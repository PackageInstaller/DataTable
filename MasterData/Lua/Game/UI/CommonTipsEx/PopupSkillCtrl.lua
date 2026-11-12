local PopupSkillCtrl = class("PopupSkillCtrl", BaseCtrl)
local ConfigData = require("GameCore.Data.ConfigData")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local AdventureModuleHelper = CS.AdventureModuleHelper
local nMaxHeight = 395
PopupSkillCtrl._mapNodeConfig = {
  btnCloseScreen = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnSuportSkill1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  btnSuportSkill2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  btnSupportUltra1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  btnSupportUltra2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  btnSkill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  btnUltra = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  btnTarget = {
    sComponentName = "ButtonEx",
    callback = "OnBtnClick_Skill"
  },
  btnDodge = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  type_s1 = {sComponentName = "Image"},
  type_s2 = {sComponentName = "Image"},
  type_u1 = {sComponentName = "Image"},
  type_u2 = {sComponentName = "Image"},
  imgSubSkillIcon = {nCount = 2, sComponentName = "Image"},
  imgRoleHeadIcon = {
    nCount = 2,
    sNodeName = "suportRole",
    sComponentName = "Image"
  },
  imgUltraSkillIcon = {nCount = 2, sComponentName = "Image"},
  EmptySupportSkill = {nCount = 2},
  EmptySupportUltra = {nCount = 2},
  mainSupportSkill = {nCount = 2},
  mainSupportUltra = {nCount = 2},
  imgUltraIcon = {sComponentName = "Image"},
  imgSkillIcon = {sComponentName = "Image"},
  imgDodgeIcon = {sComponentName = "Image"},
  type_u0 = {sComponentName = "Image"},
  imgType0 = {sComponentName = "Image"},
  imgSkillIconBg = {sComponentName = "Image"},
  imgzsIcon = {sComponentName = "Image"},
  imgIconSkill = {sComponentName = "Image"},
  imgSkillTypeBg = {sComponentName = "Image"},
  txtSkillType = {sComponentName = "TMP_Text"},
  imgSkillType = {sComponentName = "Image"},
  TMPTitle = {sComponentName = "TMP_Text"},
  txtSkillLevel = {sComponentName = "TMP_Text"},
  imgEnergyInfoBg = {},
  imgCDInfoBg = {},
  srSkillDesc = {
    sComponentName = "RectTransform"
  },
  TMP_Link = {
    sNodeName = "TMPDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnLinkClick_Word"
  },
  TMPCDTitle = {sComponentName = "TMP_Text", sLanguageId = "Talent_CD"},
  TMPCD = {sComponentName = "TMP_Text"},
  TMPEnergyTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Talent_Cost"
  },
  TMPEnergy = {sComponentName = "TMP_Text"},
  TMPDesc = {sComponentName = "TMP_Text"},
  rtTMPDesc = {
    sComponentName = "RectTransform",
    sNodeName = "TMPDesc"
  },
  aniBlur = {sComponentName = "Animator"},
  aniBlur2 = {sComponentName = "Animator"},
  aniImgBg = {sComponentName = "Animator"},
  ActionBar = {
    sCtrlName = "Game.UI.ActionBar.ActionBarCtrl"
  },
  btnShortcutClose = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Close"
  },
  txtTitleSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "Skill_Branch_SkillInfo"
  },
  TMPHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "PopupSkill_Hint"
  },
  switch_name = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharSkillDescType"
  },
  btnSwitch_on = {
    sComponentName = "UIButton",
    callback = "OnEvent_SetDesc"
  },
  btnSwitch_off = {
    sComponentName = "UIButton",
    callback = "OnEvent_SetSimpleDesc"
  },
  go_Simple = {
    sComponentName = "RectTransform"
  },
  imgBg_SupportRole = {},
  SupSkill1_Pos = {sComponentName = "Transform"},
  SupUltra1_Pos = {sComponentName = "Transform"},
  SupRole1_Pos = {sComponentName = "Transform"},
  SupSkill2_Pos = {sComponentName = "Transform"},
  SupUltra2_Pos = {sComponentName = "Transform"},
  SupRole2_Pos = {sComponentName = "Transform"},
  MainDodge_Pos = {sComponentName = "Transform"},
  MainSkill_Pos = {sComponentName = "Transform"},
  MainUltra_Pos = {sComponentName = "Transform"},
  SupSkill1_Pos_Hor = {sComponentName = "Transform"},
  SupUltra1_Pos_Hor = {sComponentName = "Transform"},
  SupRole1_Pos_Hor = {sComponentName = "Transform"},
  SupSkill2_Pos_Hor = {sComponentName = "Transform"},
  SupUltra2_Pos_Hor = {sComponentName = "Transform"},
  SupRole2_Pos_Hor = {sComponentName = "Transform"},
  MainDodge_Pos_Hor = {sComponentName = "Transform"},
  MainSkill_Pos_Hor = {sComponentName = "Transform"},
  MainUltra_Pos_Hor = {sComponentName = "Transform"}
}
PopupSkillCtrl._mapEventConfig = {}

