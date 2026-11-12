local TowerDefenseCharacterDetailCtrl = class("TowerDefenseCharacterDetailCtrl", BaseCtrl)
local SelectedColor = Color(0.9803921568627451, 0.9803921568627451, 0.9803921568627451)
local NormalColor = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764)
local AdventureModuleHelper = CS.AdventureModuleHelper
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
TowerDefenseCharacterDetailCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBar",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  char_sv = {
    sComponentName = "LoopScrollView"
  },
  txt_detailName = {sComponentName = "TMP_Text"},
  img_char = {sComponentName = "Image"},
  txtLevel = {sComponentName = "TMP_Text"},
  txt_property = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Text_Atrr"
  },
  txt_attack = {
    sComponentName = "TMP_Text",
    sLanguageId = "Attr_Atk_Simple"
  },
  txt_attackValue = {sComponentName = "TMP_Text"},
  txt_AttackSpeed = {
    sComponentName = "TMP_Text",
    sLanguageId = "Attr_AtkSpd_Simple"
  },
  txt_AttackSpeedValue = {sComponentName = "TMP_Text"},
  txt_CD = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_CDTitle"
  },
  txt_cdValue = {sComponentName = "TMP_Text"},
  txt_empty = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Empty"
  },
  btn_potential = {
    sComponentName = "UIButton",
    callback = "OnBtn_PotentialTab_OnClisk"
  },
  txt_potential_selected = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Text_Pon"
  },
  txt_potential_normal = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Text_Pon"
  },
  potential_sv = {},
  empty_potential = {},
  go_potential1 = {},
  go_potential2 = {},
  btn_skill = {
    sComponentName = "UIButton",
    callback = "OnBtn_SkillTab_OnClisk"
  },
  txt_skill_selected = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Text_Skill"
  },
  txt_skill_normal = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Text_Skill"
  },
  skill_sv = {},
  skill = {nCount = 2}
}
TowerDefenseCharacterDetailCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Close"
}
TowerDefenseCharacterDetailCtrl._mapRedDotConfig = {}

function TowerDefenseCharacterDetailCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.characterList = param[1]
    local nSelectIndex = table.indexof(self.characterList, param[2])
    if nSelectIndex < 1 then
      nSelectIndex = 1
    end
    self.nSelectedId = self.characterList[nSelectIndex]
    self.TowerdefenseLevelData = param[3]
  end
  self.selectedGrid = nil
  self:InitData()
end

function TowerDefenseCharacterDetailCtrl:OnEnable()
  GamepadUIManager.EnableGamepadUI("TowerDefenseCharacterDetailCtrl", self:GetGamepadUINode(), nil, true)
end

function TowerDefenseCharacterDetailCtrl:OnDisable()
  GamepadUIManager.DisableGamepadUI("TowerDefenseCharacterDetailCtrl")
end

function TowerDefenseCharacterDetailCtrl:OnDestroy()
  EventManager.Hit("TowerDefenseCharDetailPanelClose")
end

function TowerDefenseCharacterDetailCtrl:InitData()
  NovaAPI.SetComponentEnable(self._mapNode.char_sv, true)
  self._mapNode.char_sv:Init(#self.characterList, self, self.OnRefreshGrid)
  NovaAPI.SetComponentEnable(self._mapNode.char_sv, false)
  self:RefreshInfoData()
  self:OnTabSelected(1)
end

function TowerDefenseCharacterDetailCtrl:RefreshInfoData()
  local nEntityId = self.TowerdefenseLevelData:GetCharacterEntityId(self.nSelectedId)
  local Info = AdventureModuleHelper.GetEntityInfo(nEntityId)
  local atk = Info ~= nil and Info.atk:AsFloat() or 0
  NovaAPI.SetTMPText(self._mapNode.txt_attackValue, tostring(atk))
  local atkSpeed = Info ~= nil and Info.normalAttackSpd:AsFloat() or 0
  atkSpeed = clearFloat(atkSpeed)
  NovaAPI.SetTMPText(self._mapNode.txt_AttackSpeedValue, FormatEffectValue(atkSpeed, true, GameEnum.ValueFormat.TDP))
  local config = ConfigTable.GetData("TowerDefenseCharacter", self.nSelectedId)
  if config == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txt_detailName, config.Name)
  local nCD = self.TowerdefenseLevelData:GetCharSkillCD(self.nSelectedId)
  NovaAPI.SetTMPText(self._mapNode.txt_cdValue, string.format("%.1f", nCD) .. ConfigTable.GetUIText("TowerDef_Text_Sec"))
  if config.Icon ~= nil and config.Icon ~= "" then
    self:SetPngSprite(self._mapNode.img_char, config.Icon .. AllEnum.CharHeadIconSurfix.Q)
  end
  local level = self.TowerdefenseLevelData:GetCharacterLevel(self.nSelectedId)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, tostring(level))
  self:SetSkillDes()
  self:SetPotentialDes()
