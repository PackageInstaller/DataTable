local CharacterInfoCtrl = class("CharacterInfoCtrl", BaseCtrl)
local CharacterAttrData = require("GameCore.Data.DataClass.CharacterAttrData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local typeof = _ENV.typeof
local PropertyIndexList = {
  Simple = {
    1,
    2,
    3
  },
  Detail = {
    1,
    2,
    3,
    4,
    5,
    6,
    13,
    7,
    8,
    9,
    10,
    11,
    12
  }
}
local talent_skill_bg_fold = 76
local talent_skill_bg_unFold = 351.6
CharacterInfoCtrl._mapNodeConfig = {
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  Drag = {},
  txtCharLevel = {sComponentName = "TMP_Text"},
  txtTitleRank = {
    sComponentName = "TMP_Text",
    sLanguageId = "Template_CharRank"
  },
  txtLevelMax = {sComponentName = "TMP_Text"},
  goStarAdvance = {
    sNodeName = "tc_star_advance",
    sCtrlName = "Game.UI.TemplateEx.TemplateStarAdvanceCtrl"
  },
  goProperty = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplatePropertyCtrl"
  },
  txtTitleProperty = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterInfo_Property"
  },
  txtBtnProperty = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterInfo_Btn_Property"
  },
  btnProperty = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Property"
  },
  btnDevelopment = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Development"
  },
  txtBtnDevelopment = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterInfo_Btn_Development"
  },
  txtCharDesc = {sComponentName = "TMP_Text"},
  ScrollView = {sComponentName = "ScrollRect"},
  txtFavorCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterInfo_Favor"
  },
  tc_affinity_level = {
    sCtrlName = "Game.UI.TemplateEx.TemplateAffinityLevelCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  imgRareName = {sComponentName = "Image"},
  imgCharColor = {sComponentName = "Image"},
  imgTag = {nCount = 3},
  txtTag = {nCount = 3, sComponentName = "TMP_Text"},
  txtElement = {sComponentName = "TMP_Text"},
  imgElementIcon = {sComponentName = "Image"},
  btnSkin = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenSkinPanel"
  },
  btnCloseWordTip = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWordTip"
  },
  btnSetFavorite = {
    sComponentName = "Button",
    callback = "OnBtnClick_btnSetFavorite"
  },
  favorite_on = {
    sNodeName = "Favorite_on",
    sComponentName = "CanvasGroup"
  },
  imgWordTipBg = {},
  TMPWordDesc = {sComponentName = "TMP_Text"},
  TMPWordTipsTitle = {sComponentName = "TMP_Text"},
  reddot = {}
}
CharacterInfoCtrl._mapEventConfig = {
  [EventId.ShowCharacterSkillTips] = "ShowCharacterSkillTips",
  [EventId.CharBgRefresh] = "OnEvent_RefreshPanel",
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelAdvance",
  [EventId.CharRelatePanelBack] = "OnEvent_PanelBack"
}

function CharacterInfoCtrl:PlayOpenAnim(nClosePanelId)
  if nClosePanelId == PanelId.CharUpPanel then
    self.ani:Play("CharacterInfoPanel_out", 0, 0)
  else
    self.ani:Play("CharacterInfoPanel_in", 0, 0)
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
end

function CharacterInfoCtrl:PlayCloseAnim()
end

function CharacterInfoCtrl:RefreshContent()
  local nCurPanelId = self._panel.nPanelId
  if nCurPanelId ~= PanelId.CharInfo then
    return
  end
  self.characterId = self._panel.nCharId
  self.characterIdList = self._panel.tbCharList
  local tempCharacterId = PlayerData.Char:TempGetCharInfoData()
  if type(tempCharacterId) == "number" then
    self.characterId = tempCharacterId
    PlayerData.Char:TempClearCharInfoData()
  end
  if type(self.characterId) ~= "number" then
    return
  end
  self.configData = ConfigTable.GetData_Character(self.characterId)
  for index, characterId in ipairs(self.characterIdList) do
    if self.characterId == characterId then
      self.curCharacterIndex = index
      break
    end
  end
  self.showDetail = false
  self:RefreshShow()
end

