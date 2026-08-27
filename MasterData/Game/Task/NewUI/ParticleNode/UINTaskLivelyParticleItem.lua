local UINTaskLivelyParticleItem = class("UINTaskLivelyParticleItem", UIBaseNode)
local base = UIBaseNode

function UINTaskLivelyParticleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.resParticleSys.onAllOver = BindCallback(self, self._OnParticlOver)
end

function UINTaskLivelyParticleItem:InitTaskLivelyParticleItem(startPos, tarPos, flyOverFunc)
  self.flyOverFunc = flyOverFunc
  self.transform.position = startPos
  self.ui.resParticleSys:InitOasisResItemParticle(tarPos, 8)
  self.ui.resParticleSys:ParticlePlay()
end

function UINTaskLivelyParticleItem:_OnParticlOver()
  self.ui.resParticleSys:ParticleReset()
  if self.flyOverFunc ~= nil then
    self.flyOverFunc(self)
  end
end

function UINTaskLivelyParticleItem:OnDelete()
  base.OnDelete(self)
end

return UINTaskLivelyParticleItem
