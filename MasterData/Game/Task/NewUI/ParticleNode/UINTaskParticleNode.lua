local UINTaskParticleNode = class("UINTaskParticleNode", UIBaseNode)
local base = UIBaseNode
local UINTaskLivelyParticleItem = require("Game.Task.NewUI.ParticleNode.UINTaskLivelyParticleItem")

function UINTaskParticleNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.particleItem:SetActive(false)
  self.particlePool = UIItemPool.New(UINTaskLivelyParticleItem, self.ui.particleItem)
  self._OnResFlyAniOverFunc = BindCallback(self, self._OnResFlyAniOver)
end

function UINTaskParticleNode:HideTaskParticle()
  self.particlePool:HideAll()
end

function UINTaskParticleNode:FlyTaskLively(startPos, targetPos)
  local resflyAni = self.particlePool:GetOne()
  resflyAni:InitTaskLivelyParticleItem(startPos, targetPos, self._OnResFlyAniOverFunc)
end

function UINTaskParticleNode:_OnResFlyAniOver(item)
  self.particlePool:HideOne(item)
end

function UINTaskParticleNode:OnDelete()
  self.particlePool:DeleteAll()
  base.OnDelete(self)
end

return UINTaskParticleNode
