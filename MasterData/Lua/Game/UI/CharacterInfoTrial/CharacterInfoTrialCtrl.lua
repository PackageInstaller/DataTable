local CharacterInfoTrialCtrl = class("CharacterInfoTrialCtrl", BaseCtrl)
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
CharacterInfoTrialCtrl._mapNodeConfig = {
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
  txtCharDesc = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  imgRareName = {sComponentName = "Image"},
  imgCharColor = {sComponentName = "Image"},
  imgTag = {nCount = 3},
  txtTag = {nCount = 3, sComponentName = "TMP_Text"},
  txtElement = {sComponentName = "TMP_Text"},
  imgElementIcon = {sComponentName = "Image"},
  btnCloseWordTip = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWordTip"
  },
  imgWordTipBg = {},
  TMPWordDesc = {sComponentName = "TMP_Text"},
  TMPWordTipsTitle = {sComponentName = "TMP_Text"}
}
CharacterInfoTrialCtrl._mapEventConfig = {
  [EventId.ShowCharacterSkillTips] = "ShowCharacterSkillTips",
  [EventId.CharBgRefresh] = "OnEvent_RefreshPanel",
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelAdvance",
  [EventId.CharRelatePanelBack] = "OnEvent_PanelBack"
}

function CharacterInfoTrialCtrl:PlayOpenAnim(nClosePanelId)
  if nClosePanelId == PanelId.CharUpPanel then
    self.ani:Play("CharacterInfoPanel_out", 0, 0)
  else
    self.ani:Play("CharacterInfoPanel_in", 0, 0)
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.4)
end

function CharacterInfoTrialCtrl:PlayCloseAnim()
end

function CharacterInfoTrialCtrl:RefreshContent()
  local nCurPanelId = self._panel.nPanelId
  if nCurPanelId ~= PanelId.CharInfoTrial then
    return
  end
  self.mapCharTrialInfo = self._panel.mapCharTrialInfo
  self.characterId = self._panel.nCharId
  self.configData = self._panel.configData
  self.showDetail = false
  self:RefreshShow()
end

function CharacterInfoTrialCtrl:InitBg()
  EventManager.Hit(EventId.CharBgRefresh, PanelId.CharInfoTrial, self.characterId)
end

function CharacterInfoTrialCtrl:RefreshShow()
  self:CalculateCharacterInfo()
  self:RefreshCharacterInfo()
  self:RefreshProperty()
end

function CharacterInfoTrialCtrl:CalculateCharacterInfo()
  self:CalculateProperty()
end

function CharacterInfoTrialCtrl:CalculateProperty()
  local nMaxLevel = 0
  
  local function forEach(mapData)
    if mapData.Grade == self.configData.Grade and tonumber(mapData.LvLimit) > nMaxLevel then
      nMaxLevel = tonumber(mapData.LvLimit)
    end
  end
  
  ForEachTableLine(DataTable.CharRaritySequence, forEach)
  local charData = {
    nLevel = self.mapCharTrialInfo.nLevel,
    nAdvance = self.mapCharTrialInfo.nAdvance
  }
  if not self.attrData then
    self.attrData = CharacterAttrData.new(self.characterId, {mapChar = charData})
  else
    self.attrData:SetCharacter(self.characterId, {mapChar = charData})
  end
end

function CharacterInfoTrialCtrl:RefreshCharacterInfo()
  local MaxLevel = PlayerData.Char:CalCharMaxLevel(self.mapCharTrialInfo.nId, self.mapCharTrialInfo.nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtCharLevel, self.mapCharTrialInfo.nLevel)
  NovaAPI.SetTMPText(self._mapNode.txtLevelMax, "/" .. MaxLevel)
  self._mapNode.goStarAdvance:SetStar(self.mapCharTrialInfo.nAdvance, 8)
  local mapConfigDesc = ConfigTable.GetData("CharacterDes", self.mapCharTrialInfo.nId)
  local sDesc
  if mapConfigDesc ~= nil then
    sDesc = mapConfigDesc.CharDes
  else
    sDesc = ""
  end
  NovaAPI.SetTMPText(self._mapNode.txtCharDesc, sDesc)
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapCharTrialInfo.sName)
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
end

function CharacterInfoTrialCtrl:RefreshProperty()
  local attrList = self.attrData:GetAttrList()
  for i = 1, #PropertyIndexList.Simple do
    local index = PropertyIndexList.Simple[i]
    local mapCharAttr = AllEnum.CharAttr[index]
    self._mapNode.goProperty[i]:SetCharProperty(mapCharAttr, attrList[index], true)
  end
end

function CharacterInfoTrialCtrl:RefreshActor2D()
  EventManager.Hit(EventId.CharBgRefresh, PanelId.CharInfoTrial, self.characterId)
end

function CharacterInfoTrialCtrl:PlaySwitchAnim(nClosePanelId, nOpenPanelId, bBack)
  if nClosePanelId == PanelId.CharInfoTrial then
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  end
  if nOpenPanelId == PanelId.CharInfoTrial then
    self._mapNode.safeAreaRoot.gameObject:SetActive(true)
    self:PlayOpenAnim(nClosePanelId)
  end
end

function CharacterInfoTrialCtrl:FadeIn()
end

function CharacterInfoTrialCtrl:Awake()
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

function CharacterInfoTrialCtrl:OnEnable()
  self:RefreshContent()
  if self._panel.nPanelId == PanelId.CharInfoTrial then
    self:PlayOpenAnim()
  else
    self._mapNode.safeAreaRoot.gameObject:SetActive(false)
  end
end

function CharacterInfoTrialCtrl:OnDisable()
end

function CharacterInfoTrialCtrl:OnDestroy()
end

function CharacterInfoTrialCtrl:OnBtnClick_Property()
  local attrList = self.attrData:GetAttrList()
  local mapCfg = ConfigTable.GetData_Character(self.characterId)
  if not mapCfg then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.CharAttrDetail, attrList, mapCfg.EET)
end

function CharacterInfoTrialCtrl:OnBtnClick_CloseWordTip()
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function CharacterInfoTrialCtrl:OnEvent_RefreshPanel()
  if self._panel.nPanelId ~= PanelId.CharInfo then
    return
  end
  self:RefreshContent()
end

function CharacterInfoTrialCtrl:OnEvent_PanelAdvance(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, false)
  self:RefreshContent()
end

function CharacterInfoTrialCtrl:OnEvent_PanelBack(nClosePanelId, nOpenPanelId)
  self:PlaySwitchAnim(nClosePanelId, nOpenPanelId, true)
  self:RefreshContent()
end

function CharacterInfoTrialCtrl:OnEventTrigger_BeginDrag(eventTrigger, eventData)
  self.nBeginX = eventData.position.x
  self.nBeginTS = CS.UnityEngine.Time.time
end

function CharacterInfoTrialCtrl:OnEvnetTrigger_EndDrag(eventTrigger, eventData)
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

return CharacterInfoTrialCtrl
