_class("UICurrencyMenu_Shop", UICustomWidget)
UICurrencyMenu_Shop = UICurrencyMenu_Shop

function UICurrencyMenu_Shop:Constructor()
  self.SortCurrencyId = {}
  local count = table.count(Cfg.cfg_top_tips({}))
  for id, cfg in pairs(Cfg.cfg_top_tips({})) do
    self.SortCurrencyId[id] = cfg.Sort
  end
end

function UICurrencyMenu_Shop:OnShow()
  self:AttachEvent(GameEventType.ShowHideTSFBtn, self.ShowHideTSFBtn)
  self._topTips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._topTipsInfo = self._topTips:SpawnObject("UITopTipsContext")
  self._panel = self:GetUIComponent("UISelectObjectPath", "panel")
  self._btnZJJSF = self:GetUIComponent("Button", "BtnZJJSF")
  self._btnTSF = self:GetUIComponent("Button", "BtnTSF")
  self._btnZJJSF.gameObject:SetActive(false)
  self._btnTSF.gameObject:SetActive(false)
end

function UICurrencyMenu_Shop:OnHide()
  self:DetachEvent(GameEventType.ShowHideTSFBtn, self.ShowHideTSFBtn)
end

function UICurrencyMenu_Shop:GetItems()
  return self.items
end

function UICurrencyMenu_Shop:GetItemByTypeId(typeId)
  for index, item in ipairs(self.items) do
    if item:GetTypeId() == typeId then
      return item
    end
  end
  return nil
end

function UICurrencyMenu_Shop:SetData(typeIds, hideAddBtn, notSort)
  if not typeIds then
    return
  end
  if notSort then
  else
    table.sort(typeIds, function(a, b)
      return self.SortCurrencyId[a] > self.SortCurrencyId[b]
    end)
  end
  local count = #typeIds
  self._panel:SpawnObjects("UICurrencyItem_Shop", count)
  self.items = self._panel:GetAllSpawnList()
  local index = 1
  for key, item in pairs(self.items) do
    local roleAssetId = typeIds[index]
    item:SetData(roleAssetId, function(id, go)
      self._topTipsInfo:SetData(id, go)
    end, hideAddBtn)
    if roleAssetId == RoleAssetID.RoleAssetPhyPoint then
      item:SetAddCallBack(function()
        self:ShowDialog("UIGetPhyPointController")
      end)
    end
    index = index + 1
  end
end

function UICurrencyMenu_Shop:ShowHideTSFBtn(isShow)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local isJapanZone = roleModule:IsJapanZone()
  if isJapanZone then
    self._btnZJJSF.gameObject:SetActive(isShow)
    self._btnTSF.gameObject:SetActive(isShow)
  else
    self._btnZJJSF.gameObject:SetActive(false)
    self._btnTSF.gameObject:SetActive(false)
  end
end

function UICurrencyMenu_Shop:BtnZJJSFOnClick()
  self:ShowDialog("UIPayLawContentController", 2)
end

function UICurrencyMenu_Shop:BtnTSFOnClick()
  self:ShowDialog("UIPayLawContentController", 1)
end
