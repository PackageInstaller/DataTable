local PotentialPreselectionEditCtrl = class("PotentialPreselectionEditCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
PotentialPreselectionEditCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Member"
  },
  txtPreselectionName = {sComponentName = "TMP_Text"},
  btnEditName = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EditName"
  },
  imgEmptyChar = {nCount = 3},
  imgCharBg = {nCount = 3},
  imgCharIcon = {nCount = 3, sComponentName = "Image"},
  imgCharFrame = {nCount = 3, sComponentName = "Image"},
  imgCharElement = {nCount = 3, sComponentName = "Image"},
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  txtCharName = {nCount = 3, sComponentName = "TMP_Text"},
  txtPotentialCount = {nCount = 3, sComponentName = "TMP_Text"},
  btnSelectChar = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CharList"
  },
  btn_Preference = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Preference"
  },
  txtLike = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Like"
  },
  btn_PreferenceIcon = {sComponentName = "Button"},
  goEmpty = {
    sNodeName = "---empty---"
  },
  txt_Empty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Select_Char"
  },
  btnPreviewRoot = {},
  btnUse = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Use"
  },
  txtBtnUse = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Use"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Cancel"
  },
  btnEdit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Edit"
  },
  txtBtnEdit = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Edit"
  },
  btnShare = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Share"
  },
  txtBtnShare = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Share"
  },
  btnDelete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Delete"
  },
  txtBtnDelete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Delete"
  },
  btnEditRoot = {},
  btnSave = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Save"
  },
  txtBtnSave = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Edit_Save"
  },
  btnAbandon = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Abandon"
  },
  txtBtnAbandon = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Edit_Abandon"
  },
  goPotential = {
    sNodeName = "---potential---"
  },
  potentialCardRoot = {},
  animPotentialCard = {
    sNodeName = "potentialCardRoot",
    sComponentName = "Animator"
  },
  PotentialCard = {
    sCtrlName = "Game.UI.StarTower.Potential.PotentialCardItemCtrl"
  },
  CharList = {},
  PotentialList = {
    nCount = 3,
    sCtrlName = "Game.UI.PotentialPreselection.CharPotentialListCtrl"
  },
  PotentialDepotItem = {},
  rtPotentialContent = {
    sNodeName = "PotentialContent",
    sComponentName = "RectTransform"
  },
  switch_des = {},
  switch_img_bg = {
    sComponentName = "RectTransform"
  },
  switch_name = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Change_Desc"
  },
  btnSwitch_on = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SetDes"
  },
  btnSwitch_off = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SetSimpleDes"
  },
  goQuantitySelector = {
    sNodeName = "tc_quantity_selector",
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySelectorCtrl"
  },
  potentialEmpty = {},
  txt_EmptyPotential = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Potential_Empty"
  },
  goCharList = {
    sNodeName = "---charList---",
    sCtrlName = "Game.UI.PotentialPreselection.PotentialPreselectionCharListCtrl"
  },
  animCharList = {
    sNodeName = "---charList---",
    sComponentName = "Animator"
  },
  btnCharListMask = {}
}
PotentialPreselectionEditCtrl._mapEventConfig = {
  SelectPreselectionChar = "OnEvent_SelectPreselectionChar",
  ClosePreselectionCharList = "OnEvent_CloseCharList",
  SelectDepotPotential = "OnEvent_SelectPotential",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome"
}
PotentialPreselectionEditCtrl._mapRedDotConfig = {}
local COLOR_PREFER = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764)
local COLOR_NO_PREFER = Color(0.5803921568627451, 0.6666666666666666, 0.7529411764705882)

function PotentialPreselectionEditCtrl:IsPreviewMode()
  return self._panel.nPanelType == AllEnum.PreselectionPanelType.Preview or self._panel.nPanelType == AllEnum.PreselectionPanelType.SystemPreview
end

function PotentialPreselectionEditCtrl:IsSystemPreviewMode()
  return self._panel.nPanelType == AllEnum.PreselectionPanelType.SystemPreview
end

function PotentialPreselectionEditCtrl:InitSelectList()
  self.tbSelectCharList = {}
  if self.initPreselectData ~= nil and next(self.initPreselectData) ~= nil then
    local tbChar = self.initPreselectData.tbCharPotential
    for k, v in ipairs(tbChar) do
      self.tbSelectCharList[k] = {}
      self.tbSelectCharList[k].nCharId = v.nCharId
      self.tbSelectCharList[k].tbPotential = self:GetAllPotentialList(v.nCharId, k, v.tbPotential)
    end
  else
    for i = 1, 3 do
      if self.tbSelectCharList[i] == nil then
        self.tbSelectCharList[i] = {}
        self.tbSelectCharList[i].nCharId = 0
      end
    end
  end
end

function PotentialPreselectionEditCtrl:CheckPotentialSpecialCount()
  if self.bSelectSpecial and self.nSelectSpecialCount >= 2 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Sepcail_Max"))
    return false
  end
  return true
