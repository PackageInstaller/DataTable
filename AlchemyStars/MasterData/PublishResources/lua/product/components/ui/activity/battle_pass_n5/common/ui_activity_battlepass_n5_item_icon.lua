_class("UIActivityBattlePassN5ItemIcon", UICustomWidget)
UIActivityBattlePassN5ItemIcon = UIActivityBattlePassN5ItemIcon

function UIActivityBattlePassN5ItemIcon:OnShow(uiParams)
  self._anim = self:GetUIComponent("Animation", "animation")
  self._root = self:GetGameObject("animation")
  self._lvIcon = self:GetGameObject("lvIcon")
end

function UIActivityBattlePassN5ItemIcon:OnHide()
  self._anim = nil
  self._root = nil
  self._cg = nil
  self._index = nil
  self._callback = nil
end

function UIActivityBattlePassN5ItemIcon:SetData_LvIcon(index, lv)
  self._lvIcon:SetActive(true)
  local txt = self:GetUIComponent("UILocalizationText", "txt")
  local formatStr = "+Lv.%s"
  txt:SetText(lv)
end

function UIActivityBattlePassN5ItemIcon:SetData(index, roleAsset, callback, scale)
  self._lvIcon:SetActive(false)
  self._scale = scale or UIItemScale.Level2
  self:_GetComponents()
  self._index = index
  self._roleAsset = roleAsset
  self._callback = callback
  local cfg_item = Cfg.cfg_item[self._roleAsset.assetid]
  if cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. self._roleAsset.assetid)
    return
  end
  self._cg = cfg_item.Icon
  self._colorEnum = cfg_item.Color
  self:_OnValue()
end

function UIActivityBattlePassN5ItemIcon:_GetComponents()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base, self._scale)
  self.uiItem:SetClickCallBack(function(go)
    self:bgOnClick(go)
  end)
end

function UIActivityBattlePassN5ItemIcon:_OnValue()
  local icon = self._cg
  local quality = self._colorEnum
  local text1 = self._roleAsset.count
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = self._roleAsset.assetid
  })
end

function UIActivityBattlePassN5ItemIcon:bgOnClick(go)
  if self._callback then
    self._callback(self._roleAsset.assetid, go.transform.position)
  end
end

function UIActivityBattlePassN5ItemIcon:PlayAnimationInSequence(index)
  if not self._anim then
    return
  end
  local stamp = index * 60
  self:StartTask(function(TT)
    self:_ResetAnimation()
    self._root:SetActive(false)
    YIELD(TT, stamp)
    if self._root then
      self._root:SetActive(true)
      self._anim:Play("UIeff_UIActivityBattlePassN5ItemIcon_in")
    end
  end, self)
end

function UIActivityBattlePassN5ItemIcon:_ResetAnimation()
  if not self._anim then
    return
  end
  local state = self._anim:get_Item("UIeff_UIActivityBattlePassN5ItemIcon_in")
  state.normalizedTime = 0
  self._anim:Stop()
end
