local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINBaseItemWithReceived = class("UINBaseItemWithReceived", UINBaseItemWithCount)
local base = UINBaseItemWithCount

function UINBaseItemWithReceived:OnInit()
  base.OnInit(self)
end

function UINBaseItemWithReceived:InitItemWithCount(itemCfg, count, clickEvent, isPicked)
  self:SetPickedUIActive(isPicked)
  base.InitItemWithCount(self, itemCfg, count, clickEvent)
  if isPicked then
    self:CloseGreatRewardLoopFx()
  end
end

function UINBaseItemWithReceived:SetPickedUIActive(isPicked)
  self.ui.obj_isPicked:SetActive(isPicked)
  if not IsNull(self.ui.tex_IsPicked) then
    self.ui.tex_IsPicked:SetIndex(0)
  end
  if not IsNull(self.ui.tex_Recevied) then
    self.ui.tex_Recevied:SetIndex(0)
  end
end

function UINBaseItemWithReceived:SetExpiredUIActive(isPicked)
  self.ui.obj_isPicked:SetActive(isPicked)
  if not IsNull(self.ui.tex_IsPicked) then
    self.ui.tex_IsPicked:SetIndex(1)
  end
  if not IsNull(self.ui.tex_Recevied) then
    self.ui.tex_Recevied:SetIndex(1)
  end
end

function UINBaseItemWithReceived:OnDelete()
  base.OnDelete(self)
end

return UINBaseItemWithReceived
