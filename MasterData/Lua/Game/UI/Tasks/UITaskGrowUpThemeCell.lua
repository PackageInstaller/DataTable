-------------------------------------------------------------------------------
-- 任务界面 - 成就面板 - 任务列表项
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-02-18 15:50:09
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/OverseaTasks/OverseaGrowUpTaskThemeCell.prefab
---@class UITaskGrowUpThemeCell
---@field Env                           	UITaskGrowUpThemeCell                   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgCareerS                    	Engine.UI.ImageAlterable                @ 职业 ui
---@field ImgElement                    	Engine.UI.RawImageAlterable             @ 职业 ui
---@field fullButton                    	UnityEngine.UI.Button               @ 主按钮 
---@field txtLock                       	UnityEngine.UI.Text                 @ ThemeState.Locked 状态
---@field finishTF                      	UnityEngine.RectTransform               @ ThemeState.Finshed 状态
---@field redPointTF                    	UnityEngine.RectTransform               @ 小红点
---@field ImgBgInfo                     	Game.Native.Common.UISwitchImage         @ 3种卡牌状态, 3种底图
---@field rareIcon                      	Game.Native.Common.UISwitchImage         @ SSR 星级-icon
---@field rareBG                        	Game.Native.Common.UISwitchImage         @ SSR 星级-背景
---@field txtName2                      	UnityEngine.UI.Text                 @ 角色副名  滑轮XX
---@field txtName1                      	UnityEngine.UI.Text                 @ 角色名字  非天
---@field rowImgAlterable               	Engine.UI.RawImageAlterable        @ 头像
local UITaskGrowUpThemeCell = Class("UITaskGrowUpThemeCell")
-- 外部使用时:
-- local UITaskGrowUpThemeCell = import("Game.UI.Tasks.UITaskGrowUpThemeCell")


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
local UIGrayGraphics = CS.Engine.UI.UIGrayGraphics

local KTool = CS.Engine.Lib.KTool


local UITaskGrowUpPanelUtils = import("Game.UI.Tasks.UITaskGrowUpPanelUtils")
local ThemeState = UITaskGrowUpPanelUtils.ThemeState

local UIModule = CS.Engine.UI.UIModule


-- ============================================================



function UITaskGrowUpThemeCell:__init()
end


function UITaskGrowUpThemeCell:__delete()
end


function UITaskGrowUpThemeCell:Awake()

    assert( self.fullButton )
    assert( self.rowImgAlterable )
    assert( self.txtName1 )
    assert( self.txtName2 )
    assert( self.rareBG and self.rareIcon )
    assert( self.ImgBgInfo )
    assert( self.redPointTF )
    assert( self.finishTF )
    assert( self.txtLock )
    assert( self.ImgElement )
    assert( self.ImgCareerS )

    self.rowRawImage = KTool.GetComponent(self.rowImgAlterable.gameObject, typeof(RawImage))
    self.rowUIGrayGraphics = KTool.GetComponent(self.rowImgAlterable.gameObject, typeof(UIGrayGraphics))
    assert( self.rowRawImage and self.rowUIGrayGraphics )

end


function UITaskGrowUpThemeCell:Start()
    -- 绑定主按钮
    SetButtonAction(self.fullButton, Bind(self, self.OnClickButton))
end


function UITaskGrowUpThemeCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------


function UITaskGrowUpThemeCell:Init( themeDojo_ )

    -- 读配表:
    self.themeDojo = themeDojo_
    self.themeVo = UITaskGrowUpPanelUtils.ReadGrowUpThemeVO( themeDojo_.id )   -- 成长任务主题表
    self.cardVO = UITaskGrowUpPanelUtils.ReadCardVO(self.themeVo.bigReward)    -- 角色卡牌表
    
    -- 点亮小红点:
    local isHaveRedPoint = (themeDojo_.redDotHint == 0)
    CfUtils.SetActive(self.redPointTF.gameObject, isHaveRedPoint == true)
    
    -- 换卡牌 主头像:
    self.rowImgAlterable:LoadSprite( self.themeVo.bigRewardResource )

    -- 换 角色名字:
    self.txtName1.text = self.cardVO.descr    -- 角色主名
    self.txtName2.text = self.cardVO.name    -- 角色副名

    -- 换 SSR 星级:
    local rare = self.cardVO.rare
    CfUtils.SetUISwitchImage(self.rareBG.gameObject,   rare)
    CfUtils.SetUISwitchImage(self.rareIcon.gameObject, rare)

    -- 职业 ui:
    local elementPath = string.format("Arts/Icons/LevelGain/common_ico_element_l_%d.png", checkInt( self.cardVO.attributeType )) -- 颜色属性
    local careerPath  = string.format("UIAtlas/Common2/common_ico_career_%d.png",         checkInt( self.cardVO.career )) -- 职业
    self.ImgElement:LoadSprite( elementPath )
    self.ImgCareerS:LoadSprite( careerPath )


    -- 主题卡 3种状态:
    self.themeState = nil 
    if self.themeDojo.finish == 1 then 
        self.themeState = ThemeState.Finshed    -- 领取完所有奖励
    else 
        if self.themeDojo.unlock == 0 then 
            self.themeState = ThemeState.Locked         -- 未解锁
        else 
            self.themeState = ThemeState.Unlocked   -- 解锁
        end
    end 

    self:SwitchByThemeState()
end


function UITaskGrowUpThemeCell:SwitchByThemeState()

    CfUtils.SetActive(self.finishTF.gameObject, self.themeState == ThemeState.Finshed )
    CfUtils.SetActive(self.txtLock.gameObject, self.themeState == ThemeState.Locked )

    if self.themeState == ThemeState.Locked then 
        -- 未解锁:

        -- 读取 解锁条件文本:
        local unlockText = GameUtils.GetUnlockDescr(self.themeVo.unlock, self.themeVo.unlockParameter)
        self.txtLock.text = unlockText

        self.rowRawImage.color = Color( 0.5, 0.5, 0.5, 1 )
        self.rowUIGrayGraphics:MarkGray( true )
    end

end



function UITaskGrowUpThemeCell:OnClickButton()
    if self.themeState ~= ThemeState.Unlocked then 
        return
    end 
    --print( "点击 卡牌" )

    -- 进入 成长任务 二级界面: 同时保持一级页面始终开着
    UIModule.OpenDialog(
        { 
            id = Constants.UITypeIds.UITaskGrowUpSecondPanel, 
            parameters = 
            {
                themeId = self.themeDojo.id
            }
        },
        {
            {id = Constants.UITypeIds.UITasksDialog}
        }
    )
end



return UITaskGrowUpThemeCell
