-------------------------------------------------------------------------------
-- 任务界面 - 日常面板 - 任务列表节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-02-20 03:56:33
-------------------------------------------------------------------------------

local DOTween = CS.DG.Tweening

local REWARDS_ANIM_TIME = 0.5  -- 奖励动画时间

--- from: Assets/BundleResources/Prefabs/OverseaTasks/DailyTaskCellNode.prefab > name: DailyTaskCellNode
---@class UITaskDailyTaskCell
---@field Env                           	UITaskDailyTaskCell                     
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BoomMoveUIFX                  	UnityEngine.RectTransform               @ 活跃点拖尾特效
---@field ImgIcon                       	UnityEngine.RectTransform               @ 任务图标节点
---@field RootNode                      	UnityEngine.RectTransform               @ 根位置节点
---@field Particle                      	UnityEngine.RectTransform               @ 完成状态粒子节点
---@field ImgDecorate2                  	UnityEngine.RectTransform               @ 装饰状态节点2
---@field ImgDecorate                   	UnityEngine.RectTransform               @ 装饰状态节点1
---@field AnimRoot                      	UnityEngine.RectTransform               @ 动画根节点
---@field Fill                          	UnityEngine.RectTransform               @ 任务进度条图片
---@field HasDrawnNode                  	UnityEngine.RectTransform               @ 已领取状态节点
---@field LockButton                    	UnityEngine.RectTransform               @ 锁定中按钮
---@field LockNode                      	UnityEngine.RectTransform               @ 锁定中状态节点
---@field BtnReceive                    	UnityEngine.RectTransform               @ 领取按钮
---@field FontStyleButton               	UnityEngine.RectTransform               @ 前往按钮
---@field ProgressNode                  	UnityEngine.RectTransform               @ 进行中状态节点
---@field PointTxt                      	UnityEngine.RectTransform               @ 活跃点文本
---@field Slider                        	UnityEngine.UI.Slider                   @ 任务进度条
---@field TitleTxt                      	UnityEngine.RectTransform               @ 任务进度文本
---@field SliderParent                  	UnityEngine.RectTransform               @ 进度跟节点
---@field NameTxt                       	UnityEngine.RectTransform               @ 任务描述文本
local UITaskDailyTaskCell = Class('UITaskDailyTaskCell')


function UITaskDailyTaskCell:__init()
    ---@type UnityEngine.Vector2
    self.initBoomMoveUIFXPos_ = nil
    ---@type UnityEngine.Coroutine
    self.playRewardsAnimCo_ = nil
end


function UITaskDailyTaskCell:__delete()
    self.initBoomMoveUIFXPos_ = nil
    self.playRewardsAnimCo_   = nil
end


function UITaskDailyTaskCell:Awake()
    self.initBoomMoveUIFXPos_ = Vector2.New(
        self.BoomMoveUIFX.transform:GetLocalPositionX(), 
        self.BoomMoveUIFX.transform:GetLocalPositionY()
    )
end


function UITaskDailyTaskCell:Start()
    SetButtonAction(self.LockButton, Bind(self, self.OnClickLockButtonHandler_))
    SetButtonAction(self.BtnReceive, Bind(self, self.OnClickReceiveButtonHandler_))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickJumpToButtonHandler_))

    self.isInitComplete_ = true
    self:UpdateAnimRoot_()
    if self.initCompleteCallback_ then
        self.initCompleteCallback_()
    end
end


function UITaskDailyTaskCell:OnDestroy()
    self:StopRewardsAnim()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UITaskDailyTaskCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UITaskDailyTaskCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UITaskDailyTaskCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
---@param callback fun(cb:fun():void):void
function UITaskDailyTaskCell:SetCellData(cellData, callback)
    self.cellData_ = checkTable(cellData)
    self.initCompleteCallback_ = callback
    self:RefreshData_()
end


---@return fun(luaIndex:number):void
function UITaskDailyTaskCell:GetClickReceiveCB()
    return self.clickReceiveCallback_
end
---@param callback fun(luaIndex:number):void
function UITaskDailyTaskCell:SetClickReceiveCB(callback)
    self.clickReceiveCallback_ = callback
end


---@return fun(luaIndex:number):void
function UITaskDailyTaskCell:GetClickJumpToCB()
    return self.clickJumpToCallback_
end
---@param callback fun(luaIndex:number):void
function UITaskDailyTaskCell:SetClickJumpToCB(callback)
    self.clickJumpToCallback_ = callback
end


-------------------------------------------------
-- public

function UITaskDailyTaskCell:PlayCompleteAnim()
    CfUtils.PlayAnimation(self.RootNode, "OverseaTasksDialogCellCompleteGo_Active")
end


function UITaskDailyTaskCell:ResetCompleteAnim()
    -- self.BtnReceive:Find("AnimRoot").localScale = Vector3(1, 1, 1)
    -- CfUtils.SetCanvasGroupAlpha(self.BtnReceive:Find("AnimRoot"), 1)
    CfUtils.PlayAnimation(self.RootNode, "OverseaTasksDialogCellCompleteGo_Idle")
