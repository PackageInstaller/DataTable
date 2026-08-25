local GearItemHiddenChannel, Super = System.NewClass("GearItemHiddenChannel", GearItemBase)

function GearItemHiddenChannel:ctor()
  Super.ctor(self)
end

function GearItemHiddenChannel:OnTriggerChild(svrData)
  self:OpenEventPanel(svrData)
end

function GearItemHiddenChannel:OnLoad()
  Super.OnLoad(self)
  self.spriteRender = self.go:GetComponent(typeof(CS.UnityEngine.MeshRenderer))
  self.spriteRender.enabled = false
end

return GearItemHiddenChannel