end

function PotentialPreselectionEditCtrl:ChangePanel()
  if self.nTeamIndex == nil or self.curPreselectData == nil then
    return
  end
  local bPreviewMode = self:IsPreviewMode()
  local bSystemPreview = self:IsSystemPreviewMode()
  local bSystemPreviewWithTeam = bSystemPreview and self.nTeamIndex > 0
  self._mapNode.btnPreviewRoot.gameObject:SetActive(bPreviewMode)
  self._mapNode.btnEditRoot.gameObject:SetActive((not bPreviewMode or bSystemPreview) and not bSystemPreviewWithTeam)
  self._mapNode.btn_Preference.gameObject:SetActive(self._panel.nPanelType == AllEnum.PreselectionPanelType.Preview)
  self._mapNode.btnEditName.gameObject:SetActive(self._panel.nPanelType == AllEnum.PreselectionPanelType.Preview)
  self._mapNode.btnEdit.gameObject:SetActive(not bSystemPreview)
  self._mapNode.btnShare.gameObject:SetActive(not bSystemPreview)
  self._mapNode.btnDelete.gameObject:SetActive(not bSystemPreview)
  self._mapNode.btnAbandon.gameObject:SetActive(not bSystemPreview)
  self._mapNode.btnSave.gameObject:SetActive((bSystemPreview or not bPreviewMode) and not bSystemPreviewWithTeam)
  if self.nTeamIndex > 0 and self._panel.nPanelType == AllEnum.PreselectionPanelType.Preview then
    local nPreselectionId = PlayerData.Team:GetTeamPreselectionId(self.nTeamIndex)
    self._mapNode.btnUse.gameObject:SetActive(nPreselectionId ~= self.curPreselectData.nId)
    self._mapNode.btnCancel.gameObject:SetActive(nPreselectionId == self.curPreselectData.nId)
  elseif self.nTeamIndex > 0 and bSystemPreview then
    self._mapNode.btnUse.gameObject:SetActive(true)
    self._mapNode.btnCancel.gameObject:SetActive(false)
  else
    self._mapNode.btnUse.gameObject:SetActive(false)
    self._mapNode.btnCancel.gameObject:SetActive(false)
  end
end

function PotentialPreselectionEditCtrl:RefreshContent()
  self:ChangePanel()
  self.bEmpty = false
  for _, v in ipairs(self.tbSelectCharList) do
    if v.nCharId == 0 then
      self.bEmpty = true
      break
    end
  end
  self._mapNode.goEmpty.gameObject:SetActive(self.bEmpty)
  self._mapNode.goPotential.gameObject:SetActive(not self.bEmpty)
  NovaAPI.SetTMPText(self._mapNode.txtPreselectionName, self.curPreselectData.sName)
  self._mapNode.btn_PreferenceIcon.interactable = self.curPreselectData.bPreference
  NovaAPI.SetTMPColor(self._mapNode.txtLike, self.curPreselectData.bPreference and COLOR_PREFER or COLOR_NO_PREFER)
  if self.bEmpty then
    self:SetEmpty()
    return
  end
  self:RefreshCharList()
  self:RefreshPotentialList()
  if not self:IsPreviewMode() and self.bShowCharList then
    local tbSelect = {}
    for _, v in ipairs(self.tbSelectCharList) do
      table.insert(tbSelect, v.nCharId)
    end
    self._mapNode.goCharList:ShowList(tbSelect)
    self._mapNode.btnCharListMask.gameObject:SetActive(true)
  end
end

