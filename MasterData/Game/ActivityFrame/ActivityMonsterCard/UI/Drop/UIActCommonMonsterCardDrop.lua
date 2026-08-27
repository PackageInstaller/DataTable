local base = UIBaseWindow
local UIActCommonMonsterCardDrop = class("UIActCommonMonsterCardDrop", base)
local eActMonsterCardEnum = require("Game.ActivityFrame.ActivityMonsterCard.eActMonsterCardEnum")
local UINActCommonMonsterCardDropGroupItem = require("Game.ActivityFrame.ActivityMonsterCard.UI.Drop.UINActCommonMonsterCardDropGroupItem")

function UIActCommonMonsterCardDrop:OnInit()
  UIUtil.SetTopStatus(self, self.Delete)
  UIUtil.AddButtonListener(self.ui.Btn_Close, self, self._OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickBack)
  UIUtil.AddButtonListener(self.ui.Background, self, self._OnClickBack)
  self.rewardItemPool = UIItemPool.New(UINActCommonMonsterCardDropGroupItem, self.ui.ItemGroup, false)
end

function UIActCommonMonsterCardDrop:InitActCommonMonsterCardDrop(actFrameId, dropMonCardDataList)
  self.dropMonCardDataList = dropMonCardDataList
  local cardDicCfg = ConfigData.activity_monster_card_card[actFrameId]
  local diffTypeListDic = {}
  for _, data in ipairs(self.dropMonCardDataList) do
    local itemCfg = data.itemCfg
    local monCardId = itemCfg.id
    local cardCfg = cardDicCfg[monCardId]
    if cardCfg == nil then
      error("not have monster card cfg with id:" .. tostring(monCardId))
    else
      local typeId = cardCfg.card_type_id
      if diffTypeListDic[typeId] == nil then
        diffTypeListDic[typeId] = {}
      end
      table.insert(diffTypeListDic[typeId], data)
    end
  end
  self.rewardItemPool:HideAll()
  for _, typeId in ipairs(eActMonsterCardEnum.cardTypeOredr) do
    if diffTypeListDic[typeId] ~= nil then
      local itemGroup = self.rewardItemPool:GetOne()
      itemGroup:InitUINActCommonMonsterCardDropGroupItem(typeId, diffTypeListDic[typeId])
    end
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.Rect)
end

function UIActCommonMonsterCardDrop:_OnClickBack()
  UIUtil.OnClickBackByUiTab(self)
end

function UIActCommonMonsterCardDrop:OnDelete()
  base.OnDelete(self)
end

return UIActCommonMonsterCardDrop
