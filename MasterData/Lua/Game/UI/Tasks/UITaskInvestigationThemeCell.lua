-------------------------------------------------------------------------------
-- 任务界面 - 调查任务面板 - 卡牌
-- 
-- Author: zou hanjie <canglanxing@funtoygame.com>
-- 
-- Create: 2023-08-29 13:30:11
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaInvestigationTasksCell.prefab
---@class UITaskInvestigationThemeCell
---@field Env                           	UITaskInvestigationThemeCell            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field CardItem                      	UnityEngine.UI.Button                   @ 按钮
---@field LvMaxNode                     	UnityEngine.RectTransform               @ 等级全满了
---@field Lv                            	UnityEngine.RectTransform               @ 等级区
---@field TaskSchedule                  	UnityEngine.RectTransform               @ 任务区
---@field redPoint                      	UnityEngine.RectTransform               @ 小红点 右上角
---@field TxtLock                       	CustomText                              @ 锁定时文本 "完成4-20主线任务后解锁"
---@field TaskNum                       	TMPro.TextMeshProUGUI                   @ 任务数量 "3/32"
---@field TxtLvNum                      	TMPro.TextMeshProUGUI                   @ 区域等级: LV 5
---@field TxtLevelName                  	UnityEngine.UI.Text                     @ "昆士区"
---@field ImgCardRole                   	Engine.UI.RawImageAlterable             @ 角色图
---@field ImgBg                         	Engine.UI.RawImageAlterable             @ 背景图
local UITaskInvestigationThemeCell = Class("UITaskInvestigationThemeCell")
-- 外部使用时:
-- local UITaskInvestigationThemeCell = import("Game.UI.Tasks.UITaskInvestigationThemeCell")


-- ============================================================

local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程


local Transform = CS.UnityEngine.Transform
local Color = CS.UnityEngine.Color
local Button = CS.UnityEngine.UI.Button
local RawImage = CS.UnityEngine.UI.RawImage
local RawImageAlterable = CS.Engine.UI.RawImageAlterable
local Text = CS.UnityEngine.UI.Text
local UISwitchImage = CS.Game.Native.Common.UISwitchImage
local Mathf = CS.UnityEngine.Mathf

local KTool = CS.Engine.Lib.KTool

local UIModule = CS.Engine.UI.UIModule
local KCookie = CS.Engine.Lib.KCookie

local UIGrayGraphics = CS.Engine.UI.UIGrayGraphics
local UIAllChildGrayGraphics = CS.Engine.UI.UIAllChildGrayGraphics
local Gradient2 = CS.UnityEngine.UI.Extensions.Gradient2


local UITaskGrowUpPanelUtils = import("Game.UI.Tasks.UITaskGrowUpPanelUtils")
local ThemeState = UITaskGrowUpPanelUtils.ThemeState

local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
local UITaskInvestigationPanel = import('Game.UI.Tasks.UITaskInvestigationPanel')
local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')

---@type UITaskUtils
local UITaskUtils = import('Game.UI.Tasks.UITaskUtils')

local ActionComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ActionComponent)

-- ============================================================




-- ============================================================

function UITaskInvestigationThemeCell:__init()
    self.isUnlock = false 
    self.unLockDescription = ""
    self.isInit = false 
end


function UITaskInvestigationThemeCell:__delete()
end


function UITaskInvestigationThemeCell:Awake()

    assert( self.ImgCardRole )
    assert( self.ImgBg )
    assert( self.TxtLevelName )
    assert( self.TxtLvNum )
    assert( self.TaskNum )
    assert( self.TxtLock )
    assert( self.redPoint )
    assert( self.TaskSchedule )
    assert( self.Lv )
    assert( self.LvMaxNode )
    assert( self.CardItem )

end


function UITaskInvestigationThemeCell:Start()
    -- 绑定主按钮
    SetButtonAction(self.CardItem, Bind(self, self.OnClickButton))
    self:SelfInit()
end


function UITaskInvestigationThemeCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end




function UITaskInvestigationThemeCell:SelfInit()
    if self.isInit ~= true  then 
        self.imgBgUIAllChildGrayGraphics = KTool.GetComponent(self.ImgBg.gameObject, typeof(UIGrayGraphics))
        self.imgCardRoleGradient2 = KTool.GetComponent(self.ImgCardRole.gameObject, typeof(Gradient2))
        assert( self.imgBgUIAllChildGrayGraphics )
        assert( self.imgCardRoleGradient2 )
        ---
        self.isInit = true
    end
end