function PotentialPreselectionEditCtrl:RefreshCharList()
  for i = 1, 3 do
    local bEmpty = self.tbSelectCharList[i].nCharId == 0
    self._mapNode.imgEmptyChar[i].gameObject:SetActive(bEmpty)
    self._mapNode.imgCharBg[i].gameObject:SetActive(not bEmpty)
    self._mapNode.txtPotentialCount[i].gameObject:SetActive(not bEmpty)
    if bEmpty then
      NovaAPI.SetTMPText(self._mapNode.txtCharName[i], ConfigTable.GetUIText("Potential_Preselection_Char_Empty"))
    else
      local nCharId = self.tbSelectCharList[i].nCharId
      local mapCharCfg = ConfigTable.GetData_Character(nCharId)
      if mapCharCfg ~= nil then
        local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
        local mapCharSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
        local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
        self:SetPngSprite(self._mapNode.imgCharIcon[i], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
        self:SetAtlasSprite(self._mapNode.imgCharFrame[i], "12_rare", sFrame)
        self:SetAtlasSprite(self._mapNode.imgCharElement[i], "12_rare", AllEnum.Char_Element[mapCharCfg.EET].icon)
        NovaAPI.SetTMPText(self._mapNode.txtCharName[i], mapCharCfg.Name)
        NovaAPI.SetTMPText(self._mapNode.txtPotentialCount[i], 0)
      end
    end
  end
end

function PotentialPreselectionEditCtrl:RefreshPotentialList()
  local bEmpty = true
  self.nSelectId = nil
  self.nSelectCharIdx = 0
  local nPotentialCount = 0
  for k, v in ipairs(self.tbSelectCharList) do
    local nAllCount = 0
    local nSelectId = 0
    if 0 < v.nCharId then
      bEmpty = false
      if v.tbPotential == nil then
        v.tbPotential = self:GetAllPotentialList(v.nCharId, k)
      end
      for style, tb in ipairs(v.tbPotential) do
        for _, data in ipairs(tb) do
          nAllCount = nAllCount + data.nLevel
          if 0 < data.nLevel and nSelectId == 0 then
            nSelectId = data.nId
          end
        end
      end
      nPotentialCount = nPotentialCount + nAllCount
      if self.nSelectId == nil then
        if self:IsPreviewMode() then
          if nSelectId ~= 0 then
            self.nSelectId = nSelectId
          end
        elseif v.tbPotential[1] and v.tbPotential[1][1] then
          self.nSelectId = v.tbPotential[1][1].nId
        end
        self.nSelectCharIdx = k
      end
      self._mapNode.PotentialList[k]:RefreshPotential(v.nCharId, v.tbPotential, self._mapNode.PotentialDepotItem, k == 1, self._panel.nPanelType)
      self._mapNode.PotentialList[k]:ShowAllCount(false)
    end
    NovaAPI.SetTMPText(self._mapNode.txtPotentialCount[k], nAllCount)
  end
  self._mapNode.goEmpty.gameObject:SetActive(bEmpty)
  self._mapNode.goPotential.gameObject:SetActive(not bEmpty)
  if not bEmpty then
    if self.nSelectId ~= nil and self.nSelectId ~= 0 then
      self._mapNode.potentialCardRoot.gameObject:SetActive(true)
      EventManager.Hit("SelectDepotPotential", self.nSelectId)
    else
      self._mapNode.potentialCardRoot.gameObject:SetActive(false)
    end
    self._mapNode.potentialEmpty.gameObject:SetActive(self:IsPreviewMode() and nPotentialCount == 0)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtPotentialContent)
    end
    
    cs_coroutine.start(wait)
    self:InitSwitch()
  end
end

function PotentialPreselectionEditCtrl:RefreshSelectPotential(bPlayAnim)
  self._mapNode.PotentialCard.gameObject:SetActive(true)
  local potentialCfg = ConfigTable.GetData("Potential", self.nSelectId)
  if nil ~= potentialCfg then
    self.nSelectCharIdx = 0
    for k, v in ipairs(self.tbSelectCharList) do
      if v.nCharId == potentialCfg.CharId then
        self.nSelectCharIdx = k
        break
      end
    end
    local nLevel = 0
    local nMaxLevel = 0
    self.nSelectSpecialCount = 0
    self.bSelectSpecial = false
    local mapData = self.tbSelectCharList[self.nSelectCharIdx]
    if mapData ~= nil then
      for nType, tb in ipairs(mapData.tbPotential) do
        for _, data in ipairs(tb) do
          if data.nId == self.nSelectId then
            nLevel = data.nLevel
            nMaxLevel = data.nMaxLevel
            self.bSelectSpecial = data.nSpecial == 1
          end
          if data.nSpecial == 1 then
            self.nSelectSpecialCount = self.nSelectSpecialCount + data.nLevel
          end
        end
      end
    end
    self.nSelectLevel = nLevel
    self.nLastSelectLevel = nLevel
    nLevel = math.max(nLevel, 1)
    local bSimple = PlayerData.StarTower:GetPotentialDescSimple()
    if bPlayAnim then
      self._mapNode.animPotentialCard:Play("potentialCardRoot_in", 0, 0)
    end
    self._mapNode.PotentialCard:SetPotentialItem(self.nSelectId, nLevel, nil, bSimple, nil, 0, AllEnum.PotentialCardType.CharInfo)
    self._mapNode.PotentialCard:ChangeWordRaycast(true)
    self._mapNode.goQuantitySelector.gameObject:SetActive(not self:IsPreviewMode())
    if not self:IsPreviewMode() then
      local function callback(nCount)
        self.nSelectLevel = nCount
        
        self:RefreshPotentialCount()
      end
      
      local function addCallback()
        return self:CheckPotentialSpecialCount()
      end
      
      self._mapNode.goQuantitySelector:Init(callback, self.nSelectLevel, nMaxLevel, false, true, addCallback)
    end
  end
end

