---
--- Created by zou hanjie.
--- DateTime: 2023-10-21 18:02:11
---
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local cs_coroutine = import('XLua.cs_coroutine')
local Yielders = CS.Engine.Lib.Yielders -- 协程

local UIModule = CS.Engine.UI.UIModule

local IdolLive3D_TalkNode = 'Game.IdolLive3D.Tools.IdolLive3D_TalkNode'
                              

-- 


--- from: Assets/BundleResources/Prefabs/IdolLive3D14900850/IdolLive3D14900850.prefab > name: IdolLive3D14900850
---@class UI_14900850
---@field Env                           	UI_14900850                             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field PanelWakeUp                   	UnityEngine.RectTransform               	@ 0    面板 1 -- 2按钮
---@field PanelDesc                     	UnityEngine.RectTransform               	@ 1    面板 2 -- 3按钮
---@field BtnGentle                     	UnityEngine.RectTransform               	@ 2    按钮 1-1 - "温柔唤醒"
---@field BtnViolence                   	UnityEngine.RectTransform               	@ 3    按钮 1-2 - "粗暴唤醒"
---@field BtnFace                       	UnityEngine.RectTransform               	@ 4    按钮 2-1 - "洗脸"
---@field BtnClothing                   	UnityEngine.RectTransform               	@ 5    按钮 2-2 - "穿衣"
---@field BtnEat                        	UnityEngine.RectTransform               	@ 6    按钮 2-3 - "吃饭"
local UI_14900850 = Class("UI_14900850")
-- ==================================
-- 'Game.IdolLive3D.Interactive.Customs.UI_14900850'



local Image = CS.UnityEngine.UI.Image
local Color = CS.UnityEngine.Color
local Transform = CS.UnityEngine.Transform
local Time = CS.UnityEngine.Time
local CanvasGroup = CS.UnityEngine.CanvasGroup
local Animation = CS.UnityEngine.Animation
local Mathf = CS.UnityEngine.Mathf
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode

local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool
local CinemachineBlendDefinition = CS.Cinemachine.CinemachineBlendDefinition
local GameUtils = import('Game.Utils.GameUtils')

local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

local IdolLive3D_Loader = import('Game.IdolLive3D.IdolLive3D_Loader')

local IdolLive3D_Utils = import('Game.IdolLive3D.IdolLive3D_Utils')

---@type IdolLive3D_GraphicSetting
local IdolLive3D_GraphicSetting = import('Game.IdolLive3D.IdolLive3D_GraphicSetting')

---@type IdolLive3D_States
local IdolLive3D_States = import('Game.IdolLive3D.IdolLive3D_States')
local InteractiveStateType = IdolLive3D_States.InteractiveStateType

local IdolLive3D_UISmoothShowEnt = import('Game.IdolLive3D.IdolLive3D_UISmoothShowEnt')

local IdolLive3D_UITouchTips = import('Game.IdolLive3D.IdolLive3D_UITouchTips')

---@type IdolLive3D_UIHand
local IdolLive3D_UIHand = import('Game.IdolLive3D.IdolLive3D_UIHand')

---@type IdolLive3D_UIQTE
local IdolLive3D_UIQTE = import('Game.IdolLive3D.IdolLive3D_UIQTE')

---@type IdolLive3D_UISwitchBtn
local IdolLive3D_UISwitchBtn = import('Game.IdolLive3D.IdolLive3D_UISwitchBtn')

---@type Live3D_CustomEvents
local Live3D_CustomEvents = import('Game.IdolLive3D.Interactive.Customs.Live3D_CustomEvents')


------------------------------------- 


local ClothState = { 
    On = 1, 
    Off = 2,
}



-- ==================================
function UI_14900850:__init()
    self.isInit = false
    self.chooseIdle100CB = nil
    self.chooseIdle200CB = nil
end

function UI_14900850:__delete()
    self.cardSkinId = nil
end

function UI_14900850:OnFocus(focus)
    if focus then
    else 
    end
end

function UI_14900850:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
    end))
    return coWait
end


function UI_14900850:Awake()
    self.clothIcon = self.BtnClothing:Find("ImgIcon")
    self.clothTxt  = self.BtnClothing:Find("TxtTitle")
    self:ShowPanel_1(false)
    self:ShowPanel_2(false)
end



function UI_14900850:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local argument = checkTable(self.controller.Argument.parameters)
    end))
    return coWait
end


function UI_14900850:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        IdolLive3D_Utils.StopCoroutine(self.co_1)

        ---
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end



