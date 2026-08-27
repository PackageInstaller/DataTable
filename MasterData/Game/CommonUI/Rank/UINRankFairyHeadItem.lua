local base = UIBaseNode
local UINRankFairyHeadItem = class("UINRankFairyHeadItem", base)
local UINFairyHeadItem = require("Game.Fairy.UI.Common.UINFairyHeadItem")

function UINRankFairyHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._showHeadQuality = true
end

function UINRankFairyHeadItem:SetRankFairyHeadItemQualityShow(isShow)
  self._showHeadQuality = isShow
  if self._fairyItem then
    self._fairyItem:SetFairyHeadItemQualityShow(self._showHeadQuality)
  end
end

function UINRankFairyHeadItem:InitRankFairyHeadItem(fairyRankMsg, showLv, resLoader)
  if fairyRankMsg == nil then
    self.ui.emptyBottom:SetActive(true)
    self.ui.fairyHeadItem:SetActive(false)
    return
  end
  self.ui.emptyBottom:SetActive(false)
  self.ui.fairyHeadItem:SetActive(true)
  if self._fairyItem == nil then
    self._fairyItem = UINFairyHeadItem.New()
    self._fairyItem:Init(self.ui.fairyHeadItem)
    self._fairyItem:SetFairyHeadItemLvShow(showLv)
    self._fairyItem:SetFairyHeadItemQualityShow(self._showHeadQuality)
  end
  local fairyMsg = {
    base = {
      uid = 1,
      dataId = fairyRankMsg.id,
      level = fairyRankMsg.level,
      exp = 0,
      rank = fairyRankMsg.rank,
      name = nil,
      favor = false
    },
    skill = {
      data = {}
    }
  }
  local num = 0
  for k, v in pairs(fairyRankMsg.skill) do
    num = num + 1
    table.insert(fairyMsg.skill.data, {
      id = k,
      grades = v,
      slot = num
    })
  end
  local FairyData = require("Game.Fairy.Data.FairyData")
  local fairyData = FairyData.GenFairyData(fairyMsg)
  self._fairyItem:InitFairyHeadItem(fairyData, resLoader)
end

function UINRankFairyHeadItem:OnDelete()
  base.OnDelete(self)
end

return UINRankFairyHeadItem
