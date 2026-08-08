local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local playerInput
local sizeChange = 0
local MAX_ACTOR_HUD = 5

function SetupWindow()
  playerInput = CS.SceneFight.Instance.mPlayerInput.transform
  REF.Input_Joystick.UISprite.enabled = false
  REF.Input_Joystick_Left.UISprite.enabled = false
  REF.Input_Joystick_Right.UISprite.enabled = false
  playerInput:Find("Joystick"):GetComponent(typeof(CS.PadInputJoystick)):OnInitNGUIBtn(REF.Input_Joystick.transform)
  playerInput:Find("ButtonLeft"):GetComponent(typeof(CS.PadInputButton)):OnInitNGUIBtn(REF.Input_Joystick_Left.transform)
  playerInput:Find("ButtonRight"):GetComponent(typeof(CS.PadInputButton)):OnInitNGUIBtn(REF.Input_Joystick_Right.transform)
end

function InitWindow()
  CS.UICamera.onScreenResize = CS.UICamera.onScreenResize + screenSizeChanged
  onUISizeUpdateImpl()
end

function UninitWindow()
  CS.UICamera.onScreenResize = CS.UICamera.onScreenResize - screenSizeChanged
end

function LateUpdateWindow(delta)
  if sizeChange ~= 0 then
    sizeChange = 0
    onUISizeUpdateImpl()
  end
end

function screenSizeChanged()
  sizeChange = 1
end

function onUISizeUpdateImpl()
  local point = CS.UnityEngine.Vector2.zero
  local size = CS.UnityEngine.Vector2.one
  point, size = CS.UIBaseProcess.Instance:TransUIPointAndSize(REF.Input_Joystick.transform, 300.0)
  playerInput:Find("Joystick"):GetComponent(typeof(CS.PadInputJoystick)):OnSizeUpdate(point, size)
  point, size = CS.UIBaseProcess.Instance:TransUIPointAndSize(REF.Input_Joystick_Left.transform, 140.0)
  playerInput:Find("ButtonLeft"):GetComponent(typeof(CS.PadInputButton)):OnSizeUpdate(point, size)
  point, size = CS.UIBaseProcess.Instance:TransUIPointAndSize(REF.Input_Joystick_Right.transform, 140.0)
  playerInput:Find("ButtonRight"):GetComponent(typeof(CS.PadInputButton)):OnSizeUpdate(point, size)
end