function PopupSkillCtrl:Awake()
  self._mapNode.btnShortcutClose.gameObject:SetActive(GamepadUIManager.GetInputState())
  if GamepadUIManager.GetInputState() then
    local tbConfig = {
      {
        sAction = "Back",
        sLang = "ActionBar_Back"
      }
    }
    self._mapNode.ActionBar:InitActionBar(tbConfig)
  end
end

function PopupSkillCtrl:FadeIn()
end

function PopupSkillCtrl:FadeOut()
end

function PopupSkillCtrl:OnEnable()
  self._mapNode.aniImgBg:Play("t_window_04_t_in")
  local tbParam = self:GetPanelParam()
  self.tbChar = tbParam[1]
  local bNoMask = tbParam[2]
  local tbTrialId = tbParam[3]
  self.mapCharInfo = tbParam[4]
  local nSelectCharId = tbParam[5]
  self.bOutBattle = tbParam[6]
  self._mapNode.aniBlur.gameObject:SetActive(not bNoMask)
  self._mapNode.aniBlur2.gameObject:SetActive(bNoMask)
  self.mapCharSkill = {}
  local bTrial = tbTrialId and 0 < #tbTrialId
  for k, nCharId in ipairs(self.tbChar) do
    local mapChar = self.mapCharInfo and self.mapCharInfo[nCharId]
    if mapChar and mapChar.tbSkillAddedLvs then
      self.mapCharSkill[nCharId] = clone(mapChar.tbSkillAddedLvs)
    elseif bTrial then
      self.mapCharSkill[nCharId] = PlayerData.Char:GetTrialCharSkillAddedLevel(tbTrialId[k])
    elseif self.mapCharInfo == nil or next(self.mapCharInfo) == nil then
      self.mapCharSkill[nCharId] = PlayerData.Char:GetCharSkillAddedLevel(nCharId)
    else
      self.mapCharSkill[nCharId] = clone(self.mapCharInfo[nCharId].tbSkillLvs)
      table.insert(self.mapCharSkill[nCharId], 3, self.mapCharSkill[nCharId][2])
    end
  end
  self.mapBtnFunc = {}
  local mapCfgDataMain = ConfigTable.GetData_Character(self.tbChar[1])
  local mapSkillMain = ConfigTable.GetData_Skill(mapCfgDataMain.SkillId)
  local mapSkillUltra = ConfigTable.GetData_Skill(mapCfgDataMain.UltimateId)
  local mapSkillDodge = ConfigTable.GetData_Skill(mapCfgDataMain.DodgeId)
  self:SetPngSprite(self._mapNode.imgUltraIcon, mapSkillUltra.Icon)
  self:SetPngSprite(self._mapNode.imgSkillIcon, mapSkillMain.Icon)
  self:SetPngSprite(self._mapNode.imgDodgeIcon, mapSkillDodge.Icon)
  self:SetAtlasSprite(self._mapNode.type_u0, "15_battle", "skill_btn_b_type_" .. mapCfgDataMain.EET)
  self:SetAtlasSprite(self._mapNode.imgType0, "15_battle", "skill_btn_b_type_" .. mapCfgDataMain.EET)
  if self.tbChar[2] then
    local mapCfgDataSub1 = ConfigTable.GetData_Character(self.tbChar[2])
    local mapSkillSub1 = ConfigTable.GetData_Skill(mapCfgDataSub1.AssistSkillId)
    local mapSkillUltraSub1 = ConfigTable.GetData_Skill(mapCfgDataSub1.UltimateId)
    self:SetPngSprite(self._mapNode.imgSubSkillIcon[1], mapSkillSub1.Icon)
    self:SetPngSprite(self._mapNode.imgUltraSkillIcon[1], mapSkillUltraSub1.Icon)
    local mapCharSub1 = self.mapCharInfo and self.mapCharInfo[self.tbChar[2]]
    local nCharSkinId1 = mapCharSub1 and mapCharSub1.nSkinId or PlayerData.Char:GetCharSkinId(self.tbChar[2])
    local mapCharSkin1 = ConfigTable.GetData_CharacterSkin(nCharSkinId1)
    self:SetPngSprite(self._mapNode.imgRoleHeadIcon[1], mapCharSkin1.Icon, AllEnum.CharHeadIconSurfix.L)
    self:SetAtlasSprite(self._mapNode.type_u1, "15_battle", "skill_btn_b_type_" .. mapCfgDataSub1.EET)
    self:SetAtlasSprite(self._mapNode.type_s1, "15_battle", "skill_btn_b_type_" .. mapCfgDataSub1.EET)
    self._mapNode.EmptySupportSkill[1]:SetActive(false)
    self._mapNode.EmptySupportUltra[1]:SetActive(false)
    self._mapNode.mainSupportSkill[1]:SetActive(true)
    self._mapNode.mainSupportUltra[1]:SetActive(true)
    self._mapNode.imgRoleHeadIcon[1].gameObject:SetActive(true)
    self.mapBtnFunc[self._mapNode.btnSuportSkill1] = {
      mapCfgDataSub1.AssistSkillId,
      self.mapCharSkill[self.tbChar[2]][3],
      self.tbChar[2],
      3
    }
    self.mapBtnFunc[self._mapNode.btnSupportUltra1] = {
      mapCfgDataSub1.UltimateId,
      self.mapCharSkill[self.tbChar[2]][4],
      self.tbChar[2],
      4
    }
  else
    self._mapNode.EmptySupportSkill[1]:SetActive(true)
    self._mapNode.EmptySupportUltra[1]:SetActive(true)
    self._mapNode.mainSupportSkill[1]:SetActive(false)
    self._mapNode.mainSupportUltra[1]:SetActive(false)
    self._mapNode.imgRoleHeadIcon[1].gameObject:SetActive(false)
  end
  if self.tbChar[3] then
    local mapCfgDataSub2 = ConfigTable.GetData_Character(self.tbChar[3])
    local mapSkillSub2 = ConfigTable.GetData_Skill(mapCfgDataSub2.AssistSkillId)
    local mapSkillUltraSub2 = ConfigTable.GetData_Skill(mapCfgDataSub2.UltimateId)
    self:SetPngSprite(self._mapNode.imgSubSkillIcon[2], mapSkillSub2.Icon)
    self:SetPngSprite(self._mapNode.imgUltraSkillIcon[2], mapSkillUltraSub2.Icon)
    local mapCharSub2 = self.mapCharInfo and self.mapCharInfo[self.tbChar[3]]
    local nCharSkinId2 = mapCharSub2 and mapCharSub2.nSkinId or PlayerData.Char:GetCharSkinId(self.tbChar[3])
    local mapCharSkin2 = ConfigTable.GetData_CharacterSkin(nCharSkinId2)
    self:SetPngSprite(self._mapNode.imgRoleHeadIcon[2], mapCharSkin2.Icon, AllEnum.CharHeadIconSurfix.L)
    self:SetAtlasSprite(self._mapNode.type_u2, "15_battle", "skill_btn_b_type_" .. mapCfgDataSub2.EET)
    self:SetAtlasSprite(self._mapNode.type_s2, "15_battle", "skill_btn_b_type_" .. mapCfgDataSub2.EET)
    self._mapNode.EmptySupportSkill[2]:SetActive(false)
    self._mapNode.EmptySupportUltra[2]:SetActive(false)
    self._mapNode.mainSupportSkill[2]:SetActive(true)
    self._mapNode.mainSupportUltra[2]:SetActive(true)
    self._mapNode.imgRoleHeadIcon[2].gameObject:SetActive(true)
    self.mapBtnFunc[self._mapNode.btnSuportSkill2] = {
      mapCfgDataSub2.AssistSkillId,
      self.mapCharSkill[self.tbChar[3]][3],
      self.tbChar[3],
      3
    }
    self.mapBtnFunc[self._mapNode.btnSupportUltra2] = {
      mapCfgDataSub2.UltimateId,
      self.mapCharSkill[self.tbChar[3]][4],
      self.tbChar[3],
      4
    }
  else
    self._mapNode.EmptySupportSkill[2]:SetActive(true)
    self._mapNode.EmptySupportUltra[2]:SetActive(true)
    self._mapNode.mainSupportSkill[2]:SetActive(false)
    self._mapNode.mainSupportUltra[2]:SetActive(false)
    self._mapNode.imgRoleHeadIcon[2].gameObject:SetActive(false)
  end
  self.mapBtnFunc[self._mapNode.btnSkill] = {
    mapCfgDataMain.SkillId,
    self.mapCharSkill[self.tbChar[1]][2],
    self.tbChar[1],
    2
  }
  self.mapBtnFunc[self._mapNode.btnUltra] = {
    mapCfgDataMain.UltimateId,
    self.mapCharSkill[self.tbChar[1]][4],
    self.tbChar[1],
    4
  }
  self.mapBtnFunc[self._mapNode.btnTarget] = {"MsgTarget"}
  self.mapBtnFunc[self._mapNode.btnDodge] = {"MsgDodge"}
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("PopupSkillCtrl", self:GetGamepadUINode(), nil, true)
  end
  self:SetKeyLayout()
  if nSelectCharId ~= nil then
    for k, v in ipairs(self.tbChar) do
      if v == nSelectCharId then
        if k == 1 then
          self:OnBtnClick_Skill(self._mapNode.btnSkill)
        elseif k == 2 then
          self:OnBtnClick_Skill(self._mapNode.btnSuportSkill1)
        elseif k == 3 then
          self:OnBtnClick_Skill(self._mapNode.btnSuportSkill2)
        end
      end
    end
  else
    self.curButton = self._mapNode.btnSkill
    self:SetSkill(mapCfgDataMain.SkillId, self.mapCharSkill[self.tbChar[1]][2], self.tbChar[1], 2)
    self:SetSelect(self._mapNode.btnSkill, true)
  end
