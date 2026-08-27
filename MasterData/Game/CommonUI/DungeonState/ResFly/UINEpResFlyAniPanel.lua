local UINEpResFlyAniPanel = class("UINEpResFlyAniPanel", UIBaseNode)
local UINEpResFlyAniItem = require("Game.CommonUI.DungeonState.ResFly.UINEpResFlyAniItem")

function UINEpResFlyAniPanel:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.particlePool = UIItemPool.New(UINEpResFlyAniItem, self.ui.particleItem)
  self.ui.particleItem:SetActive(false)
  self.particlePool:HideAll()
  self.__OnResFlyAniOver = BindCallback(self, self.OnResFlyAniOver)
end

function UINEpResFlyAniPanel:StartNewResFlyAni(itemId, startPos, targetPos, count)
  local resflyAni = self.particlePool:GetOne()
  resflyAni:InitResFlyAniItem(itemId, startPos, targetPos, self.__OnResFlyAniOver, count)
end

function UINEpResFlyAniPanel:OnResFlyAniOver(item)
  self.particlePool:HideOne(item)
end

return UINEpResFlyAniPanel
