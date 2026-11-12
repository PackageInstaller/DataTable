local OptionUpdateChooseCtrl = class("OptionUpdateChooseCtrl", BaseCtrl)
OptionUpdateChooseCtrl._mapNodeConfig = {
  btnChoose = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Choose"
  },
  txtChoose = {nCount = 3, sComponentName = "TMP_Text"},
  Checkmark = {nCount = 3, sComponentName = "Animator"},
  Mask = {nCount = 3},
  Choose = {nCount = 3},
  txtOptionTitle = {sComponentName = "TMP_Text"}
}
OptionUpdateChooseCtrl._mapEventConfig = {}

function OptionUpdateChooseCtrl:SetText(s1, s2, s3, sTitle)
  NovaAPI.SetTMPText(self._mapNode.txtOptionTitle, sTitle)
  NovaAPI.SetTMPText(self._mapNode.txtChoose[1], s1)
  NovaAPI.SetTMPText(self._mapNode.txtChoose[2], s2)
  NovaAPI.SetTMPText(self._mapNode.txtChoose[3], s3)
end

function OptionUpdateChooseCtrl:Init(callback, nIndex, nCount)
  self.nIndex = nIndex
  self.callback = callback
  if nCount == nil then
    nCount = 3
  end
  for i = 1, 3 do
    if i > nCount then
      self._mapNode.Choose[i].gameObject:SetActive(false)
    else
      self._mapNode.Choose[i].gameObject:SetActive(true)
      if i == self.nIndex then
        self._mapNode.Checkmark[i]:Play("checkmark_in", -1, 1)
      else
        self._mapNode.Checkmark[i]:Play("checkmark_out", -1, 1)
      end
    end
  end
end

function OptionUpdateChooseCtrl:SetGray(tbGrayIndex, sTip)
  self.tbGrayIndex = tbGrayIndex
  self.sTip = sTip
  for i = 1, 3 do
    self._mapNode.Mask[i]:SetActive(tbGrayIndex and tbGrayIndex[i])
  end
end

function OptionUpdateChooseCtrl:Awake()
end

function OptionUpdateChooseCtrl:OnBtnClick_Choose(btn, index)
  if self.nIndex == index then
    return
  end
  if self.tbGrayIndex and self.tbGrayIndex[index] then
    EventManager.Hit(EventId.OpenMessageBox, self.sTip or "")
    return
  end
  
  local function suc()
    self._mapNode.Checkmark[self.nIndex]:SetTrigger("PlayCheckmarkHide")
    self._mapNode.Checkmark[index]:SetTrigger("PlayCheckmarkShow")
    self.nIndex = index
  end
  
  self.callback(index, suc)
end

return OptionUpdateChooseCtrl
