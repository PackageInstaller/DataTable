local ThrowGiftItemUseBtnCtrl = class("ThrowGiftItemUseBtnCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
ThrowGiftItemUseBtnCtrl._mapNodeConfig = {
  txtBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "ThrowGift_UseItem"
  },
  btnUseItem1 = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Confirm",
    sAction = "ThrowGiftItemConfirm"
  },
  btnItem1 = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Item"
  },
  imgBgItemInuse = {sComponentName = "Image"},
  imgItemIconEmpty = {},
  imgItemIcon1 = {sComponentName = "Image"},
  rtParent = {sComponentName = "Animator"},
  cgParent = {
    sNodeName = "rtParent",
    sComponentName = "CanvasGroup"
  }
}
ThrowGiftItemUseBtnCtrl._mapEventConfig = {}
ThrowGiftItemUseBtnCtrl._mapRedDotConfig = {}

function ThrowGiftItemUseBtnCtrl:Awake()
  self.nIdx = 0
end

function ThrowGiftItemUseBtnCtrl:FadeIn()
end

function ThrowGiftItemUseBtnCtrl:FadeOut()
end

function ThrowGiftItemUseBtnCtrl:OnEnable()
  self._mapNode.btnUseItem1.interactable = false
end

function ThrowGiftItemUseBtnCtrl:OnDisable()
end

function ThrowGiftItemUseBtnCtrl:OnDestroy()
end

function ThrowGiftItemUseBtnCtrl:OnRelease()
end

function ThrowGiftItemUseBtnCtrl:SetIdx(nIdx)
  self.nIdx = nIdx
end

function ThrowGiftItemUseBtnCtrl:OnBtnClick_Item()
  WwiseAudioMgr:PostEvent("Mode_Present_prop_choose")
  if self.nItemId == 0 then
    return
  end
  EventManager.Hit("OnBtnClick_ThrowGiftItemUseBtn", self.nIdx, self.nItemId)
end

function ThrowGiftItemUseBtnCtrl:OnBtnClick_Confirm()
  EventManager.Hit("OnBtnClick_ThrowGiftItemConfirmBtn", self.nIdx, self.nItemId)
end

function ThrowGiftItemUseBtnCtrl:SetItem(nId)
  self.nItemId = nId
  if nId == 0 then
    self._mapNode.imgItemIcon1.gameObject:SetActive(false)
    self._mapNode.imgItemIconEmpty.gameObject:SetActive(true)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgParent, 0.5)
    return
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.cgParent, 1)
  self._mapNode.imgItemIcon1.gameObject:SetActive(true)
  self._mapNode.imgItemIconEmpty.gameObject:SetActive(false)
  local mapItemCfgData = ConfigTable.GetData("ThrowGiftItem", nId)
  if mapItemCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  self:SetPngSprite(self._mapNode.imgItemIcon1, mapItemCfgData.Icon)
end

function ThrowGiftItemUseBtnCtrl:PlayAnim(nType)
  if nType == 1 then
    self._mapNode.rtParent:Play("rtParent_in")
    self._mapNode.btnUseItem1.interactable = true
  elseif nType == 2 then
    self._mapNode.rtParent:Play("rtParent_out")
    self._mapNode.btnUseItem1.interactable = false
  else
    self._mapNode.rtParent:Play("rtParent_switch")
    self._mapNode.btnUseItem1.interactable = false
  end
  self._mapNode.imgBgItemInuse.gameObject:SetActive(nType == 1)
end

function ThrowGiftItemUseBtnCtrl:SetAction(nIdx)
  self._mapNodeConfig.btnItem1.sAction = "ThrowGiftItem" .. nIdx
  self.tbGamepadUINode = self:GetGamepadUINode()
  GamepadUIManager.AddGamepadUINode(self._panel.sGamepadPanelName, self.tbGamepadUINode)
end

return ThrowGiftItemUseBtnCtrl
