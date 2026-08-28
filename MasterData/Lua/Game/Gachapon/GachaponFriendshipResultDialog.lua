-------------------------------------------------------------------------------
-- 海外抽卡 - 友情卡池结果界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-04-22 17:59:48
-------------------------------------------------------------------------------

local ResultCellPath = 'Game.Gachapon.GachaponFriendshipResultCell'

local RootAnimName = {
    IDLE  = 'GachaponFriendshipResultDialog_Idle',
    ENTER = 'GachaponFriendshipResultDialog_Entry',
}

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/Gachapon/GachaponFriendshipResultDialog.prefab > name: GachaponFriendshipResultDialog
---@class GachaponFriendshipResultDialog
---@field Env                           	GachaponFriendshipResultDialog          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field ClickClose                    	UnityEngine.RectTransform               	@ 1    空白关闭区
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 2    动画根节点
---@field OneResultRoot                 	UnityEngine.RectTransform               	@ 3    单抽结果根节点
---@field TenResultRoot                 	UnityEngine.RectTransform               	@ 4    十抽结果根节点
local GachaponFriendshipResultDialog = Class('GachaponFriendshipResultDialog')


function GachaponFriendshipResultDialog:__init()
    ---@type UnityEngine.Coroutine @ 等待入场动画协程
    self.waitEntryAnimCo_ = nil

    ---@type GachaponFriendshipResultCell[] @ 结果节点列表
    self.resultCellList_ = {}

    ---@type fun():void @ 重新打开回调
    self.needReopenCb_ = nil
end


function GachaponFriendshipResultDialog:__delete()
    self.waitEntryAnimCo_ = nil
    self.resultCellList_  = nil
    self.needReopenCb_    = nil
end


function GachaponFriendshipResultDialog:Awake()
    SetButtonAction(self.ClickClose, Bind(self, self.OnClickEmptyCloseAreaHandler_))
end


function GachaponFriendshipResultDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams   = CfUtils.DialogSafeParameters(self.controller)
        self.needReopenCb_ = initParams.needReopenCb
        self:SetCallResult(initParams.result)
    end)
end


function GachaponFriendshipResultDialog:OnFinalize()
    return CoWaitDo(function()
        if self.waitEntryAnimCo_ then
            CoStop(self.waitEntryAnimCo_)
            self.waitEntryAnimCo_ = nil
        end
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function GachaponFriendshipResultDialog:OnShow()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)
        if initParams.isReopenMode then
            CfUtils.PlayAnimation(self.AnimRoot, RootAnimName.IDLE)
        else
            CfUtils.PlayAnimation(self.AnimRoot, RootAnimName.ENTER)
            local entryAnimTime   = CfUtils.GetAnimationTime(self.AnimRoot, RootAnimName.ENTER)
            self.waitEntryAnimCo_ = CoStart(function()
                CoYield(entryAnimTime)
                self.waitEntryAnimCo_ = nil
            end)
        end
    end)
end


-------------------------------------------------
-- get / set

---@return table[]
function GachaponFriendshipResultDialog:GetCallResult()
    return checkTable(self.callResult_)
end
function GachaponFriendshipResultDialog:SetCallResult(result)
    self.callResult_ = checkTable(result)
    self:UpdateCallResult_()
end


-------------------------------------------------
-- public

function GachaponFriendshipResultDialog:Close()
    if self.closeCallback_ then
        self.closeCallback_()
    end
    CfUtils.DialogClose(self.controller)
end


-------------------------------------------------
-- private

function GachaponFriendshipResultDialog:UpdateCallResult_()
    local resultNodeList = {}
    self.resultCellList_ = {}

    if #self:GetCallResult() > 1 then
        CfUtils.SetActive(self.OneResultRoot, false)
        CfUtils.SetActive(self.TenResultRoot, true)
        for itemIndex = 1, 10 do
            resultNodeList[itemIndex] = self.TenResultRoot:Find('Root/GachaponFriendshipTreasureboxNode'.. itemIndex)
        end
    else
        CfUtils.SetActive(self.OneResultRoot, true)
        CfUtils.SetActive(self.TenResultRoot, false)
        resultNodeList[1] = self.OneResultRoot:Find('Root/GachaponFriendshipTreasureboxNode')
    end

    for resultIndex, resultNode in ipairs(resultNodeList) do
        self.resultCellList_[resultIndex] = CfUtils.GetLuaScr(resultNode, ResultCellPath)
        self.resultCellList_[resultIndex]:SetResultIndex(resultIndex)
        self.resultCellList_[resultIndex]:SetResultData(self:GetCallResult()[resultIndex])
        self.resultCellList_[resultIndex]:SetClickCardHeadCb(Bind(self, self.OnClickResultCellCardHeadHandler_))
    end
end


-------------------------------------------------
-- handler

function GachaponFriendshipResultDialog:OnClickEmptyCloseAreaHandler_()
    if self.waitEntryAnimCo_ then return end
    self:Close()
end


function GachaponFriendshipResultDialog:OnClickResultCellCardHeadHandler_(luaIndex)
    if self.waitEntryAnimCo_ then return end
    local GachaponUtils = import('Game.Gachapon.GachaponUtils')
    local resultData    = checkTable(self:GetCallResult()[luaIndex])
    local resultGoodsId = checkInt(resultData.goodsId)
    if self.needReopenCb_ then
        self.needReopenCb_()
    end
    CoStart(function()
        CoYield(CfUtils.DialogClose(self.controller))
        CoYield(GachaponUtils.OpenDetail(resultGoodsId, CfUtils.DialogGetAllArgs()))
    end)
end


return GachaponFriendshipResultDialog
