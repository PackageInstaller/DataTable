-------------------------------------------------------------------------------
-- 夜寻迷宫 - 主地图任务 - 任务节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-28 21:08:22
-------------------------------------------------------------------------------

local PatrolMazeUtils = import('Game.UI.PatrolMaze.PatrolMazeUtils')

--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinTaskDialog.prefab > name: Cell
---@class PatrolMazePrimaryTaskCell
---@field Env                           	PatrolMazePrimaryTaskCell               
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field AnimRoot                      	UnityEngine.RectTransform               	@ 1    动画根节点
---@field ImgFrame1                     	UnityEngine.RectTransform               	@ 2    装饰状态节点1
---@field ImgFrame2                     	UnityEngine.RectTransform               	@ 3    装饰状态节点2
---@field DescrTxt                      	UnityEngine.RectTransform               	@ 4    描述文本
---@field ProgressTxt                   	UnityEngine.RectTransform               	@ 5    进度文本
---@field ProgressBar                   	UnityEngine.RectTransform               	@ 6    进度条
---@field ProgressImg                   	UnityEngine.RectTransform               	@ 7    进度图片
---@field GoodsListLight                	UnityEngine.RectTransform               	@ 8    道具列表节点
---@field DrawUIFX                      	UnityEngine.RectTransform               	@ 9    领取特效
---@field DrawBtn                       	UnityEngine.RectTransform               	@ 10   领取按钮
---@field FinishNode                    	UnityEngine.RectTransform               	@ 11   完成节点
---@field UnderwayNode                  	UnityEngine.RectTransform               	@ 12   进行中节点
local PatrolMazePrimaryTaskCell = Class('PatrolMazePrimaryTaskCell')


function PatrolMazePrimaryTaskCell:__init()
    ---@type CommonGoodsListLight @ 敌人奖励列表
    self.taskRewardsList_ = nil
end


function PatrolMazePrimaryTaskCell:__delete()
    self.taskRewardsList_ = nil
end


function PatrolMazePrimaryTaskCell:Awake()
    self.taskRewardsList_ = CfUtils.GetLuaScr(self.GoodsListLight, Constants.UILuaTablePath.ComGoodsList2)
end


function PatrolMazePrimaryTaskCell:Start()
    SetButtonAction(self.DrawBtn, Bind(self, self.OnClickDrawButtonHandler_))
    if self:GetOnInitCB() then
        self:GetOnInitCB()()
    end
end


function PatrolMazePrimaryTaskCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function PatrolMazePrimaryTaskCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function PatrolMazePrimaryTaskCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return PatrolMazeTaskDojo
function PatrolMazePrimaryTaskCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function PatrolMazePrimaryTaskCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:RefreshData_()
end


---@return fun(luaIndex:number):void
function PatrolMazePrimaryTaskCell:GetClickDrawCB()
    return self.clickReceiveCallback_
end
---@param callback fun(luaIndex:number):void
function PatrolMazePrimaryTaskCell:SetClickDrawCB(callback)
    self.clickReceiveCallback_ = callback
end


---@return fun():void
function PatrolMazePrimaryTaskCell:GetOnInitCB()
    return self.onInitCallback_
end
---@param callback fun():void
function PatrolMazePrimaryTaskCell:SetOnInitCB(callback)
    self.onInitCallback_ = callback
end


-------------------------------------------------
-- public

function PatrolMazePrimaryTaskCell:PlayAnimByHide()
    CfUtils.PlayAnimator(self.AnimRoot, 'Wait')
end


function PatrolMazePrimaryTaskCell:PlayAnimByIdle()
    CfUtils.PlayAnimator(self.AnimRoot, 'Default')
end


function PatrolMazePrimaryTaskCell:PlayDelayAnimByShow(delayIndex)
    CfUtils.PlayDelayShowAnimate(self.AnimRoot, delayIndex, 0.1, 0.1, 'Go')
end


function PatrolMazePrimaryTaskCell:UpdateDrawStatus()
    local cellData = self:GetCellData()
    local isUndone = cellData:IsDoing()
    local isCanGet = cellData:CanDraw()
    local isHasGot = cellData:IsDrawn()

    CfUtils.SetActive(self.DrawBtn, isCanGet)
    CfUtils.SetActive(self.DrawUIFX, isCanGet)
    CfUtils.SetActive(self.FinishNode, isHasGot)
    CfUtils.SetActive(self.UnderwayNode, isUndone)

    local isShowCan = isCanGet
    CfUtils.SetUISwitchImage(self.ImgFrame1, isShowCan and 2 or 1)
    CfUtils.SetUISwitchImage(self.ImgFrame2, isShowCan and 2 or 1)
    CfUtils.SetUISwitchImage(self.ProgressImg, isShowCan and 2 or 1)
end


-------------------------------------------------
-- private

function PatrolMazePrimaryTaskCell:RefreshData_()
    local cellData = self:GetCellData()
    local isUndone = cellData:IsDoing()
    local isCanGet = cellData:CanDraw()
    local isHasGot = cellData:IsDrawn()

    -- update descr
    local areaTaskVo = PatrolMazeUtils.GetAreaTaskVo(cellData.taskId)
    CfUtils.FillText(self.DescrTxt, areaTaskVo.taskDescr)

    -- update rewards
    self.taskRewardsList_:FreshBaseUI(areaTaskVo.rewardsData)

    -- update progress
    local progressNum = checkInt(cellData.progress)
    local progressAll = checkInt(areaTaskVo.targetNum)
    local textFormat  = '(<size=30><color=#545454>_curNum_</size></color>/_allNum_)'
    CfUtils.FillText(self.ProgressTxt, string.fmt(textFormat, {_curNum_ = progressNum, _allNum_ = progressAll}))
    CfUtils.SetSliderPercent(self.ProgressBar, progressNum / progressAll)

    -- update state
    self:UpdateDrawStatus()
end


-------------------------------------------------
-- handler

function PatrolMazePrimaryTaskCell:OnClickDrawButtonHandler_()
    if self:GetClickDrawCB() then
        self:GetClickDrawCB()(self:GetLuaIndex())
    end
end


return PatrolMazePrimaryTaskCell
