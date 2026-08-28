-------------------------------------------------------------------------------
-- Pass卡 - 任务界面 - 任务列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-11-30 16:59:47
-------------------------------------------------------------------------------

local PassCardUtils = import('Game.UI.PassCard.PassCardUtils')
local passCardComp  = PassCardUtils.GetComp()

--- from: Assets/BundleResources/Prefabs/BattlePass/BattlePassTaskPopup.prefab > name: Cell
---@class UIBattlePassTaskPopupNode
---@field Env                           	UIBattlePassTaskPopupNode               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field MaskLight                     	UnityEngine.RectTransform               @ 
---@field LockedIcon                    	UnityEngine.RectTransform               @ 锁定图标
---@field FinishIcon                    	UnityEngine.RectTransform               @ 完成图标
---@field FinishAndLock                 	UnityEngine.RectTransform               @ 已完成节点
---@field Underway                      	UnityEngine.RectTransform               @ 进行中节点
---@field BtnDraw                       	Game.Native.Common.FontStyleButton      @ 领取按钮
---@field UIFX_CanDraw                  	UnityEngine.RectTransform               @ 可领取特效
---@field BtnRefreshAnim                	UnityEngine.RectTransform               @ 刷新按钮动画节点
---@field BtnRefresh                    	UnityEngine.RectTransform               @ 刷新按钮
---@field ProgressTxt                   	UnityEngine.RectTransform               @ 任务进度文本
---@field ProgressImg                   	UnityEngine.RectTransform               @ 任务进度条图
---@field ProgressBar                   	UnityEngine.RectTransform               @ 任务进度条
---@field ProgressGroup                 	UnityEngine.RectTransform               @ 进度信息节点
---@field TextDescribe                  	UnityEngine.RectTransform               @ 任务描述文本
---@field ImgDecorate                   	UnityEngine.RectTransform               @ 左侧装饰节点
---@field ImgElite                      	UnityEngine.RectTransform               @ 精英图标
---@field CommonGoodsList               	UnityEngine.RectTransform               @ 道具列表
---@field AnimRoot                      	UnityEngine.RectTransform               @ 动画根节点
local UIBattlePassTaskPopupNode = Class('UIBattlePassTaskPopupNode')


function UIBattlePassTaskPopupNode:__init()
    ---@type CommonGoodsListLight
    self.taskRewardsList_ = nil
end


function UIBattlePassTaskPopupNode:__delete()
    self.taskRewardsList_ = nil
end


function UIBattlePassTaskPopupNode:Awake()
    self.taskRewardsList_ = CfUtils.GetLuaScr(self.CommonGoodsList, Constants.UILuaTablePath.ComGoodsList2)
    self:PlayAnimByHide()
end


function UIBattlePassTaskPopupNode:Start()
    SetButtonAction(self.BtnDraw, Bind(self, self.OnClickDrawButtonHandler_))
    SetButtonAction(self.BtnRefresh, Bind(self, self.OnClickRefreshButtonHandler_))
end


function UIBattlePassTaskPopupNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIBattlePassTaskPopupNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIBattlePassTaskPopupNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UIBattlePassTaskPopupNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function UIBattlePassTaskPopupNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function UIBattlePassTaskPopupNode:GetClickDrawCB()
    return self.clickDrawCallback_
end
---@param callback fun(luaIndex:integer):void
function UIBattlePassTaskPopupNode:SetClickDrawCB(callback)
    self.clickDrawCallback_ = callback
end


---@return fun(luaIndex:integer):void
function UIBattlePassTaskPopupNode:GetClickRefreshCB()
    return self.clickRefreshCallback_
end
---@param callback fun(luaIndex:integer):void
function UIBattlePassTaskPopupNode:SetClickRefreshCB(callback)
    self.clickRefreshCallback_ = callback
end


-------------------------------------------------
-- public

function UIBattlePassTaskPopupNode:PlayAnimByHide()
    CfUtils.PlayAnimation(self.AnimRoot, 'UI_Common_List_Cell_Hide')
    CfUtils.StopAnimation(self.BtnRefreshAnim)
end


function UIBattlePassTaskPopupNode:PlayAnimByIdle()
    CfUtils.PlayAnimation(self.AnimRoot, 'UI_Common_List_Cell_Idle')
    CfUtils.StopAnimation(self.BtnRefreshAnim)
end


