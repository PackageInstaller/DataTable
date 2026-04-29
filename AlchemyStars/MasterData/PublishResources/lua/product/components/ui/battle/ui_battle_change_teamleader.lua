require("ui_controller")
_class("UIBattleChangeTeamLeader", UIController)
UIBattleChangeTeamLeader = UIBattleChangeTeamLeader

function UIBattleChangeTeamLeader:OnShow(uiParams)
  local excPos = Vector2(-214, -17)
  self._btnList = {}
  self._maskList = {}
  for i = 1, 4 do
    local objName = "btn" .. tostring(i)
    local btn = self:GetGameObject(objName)
    btn:SetActive(false)
    self._btnList[i] = btn
    local masObjName = "Mask" .. tostring(i)
    local mask = self:GetGameObject(masObjName)
    mask:SetActive(false)
    self._maskList[i] = mask
  end
  local language = Localization.GetCurLanguage()
  if language == LanguageType.es then
    for i = 1, 4 do
      local txtObjName = "txt" .. tostring(i)
      local txtCmpt = self:GetUIComponent("UILocalizationText", txtObjName)
      if txtCmpt then
        txtCmpt.fontSize = 26
        txtCmpt.lineSpacing = 0.6
      end
    end
  end
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self._petDataList = uiParams[1]
  self.ChangeTeamLeaderCallBackFunc = uiParams[2]
  self._useMultiColumn = uiParams[3]
  self._switchColumnBtnCb = uiParams[4]
  self._isSealedCurse = {}
  self._isPetNotInTeam = {}
  for i, v in ipairs(self._petDataList) do
    local btn = self._btnList[i]
    if not btn then
      break
    end
    local mask = self._maskList[i]
    local pos = camera:ScreenToWorldPoint(v.screenPos)
    if not v.isDead then
      btn:SetActive(true)
      btn.transform.position = pos
      local rectTransform = btn:GetComponent("RectTransform")
      rectTransform.anchoredPosition = Vector2(rectTransform.anchoredPosition.x + excPos.x, rectTransform.anchoredPosition.y + excPos.y)
    end
    mask:SetActive(v.isHelpPet)
    local isCursed = not v.isHelpPet and v.isSealedCurse
    self._isSealedCurse[i] = isCursed
    self._isPetNotInTeam[i] = v.isPetNotInTeam
    local maskSealedCurse = self:GetGameObject("MaskSealedCurse" .. tostring(i))
    maskSealedCurse:SetActive(isCursed or v.isPetNotInTeam)
  end
  self.petModule = self:GetModule(PetModule)
  local btn = self:GetGameObject("SwitchTeamColumnBtn")
  if btn then
    if self._useMultiColumn then
      btn:SetActive(true)
    else
      btn:SetActive(false)
    end
  end
end

function UIBattleChangeTeamLeader:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ToggleTeamLeaderChangeUI, false)
end

function UIBattleChangeTeamLeader:GetPetPstID(index)
  local petData = self._petDataList[index]
  if petData then
    return petData.petPstID
  end
end

function UIBattleChangeTeamLeader:IsCanCastChangePet(index)
  local petData = self._petDataList[index]
  if petData then
    return not petData.isHelpPet
  end
  return false
end

function UIBattleChangeTeamLeader:ChangeTeamLeader(index)
  if self._isSealedCurse[index] then
    local text = StringTable.Get("str_battle_change_teamleader_sealed_curse")
    ToastManager.ShowToast(text)
    return
  end
  if self._isPetNotInTeam[index] then
    local text = StringTable.Get("str_battle_jjz_1")
    ToastManager.ShowToast(text)
    return
  end
  local petPstID = self:GetPetPstID(index)
  if petPstID then
    if self:IsCanCastChangePet(index) then
      self.ChangeTeamLeaderCallBackFunc(petPstID)
      self:CloseDialog()
    else
      local text = StringTable.Get("str_battle_helppet_no_set_teamleader")
      ToastManager.ShowToast(text)
    end
  end
end

function UIBattleChangeTeamLeader:ChangeTeamLeaderBtn1OnClick()
  self:ChangeTeamLeader(1)
end

function UIBattleChangeTeamLeader:ChangeTeamLeaderBtn2OnClick()
  self:ChangeTeamLeader(2)
end

function UIBattleChangeTeamLeader:ChangeTeamLeaderBtn3OnClick()
  self:ChangeTeamLeader(3)
end

function UIBattleChangeTeamLeader:ChangeTeamLeaderBtn4OnClick()
  self:ChangeTeamLeader(4)
end

function UIBattleChangeTeamLeader:bgOnClick()
  self:CloseDialog()
end

function UIBattleChangeTeamLeader:GetBtn(petTempId)
  local index = 1
  for i, petData in ipairs(self._petDataList) do
    local pet = self.petModule:GetPet(petData.petPstID)
    if pet then
      if pet:GetTemplateID() == petTempId then
        index = i
        break
      end
    elseif petData.petPstID == petTempId then
      index = i
      break
    end
  end
  return self._btnList[index]
end

function UIBattleChangeTeamLeader:SwitchTeamColumnBtnOnClick()
  if self._switchColumnBtnCb then
    self._switchColumnBtnCb()
  end
end
