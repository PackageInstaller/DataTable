local base = UIBaseNode
local UINDeliverySimulatorSelectRank = class("UINDeliverySimulatorSelectRank", base)
local UINDeliverySimulatorSelectRankItem = require("Game.ActivityDeliverySimulator.UI.Select.UINDeliverySimulatorSelectRankItem")
local cs_tweening = CS.DG.Tweening

function UINDeliverySimulatorSelectRank:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rankItemPool = UIItemPool.New(UINDeliverySimulatorSelectRankItem, self.ui.item, false)
end

function UINDeliverySimulatorSelectRank:InitDeliverySimulatorSelectRank(rankDataList, index)
  self.ui.tex_RankTitle:SetIndex(0, string.format("LEVEL.%02d", index))
  self.rankItemPool:HideAll()
  for id, data in pairs(rankDataList) do
    local item = self.rankItemPool:GetOne()
    item:InitDeliverySimulatorSelectRankItem(data, id)
  end
end

function UINDeliverySimulatorSelectRank:OnShow()
  local scale = self.ui.bottom.localScale
  scale.y = 0
  self.ui.bottom.localScale = scale
  if self.showRankSeq == nil then
    self.showRankSeq = cs_tweening.DOTween.Sequence()
    self.showRankSeq:AppendCallback(function()
      self.ui.infoBk.gameObject:SetActive(false)
    end):Append(self.ui.bottom:DOScaleY(1, 0.3)):AppendCallback(function()
      self.ui.infoBk.gameObject:SetActive(true)
    end):Insert(0.2, self.ui.infoBk.transform:DOAnchorPosY(self.ui.infoBk.transform.anchoredPosition.y - 50, 0.3):From()):Insert(0.2, self.ui.infoBk:DOFade(0, 0.3):From()):SetAutoKill(false)
  else
    self.showRankSeq:Restart()
  end
end

function UINDeliverySimulatorSelectRank:RealHideFunc()
  if self.hideRankSeq == nil then
    self.hideRankSeq = cs_tweening.DOTween.Sequence()
    self.hideRankSeq:AppendCallback(function()
      self.ui.infoBk.gameObject:SetActive(false)
    end):Append(self.ui.bottom:DOScaleY(0, 0.3)):AppendCallback(function()
      self:Hide()
    end):SetAutoKill(false)
  else
    self.hideRankSeq:Restart()
  end
end

function UINDeliverySimulatorSelectRank:OnDelete()
  self.rankItemPool:DeleteAll()
  if self.showRankSeq then
    self.showRankSeq:Kill()
    self.showRankSeq = nil
  end
  if self.hideRankSeq then
    self.hideRankSeq:Kill()
    self.hideRankSeq = nil
  end
end

return UINDeliverySimulatorSelectRank