function UIBattlePassTaskPopupNode:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimation(self.AnimRoot, delayIndex)
    CfUtils.PlayDelayShowAnimation(self.BtnRefreshAnim, delayIndex, 'BattlePassTaskPopup_Btnfresh')
end


-------------------------------------------------
-- private

function UIBattlePassTaskPopupNode:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type PassCardUtils.TaskType
    local taskType = checkInt(cellData.taskType)
    ---@type PassCardTaskInfoDojo
    local taskDojo = checkTable(cellData.taskDojo)
    ---@type PassCardDailyTaskVo | PassCardEliteTaskVo
    local taskVo   = checkTable(cellData.taskVo)
    ---@type boolean
    local isUnlock = checkBool(cellData.isUnlock)
    
    -- update task icon
    local isDailyTask = taskType == PassCardUtils.TaskType.Daily
    local isEliteTask = taskType == PassCardUtils.TaskType.Elite
    CfUtils.SetActive(self.ImgElite, isEliteTask)

    -- update task descr
    CfUtils.FillText(self.TextDescribe, tostring(taskVo.taskDescr))

    -- update task progress
    local targetNum  = checkInt(taskVo.taskContenNum)
    local currentNum = taskDojo:IsDoing() and taskDojo.progress or targetNum
    CfUtils.FillText(self.ProgressTxt, string.fmt('(<size=30><color=#545454>%1</size></color>/%2)', currentNum, targetNum))
    CfUtils.SetSliderPercent(self.ProgressBar, currentNum, targetNum)
    
    -- update task rewards
    local expGoodsNum = checkInt(taskVo.expPoint)
    if isDailyTask and passCardComp:IsUnlockNormalPass() then
        local dailyExpExtra = PassCardUtils.GetParamValue(PassCardUtils.ParamsId.DTASK_PARSS_EXP_EXTRA)
        expGoodsNum = math.ceil(expGoodsNum * (1 + dailyExpExtra))
    end
    self.taskRewardsList_:FreshBaseUI({
        {goodsId = passCardComp:GetPassExpGoodsId(), num = expGoodsNum},
    }, nil, nil, nil, nil, nil, false)

    -- update task state
    if isUnlock then
        CfUtils.SetUISwitchImage(self.ProgressImg, taskDojo:CanDraw() and 2 or 1)
        CfUtils.SetUISwitchImage(self.ImgDecorate, taskDojo:CanDraw() and 2 or 1)
        CfUtils.SetActive(self.ProgressGroup, true)
        CfUtils.SetActive(self.FinishAndLock, taskDojo:IsDrawn())
        CfUtils.SetActive(self.FinishIcon, true)
        CfUtils.SetActive(self.LockedIcon, false)
        CfUtils.SetActive(self.UIFX_CanDraw, taskDojo:CanDraw())
        if checkInt(taskVo.openType) > 0 then
            CfUtils.SetActive(self.Underway, false)
            CfUtils.SetActive(self.BtnDraw, not taskDojo:IsDrawn())
        else
            CfUtils.SetActive(self.Underway, taskDojo:IsDoing())
            CfUtils.SetActive(self.BtnDraw, taskDojo:CanDraw())
        end
        if taskDojo:CanDraw() then
            self.BtnDraw:ResetFontStyle('B12', localize('领取'))
        else
            self.BtnDraw:ResetFontStyle('B13', localize('前往'))
        end
    else
        CfUtils.SetUISwitchImage(self.ImgDecorate, 1)
        CfUtils.SetActive(self.ProgressGroup, false)
        CfUtils.SetActive(self.FinishAndLock, true)
        CfUtils.SetActive(self.FinishIcon, false)
        CfUtils.SetActive(self.LockedIcon, true)
        CfUtils.SetActive(self.UIFX_CanDraw, false)
        CfUtils.SetActive(self.Underway, false)
        CfUtils.SetActive(self.BtnDraw, false)
    end
end


-------------------------------------------------
-- handler

function UIBattlePassTaskPopupNode:OnClickDrawButtonHandler_()
    if self:GetClickDrawCB() then
        self:GetClickDrawCB()(self:GetLuaIndex())
    end
end


function UIBattlePassTaskPopupNode:OnClickRefreshButtonHandler_()
    if self:GetClickRefreshCB() then
        self:GetClickRefreshCB()(self:GetLuaIndex())
    end
end


return UIBattlePassTaskPopupNode