-- allTaskInfoDojo_ -- 后端数据, 若为 nil, 表示此区域未解锁
-- regionIdx_ -- 1-based
function UITaskInvestigationThemeCell:Init( investigationPanel_, allTaskInfoDojo_, regionIdx_ )
    self:SelfInit()

    -- 目标区域 是否解锁(bool), 解锁条件描述(string) 
    self.isUnlock, self.unLockDescription = ActionUtils.IsUnlockRegionalPoint(regionIdx_)
    if self.isUnlock == true and allTaskInfoDojo_ == nil then 
        printError("koko - 后端数据异常, 本该解锁了, 却拿到了空的后端数据")
        self.isUnlock = false  -- 本地补正, 将它设置为 未解锁
    end         
    self.regionIdx = regionIdx_

    -- 得到配表数据:
    local regionPrimaryMapVo = investigationPanel_:GetRegionPrimaryMapVo(regionIdx_) -- 一级大地图表
    local maxLevel           = UITaskInvestigationPanel.GetRegionMaxLvlById(regionIdx_) -- 本地区 最大调查等级

    -- 当前 调查等级:
    local level = isNotNull(allTaskInfoDojo_) and checkInt(allTaskInfoDojo_.level) or 1
    if level > maxLevel then 
        printError("koko 当前调查任务等级 比 任务等级max 都大; level" .. tostring(level) .. "; maxLevel = " .. tostring(maxLevel) )
        level = maxLevel
    end 
    local isMaxLevel = (level == maxLevel) -- 调查等级是否已满 

    ---
    local totalTaskNum       = UITaskInvestigationPanel.GetRegionTaskNumById(regionIdx_, level ) -- 本地区本调查等级下的 任务总数
    -- 当前 完成的任务个数:
    local taskNum = isNotNull(allTaskInfoDojo_) and  allTaskInfoDojo_.completeTask or 0
    if taskNum > totalTaskNum then 
        printError("koko 完成任务数量 比 任务总数还多; taskNum = " .. tostring(taskNum) .. "; totalTaskNum = " .. tostring(totalTaskNum)   )
        taskNum = totalTaskNum
    end 

    -- 背景, 角色:
    -- 如果 ui 准备的图不足, 下面的 img 加载会直接报错;
    local bgPath    = string.format("Arts/Icons/Task/task_survey_bg_region%d.png", checkInt(regionIdx_)) -- 背景图
    local rolePath  = string.format("Arts/Icons/Task/task_survey_cat%d.png",       checkInt(regionIdx_)) -- 角色图

    -- ======================================== 绘制 ===============================================:
    -- 区域名字
    CfUtils.FillText( self.TxtLevelName.gameObject, regionPrimaryMapVo.name )

    -- 显示/影藏 小红点
    if self.isUnlock and isNotNull(allTaskInfoDojo_) then

        local redPointFromServe = checkInt(allTaskInfoDojo_.canReceiveTask) > 0
        local redPointFromRegion = ActionUtils.IsHasTaskCanDraw(regionIdx_)

        --print( "koko - 调查任务: 区域:" .. tostring(regionIdx_) .. ", 后端红点:-" .. (redPointFromServe==true and "有" or "无") .. " , 区域检测红点:-" .. (redPointFromRegion==true and "有" or "无") )

        --CfUtils.SetActive( self.redPoint.gameObject, redPointFromServe or redPointFromRegion )
        CfUtils.SetActive( self.redPoint.gameObject, redPointFromRegion )
    else
        CfUtils.SetActive( self.redPoint.gameObject, false )
    end 

    -- 绘制 背景, 角色:
    self.ImgBg:LoadSprite( bgPath )
    self.ImgCardRole:LoadSprite( rolePath )
    ---
    if self.isUnlock == true then 
        -- ======================== 解锁了 ===========================:
        -- 背景彩色
        self.imgBgUIAllChildGrayGraphics:MarkGray( false )
        -- 角色彩色
        self.imgCardRoleGradient2.enabled = false 

        if isMaxLevel == false then 
            -- ======================== 调查等级 未满 ===========================:
            -- 调查满级:
            CfUtils.SetActive( self.LvMaxNode.gameObject, false )
            -- 解锁信息:
            CfUtils.SetActive( self.TxtLock.gameObject, false )
            -- 区域调查等级:
            CfUtils.SetActive( self.Lv.gameObject, true )
            CfUtils.FillText( self.TxtLvNum.gameObject, level )
            -- 任务信息:
            CfUtils.SetActive( self.TaskSchedule.gameObject, true )
            local taskInfo = tostring(taskNum) .. "/" .. tostring(totalTaskNum)
            CfUtils.FillText( self.TaskNum.gameObject, taskInfo )
        else 
            -- ======================== 调查等级 已满 ===========================:
            -- 调查满级:
            CfUtils.SetActive( self.LvMaxNode.gameObject, true )
            -- 区域调查等级:
            CfUtils.SetActive( self.Lv.gameObject, true )
            CfUtils.FillText( self.TxtLvNum.gameObject, level )
            -- 任务信息:
            CfUtils.SetActive( self.TaskSchedule.gameObject, false )
            -- 解锁信息:
            CfUtils.SetActive( self.TxtLock.gameObject, false )
        end
    else 
        -- ======================== 未解锁 ===========================:
        -- 背景灰色
        self.imgBgUIAllChildGrayGraphics:MarkGray( true )
        -- 角色灰色
        self.imgCardRoleGradient2.enabled = true
        -- 区域调查等级:
        CfUtils.SetActive( self.Lv.gameObject, false )
        -- 任务信息:
        CfUtils.SetActive( self.TaskSchedule.gameObject, false )
        -- 解锁信息:
        CfUtils.SetActive( self.TxtLock.gameObject, true )
        CfUtils.FillText( self.TxtLock.gameObject, self.unLockDescription )
    end
end






function UITaskInvestigationThemeCell:OnClickButton()

    if self.isUnlock ~= true then 
        GameUtils.Toast( self.unLockDescription )

    else 
        KCookie.Set("Task.TypeIndexFromOutside", UITaskUtils.TaskTypeIndexFromOutside.Investigation)

        -- UIModule.OpenDialog(
        --     { 
        --         id = Constants.UITypeIds.UIActionSecondMapDialog, parameters = {id = self.regionIdx}
        --     }, 
        --     {
        --         {id = Constants.UITypeIds.UITasksDialog }
        --     }
        -- )

        -- 执行界面跳转前, 主动刷新 区域数据
        ActionComponent:OverseaRegionalHomeReq(function() 
            -- 跳转到 区域的 任务界面:
            UIModule.OpenDialog(
                { 
                    id = Constants.UITypeIds.UIActionConstructDialog, parameters = {mapId = self.regionIdx} 
                }, 
                {
                    { id = Constants.UITypeIds.UITasksDialog }
                }
            )
        end)

    end 
end








return UITaskInvestigationThemeCell