end


---@param targetNode UnityEngine.GameObject
---@param finishCb fun():void
function UITaskDailyTaskCell:PlayRewardsAnim(targetNode, finishCb)
    self:StopRewardsAnim()

    self.playRewardsAnimCo_ = CoStart(function()
        CfUtils.SetActive(self.BoomMoveUIFX, true)
    
        if self.initBoomMoveUIFXPos_ then
            local targetPosition = targetNode.transform.position
            self.BoomMoveUIFX.transform.localPosition = self.initBoomMoveUIFXPos_
            self.BoomMoveUIFX.transform:DOMove(targetPosition, REWARDS_ANIM_TIME):SetEase(DOTween.Ease.InOutQuad)
            CoYield(REWARDS_ANIM_TIME)
        end

        CfUtils.SetActive(self.BoomMoveUIFX, false)
        
        if finishCb then
            finishCb()
        end

        self.playRewardsAnimCo_ = nil
    end)
end


function UITaskDailyTaskCell:StopRewardsAnim()
    if self.playRewardsAnimCo_ then
        CoStop(self.playRewardsAnimCo_)
        self.playRewardsAnimCo_ = nil
    end
end


-------------------------------------------------
-- private

function UITaskDailyTaskCell:RefreshData_()
    local cellData = self:GetCellData()

    ---@type DailyTaskVo
    local taskVo     = checkTable(cellData.taskVo)
    local taskData   = checkTable(cellData.taskData)
    local isJumpTo   = checkInt(taskVo.openType) > 0
    local isLocked   = cellData.isLocked == true
    local isDrawn    = cellData.isDrawn == true
    local isCanDraw  = cellData.isCanDraw == true
    local isWorking  = cellData.isWorking == true
    local targetNum  = checkInt(taskVo.taskContent)
    local currentNum = math.max(isDrawn and targetNum or 0, checkInt(taskData.progress))

    -- update infos
    CfUtils.FillImage(self.ImgIcon, taskVo.taskIcon)
    CfUtils.FillText(self.NameTxt, tostring(taskVo.taskTitle))
    CfUtils.FillText(self.PointTxt, string.fmt('+%1', checkInt(taskVo.point)))
    CfUtils.FillText(self.TitleTxt, string.format("<size=30><color=#545454>%d</color></size>/%d", currentNum, targetNum))
    CfUtils.SetSliderPercent(self.Slider, currentNum / targetNum)
    
    -- update status
    CfUtils.SetActive(self.Particle, false)
    CfUtils.SetActive(self.LockNode, isLocked)
    CfUtils.SetActive(self.SliderParent, not isLocked)
    if isLocked then
        CfUtils.SetActive(self.BtnReceive, false)
        CfUtils.SetActive(self.HasDrawnNode, false)
        CfUtils.SetActive(self.ProgressNode, false)
        CfUtils.SetActive(self.FontStyleButton, false)
    else
        CfUtils.SetActive(self.BtnReceive, isCanDraw)
        CfUtils.SetActive(self.HasDrawnNode, isDrawn)
        CfUtils.SetActive(self.ProgressNode, isWorking and not isJumpTo)
        CfUtils.SetActive(self.FontStyleButton, isWorking and isJumpTo)
    end

    self:StopRewardsAnim()
    if self.isInitComplete_ then
        self:UpdateAnimRoot_()
        if self.initCompleteCallback_ then
            self.initCompleteCallback_()
        end
    end
end


function UITaskDailyTaskCell:UpdateAnimRoot_()
    local cellData  = self:GetCellData()
    local isCanDraw = cellData.isCanDraw == true
    CfUtils.PlayAnimation(self.AnimRoot, isCanDraw and "OverseaTasksDialogCellCompleteGo" or "OverseaTasksDialogCellGo")
end


-------------------------------------------------
-- handler

function UITaskDailyTaskCell:OnClickReceiveButtonHandler_()
    if self:GetClickReceiveCB() then
        self:GetClickReceiveCB()(self:GetLuaIndex())
    end
end


function UITaskDailyTaskCell:OnClickJumpToButtonHandler_()
    if self:GetClickJumpToCB() then
        self:GetClickJumpToCB()(self:GetLuaIndex())
    end
end


function UITaskDailyTaskCell:OnClickLockButtonHandler_()
    local cellData = self:GetCellData()
    ---@type DailyTaskVo
    local taskVo = checkTable(cellData.taskVo)
    if taskVo.unlockId > 0 then
        local prevTaskId = checkInt(taskVo.before)
        local unlockText = GameUtils.GetUnlockDescr(taskVo.unlockId, taskVo.unlockValue)
        if prevTaskId > 0 then
            unlockText = localize('_unlock_后，下次每日任务刷新时开启', {_unlock_ = unlockText})
        end
        GameUtils.Toast(unlockText)
    end
end


return UITaskDailyTaskCell
