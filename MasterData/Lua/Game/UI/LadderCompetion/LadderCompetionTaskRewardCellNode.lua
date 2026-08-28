-------------------------------------------------------------------------------
-- 天梯竞技 - 任务界面 - 列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-08-11 11:00:00
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/LadderCompetion/LadderCompetionTaskRewardDialog.prefab > name: Cell
---@class LadderCompetionTaskRewardCellNode
---@field Env                           	LadderCompetionTaskRewardCellNode       
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field FinishGroup                   	UnityEngine.RectTransform               
---@field BtnDrawReward                 	UnityEngine.RectTransform               
---@field TxtUnfinished                 	UnityEngine.RectTransform               
---@field ImgCanFrame2                  	UnityEngine.RectTransform               
---@field ImgCanFrame1                  	UnityEngine.RectTransform               
---@field ImgProgress                   	UnityEngine.RectTransform               
---@field ProgressBar                   	UnityEngine.RectTransform               
---@field TextProgress                  	UnityEngine.RectTransform               
---@field TextDescribe                  	UnityEngine.RectTransform               
---@field CommonGoodsList               	UnityEngine.RectTransform               
---@field animRoot                      	UnityEngine.RectTransform               
local LadderCompetionTaskRewardCellNode = Class('LadderCompetionTaskRewardCellNode')


function LadderCompetionTaskRewardCellNode:__init()
    ---@type CommonGoodsList
    self.CommonGoodsListLua_ = nil
end


function LadderCompetionTaskRewardCellNode:__delete()
    self.CommonGoodsListLua_ = nil
end


function LadderCompetionTaskRewardCellNode:Awake()
    self.CommonGoodsListLua_ = CfUtils.GetLuaScr(self.CommonGoodsList, 'Game.Behaviours.CommonGoodsList')
    SetButtonAction(self.BtnDrawReward, Bind(self, self.OnClickFunctionButtonHandler_))
    self:PlayAnimByHide()
end


function LadderCompetionTaskRewardCellNode:Start()
end


function LadderCompetionTaskRewardCellNode:OnDestroy()
    self.controller = nil  -- luabehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

function LadderCompetionTaskRewardCellNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
function LadderCompetionTaskRewardCellNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


function LadderCompetionTaskRewardCellNode:GetCellData()
    return checkTable(self.cellData_)
end
function LadderCompetionTaskRewardCellNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:RefreshData_()
end


---@return fun(luaIndex:number):void
function LadderCompetionTaskRewardCellNode:GetClickCB()
    return self.clickCallback_
end
---@param callback fun(luaIndex:number):void
function LadderCompetionTaskRewardCellNode:SetClickCB(callback)
    self.clickCallback_ = callback
end


-------------------------------------------------
-- public

function LadderCompetionTaskRewardCellNode:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Hide')
end


function LadderCompetionTaskRewardCellNode:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Idle')
end


function LadderCompetionTaskRewardCellNode:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, 'UI_Common_List_Cell_Show')
end


-------------------------------------------------
-- private

function LadderCompetionTaskRewardCellNode:RefreshData_()
    local cellData = self:GetCellData()
    local taskData = checkTable(cellData.taskData)
    local statusId = checkInt(taskData.status)
    local isUndone = statusId == Constants.GetStatus.Not
    local isCanGet = statusId == Constants.GetStatus.Can
    local isHasGot = statusId == Constants.GetStatus.Has
    local taskVo   = checkTable(cellData.taskVo)

    -- update status
    CfUtils.SetActive(self.TxtUnfinished, isUndone)
    CfUtils.SetActive(self.BtnDrawReward, isCanGet)
    CfUtils.SetActive(self.FinishGroup, isHasGot)

    -- update descr
    CfUtils.FillText(self.TextDescribe, taskVo.desc)
    
    ---- update rewards
    -- local prizeIds = string.split(taskVo.rewardId, ";")
    -- local prizeNums = string.split(taskVo.rewardNum,";")
    -- local count = math.min(#prizeIds, #prizeNums)
    -- local data = {}
    -- for i = 1, count do
    --    data[i] = {}
    --    data[i].id = prizeIds[i]
    --    data[i].num = prizeNums[i]
    -- end
    if not isNull(self.CommonGoodsListLua_) then
        self.CommonGoodsListLua_:FreshBaseUI(checkTable(taskVo.rewards))
    end
    
    -- update progress text
    local progressAll = checkInt(taskVo.taskContenNum)
    local progressNum = checkInt(taskData.progress)
    local textFormat  = '(<size=30><color=#545454>_curNum_</size></color>/_allNum_)'
    CfUtils.FillText(self.TextProgress, string.fmt(textFormat, {_curNum_ = progressNum, _allNum_ = progressAll}))

    -- update canFrame
    local isShowCan = not isHasGot and progressNum >= progressAll
    CfUtils.SetUISwitchImage(self.ImgCanFrame1, isShowCan and 2 or 1)
    CfUtils.SetUISwitchImage(self.ImgCanFrame2, isShowCan and 2 or 1)

    -- update progressBar
    CfUtils.SetUISwitchImage(self.ImgProgress, isShowCan and 2 or 1)
    CfUtils.SetSliderPercent(self.ProgressBar, progressNum / progressAll)
end


-------------------------------------------------
-- handler

function LadderCompetionTaskRewardCellNode:OnClickFunctionButtonHandler_()
    if self:GetClickCB() then
        self:GetClickCB()(self:GetLuaIndex())
    end
end


return LadderCompetionTaskRewardCellNode
