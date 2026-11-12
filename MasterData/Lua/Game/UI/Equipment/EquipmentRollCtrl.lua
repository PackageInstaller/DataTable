local EquipmentRollCtrl = class("EquipmentRollCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
EquipmentRollCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goCoinOther = {},
  btnEquipmentSlot = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_EquipmentSlot"
  },
  imgLockBg = {nCount = 3},
  txtLockDesc = {nCount = 3, sComponentName = "TMP_Text"},
  imgLockType = {nCount = 3, sComponentName = "Image"},
  imgChoose = {nCount = 3},
  imgSlotIcon = {nCount = 3, sComponentName = "Transform"},
  imgCharHead = {sComponentName = "Image"},
  tab = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateTabCtrl"
  },
  btnTab = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  imgLayerLock = {nCount = 4},
  txtEquipOn = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Equipped"
  },
  imgTabMask = {},
  rtTabMak = {
    sNodeName = "imgTabMask",
    sComponentName = "RectTransform"
  },
  imgEquipmentIcon = {nCount = 2, sComponentName = "Transform"},
  txtEquipmentName = {nCount = 2, sComponentName = "TMP_Text"},
  imgEquipmentUp = {nCount = 2},
  txtEquipmentDesc = {sComponentName = "TMP_Text"},
  ScrollView = {sComponentName = "ScrollRect"},
  txtLockSwitch = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Roll_LockRoll"
  },
  btnSwitch = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  aniIconMask = {sNodeName = "IconMask", sComponentName = "Animator"},
  goSwitch = {},
  imgBgOn = {},
  imgBgOff = {},
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Roll_EmptyTitle"
  },
  txtLockLimit = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Roll_LockAttrTitle"
  },
  txtLockLimitCount = {sComponentName = "TMP_Text"},
  txtTitleCurAttr = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Roll_CurAttr"
  },
  goProperty = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateRandomPropertyCtrl"
  },
  btnUnlock = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Unlock"
  },
  btnLock = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  txtAlterEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Roll_NoneRolled"
  },
  goAlter = {},
  goPropertyAlter = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateRandomPropertyCtrl"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  btnRoll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Roll"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_ConfirmRollResult"
  },
  txtBtnRoll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_Reroll"
  },
  imgConfirmMask = {},
  imgCostIcon = {nCount = 2, sComponentName = "Image"},
  txtCostCount = {nCount = 2, sComponentName = "TMP_Text"},
  goCost2 = {},
  btnActive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Active"
  },
  txtBtnActive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_Active"
  },
  imgActiveCostIcon = {sComponentName = "Image"},
  txtActiveCostCount = {sComponentName = "TMP_Text"},
  btnEquip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Equip"
  },
  btnUnload = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Unload"
  },
  txtBtnEquip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_EquipShort"
  },
  txtBtnUnload = {
    sComponentName = "TMP_Text",
    sLanguageId = "Equipment_Btn_UnloadShort"
  },
  Replace = {
    sNodeName = "----Replace----",
    sCtrlName = "Game.UI.Equipment.EquipmentAttrReplaceCtrl"
  },
  FX = {sNodeName = "--FX--"}
}
EquipmentRollCtrl._mapEventConfig = {}

function EquipmentRollCtrl:Refresh()
  self:RefreshPresetData()
  self:RefreshPresetSlot()
  self:RefreshSlot()
end

function EquipmentRollCtrl:RefreshSlot()
  for i = 1, 2 do
    delChildren(self._mapNode.imgEquipmentIcon[i])
  end
  self.tbEquipmentIcon = {}
  self:RefreshSlotData()
  self:RefreshTab()
  self:RefreshIndexGem()
end

function EquipmentRollCtrl:RefreshIndexGem(bAfterActive)
  self:RefreshSelectData()
  self:RefreshEquipmentInfo()
  self:RefreshEquipmentTop()
  self:RefreshEquipmentState(bAfterActive)
  self:RefreshAttr()
  self:RefreshAlterAttr()
  self:RefreshCoin()
  self:RefreshConfirm()
end

function EquipmentRollCtrl:RefreshPresetData()
  local nSelect = PlayerData.Equipment:GetSelectPreset(self._panel.nCharId)
  self.tbSlot = PlayerData.Equipment:GetSlotWithIndex(self._panel.nCharId, nSelect)
