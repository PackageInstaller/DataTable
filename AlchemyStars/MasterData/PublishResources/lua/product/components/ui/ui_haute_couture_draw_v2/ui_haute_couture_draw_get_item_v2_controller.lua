_class("UIHauteCoutureDrawGetItemV2Controller", UIController)
UIHauteCoutureDrawGetItemV2Controller = UIHauteCoutureDrawGetItemV2Controller

function UIHauteCoutureDrawGetItemV2Controller:Constructor()
  self.main = nil
  self.bg = nil
  self.items = {}
  self.titleTex = nil
  self.noSort = nil
  self.callback = nil
end

function UIHauteCoutureDrawGetItemV2Controller:OnShow(uiParams)
  self.items = uiParams[1]
  self.titleTex = uiParams[2]
  self.noSort = uiParams[3]
  self.callback = uiParams[4]
  self._ctx = uiParams[5]
  local main = self:GetUIComponent("UISelectObjectPath", "uiRoot")
  self.hcType = HauteCouture:GetInstance().HcType
  if self.hcType == HauteCoutureType.HC_GL then
    main.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawGetItemMainGL.prefab")
    self.main = main:SpawnObject("UIHauteCoutureDrawGetItemMainGL")
  elseif self.hcType == HauteCoutureType.HC_KR then
    main.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawGetItemMainKR.prefab")
    self.main = main:SpawnObject("UIHauteCoutureDrawGetItemMainKR")
  else
    local prefab, class = self._ctx:GetGetItemUIInfo()
    main.dynamicInfoOfEngine:SetObjectName(prefab)
    self.main = main:SpawnObject(class._className)
  end
end