end

function PopupSkillCtrl:SetSelect(goTarget, bSelect)
  local goSelect = goTarget.transform:Find("imgSelect")
  if goSelect ~= nil then
    goSelect.gameObject:SetActive(bSelect)
  end
end

function PopupSkillCtrl:OnDisable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("PopupSkillCtrl")
  end
end

function PopupSkillCtrl:OnDestroy()
end

function PopupSkillCtrl:OnRelease()
end

function PopupSkillCtrl:SetSkill(nSkillId, nLevel, nCharId, nType)
  self.nLevel = nLevel
  local mapCharCfgData = ConfigTable.GetData_Character(nCharId)
  local mapCfgDataSkill = ConfigTable.GetData_Skill(nSkillId)
  local nCD = FormatNum(mapCfgDataSkill.SkillCD * ConfigData.IntFloatPrecision)
  local nCost = FormatNum(mapCfgDataSkill.UltraEnergy * ConfigData.IntFloatPrecision)
  NovaAPI.SetTMPText(self._mapNode.txtSkillLevel, ConfigTable.GetUIText("Skill_Level") .. nLevel)
  self:SetAtlasSprite(self._mapNode.imgSkillIconBg, "12_rare", AllEnum.ElementIconType.SkillEx .. mapCharCfgData.EET)
  self:SetPngSprite(self._mapNode.imgIconSkill, mapCfgDataSkill.Icon)
  local skillShowCfg = AllEnum.SkillTypeShow[nType]
  NovaAPI.SetTMPText(self._mapNode.txtSkillType, ConfigTable.GetUIText(skillShowCfg.sLanguageId))
  self:SetAtlasSprite(self._mapNode.imgzsIcon, "10_ico", "zs_character_skill_" .. skillShowCfg.bgIconIndex)
  local _, color = ColorUtility.TryParseHtmlString(AllEnum.SkillElementBgColor[mapCharCfgData.EET])
  NovaAPI.SetImageColor(self._mapNode.imgzsIcon, Color(color.r, color.g, color.b, 0.19607843137254902))
  local skillTypeIconIdx = skillShowCfg.iconIndex
  self:SetAtlasSprite(self._mapNode.imgSkillType, "05_language", "zs_character_skill_text_" .. skillTypeIconIdx)
  NovaAPI.SetImageNativeSize(self._mapNode.imgSkillType)
  local _, _color = ColorUtility.TryParseHtmlString(skillShowCfg.bgColor)
  NovaAPI.SetImageColor(self._mapNode.imgSkillTypeBg, _color)
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, string.format("%s·%s", mapCharCfgData.Name, mapCfgDataSkill.Title))
  local sCD = tostring(nCD) .. ConfigTable.GetUIText("Talent_Sec")
  local sCost = tostring(nCost)
  if not self.bOutBattle then
    local actorIdCSList = AdventureModuleHelper.GetCurrentGroupPlayers()
    if actorIdCSList ~= nil then
      for i = 0, actorIdCSList.Count - 1 do
        local characterId = AdventureModuleHelper.GetCharacterId(actorIdCSList[i])
        if characterId and 0 < characterId and characterId == nCharId then
          local skillCd = AdventureModuleHelper.GetPlayerSkillCd(actorIdCSList[i])
          if skillCd then
            sCost = tostring(skillCd:GetTotalEnergy())
          end
          break
        end
      end
    end
  end
  if nCD <= 0 then
    sCD = ConfigTable.GetUIText("Skill_NoCD")
  end
  if nCost <= 0 then
    sCost = ConfigTable.GetUIText("Skill_NoCost")
  end
  NovaAPI.SetTMPText(self._mapNode.TMPCD, sCD)
  NovaAPI.SetTMPText(self._mapNode.TMPEnergy, sCost)
  local bVisibleCD, bVisibleCost = false, false
  if mapCfgDataSkill.Type == GameEnum.skillType.NORMAL then
    bVisibleCD, bVisibleCost = false, false
  elseif mapCfgDataSkill.Type == GameEnum.skillType.SKILL or mapCfgDataSkill.Type == GameEnum.skillType.SUPPORT then
    bVisibleCD, bVisibleCost = true, false
  elseif mapCfgDataSkill.Type == GameEnum.skillType.ULTIMATE then
    bVisibleCD, bVisibleCost = true, true
  end
  self._mapNode.imgEnergyInfoBg:SetActive(bVisibleCD or bVisibleCost)
  self._mapNode.imgCDInfoBg:SetActive(bVisibleCD)
  local bIsSimpleDescType = PlayerData.Char:GetTipsPanelSkillDescType()
  self._mapNode.btnSwitch_on.gameObject:SetActive(bIsSimpleDescType)
  self._mapNode.btnSwitch_off.gameObject:SetActive(not bIsSimpleDescType)
  local sDesc = ""
  if bIsSimpleDescType then
    sDesc = UTILS.ParseDesc(mapCfgDataSkill, nil, nil, true)
  else
    sDesc = UTILS.ParseDesc(mapCfgDataSkill)
  end
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, sDesc)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    local nHeight = self._mapNode.rtTMPDesc.sizeDelta.y + 12
    if nHeight > nMaxHeight then
      nHeight = nMaxHeight
    end
    self._mapNode.srSkillDesc.sizeDelta = Vector2(self._mapNode.srSkillDesc.sizeDelta.x, nHeight)
    self._mapNode.go_Simple.anchoredPosition = Vector2(self._mapNode.go_Simple.anchoredPosition.x, self._mapNode.srSkillDesc.anchoredPosition.y - nHeight - 33)
  end
  
  cs_coroutine.start(wait)