end

function EquipmentRollCtrl:RefreshPresetSlot()
  for i = 1, 3 do
    local mapSlot = self.tbSlot[i]
    local bUnlock = mapSlot.bUnlock
    self._mapNode.imgLockBg[i].gameObject:SetActive(not bUnlock)
    self._mapNode.imgSlotIcon[i].gameObject:SetActive(bUnlock)
    self._mapNode.imgChoose[i].gameObject:SetActive(self._panel.nSlotId == mapSlot.nSlotId)
    local nGemId = PlayerData.Equipment:GetGemIdBySlot(self._panel.nCharId, mapSlot.nSlotId)
    local mapGemCfg = ConfigTable.GetData("CharGem", nGemId)
    if mapGemCfg then
      if not bUnlock then
        self:SetPngSprite(self._mapNode.imgLockType[i], mapGemCfg.IconBg)
        NovaAPI.SetTMPText(self._mapNode.txtLockDesc[i], orderedFormat(ConfigTable.GetUIText("Equipment_SlotActiveLevel"), mapSlot.nLevel))
      else
        delChildren(self._mapNode.imgSlotIcon[i])
        local equipPrefab
        local sPrefab = mapGemCfg.Icon .. ".prefab"
        if GameResourceLoader.ExistsAsset(Settings.AB_ROOT_PATH .. sPrefab) == true then
          equipPrefab = self:LoadAsset(sPrefab)
        end
        if equipPrefab then
          local goEquip = instantiate(equipPrefab, self._mapNode.imgSlotIcon[i])
          goEquip.transform:Find("goFx").gameObject:SetActive(false)
        end
      end
    end
  end
  local nCharSkinId = PlayerData.Char:GetCharSkinId(self._panel.nCharId)
  local sIcon = ConfigTable.GetData_CharacterSkin(nCharSkinId).Icon
  self:SetPngSprite(self._mapNode.imgCharHead, sIcon, AllEnum.CharHeadIconSurfix.L)
end

function EquipmentRollCtrl:RefreshSlotData()
  local nGemId = PlayerData.Equipment:GetGemIdBySlot(self._panel.nCharId, self._panel.nSlotId)
  self.mapGemCfg = ConfigTable.GetData("CharGem", nGemId)
  self.mapSlotCfg = ConfigTable.GetData("CharGemSlotControl", self._panel.nSlotId)
  self._mapNode.TopBar:CreateCoin({
    self.mapGemCfg.RefreshCostTid,
    self.mapSlotCfg.LockItemTid
  })
  self.nSubSelectIndex = 1
end

function EquipmentRollCtrl:RefreshSelectData()
  local tbEquipment = PlayerData.Equipment:GetEquipmentBySlot(self._panel.nCharId, self._panel.nSlotId)
  self.mapEquipment = tbEquipment[self._panel.nSelectGemIndex]
  self.tbLockAttr = {}
end

function EquipmentRollCtrl:RefreshTab()
  for i = 1, 4 do
    local nState = self:GetTabState(i)
    self._mapNode.tab[i]:SetSelect(i == self._panel.nSelectGemIndex, nState)
    self._mapNode.tab[i]:SetText(ConfigTable.GetUIText("RomanNumeral_" .. i))
    if i == self._panel.nSelectGemIndex and 1 < i then
      self._mapNode.tab[i - 1]:SetLine(false)
    end
  end
  self:RefreshTabState()
end

function EquipmentRollCtrl:GetTabState(nCurTab)
  local nState = 2
  if nCurTab == 1 then
    nState = 1
  elseif nCurTab == 4 then
    nState = 3
  end
  return nState
end

