local UINEpResFlyAniItem = class("UINEpResFlyAniItem", UIBaseNode)

function UINEpResFlyAniItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.resParticleSys.onAllOver = BindCallback(self, self.OnParticlOver)
end

function UINEpResFlyAniItem:InitResFlyAniItem(resId, resUiPos, targetPos, onResFlyOver, count)
  self.targetPos = targetPos
  self.onResFlyOver = onResFlyOver
  self:SetResItemPic(resId)
  self:UpdateRootPos(resUiPos)
  if targetPos ~= nil then
    self.ui.resParticleSys:InitOasisResItemParticle(targetPos, count)
    self.ui.resParticleSys:ParticlePlay()
  end
end

function UINEpResFlyAniItem:UpdateRootPos(resUiPos)
  self.transform.localPosition = resUiPos
end

function UINEpResFlyAniItem:SetResItemPic(resId)
  local cfg = ConfigData.item[resId]
  if cfg == nil then
    return
  end
  local sprite = CRH:GetSpriteByItemConfig(cfg)
  self.ui.resParticleSys:SetParticleMatarailBySprite(sprite)
end

function UINEpResFlyAniItem:OnParticlOver()
  self.ui.resParticleSys:ParticleReset()
  self.onResFlyOver(self)
end

return UINEpResFlyAniItem
