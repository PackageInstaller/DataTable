-------------------------------------------------------------------------------
-- 天梯竞技 - 任务界面 - 列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-08-11 11:00:00
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/Activity/ActivityMonopolyTaskRewardpopup140004.prefab > name: Cell
---@class ActivityThrowDiceTaskCellNode
---@field Env                           	ActivityThrowDiceTaskCellNode           
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field FinishGroup                   	UnityEngine.RectTransform               	@ 0    
---@field BtnDrawReward                 	UnityEngine.RectTransform               	@ 1    
---@field TxtUnfinished                 	UnityEngine.RectTransform               	@ 2    
---@field ImgCanFrame2                  	UnityEngine.RectTransform               	@ 3    
---@field ImgCanFrame1                  	UnityEngine.RectTransform               	@ 4    
---@field ImgProgress                   	UnityEngine.RectTransform               	@ 5    
---@field ProgressBar                   	UnityEngine.RectTransform               	@ 6    
---@field TextProgress                  	UnityEngine.RectTransform               	@ 7    
---@field TextDescribe                  	UnityEngine.RectTransform               	@ 8    
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 9    
---@field CommonGoodsListLight          	UnityEngine.RectTransform               	@ 10   
local ActivityThrowDiceTaskCellNode = Class('ActivityThrowDiceTaskCellNode')


function ActivityThrowDiceTaskCellNode:__init()
    ---@type CommonGoodsList
    self.CommonGoodsListLua_ = nil
end


function ActivityThrowDiceTaskCellNode:__delete()
    self.CommonGoodsListLua_ = nil
end


function ActivityThrowDiceTaskCellNode:Awake()
    self.CommonGoodsListLua_ = CfUtils.GetLuaScr(self.CommonGoodsListLight, 'Game.Behaviours.CommonGoodsListLight')
    SetButtonAction(self.BtnDrawReward, Bind(self, self.OnClickFunctionButtonHandler_))
    self:PlayAnimByHide()
end


function ActivityThrowDiceTaskCellNode:Start()
end


function ActivityThrowDiceTaskCellNode:OnDestroy()
    self.controller = nil  -- luabehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

function ActivityThrowDiceTaskCellNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
function ActivityThrowDiceTaskCellNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


function ActivityThrowDiceTaskCellNode:GetCellData()
    return checkTable(self.cellData_)
end
function ActivityThrowDiceTaskCellNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:RefreshData_()
end


---@return fun(luaIndex:number):void
function ActivityThrowDiceTaskCellNode:GetClickCB()
    return self.clickCallback_
end
---@param callback fun(luaIndex:number):void
function ActivityThrowDiceTaskCellNode:SetClickCB(callback)
    self.clickCallback_ = callback
end


-------------------------------------------------
-- public

function ActivityThrowDiceTaskCellNode:PlayAnimByHide()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Hide')
end


function ActivityThrowDiceTaskCellNode:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.animRoot, 'UI_Common_List_Cell_Idle')
end


function ActivityThrowDiceTaskCellNode:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.animRoot, delayIndex, 'UI_Common_List_Cell_Show')
end


-------------------------------------------------
-- private

function ActivityThrowDiceTaskCellNode:RefreshData_()
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
    local prizeIds = string.split(taskVo.rewardId, ";")
    local prizeNums = string.split(taskVo.rewardNum,";")
    local count = math.min(#prizeIds, #prizeNums)
    local data = {}
    for i = 1, count do
       data[i] = {}
       data[i].id = prizeIds[i]
       data[i].num = prizeNums[i]
    end  
    -- update progress text
    local progressAll = checkInt(taskVo.taskContenNum)
    local progressNum = checkInt(taskData.progress)
    local textFormat  = '(<size=30><color=#545454>_curNum_</size></color>/_allNum_)'
    self.CommonGoodsListLua_:FreshBaseUI(data) 
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

function ActivityThrowDiceTaskCellNode:OnClickFunctionButtonHandler_()
    if self:GetClickCB() then
        self:GetClickCB()(self:GetLuaIndex())
    end
end


return ActivityThrowDiceTaskCellNode