function EquipmentRollCtrl:RefreshTabState()
  local tbEquipment = PlayerData.Equipment:GetEquipmentBySlot(self._panel.nCharId, self._panel.nSlotId)
  for i = 1, 4 do
    local mapEquipment = tbEquipment[i]
    self._mapNode.imgLayerLock[i]:SetActive(mapEquipment and mapEquipment.bLock)
    self._mapNode.txtEquipOn[i].gameObject:SetActive(self._panel.nEquipedGemIndex == i)
  end
  local bMask = tbEquipment and #tbEquipment < self.mapSlotCfg.MaxAlterNum - 1
  self._mapNode.imgTabMask:SetActive(bMask)
  self.nFirstEmpty = 0
  if bMask then
    for i = 1, self.mapSlotCfg.MaxAlterNum do
      local mapEquipment = tbEquipment[i]
      local bEmpty = mapEquipment == nil
      if bEmpty then
        self.nFirstEmpty = i
        break
      end
    end
    local tbPos = {
      521.2937,
      352.58,
      183.4057
    }
    local nWidth = tbPos[self.nFirstEmpty] or 0
    self._mapNode.rtTabMak.sizeDelta = Vector2(nWidth, 74)
  end
end

function EquipmentRollCtrl:RefreshEquipmentTop()
  local sRoman = ConfigTable.GetUIText("RomanNumeral_" .. self._panel.nSelectGemIndex)
  local sSuf = orderedFormat(ConfigTable.GetUIText("Equipment_NameIndexSuffix"), sRoman)
  NovaAPI.SetTMPText(self._mapNode.txtEquipmentName[self.nSubSelectIndex], self.mapGemCfg.Title .. sSuf)
  local bUpgrade = self.mapEquipment and self.mapEquipment:GetUpgradeCount() > 0
  self._mapNode.imgEquipmentUp[self.nSubSelectIndex]:SetActive(bUpgrade)
  if self.tbEquipmentIcon[self.nSubSelectIndex] then
    self.tbEquipmentIcon[self.nSubSelectIndex].transform:Find("goFx").gameObject:SetActive(bUpgrade)
  end
end

function EquipmentRollCtrl:RefreshEquipmentInfo()
  for i = 1, 2 do
    if self.tbEquipmentIcon[i] == nil then
      local equipPrefab
      local sPrefab = self.mapGemCfg.Icon .. ".prefab"
      if GameResourceLoader.ExistsAsset(Settings.AB_ROOT_PATH .. sPrefab) == true then
        equipPrefab = self:LoadAsset(sPrefab)
      end
      if equipPrefab then
        self.tbEquipmentIcon[i] = instantiate(equipPrefab, self._mapNode.imgEquipmentIcon[i])
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtEquipmentDesc, self.mapGemCfg.Desc)
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView, 1)
  local nLockAttr = self:GetAttrLockCount()
  NovaAPI.SetTMPText(self._mapNode.txtLockLimitCount, orderedFormat(ConfigTable.GetUIText("Equipment_Roll_LockAttrCount"), nLockAttr, self.mapSlotCfg.LockableNum))
  self:RefreshLock()
end

function EquipmentRollCtrl:RefreshEquipmentState(bAfterActive)
  local bEmpty = self.mapEquipment == nil
  self._mapNode.goSwitch:SetActive(not bEmpty)
  self._mapNode.btnConfirm.gameObject:SetActive(not bEmpty)
  self._mapNode.btnRoll.gameObject:SetActive(not bEmpty)
  self._mapNode.btnActive.gameObject:SetActive(bEmpty)
  self._mapNode.btnEquip.gameObject:SetActive(not bEmpty and self._panel.nEquipedGemIndex ~= self._panel.nSelectGemIndex)
  self._mapNode.btnUnload.gameObject:SetActive(not bEmpty and self._panel.nEquipedGemIndex == self._panel.nSelectGemIndex)
  if bAfterActive then
    self._mapNode.FX:SetActive(false)
    self._mapNode.FX:SetActive(true)
    
    local function callback()
      self._mapNode.imgBgOff:SetActive(bEmpty)
      self._mapNode.imgBgOn:SetActive(not bEmpty)
      WwiseAudioMgr:PostEvent("ui_charInfo_equipment_coagulate_ani")
    end
    
    self:AddTimer(1, 0.07, callback, true, true, true)
  else
    self._mapNode.imgBgOff:SetActive(bEmpty)
    self._mapNode.imgBgOn:SetActive(not bEmpty)
  end
end

function EquipmentRollCtrl:GetAttrLockCount()
  local nLockAttr = 0
  for _, v in pairs(self.tbLockAttr) do
    if v == true then
      nLockAttr = nLockAttr + 1
    end
  end
  return nLockAttr