function PotentialPreselectionEditCtrl:RefreshPotentialCount()
  if self.nSelectCharIdx ~= 0 then
    local bSimple = PlayerData.StarTower:GetPotentialDescSimple()
    local nLevel = math.max(self.nSelectLevel, 1)
    self._mapNode.PotentialCard:SetPotentialItem(self.nSelectId, nLevel, nil, bSimple, nil, 0, AllEnum.PotentialCardType.CharInfo)
    self._mapNode.PotentialCard:ChangeWordRaycast(true)
    if self._mapNode.PotentialList[self.nSelectCharIdx] ~= nil then
      self._mapNode.PotentialList[self.nSelectCharIdx]:RefreshPotentialLevel(self.nSelectId, self.nSelectLevel, self.nLastSelectLevel)
    end
    self.nLastSelectLevel = self.nSelectLevel
    self.nSelectSpecialCount = 0
    local mapData = self.tbSelectCharList[self.nSelectCharIdx]
    if mapData ~= nil then
      local nAllCount = 0
      for nType, tb in ipairs(mapData.tbPotential) do
        for _, data in ipairs(tb) do
          if data.nId == self.nSelectId then
            data.nLevel = self.nSelectLevel
          end
          nAllCount = nAllCount + data.nLevel
          if data.nSpecial == 1 then
            self.nSelectSpecialCount = self.nSelectSpecialCount + data.nLevel
          end
        end
      end
      NovaAPI.SetTMPText(self._mapNode.txtPotentialCount[self.nSelectCharIdx], nAllCount)
    end
  end
end

function PotentialPreselectionEditCtrl:InitSwitch()
  local bSimple = PlayerData.StarTower:GetPotentialDescSimple()
  self._mapNode.btnSwitch_on.gameObject:SetActive(bSimple)
  self._mapNode.btnSwitch_off.gameObject:SetActive(not bSimple)
end

function PotentialPreselectionEditCtrl:GetAllPotentialList(nCharId, nIndex, tbPotential)
  local tbAllPotential = {}
  local charPotentialCfg = PlayerData.Char:GetCharPotentialList(nCharId)
  if charPotentialCfg ~= nil then
    if nIndex == 1 then
      tbAllPotential = charPotentialCfg.master
    else
      tbAllPotential = charPotentialCfg.assist
    end
  end
  local tbSortList = {}
  for style, tb in ipairs(tbAllPotential) do
    tbSortList[style] = {}
    for _, data in ipairs(tb) do
      local itemCfg = ConfigTable.GetData_Item(data.nId)
      if itemCfg ~= nil then
        local nLevel = 0
        if tbPotential ~= nil and 0 < #tbPotential then
          for _, v in ipairs(tbPotential) do
            if v.nId == data.nId then
              nLevel = v.nLevel
              break
            end
          end
        end
        data.nLevel = nLevel
        local nSpecial = itemCfg.Stype == GameEnum.itemStype.SpecificPotential and 1 or 0
        local nMaxLevel = nSpecial == 1 and 1 or ConfigTable.GetConfigNumber("PotentialPreselectionMaxLevel")
        table.insert(tbSortList[style], {
          nId = data.nId,
          nLevel = data.nLevel,
          nMaxLevel = nMaxLevel,
          nSpecial = nSpecial,
          nRarity = itemCfg.Rarity
        })
      end
    end
    table.sort(tbSortList[style], function(a, b)
      if a.nSpecial == b.nSpecial then
        if a.nRarity == b.nRarity then
          if a.nLevel == b.nLevel then
            return a.nId < b.nId
          end
          return a.nLevel > b.nLevel
        end
        return a.nRarity < b.nRarity
      end
      return a.nSpecial > b.nSpecial
    end)
  end
  return tbSortList
end

function PotentialPreselectionEditCtrl:SetEmpty()
  for i = 1, 3 do
    self._mapNode.imgEmptyChar[i].gameObject:SetActive(true)
    self._mapNode.imgCharBg[i].gameObject:SetActive(false)
    self._mapNode.txtPotentialCount[i].gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtCharName[i], ConfigTable.GetUIText("Potential_Preselection_Char_Empty"))
  end
  if not self:IsPreviewMode() then
    local tbSelect = {}
    for _, v in ipairs(self.tbSelectCharList) do
      table.insert(tbSelect, v.nCharId)
    end
    self._mapNode.goCharList:ShowList(tbSelect)
    self._mapNode.btnCharListMask.gameObject:SetActive(true)
    self.bShowCharList = true
  end
end

function PotentialPreselectionEditCtrl:CheckChange()
  local bChange = false
  local tbChangeChar = {}
  if self.initPreselectData ~= nil and next(self.initPreselectData) ~= nil then
    local tbCharPotential = self.initPreselectData.tbCharPotential
    for k, v in ipairs(self.tbSelectCharList) do
      if tbCharPotential[k].nCharId ~= v.nCharId then
        bChange = true
        table.insert(tbChangeChar, tbCharPotential[k].nCharId)
      end
      if v.tbPotential ~= nil and tbCharPotential[k].tbPotential == nil then
        bChange = true
        break
      end
      local tbTemp = {}
      for _, data in ipairs(tbCharPotential[k].tbPotential) do
        tbTemp[data.nId] = data.nLevel
      end
      if v.tbPotential ~= nil and tbCharPotential[k].tbPotential ~= nil then
        for nType, tb in ipairs(v.tbPotential) do
          for _, potential in ipairs(tb) do
            local nInitLevel = tbTemp[potential.nId] or 0
            if nInitLevel ~= potential.nLevel then
              bChange = true
              break
            end
          end
        end
      end
    end
  else
    for k, v in ipairs(self.tbSelectCharList) do
      if v.nCharId ~= 0 then
        bChange = true
        break
      end
    end
  end
  return bChange, tbChangeChar
