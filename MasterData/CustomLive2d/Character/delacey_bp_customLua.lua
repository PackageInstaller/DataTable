local base = require("CustomLive2d.Base.live2dCustomLuaBase")
local delacey_bp_customLua = class("delacey_bp_customLua", base)

function delacey_bp_customLua:OnInit()
  self.normalAL2dClip = self:GetL2dClip("normalA")
  self.normalBL2dClip = self:GetL2dClip("normalB")
  self.numberA = 0
  self.numberB = 0
  self.GetDragParam("Paramlogin2").isKeepValue = true
end

function delacey_bp_customLua:OnPlayL2dClip(animName)
  self:Qiehuan(animName)
  self:Jishu(animName)
  self:Jishu2("ParamXianQz")
  print("play")
  print("当前吸附值为 ", self:GetDragParam("Paramlogin2").AdsorptionValueArray[self.numberB])
  if animName == "touch_4" then
    self:ChaRuPlay()
  end
  if self.numberB >= 4 and animName == "touch_8" then
    self:GetDragParam("ParamXianQz").TriggerEventName = "touch_4"
    self.numberB = 0
  end
end

function delacey_bp_customLua:OnLive2dEvent(eventName, ...)
end

function delacey_bp_customLua:OnEventCallCustomLua(eventArg)
end

function delacey_bp_customLua:OnTriggerCallCustomLua(triggerArg)
end

function delacey_bp_customLua:Qiehuan(animName)
  if (animName == "touch_8" or animName == "touch_B3") and self.csCtrl.NormalAnimation ~= self.normalBL2dClip.Clip then
    self.csCtrl.NormalAnimation = self.normalBL2dClip.Clip
    print("succedB")
  end
  if (animName == "touch_9" or animName == "touch_A1" or animName == "touch_A2" or animName == "touch_B1" or animName == "touch_B2") and self.csCtrl.NormalAnimation ~= self.normalAL2dClip.Clip then
    self.csCtrl.NormalAnimation = self.normalAL2dClip.Clip
    print("succedA")
  end
end

function delacey_bp_customLua:Jishu(animName)
  if animName == "touch_1" then
    self.numberA = self.numberA + 1
    print("numberA = ", self.numberA)
  end
end

function delacey_bp_customLua:Jishu2(paramName)
  if self:GetParamValue(paramName) >= 0.6 then
    self.numberB = self.numberB + 1
    print("numberB = ", self.numberB)
  end
end

function delacey_bp_customLua:ChaRuPlay()
  if self.numberB >= 4 then
    self:GetDragParam("ParamXianQz").TriggerEventName = "touch_8"
  end
end

return delacey_bp_customLua
