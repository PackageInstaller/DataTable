_class("UIHauteCoutureDrawRulesV2Controller", UIController)
UIHauteCoutureDrawRulesV2Controller = UIHauteCoutureDrawRulesV2Controller

function UIHauteCoutureDrawRulesV2Controller:Constructor()
  self.main = nil
  self.bg = nil
end

function UIHauteCoutureDrawRulesV2Controller:OnShow(uiParams)
  local bg = self:GetUIComponent("UISelectObjectPath", "bgRoot")
  local main = self:GetUIComponent("UISelectObjectPath", "uiRoot")
  self.CtxData = uiParams[1]
  self.hcType = self.CtxData:HC_Type()
  if self.hcType == HauteCoutureType.HC_GL then
    bg.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawRulesBgGL.prefab")
    main.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawRulesMainGL.prefab")
    self.bg = bg:SpawnObject("UIHauteCoutureDrawRulesBgGL")
    self.main = main:SpawnObject("UIHauteCoutureDrawRulesMainGL")
  elseif self.hcType == HauteCoutureType.HC_KR then
    bg.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawRulesBgKR.prefab")
    main.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawRulesMainKR.prefab")
    self.bg = bg:SpawnObject("UIHauteCoutureDrawRulesBgKR")
    self.main = main:SpawnObject("UIHauteCoutureDrawRulesMainKR")
  else
    local bgPrefab, bgClass = self.CtxData:GetRulesUIBgInfo()
    local prefab, class = self.CtxData:GetRulesUIInfo()
    bg.dynamicInfoOfEngine:SetObjectName(bgPrefab)
    main.dynamicInfoOfEngine:SetObjectName(prefab)
    self.bg = bg:SpawnObject(bgClass._className)
    self.main = main:SpawnObject(class._className)
  end
end