end

function PotentialPreselectionEditCtrl:ClosePanel(bCloseList)
  EventManager.Hit(EventId.ClosePanel, PanelId.PotentialPreselectionEdit)
  if bCloseList then
    EventManager.Hit(EventId.ClosePanel, PanelId.PotentialPreselectionList)
  end
end

function PotentialPreselectionEditCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" and self._panel.nPanelType == 0 then
    self._panel.nPanelType = tbParam[1]
    self.initPreselectData = tbParam[2]
    self.tbBuildChar = tbParam[3]
    self.nTeamIndex = tbParam[4] or 0
    self.sPresetName = tbParam[5] or ""
    self.bShowCharList = false
    self.curPreselectData = nil
  end
end

function PotentialPreselectionEditCtrl:OnEnable()
  self.tbOption = {
    AllEnum.ChooseOption.Char_Element,
    AllEnum.ChooseOption.Char_Rarity,
    AllEnum.ChooseOption.Char_PowerStyle,
    AllEnum.ChooseOption.Char_TacticalStyle,
    AllEnum.ChooseOption.Char_AffiliatedForces
  }
  self._mapNode.goCharList.gameObject:SetActive(self.bShowCharList)
  self._mapNode.btnCharListMask.gameObject:SetActive(self.bShowCharList)
  self._mapNode.PotentialDepotItem.gameObject:SetActive(false)
  self._mapNode.btnUse.gameObject:SetActive(self.tbBuildChar ~= nil)
  self.nSelectId = nil
  self.nSelectCharIdx = 0
  self.nSelectLevel = 0
  self.nLastSelectLevel = 0
  if self.curPreselectData == nil then
    self.curPreselectData = {}
    if self._panel.nPanelType == AllEnum.PreselectionPanelType.Create then
      self.curPreselectData.sName = ConfigTable.GetUIText("Potential_Preselection_Name_Init")
      self.curPreselectData.bPreference = false
      self.curPreselectData.tbCharPotential = {}
    else
      self.curPreselectData = clone(self.initPreselectData)
    end
    self:InitSelectList()
  end
  self:RefreshContent()
end

function PotentialPreselectionEditCtrl:OnDisable()
  PlayerData.Filter:Reset(self.tbOption)
end

function PotentialPreselectionEditCtrl:OnDestroy()
end

function PotentialPreselectionEditCtrl:OnBtnClick_EditName()
  local function callback(sName)
    self.curPreselectData = PlayerData.PotentialPreselection:GetPreselectionById(self.curPreselectData.nId)
    
    NovaAPI.SetTMPText(self._mapNode.txtPreselectionName, self.curPreselectData.sName)
  end
  
  EventManager.Hit(EventId.OpenPanel, PanelId.PreselectionRename, self.curPreselectData, callback, self._panel.nPanelType ~= AllEnum.PreselectionPanelType.Preview)
end

function PotentialPreselectionEditCtrl:OnBtnClick_CharList()
  if self._mapNode.goCharList.gameObject.activeSelf or self:IsPreviewMode() then
    return
  end
  self.bShowCharList = true
  local tbSelect = {}
  for _, v in ipairs(self.tbSelectCharList) do
    table.insert(tbSelect, v.nCharId)
  end
  self._mapNode.goCharList:ShowList(tbSelect)
  self._mapNode.btnCharListMask.gameObject:SetActive(true)
end

function PotentialPreselectionEditCtrl:OnBtnClick_Preference()
  if self._panel.nPanelType == AllEnum.PreselectionPanelType.Preview then
    local tbCheckIn = {}
    local tbCheckOut = {}
    if self.curPreselectData.bPreference then
      table.insert(tbCheckOut, self.curPreselectData.nId)
    else
      table.insert(tbCheckIn, self.curPreselectData.nId)
    end
    
    local function callback()
      self.curPreselectData = PlayerData.PotentialPreselection:GetPreselectionById(self.curPreselectData.nId)
      self._mapNode.btn_PreferenceIcon.interactable = self.curPreselectData.bPreference
      NovaAPI.SetTMPColor(self._mapNode.txtLike, self.curPreselectData.bPreference and COLOR_PREFER or COLOR_NO_PREFER)
    end
    
    PlayerData.PotentialPreselection:SendPreselectionPreference(tbCheckIn, tbCheckOut, callback)
  end
end

