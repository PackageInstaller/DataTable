local OptionDynamicCtrl = class("OptionDynamicCtrl", BaseCtrl)
OptionDynamicCtrl._mapNodeConfig = {
  Choose = {},
  trChoose = {sComponentName = "Transform"},
  txtOptionTitle = {sComponentName = "TMP_Text"}
}
OptionDynamicCtrl._mapEventConfig = {}

function OptionDynamicCtrl:SetText(sTitle, tbChoose)
  NovaAPI.SetTMPText(self._mapNode.txtOptionTitle, sTitle)
  for i = 1, self.nCount do
    NovaAPI.SetTMPText(self.txtChoose[i], tbChoose[i])
  end
end

function OptionDynamicCtrl:Init(callback, nIndex, nCount, sConfirm, bIsVoLan)
  self.nIndex = nIndex
  self.callback = callback
  self.nCount = nCount
  self.sConfirm = sConfirm
  self.txtChoose = {}
  self.Checkmark = {}
  self.Mask = {}
  self.bIsVoLan = bIsVoLan == true
  delChildren(self._mapNode.trChoose)
  for i = 1, nCount do
    local goItemObj = instantiate(self._mapNode.Choose, self._mapNode.trChoose)
    goItemObj:SetActive(true)
    local txtChoose = goItemObj.transform:Find("btnChoose/txtChoose"):GetComponent("TMP_Text")
    local Checkmark = goItemObj.transform:Find("btnChoose/Background/Checkmark"):GetComponent("Animator")
    local Mask = goItemObj.transform:Find("btnChoose/Mask").gameObject
    table.insert(self.txtChoose, txtChoose)
    table.insert(self.Checkmark, Checkmark)
    table.insert(self.Mask, Mask)
    local btn = goItemObj.transform:Find("btnChoose"):GetComponent("UIButton")
    local func_Handler = ui_handler(self, self.OnBtnClick_Choose, goItemObj, i)
    btn.onClick:AddListener(func_Handler)
    if i == self.nIndex then
      Checkmark:Play("checkmark_in", -1, 1)
    else
      Checkmark:Play("checkmark_out", -1, 1)
    end
  end
end

function OptionDynamicCtrl:SetGray(tbGrayIndex, sTip)
  self.tbGrayIndex = tbGrayIndex
  self.sTip = sTip
  for i = 1, self.nCount do
    self.Mask[i]:SetActive(tbGrayIndex and tbGrayIndex[i])
  end
end

function OptionDynamicCtrl:OnBtnClick_Choose(btn, index)
  if self.nIndex == index then
    return
  end
  if self.tbGrayIndex and self.tbGrayIndex[index] then
    EventManager.Hit(EventId.OpenMessageBox, self.sTip or "")
    return
  end
  
  local function change()
    self.Checkmark[self.nIndex]:SetTrigger("PlayCheckmarkHide")
    self.Checkmark[index]:SetTrigger("PlayCheckmarkShow")
    self.nIndex = index
    self.callback(self.nIndex)
  end
  
  local function checkConfirm()
    if self.sConfirm then
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = self.sConfirm,
        callbackConfirm = function()
          change()
        end,
        bBlur = false
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    else
      change()
    end
  end
  
  if self.bIsVoLan == true then
    if index == 2 then
      checkConfirm()
    else
      change()
    end
  else
    checkConfirm()
  end
end

return OptionDynamicCtrl
