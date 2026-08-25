local TrinketEquipViewType = CommonDefine.TrinketEquipViewType
local TRINKET_SLOT_COUNT = CommonDefine.MaxEquipTrinketsNum
local CompTrinketEquipPartSelect, Super = NewViewComponent("CompTrinketEquipPartSelect")

function CompTrinketEquipPartSelect:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Team_Panel_Trinket_EquipResource(uiNode)
  self.model = TeamTrinketModel.Instance
end

function CompTrinketEquipPartSelect:OnEnterComponent()
  self:_InitTrinketList()
end

function CompTrinketEquipPartSelect:_InitTrinketList()
  local compTrinketEquipListData = {
    page = TrinketEquipViewType.PartSelect
  }
  self:AddViewComponentOnce(self.ui.UI_Team_Item_Suit_Bookmark, CompTrinketEquipList, compTrinketEquipListData)
  self.ui.Btn_Recommend:SetActive(true)
  self:AddButtonClickListener(self.ui.Btn_Recommend, System.fn(self, self._Btn_Recommend))
end

function CompTrinketEquipPartSelect:_Btn_Recommend_Click()
  local freeSlots = {}
  for i = 1, TRINKET_SLOT_COUNT do
    local trinket = self.model.selectTrinketDatas[i]
    if not trinket then
      table.insert(freeSlots, i)
    end
  end
  if 0 == #freeSlots then
    Alert.Show(10638)
    return
  end
  local hasFreeTrinkets = false
  for _, pos in ipairs(freeSlots) do
    local trinketUids = self.model.trinketShowList
    for _, uid in ipairs(trinketUids) do
      local weaponedAwaker = self.model:GetTrinketWeaponedAwakerTid(uid)
      if 0 == weaponedAwaker then
        hasFreeTrinkets = true
        break
      end
    end
  end
  if not hasFreeTrinkets then
    Alert.Show(10637)
    return
  end
  local awakerTid = self.model.selectAwaker
  self.trinketModel:EquipRecommendTrinket(awakerTid)
end

function CompTrinketEquipPartSelect:OnExitComponent()
  Super.OnExitComponent(self)
end

return CompTrinketEquipPartSelect