function PotentialPreselectionEditCtrl:GetSaveCharPotential()
  local tbCharPotential = {}
  for _, mapData in ipairs(self.tbSelectCharList) do
    local tbPotential = {}
    local nCharId = mapData.nCharId
    for _, tb in ipairs(mapData.tbPotential or {}) do
      for _, data in ipairs(tb) do
        if data.nLevel > 0 then
          local mapPotentialCfg = ConfigTable.GetData("Potential", data.nId)
          if mapPotentialCfg ~= nil then
            table.insert(tbPotential, {
              Id = data.nId,
              Level = data.nLevel
            })
          end
        end
      end
    end
    table.insert(tbCharPotential, {CharId = nCharId, Potentials = tbPotential})
  end
  return tbCharPotential
end

function PotentialPreselectionEditCtrl:CheckSavePreselectionLimit()
  local tbAllPreselectionList = PlayerData.PotentialPreselection:GetPreselectionList()
  local nAllCount = ConfigTable.GetConfigNumber("PotentialPreselectionMaxCount")
  if nAllCount <= #tbAllPreselectionList then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Build_Max"))
    return false
  end
  return true
end

function PotentialPreselectionEditCtrl:GetSystemPreviewSaveName()
  local sName = ConfigTable.GetUIText("Potential_Preselection_Name_Init")
  if self.sPresetName ~= nil and self.sPresetName ~= "" then
    sName = self.sPresetName
  end
  return sName
end

function PotentialPreselectionEditCtrl:NormalizeShareCode(sShareCode)
  if sShareCode == nil or sShareCode == "" then
    return nil
  end
  sShareCode = sShareCode:gsub("-", "+")
  sShareCode = sShareCode:gsub("_", "/")
  local nMod = #sShareCode % 4
  if nMod ~= 0 then
    sShareCode = sShareCode .. string.rep("=", 4 - nMod)
  end
  return sShareCode
end

function PotentialPreselectionEditCtrl:GetSavedSystemPreviewPreselection()
  local sSystemShareCode = self:NormalizeShareCode(self.curPreselectData and self.curPreselectData.sShareCode)
  if sSystemShareCode == nil then
    return nil
  end
  local tbAllPreselectionList = PlayerData.PotentialPreselection:GetPreselectionList()
  for _, mapPreselection in ipairs(tbAllPreselectionList) do
    local sShareCode = self:NormalizeShareCode(PlayerData.PotentialPreselection:PackPotentialData(mapPreselection.tbCharPotential))
    if sShareCode == sSystemShareCode then
      return mapPreselection
    end
  end
  return nil
end

function PotentialPreselectionEditCtrl:SaveSystemPreviewPreselection(callback)
  if not self:CheckSavePreselectionLimit() then
    return
  end
  PlayerData.PotentialPreselection:SavePreselectionFromRank(self:GetSystemPreviewSaveName(), false, self:GetSaveCharPotential(), callback)
end

function PotentialPreselectionEditCtrl:ApplyPreselectionToTeam(nPreselectionId, bUsePresetTeam)
  local function callback()
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Select_Suc"))
    
    self:ClosePanel(true)
  end
  
  local tmpDisc = PlayerData.Team:GetTeamDiscData(self.nTeamIndex)
  local tbTeamMemberId
  if bUsePresetTeam then
    tbTeamMemberId = {}
    for _, v in ipairs(self.tbSelectCharList) do
      table.insert(tbTeamMemberId, v.nCharId)
    end
  else
    _, tbTeamMemberId = PlayerData.Team:GetTeamData(self.nTeamIndex)
  end
  PlayerData.Team:UpdateFormationInfo(self.nTeamIndex, tbTeamMemberId, tmpDisc, nPreselectionId, callback)
end

function PotentialPreselectionEditCtrl:SaveAndApplySystemPreview(bUsePresetTeam)
  self:SaveSystemPreviewPreselection(function(mapBuildData)
    if mapBuildData ~= nil then
      self:ApplyPreselectionToTeam(mapBuildData.nId, bUsePresetTeam)
    end
  end)
end

function PotentialPreselectionEditCtrl:OnBtnClick_UseSystemPreview(bCharDiff, bCharLock)
  local function SaveAndApply(bApply)
    local mapSavedPreselection = self:GetSavedSystemPreviewPreselection()
    
    if mapSavedPreselection ~= nil then
      self:ApplyPreselectionToTeam(mapSavedPreselection.nId, bCharDiff and bApply)
      return
    end
    local sTipsKey = "Potential_Preselection_SystemRcmd_Same"
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText(sTipsKey),
      callbackConfirm = function()
        self:SaveAndApplySystemPreview(bCharDiff and bApply)
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  if bCharLock then
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Potential_Preselection_Char_Lock_Tip"),
      callbackConfirm = function()
        SaveAndApply(false)
      end,
      callbackCancel = function()
        self:ClosePanel()
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  elseif bCharDiff then
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Potential_Preselection_Build_Auto"),
      callbackConfirm = function()
        if self.nTeamIndex > 0 then
          SaveAndApply(true)
        end
      end,
      callbackCancel = function()
        SaveAndApply(false)
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  else
    SaveAndApply(true)
  end
end

