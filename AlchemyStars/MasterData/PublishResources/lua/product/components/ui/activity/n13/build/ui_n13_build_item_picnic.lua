_class("UIBuildBuildItemPicnic", UICustomWidget)
UIBuildBuildItemPicnic = UIBuildBuildItemPicnic

function UIBuildBuildItemPicnic:OnShow()
  self._go = self:GetGameObject("Go")
  self._maskPanel = self:GetUIComponent("RectTransform", "Mask")
  self._txtDebug = self:GetUIComponent("UILocalizationText", "_txtDebug")
end

function UIBuildBuildItemPicnic:SetData(buildManager, buildItemId, btnCallback)
  self._buildManager = buildManager
  self._buildItemId = buildItemId
  self._btnCallback = btnCallback
  self:Refresh()
end

function UIBuildBuildItemPicnic:Refresh()
  local show = self:CanShowBtn()
  self._go:SetActive(show)
  if not show then
    return
  end
  self:_SetPos(self._buildItemId)
  self:_SetBtn(self._buildItemId)
end

function UIBuildBuildItemPicnic:CanShowBtn()
  local show = self._buildManager:IsShow(self._buildItemId)
  local complete = self._buildManager:CheckPicnicStatusComplete(self._buildItemId)
  local lockTime = self._buildManager:CheckPicnicLockTime(self._buildItemId)
  local nextCfg = self._buildManager:CheckPicnicHaveNextCfg()
  local result = show and complete and lockTime and nextCfg
  if result then
    Log.debug("UIBuildBuildItemPicnic:CanShowBtn() result = true")
  else
    Log.debug("UIBuildBuildItemPicnic:CanShowBtn() result = " .. tostring(result), " show = " .. tostring(show), " complete = " .. tostring(complete), " lockTime = " .. tostring(lockTime), " nextCfg = " .. tostring(nextCfg))
  end
  return result
end

function UIBuildBuildItemPicnic:_CanPicnic()
  return self._buildManager:CheckCanPicnic(self._buildItemId)
end

function UIBuildBuildItemPicnic:_SetPos(buildItemId)
  self._go.transform.anchoredPosition = self._buildManager:GetWidgetPos(buildItemId)
  self._maskPanel.anchoredPosition = self._buildManager:GetWidgetDesPos(buildItemId)
end

function UIBuildBuildItemPicnic:_SetBtn(buildItemId)
  local str = UIActivityN13Helper.GetStrByStatus_Picnic(self._buildManager:GetName(buildItemId))
  if self._buildManager:CheckPicnicHaveStory() then
    str = str .. "(等待剧情)"
  elseif not self._buildManager:CheckPicnicLockTime(buildItemId) then
    str = str .. "(等待刷新)"
  elseif not self._buildManager:CheckPicnicHaveNextCfg() then
    str = str .. "(全部结束)"
  end
  self._txtDebug:SetText(str)
end

function UIBuildBuildItemPicnic:BtnOnClick()
  if not self:_CanPicnic() then
    if self._buildManager:CheckPicnicHaveStory() then
      ToastManager.ShowToast(StringTable.Get("str_n13_picnic_need_play_story"))
    end
    return
  end
  self._go:SetActive(false)
  if self._btnCallback then
    self._btnCallback()
  end
end
