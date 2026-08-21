_class("UIEducationMain", UIController)
UIEducationMain = UIEducationMain

function UIEducationMain:Constructor()
end

function UIEducationMain:GetData()
  return self._data
end

function UIEducationMain:LoadDataOnEnter(TT, res, uiParams)
  local petModule = GameGlobal.GetModule(PetModule)
  UIEducationMain._data = petModule:GetUIEducationData()
  self._data:SetRedDirty(true)
  self._data:TestCondition()
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function UIEducationMain:OnShow(uiParams)
  self:UIWidget()
  self:InitCommonTopButton()
  self:CreateElements()
  self:FlushElements()
  self:InAnimation()
  self:AttachEvent(GameEventType.EducationChanged, self.OnEducationChanged)
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:IsGuideProcess(5511) then
    self._btnGuideBlueGo:SetActive(true)
  end
end

function UIEducationMain:OnHide()
  UIEducationMain._data = nil
end

function UIEducationMain:OnUpdate(deltaTimeMS)
end

function UIEducationMain:BtnSingleOnClick(go)
  self:ShowDialog("UIEducationOne")
end

function UIEducationMain:ElementOnClick(elementType)
  if self._animationFangda == nil then
    UIEducationMain._animationFangda = {
      [ElementType.ElementType_Blue] = "uieff_UIEducationMain_fangda_shui",
      [ElementType.ElementType_Red] = "uieff_UIEducationMain_fangda_huo",
      [ElementType.ElementType_Green] = "uieff_UIEducationMain_fangda_sen",
      [ElementType.ElementType_Yellow] = "uieff_UIEducationMain_fangda_lei"
    }
    UIEducationMain._animationSuoxiao = {
      [ElementType.ElementType_Blue] = "uieff_UIEducationMain_suoxiao_shui",
      [ElementType.ElementType_Red] = "uieff_UIEducationMain_suoxiao_huo",
      [ElementType.ElementType_Green] = "uieff_UIEducationMain_suoxiao_sen",
      [ElementType.ElementType_Yellow] = "uieff_UIEducationMain_suoxiao_lei"
    }
  end
  self:ShowDialog("UIEducationUp", elementType, function(elementType)
    self._animation:Play(self._animationFangda[elementType])
    for k, v in pairs(self._lstNode) do
      v.uiWidget:PlayAnimation("uieff_UIEducationMainBtn_fangda_out")
    end
  end, function(elementType)
    self._animation:Play(self._animationSuoxiao[elementType])
    for k, v in pairs(self._lstNode) do
      v.uiWidget:PlayAnimation("uieff_UIEducationMainBtn_fangda_in")
    end
  end)
end

function UIEducationMain:OnEducationChanged()
  self:FlushElements()
end

function UIEducationMain:UIWidget()
  self._ltBtn = self:GetUIComponent("UISelectObjectPath", "ltBtn")
  self._pathBlue = self:GetUIComponent("UISelectObjectPath", "pathBlue")
  self._pathRed = self:GetUIComponent("UISelectObjectPath", "pathRed")
  self._pathGreen = self:GetUIComponent("UISelectObjectPath", "pathGreen")
  self._pathYellow = self:GetUIComponent("UISelectObjectPath", "pathYellow")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._btnGuideBlueGo = self:GetGameObject("btnGuideBlue")
  self._btnGuideBlueGo:SetActive(false)
end

function UIEducationMain:InitCommonTopButton()
  self._backBtns = self._ltBtn:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, function()
    self:ShowDialog("UIHelpController", "UIEducationMain")
  end, function()
    UICommonHelper:GetInstance():SwitchToUIMain()
  end, false, nil, false, function()
    self:EnterFullScreenBg(true)
  end)
end

function UIEducationMain:CreateElements()
  local lstPath = {
    self._pathBlue,
    self._pathRed,
    self._pathGreen,
    self._pathYellow
  }
  self._lstNode = {}
  for k, v in pairs(lstPath) do
    local uiNode = {
      uiPath = v,
      uiWidget = v:SpawnObjects("UIEducationMainBtn", 1)[1],
      element = self._data:Get(k)
    }
    uiNode.uiWidget:SetData(uiNode.element, self._atlasProperty, function(elementType)
      self:ElementOnClick(elementType)
    end)
    self._lstNode[k] = uiNode
  end
end

function UIEducationMain:FlushElements()
  for k, v in pairs(self._lstNode) do
    v.uiWidget:Flush()
  end
end

function UIEducationMain:InAnimation()
  self:StartSafeTask("UIEducationMain::InAnimation", function(lockName, TT)
    self:Lock(lockName)
    for k, v in pairs(self._lstNode) do
      v.uiWidget:PlayAnimation("uieff_UIEducationMainBtn_in")
    end
    self._animation:Play("uieff_UIEducationMain")
    YIELD(TT, 800)
    self:UnLock(lockName)
  end)
end

function UIEducationMain:BtnGuideBlueOnClick(go)
  self:ElementOnClick(ElementType.ElementType_Blue)
  self._btnGuideBlueGo:SetActive(false)
end
