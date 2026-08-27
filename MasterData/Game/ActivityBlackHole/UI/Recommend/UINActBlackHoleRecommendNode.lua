local UINActBlackHoleRecommendNode = class("UINActBlackHoleRecommendNode", UIBaseNode)
local UINActBHRecommendNodeItem = require("Game.ActivityBlackHole.UI.Recommend.UINActBHRecommendNodeItem")
local base = UIBaseNode
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local CS_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder

function UINActBlackHoleRecommendNode:OnInit()
  base.OnInit(self)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINActBHRecommendNodeItem, self.ui.item, false)
end

function UINActBlackHoleRecommendNode:InitBHRecommendNode(actData)
  local tagIds = actData:GetBlackHoleTagList()
  self.itemPool:HideAll()
  for i, v in pairs(tagIds) do
    local item = self.itemPool:GetOne()
    item:InitBHRecommendNodeItem(ConfigData.activity_blackhole_tag[v])
  end
  CS_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.rect)
  local listWidth = self.ui.list.sizeDelta.x
  local rectWidth = self.ui.rect.sizeDelta.x
  if listWidth < rectWidth then
    self.recommendSeq = cs_DoTween.Sequence():SetLink(self.gameObject):AppendCallback(function()
      local pos = self.ui.rect.anchoredPosition
      pos.x = 0
      self.ui.rect.anchoredPosition = pos
    end):AppendInterval(1):Append(self.ui.rect:DOAnchorPosX(listWidth - rectWidth, 5)):SetLoops(-1)
  end
end

function UINActBlackHoleRecommendNode:OnDelete()
  base.OnDelete(self)
  self.itemPool:DeleteAll()
  if self.recommendSeq ~= nil then
    self.recommendSeq:DOKill()
    self.recommendSeq = nil
  end
end

return UINActBlackHoleRecommendNode