end

function EquipmentRollCtrl:RefreshLock()
  if not self.mapEquipment then
    return
  end
  self._mapNode.btnSwitch[1].gameObject:SetActive(not self.mapEquipment.bLock)
  self._mapNode.btnSwitch[2].gameObject:SetActive(self.mapEquipment.bLock)
end

function EquipmentRollCtrl:RefreshAttr()
  if not self.mapEquipment then
    return
  end
  for i = 1, 4 do
    self._mapNode.goProperty[i]:SetProperty(self.mapEquipment.tbAffix[i], self._panel.nCharId, false, self.mapEquipment.tbUpgradeCount[i])
    self:RefreshAttrLock(i)
  end
end

function EquipmentRollCtrl:RefreshAttrLock(nIndex)
  local bAttrLock = self.tbLockAttr[nIndex] == true
  self._mapNode.btnUnlock[nIndex].gameObject:SetActive(bAttrLock)
  self._mapNode.btnLock[nIndex].gameObject:SetActive(not bAttrLock)
end

function EquipmentRollCtrl:RefreshAlterAttr(bRoll)
  if bRoll then
    self._mapNode.goAlter.gameObject:SetActive(false)
  end
  local bEmpty = not self.mapEquipment or self.mapEquipment:CheckAlterEmpty()
  self._mapNode.txtAlterEmpty.gameObject:SetActive(bEmpty)
  self._mapNode.goAlter.gameObject:SetActive(not bEmpty)
  if not bEmpty then
    for i = 1, 4 do
      self._mapNode.goPropertyAlter[i]:SetProperty(self.mapEquipment.tbAlterAffix[i], self._panel.nCharId, self.tbLockAttr[i], self.mapEquipment.tbAlterUpgradeCount[i])
    end
  end
end

function EquipmentRollCtrl:RefreshCoin()
  local nLockAttr = self:GetAttrLockCount()
  local bUseLock = 0 < nLockAttr
  self._mapNode.goCost2.gameObject:SetActive(bUseLock)
  self._mapNode.imgCostIcon[2].gameObject:SetActive(bUseLock)
  self._mapNode.txtCostCount[2].gameObject:SetActive(bUseLock)
  if bUseLock then
    self:SetSprite_Coin(self._mapNode.imgCostIcon[2], self.mapSlotCfg.LockItemTid)
    local nHas1 = PlayerData.Item:GetItemCountByID(self.mapSlotCfg.LockItemTid)
    NovaAPI.SetTMPText(self._mapNode.txtCostCount[2], self.mapSlotCfg.LockItemQty * nLockAttr)
    NovaAPI.SetTMPColor(self._mapNode.txtCostCount[2], nHas1 < self.mapSlotCfg.LockItemQty * nLockAttr and Red_Unable or Blue_Normal)
  end
  self:SetSprite_Coin(self._mapNode.imgCostIcon[1], self.mapGemCfg.RefreshCostTid)
  local nHas2 = PlayerData.Item:GetItemCountByID(self.mapGemCfg.RefreshCostTid)
  NovaAPI.SetTMPText(self._mapNode.txtCostCount[1], self.mapSlotCfg.RefreshCostQty)
  NovaAPI.SetTMPColor(self._mapNode.txtCostCount[1], nHas2 < self.mapSlotCfg.RefreshCostQty and Red_Unable or Blue_Normal)
  self:SetSprite_Coin(self._mapNode.imgActiveCostIcon, self.mapGemCfg.GenerateCostTid)
  local nHas3 = PlayerData.Item:GetItemCountByID(self.mapGemCfg.GenerateCostTid)
  NovaAPI.SetTMPText(self._mapNode.txtActiveCostCount, self.mapSlotCfg.GeneratenCostQty)
  NovaAPI.SetTMPColor(self._mapNode.txtActiveCostCount, nHas3 < self.mapSlotCfg.GeneratenCostQty and Red_Unable or Blue_Normal)
end

function EquipmentRollCtrl:RefreshConfirm()
  local bEmpty = not self.mapEquipment or self.mapEquipment:CheckAlterEmpty()
  self._mapNode.imgConfirmMask:SetActive(bEmpty)
