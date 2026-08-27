local base = UIBaseNode
local UIEpHeroRoughInfo = class("UIEpHeroRoughInfo", base)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ShowChipMaxCount = 3

function UIEpHeroRoughInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.propGlobalItem:SetActive(false)
  self.chipItemPool = UIItemPool.New(UINChipItem, self.ui.propGlobalItem)
end

function UIEpHeroRoughInfo:InitRoughInfo(dynHero, resloader)
  self.dynHero = dynHero
  resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(dynHero:GetResPicName()), function(texture)
    if self.dynHero ~= dynHero then
      return
    end
    self.ui.img_Pic.texture = texture
  end)
  self:RefreshHeroInfo()
end

function UIEpHeroRoughInfo:RefreshHeroInfo()
  self.ui.img_HpFill.fillAmount = self.dynHero.hpPer / ExplorationEnum.eHeroHpPercent
end

function UIEpHeroRoughInfo:RefreshHeroChip()
  local ownedChips = self.dynHero:GetOwnedChips()
  local sortTab = {}
  for k, v in pairs(ownedChips) do
    table.insert(sortTab, k)
  end
  table.sort(sortTab, function(a, b)
    return a:GetQuality() < b:GetQuality()
  end)
  local maxCount = #sortTab > ShowChipMaxCount and ShowChipMaxCount or #sortTab
  self.chipItemPool:HideAll()
  for i = 1, maxCount do
    local chipData = sortTab[i]
    local chipItem = self.chipItemPool:GetOne()
    chipItem:InitChipItem(chipData, true, nil)
    chipItem:BindDefaultClickEvent()
  end
end

function UIEpHeroRoughInfo:OnDelete()
  self.chipItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIEpHeroRoughInfo
