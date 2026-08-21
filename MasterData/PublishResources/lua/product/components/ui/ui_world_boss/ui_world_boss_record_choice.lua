_class("UIWorldBossRecordChoice", UIController)
UIWorldBossRecordChoice = UIWorldBossRecordChoice
local ChoiceType = {
  New = 1,
  Old = 2,
  None = 3
}
_enum("ChoiceType", ChoiceType)

function UIWorldBossRecordChoice:Constructor()
  self._missionModule = self:GetModule(MissionModule)
  self._worldBossModule = self:GetModule(WorldBossModule)
  self._maxPetsCount = 5
  self._choiceType = ChoiceType.None
  self._newDamage = 0
  self._oldDamage = 0
end

function UIWorldBossRecordChoice:OnShow(uiParams)
  self._newDamage = uiParams[1]
  self._callBack = uiParams[2]
  self:_GetComponents()
  self:_OnValue()
  self:_CheckSeasonEnd()
end

function UIWorldBossRecordChoice:_GetComponents()
  self._mark = self:GetGameObject("Mark")
  self._newObj = self:GetGameObject("New")
  self._oldObj = self:GetGameObject("Old")
  self._blurObj = self:GetGameObject("Blur")
  self._newDamageValueGray = self:GetUIComponent("UILocalizationText", "NewDamageValueGray")
  self._newDamageValue = self:GetUIComponent("UILocalizationText", "NewDamageValue")
  self._newPets = self:GetUIComponent("UISelectObjectPath", "NewPets")
  self._oldDamageValueGray = self:GetUIComponent("UILocalizationText", "OldDamageValueGray")
  self._oldDamageValue = self:GetUIComponent("UILocalizationText", "OldDamageValue")
  self._oldPets = self:GetUIComponent("UISelectObjectPath", "OldPets")
  self.animaiton = self:GetUIComponent("Animation", "animation")
end

function UIWorldBossRecordChoice:_OnValue()
  local teamsContext = self._missionModule:TeamCtx()
  local newTeam = teamsContext:Teams():Get(teamsContext:GetCurrTeamId())
  local record = self._worldBossModule:GetRecordByTeamIndex(self._worldBossModule:GetCurSelectTeamIndex())
  local oldTeamPets
  if record then
    oldTeamPets = record.pet_list
    self._oldDamage = record.formation_damage
  end
  self:_CreateTeamPets(newTeam.pets, oldTeamPets)
  self._newDamageValueGray:SetText(UIActivityHelper.AddZeroFrontNum(8, self._newDamage))
  self._newDamageValue:SetText(self._newDamage)
  self._oldDamageValueGray:SetText(UIActivityHelper.AddZeroFrontNum(8, self._oldDamage))
  self._oldDamageValue:SetText(self._oldDamage)
  self._mark:SetActive(false)
end

function UIWorldBossRecordChoice:_CreateTeamPets(newPets, OldPets)
  self._newPets:SpawnObjects("UIWorldBossRecordPet", self._maxPetsCount)
  self._allNewPets = self._newPets:GetAllSpawnList()
  self._oldPets:SpawnObjects("UIWorldBossRecordPet", self._maxPetsCount)
  self._allOldPets = self._oldPets:GetAllSpawnList()
  for i = 1, self._maxPetsCount do
    self._allNewPets[i]:SetData(newPets[i])
    local pstId = 0
    if OldPets then
      pstId = OldPets[i]
    end
    self._allOldPets[i]:SetData(pstId)
  end
end

function UIWorldBossRecordChoice:NewBtnOnClick(go)
  local pos = go.transform.parent.anchoredPosition
  pos.x = 2
  self._mark.transform.anchoredPosition = pos
  self._choiceType = ChoiceType.New
  self._mark:SetActive(true)
  self:PlaySelectAni()
end

function UIWorldBossRecordChoice:OldBtnOnClick(go)
  local pos = go.transform.parent.anchoredPosition
  pos.x = -1
  self._mark.transform.anchoredPosition = pos
  self._choiceType = ChoiceType.Old
  self._mark:SetActive(true)
  self:PlaySelectAni()
end

function UIWorldBossRecordChoice:PlaySelectAni()
  self:StartTask(function(TT)
    local key = "UIWorldBossRecordChoice_select_ani"
    self:Lock(key)
    self.animaiton:Play("UIWorldBossRecordChoice_xuanzhong")
    YIELD(TT, 400)
    self:UnLock(key)
  end)
end

function UIWorldBossRecordChoice:ConfirmBtnOnClick(go)
  if self._choiceType == ChoiceType.None then
    ToastManager.ShowToast(StringTable.Get("str_world_boss_choice_record"))
    return
  end
  local damage = 0
  local aniName
  if self._choiceType == ChoiceType.New then
    damage = self._newDamage
  else
    damage = self._oldDamage
  end
  self:_ChoiceRecord(damage)
end

function UIWorldBossRecordChoice:_ChoiceRecord(damage)
  self:StartTask(function(TT)
    local res = self._worldBossModule:ReqChoseRecord(TT, self._choiceType == ChoiceType.New, self._worldBossModule:GetCurSelectTeamIndex(), damage)
    if res:GetSucc() then
      self:CloseWithAnimation()
      if self._callBack then
        self._callBack(self._choiceType == ChoiceType.Old)
      end
    end
  end, self)
end

function UIWorldBossRecordChoice:_CheckSeasonEnd()
  if self._worldBossModule:CurSeasonEnd() then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_activity_common_notice_title"), StringTable.Get("str_world_boss_season_end"), function()
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Exit_Core_Game, nil, nil)
    end, nil)
  end
end

function UIWorldBossRecordChoice:CloseWithAnimation()
  self:StartTask(function(TT)
    local key = "UIWorldBossRecordChoice_Close"
    self:Lock(key)
    self._blurObj:SetActive(true)
    local aniName
    if self._choiceType == ChoiceType.New then
      aniName = "UIWorldBossRecordChoice_down"
      UIHelper.SetAsLastSibling(self._blurObj)
      UIHelper.SetAsLastSibling(self._newObj)
      UIHelper.SetAsLastSibling(self._mark)
    else
      aniName = "UIWorldBossRecordChoice_up"
      UIHelper.SetAsLastSibling(self._blurObj)
      UIHelper.SetAsLastSibling(self._oldObj)
      UIHelper.SetAsLastSibling(self._mark)
    end
    self.animaiton:Play(aniName)
    YIELD(TT, 1868)
    self.animaiton:Play("UIWorldBossRecordChoice_out")
    YIELD(TT, 800)
    self:UnLock(key)
    self:CloseDialog()
  end)
end
