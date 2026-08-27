local UINFairyLtrPoolSkillRate = class("UINFairyLtrPoolSkillRate", UIBaseNode)
local base = UIBaseNode
local UINFairyLtrPoolSkillRateItem = require("Game.Lottery.UI.PoolDetail.FairySkillRate.UINFairyLtrPoolSkillRateItem")

function UINFairyLtrPoolSkillRate:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.rewardItemDic = {}
end

function UINFairyLtrPoolSkillRate:InitFairyLtrPoolSkillRate()
  self.skillRarityList = ConfigData.fairy_skill_weight
  self:_RefillScrollRect()
end

function UINFairyLtrPoolSkillRate:_RefillScrollRect()
  self.ui.scrollRect.totalCount = #self.skillRarityList
  self.ui.scrollRect:RefillCells()
end

function UINFairyLtrPoolSkillRate:__OnNewItem(go)
  local item = UINFairyLtrPoolSkillRateItem.New()
  item:Init(go)
  self.rewardItemDic[go] = item
end

function UINFairyLtrPoolSkillRate:__OnChangeItem(go, index)
  local item = self.rewardItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local skillRarityCfg = self.skillRarityList[index + 1]
  if skillRarityCfg == nil then
    error("Can't find rewardData by index, index = " .. tonumber(index))
  end
  item:InitFairyLtrPoolSkillRateItem(skillRarityCfg)
end

function UINFairyLtrPoolSkillRate:OnDelete()
  base.OnDelete(self)
end

return UINFairyLtrPoolSkillRate
