local UIBattleResultExtra = class("UIBattleResultExtra", UIBaseWindow)
local base = UIBaseWindow
local UINBattleResultExtraItem = require("Game.BattleDungeon.UI.UINBattleResultExtraItem")

function UIBattleResultExtra:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnCloseClicked)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnCloseClicked)
  self.rewardItemDic = {}
  self.ui.rewardScroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.rewardScroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
end

function UIBattleResultExtra:InitBattleResultExtra(rewardDic)
  local ids = {}
  for id, num in pairs(rewardDic) do
    table.insert(ids, id)
  end
  table.sort(ids)
  self.__rewardDic = rewardDic
  self.__rewardIds = ids
  self.ui.rewardScroll.totalCount = #ids
  self.ui.rewardScroll:RefillCells()
end

function UIBattleResultExtra:__OnNewItem(go)
  local rewardItem = UINBattleResultExtraItem.New()
  rewardItem:Init(go)
  self.rewardItemDic[go] = rewardItem
end

function UIBattleResultExtra:__OnChangeItem(go, index)
  local rewardItem = self.rewardItemDic[go]
  if rewardItem == nil then
    error("Can't find rewardItem by gameObject")
    return
  end
  local rewardId = self.__rewardIds[index + 1]
  if rewardId == nil then
    return
  end
  local itemCfg = ConfigData.item[rewardId]
  local num = self.__rewardDic[rewardId]
  rewardItem:InitBattleExtraReward(itemCfg, num, nil)
end

function UIBattleResultExtra:OnCloseClicked()
  self:Delete()
end

function UIBattleResultExtra:OnDelete()
  base.OnDelete(self)
end

return UIBattleResultExtra
