-------------------------------------------------------------------------------
-- 任务界面 - 日常面板 - 任务宝箱节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-10-11 21:17:30
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaTasksDailyTaskBoxNode.prefab > name: OverseaTasksDailyTaskBoxNode
---@class UITaskDailyTaskBoxCell
---@field Env                           	UITaskDailyTaskBoxCell                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field AnimNode                      	UnityEngine.RectTransform               @ 动画节点
---@field TipsNode                      	UnityEngine.RectTransform               @ 提示节点
---@field DrawedImg                     	UnityEngine.RectTransform               @ 已领取状态图片
---@field PointNumTxt                   	UnityEngine.RectTransform               @ 目标点数文本
---@field ImgIconUnGet                  	UnityEngine.RectTransform               @ 未获得图标
---@field ImgIconGet                    	UnityEngine.RectTransform               @ 已获得图标
---@field BtnIocn                       	UnityEngine.RectTransform               @ 点击按钮
---@field SelectedImg                   	UnityEngine.RectTransform               @ 选中状态图片
local UITaskDailyTaskBoxCell = Class('UITaskDailyTaskBoxCell')


function UITaskDailyTaskBoxCell:__init()
end


function UITaskDailyTaskBoxCell:__delete()
end


function UITaskDailyTaskBoxCell:Awake()
end


function UITaskDailyTaskBoxCell:Start()
    SetButtonAction(self.BtnIocn, Bind(self, self.OnClickCellButtonHandler_))
end


function UITaskDailyTaskBoxCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UITaskDailyTaskBoxCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UITaskDailyTaskBoxCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function UITaskDailyTaskBoxCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function UITaskDailyTaskBoxCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:RefreshData_()
end


---@return fun(luaIndex:number, tipsNode:UnityEngine.RectTransform):void
function UITaskDailyTaskBoxCell:GetClickCellCB()
    return self.clickCellCallback_
end
---@param callback fun(luaIndex:number, tipsNode:UnityEngine.RectTransform):void
function UITaskDailyTaskBoxCell:SetClickCellCB(callback)
    self.clickCellCallback_ = callback
end


-------------------------------------------------
-- public

function UITaskDailyTaskBoxCell:PlayCanDrawAnim()
    CfUtils.PlayAnimation(self.AnimNode, "OverseaTasksDailyTasksPanel_RewardNodeGlowLoop")
end


function UITaskDailyTaskBoxCell:PlayIdleAnim()
    CfUtils.PlayAnimation(self.AnimNode, "OverseaTasksDailyTasksPanel_RewardNodeGlowIdle")
end


-------------------------------------------------
-- private

function UITaskDailyTaskBoxCell:RefreshData_()
    local cellData = self:GetCellData()

    local boxId  = checkInt(cellData.taskBoxData.boxId)
    local status = checkInt(cellData.taskBoxData.status)
    local isCan  = status == Constants.GetStatus.Can
    local isGot  = status == Constants.GetStatus.Has
    local isNot  = status == Constants.GetStatus.Not

    CfUtils.SetActive(self.DrawedImg, isGot)
    CfUtils.SetActive(self.SelectedImg, isCan)
    CfUtils.SetActive(self.ImgIconGet, isGot)
    CfUtils.SetActive(self.ImgIconUnGet, not isGot)

    ---@type TaskRewardBoxVo
    local boxVo = cellData.taskBoxData.boxVo
    CfUtils.FillText(self.PointNumTxt, boxVo.unlockPoint)
    CfUtils.SetUISwitchText(self.PointNumTxt, isNot and 1 or 2)

    if isCan then
        self:PlayCanDrawAnim()
    else
        self:PlayIdleAnim()
    end
end


-------------------------------------------------
-- handler

function UITaskDailyTaskBoxCell:OnClickCellButtonHandler_()
    if self:GetClickCellCB() then
        self:GetClickCellCB()(self:GetLuaIndex(), self.TipsNode)
    end
end


return UITaskDailyTaskBoxCell