end

function PopupSkillCtrl:DelayAnimClose()
  EventManager.Hit(EventId.ClosePanel, PanelId.PopupSkillPanel)
end

function PopupSkillCtrl:OnBtnClick_Close(btn)
  self._mapNode.aniImgBg:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  self:AddTimer(1, 0.3, "DelayAnimClose", true, true, true, false)
end

function PopupSkillCtrl:OnBtnClick_Skill(btn)
  if self.mapBtnFunc[btn] ~= nil then
    if type(self.mapBtnFunc[btn][1]) == "string" then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PopupSkill_" .. self.mapBtnFunc[btn][1]))
    else
      self:SetSkill(self.mapBtnFunc[btn][1], self.mapBtnFunc[btn][2], self.mapBtnFunc[btn][3], self.mapBtnFunc[btn][4])
      if self.curButton ~= nil then
        self:SetSelect(self.curButton, false)
      end
      self:SetSelect(btn, true)
      self.curButton = btn
    end
  end
end

function PopupSkillCtrl:OnLinkClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function PopupSkillCtrl:SetKeyLayout()
  local nType = LocalSettingData.GetLocalSettingData("BattleHUD")
  if nType == AllEnum.BattleHudType.Horizontal then
    self:SetKeyPos(self._mapNode.btnSuportSkill1.gameObject:GetComponent("RectTransform"), self._mapNode.SupSkill1_Pos_Hor)
    self:SetKeyPos(self._mapNode.btnSupportUltra1.gameObject:GetComponent("RectTransform"), self._mapNode.SupUltra1_Pos_Hor)
    self:SetKeyPos(self._mapNode.imgRoleHeadIcon[1].gameObject:GetComponent("RectTransform"), self._mapNode.SupRole1_Pos_Hor)
    self:SetKeyPos(self._mapNode.btnSuportSkill2.gameObject:GetComponent("RectTransform"), self._mapNode.SupSkill2_Pos_Hor)
    self:SetKeyPos(self._mapNode.btnSupportUltra2.gameObject:GetComponent("RectTransform"), self._mapNode.SupUltra2_Pos_Hor)
    self:SetKeyPos(self._mapNode.imgRoleHeadIcon[2].gameObject:GetComponent("RectTransform"), self._mapNode.SupRole2_Pos_Hor)
    self:SetKeyPos(self._mapNode.btnDodge.gameObject:GetComponent("RectTransform"), self._mapNode.MainDodge_Pos_Hor)
    self:SetKeyPos(self._mapNode.btnSkill.gameObject:GetComponent("RectTransform"), self._mapNode.MainSkill_Pos_Hor)
    self:SetKeyPos(self._mapNode.btnUltra.gameObject:GetComponent("RectTransform"), self._mapNode.MainUltra_Pos_Hor)
  else
    self:SetKeyPos(self._mapNode.btnSuportSkill1.gameObject:GetComponent("RectTransform"), self._mapNode.SupSkill1_Pos)
    self:SetKeyPos(self._mapNode.btnSupportUltra1.gameObject:GetComponent("RectTransform"), self._mapNode.SupUltra1_Pos)
    self:SetKeyPos(self._mapNode.imgRoleHeadIcon[1].gameObject:GetComponent("RectTransform"), self._mapNode.SupRole1_Pos)
    self:SetKeyPos(self._mapNode.btnSuportSkill2.gameObject:GetComponent("RectTransform"), self._mapNode.SupSkill2_Pos)
    self:SetKeyPos(self._mapNode.btnSupportUltra2.gameObject:GetComponent("RectTransform"), self._mapNode.SupUltra2_Pos)
    self:SetKeyPos(self._mapNode.imgRoleHeadIcon[2].gameObject:GetComponent("RectTransform"), self._mapNode.SupRole2_Pos)
    self:SetKeyPos(self._mapNode.btnDodge.gameObject:GetComponent("RectTransform"), self._mapNode.MainDodge_Pos)
    self:SetKeyPos(self._mapNode.btnSkill.gameObject:GetComponent("RectTransform"), self._mapNode.MainSkill_Pos)
    self:SetKeyPos(self._mapNode.btnUltra.gameObject:GetComponent("RectTransform"), self._mapNode.MainUltra_Pos)
  end
  self._mapNode.imgBg_SupportRole:SetActive(nType == AllEnum.BattleHudType.Sector)
end

function PopupSkillCtrl:SetKeyPos(btnTra, parentTra)
  btnTra:SetParent(parentTra)
  btnTra.anchoredPosition = Vector2.zero
  btnTra.localScale = Vector3.one
end

function PopupSkillCtrl:OnEvent_SetSimpleDesc()
  PlayerData.Char:SetTipsPanelSkillDescType(true)
  self:SetSkill(self.mapBtnFunc[self.curButton][1], self.mapBtnFunc[self.curButton][2], self.mapBtnFunc[self.curButton][3], self.mapBtnFunc[self.curButton][4])
end

function PopupSkillCtrl:OnEvent_SetDesc()
  PlayerData.Char:SetTipsPanelSkillDescType(false)
  self:SetSkill(self.mapBtnFunc[self.curButton][1], self.mapBtnFunc[self.curButton][2], self.mapBtnFunc[self.curButton][3], self.mapBtnFunc[self.curButton][4])
end

return PopupSkillCtrl
