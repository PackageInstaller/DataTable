local base = require("CustomLive2d.Base.live2dCustomLuaBase")
local jiangyu_swimsuit_customLua = class("jiangyu_swimsuit_customLua", base)

function jiangyu_swimsuit_customLua:OnInit()
  self.UInumber = 4
  self.dragUINumner = self:GetDragParam("ParamUInumber")
  self.paramUINumber = self.dragUINumner:GetComponent(typeof(CS.Live2D.Cubism.Core.CubismParameter))
  self.paramUINumber:InterationLock(1)
  self.paramUINumber.Value = 1
  self.dragUINumner.CurrentValue = 1
  self.timeState = 0
  self._timeTouchAnimNameList = {
    "touch_B1F",
    "touch_B1N",
    "touch_B2M",
    "touch_B2N",
    "touch_B3M",
    "touch_B3F"
  }
end

function jiangyu_swimsuit_customLua:OnPlayL2dClip(animName)
  if animName == "touch_2A" then
    self:Jishu(animName)
    self:ChaRuPlay()
  end
  if self.UInumber <= 1 and animName == "touch_2B" then
    self.UInumber = 0
    self.paramUINumber.Value = 0
    self.dragUINumner.CurrentValue = 0
  end
  self.timeState = self:GetParamValue("ParamShiJian")
  for key, touchName in pairs(self._timeTouchAnimNameList) do
    if self:_IsCanTouchInTheTime(touchName, self.timeState) then
      self:GetL2dClip(touchName).hitArea = self:_GetTimeTouchHitAreaIndex(touchName)
    else
      self:GetL2dClip(touchName).hitArea = -2
    end
  end
end

function jiangyu_swimsuit_customLua:OnLive2dEvent(eventName, ...)
end

function jiangyu_swimsuit_customLua:OnEventCallCustomLua(eventArg)
end

function jiangyu_swimsuit_customLua:OnTriggerCallCustomLua(triggerArg)
end

function jiangyu_swimsuit_customLua:OnEnterHeroView()
end

function jiangyu_swimsuit_customLua:Jishu(animName)
  self.UInumber = self.UInumber - 1
  print("UInumber = ", self.UInumber)
  self.paramUINumber.Value = self.UInumber
  self.dragUINumner.CurrentValue = self.UInumber
end

function jiangyu_swimsuit_customLua:ChaRuPlay()
  if self.UInumber <= 1 then
    self:GetDragParam("ParamTZ0").TriggerEventName = "touch_2B"
  end
end

function jiangyu_swimsuit_customLua:_GetTimeTouchHitAreaIndex(touchName)
  if touchName == "touch_B1F" or touchName == "touch_B1N" then
    return 16
  end
  if touchName == "touch_B2M" or touchName == "touch_B2N" then
    return 17
  end
  if touchName == "touch_B3M" or touchName == "touch_B3F" then
    return 18
  end
end

function jiangyu_swimsuit_customLua:_IsCanTouchInTheTime(touchName, time)
  if time == 0 then
    if touchName == "touch_B1F" then
      return false
    end
    if touchName == "touch_B1N" then
      return false
    end
    if touchName == "touch_B2M" then
      return true
    end
    if touchName == "touch_B2N" then
      return false
    end
    if touchName == "touch_B3M" then
      return true
    end
    if touchName == "touch_B3F" then
      return false
    end
  end
  if time == 0.5 then
    if touchName == "touch_B1F" then
      return true
    end
    if touchName == "touch_B1N" then
      return false
    end
    if touchName == "touch_B2M" then
      return false
    end
    if touchName == "touch_B2N" then
      return false
    end
    if touchName == "touch_B3M" then
      return false
    end
    if touchName == "touch_B3F" then
      return true
    end
  end
  if time == 1 then
    if touchName == "touch_B1F" then
      return false
    end
    if touchName == "touch_B1N" then
      return true
    end
    if touchName == "touch_B2M" then
      return false
    end
    if touchName == "touch_B2N" then
      return true
    end
    if touchName == "touch_B3M" then
      return false
    end
    if touchName == "touch_B3F" then
      return false
    end
  end
end

return jiangyu_swimsuit_customLua