end

function TowerDefenseCharacterDetailCtrl:SetSkillDes()
  local characterConfig = ConfigTable.GetData("TowerDefenseCharacter", self.nSelectedId)
  if characterConfig == nil then
    return
  end
  local skillConfig = ConfigTable.GetData("Skill", characterConfig.NormalAtkId)
  if skillConfig == nil then
    return
  end
  local skill1 = self._mapNode.skill[1]
  local skill1_icon = skill1.transform:Find("skill/AnimRoot/imgIcon")
  local skill1_name = skill1.transform:Find("GameObject/t_common_04/imgBg/txtTitle")
  local skill1_des = skill1.transform:Find("GameObject/txt_content")
  local skill1_type = skill1.transform:Find("skill/AnimRoot/imgType")
  local skill1_bg1 = skill1.transform:Find("skill/AnimRoot/imgBg1")
  local skill1_bg2 = skill1.transform:Find("skill/AnimRoot/imgBg2")
  if skillConfig.Icon ~= nil and skillConfig.Icon ~= "" then
    self:SetPngSprite(skill1_icon:GetComponent("Image"), skillConfig.Icon)
  end
  self:SetAtlasSprite(skill1_type:GetComponent("Image"), "05_language", "zs_character_skill_text_" .. skillConfig.Type)
  NovaAPI.SetTMPText(skill1_name:GetComponent("TMP_Text"), skillConfig.Title)
  NovaAPI.SetTMPText(skill1_des:GetComponent("TMP_Text"), skillConfig.Desc)
  local atkSkillConfig = ConfigTable.GetData("Skill", characterConfig.SkillId)
  if atkSkillConfig == nil then
    return
  end
  local skill2 = self._mapNode.skill[2]
  local skill2_icon = skill2.transform:Find("skill/AnimRoot/imgIcon")
  local skill2_name = skill2.transform:Find("GameObject/t_common_04/imgBg/txtTitle")
  local skill2_des = skill2.transform:Find("GameObject/txt_content")
  local skill2_type = skill2.transform:Find("skill/AnimRoot/imgType")
  local skill2_bg1 = skill2.transform:Find("skill/AnimRoot/imgBg1")
  local skill2_bg2 = skill2.transform:Find("skill/AnimRoot/imgBg2")
  if atkSkillConfig.Icon ~= nil and atkSkillConfig.Icon ~= "" then
    self:SetPngSprite(skill2_icon:GetComponent("Image"), atkSkillConfig.Icon)
  end
  self:SetAtlasSprite(skill2_type:GetComponent("Image"), "05_language", "zs_character_skill_text_" .. atkSkillConfig.Type)
  NovaAPI.SetTMPText(skill2_name:GetComponent("TMP_Text"), atkSkillConfig.Title)
  NovaAPI.SetTMPText(skill2_des:GetComponent("TMP_Text"), atkSkillConfig.Desc)
  local EETConfig = ConfigTable.GetData("MonsterValueTempleteAdjust", characterConfig.Templete)
  if EETConfig ~= nil then
    local sName = AllEnum.ElementIconType.SkillEx .. EETConfig.EET
    self:SetAtlasSprite(skill1_bg1:GetComponent("Image"), "12_rare", sName)
    self:SetAtlasSprite(skill2_bg1:GetComponent("Image"), "12_rare", sName)
    local _, color = ColorUtility.TryParseHtmlString(AllEnum.SkillElementBgColor[EETConfig.EET])
    NovaAPI.SetImageColor(skill1_bg2:GetComponent("Image"), Color(color.r, color.g, color.b, 0.2980392156862745))
    NovaAPI.SetImageColor(skill2_bg2:GetComponent("Image"), Color(color.r, color.g, color.b, 0.2980392156862745))
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.skill[1].gameObject:GetComponent("RectTransform"))
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.skill[2].gameObject:GetComponent("RectTransform"))
  end
  
  cs_coroutine.start(wait)