end

function EquipmentRollCtrl:GetRareCount(tbAffix)
  local nRareCount = 0
  for _, v in ipairs(tbAffix) do
    if v ~= 0 then
      local mapCfg = ConfigTable.GetData("CharGemAttrValue", v)
      if mapCfg and mapCfg.Rarity == GameEnum.itemRarity.SSR then
        nRareCount = nRareCount + 1
      end
    end
  end
  return nRareCount
end

function EquipmentRollCtrl:FadeIn()
  self.animator = self.gameObject.transform:GetComponent("Animator")
  self.animator:Play("EquipmentSelectPanel_in1")
end

function EquipmentRollCtrl:Awake()
end

function EquipmentRollCtrl:OnEnable()
  self:Refresh()
end

function EquipmentRollCtrl:OnDisable()
  if self.timer ~= nil then
    self.timer:Cancel()
  end
end

function EquipmentRollCtrl:OnDestroy()
end

function EquipmentRollCtrl:OnBtnClick_Switch(btn, nIndex)
  local bLock = nIndex == 1
  
  local function callback()
    self:RefreshLock()
    self:RefreshTabState()
  end
  
  PlayerData.Equipment:SendCharGemUpdateGemLockStatusReq(self._panel.nCharId, self._panel.nSlotId, self._panel.nSelectGemIndex, bLock, callback)
end

function EquipmentRollCtrl:OnBtnClick_Unlock(btn, nIndex)
  self.tbLockAttr[nIndex] = false
  self:RefreshAttrLock(nIndex)
  local nLockAttr = self:GetAttrLockCount()
  self:RefreshCoin()
  NovaAPI.SetTMPText(self._mapNode.txtLockLimitCount, orderedFormat(ConfigTable.GetUIText("Equipment_Roll_LockAttrCount"), nLockAttr, self.mapSlotCfg.LockableNum))
end

function EquipmentRollCtrl:OnBtnClick_Lock(btn, nIndex)
  local nLockAttr = self:GetAttrLockCount()
  if nLockAttr >= self.mapSlotCfg.LockableNum then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_LockAttrMax"))
    return
  end
  self.tbLockAttr[nIndex] = true
  self:RefreshAttrLock(nIndex)
  self:RefreshCoin()
  NovaAPI.SetTMPText(self._mapNode.txtLockLimitCount, orderedFormat(ConfigTable.GetUIText("Equipment_Roll_LockAttrCount"), nLockAttr + 1, self.mapSlotCfg.LockableNum))
end

function EquipmentRollCtrl:OnBtnClick_Confirm(btn)
  local bEmpty = not self.mapEquipment or self.mapEquipment:CheckAlterEmpty()
  if bEmpty then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_ConfirmRoll_AlterEmpty"))
    return
  end
  if self.mapEquipment.bLock then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_ConfirmRoll_EquipmentLock"))
    return
  end
  
  local function callback()
    self:RefreshAttr()
    self:RefreshAlterAttr()
    self:RefreshCoin()
    self:RefreshConfirm()
    self.animator:Play("EquipmentSelectPanel_in", 0, 0)
  end
  
  local sRoman = ConfigTable.GetUIText("RomanNumeral_" .. self._panel.nSelectGemIndex)
  local sSuf = orderedFormat(ConfigTable.GetUIText("Equipment_NameIndexSuffix"), sRoman)
  local sName = self.mapGemCfg.Title .. sSuf
  self._mapNode.Replace:Open(sName, self.mapEquipment, self._panel.nCharId, self._panel.nSlotId, self._panel.nSelectGemIndex, callback)
end