function CharacterInfoCtrl:InitBg()
  EventManager.Hit(EventId.CharBgRefresh, PanelId.CharInfo, self.characterId)
end

function CharacterInfoCtrl:RefreshShow()
  self:CalculateCharacterInfo()
  self:RefreshCharacterInfo()
  self:RefreshProperty()
end

function CharacterInfoCtrl:CalculateCharacterInfo()
  self:CalculateProperty()
end

function CharacterInfoCtrl:CalculateProperty()
  if not self.attrData then
    self.attrData = CharacterAttrData.new(self.characterId)
  else
    self.attrData:SetCharacter(self.characterId)
  end
end

function CharacterInfoCtrl:RefreshCharacterInfo()
  local data = PlayerData.Char._mapChar[self.characterId]
  local rankLevel = PlayerData.Char:GetCharLv(data.nId)
  local MaxLevel = PlayerData.Char:CalCharMaxLevel(data.nId)
  NovaAPI.SetTMPText(self._mapNode.txtCharLevel, rankLevel)
  NovaAPI.SetTMPText(self._mapNode.txtLevelMax, "/" .. MaxLevel)
  local tbAdvanceLevel = PlayerData.Char:GetAdvanceLevelTable()
  local nMaxAdvance = #tbAdvanceLevel[self.configData.Grade] - 1
  self._mapNode.goStarAdvance:SetStar(data.nAdvance, nMaxAdvance)
  local mapConfigDesc = ConfigTable.GetData("CharacterDes", self.configData.Id)
  local sDesc
  if mapConfigDesc ~= nil then
    sDesc = mapConfigDesc.CharDes
  else
    sDesc = ""
  end
  NovaAPI.SetTMPText(self._mapNode.txtCharDesc, sDesc)
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView, 1)
  local affinityData = PlayerData.Char:GetCharAffinityData(self.characterId)
  self._mapNode.tc_affinity_level:SetInfo(affinityData.Level)
  NovaAPI.SetTMPText(self._mapNode.txtName, self.configData.Name)
  self:SetSprite_FrameColor(self._mapNode.imgRareName, self.configData.Grade, AllEnum.FrameType_New.Text)
  NovaAPI.SetImageNativeSize(self._mapNode.imgRareName)
  local mapCharDescCfg = ConfigTable.GetData("CharacterDes", self.characterId)
  local sColor, tbTag
  if mapCharDescCfg ~= nil then
    sColor = mapCharDescCfg.CharColor
    tbTag = mapCharDescCfg.Tag
  else
    sColor = ""
    tbTag = {}
  end
  local _, colorChar = ColorUtility.TryParseHtmlString(sColor)
  NovaAPI.SetImageColor(self._mapNode.imgCharColor, colorChar)
  for i = 1, 3 do
    local nTag = tbTag[i]
    if nTag then
      self._mapNode.imgTag[i]:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtTag[i], ConfigTable.GetData("CharacterTag", nTag).Title)
    else
      self._mapNode.imgTag[i]:SetActive(false)
    end
  end
  local sName = AllEnum.ElementIconType.Icon .. self.configData.EET
  self:SetAtlasSprite(self._mapNode.imgElementIcon, "12_rare", sName)
  NovaAPI.SetTMPColor(self._mapNode.txtElement, AllEnum.ElementColor[self.configData.EET])
  NovaAPI.SetTMPText(self._mapNode.txtElement, ConfigTable.GetUIText("T_Element_Attr_" .. self.configData.EET))
  self:RefreshFavoriteState()
end

function CharacterInfoCtrl:RefreshProperty()
  local attrList = self.attrData:GetAttrList()
  for i = 1, #PropertyIndexList.Simple do
    local index = PropertyIndexList.Simple[i]
    local mapCharAttr = AllEnum.CharAttr[index]
    self._mapNode.goProperty[i]:SetCharProperty(mapCharAttr, attrList[index], true)
  end
end

function CharacterInfoCtrl:RefreshActor2D()
  EventManager.Hit(EventId.CharBgRefresh, PanelId.CharInfo, self.characterId)
end

