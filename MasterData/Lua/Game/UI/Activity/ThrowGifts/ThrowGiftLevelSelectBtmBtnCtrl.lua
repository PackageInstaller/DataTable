local ThrowGiftLevelSelectBtmBtnCtrl = class("ThrowGiftLevelSelectBtmBtnCtrl", BaseCtrl)
ThrowGiftLevelSelectBtmBtnCtrl._mapNodeConfig = {
  imgbgUnlock = {},
  imgIconLock = {},
  imgIconClear = {},
  imgIconUnlock = {},
  imgIconCur = {}
}
ThrowGiftLevelSelectBtmBtnCtrl._mapEventConfig = {}
ThrowGiftLevelSelectBtmBtnCtrl._mapRedDotConfig = {}

function ThrowGiftLevelSelectBtmBtnCtrl:Awake()
end

function ThrowGiftLevelSelectBtmBtnCtrl:FadeIn()
end

function ThrowGiftLevelSelectBtmBtnCtrl:FadeOut()
end

function ThrowGiftLevelSelectBtmBtnCtrl:OnEnable()
end

function ThrowGiftLevelSelectBtmBtnCtrl:OnDisable()
end

function ThrowGiftLevelSelectBtmBtnCtrl:OnDestroy()
end

function ThrowGiftLevelSelectBtmBtnCtrl:OnRelease()
end

function ThrowGiftLevelSelectBtmBtnCtrl:SetBtnState(bUnlock, bClear)
  self._mapNode.imgIconLock:SetActive(not bUnlock)
  self._mapNode.imgIconClear:SetActive(bClear)
  self._mapNode.imgIconUnlock:SetActive(bUnlock and not bClear)
end

function ThrowGiftLevelSelectBtmBtnCtrl:SetBtnCurState(bCur)
  self._mapNode.imgIconCur:SetActive(bCur)
end

function ThrowGiftLevelSelectBtmBtnCtrl:SetBtnSelectState(bSelect)
  self._mapNode.imgbgUnlock:SetActive(bSelect)
end

return ThrowGiftLevelSelectBtmBtnCtrl
