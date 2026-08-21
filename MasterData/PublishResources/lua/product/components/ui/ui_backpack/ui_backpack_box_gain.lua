_class("UIBackPackBoxGain", UIController)
UIBackPackBoxGain = UIBackPackBoxGain

function UIBackPackBoxGain:Constructor()
end

function UIBackPackBoxGain:Dispose()
end

function UIBackPackBoxGain:OnShow(uiParams)
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self._txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self._giftId = uiParams[1]
  self._count = uiParams[2]
  self._item = uiParams[3]
  self._index = uiParams[4]
  local tplId = self._item:GetTplId()
  self.uiItem:SetData({
    icon = self._item:GetIcon(),
    quality = self._item:GetColor(),
    text1 = HelperProxy:GetInstance():FormatItemCount(self._item:GetCount() * self._count),
    itemId = tplId,
    showNew = false
  })
  self._txtName:SetText(self._item:GetName())
  local count = self:GetModule(ItemModule):GetItemCount(tplId)
  self._txtCount:SetText(StringTable.Get("str_item_public_owned") .. HelperProxy:GetInstance():FormatItemCount(count))
  self._txtDesc:SetText(self._item:GetDesc())
end

function UIBackPackBoxGain:OnHide()
end

function UIBackPackBoxGain:bgOnClick()
  self:CloseDialog()
end

function UIBackPackBoxGain:btnGainOnClick()
  self:StartTask(function(TT)
    local res, msg = self:GetModule(ItemModule):RequestChooseGift(TT, self._giftId, self._index, self._count)
    if res:GetSucc() then
      local ra = RoleAsset:New()
      ra.assetid = self._item:GetTplId()
      ra.count = self._item:GetCount() * self._count
      self:ShowDialog("UIGetItemController", {ra})
      GameGlobal.EventDispatcher():Dispatch(GameEventType.CloseUIBackPackBox)
      self:CloseDialog()
    else
      Log.fatal("### fail")
    end
  end, self)
end