function CharacterInfoCtrl:PlaySwitchAnim(nClosePanelId, nOpenPanelId, bBack)
  if nClosePanelId == PanelId.CharInfo then
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  end
  if nOpenPanelId == PanelId.CharInfo then
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    self:PlayOpenAnim(nClosePanelId)
  end
end

function CharacterInfoCtrl:AddEventTrigger()
  local EventTrigger = CS.UnityEngine.EventSystems.EventTrigger
  local EventTriggerType = CS.UnityEngine.EventSystems.EventTriggerType
  local et = self._mapNode.Drag:GetComponent(typeof(EventTrigger))
  local cb_Begin = ui_handler(self, self.OnEventTrigger_BeginDrag, et)
  local entryBegin = EventTrigger.Entry()
  entryBegin.eventID = EventTriggerType.BeginDrag
  entryBegin.callback:AddListener(cb_Begin)
  et.triggers:Add(entryBegin)
  local cb_End = ui_handler(self, self.OnEvnetTrigger_EndDrag, et)
  local entryEnd = EventTrigger.Entry()
  entryEnd.eventID = EventTriggerType.EndDrag
  entryEnd.callback:AddListener(cb_End)
  et.triggers:Add(entryEnd)
  self.tbTestEventTrigger = {
    et,
    cb_Begin,
    cb_End
  }
end

function CharacterInfoCtrl:RemoveEventTrigger()
  if type(self.tbTestEventTrigger) == "table" then
    local EventTriggerType = CS.UnityEngine.EventSystems.EventTriggerType
    local et = self.tbTestEventTrigger[1]
    local cb_Begin = self.tbTestEventTrigger[2]
    local cb_End = self.tbTestEventTrigger[3]
    local nCount = et.triggers.Count - 1
    for i = nCount, 0, -1 do
      local entry = et.triggers[i]
      if entry.eventID == EventTriggerType.BeginDrag then
        entry.callback:RemoveListener(cb_Begin)
      elseif entry.eventID == EventTriggerType.EndDrag then
        entry.callback:RemoveListener(cb_End)
      end
      et.triggers:Remove(entry)
    end
    self.tbTestEventTrigger = nil
  end
end

function CharacterInfoCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Role_Upgrade, self.characterId, self._mapNode.reddot)
end

function CharacterInfoCtrl:FadeIn()
end

function CharacterInfoCtrl:Awake()
  self.ani = self.gameObject:GetComponent("Animator")
  self.characterId = nil
  self.configData = nil
  self.characterIdList = nil
  self.curCharacterIndex = nil
  self.attrData = nil
  self.attrList = nil
  self.skillLevelList = nil
  self.skillIdList = nil
  self.power = nil
  self.playEnterAnim = true
  self.showDetail = false
end

function CharacterInfoCtrl:OnEnable()
  self:RefreshContent()
  if self._panel.nPanelId == PanelId.CharInfo then
    self:PlayOpenAnim()
  else
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  end
  self:AddEventTrigger()
  self:RegisterRedDot()
end

function CharacterInfoCtrl:OnDisable()
  self:RemoveEventTrigger()
end

function CharacterInfoCtrl:OnDestroy()
end

function CharacterInfoCtrl:OnBtnClick_Left()
  if #self.characterIdList <= 1 then
    return
  end
  self.curCharacterIndex = self.curCharacterIndex - 1
  if 1 > self.curCharacterIndex then
    self.curCharacterIndex = #self.characterIdList
  end
  self.characterId = self.characterIdList[self.curCharacterIndex]
  self.configData = ConfigTable.GetData_Character(self.characterId)
  self:RefreshShow()
  self:RefreshActor2D()
end

function CharacterInfoCtrl:OnBtnClick_Right()
  if #self.characterIdList <= 1 then
    return
  end
  self.curCharacterIndex = self.curCharacterIndex + 1
  if self.curCharacterIndex > #self.characterIdList then
    self.curCharacterIndex = 1
  end
  self.characterId = self.characterIdList[self.curCharacterIndex]
  self.configData = ConfigTable.GetData_Character(self.characterId)
  self:RefreshShow()
  self:RefreshActor2D()
end

