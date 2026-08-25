local CollectTrinketDetailCom, Super = NewViewComponent("CollectTrinketDetailCom")

function CollectTrinketDetailCom:ctor(uiNode, view, trinketCollectTid)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Panel_EquipDetailResource(uiNode)
  self:_InitViewData(trinketCollectTid)
end

function CollectTrinketDetailCom:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:_RefreshView()
end

function CollectTrinketDetailCom:_InitViewData(trinketCollectTid)
  self._trinketCollectTid = trinketCollectTid
end

function CollectTrinketDetailCom:_RefreshView()
  self:SetActive(self.ui.Item_Weapon, false)
  self:SetActive(self.ui.Item_Trinket, true)
  local collectCfg = CollectionHallCfgUtils.GetCfg(self._trinketCollectTid)
  local trinketItemTidList = collectCfg.UnlockCondPara
  for i = 1, #trinketItemTidList do
    local itemTid = trinketItemTidList[i]
    local itemIcon = ItemCfgUtils.GetCfgField("Icon", itemTid)
    self:SetImage(self.ui["Image_Parts_" .. i], itemIcon)
  end
  local trinketSuitCfg = ItemCfgUtils.GetTrinketSuitCfg(trinketItemTidList[1])
  self:SetImage(self.ui.Image_Finish, trinketSuitCfg.Icon)
  self:SetText(self.ui.Text_Name, LT.Text(collectCfg.Title))
  self:SetText(self.ui.Text_Desc, LT.Text(collectCfg.Desc))
  StrUtils.SetPreferredHeight(self.ui.Text_Desc, 10)
end

return CollectTrinketDetailCom
