_class("UISakuraDrawShopTipsController", UIController)
UISakuraDrawShopTipsController = UISakuraDrawShopTipsController

function UISakuraDrawShopTipsController:Constructor()
  self._outAnimName = "uieff_UISakuraDrawShopTipsController_out"
  self._outAnimTime = 433
end

function UISakuraDrawShopTipsController:OnShow(uiParams)
  self._data = uiParams[1]
  self:_GetComponent()
  self:_OnValue()
end

function UISakuraDrawShopTipsController:_GetComponent()
  self._descripution = self:GetUIComponent("UILocalizationText", "Descripution")
  self._item = self:GetUIComponent("UISelectObjectPath", "Item")
  self._contentAnim = self:GetUIComponent("Animation", "Content")
  self._itemInfoName = self:GetUIComponent("UILocalizationText", "Name")
  self._itemInfoCount = self:GetUIComponent("UILocalizationText", "OwnCount")
end

function UISakuraDrawShopTipsController:_OnValue()
  if self._data ~= nil then
    local itemId = self._data:GetItemId()
    local config = Cfg.cfg_item[itemId]
    if config ~= nil then
      self._itemInfoName:SetText(StringTable.Get(config.Name))
      self._descripution:SetText(StringTable.Get(config.Intro))
    end
    local roleModule = GameGlobal.GetModule(RoleModule)
    local c = roleModule:GetAssetCount(itemId)
    self._itemInfoCount:SetText(StringTable.Get("str_item_public_owned") .. self:_FormatItemCount(c))
    self._itemWidget = self._item:SpawnObject("UISakuraDrawShopAwardCell")
    self._itemWidget:InitData(self._data, nil)
  end
end

function UISakuraDrawShopTipsController:bgOnClick()
  self:CloseDialogWithAnim()
end

function UISakuraDrawShopTipsController:CloseDialogWithAnim()
  if self._contentAnim then
    self:Lock("UISakuraDrawShopTipsController:CloseDialogWithAnim")
    if self._contentAnim then
      self._contentAnim:Play(self._outAnimName)
    end
    self:StartTask(function(TT)
      YIELD(TT, self._outAnimTime)
      self:UnLock("UISakuraDrawShopTipsController:CloseDialogWithAnim")
      self:CloseDialog()
    end, self)
  end
end

function UISakuraDrawShopTipsController:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end
