local UINRecommeFormationItem = class("UINRecommeFormationItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadWithStarItem = require("Game.CommonUI.Hero.UINHeroHeadWithStarItem")
local UINRankFairyHeadItem = require("Game.CommonUI.Rank.UINRankFairyHeadItem")
local CS_MessageCommon = CS.MessageCommon

function UINRecommeFormationItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.obj_HeroHead:SetActive(false)
  self.ui.obj_EmptyHero:SetActive(false)
  self.heroHeadPool = UIItemPool.New(UINHeroHeadWithStarItem, self.ui.obj_HeroHead)
  self.emptyIconList = {}
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickRecommeItem)
  self._fairyHead = UINRankFairyHeadItem.New()
  self._fairyHead:Init(self.ui.obj_FairyHead)
end

function UINRecommeFormationItem:InitRecommeItemNew(recommeCtr, data, recordInfo, resloader, callback)
  self.recommeCtr = recommeCtr
  self.data = data
  self.resloader = resloader
  self.itemClickCallback = callback
  self.index = data.rank
  local stageCount = recordInfo:GetRecommeMaxStageNum()
  self.heroHeadPool:HideAll()
  for i = 1, #self.emptyIconList do
    self.emptyIconList[i]:SetActive(false)
  end
  local emptyIndex = self:__RefreshHeroIcon(1, self.ui.mainTeam, 1, stageCount)
  self.ui.tex_Rank.text = string.format("%02d", data.rank)
  self.ui.tex_winCount.text = tostring(data.winCount)
  self.ui.tex_power.text = tostring(data.power)
  local fairyElem = self.data:GetRecomSingleFairyElem()
  self._fairyHead:SetRankFairyHeadItemQualityShow(false)
  self._fairyHead:InitRankFairyHeadItem(fairyElem, false, resloader)
  self._fairyHead.transform:SetAsLastSibling()
end

function UINRecommeFormationItem:__RefreshHeroIcon(emptyIndex, parentTr, startIndex, endIndex)
  for i = startIndex, endIndex do
    local recommanHeroInfo = self.data.recommanHeroList[i]
    if recommanHeroInfo ~= nil then
      local item = self.heroHeadPool:GetOne()
      local isHas = PlayerDataCenter.heroDic[recommanHeroInfo.basicId] ~= nil
      item:InitHeadByNotHaveData(recommanHeroInfo.basicId, isHas)
      item.gameObject.transform:SetParent(parentTr)
      item.gameObject.transform:SetAsLastSibling()
    else
      local emptyIcon
      if emptyIndex <= #self.emptyIconList then
        emptyIcon = self.emptyIconList[emptyIndex]
      else
        emptyIcon = self.ui.obj_EmptyHero:Instantiate()
        table.insert(self.emptyIconList, emptyIcon)
      end
      emptyIndex = emptyIndex + 1
      emptyIcon:SetActive(true)
      emptyIcon.transform:SetParent(parentTr)
      emptyIcon.transform:SetAsLastSibling()
    end
  end
  return emptyIndex
end

function UINRecommeFormationItem:OnClickRecommeItem()
  self.itemClickCallback(self.index)
end

return UINRecommeFormationItem