function CharacterInfoCtrl:OnBtnClick_Property()
  local attrList = self.attrData:GetAttrList()
  local mapCfg = ConfigTable.GetData_Character(self.characterId)
  if not mapCfg then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.CharAttrDetail, attrList, mapCfg.EET)
end

function CharacterInfoCtrl:OnBtnClick_TempSwitchSkin()
  local mapCfgData_Char = ConfigTable.GetData_Character(self.characterId)
  local nCurCharAdvance = PlayerData.Char:GetCharAdvance(self.characterId)
  local bCanSwitch = nCurCharAdvance >= mapCfgData_Char.AdvanceSkinUnlockLevel
  if bCanSwitch == true then
    local nSkinId = PlayerData.Char:GetCharSkinId(self.characterId)
    if nSkinId == mapCfgData_Char.DefaultSkinId then
      nSkinId = mapCfgData_Char.AdvanceSkinId
    elseif nSkinId == mapCfgData_Char.AdvanceSkinId then
      nSkinId = mapCfgData_Char.DefaultSkinId
    else
      return
    end
    
    local function func_callback()
      PlayerData.Char:SetCharSkinId(self.characterId, nSkinId)
    end
    
    local msgSend = {}
    msgSend.CharId = self.characterId
    msgSend.SkinId = nSkinId
    HttpNetHandler.SendMsg(NetMsgId.Id.char_skin_set_req, msgSend, nil, func_callback)
  end
end

function CharacterInfoCtrl:OnBtnClick_OpenSkinPanel()
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.CharacterSkinPanel, self.characterId)
  end
  
  EventManager.Hit(EventId.SetTransition, 5, func)
end

function CharacterInfoCtrl:OnBtnClick_CloseWordTip()
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function CharacterInfoCtrl:OnBtnClick_Development()
  EventManager.Hit(EventId.CharRelatePanelOpen, PanelId.CharUpPanel, self._panel.nCharId)
end

function CharacterInfoCtrl:OnBtnClick_btnSetFavorite()
  local bOnFavorite = PlayerData.Char:GetCharFavoriteState(self.characterId)
  bOnFavorite = not bOnFavorite
  
  local function func_callback()
    PlayerData.Char:SetCharFavoriteState(self.characterId, bOnFavorite)
    if bOnFavorite then
      local sTip = ConfigTable.GetUIText("SetCharacterCommon_Tip")
      EventManager.Hit(EventId.OpenMessageBox, sTip)
      EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
    end
    self:RefreshFavoriteState()
  end
  
  local msgSend = {
    Value = self.characterId
  }
  HttpNetHandler.SendMsg(NetMsgId.Id.char_favorite_set_req, msgSend, nil, func_callback)
end

function CharacterInfoCtrl:RefreshFavoriteState()
  local bOnFavorite = PlayerData.Char:GetCharFavoriteState(self.characterId)
  if bOnFavorite then
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.favorite_on, 1)
  else
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.favorite_on, 0)
  end
end

function CharacterInfoCtrl:OnEvent_RefreshPanel()
  if self._panel.nPanelId ~= PanelId.CharInfo then
    return
  end
  self:RefreshContent()
  self:RegisterRedDot()
end

function CharacterInfoCtrl:OnEvent_PanelAdvance(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, false)
  self:RefreshContent()
end

function CharacterInfoCtrl:OnEvent_PanelBack(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, true)
  self:RefreshContent()
end

function CharacterInfoCtrl:OnEventTrigger_BeginDrag(eventTrigger, eventData)
  self.nBeginX = eventData.position.x
  self.nBeginTS = CS.UnityEngine.Time.time
end

function CharacterInfoCtrl:OnEvnetTrigger_EndDrag(eventTrigger, eventData)
  if type(self.nBeginTS) == "number" and type(self.nBeginX) == "number" then
    local nDelX = eventData.position.x - self.nBeginX
    local nDelTS = CS.UnityEngine.Time.time - self.nBeginTS
    if nDelTS < 0.3 then
      if nDelX < 0 then
        self:OnBtnClick_Right()
      elseif 0 < nDelX then
        self:OnBtnClick_Left()
      end
    end
  end
end

return CharacterInfoCtrl
