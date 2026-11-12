local CommonTipsBaseCtrl = require("Game.UI.CommonTipsEx.CommonTipsBaseCtrl")
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local SoldierCharTipsCtrl = class("SoldierCharTipsCtrl", CommonTipsBaseCtrl)
SoldierCharTipsCtrl._mapNodeConfig = {
  btnCloseTips = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClosePanel"
  },
  rtContent = {
    sComponentName = "RectTransform"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "RectTransform"
  },
  btnCloseWordTip = {
    sComponentName = "Button",
    callback = "OnBtnClick_CloseWord"
  },
  imgWordTipBg = {},
  TMPWordDesc = {sComponentName = "TMP_Text"},
  TMPWordTipsTitle = {sComponentName = "TMP_Text"},
  imgTipsBg = {
    sComponentName = "RectTransform"
  },
  TipsContent = {
    sComponentName = "RectTransform"
  },
  ScrollView = {sComponentName = "ScrollRect"},
  rtDescContent = {
    sComponentName = "RectTransform"
  },
  srDesc = {
    sComponentName = "RectTransform"
  },
  tc_char_small = {
    sCtrlName = "Game.UI.Soldier.Template.Character.SoldierCharItemCtrl"
  },
  txtTitleName = {sComponentName = "TMP_Text"},
  txtCost = {sComponentName = "TMP_Text"},
  txtChessType = {sComponentName = "TMP_Text"},
  goStar = {sNodeName = "Star", nCount = 5},
  goPartnerRootLayout = {sComponentName = "Transform"},
  goPartnerItem = {sComponentName = "Transform"},
  imgHpBar = {
    sComponentName = "RectTransform"
  },
  imgHpFill = {sComponentName = "Image"},
  txtHp = {sComponentName = "TMP_Text"},
  imgEnergyBar = {
    sComponentName = "RectTransform"
  },
  imgEnergyFill = {sComponentName = "Image"},
  txtEnergy = {sComponentName = "TMP_Text"},
  goAttrGridLayout = {sComponentName = "Transform"},
  goPropertyItem = {sComponentName = "Transform"},
  goBaseInfo = {
    sComponentName = "RectTransform"
  },
  btnCharAttr = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CharAttr"
  },
  btnTabFront = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Front"
  },
  btnTabSupport = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Support"
  },
  txtTitleSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_SkillTitle"
  },
  goSkillItem = {
    nCount = 3,
    sCtrlName = "Game.UI.Soldier.CharacterTips.Items.SoldierCharSkillItemCtrl"
  },
  btnSkillItem = {
    nCount = 3,
    sNodeName = "goSkillItem",
    sComponentName = "UIButton",
    callback = "OnBtnClick_SkillItem"
  },
  txtTitlePotential = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_PotentialTitle"
  },
  goPotentialList = {sComponentName = "Transform"},
  goPotentialItem = {sComponentName = "Transform"},
  go_Vanguard_on = {},
  go_Vanguard_off = {},
  go_Support_on = {},
  go_Support_off = {},
  txt_Vanguard_on = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Vanguard_Skill"
  },
  txt_Vanguard_off = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Vanguard_Skill"
  },
  txt_Support_on = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Support_Skill"
  },
  txt_Support_off = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Support_Skill"
  },
  icon_Position = {sComponentName = "Image"},
  btnShortcutClose = {
    callback = "OnBtnClick_ClosePanel"
  },
  imgBg_Rare = {sComponentName = "Image"},
  img_Rare = {sComponentName = "Image"},
  trSkillDetail = {sComponentName = "Transform"},
  trPontentialDetail = {sComponentName = "Transform"},
  trPartnerDetail = {sComponentName = "Transform"},
  imgBG = {sNodeName = "----BG----", sComponentName = "Image"}
}
SoldierCharTipsCtrl._mapEventConfig = {
  OnSetTipsPosition = "OnEvent_SetTipsPosition",
  SoldierCharTips_ShowBg = "OnEvent_ShowBg"
}
SoldierCharTipsCtrl._mapRedDotConfig = {}
SoldierCharTipsCtrl.minTipHeight = 59.13
SoldierCharTipsCtrl.maxTipHeight = 896
local iconPath = "Icon/SoldierOtherIcon/"
local iconPartnerPath = "Icon/SoldierPartner/"
local ImgChessRarity = {
  [GameEnum.ChessRarity.Gold] = "ChessQuality_05_XL",
  [GameEnum.ChessRarity.Purple] = "ChessQuality_04_XL",
  [GameEnum.ChessRarity.Blue] = "ChessQuality_03_XL",
  [GameEnum.ChessRarity.Green] = "ChessQuality_02_XL",
  [GameEnum.ChessRarity.White] = "ChessQuality_01_XL"
}
local tbColor = {
  "#d5ddec",
  "#d8e8b6",
  "#a0c8fe",
  "#caaefa",
  "#fecc88"
}