end

function TowerDefenseCharacterDetailCtrl:SetPotentialDes()
  local tbPotentialList = self.TowerdefenseLevelData:GetPotentialByChar(self.nSelectedId)
  self._mapNode.go_potential1:SetActive(false)
  self._mapNode.go_potential2:SetActive(false)
  if tbPotentialList == nil then
    return
  end
  local corePotentialId, normalPotentialId = 0, 0
  for _, potentialId in pairs(tbPotentialList) do
    local config = ConfigTable.GetData("TowerDefensePotential", potentialId)
    if config ~= nil then
      if config.Rarity == GameEnum.itemRarity.SSR then
        corePotentialId = config.Id
      elseif config.Rarity == GameEnum.itemRarity.SR then
        normalPotentialId = config.Id
      end
    end
  end
  if normalPotentialId ~= 0 then
    local corePotentialConfig = ConfigTable.GetData("TowerDefensePotential", normalPotentialId)
    local icon = self._mapNode.go_potential1.transform:Find("icon/img_bgNormal/icon")
    local txtTitle = self._mapNode.go_potential1.transform:Find("GameObject/t_common_04/imgBg/txtTitle")
    local txt_content = self._mapNode.go_potential1.transform:Find("GameObject/txt_content")
    if corePotentialConfig.Icon ~= nil and corePotentialConfig.Icon ~= "" then
      self:SetPngSprite(icon:GetComponent("Image"), corePotentialConfig.Icon .. AllEnum.PotentialIconSurfix.A)
    end
    NovaAPI.SetTMPText(txtTitle:GetComponent("TMP_Text"), corePotentialConfig.Name)
    NovaAPI.SetTMPText(txt_content:GetComponent("TMP_Text"), corePotentialConfig.PotentialDes)
  end
  if corePotentialId ~= 0 then
    local basePotentialConfig = ConfigTable.GetData("TowerDefensePotential", corePotentialId)
    local icon = self._mapNode.go_potential2.transform:Find("icon/img_bgCore/icon")
    local txtTitle = self._mapNode.go_potential2.transform:Find("GameObject/t_common_04/imgBg/txtTitle")
    local txt_content = self._mapNode.go_potential2.transform:Find("GameObject/txt_content")
    if basePotentialConfig.Icon ~= nil and basePotentialConfig.Icon ~= "" then
      self:SetPngSprite(icon:GetComponent("Image"), basePotentialConfig.Icon .. AllEnum.PotentialIconSurfix.A)
    end
    NovaAPI.SetTMPText(txtTitle:GetComponent("TMP_Text"), basePotentialConfig.Name)
    NovaAPI.SetTMPText(txt_content:GetComponent("TMP_Text"), basePotentialConfig.PotentialDes)
  end
  self._mapNode.go_potential1:SetActive(normalPotentialId ~= 0)
  self._mapNode.go_potential2:SetActive(corePotentialId ~= 0)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.go_potential1:GetComponent("RectTransform"))
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.go_potential2:GetComponent("RectTransform"))
  end
  
  cs_coroutine.start(wait)
end

function TowerDefenseCharacterDetailCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local img_head = goGrid.transform:Find("btn_grid/AnimRoot/icon_head"):GetComponent("Image")
  local txt_name = goGrid.transform:Find("btn_grid/AnimRoot/txt_name"):GetComponent("TMP_Text")
  local go_selected = goGrid.transform:Find("btn_grid/AnimRoot/bg_selected")
  local bSelected = self.characterList[nIndex] == self.nSelectedId
  local config = ConfigTable.GetData("TowerDefenseCharacter", self.characterList[nIndex])
  if config == nil then
    return
  end
  if config.Icon ~= nil and config.Icon ~= "" then
    self:SetPngSprite(img_head, config.Icon .. AllEnum.CharHeadIconSurfix.QS)
  end
  NovaAPI.SetTMPText(txt_name, config.Name)
  if bSelected then
    NovaAPI.SetTMPColor(txt_name, SelectedColor)
    self.selectedGrid = goGrid
  else
    NovaAPI.SetTMPColor(txt_name, NormalColor)
  end
  
  local function cb()
    if self.selectedGrid ~= nil then
      local go_selected = self.selectedGrid.transform:Find("btn_grid/AnimRoot/bg_selected")
      local txt_name = self.selectedGrid.transform:Find("btn_grid/AnimRoot/txt_name"):GetComponent("TMP_Text")
      NovaAPI.SetTMPColor(txt_name, NormalColor)
      go_selected.gameObject:SetActive(false)
    end
    self.nSelectedId = self.characterList[nIndex]
    local go_selected = goGrid.transform:Find("btn_grid/AnimRoot/bg_selected")
    local txt_name = goGrid.transform:Find("btn_grid/AnimRoot/txt_name"):GetComponent("TMP_Text")
    NovaAPI.SetTMPColor(txt_name, SelectedColor)
    go_selected.gameObject:SetActive(true)
    self.selectedGrid = goGrid
    self:RefreshInfoData()
    self:OnTabSelected(1)
  end
  
  local btn = goGrid.transform:Find("btn_grid"):GetComponent("UIButton")
  btn.onClick:RemoveAllListeners()
  btn.onClick:AddListener(cb)
  go_selected.gameObject:SetActive(bSelected)
end

function TowerDefenseCharacterDetailCtrl:OnTabSelected(nIndex)
  local btn_potential = self._mapNode.btn_potential
  local potential_Normal = btn_potential.gameObject.transform:Find("AnimRoot/go_normal")
  local potential_Select = btn_potential.gameObject.transform:Find("AnimRoot/go_selected")
  potential_Normal.gameObject:SetActive(nIndex ~= 1)
  potential_Select.gameObject:SetActive(nIndex == 1)
  local btn_skill = self._mapNode.btn_skill
  local skill_Normal = btn_skill.gameObject.transform:Find("AnimRoot/go_normal")
  local skill_Select = btn_skill.gameObject.transform:Find("AnimRoot/go_selected")
  skill_Normal.gameObject:SetActive(nIndex ~= 2)
  skill_Select.gameObject:SetActive(nIndex == 2)
  self._mapNode.skill_sv:SetActive(nIndex == 2)
  local bShowPotential = false
  if nIndex == 1 then
    local tbPotentialList = self.TowerdefenseLevelData:GetPotentialByChar(self.nSelectedId)
    if tbPotentialList ~= nil then
      for _, potentialId in pairs(tbPotentialList) do
        local config = ConfigTable.GetData("TowerDefensePotential", potentialId)
        if config ~= nil and (config.Rarity == GameEnum.itemRarity.SSR or config.Rarity == GameEnum.itemRarity.SR) then
          bShowPotential = true
          break
        end
      end
    end
  end
  self._mapNode.potential_sv:SetActive(nIndex == 1 and bShowPotential)
  self._mapNode.empty_potential:SetActive(nIndex == 1 and not bShowPotential)
end

function TowerDefenseCharacterDetailCtrl:OnEvent_AAA()
end

function TowerDefenseCharacterDetailCtrl:OnBtn_PotentialTab_OnClisk()
  self:OnTabSelected(1)
end

function TowerDefenseCharacterDetailCtrl:OnBtn_SkillTab_OnClisk()
  self:OnTabSelected(2)
end

function TowerDefenseCharacterDetailCtrl:OnEvent_Close(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.TowerDefenseCharacterDetailPanel)
end

return TowerDefenseCharacterDetailCtrl