function EquipmentRollCtrl:OnBtnClick_Roll(btn)
  if self.mapEquipment.bLock then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_Roll_EquipmentLock"))
    return
  end
  local bHasUpgrade = false
  for k, v in pairs(self.mapEquipment.tbUpgradeCount) do
    if 0 < v and not self.tbLockAttr[k] then
      bHasUpgrade = true
      break
    end
  end
  local tbLockAttrId = {}
  for k, v in pairs(self.tbLockAttr) do
    if v == true then
      table.insert(tbLockAttrId, self.mapEquipment.tbAffix[k])
    end
  end
  local bEnough = false
  local nHasRefresh = PlayerData.Item:GetItemCountByID(self.mapGemCfg.RefreshCostTid)
  local nLockAttr = self:GetAttrLockCount()
  local bUseLock = 0 < nLockAttr
  if bUseLock then
    local nHasLock = PlayerData.Item:GetItemCountByID(self.mapSlotCfg.LockItemTid)
    bEnough = nHasLock >= self.mapSlotCfg.LockItemQty * nLockAttr and nHasRefresh >= self.mapSlotCfg.RefreshCostQty
  else
    bEnough = nHasRefresh >= self.mapSlotCfg.RefreshCostQty
  end
  if not bEnough then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_MatNotEnough_Roll"))
    if nHasRefresh < self.mapSlotCfg.RefreshCostQty then
      self._mapNode.TopBar:OnBtnClick_CoinFirstTips(self._mapNode.goCoinOther)
    end
    return
  end
  
  local function step1(next)
    local isSelectAgain = false
    
    local function confirmCallback()
      PlayerData.Equipment:SetRollUpgradeWarning(not isSelectAgain)
      next()
    end
    
    local function againCallback(isSelect)
      isSelectAgain = isSelect
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Equipment_RollWarning_HasUpgrade"),
      callbackConfirm = confirmCallback,
      callbackAgain = againCallback,
      sAgain = ConfigTable.GetUIText("MessageBox_LoginWarning")
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
  
  local function step2()
    local function roll()
      local function callback()
        self:RefreshAlterAttr(true)
        
        self:RefreshCoin()
        self:RefreshConfirm()
        WwiseAudioMgr:PostEvent("ui_charInfo_equipment_reforge_ani")
      end
      
      PlayerData.Equipment:SendCharGemRefreshReq(self._panel.nCharId, self._panel.nSlotId, self._panel.nSelectGemIndex, tbLockAttrId, callback)
    end
    
    local function warning()
      local isSelectAgain = false
      
      local function confirmCallback()
        PlayerData.Equipment:SetRollWarning(not isSelectAgain)
        roll()
      end
      
      local function againCallback(isSelect)
        isSelectAgain = isSelect
      end
      
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("Equipment_RollWarning_HighQuality"),
        callbackConfirm = confirmCallback,
        callbackAgain = againCallback,
        sAgain = ConfigTable.GetUIText("MessageBox_LoginWarning")
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end
    
    local bWarn = PlayerData.Equipment:GetRollWarning()
    if self.mapEquipment.tbAlterAffix and bWarn then
      local nRareCount = self:GetRareCount(self.mapEquipment.tbAffix)
      local nAlterRareCount = self:GetRareCount(self.mapEquipment.tbAlterAffix)
      local bLock = false
      for k, v in pairs(self.tbLockAttr) do
        if v == true then
          bLock = true
          break
        end
      end
      local bHasHQ = PlayerData.Equipment:CheckAlterHighQualityAffix(self.mapEquipment.tbAlterAffix, tbLockAttrId)
      if not bLock and nAlterRareCount >= ConfigTable.GetConfigNumber("CharGemHighQualityNum") then
        warning()
      elseif bLock and nRareCount < nAlterRareCount then
        warning()
      elseif bHasHQ then
        warning()
      else
        roll()
      end
    else
      roll()
    end
  end
  
  local bWarn = PlayerData.Equipment:GetRollUpgradeWarning()
  if bHasUpgrade and bWarn then
    step1(step2)
  else
    step2()
  end
end

function EquipmentRollCtrl:OnBtnClick_EquipmentSlot(_, nIndex)
  if not self.tbSlot[nIndex].bUnlock then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("Equipment_SlotLock"), self.tbSlot[nIndex].nLevel))
    return
  end
  if self.tbSlot[nIndex].nSlotId == self._panel.nSlotId then
    return
  end
  self._panel.nSlotId = self.tbSlot[nIndex].nSlotId
  self._panel.nEquipedGemIndex = self.tbSlot[nIndex].nGemIndex
  self._panel.nSelectGemIndex = self.tbSlot[nIndex].nGemIndex == 0 and 1 or self.tbSlot[nIndex].nGemIndex
  PlayerData.Equipment:CacheEquipmentSelect(self._panel.nSlotId, self._panel.nSelectGemIndex, self._panel.nCharId)
  for i = 1, 3 do
    self._mapNode.imgChoose[i].gameObject:SetActive(self._panel.nSlotId == self.tbSlot[i].nSlotId)
  end
  self.animator:Play("EquipmentSelectPanel_in", 0, 0)
  self:RefreshSlot()