function SoldierCharTipsCtrl:Awake()
  self._tbPartnerItems = {}
  self._tbPropertyItems = {}
  self._tbPotentialItems = {}
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.rtTarget = tbParam[1]
    self.tbData = tbParam[2]
    self.tbDeployedChess = tbParam[3] or {}
    self.tbPartner = tbParam[4] or {}
    self.tbCurAttr = tbParam[5] or {}
    self.bAddCharGrowth = tbParam[6]
  end
end

function SoldierCharTipsCtrl:OnEnable()
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
  if self._mapNode.btnShortcutClose ~= nil then
    self:EnableGamepadUI(self._mapNode.btnShortcutClose, true)
  end
  self.nId = self.tbData.nId
  if self.nId ~= nil then
    self:Refresh(self.nId, self.tbData)
  end
  if self.rtTarget ~= nil and self._mapNode.rtContent ~= nil and self._mapNode.safeAreaRoot ~= nil then
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if self._mapNode == nil then
        return
      end
      local nContentHeight = self._mapNode.rtDescContent.sizeDelta.y
      if nContentHeight > self.maxTipHeight then
        nContentHeight = self.maxTipHeight
        NovaAPI.SetScrollRectVertical(self._mapNode.ScrollView, true)
      end
      if nContentHeight < self.minTipHeight then
        nContentHeight = self.minTipHeight
        NovaAPI.SetScrollRectVertical(self._mapNode.ScrollView, false)
      end
      self._mapNode.srDesc.sizeDelta = Vector2(self._mapNode.srDesc.sizeDelta.x, nContentHeight)
      local nBaseInfoHeight = 0
      if self._mapNode.goBaseInfo ~= nil then
        LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goBaseInfo)
        nBaseInfoHeight = self._mapNode.goBaseInfo.rect.height
      end
      self._mapNode.imgTipsBg.sizeDelta = Vector2(self._mapNode.imgTipsBg.sizeDelta.x, nContentHeight + nBaseInfoHeight)
      self._mapNode.srDesc.gameObject:SetActive(false)
      self:SetTipsPosition(self.rtTarget, self._mapNode.rtContent, self._mapNode.safeAreaRoot)
      self._mapNode.srDesc.gameObject:SetActive(true)
      if self.bSetTipsPos ~= true then
        self._mapNode.trSkillDetail.position = self._mapNode.imgTipsBg.position
        self._mapNode.trPontentialDetail.position = self._mapNode.imgTipsBg.position
        self._mapNode.trPartnerDetail.position = self._mapNode.imgTipsBg.position
      end
    end
    
    cs_coroutine.start(wait)
  end
end

function SoldierCharTipsCtrl:OnDisable()
  self:DisableGamepadUI()
  self:_ClearPartnerTags()
  self:_ClearPropertyItems()
  self:_ClearPotentialItems()
end

function SoldierCharTipsCtrl:OnDestroy()
end

