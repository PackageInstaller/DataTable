
---@class FloatingMarkerUI
---@field btnAnimComp      UnityEngine.Animation
---@field imgAnimComp      UnityEngine.Animation
---@field markerBtn        UnityEngine.UI.Button
---@field imageRoot        UnityEngine.RectTransform  
local FloatingMarkerUI = Class('FloatingMarkerUI')
-- 外部调用时
-- local FloatingMarkerUI = import('Game.DreamSpace.Hint.FloatingMarkerUI')

-- ========================================================



--- lua:

local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程


---:
local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Canvas = CS.UnityEngine.Canvas
local RectTransform = CS.UnityEngine.RectTransform
local Mathf = CS.UnityEngine.Mathf
local Time = CS.UnityEngine.Time
local Transform = CS.UnityEngine.Transform
local CanvasGroup = CS.UnityEngine.CanvasGroup

local UISwitchImage = CS.Game.Native.Common.UISwitchImage


--- funtoy:
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool
local Vector3 = CS.UnityEngine.Vector3

local DreamSpaceUtils = CS.DreamSpace.DreamSpaceUtils

---@type DreamSpaceSounds
local DreamSpaceSounds = import('Game.DreamSpace.Tools.DreamSpaceSounds'):GetInstance()

local DreamSpaceLuaUtils = import('Game.DreamSpace.Tools.DreamSpaceLuaUtils')

local UIMain_TaskPanel = import('Game.DreamSpace.Level1.UI.UIMain_TaskPanel')

-- ========================================================

local markerLoopAnimClip = "BtnMainTaskRoot_Loop"
local markerEntryAnimClip = "BtnMainTaskRoot_entry"
local buttonIdleAnimClip = "UI_ActionDreamland_ButtonIdle"
local buttonPressedAnimClip = "UI_ActionDreamland_ButtonPressed" 

-- ========================================================

local taskPanel = nil

function FloatingMarkerUI:__init()
    self.controller = nil
end


function FloatingMarkerUI:__delete()
end



function FloatingMarkerUI:Awake()
end

function FloatingMarkerUI:Start()
    KTool.SetActive(self.controller.gameObject, true)

    if isNotNull(self.markerBtn) then 
        self.markerBtn.onClick:AddListener(Bind(self, self.Pressed))
    end

    -- DreamSpaceLuaUtils.StopCoroutine( self.co_1 )
    -- self.co_1 = cs_coroutine.start(self.DelayInit, self)
end


-- function FloatingMarkerUI:DelayInit()
--     cs_coroutine.yield_return( UIMain_TaskPanel.WaitInstance() ) -- 等待实例化
--     self.taskPanel = UIMain_TaskPanel.GetInstance()   -- 拿到唯一实例
-- end



function FloatingMarkerUI:OnDestroy()
    --DreamSpaceLuaUtils.StopCoroutine( self.co_1 )
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
end

-- =====================================================


function FloatingMarkerUI:Entry()
    KTool.SetActive(self.controller.gameObject, true)
    --self.imgAnimComp:Play(markerEntryAnimClip)
end


function FloatingMarkerUI:Pressed()
    self.btnAnimComp:Play(buttonPressedAnimClip)
    if isNotNull(taskPanel) then
        taskPanel:Shiny()
        DreamSpaceSounds.Play( DreamSpaceSounds.sfx.tips )
    end
end


-- display or hide the marker depending on whether its state (blocked or not).
function FloatingMarkerUI:DisplayImage(isShow)
    KTool.SetActive(self.imageRoot, isShow)
end

-- activate or deactivate the floating marker ui without caring about its state.
function FloatingMarkerUI:EnableUI(isEnable)
    KTool.SetActive(self.imgAnimComp, isEnable)
end



function FloatingMarkerUI:SetTaskPanel(panel)
    taskPanel = panel
end



return FloatingMarkerUI