end

function EquipmentRollCtrl:OnBtnClick_Tab(btn, nIndex)
  if nIndex == self._panel.nSelectGemIndex then
    return
  end
  if self.nFirstEmpty > 0 and nIndex > self.nFirstEmpty then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_SlotGemEmpty"))
    return
  end
  if self.timer ~= nil then
    self.timer:Cancel()
  end
  local nState = self:GetTabState(self._panel.nSelectGemIndex)
  self._mapNode.tab[self._panel.nSelectGemIndex]:SetSelect(false, nState)
  if self._panel.nSelectGemIndex > 1 then
    self._mapNode.tab[self._panel.nSelectGemIndex - 1]:SetLine(true)
  end
  nState = self:GetTabState(nIndex)
  self._mapNode.tab[nIndex]:SetSelect(true, nState)
  if 1 < nIndex then
    self._mapNode.tab[nIndex - 1]:SetLine(false)
  end
  local sAnimName = nIndex > self._panel.nSelectGemIndex and "IconMaskSwitch1_R" or "IconMaskSwitch1_L"
  self.nSubSelectIndex = 2
  self._mapNode.aniIconMask:Play(sAnimName)
  self._panel.nSelectGemIndex = nIndex
  PlayerData.Equipment:CacheEquipmentSelect(self._panel.nSlotId, self._panel.nSelectGemIndex, self._panel.nCharId)
  self:RefreshIndexGem()
  self.animator:Play("EquipmentSelectPanel_in", 0, 0)
  
  local function callback()
    self.nSubSelectIndex = 1
    self:RefreshEquipmentTop()
  end
  
  local nAnimTime = NovaAPI.GetAnimClipLength(self._mapNode.aniIconMask, {sAnimName})
  self.timer = self:AddTimer(1, nAnimTime, callback, true, true, true)
end

function EquipmentRollCtrl:OnBtnClick_Active()
  local nHas = PlayerData.Item:GetItemCountByID(self.mapGemCfg.GenerateCostTid)
  if nHas < self.mapSlotCfg.GeneratenCostQty then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Equipment_MatNotEnough_Active"))
    self._mapNode.TopBar:OnBtnClick_CoinFirstTips(self._mapNode.goCoinOther)
    return
  end
  
  local function callback()
    PlayerData.Equipment:CacheEquipmentSelect(self._panel.nSlotId, self._panel.nSelectGemIndex, self._panel.nCharId)
    self:RefreshTab()
    self:RefreshIndexGem(true)
  end
  
  PlayerData.Equipment:SendCharGemGenerateReq(self._panel.nCharId, self._panel.nSlotId, self._panel.nSelectGemIndex, callback)
end

function EquipmentRollCtrl:OnBtnClick_Unload()
  local nSelectPreset = PlayerData.Equipment:GetSelectPreset(self._panel.nCharId)
  
  local function callback()
    self._panel.nEquipedGemIndex = 0
    self:RefreshPresetData()
    self:RefreshTab()
    self:RefreshIndexGem()
  end
  
  PlayerData.Equipment:SendCharGemEquipGemReq(self._panel.nCharId, self._panel.nSlotId, 0, nSelectPreset, callback)
end

function EquipmentRollCtrl:OnBtnClick_Equip()
  local nSelectPreset = PlayerData.Equipment:GetSelectPreset(self._panel.nCharId)
  
  local function callback()
    self._panel.nEquipedGemIndex = self._panel.nSelectGemIndex
    self:RefreshPresetData()
    self:RefreshTab()
    self:RefreshIndexGem()
  end
  
  PlayerData.Equipment:SendCharGemEquipGemReq(self._panel.nCharId, self._panel.nSlotId, self._panel.nSelectGemIndex, nSelectPreset, callback)
end

return EquipmentRollCtrl
