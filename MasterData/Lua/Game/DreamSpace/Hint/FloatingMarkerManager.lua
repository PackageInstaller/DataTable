

---@class FloatingMarkerManager

---@field anchorGroup                  UnityEngine.Transform   
---@field taskPanelBehavior            Engine.Modules.LuaBehaviour
---@field floatingMarkerInst           UnityEngine.RectTransform        
local FloatingMarkerManager = Class('FloatingMarkerManager')
--local FloatingMarkerManager = import('Game.DreamSpace.Hint.FloatingMarkerManager')


local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders -- 协程

---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local DreamSpaceLuaUtils = import('Game.DreamSpace.Tools.DreamSpaceLuaUtils')

local DreamSpaceStates = import('Game.DreamSpace.Tools.DreamSpaceStates')

local Object = CS.UnityEngine.Object
local GameObject = CS.UnityEngine.GameObject
local Canvas = CS.UnityEngine.Canvas
local Transform = CS.UnityEngine.Transform
local Button = CS.UnityEngine.UI.Button
local RectTransform = CS.UnityEngine.RectTransform
local Vector3 = CS.UnityEngine.Vector3

--- funtoy:
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local KTool = CS.Engine.Lib.KTool

local DreamSpaceUtils = CS.DreamSpace.DreamSpaceUtils
local FloatingMarkerCalculate = CS.InteractableHint.FloatingMarkerCalculate
local LuaBehaviour = CS.Engine.Modules.LuaBehaviour
local LuaParameters = CS.Engine.Modules.LuaParameters
local GlobalsInDreamSpace = CS.DreamSpace.GlobalsInDreamSpace


function FloatingMarkerManager:__init()
    self.controller = nil
    self.isInit = false;
    self.WhenButtonPressed = nil -- 函数指针
end

function FloatingMarkerManager:__delete()
    self.DelayInitCoroutine = nil
end

function FloatingMarkerManager:Awake()
    
end


function FloatingMarkerManager:Start()
    self.anchorIndex = 1
    self.anchorList = {}
    self.transform = self.controller.gameObject.transform
    self.floatingMarkerCalculate = KTool.GetComponent(self.controller.gameObject, typeof(FloatingMarkerCalculate))
    DreamSpaceLuaUtils.StopCoroutine( self.DelayInitCoroutine )
    self.DelayInitCoroutine = cs_coroutine.start(self.DelayInit, self)
end


function FloatingMarkerManager:OnDestroy()
    DreamSpaceLuaUtils.StopCoroutine( self.DelayInitCoroutine )
    self.DelayInitCoroutine = nil
    ---
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
end


function FloatingMarkerManager:DelayInit()   
    coroutine.yield(Yielders.EndOfFrame)                 -- 先等待一帧, 等新场景中新的 SwitchablePlayer 实例被创建
    
    self.FindCharacterRefInScene(self)

    self.InitAnchorList(self)

    self.InitFloatingMarkerCalculate(self, self.anchorList[self.anchorIndex])

    self.InitMarkerUI(self)

    self.isInit = true
end

function FloatingMarkerManager:InitAnchorList()
    for i = 1, self.anchorGroup.childCount do
        self.anchorList[i] = self.anchorGroup:GetChild(i - 1)
    end
end

function FloatingMarkerManager:FindCharacterRefInScene() -- 只会查找 5 次, 还是找不到就放弃 hint 功能了;
    self.role = nil

    for i = 1, DreamSpaceStates.DelayInitWaitFrames do 
        self.role = GlobalsInDreamSpace.FindComponent("vTargetFollow")
        if not isNull(self.role) then
            return
        end
        coroutine.yield(Yielders.EndOfFrame)
    end

    if isNull(self.role) then
        assert(false, "始终没能找到 gamoebj: SwitchablePlayer/VTarget/Follow, 请查找原因")
        return
    end
end


function FloatingMarkerManager:InitFloatingMarkerCalculate(anchor)
    self.floatingMarkerCalculate:SetAnchor(anchor)
    self.floatingMarkerCalculate:SetFloatingMarker(self.floatingMarkerInst)
    self.floatingMarkerCalculate.OnFrameIn = Bind(self, self.OnFramein)
    self.floatingMarkerCalculate.OnBlocked = Bind(self, self.UpdateBlocked)
    self.floatingMarkerCalculate.OnUnblocked = Bind(self, self.UpdateUnblocked)
end

function FloatingMarkerManager:InitMarkerUI()


    local taskPanelLuaEnv = DreamSpaceLuaUtils.GetLuaScr(self.taskPanelBehavior.gameObject, "Game.DreamSpace.Level1.UI.UIMain_TaskPanel" )
    assert(taskPanelLuaEnv)
    self.floatingMarkerUI = DreamSpaceLuaUtils.GetLuaScr(self.floatingMarkerInst.gameObject, "Game.DreamSpace.Hint.FloatingMarkerUI" )
    self.floatingMarkerUI:SetTaskPanel(taskPanelLuaEnv)

    self.floatingMarkerUI:EnableUI(false)
end


function FloatingMarkerManager:OnFramein()
    self.floatingMarkerUI:Entry()
end

function FloatingMarkerManager:UpdateBlocked()    
    self.floatingMarkerUI:DisplayImage(false)
end

function FloatingMarkerManager:UpdateUnblocked()
    self.floatingMarkerUI:DisplayImage(true)
end

function FloatingMarkerManager:EnableMarker(isEnable)
    self.floatingMarkerUI:EnableUI(isEnable)
end

function FloatingMarkerManager:MoveToNextAnchor()
    if not (self.anchorIndex + 1 > #self.anchorList) then
        self.anchorIndex = self.anchorIndex + 1
        self.floatingMarkerCalculate:SetAnchor(self.anchorList[self.anchorIndex])
    else
        self:EnableMarker(false)
    end
end






return FloatingMarkerManager
