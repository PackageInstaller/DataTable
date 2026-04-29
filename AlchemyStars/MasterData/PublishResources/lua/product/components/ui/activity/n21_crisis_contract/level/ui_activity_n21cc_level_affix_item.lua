_class("UIActivityN21CCLevelAffixItem", UICustomWidget)
UIActivityN21CCLevelAffixItem = UIActivityN21CCLevelAffixItem

function UIActivityN21CCLevelAffixItem:OnShow()
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._mask = self:GetGameObject("Mask")
  self._unSelcted = self:GetGameObject("UnSelcted")
  self._selected = self:GetGameObject("Selected")
  self._selectScoreBg = self:GetGameObject("SelectScoreBg")
  self._unSelectScoreBg = self:GetGameObject("UnSelectScoreBg")
  self._lockScoreBg = self:GetGameObject("LockScoreBg")
  self._selectedBg = self:GetGameObject("SelectedBg")
  self._lock = self:GetGameObject("Lock")
  self._go = self:GetGameObject()
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._btn = self:GetUIComponent("CanvasGroup", "Btn")
  self:AttachEvent(GameEventType.N21CCClearAllSelectAffix, self.RefreshSelectStatus)
end

function UIActivityN21CCLevelAffixItem:OnHide()
  self:DetachEvent(GameEventType.N21CCClearAllSelectAffix, self.RefreshSelectStatus)
end

function UIActivityN21CCLevelAffixItem:Refresh(affixData, isOpen, playAnim, callback)
  self._affixData = affixData
  if affixData == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._callback = callback
  self._isOpen = isOpen
  self:RefreshUI()
  if not playAnim then
    self._anim:Play("UIActivityN21CCLevelAffixItem")
  end
end

function UIActivityN21CCLevelAffixItem:RefreshSelectStatus()
  if self._affixData == nil then
    return
  end
  self._mask:SetActive(false)
  self._unSelcted:SetActive(false)
  self._selected:SetActive(false)
  self._selectScoreBg:SetActive(false)
  self._unSelectScoreBg:SetActive(false)
  self._lockScoreBg:SetActive(false)
  self._selectedBg:SetActive(false)
  self._lock:SetActive(false)
  local isSelected = self._affixData:IsSelected()
  if not self._isOpen then
    self._mask:SetActive(true)
    self._lock:SetActive(true)
    self._lockScoreBg:SetActive(true)
    self._nameLabel.color = Color(0.25882352941176473, 0.25882352941176473, 0.24705882352941178, 1)
  elseif isSelected then
    self._unSelcted:SetActive(true)
    self._selected:SetActive(true)
    self._selectScoreBg:SetActive(true)
    self._selectedBg:SetActive(true)
    self._nameLabel.color = Color(0.9882352941176471, 0.9882352941176471, 0.9882352941176471, 1)
  else
    local isGroupSelected = false
    local affixGroupData = self._affixData:GetAffixGroupData()
    local affixDatas = affixGroupData:GetAffixDatas()
    for i = 1, #affixDatas do
      if affixDatas[i]:IsSelected() then
        isGroupSelected = true
        break
      end
    end
    self._unSelcted:SetActive(true)
    self._nameLabel.color = Color(0.25882352941176473, 0.25882352941176473, 0.24705882352941178, 1)
    if isGroupSelected then
      self._selectScoreBg:SetActive(true)
      self._mask:SetActive(true)
    else
      self._unSelectScoreBg:SetActive(true)
    end
  end
end

function UIActivityN21CCLevelAffixItem:RefreshData(isOpen)
  self._isOpen = isOpen
  self:RefreshUI()
end

function UIActivityN21CCLevelAffixItem:RefreshUI()
  if not self._affixData then
    return
  end
  self._nameLabel:SetText(self._affixData:GetDes())
  local scoreStr = ""
  local score = self._affixData:GetScroe()
  if 0 <= score then
    scoreStr = "<color=#ffbf14>+" .. score .. "</color>"
  else
    scoreStr = "<color=#b3f12d>" .. score .. "</color>"
  end
  self._scoreLabel:SetText(scoreStr)
  self:RefreshSelectStatus()
end

function UIActivityN21CCLevelAffixItem:BtnOnClick()
  if not self._isOpen then
    ToastManager.ShowToast(StringTable.Get("str_n20_crisis_contract_affix_lock_tips"))
    return
  end
  if self._callback then
    self._callback(self._affixData)
  end
end

function UIActivityN21CCLevelAffixItem:PlayAnim()
  self._anim:Play("UIActivityN21CCLevelAffixItem")
end
