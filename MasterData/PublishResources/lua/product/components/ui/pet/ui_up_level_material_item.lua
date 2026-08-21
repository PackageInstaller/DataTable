_class("UIUpLevelMaterialItem", UICustomWidget)
UIUpLevelMaterialItem = UIUpLevelMaterialItem

function UIUpLevelMaterialItem:Constructor()
  self._perSecondCout = 2
  self._perNextSecondCout = 5
end

function UIUpLevelMaterialItem:OnShow(uiParams)
  self._itemInfo = nil
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.PetLevelUpFast)
end

function UIUpLevelMaterialItem:OnHide()
end

function UIUpLevelMaterialItem:SetData(itemInfo, petElement, consumInfo, tItemIndex, maxCount, parentGo)
  self._itemInfo = itemInfo
  if itemInfo == nil then
    self.uiItem:SetData({
      useNum = 0,
      exp = "",
      icon = "",
      quality = 0,
      text1 = ""
    })
    self.uiItem:Select(false)
    self.uiItem:SetBtnImage(false)
    return
  end
  local exp = ""
  local icon = ""
  local quality = 0
  local text1 = ""
  self._useNum = 0
  local itemId = self._itemInfo.m_template_data.ID
  self._consumInfo = consumInfo
  self._maxCount = maxCount
  text1 = HelperProxy:GetInstance():FormatItemCount(itemInfo.m_data.count)
  local cfg = Cfg.cfg_item[self._itemInfo.m_template_data.ID]
  if cfg then
    icon = cfg.Icon
    quality = cfg.Color
  end
  self._itemIndex = tItemIndex
  self._useNum = self._consumInfo and self._consumInfo.count or 0
  local cfg_ite_type = Cfg.cfg_item_pet_exp[self._itemInfo.m_template_data.ID]
  if cfg_ite_type and cfg_ite_type.Element == petElement then
    local v = "+" .. Cfg.cfg_global.ElementAddExp.IntValue .. "%"
    exp = v
  end
  self.uiItem:SetData({
    exp = exp,
    icon = icon,
    quality = quality,
    text1 = text1,
    useNum = self._useNum,
    itemId = itemId,
    changePos = true,
    isUp = true
  })
  self.uiItem:SetBtnImage(true)
  self.uiItem:SetClickCallBack(function()
    Log.fatal("UIUpLevelMaterialItem callback")
    local deltaPosition = self.uiItem._transform.position - parentGo.transform.position
    local asset = RoleAsset:New()
    asset.assetid = self._itemInfo.m_template_data.ID
    self:ShowDialog("UICommonItemInfo", asset, deltaPosition)
  end)
end

function UIUpLevelMaterialItem:ShowUpAnim(changePos, isUp)
  self.uiItem:SetData({changePos = changePos, isUp = isUp})
end
