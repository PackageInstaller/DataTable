local base = require("CustomLive2d.Base.live2dCustomLuaBase")
local xinghuan_idol_customLua = class("xinghuan_idol_customLua", base)

function xinghuan_idol_customLua:OnInit()
  self.UInumber = 0
  self.Colornumber = 0
  self.dragColornumber = self:GetDragParam("ParamPhoneaixinyanse")
  self.paramColornumber = self.dragColornumber:GetComponent(typeof(CS.Live2D.Cubism.Core.CubismParameter))
  self.paramColornumber:InterationLock(1)
  self.paramColornumber.Value = 1
  self.dragColornumber.CurrentValue = 1
  self.Phtnumber = 0.4
  self.dragPhtnumber = self:GetDragParam("ParamPhonexiangcezhaopian")
  self.paramPhtnumber = self.dragPhtnumber:GetComponent(typeof(CS.Live2D.Cubism.Core.CubismParameter))
  self.paramPhtnumber:InterationLock(1)
  self.paramPhtnumber.Value = 1
  self.dragPhtnumber.CurrentValue = 1
end

function xinghuan_idol_customLua:OnPlayL2dClip(animName)
  if animName == "touch_dianzan1" then
    self.UInumber = self.UInumber + 1
    self:ChaRuPlay()
    self.paramColornumber.Value = self.Colornumber
    self.dragColornumber.CurrentValue = self.Colornumber
  elseif animName == "touch_dianzan2" then
    self.UInumber = self.UInumber + 1
    self:ChaRuPlay()
    self.paramColornumber.Value = self.Colornumber
    self.dragColornumber.CurrentValue = self.Colornumber
  end
  print("UInumber = ", self.UInumber)
  print("Colornumber = ", self.Colornumber)
  if animName == "touch_A" then
    self.Phtnumber = 0.4
  elseif animName == "touch_B" then
    self.Phtnumber = 0.3
  elseif animName == "touch_C" then
    self.Phtnumber = 0.2
  elseif animName == "touch_D" then
    self.Phtnumber = 0.1
  end
  self.paramPhtnumber.Value = self.Phtnumber
  self.dragPhtnumber.CurrentValue = self.Phtnumber
end

function xinghuan_idol_customLua:ChaRuPlay()
  if self.UInumber >= 20 then
    self:GetL2dClip("touch_A").hitArea = 16
    self:GetL2dClip("touch_B").hitArea = 30
    self:GetL2dClip("touch_C").hitArea = 30
    self:GetL2dClip("touch_D").hitArea = 30
    self.Colornumber = 0
    self.UInumber = 0
  elseif self.UInumber >= 15 then
    self:GetL2dClip("touch_A").hitArea = 30
    self:GetL2dClip("touch_B").hitArea = 30
    self:GetL2dClip("touch_C").hitArea = 30
    self:GetL2dClip("touch_D").hitArea = 16
    self.Colornumber = 0.6
  elseif self.UInumber >= 10 then
    self:GetL2dClip("touch_A").hitArea = 30
    self:GetL2dClip("touch_B").hitArea = 30
    self:GetL2dClip("touch_C").hitArea = 16
    self:GetL2dClip("touch_D").hitArea = 30
    self.Colornumber = 0.4
  elseif self.UInumber >= 5 then
    self:GetL2dClip("touch_A").hitArea = 30
    self:GetL2dClip("touch_B").hitArea = 16
    self:GetL2dClip("touch_C").hitArea = 30
    self:GetL2dClip("touch_D").hitArea = 30
    self.Colornumber = 0.2
  else
    self:GetL2dClip("touch_A").hitArea = 16
    self:GetL2dClip("touch_B").hitArea = 30
    self:GetL2dClip("touch_C").hitArea = 30
    self:GetL2dClip("touch_D").hitArea = 30
  end
end

return xinghuan_idol_customLua
