local ThrowGiftItemSelectGridCtrl = class("ThrowGiftItemSelectGridCtrl", BaseCtrl)
ThrowGiftItemSelectGridCtrl._mapNodeConfig = {
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "ThrowGift_GetCard"
  },
  btnConfirm = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Confirm"
  },
  imgBgSelect = {},
  imgItemIcon = {sComponentName = "Image"},
  TMPItemName = {sComponentName = "TMP_Text"},
  TMPItemDesc = {sComponentName = "TMP_Text"},
  AnimRoot = {
    sNodeName = "AnimRootTop",
    sComponentName = "Animator"
  }
}
ThrowGiftItemSelectGridCtrl._mapEventConfig = {}
ThrowGiftItemSelectGridCtrl._mapRedDotConfig = {}

function ThrowGiftItemSelectGridCtrl:Awake()
end

function ThrowGiftItemSelectGridCtrl:FadeIn()
end

function ThrowGiftItemSelectGridCtrl:FadeOut()
end

function ThrowGiftItemSelectGridCtrl:OnEnable()
  self.Idx = 0
  self.animator = self.gameObject:GetComponent("Animator")
  self._mapNode.btnConfirm.interactable = false
end

function ThrowGiftItemSelectGridCtrl:OnDisable()
end

function ThrowGiftItemSelectGridCtrl:OnDestroy()
end

function ThrowGiftItemSelectGridCtrl:OnRelease()
end

function ThrowGiftItemSelectGridCtrl:Refresh(nItemId)
  self:SetDefault()
  local mapItemCfgData = ConfigTable.GetData("ThrowGiftItem", nItemId)
  if mapItemCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPItemName, mapItemCfgData.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPItemDesc, mapItemCfgData.Desc)
  self:SetPngSprite(self._mapNode.imgItemIcon, mapItemCfgData.Icon)
  self._mapNode.btnConfirm.interactable = false
end

function ThrowGiftItemSelectGridCtrl:SetSelect(bSelect)
  if bSelect then
    self._mapNode.AnimRoot:Play("btnItemSelect_in")
    self._mapNode.btnConfirm.interactable = true
  else
    self._mapNode.AnimRoot:Play("btnItemSelect_out")
    self._mapNode.btnConfirm.interactable = false
  end
  self._mapNode.imgBgSelect:SetActive(bSelect)
end

function ThrowGiftItemSelectGridCtrl:SetDefault()
  self._mapNode.AnimRoot:Play("default")
  self._mapNode.btnConfirm.interactable = false
  self._mapNode.imgBgSelect:SetActive(false)
end

function ThrowGiftItemSelectGridCtrl:PlaySelectAnim()
  self.animator:Play("btnItemSelectCard_out")
end

function ThrowGiftItemSelectGridCtrl:OnBtnClick_Confirm(btn)
  EventManager.Hit("ThrowGiftItemSelectConfirmClick")
end

return ThrowGiftItemSelectGridCtrl
