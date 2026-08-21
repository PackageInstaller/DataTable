_class("UIWidgetFeatureAutoBeadPowerInfo", UICustomWidget)
UIWidgetFeatureAutoBeadPowerInfo = UIWidgetFeatureAutoBeadPowerInfo

function UIWidgetFeatureAutoBeadPowerInfo:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureAutoBeadPowerInfo:InitWidget()
  self._imageNormalGo = self:GetGameObject("ImageNormal")
  self._imageNormal = self:GetUIComponent("Image", "ImageNormal")
  self._powerValue = self:GetUIComponent("UILocalizationText", "PowerValue")
  self._restPointValue = self:GetUIComponent("UILocalizationText", "RestPointValue")
  self._anim = self:GetUIComponent("Animation", "UIWidgetFeatureAutoBeadPowerInfo")
  self._animName = {
    [1] = "uieffanim_N16_UIWidgetFeatureAutoBeadPowerInfo_01",
    [2] = "uieffanim_N16_UIWidgetFeatureAutoBeadPowerInfo_02"
  }
  self._curAnimLevel = 0
  self._triggered1 = false
  self._triggered2 = false
  self:RegisterEvent()
end

function UIWidgetFeatureAutoBeadPowerInfo:RegisterEvent()
  self:AttachEvent(GameEventType.FeatureAutoBeadPointRefreshUI, self._OnFeatureAutoBeadPointRefreshUI)
  self:AttachEvent(GameEventType.FeatureAutoBeadPointChange, self._OnFeatureAutoBeadPointChange)
  self:AttachEvent(GameEventType.FeatureAutoBeadPointToPowerChange, self._OnFeatureAutoBeadPointToPowerChange)
  self:AttachEvent(GameEventType.GuideRound, self._GuideRound)
end

function UIWidgetFeatureAutoBeadPowerInfo:SetData(initInfo)
  local curPoint, pointToPower = InnerGameHelperRender.GetCurAutoBeadPowerInfo()
  self._initData = initInfo
  self._curPoint = math.floor(curPoint)
  self._pointToPower = math.floor(pointToPower)
  self:SetValue(self._curPoint)
end

function UIWidgetFeatureAutoBeadPowerInfo:BaseOnClick(go)
  if InnerGameHelperRender.IsPuzzleState() then
    return
  end
  if InnerGameHelperRender.IsPet1702361ActiveSkillPreview() then
    return
  end
  self:ShowDialog("UIFeatureAutoBeadInfo")
end

function UIWidgetFeatureAutoBeadPowerInfo:SetValue(pointValue)
  pointValue = math.floor(pointValue)
  self._curPoint = pointValue
  self:_SetUiValue(self._curPoint)
end

function UIWidgetFeatureAutoBeadPowerInfo:_SetUiValue(pointValue)
  pointValue = math.floor(pointValue)
  local uiRestPoint = 0
  local uiPower = 0
  local uiPercent = 0
  if 0 >= self._pointToPower then
    uiPower = 0
    uiRestPoint = pointValue
    uiPercent = 0
  else
    uiPower = math.floor(pointValue / self._pointToPower)
    uiRestPoint = pointValue - uiPower * self._pointToPower
    uiPercent = math.floor(uiRestPoint / self._pointToPower * 100)
  end
  self._powerValue:SetText(uiPower)
  local percentStr = tostring(uiPercent) .. "%"
  self._restPointValue:SetText(percentStr)
end

function UIWidgetFeatureAutoBeadPowerInfo:_OnFeatureAutoBeadPointRefreshUI()
  local curPoint, pointToPower = InnerGameHelperRender.GetCurAutoBeadPowerInfo()
  self._curPoint = math.floor(curPoint)
  self._pointToPower = math.floor(pointToPower)
  self:SetValue(self._curPoint)
end

function UIWidgetFeatureAutoBeadPowerInfo:_OnFeatureAutoBeadPointChange(curPoint)
  self:_OnFeatureAutoBeadPointRefreshUI()
end

function UIWidgetFeatureAutoBeadPowerInfo:_OnFeatureAutoBeadPointToPowerChange(curPoint)
  self:_OnFeatureAutoBeadPointRefreshUI()
end

function UIWidgetFeatureAutoBeadPowerInfo:_GuideRound(levelID, curWaveIndex, curRoundIndex)
  if not self._triggered1 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonMazeBeadInner)
    self._triggered1 = true
  end
  if not self._triggered2 and curRoundIndex == 2 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonMazeBeadInner2)
    self._triggered2 = true
  end
end