function UI_14900850:Init( mainForRuntime_ )
    self.mainForRuntime = mainForRuntime_
    self.interactiveManager = mainForRuntime_.idolLive3D_InteractiveManagerEnv

    self.clothState = ClothState.Off

    SetButtonAction(self.BtnGentle.gameObject,      Bind(self, self.OnClickBtn_1_GentleWakeUp))
    SetButtonAction(self.BtnViolence.gameObject,    Bind(self, self.OnClickBtn_1_ViolenceWakeUp))
    SetButtonAction(self.BtnFace.gameObject,        Bind(self, self.OnClickBtn_2_Face))
    SetButtonAction(self.BtnClothing.gameObject,    Bind(self, self.OnClickBtn_2_Clothing))
    SetButtonAction(self.BtnEat.gameObject,         Bind(self, self.OnClickBtn_2_Eat))

    self.frameCount = 0 -- 帧计时
    self.isInit = true
end


function UI_14900850:SelfUpdate()
    if self.frameCount < 9999 then
        self.frameCount = self.frameCount + 1
    end
    --print("frameCount" .. tostring(self.frameCount))
end

-- ================================================== 


function UI_14900850:BindCB_ChooseIdle100( cb_ )
    self.chooseIdle100CB = cb_
end

function UI_14900850:BindCB_ChooseIdle200( cb_ )
    self.chooseIdle200CB = cb_
end




-- ==================================


function UI_14900850:ShowPanel_1( isShow_ )
    CfUtils.SetActive( self.PanelWakeUp.gameObject, isShow_==true )
end

function UI_14900850:ShowPanel_2( isShow_ )
    CfUtils.SetActive( self.PanelDesc.gameObject, isShow_==true )
end


function UI_14900850:OnClickBtn_1_GentleWakeUp()
    --print("按钮 -1- 温柔唤醒")
    if isNotNull(self.chooseIdle100CB) then 
        self.chooseIdle100CB()
    end 
    self:ShowPanel_1(false)
    self:ShowPanel_2(false)
end

function UI_14900850:OnClickBtn_1_ViolenceWakeUp()
    --print("按钮 -1- 暴力唤醒")
    if isNotNull(self.chooseIdle200CB) then 
        self.chooseIdle200CB()
    end 
    self:ShowPanel_1(false)
    self:ShowPanel_2(false)
end

-- =====================================================


function UI_14900850:OnClickBtn_2_Face()
    if self.interactiveManager:IsInIdleState() then 
        print("按钮 -2- 洗脸")
        Events.Broadcast(IdolLive3D_States.EventVirtualSimpleTap, "ui_face")
    end 
end


function UI_14900850:OnClickBtn_2_Eat()
    if self.interactiveManager:IsInIdleState() then 
        print("按钮 -2- 吃饭")
        Events.Broadcast(IdolLive3D_States.EventVirtualSimpleTap, "ui_food")
    end
end


function UI_14900850:OnClickBtn_2_Clothing()
    -- 禁止玩家连续点击
    if self.frameCount < 30 then 
        return
    end 
    ---
    if self.interactiveManager:IsInIdleState() then 
        self.frameCount = 0


        IdolLive3D_Utils.StopCoroutine(self.co_1)
        self.co_1 = cs_coroutine.start(function()

            if self.clothState == ClothState.Off then 
                self.clothState = ClothState.On
                print("按钮 -2- 穿衣")
                Events.Broadcast(IdolLive3D_States.EventVirtualSimpleTap, "ui_on_cloth")
                --- ui 显示 "脱衣服"
                CfUtils.SetUISwitchText( self.clothTxt.gameObject, 2 )
                CfUtils.SetUISwitchImage( self.clothIcon.gameObject, 2 )
                ---
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.7 ))
                Events.Broadcast(Live3D_CustomEvents.DoDress,                 true)

            else 
                self.clothState = ClothState.Off
                print("按钮 -2- 脱衣")
                Events.Broadcast(IdolLive3D_States.EventVirtualSimpleTap, "ui_off_cloth")
                --- ui 显示 "穿衣服"
                CfUtils.SetUISwitchText( self.clothTxt.gameObject, 1 )
                CfUtils.SetUISwitchImage( self.clothIcon.gameObject, 1 )
                ---
                cs_coroutine.yield_return(Yielders.GetWaitForSeconds( 0.55 ))
                Events.Broadcast(Live3D_CustomEvents.DoDress,                 false)
            end 

        end)
    end
end












return UI_14900850
