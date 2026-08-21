_class("UIWidgetPetEquipRefine", UICustomWidget)
UIWidgetPetEquipRefine = UIWidgetPetEquipRefine

function UIWidgetPetEquipRefine:OnShow()
  self.enableFakeInput = true
  self:AttachEvent(GameEventType.BattleUIRefreshRefineSwitchBtnState, self._RefreshSwitchBtnState)
  self._uiBattle1Atlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
  self._refineDesc = self:GetUIComponent("UILocalizationText", "refineDesc")
  self._bgRectTransform = self:GetUIComponent("RectTransform", "bg")
  self._refineInfoRT = self:GetUIComponent("RectTransform", "refineInfo")
  self._btnSwitch = self:GetUIComponent("Image", "btnSwitch")
  self._imgSwitch = self:GetUIComponent("Image", "imgSwitch")
  self._imgSwitchRT = self:GetUIComponent("RectTransform", "imgSwitch")
  self._txtSwitch = self:GetUIComponent("UILocalizationText", "txtSwitch")
  self._objOnPos = self:GetGameObject("objOnPos")
  self._objOffPos = self:GetGameObject("objOffPos")
  self._isMoving = false
end

function UIWidgetPetEquipRefine:HideSelf()
  self:GetGameObject():SetActive(false)
end

function UIWidgetPetEquipRefine:ShowSelf()
  self:GetGameObject():SetActive(true)
end

function UIWidgetPetEquipRefine:SetUIPos(position, isUp)
  self:GetGameObject().transform.position = position
  if isUp then
    self._refineInfoRT.anchorMax = Vector2(0.5, 0)
    self._refineInfoRT.anchorMin = Vector2(0.5, 0)
    self._refineInfoRT.pivot = Vector2(0.5, 0)
  else
    self._refineInfoRT.anchorMax = Vector2(0.5, 1)
    self._refineInfoRT.anchorMin = Vector2(0.5, 1)
    self._refineInfoRT.pivot = Vector2(0.5, 1)
  end
end

function UIWidgetPetEquipRefine:OnHide()
  self.activeSkillCheckPass = true
  self._cannotCastReason = nil
end

function UIWidgetPetEquipRefine:_RefreshUI(isClick)
  local moveTime = 0
  if isClick then
    moveTime = 0.2
    self._isMoving = true
  end
  local pos = self._objOnPos.transform.position
  if self._uiState == EquipRefineUIStateType.Off then
    pos = self._objOffPos.transform.position
  end
  self._imgSwitchRT:DOMove(pos, moveTime):OnComplete(function()
    self._isMoving = false
    local buffCfgData = self._buffViewIns:BuffConfigData()
    local viewParam = buffCfgData:GetViewParams()
    local strDesc = viewParam.RefineOnDesc
    if self._uiState == EquipRefineUIStateType.On then
      self._txtSwitch.color = Color.white
      self._txtSwitch:SetText(StringTable.Get("str_battle_pet_refine_ui_on"))
      self._btnSwitch.sprite = self._uiBattle1Atlas:GetSprite("thread_zhudong_btn9")
      self._imgSwitch.sprite = self._uiBattle1Atlas:GetSprite("thread_zhudong_btn11")
    elseif self._uiState == EquipRefineUIStateType.Off then
      self._txtSwitch.color = Color(0.984313725490196, 0.984313725490196, 0.984313725490196, 1)
      self._txtSwitch:SetText(StringTable.Get("str_battle_pet_refine_ui_off"))
      self._btnSwitch.sprite = self._uiBattle1Atlas:GetSprite("thread_zhudong_btn13")
      self._imgSwitch.sprite = self._uiBattle1Atlas:GetSprite("thread_zhudong_btn12")
      strDesc = viewParam.RefineOffDesc
    end
    self._refineDesc:SetText(StringTable.Get(strDesc))
  end)
end

function UIWidgetPetEquipRefine:Init(petPstID, buffViewIns)
  self._petPstID = petPstID
  self._buffViewIns = buffViewIns
  self._uiState = InnerGameHelperRender.GetBuffValue(petPstID, "EquipRefineUIState") or EquipRefineUIStateType.On
  self:_RefreshUI()
end

function UIWidgetPetEquipRefine:BtnSwitchOnClick()
  if self._isMoving then
    return
  end
  if self._uiState == EquipRefineUIStateType.On then
    self._uiState = EquipRefineUIStateType.Off
  elseif self._uiState == EquipRefineUIStateType.Off then
    self._uiState = EquipRefineUIStateType.On
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIBattleSwitchPetEquipRefine, self._uiState, self._petPstID)
end

function UIWidgetPetEquipRefine:_RefreshSwitchBtnState(uiState)
  if uiState ~= self._uiState then
    self._uiState = uiState
  end
  self:_RefreshUI(true)
end
