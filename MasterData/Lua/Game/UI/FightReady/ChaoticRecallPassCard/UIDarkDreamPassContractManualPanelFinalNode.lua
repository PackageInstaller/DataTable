-------------------------------------------------------------------------------
-- Pass卡 - 奖励界面 - 奖励列表宝箱节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 16:59:47
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.FightReady.ChaoticRecallPassCard.ChaoticRecallPassCardUtils')

--- from: Assets/BundleResources/Prefabs/ResidentEvent/DarkDreamPassContractManual.prefab > name: Cell2
---@class UIDarkDreamPassContractManualPanelFinalNode                    
---@field Env                           	UIDarkDreamPassContractManualPanelFinalNode
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RedPoint                      	UnityEngine.RectTransform               	@ 0    红点节点
---@field DrawUIFX                      	UnityEngine.RectTransform               	@ 1    领取特效
---@field CheckIcon                     	UnityEngine.RectTransform               	@ 2    查看图标
---@field DrwaBtn                       	UnityEngine.RectTransform               	@ 3    领取按钮
---@field IconBtn                       	UnityEngine.RectTransform               	@ 4    图标按钮
---@field TimesTxt                      	UnityEngine.RectTransform               	@ 5    次数文本
---@field DescrTxt                      	UnityEngine.RectTransform               	@ 6    描述文本
---@field TitleTxt                      	UnityEngine.RectTransform               	@ 7    标题文本
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 8    
local UIDarkDreamPassContractManualPanelFinalNode = Class('UIDarkDreamPassContractManualPanelFinalNode')


function UIDarkDreamPassContractManualPanelFinalNode:__init()
end


function UIDarkDreamPassContractManualPanelFinalNode:__delete()
end


function UIDarkDreamPassContractManualPanelFinalNode:Awake()
end


function UIDarkDreamPassContractManualPanelFinalNode:AddListener()
    if self.eventsDecorated_ then return end
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [PassCardUtils.EventName.PASS_CARD_LOOP_TIMES] = Bind(self, self.OnPassLoopTimesEventHandler_),
    })
end


function UIDarkDreamPassContractManualPanelFinalNode:Start()
    SetButtonAction(self.IconBtn, Bind(self, self.OnClickRewardsTipsIconHandler_))
    SetButtonAction(self.DrwaBtn, Bind(self, self.OnClickDrawRewardsButtonHandler_))
end


function UIDarkDreamPassContractManualPanelFinalNode:OnDestroy()
    CfUtils.EventsUndecorated(self.eventsDecorated_)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return ContractRecallPassCardHomeDojo
function UIDarkDreamPassContractManualPanelFinalNode:GetHomeDojo()
    return self.homeDojo_
end
---@param luaIndex ContractRecallPassCardHomeDojo
function UIDarkDreamPassContractManualPanelFinalNode:SetHomeDojo(homeDojo)
    self.homeDojo_ = homeDojo
end


---@return integer
function UIDarkDreamPassContractManualPanelFinalNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIDarkDreamPassContractManualPanelFinalNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UIDarkDreamPassContractManualPanelFinalNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function UIDarkDreamPassContractManualPanelFinalNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
    self:AddListener()
end


---@return fun(luaIndex:integer):void
function UIDarkDreamPassContractManualPanelFinalNode:GetClickDrawCB()
    return self.clickDrawCallback_
end
---@param callback fun(luaIndex:integer):void
function UIDarkDreamPassContractManualPanelFinalNode:SetClickDrawCB(callback)
    self.clickDrawCallback_ = callback
end


-------------------------------------------------
-- private

function UIDarkDreamPassContractManualPanelFinalNode:UpdateCellInfo_()
    local cellData = self:GetCellData()

    -- update descr
    local loopChestDescr = PassCardUtils.GetParamDescr(PassCardUtils.ParamsId.LOOP_CHEST_DESCR)
    CfUtils.FillText(self.DescrTxt, string.fmt(loopChestDescr, {_target_num_ = PassCardUtils.GetLoopChestEachExp()}))

    -- update times
    local canDrawCount = self:GetHomeDojo().canDrawCircleTimes
    CfUtils.FillText(self.TimesTxt, localize('<size=50>x</size>_num_', {_num_ = canDrawCount}))

    -- update state
    CfUtils.SetActive(self.RedPoint, canDrawCount > 0)
    CfUtils.SetActive(self.DrawUIFX, canDrawCount > 0)
end


-------------------------------------------------
-- handler

function UIDarkDreamPassContractManualPanelFinalNode:OnPassLoopTimesEventHandler_()
    self:UpdateCellInfo_()
end


function UIDarkDreamPassContractManualPanelFinalNode:OnClickRewardsTipsIconHandler_()
    local rewardsData = {
        {goodsId = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.LOOP_CHEST_ID), num = 1}
    }
    GameUtils.ShowCommonTipsBattlePass(self.CheckIcon, rewardsData)
end


function UIDarkDreamPassContractManualPanelFinalNode:OnClickDrawRewardsButtonHandler_()
    if self:GetClickDrawCB() then
        self:GetClickDrawCB()(self:GetLuaIndex())
    end
end


return UIDarkDreamPassContractManualPanelFinalNode
