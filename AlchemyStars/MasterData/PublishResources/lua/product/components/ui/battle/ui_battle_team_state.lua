_class("UIBattleTeamState", UIController)
UIBattleTeamState = UIBattleTeamState

function UIBattleTeamState:OnShow(uiParams)
  local leaderPetData = uiParams[1]
  self.teamStateGO = uiParams[2]
  self._curHp = uiParams[3]
  self._maxHp = uiParams[4]
  self.teamStateOriParent = self.teamStateGO.parent
  self._imgBG = self:GetUIComponent("RawImageLoader", "imgBG")
  local battle_mes = leaderPetData:GetBattleMes(PetSkinEffectPath.BODY_INGAME_TEAM)
  self._imgBG:LoadImage(battle_mes)
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  local leaderLocalName = StringTable.Get(leaderPetData:GetPetName())
  self._txtName:SetText(leaderLocalName)
  self._hpTxt = self:GetUIComponent("UILocalizationText", "HpValueText")
  self._skillInfo = self:GetGameObject("SkillInfo")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self.imgElement = self:GetUIComponent("Image", "imgElement")
  self._leaderSkillDescTxt = self:GetUIComponent("UILocalizationText", "SkillDesc")
  self._leaderSkillNameTxt = self:GetUIComponent("UILocalizationText", "SkillName")
  self.ElementNameTable = {
    [ElementType.ElementType_Blue] = "str_pet_element_name_blue",
    [ElementType.ElementType_Red] = "str_pet_element_name_red",
    [ElementType.ElementType_Green] = "str_pet_element_name_green",
    [ElementType.ElementType_Yellow] = "str_pet_element_name_yellow",
    [ElementType.ElementType_AnyNone] = "str_pet_element_name_any_none"
  }
  local firstElement = leaderPetData:GetPetFirstElement()
  self.imgElement.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(Cfg.cfg_pet_element[firstElement].Icon))
  self._leaderSkillNameTxt:SetText(StringTable.Get(self.ElementNameTable[firstElement]))
  
  local function GetRestrainAndBe(ele)
    if ele == 1 then
      return ele + 1, 4
    elseif ele == 4 then
      return 1, ele - 1
    else
      return ele + 1, ele - 1
    end
  end
  
  local r, b = GetRestrainAndBe(firstElement)
  if firstElement == ElementType.ElementType_AnyNone then
    self._leaderSkillDescTxt:SetText("")
  else
    self._leaderSkillDescTxt:SetText(StringTable.Get("str_battle_state_leader_state", StringTable.Get(self.ElementNameTable[r]), string.format("%d", BattleConst.Strong * 100), StringTable.Get(self.ElementNameTable[b]), string.format("%d", BattleConst.Counter * 100)))
  end
  self._rightUpAnchor = self:GetGameObject("RightUpAnchor")
  self.teamStateGO:SetParent(self._rightUpAnchor.transform, false)
  self:RefreshHpTxt()
  self:AttachEvent(GameEventType.TeamHPChange, self.OnTeamHPChange)
  self._teamBuffList = uiParams[5]
  self._sop = self:GetUIComponent("UISelectObjectPath", "Content")
  self:OnChangeBuff(true, nil)
end

function UIBattleTeamState:OnHide()
  if self.imgElement then
    self.imgElement.sprite = nil
    self.imgElement = nil
  end
  self:DetachEvent(GameEventType.TeamHPChange, self.OnTeamHPChange)
  self.teamStateGO:SetParent(self.teamStateOriParent, false)
end

function UIBattleTeamState:ExitBtnOnClick(go)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIBattleTeamState",
    input = "ExitBtnOnClick",
    args = {}
  })
  self:CloseDialog()
end

function UIBattleTeamState:OnTeamHPChange(teamHealthBlock)
  if teamHealthBlock.isLocalTeam then
    self._curHp = teamHealthBlock.currentHP
    self._maxHp = teamHealthBlock.maxHP
    self:RefreshHpTxt()
  end
end

function UIBattleTeamState:OnChangeBuff()
  self:StartTask(function(TT)
    YIELD(TT)
    if self._sop == nil or tostring(self._sop) == "null" then
      return
    end
    self._teamBuffList = self:OnSortBuffArray(self._teamBuffList)
    local teamBuffCount = #self._teamBuffList
    self._sop:SpawnObjects("UITeamBuffItem", teamBuffCount)
    self._buffs = self._sop:GetAllSpawnList()
    for i, v in ipairs(self._buffs) do
      v:GetGameObject():SetActive(false)
      if teamBuffCount >= i then
        v:GetGameObject():SetActive(true)
        local buffViewInstance = self._teamBuffList[i]
        v:SetData(buffViewInstance)
      end
    end
  end, self)
end

function UIBattleTeamState:RefreshHpTxt()
  local hpPercent = self._curHp / self._maxHp
  if hpPercent <= 0 then
    hpPercent = 0
  elseif hpPercent <= 0.01 then
    hpPercent = 1
  else
    hpPercent = math.floor(hpPercent * 100 + 0.5)
  end
  local strCurHp = "<color=#FF6900>" .. math.modf(self._curHp) .. "</color>"
  local strMaxHp = math.modf(self._maxHp)
  local strHpPercent = "<color=#00A1FF>" .. math.modf(hpPercent) .. "</color>"
  self._hpTxt:SetText(strCurHp .. "/" .. strMaxHp .. " (" .. strHpPercent .. "%)")
end

function UIBattleTeamState:OnSortBuffArray(buffViewArray)
  table.sort(buffViewArray, function(a, b)
    if a:BuffID() == b:BuffID() then
      return a:BuffSeq() < b:BuffSeq()
    end
    return a:BuffID() < b:BuffID()
  end)
  return buffViewArray
end
