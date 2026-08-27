local UINOasisParticle = class("UINOasisParticle", UIBaseNode)
local UINOasisParticleItem = require("Game.Oasis.UI.Particle.UINOasisParticleItem")
local base = UIBaseNode

function UINOasisParticle:ctor(oasisMain)
  self.oasisMain = oasisMain
end

function UINOasisParticle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.particlePool = UIItemPool.New(UINOasisParticleItem, self.ui.particleItem)
  self.ui.particleItem:SetActive(false)
  self.parItemDic = {}
  self.onResFlyAniOver = BindCallback(self, self.OnResFlyAniOver)
end

function UINOasisParticle:InitOasisParticle(oasisCtrl, topResUIPosDic, selBuildItems, resProgressDic)
  self.oasisCtrl = oasisCtrl
  self.particlePool:HideAll()
  for buildId, buildItem in pairs(selBuildItems) do
    local resId = buildItem:GetResItemId()
    local resUiPos = buildItem:GetUIResPos()
    local targetPos = topResUIPosDic[resId]
    if targetPos ~= nil then
      local progress = resProgressDic[buildId] or 1
      local num = math.max(math.ceil(progress * 8), 1)
      local particleItem = self.particlePool:GetOne()
      particleItem:InitParticleItem(resId, resUiPos, targetPos, self.onResFlyAniOver, num)
      self.parItemDic[buildId] = particleItem
      self:UpdateOasisResPaticlePos(buildId)
    end
  end
end

function UINOasisParticle:UpdateOasisResPaticlePosAll()
  for buildId, v in pairs(self.parItemDic) do
    self:UpdateOasisResPaticlePos(buildId)
  end
end

function UINOasisParticle:UpdateOasisResPaticlePos(buildId)
  local parItem = self.parItemDic[buildId]
  local buildItem = self.oasisCtrl:GetOasisBuildItemById(buildId)
  if parItem ~= nil and buildItem ~= nil then
    local resUiPos = buildItem:GetUIResPos()
    parItem:UpdateRootPos(resUiPos)
  end
end

function UINOasisParticle:OnResFlyAniOver(item)
  self.particlePool:HideOne(item)
end

function UINOasisParticle:OnDelete()
  self.particlePool:DeleteAll()
  base.OnDelete(self)
end

return UINOasisParticle