function SoldierCharTipsCtrl:Refresh(nId, tbData)
  self.nId = nId
  self.tbData = tbData
  local mapCfg = ConfigTable.GetData("SoldierCharacter", nId)
  if mapCfg == nil then
    printError("[SoldierCharTipsCtrl] SoldierCharacter 表找不到数据，id：" .. tostring(nId))
    return
  end
  self.mapCfg = mapCfg
  self:_SetBaseInfo(mapCfg, tbData)
  self:_SetAttr(mapCfg, tbData)
  self:_SetPotentials(mapCfg)
  self:_RefreshTabSelect(self.bChosenFont)
  self:_SetSkills(mapCfg, self.bChosenFont)
end

function SoldierCharTipsCtrl:_SetPotentials(mapCfg)
  self._mapNode.goPotentialItem.gameObject:SetActive(false)
  local tbList = {}
  for nStar = 1, 4 do
    local tbIds = mapCfg["Potential" .. nStar]
    if type(tbIds) == "table" then
      for _, nId in ipairs(tbIds) do
        if nId ~= nil and nId ~= 0 then
          tbList[#tbList + 1] = {nId = nId, nStar = nStar}
        end
      end
    elseif type(tbIds) == "number" and tbIds ~= 0 then
      tbList[#tbList + 1] = {nId = tbIds, nStar = nStar}
    end
  end
  for _, tbItem in ipairs(tbList) do
    local goItem = instantiate(self._mapNode.goPotentialItem, self._mapNode.goPotentialList)
    goItem.gameObject:SetActive(true)
    local objCtrl = self:BindCtrlByNode(goItem, "Game.UI.Soldier.Template.SoldierPotentialItemCtrl")
    if objCtrl ~= nil then
      local nStar = self.tbData.nStar
      objCtrl:SetItemData(tbItem.nId, tbItem.nStar)
      if nStar < tbItem.nStar then
        objCtrl:SetItemLockData(tbItem.nId, tbItem.nStar)
      end
      self._tbPotentialItems[#self._tbPotentialItems + 1] = objCtrl
    end
    local btnItem = goItem:GetComponent("UIButton")
    if btnItem ~= nil then
      btnItem.onClick:RemoveAllListeners()
      btnItem.onClick:AddListener(function()
        self:OnBtnClick_PotentialItem(tbItem)
      end)
    end
  end
end

function SoldierCharTipsCtrl:_SetSkills(mapCfg, bFront)
  if mapCfg == nil or type(self._mapNode.goSkillItem) ~= "table" then
    return
  end
  if bFront then
    local tbSlots = {
      {
        nSkillId = mapCfg.Skill,
        nSkillIndex = 2
      }
    }
    for i, objCtrl in ipairs(self._mapNode.goSkillItem) do
      local slot = tbSlots[i]
      if slot ~= nil and slot.nSkillId ~= nil and slot.nSkillId ~= 0 then
        objCtrl.gameObject:SetActive(true)
        objCtrl:SetData(slot.nSkillId, slot.nSkillIndex)
      else
        objCtrl.gameObject:SetActive(false)
      end
    end
  else
    local nSkillId = mapCfg.Support
    for i, objCtrl in ipairs(self._mapNode.goSkillItem) do
      if i == 1 and nSkillId ~= nil and nSkillId ~= 0 then
        objCtrl.gameObject:SetActive(true)
        objCtrl:SetData(nSkillId, 3)
      else
        objCtrl.gameObject:SetActive(false)
      end
    end
  end
end

function SoldierCharTipsCtrl:_ClearPotentialItems()
  if type(self._tbPotentialItems) == "table" then
    for _, objCtrl in ipairs(self._tbPotentialItems) do
      self:UnbindCtrlByNode(objCtrl)
    end
  end
  self._tbPotentialItems = {}
end

function SoldierCharTipsCtrl:_SetBaseInfo(mapCfg)
  self._mapNode.tc_char_small:SetItemData(mapCfg.Id)
  self._mapNode.tc_char_small:SetCharLevel(self.tbData.nStar)
  NovaAPI.SetTMPText(self._mapNode.txtTitleName, mapCfg.Name)
  NovaAPI.SetTMPText(self._mapNode.txtCost, mapCfg.Cost)
  local nChessType = mapCfg.Type
  local tbChessTypeConfig = CacheTable.GetData("_SoldierChessType", nChessType)
  NovaAPI.SetTMPText(self._mapNode.txtChessType, tbChessTypeConfig.Name)
  self:SetPngSprite(self._mapNode.icon_Position, iconPath .. tbChessTypeConfig.Icon)
  self:_SetPartnerTags(mapCfg)
  self:_SetStar(mapCfg)
  self:SetPngSprite(self._mapNode.imgBg_Rare, iconPath .. ImgChessRarity[mapCfg.Rarity])
  local _, rareColor = ColorUtility.TryParseHtmlString(tbColor[mapCfg.Rarity])
  NovaAPI.SetImageColor(self._mapNode.img_Rare, rareColor)
  if self.tbData.nPositionType == GameEnum.SoldierPositionType.FightPosition then
    nChessType = GameEnum.ChessType.Vanguard
  elseif self.tbData.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
    nChessType = GameEnum.ChessType.Support
  end
  if nChessType == GameEnum.ChessType.Balance or nChessType == GameEnum.ChessType.Vanguard then
    self:OnBtnClick_Front()
  else
    self:OnBtnClick_Support()
  end
end

local function _TransValueFormat(nValue, bPercent, nFormat)
  return FormatEffectValue(nValue, bPercent, nFormat)
end

function SoldierCharTipsCtrl:_SetAttr(mapCfg)
  self:_ClearPropertyItems()
  self._mapNode.goPropertyItem.gameObject:SetActive(false)
  local nStar = type(self.tbData) == "table" and self.tbData.nStar or mapCfg.MaxStar or 1
  local tbAttrSortList, tbAttrMap = SoldierAttrData.CalcCharacterAttr(mapCfg.Id, nStar, self.tbDeployedChess, self.tbPartner, nil, self.bAddCharGrowth)
  if type(tbAttrSortList) ~= "table" then
    return
  end
  if type(self.tbCurAttr) == "table" and next(self.tbCurAttr) ~= nil then
    local attrKeyMap = {
      Hp = "hp",
      HpMax = "hpMax",
      Energy = "nMaxEnergy",
      Atk = "atk",
      Def = "def",
      Recovery = "nRecoverRate",
      CritRate = "critRate",
      CritPower = "critPower",
      ATKSPD_P = "attackSpeed"
    }
    for _, mapAttr in ipairs(tbAttrSortList) do
      local curAttrKey = attrKeyMap[mapAttr.sKey]
      if curAttrKey ~= nil and self.tbCurAttr[curAttrKey] ~= nil then
        mapAttr.nValue = self.tbCurAttr[curAttrKey]
        print("[SoldierCharTipsCtrl] 实时属性覆盖：", mapAttr.sKey, "=", mapAttr.nValue)
      end
    end
    if tbAttrMap and tbAttrMap.InitialEnergy and self.tbCurAttr.nEnergy ~= nil then
      tbAttrMap.InitialEnergy.nValue = self.tbCurAttr.nEnergy
    end
  end
  for _, mapAttr in ipairs(tbAttrSortList) do
    local sKey = mapAttr.sKey
    if sKey == "Hp" then
      local nHp = type(self.tbCurAttr) == "table" and self.tbCurAttr.hp ~= nil and self.tbCurAttr.hp or mapAttr.nValue or 0
      local nMaxHp = type(self.tbCurAttr) == "table" and self.tbCurAttr.hpMax ~= nil and self.tbCurAttr.hpMax or mapAttr.nValue or 0
      self:_SetBar(self._mapNode.imgHpFill, self._mapNode.txtHp, nHp, nMaxHp, self._mapNode.imgHpBar)
    elseif sKey == "Energy" then
      local nMaxEnergy = mapAttr.nValue or 0
      local nInitEnergy = tbAttrMap and tbAttrMap.InitialEnergy and tbAttrMap.InitialEnergy.nValue or 0
      self:_SetBar(self._mapNode.imgEnergyFill, self._mapNode.txtEnergy, nInitEnergy, nMaxEnergy, self._mapNode.imgEnergyBar)
    elseif sKey ~= "InitialEnergy" then
      local mapAttributeDesc = CacheTable.GetData("_AttributeDesc", sKey)
      if mapAttributeDesc ~= nil then
        local goItem = instantiate(self._mapNode.goPropertyItem, self._mapNode.goAttrGridLayout)
        goItem.gameObject:SetActive(true)
        local trIcon = goItem:Find("imgIcon")
        if trIcon ~= nil and mapAttributeDesc.Icon and 0 < #mapAttributeDesc.Icon then
          local img = trIcon:GetComponent("Image")
          if img ~= nil then
            self:SetPngSprite(img, mapAttributeDesc.Icon)
          end
        end
        local trName = goItem:Find("txtProperty")
        if trName ~= nil then
          local tmp = trName:GetComponent("TMP_Text")
          if tmp ~= nil then
            local sName
            if mapAttr.sLanguageId ~= nil then
              sName = ConfigTable.GetUIText(mapAttr.sLanguageId)
            else
              sName = mapAttributeDesc.Desc or ""
            end
            NovaAPI.SetTMPText(tmp, sName)
          end
        end
        local trValue = goItem:Find("txtValue2")
        if trValue ~= nil then
          local tmp = trValue:GetComponent("TMP_Text")
          if tmp ~= nil then
            local sValue = _TransValueFormat(mapAttr.nValue or 0, mapAttributeDesc.isPercent, mapAttributeDesc.Format)
            NovaAPI.SetTMPText(tmp, sValue)
            print("[SoldierCharTipsCtrl] 属性值：", sKey, "=", sValue)
          end
        end
        self._tbPropertyItems[#self._tbPropertyItems + 1] = goItem
      end
    end
  end
end

function SoldierCharTipsCtrl:_ClearPropertyItems()
  if type(self._tbPropertyItems) == "table" then
    for _, goItem in ipairs(self._tbPropertyItems) do
      if goItem ~= nil and goItem:IsNull() == false then
        destroy(goItem.gameObject)
      end
    end
  end
  self._tbPropertyItems = {}
end

function SoldierCharTipsCtrl:_SetPartnerTags(mapCfg)
  self:_ClearPartnerTags()
  self._mapNode.goPartnerItem.gameObject:SetActive(false)
  local tbPartner = mapCfg.PartnerType
  if type(tbPartner) ~= "table" then
    return
  end
  for _, nPartnerType in ipairs(tbPartner) do
    local mapGroup = CacheTable.GetData("_SoldierPartnerGroup", nPartnerType)
    if mapGroup ~= nil then
      local goItem = instantiate(self._mapNode.goPartnerItem, self._mapNode.goPartnerRootLayout)
      goItem.gameObject:SetActive(true)
      local txtPartner = goItem:Find("txtPartner")
      if txtPartner ~= nil then
        local tmp = txtPartner:GetComponent("TMP_Text")
        if tmp ~= nil then
          NovaAPI.SetTMPText(tmp, mapGroup.Name or "")
        end
        local trIcon = goItem:Find("imgIcon")
        if trIcon ~= nil and mapGroup.Icon and #mapGroup.Icon > 0 then
          local img = trIcon:GetComponent("Image")
          if img ~= nil then
            self:SetPngSprite(img, iconPartnerPath .. mapGroup.Icon .. "_M")
          end
        end
      end
      local btnPartner = goItem:GetComponent("UIButton")
      if btnPartner ~= nil then
        btnPartner.onClick:RemoveAllListeners()
        btnPartner.onClick:AddListener(function()
          EventManager.Hit(EventId.OpenPanel, PanelId.SoldierPartnerTips, self._mapNode.trPartnerDetail, nPartnerType, 0, false, {}, false)
        end)
      end
      self._tbPartnerItems[#self._tbPartnerItems + 1] = goItem
    end
  end
end

function SoldierCharTipsCtrl:_ClearPartnerTags()
  if type(self._tbPartnerItems) == "table" then
    for _, goItem in ipairs(self._tbPartnerItems) do
      if goItem ~= nil and goItem:IsNull() == false then
        destroy(goItem.gameObject)
      end
    end
  end
  self._tbPartnerItems = {}
end

function SoldierCharTipsCtrl:_SetStar(mapCfg)
  local nStar = type(self.tbData) == "table" and self.tbData.nStar or mapCfg.MaxStar or 0
  for i = 1, 5 do
    if self._mapNode.goStar[i] ~= nil then
      self._mapNode.goStar[i]:SetActive(i <= nStar)
    end
  end
end

function SoldierCharTipsCtrl:_SetBar(imgFill, txt, nCur, nMax, rtBar)
  nCur = nCur or 0
  nMax = nMax or 0
  if imgFill ~= nil and rtBar ~= nil then
    LayoutRebuilder.ForceRebuildLayoutImmediate(rtBar)
    local nInitWidth = rtBar.rect.width
    local rt = imgFill.rectTransform
    if rt ~= nil then
      local nPct = 0 < nMax and nCur / nMax or 0
      rt.sizeDelta = Vector2(nInitWidth * nPct, rt.sizeDelta.y)
    end
  end
  if txt ~= nil then
    NovaAPI.SetTMPText(txt, string.format("%s/%s", tostring(nCur), tostring(nMax)))
  end
end

function SoldierCharTipsCtrl:OnBtnClick_ClosePanel()
  EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
end

function SoldierCharTipsCtrl:OnBtnClick_Front()
  self:_RefreshTabSelect(true)
  self:_SetSkills(self.mapCfg, true)
  self.bChosenFont = true
end

function SoldierCharTipsCtrl:OnBtnClick_Support()
  self:_RefreshTabSelect(false)
  self:_SetSkills(self.mapCfg, false)
  self.bChosenFont = false
end

function SoldierCharTipsCtrl:_RefreshTabSelect(bFront)
  self._mapNode.go_Vanguard_on.gameObject:SetActive(bFront)
  self._mapNode.go_Support_on.gameObject:SetActive(not bFront)
  self._mapNode.go_Vanguard_off.gameObject:SetActive(not bFront)
  self._mapNode.go_Support_off.gameObject:SetActive(bFront)
end

function SoldierCharTipsCtrl:OnBtnClick_SkillItem(btn, nIndex)
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharSkillDetail, self._mapNode.trSkillDetail, self.nId, self.tbData.nStar, self.bChosenFont)
end

function SoldierCharTipsCtrl:OnBtnClick_PotentialItem(tbItem)
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharPontentialDetailPanel, self._mapNode.trPontentialDetail, tbItem.nId)
end

function SoldierCharTipsCtrl:OnBtnClick_CloseWord(btn)
  self._mapNode.btnCloseWordTip.gameObject:SetActive(false)
  self._mapNode.imgWordTipBg:SetActive(false)
end

function SoldierCharTipsCtrl:OnBtnClick_CharAttr()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharAttriTips, self.nId, true)
end

function SoldierCharTipsCtrl:OnEvent_ShowBg()
  self._mapNode.imgBG.enabled = true
end

function SoldierCharTipsCtrl:OnEvent_SetTipsPosition(skillTipsPos, pontentialTipsPos, partnerTipsPos)
  self.bSetTipsPos = true
  if skillTipsPos ~= nil and self._mapNode.trSkillDetail ~= nil then
    self._mapNode.trSkillDetail.position = skillTipsPos
  end
  if pontentialTipsPos ~= nil and self._mapNode.trPontentialDetail ~= nil then
    self._mapNode.trPontentialDetail.position = pontentialTipsPos
  end
  if partnerTipsPos ~= nil and self._mapNode.trPartnerDetail ~= nil then
    self._mapNode.trPartnerDetail.position = partnerTipsPos
  end
end

return SoldierCharTipsCtrl
