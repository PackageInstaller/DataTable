local InteractiveHUDCtrl = class("InteractiveHUDCtrl", BaseCtrl)
InteractiveHUDCtrl._mapNodeConfig = {
  imgFurnitureIcon = {sComponentName = "Image"},
  btnFurnitureIcon = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Interactive"
  }
}
InteractiveHUDCtrl._mapEventConfig = {}
InteractiveHUDCtrl._mapRedDotConfig = {}

function InteractiveHUDCtrl:Awake()
end

function InteractiveHUDCtrl:FadeIn()
end

function InteractiveHUDCtrl:FadeOut()
end

function InteractiveHUDCtrl:OnEnable()
  self.nFurId = 0
end

function InteractiveHUDCtrl:OnDisable()
end

function InteractiveHUDCtrl:OnDestroy()
end

function InteractiveHUDCtrl:OnRelease()
end

function InteractiveHUDCtrl:Show(nId, rtTransform, nFurId, sIcon)
  self.nUid = nId
  self.nFurId = nFurId
  self:SetPngSprite(self._mapNode.imgFurnitureIcon, sIcon)
  safe_call_cs_func(CS.DormModuleHelper.SetHudFollowTarget, self.gameObject, rtTransform, Vector3(0, 1.5, 0))
end

function InteractiveHUDCtrl:Hide()
  self.nUid = 0
  self.nFurId = 0
  safe_call_cs_func(CS.DormModuleHelper.UnsetHudFollowTarget, self.gameObject)
end

function InteractiveHUDCtrl:OnBtnClick_Interactive()
  EventManager.Hit("FurnitureFunctionBtnClick", self.nUid, self.nFurId)
end

return InteractiveHUDCtrl