function PotentialPreselectionEditCtrl:OnBtnClick_Use()
  local bCharDiff = false
  local bCharLock = false
  for k, v in ipairs(self.tbSelectCharList) do
    if k == 1 then
      if v.nCharId ~= self.tbBuildChar[k] then
        bCharDiff = true
      end
    elseif table.indexof(self.tbBuildChar, v.nCharId) == 0 then
      bCharDiff = true
    end
    if not PlayerData.Char:CheckCharUnlock(v.nCharId) then
      bCharLock = true
    end
  end
  if self:IsSystemPreviewMode() then
    self:OnBtnClick_UseSystemPreview(bCharDiff, bCharLock)
    return
  end
  if bCharLock then
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Potential_Preselection_Char_Lock_Tip"),
      callbackConfirm = function()
        self:ApplyPreselectionToTeam(self.curPreselectData.nId, false)
      end,
      callbackCancel = function()
        self:ClosePanel()
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  elseif bCharDiff then
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Potential_Preselection_Build_Auto"),
      callbackConfirm = function()
        if self.nTeamIndex > 0 then
          self:ApplyPreselectionToTeam(self.curPreselectData.nId, true)
        end
      end,
      callbackCancel = function()
        self:ApplyPreselectionToTeam(self.curPreselectData.nId, false)
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  else
    self:ApplyPreselectionToTeam(self.curPreselectData.nId, false)
  end
end

function PotentialPreselectionEditCtrl:OnBtnClick_Cancel()
  local function callback()
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Cancel_Suc"))
    
    if PanelManager.CheckPanelOpen(PanelId.PotentialPreselectionList) then
      self:ClosePanel()
      EventManager.Hit("RefreshPreselectionList")
    else
      EventManager.Hit(EventId.OpenPanel, PanelId.PotentialPreselectionList, self.tbBuildChar or {}, self.nTeamIndex)
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self:ClosePanel()
      end
      
      cs_coroutine.start(wait)
    end
  end
  
  local tmpDisc = PlayerData.Team:GetTeamDiscData(self.nTeamIndex)
  local _, tbTeamMemberId = PlayerData.Team:GetTeamData(self.nTeamIndex)
  PlayerData.Team:UpdateFormationInfo(self.nTeamIndex, tbTeamMemberId, tmpDisc, 0, callback)
end

function PotentialPreselectionEditCtrl:OnBtnClick_Edit()
  self._panel.nPanelType = AllEnum.PreselectionPanelType.Edit
  self:ChangePanel()
  self:RefreshContent()
end

function PotentialPreselectionEditCtrl:OnBtnClick_Share()
  if self.initPreselectData ~= nil and next(self.initPreselectData) ~= nil then
    local sCode = PlayerData.PotentialPreselection:PackPotentialData(self.initPreselectData.tbCharPotential)
    if sCode ~= nil then
      CS.UnityEngine.GUIUtility.systemCopyBuffer = sCode
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Share_Suc"))
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Share_Fail"))
    end
  end
end

function PotentialPreselectionEditCtrl:OnBtnClick_Delete()
  local function sucCallback()
    EventManager.Hit(EventId.ClosePanel, PanelId.PotentialPreselectionEdit)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Potential_Preselection_Delete_Tip"),
    callbackConfirm = function()
      local tbIds = {
        self.curPreselectData.nId
      }
      PlayerData.PotentialPreselection:SendDeletePreselection(tbIds, sucCallback)
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function PotentialPreselectionEditCtrl:OnBtnClick_Save()
  local tbCharPotential = self:GetSaveCharPotential()
  local bSystemPreview = self:IsSystemPreviewMode()
  
  local function callback(mapBuildData)
    if bSystemPreview then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Save_Form_Rank"))
      EventManager.Hit("RefreshPreselectionList")
      return
    end
    self.initPreselectData = mapBuildData
    self.curPreselectData = clone(self.initPreselectData)
    self._panel.nPanelType = AllEnum.PreselectionPanelType.Preview
    self:RefreshContent()
  end
  
  if self._panel.nPanelType == AllEnum.PreselectionPanelType.Create then
    local sName = self.curPreselectData.sName
    local bPreference = self.curPreselectData.bPreference
    PlayerData.PotentialPreselection:SavePreselection(sName, bPreference, tbCharPotential, callback)
  elseif self:IsSystemPreviewMode() then
    self:SaveSystemPreviewPreselection(callback)
  else
    PlayerData.PotentialPreselection:SendUpdatePotential(self.curPreselectData.nId, tbCharPotential, callback)
  end
end

function PotentialPreselectionEditCtrl:OnBtnClick_Abandon()
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Potential_Preselection_Abandon_Edit"),
    callbackConfirm = function()
      if self._panel.nPanelType == AllEnum.PreselectionPanelType.Create then
        EventManager.Hit(EventId.ClosePanel, PanelId.PotentialPreselectionEdit)
      else
        self._panel.nPanelType = AllEnum.PreselectionPanelType.Preview
        self:InitSelectList()
        self:RefreshContent()
      end
    end
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function PotentialPreselectionEditCtrl:OnBtnClick_SetDes()
  PlayerData.StarTower:SetPotentialDescSimple(false)
  EventManager.Hit("SelectDepotPotential", self.nSelectId)
  self._mapNode.btnSwitch_on.gameObject:SetActive(false)
  self._mapNode.btnSwitch_off.gameObject:SetActive(true)
