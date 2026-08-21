_class("UIHauteCoutureDrawDynamicProbablityV2Controller", UIController)
UIHauteCoutureDrawDynamicProbablityV2Controller = UIHauteCoutureDrawDynamicProbablityV2Controller

function UIHauteCoutureDrawDynamicProbablityV2Controller:Constructor()
  self.main = nil
  self.bg = nil
  self._prizes = nil
  self._drawTimes = nil
  self._gotPrizeIds = nil
  self._componentId = 0
end

function UIHauteCoutureDrawDynamicProbablityV2Controller:OnShow(uiParams)
  local bg = self:GetUIComponent("UISelectObjectPath", "bgRoot")
  local main = self:GetUIComponent("UISelectObjectPath", "uiRoot")
  self.hcType = uiParams[1]
  self._prizes = uiParams[2]
  self._drawTimes = uiParams[3]
  self._gotPrizeIds = uiParams[4]
  self._componentId = uiParams[5]
  self._ctx = uiParams[6]
  if self.hcType == HauteCoutureType.HC_GL then
    bg.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawDynamicProbabilityBgGL.prefab")
    main.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawDynamicProbabilityMainGL.prefab")
    self.bg = bg:SpawnObject("UIHauteCoutureDrawDynamicProbabilityBgGL")
    self.main = main:SpawnObject("UIHauteCoutureDrawDynamicProbabilityMainGL")
  elseif self.hcType == HauteCoutureType.HC_KR then
    bg.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawDynamicProbabilityBgKR.prefab")
    main.dynamicInfoOfEngine:SetObjectName("UIHauteCoutureDrawDynamicProbabilityMainKR.prefab")
    self.bg = bg:SpawnObject("UIHauteCoutureDrawDynamicProbabilityBgKR")
    self.main = main:SpawnObject("UIHauteCoutureDrawDynamicProbabilityMainKR")
  else
    local bgPrefab, bgClass = self._ctx:GetDynamicProbablityUIBgInfo()
    local prefab, class = self._ctx:GetDynamicProbablityUIInfo()
    bg.dynamicInfoOfEngine:SetObjectName(bgPrefab)
    main.dynamicInfoOfEngine:SetObjectName(prefab)
    self.bg = bg:SpawnObject(bgClass._className)
    self.main = main:SpawnObject(class._className)
  end
end
