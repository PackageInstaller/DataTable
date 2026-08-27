local UINOasisParticleItem = class("UINOasisParticleItem", UIBaseNode)
local base = UIBaseNode
local cs_Material = CS.UnityEngine.Material

function UINOasisParticleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.onParticlOver = BindCallback(self, self.OnParticlOver)
  self.ui.resParticleSys.onAllOver = self.onParticlOver
end

function UINOasisParticleItem:InitParticleItem(resId, resUiPos, targetPos, onResFlyAniOver, num)
  if targetPos == nil then
    return
  end
  self.targetPos = targetPos
  self.onResFlyAniOver = onResFlyAniOver
  self:SetResItemPic(resId)
  self:UpdateRootPos(resUiPos)
  self.ui.resParticleSys:InitOasisResItemParticle(targetPos, num)
  self.ui.resParticleSys:ParticlePlay()
end

function UINOasisParticleItem:UpdateRootPos(resUiPos)
  local anchorPos = UIManager:World2UIPosition(resUiPos)
  self.transform.anchoredPosition = anchorPos
end

function UINOasisParticleItem:SetResItemPic(resId)
  local cfg = ConfigData.item[resId]
  if cfg == nil then
    return
  end
  local sprite = CRH:GetSprite(cfg.icon)
  self.ui.resParticleSys:SetParticleMatarailBySprite(sprite)
end

function UINOasisParticleItem:OnParticlOver()
  self.ui.resParticleSys:ParticleReset()
  if self.onResFlyAniOver ~= nil then
    self.onResFlyAniOver(self)
  else
    self:Hide()
  end
end

function UINOasisParticleItem:OnDelete()
  self.ui.resParticleSys:ParticleReset()
  base.OnDelete(self)
end

return UINOasisParticleItem