end

function PotentialPreselectionEditCtrl:OnBtnClick_SetSimpleDes()
  PlayerData.StarTower:SetPotentialDescSimple(true)
  EventManager.Hit("SelectDepotPotential", self.nSelectId)
  self._mapNode.btnSwitch_on.gameObject:SetActive(true)
  self._mapNode.btnSwitch_off.gameObject:SetActive(false)
end

function PotentialPreselectionEditCtrl:OnEvent_SelectPreselectionChar(tbChar)
  for i = 1, 3 do
    if tbChar[i] == nil then
      self.tbSelectCharList[i].nCharId = 0
      self.tbSelectCharList[i].tbPotential = nil
    elseif self.tbSelectCharList[i].nCharId == 0 or self.tbSelectCharList[i].nCharId ~= tbChar[i] then
      self.tbSelectCharList[i].nCharId = tbChar[i]
      self.tbSelectCharList[i].tbPotential = nil
    end
  end
  self:RefreshCharList()
end

function PotentialPreselectionEditCtrl:OnEvent_CloseCharList(tbChar)
  local function confirmCallback()
    for i = 1, 3 do
      if tbChar[i] == nil then
        self.tbSelectCharList[i].nCharId = 0
        
        self.tbSelectCharList[i].tbPotential = nil
      elseif self.tbSelectCharList[i].nCharId == 0 or self.tbSelectCharList[i].nCharId ~= tbChar[i] then
        self.tbSelectCharList[i].nCharId = tbChar[i]
        self.tbSelectCharList[i].tbPotential = nil
      end
    end
    self._mapNode.btnCharListMask.gameObject:SetActive(false)
    local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animCharList, {
      "charList_out"
    })
    self._mapNode.animCharList:Play("charList_out")
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
    self:AddTimer(1, nAnimLen, function()
      self._mapNode.goCharList:CloseList()
      self.bShowCharList = false
      self:RefreshContent()
    end, true, true, true)
  end
  
  local tbChangeChar = {}
  for k, v in ipairs(self.tbSelectCharList) do
    local nCharId = v.nCharId
    if tbChar[k] ~= nCharId and v.nCharId ~= 0 then
      table.insert(tbChangeChar, nCharId)
    end
  end
  if 0 < #tbChangeChar then
    local sContentSub = ""
    for k, v in ipairs(tbChangeChar) do
      local mapCharCfg = ConfigTable.GetData_Character(v)
      if mapCharCfg ~= nil then
        sContentSub = sContentSub .. mapCharCfg.Name
        if k ~= #tbChangeChar then
          sContentSub = sContentSub .. ", "
        end
      end
    end
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Potential_Preselection_Char_Change"),
      sContentSub = sContentSub,
      callbackConfirm = confirmCallback
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  else
    confirmCallback()
  end
end

function PotentialPreselectionEditCtrl:OnEvent_SelectPotential(nPotentialId, nLevel, nPotentialAdd, btn)
  local bPlayAnim = self.nSelectId ~= nPotentialId
  self.nSelectId = nPotentialId
  self:RefreshSelectPotential(bPlayAnim)
end

function PotentialPreselectionEditCtrl:OnEvent_Back()
  if not self:IsPreviewMode() then
    if self.bShowCharList then
      local bCloseCharList = true
      if self._panel.nPanelType == AllEnum.PreselectionPanelType.Create then
        for _, v in ipairs(self.tbSelectCharList) do
          if v.nCharId == 0 then
            bCloseCharList = false
            break
          end
        end
      end
      if bCloseCharList then
        self._mapNode.btnCharListMask.gameObject:SetActive(false)
        local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animCharList, {
          "charList_out"
        })
        self._mapNode.animCharList:Play("charList_out")
        EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
        self:AddTimer(1, nAnimLen, function()
          self._mapNode.goCharList:CloseList()
          self.bShowCharList = false
        end, true, true, true)
        return
      end
    end
    local bChange, tbChangeChar = self:CheckChange()
    if bChange then
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("Potential_Preselection_UnSave_Tip"),
        callbackConfirm = function()
          self:ClosePanel()
        end
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
      return
    end
  end
  self:ClosePanel()
end

function PotentialPreselectionEditCtrl:OnEvent_BackHome()
  if not self:IsPreviewMode() then
    local bChange, tbChangeChar = self:CheckChange()
    if bChange then
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("Potential_Preselection_UnSave_Tip"),
        callbackConfirm = function()
          PanelManager.Home()
        end
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
      return
    end
  end
  PanelManager.Home()
end

return PotentialPreselectionEditCtrl
