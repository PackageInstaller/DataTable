local SoldierRoomInfoCtrl = class("SoldierRoomInfoCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local LocalData = require("GameCore.Data.LocalData")
SoldierRoomInfoCtrl._mapNodeConfig = {
  canvas_group = {
    sComponentName = "CanvasGroup",
    sNodeName = "----SafeAreaRoot----"
  },
  btnPause = {
    sComponentName = "UIButton",
    callback = "OnBtn_Pause"
  },
  BtnBg = {},
  goNodeInfo = {},
  txtNode = {sComponentName = "TMP_Text"},
  txtProgress = {sComponentName = "TMP_Text"},
  imgProgressBg = {
    sComponentName = "RectTransform"
  },
  imgProgress = {sComponentName = "Image"},
  txtCurHp = {sComponentName = "TMP_Text"},
  txtCoin = {sComponentName = "TMP_Text"},
  btnCoin = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CoinTips"
  },
  goCharList = {},
  goMainChar = {
    nCount = 3,
    sCtrlName = "Game.UI.Soldier.Battle.SoldierMainCharItemCtrl"
  },
  goSubChar = {
    nCount = 6,
    sCtrlName = "Game.UI.Soldier.Battle.SoldierSubCharItemCtrl"
  },
  goDamage = {nCount = 9},
  txtChessName = {nCount = 9, sComponentName = "TMP_Text"},
  txtDamage = {nCount = 9, sComponentName = "TMP_Text"},
  rtChallengeTime = {},
  TMPChallengeTime = {sComponentName = "TMP_Text"},
  imgUnfold = {},
  btnFold = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Fold"
  },
  btnPartner = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Partner"
  },
  btnCharacter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Character"
  },
  svPartnerUnfold = {sComponentName = "Transform"},
  svCharUnfold = {sComponentName = "Transform"},
  goPartnerItem = {sComponentName = "Transform"},
  goPartnerUnfold = {sComponentName = "Transform"},
  goCharDamageItem = {sComponentName = "Transform"},
  goCharUnfold = {sComponentName = "Transform"},
  imgFold = {},
  btnUnfold = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Unfold"
  },
  btnChange = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Change"
  },
  txtBtnPartner = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Battle_Btn_Partner"
  },
  txtBtnChar = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Battle_Btn_Char"
  },
  svPartnerFold = {sComponentName = "Transform"},
  svCharFold = {sComponentName = "Transform"},
  goPartnerItemFold = {sComponentName = "Transform"},
  goPartnerFold = {sComponentName = "Transform"},
  goCharItemFold = {sComponentName = "Transform"},
  goCharFold = {sComponentName = "Transform"},
  txtBtnAutoBattleOpen = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "AutoBattle_Open"
  },
  txtBtnAutoBattleClose = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "AutoBattle_Close"
  },
  btnAutoBattleOpen = {
    sComponentName = "NaviButton",
    callback = "OnClick_AutoBattleOpen",
    sAction = "AutoBattle"
  },
  btnAutoBattleClose = {
    sComponentName = "NaviButton",
    callback = "OnClick_AutoBattleClose",
    sAction = "AutoBattle"
  },
  btn_speed = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_ChangeSpeed"
  },
  txtBtnspeed = {
    nCount = 4,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_AddSpeed"
  },
  go_X1 = {},
  go_X2 = {},
  charDetialRoot = {sComponentName = "Transform"},
  parnterDetialRoot = {sComponentName = "Transform"},
  goSurvivalTime = {},
  txtSurvivalTime = {sComponentName = "TMP_Text"},
  TimeItem = {nCount = 3},
  goRating = {},
  txtNodeRating = {sComponentName = "TMP_Text"},
  txtProgressRating = {sComponentName = "TMP_Text"},
  imgProgressRating = {sComponentName = "Image"},
  txtHp = {nCount = 3, sComponentName = "TMP_Text"},
  SkillItem = {},
  bossItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SkillDetail"
  },
  imgSkill = {sComponentName = "Image"},
  imgSkillInitiative = {},
  txtSkillInitiative = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossSkill_Active"
  },
  imgSkillPassive = {},
  txtSkillPassive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossSkill_Passive"
  },
  txtSkillName = {sComponentName = "TMP_Text"}
}
SoldierRoomInfoCtrl._mapEventConfig = {
  OpenSoldierRoomInfo = "OnEvent_OpenUI",
  InputEnable = "OnEvent_InputEnable",
  LoadLevelRefresh = "OnEvent_LoadLevelRefresh",
  RefreshSoldierBattleTime = "OnEvent_RefreshTime",
  RefreshSoldierChessList = "OnEvent_RefreshChessList",
  RefreshChessDamage = "OnEvent_RefreshChessDamage",
  RefreshSoldierProgress = "OnEvent_RefreshProgress",
  RefreshSoldierCoin = "OnEvent_RefreshCoin",
  RestartSoldier = "OnEvent_ClearSoldier",
  SettleSoldierBattle = "OnEvent_ClearSoldier",
  LeaveSoldier = "OnEvent_ClearSoldier",
  Soldier_Settlement_Ready = "OnEvent_SettlementReady",
  Soldier_IsStart_Ready = "OnEvent_IsStartReady",
  Soldier_IsStart_Ok = "OnEvent_IsStartOk",
  EnemyBattle_DpsCheckStageTotalDamage = "OnEvent_SetDPSMsg"
}
local colorWhite = Color(1, 1, 1, 1)
local colorRed = Color(0.8470588235294118, 0.3137254901960784, 0.32941176470588235)
local nMaxWidth = 0
local nHeight = 0
local TAB_PARTNER = 1
local TAB_CHARACTER = 2
local iconPath = "Icon/SoldierOtherIcon/"
local iconPartnerPath = "Icon/SoldierPartner/"

function SoldierRoomInfoCtrl:OpenUI(nFloorId)
  self.nFloorId = nFloorId
  local mapFloorCfg = ConfigTable.GetData("SoldierFloor", nFloorId)
  self.isDpsCheckStage = false
  if mapFloorCfg ~= nil then
    self.nTotalTime = mapFloorCfg.BattleTime
    self.nRemainTime = 0
    self.isDpsCheckStage = mapFloorCfg.IsDpsCheckStage
  end
  self:InitDpsCheckUI()
  nMaxWidth = self._mapNode.imgProgressBg.sizeDelta.x
  nHeight = self._mapNode.imgProgressBg.sizeDelta.y
  self._mapNode.rtChallengeTime.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, "00:00")
  NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
  local nHp = self.levelData:GetHp()
  NovaAPI.SetTMPText(self._mapNode.txtCurHp, nHp)
  local nCount = self.levelData:GetItem(AllEnum.CoinItemId.SoldierCurrency)
  NovaAPI.SetTMPText(self._mapNode.txtCoin, tostring(nCount))
  local nStage, nNodexIndex = PlayerData.SoldierData:GetCurChallengeState()
  NovaAPI.SetTMPText(self._mapNode.txtNode, nStage .. "-" .. nNodexIndex)
  self:ApplyViewState()
  self._mapNode.btnAutoBattleOpen.gameObject:SetActive(false)
  self._mapNode.btnAutoBattleClose.gameObject:SetActive(true)
  local bSpeed = LocalData.GetPlayerLocalData("Soldier_RoomInfo_SpeedUp") or false
  self:SetTimeScale(bSpeed)
  self:UpdateSpeedIcon()
end

function SoldierRoomInfoCtrl:InitDpsCheckUI()
  self._mapNode.goSurvivalTime:SetActive(self.isDpsCheckStage)
  self._mapNode.goRating:SetActive(self.isDpsCheckStage)
  self._mapNode.rtChallengeTime:SetActive(not self.isDpsCheckStage)
  self._mapNode.goNodeInfo:SetActive(not self.isDpsCheckStage)
  if self.isDpsCheckStage then
    self:InitDpsCheckUIMsg()
  end
end

function SoldierRoomInfoCtrl:CloseUI()
  for _, v in ipairs(self._mapNode.goMainChar) do
    v:CloseUI()
  end
  for _, v in ipairs(self._mapNode.goSubChar) do
    v:CloseUI()
  end
end

function SoldierRoomInfoCtrl:ApplyViewState()
  self._mapNode.txtBtnPartner[1].gameObject:SetActive(self._nShowTab == TAB_PARTNER)
  self._mapNode.txtBtnChar[1].gameObject:SetActive(self._nShowTab == TAB_CHARACTER)
  self._mapNode.imgUnfold.gameObject:SetActive(self._bUnfold)
  self._mapNode.imgFold.gameObject:SetActive(not self._bUnfold)
  if self._bUnfold then
    self._mapNode.svPartnerUnfold.gameObject:SetActive(self._nShowTab == TAB_PARTNER)
    self._mapNode.svCharUnfold.gameObject:SetActive(self._nShowTab == TAB_CHARACTER)
  else
    self._mapNode.svPartnerFold.gameObject:SetActive(self._nShowTab == TAB_PARTNER)
    self._mapNode.svCharFold.gameObject:SetActive(self._nShowTab == TAB_CHARACTER)
  end
  self:ChangeBtnBgState()
end

function SoldierRoomInfoCtrl:SetTime(nTime)
  self.nRemainTime = self.nTotalTime - nTime
  if self.nRemainTime <= 0 then
    NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, ConfigTable.GetUIText("Soldier_Battle_Speed"))
  else
    if self.nRemainTime <= 5 then
      NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorRed)
    else
      NovaAPI.SetTMPColor(self._mapNode.TMPChallengeTime, colorWhite)
    end
    local nMin = math.floor(self.nRemainTime / 60)
    local nSec = math.fmod(self.nRemainTime, 60)
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeTime, string.format("%02d:%02d", nMin, nSec))
  end
end

function SoldierRoomInfoCtrl:RefreshChessList()
  for _, v in ipairs(self._mapNode.goDamage) do
    v.gameObject:SetActive(false)
  end
  local tbActivePartner, tbPartner = SoldierAttrData.CalcActivePartners(self.tbChess)
  for k, v in ipairs(self.tbChess) do
    local nIndex = v.nIndex
    if v.nPositionType == GameEnum.SoldierPositionType.FightPosition then
      if v.nId > 0 then
        self._mapNode.goMainChar[nIndex]:InitChar(v, self.tbChess, tbActivePartner, self)
        self._mapNode.goMainChar[nIndex]:SetTipsRoot(self._mapNode.charDetialRoot)
      else
        self._mapNode.goMainChar[nIndex]:SetEmpty()
      end
    elseif v.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
      if v.nId > 0 then
        self._mapNode.goSubChar[nIndex]:InitChar(v, self.tbChess, tbActivePartner, self)
        self._mapNode.goSubChar[nIndex]:SetTipsRoot(self._mapNode.charDetialRoot)
      else
        self._mapNode.goSubChar[nIndex]:SetEmpty()
      end
    end
  end
  self:RefreshPartner(tbPartner)
  self:BuildCharList(self.tbChess)
end

function SoldierRoomInfoCtrl:RefreshPartner(tbPartner)
  if self._bPartnerBuilt then
    return
  end
  self.tabPartnerBtn = {}
  if tbPartner == nil then
    return
  end
  local index = 0
  for _, v in ipairs(tbPartner) do
    index = index + 1
    local mapPartnerGroupCfg = CacheTable.GetData("_SoldierPartnerGroup", v.nType)
    if mapPartnerGroupCfg ~= nil then
      local nPartnerQty = GameEnum.PartnerLevelQuality.None
      local sBgPath = ""
      local cfgList = CacheTable.GetData("_SoldierPartner", v.nType)
      if cfgList == nil then
        return
      end
      local partnerCfg = cfgList[v.nActiveLevel]
      if partnerCfg == nil then
        partnerCfg = cfgList[1]
      end
      if v.nActiveLevel == 0 then
        sBgPath = iconPath .. AllEnum.SoldierPartnerLevelIcon[GameEnum.PartnerLevelQuality.None].bg
      else
        sBgPath = iconPath .. AllEnum.SoldierPartnerLevelIcon[partnerCfg.PartnerLevelQuality].bg
      end
      
      local function clickCb()
        local bTrace = PlayerData.SoldierData:GetCurLevelData():CheckPartnerTrace(v.nType)
        EventManager.Hit(EventId.OpenPanel, PanelId.SoldierPartnerTips, self._mapNode.parnterDetialRoot, v.nType, v.nActiveLevel, bTrace)
        EventManager.Hit("OnSetParnterTipsPosition", self._mapNode.parnterDetialRoot:GetChild(0).position, self._mapNode.parnterDetialRoot:GetChild(1).position, self._mapNode.parnterDetialRoot:GetChild(2).position)
      end
      
      local goU = instantiate(self._mapNode.goPartnerItem, self._mapNode.goPartnerUnfold)
      goU.gameObject:SetActive(true)
      local imgQtyU = goU:Find("imgPartner"):GetComponent("Image")
      local imgIconU = goU:Find("imgPartnerIcon"):GetComponent("Image")
      local txtName = goU:Find("txtPartnerName"):GetComponent("TMP_Text")
      local txtLvlU = goU:Find("imgPartnerbg/txtPartner"):GetComponent("TMP_Text")
      local txtCount = goU:Find("txtPartnerCount"):GetComponent("TMP_Text")
      self:SetPngSprite(imgQtyU, sBgPath)
      self:SetPngSprite(imgIconU, iconPartnerPath .. mapPartnerGroupCfg.Icon .. AllEnum.SoldierChessIconSurfix.M)
      NovaAPI.SetTMPText(txtName, mapPartnerGroupCfg.Name)
      local strLevel = ""
      for i = 1, #v.tbNumList do
        if 1 < i then
          strLevel = strLevel .. "/"
        end
        if i ~= v.nActiveLevel then
          strLevel = strLevel .. v.tbNumList[i]
        else
          strLevel = strLevel .. "<color=#3F4A5E>" .. v.tbNumList[i] .. "</color>"
        end
      end
      NovaAPI.SetTMPText(txtLvlU, strLevel)
      NovaAPI.SetTMPText(txtCount, v.nCurNum)
      self._tbPartnerInst.unfold[#self._tbPartnerInst.unfold + 1] = goU
      local btnU = imgQtyU.gameObject:GetComponent("UIButton")
      btnU.onClick:RemoveAllListeners()
      btnU.onClick:AddListener(clickCb)
      table.insert(self.tabPartnerBtn, btnU)
      local goF = instantiate(self._mapNode.goPartnerItemFold, self._mapNode.goPartnerFold)
      goF.gameObject:SetActive(true)
      local imgQty = goF:Find("imgPartner"):GetComponent("Image")
      local imgIconF = goF:Find("imgPartnerIcon"):GetComponent("Image")
      local txtLvlF = goF:Find("txtPartner"):GetComponent("TMP_Text")
      self:SetPngSprite(imgQty, sBgPath)
      self:SetPngSprite(imgIconF, iconPartnerPath .. mapPartnerGroupCfg.Icon .. AllEnum.SoldierChessIconSurfix.M)
      NovaAPI.SetTMPText(txtLvlF, tostring(v.nCurNum or 0))
      self._tbPartnerInst.fold[#self._tbPartnerInst.fold + 1] = goF
      local btnF = imgQty.gameObject:GetComponent("UIButton")
      btnF.onClick:RemoveAllListeners()
      btnF.onClick:AddListener(clickCb)
      table.insert(self.tabPartnerBtn, btnF)
      if index == #tbPartner then
        goU:Find("imgLine").gameObject:SetActive(false)
        goF:Find("imgLine").gameObject:SetActive(false)
      end
    end
  end
  self._bPartnerBuilt = true
end

function SoldierRoomInfoCtrl:_FillCharCommon(goItem, mapChess, mapCfg)
  local imgIcon = goItem:Find("imgChar"):GetComponent("Image")
  local img_icon = goItem:Find("iconMask/img_icon"):GetComponent("Image")
  local sIcon = AllEnum.SoldierChessRarityIcon[mapCfg.Rarity]
  sIcon = iconPath .. sIcon .. AllEnum.SoldierChessIconSurfix.S
  if imgIcon then
    self:SetPngSprite(imgIcon, sIcon)
  end
  local skinCfg = ConfigTable.GetData("SoldierSkin", mapCfg.Skin)
  if img_icon and skinCfg then
    self:SetPngSprite(img_icon, skinCfg.Icon .. AllEnum.SoldierChessIconSurfix.S)
  end
  for i = 1, 5 do
    local goStar = goItem:Find("goStarRoot/imgStar" .. i)
    if goStar then
      goStar.gameObject:SetActive(i <= mapChess.nStar)
    end
  end
end

function SoldierRoomInfoCtrl:BuildCharList(tbChess)
  if self._bCharBuilt then
    return
  end
  local index = 0
  local totalIndex = 0
  for _, v in ipairs(tbChess or {}) do
    if v.nId and 0 < v.nId then
      totalIndex = totalIndex + 1
    end
  end
  for _, v in ipairs(tbChess or {}) do
    if v.nId and 0 < v.nId then
      index = index + 1
      local mapCfg = ConfigTable.GetData("SoldierCharacter", v.nId)
      if mapCfg ~= nil then
        local goU = instantiate(self._mapNode.goCharDamageItem, self._mapNode.goCharUnfold)
        goU.gameObject:SetActive(true)
        self:_FillCharCommon(goU, v, mapCfg)
        local trDamage = goU:Find("txtDamage")
        local imgDamage = goU:Find("imgDamageBg/imgDamage"):GetComponent("RectTransform")
        local txtDamage = trDamage and trDamage:GetComponent("TMP_Text") or nil
        if txtDamage then
          NovaAPI.SetTMPText(txtDamage, "0")
        end
        local goF = instantiate(self._mapNode.goCharItemFold, self._mapNode.goCharFold)
        goF.gameObject:SetActive(true)
        self:_FillCharCommon(goF, v, mapCfg)
        self._tbCharInst[v.nId] = {
          goUnfold = goU,
          goFold = goF,
          txtDamage = txtDamage,
          imgDamage = imgDamage
        }
        if self.tbDamage[v.nId] == nil then
          self.tbDamage[v.nId] = {nDamage = 0}
        end
        if index == totalIndex then
          goU:Find("imgLine").gameObject:SetActive(false)
          goF:Find("imgLine").gameObject:SetActive(false)
        end
      end
    end
  end
  self._bCharBuilt = true
  self:_RefreshAllDamageUI()
end

function SoldierRoomInfoCtrl:_RefreshAllDamageUI()
  local tbSorted = {}
  local nMaxDamage = 0
  for nId, v in pairs(self.tbDamage) do
    local nDamage = v.nDamage or 0
    table.insert(tbSorted, {nId = nId, nDamage = nDamage})
    if nMaxDamage < nDamage then
      nMaxDamage = nDamage
    end
  end
  table.sort(tbSorted, function(a, b)
    if a.nDamage == b.nDamage then
      return a.nId < b.nId
    end
    return a.nDamage > b.nDamage
  end)
  for nOrder, mapEntry in ipairs(tbSorted) do
    local inst = self._tbCharInst[mapEntry.nId]
    if inst then
      local nPercent = 0 < nMaxDamage and mapEntry.nDamage / nMaxDamage or 0
      if inst.txtDamage then
        NovaAPI.SetTMPText(inst.txtDamage, self:ThousandsNumber(mapEntry.nDamage))
      end
      if inst.imgDamage then
        inst.imgDamage.sizeDelta = Vector2(nPercent * 178, 16)
      end
      if inst.goUnfold then
        inst.goUnfold:SetSiblingIndex(nOrder - 1)
      end
      if inst.goFold then
        inst.goFold:SetSiblingIndex(nOrder - 1)
      end
    end
  end
end

function SoldierRoomInfoCtrl:RefreshChessDamage(nId, nDamage)
  if self.tbDamage[nId] == nil then
    self.tbDamage[nId] = {nDamage = nDamage}
  else
    self.tbDamage[nId].nDamage = nDamage
  end
  if self._bCharBuilt then
    self:_RefreshAllDamageUI()
  end
end

function SoldierRoomInfoCtrl:OnEnable()
  self.levelData = PlayerData.SoldierData:GetCurLevelData()
  self.tbDamage = {}
  self.tbCacheSoldierEnergy = {}
  self._mapNode.BtnBg.gameObject:SetActive(false)
  self._mapNode.goPartnerItem.gameObject:SetActive(false)
  self._mapNode.goCharDamageItem.gameObject:SetActive(false)
  self._mapNode.goPartnerItemFold.gameObject:SetActive(false)
  self._mapNode.goCharItemFold.gameObject:SetActive(false)
  self._bUnfold = true
  self._nShowTab = TAB_CHARACTER
  self._tbPartnerInst = {
    unfold = {},
    fold = {}
  }
  self._tbCharInst = {}
  self._bPartnerBuilt = false
  self._bCharBuilt = false
  self:SetBossTemplateMsg()
end

function SoldierRoomInfoCtrl:OnDisable()
  self:CloseUI()
end

function SoldierRoomInfoCtrl:OnDestroy()
  if self.tabPartnerBtn then
    for i, v in pairs(self.tabPartnerBtn) do
      v.onClick:RemoveAllListeners()
    end
    self.tabPartnerBtn = nil
  end
end

function SoldierRoomInfoCtrl:OnBtn_Pause()
  if not self.isStartReady then
    return
  end
  EventManager.Hit("OpenSoldierPause", self.tbChess, self.tbCacheSoldierEnergy)
end

function SoldierRoomInfoCtrl:OnBtnClick_CoinTips()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierGoldTips)
end

function SoldierRoomInfoCtrl:OnBtnClick_Fold()
  self._bUnfold = false
  self:ApplyViewState()
end

function SoldierRoomInfoCtrl:OnBtnClick_Unfold()
  self._bUnfold = true
  self:ApplyViewState()
end

function SoldierRoomInfoCtrl:OnBtnClick_Partner()
  self._nShowTab = TAB_PARTNER
  self:ApplyViewState()
end

function SoldierRoomInfoCtrl:OnBtnClick_Character()
  self._nShowTab = TAB_CHARACTER
  self:ApplyViewState()
end

function SoldierRoomInfoCtrl:ChangeBtnBgState()
  local PartnerBg = self._mapNode.btnPartner.transform:Find("AnimRoot/imgBg").gameObject
  local BtnPartner2 = self._mapNode.btnPartner.transform:Find("AnimRoot/txtBtnPartner2").gameObject
  local BtnPartner3 = self._mapNode.btnPartner.transform:Find("AnimRoot/txtBtnPartner3").gameObject
  local CharacterBg = self._mapNode.btnCharacter.transform:Find("AnimRoot/imgBg").gameObject
  local BtnChar2 = self._mapNode.btnCharacter.transform:Find("AnimRoot/txtBtnChar2").gameObject
  local BtnChar3 = self._mapNode.btnCharacter.transform:Find("AnimRoot/txtBtnChar3").gameObject
  PartnerBg:SetActive(self._nShowTab == TAB_PARTNER)
  BtnPartner2:SetActive(self._nShowTab == TAB_PARTNER)
  BtnPartner3:SetActive(self._nShowTab ~= TAB_PARTNER)
  CharacterBg:SetActive(self._nShowTab ~= TAB_PARTNER)
  BtnChar2:SetActive(self._nShowTab ~= TAB_PARTNER)
  BtnChar3:SetActive(self._nShowTab == TAB_PARTNER)
end

function SoldierRoomInfoCtrl:OnBtnClick_Change()
  self._nShowTab = self._nShowTab == TAB_PARTNER and TAB_CHARACTER or TAB_PARTNER
  self:ApplyViewState()
end

function SoldierRoomInfoCtrl:OnEvent_OpenUI(nFloorId)
  self:OpenUI(nFloorId)
  self.isStartReady = false
end

function SoldierRoomInfoCtrl:OnEvent_InputEnable(bEnable)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvas_group, bEnable == true and 1 or 0)
  NovaAPI.SetCanvasGroupInteractable(self._mapNode.canvas_group, bEnable == true)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvas_group, bEnable == true)
end

function SoldierRoomInfoCtrl:OnEvent_LoadLevelRefresh()
  self._mapNode.BtnBg.gameObject:SetActive(true)
end

function SoldierRoomInfoCtrl:OnEvent_RefreshChessList(tbChess)
  self.tbChess = tbChess or {}
  self:RefreshChessList()
end

function SoldierRoomInfoCtrl:OnEvent_RefreshChessDamage(nId, nDamage)
  self:RefreshChessDamage(nId, nDamage)
end

function SoldierRoomInfoCtrl:OnEvent_RefreshTime(nTime)
  if not self.isDpsCheckStage then
    self._mapNode.rtChallengeTime.gameObject:SetActive(true)
    if self.nRemainTime < 0 then
      return
    end
    self:SetTime(nTime)
  else
    self:SetDpsCheckTime(nTime)
  end
end

function SoldierRoomInfoCtrl:OnEvent_RefreshProgress(nTotalHp, nHp)
  local nProgress = nHp / nTotalHp
  NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%.f %%", nProgress * 100))
  NovaAPI.SetImageFillAmount(self._mapNode.imgProgress, nProgress)
end

function SoldierRoomInfoCtrl:OnEvent_RefreshCoin(nCount)
  local nCurCount = self.levelData:GetItem(AllEnum.CoinItemId.SoldierCurrency) or 0
  NovaAPI.SetTMPText(self._mapNode.txtCoin, tostring(nCount + nCurCount))
end

function SoldierRoomInfoCtrl:OnEvent_ClearSoldier()
  for _, v in ipairs(self._mapNode.goMainChar) do
    v:CloseUI()
  end
  for _, v in ipairs(self._mapNode.goSubChar) do
    v:CloseUI()
  end
  for _, inst in pairs(self._tbCharInst) do
    if inst.txtDamage then
      NovaAPI.SetTMPText(inst.txtDamage, "0")
    end
    if inst.imgDamage then
      inst.imgDamage.sizeDelta = Vector2(0, 16)
    end
  end
  self.tbDamage = {}
end

function SoldierRoomInfoCtrl:CacheSoldierEnergyData(dataId, nEnergy, nMaxEnergy, nRecoverRate, nDeath)
  self.tbCacheSoldierEnergy[dataId] = {
    energy = nEnergy,
    maxEnergy = nMaxEnergy,
    recoverRate = nRecoverRate,
    death = nDeath
  }
end

function SoldierRoomInfoCtrl:OnClick_AutoBattleOpen()
end

function SoldierRoomInfoCtrl:OnClick_AutoBattleClose()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_AutoBattle_Tips"))
end

function SoldierRoomInfoCtrl:OnEvent_SettlementReady()
  self._mapNode.BtnBg.gameObject:SetActive(false)
  self._mapNode.btnPause.gameObject:SetActive(false)
end

function SoldierRoomInfoCtrl:OnEvent_IsStartReady(isReady)
  self.isStartReady = isReady
end

function SoldierRoomInfoCtrl:OnEvent_IsStartOk()
  if not PlayerData.Guide:CheckGuideFinishById(506) then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_506")
  end
end

function SoldierRoomInfoCtrl:OnBtnClick_ChangeSpeed()
  self:SetTimeScale(not self.bSpeedUp)
  self:UpdateSpeedIcon()
end

function SoldierRoomInfoCtrl:SetTimeScale(bSpeedUp)
  self.bSpeedUp = bSpeedUp
  LocalData.SetPlayerLocalData("Soldier_RoomInfo_SpeedUp", bSpeedUp)
  if self.bSpeedUp then
    CS.AdventureModuleHelper.TowerDefense_SetTimeScale(150)
  else
    CS.AdventureModuleHelper.TowerDefense_SetTimeScale(100)
  end
end

function SoldierRoomInfoCtrl:UpdateSpeedIcon()
  self._mapNode.go_X1:SetActive(not self.bSpeedUp)
  self._mapNode.go_X2:SetActive(self.bSpeedUp)
end

function SoldierRoomInfoCtrl:InitDpsCheckUIMsg()
  local curGradeChallengeId = PlayerData.SoldierData:GetCurGradeChallengeId()
  local config = ConfigTable.GetData("SoldierGradeChallenge", curGradeChallengeId)
  local addGroupId = config.CheckStageGroupId
  self.tabStageAddScore = {}
  self.objStageAddScore = {}
  
  local function foreach_Base(baseData)
    if baseData.Group == addGroupId then
      self.tabStageAddScore[baseData.Index] = baseData
    end
  end
  
  ForEachTableLine(DataTable.SoldierCheckStageAddScore, foreach_Base)
  self:SetDpsCheckTime(0)
  for i = 1, 3 do
    local obj = self._mapNode.TimeItem[i].gameObject
    local Imagebg = obj.transform:Find("Imagebg").gameObject
    local Imagecert = obj.transform:Find("Imagecert").gameObject
    local txtTime = Imagebg.transform:Find("txtTime"):GetComponent("TMP_Text")
    local txtcertTime = Imagecert.transform:Find("txtcertTime"):GetComponent("TMP_Text")
    local tmpMsg = self.tabStageAddScore[i]
    if tmpMsg ~= nil then
      local prevScore = self.tabStageAddScore[i - 1] and self.tabStageAddScore[i - 1].TankingAddScore or 0
      local addScore = tmpMsg.TankingAddScore - prevScore
      local nMin = math.floor(tmpMsg.Duration / 60)
      local nSec = math.fmod(tmpMsg.Duration, 60)
      NovaAPI.SetTMPText(txtTime, orderedFormat(ConfigTable.GetUIText("Solider_SurvivalTimeScore"), string.format("%02d:%02d", nMin, nSec), addScore))
      NovaAPI.SetTMPText(txtcertTime, orderedFormat(ConfigTable.GetUIText("Solider_SurvivalTimeScore"), string.format("%02d:%02d", nMin, nSec), addScore))
    end
    local tabObj = {}
    tabObj.Imagebg = Imagebg
    tabObj.Imagecert = Imagecert
    self.objStageAddScore[i] = tabObj
    Imagebg:SetActive(true)
    Imagecert:SetActive(false)
  end
  self:OnEvent_SetDPSMsg(0)
  for i = 1, 3 do
    local tmpMsg = self.tabStageAddScore[i]
    if tmpMsg ~= nil then
      local prevScore = self.tabStageAddScore[i - 1] and self.tabStageAddScore[i - 1].DPSAddScore or 0
      local addScore = tmpMsg.DPSAddScore - prevScore
      NovaAPI.SetTMPText(self._mapNode.txtHp[i], "+" .. addScore)
    end
  end
end

function SoldierRoomInfoCtrl:SetDpsCheckTime(nTime)
  local nMin = math.floor(nTime / 60)
  local nSec = math.fmod(nTime, 60)
  NovaAPI.SetTMPText(self._mapNode.txtSurvivalTime, orderedFormat(ConfigTable.GetUIText("Solider_SurvivalTime"), string.format("%02d:%02d", nMin, nSec)))
  for i = 1, 3 do
    if nTime >= self.tabStageAddScore[i].Duration then
      self.objStageAddScore[i].Imagebg:SetActive(false)
      self.objStageAddScore[i].Imagecert:SetActive(true)
    end
  end
end

function SoldierRoomInfoCtrl:OnEvent_SetDPSMsg(totalDPS)
  NovaAPI.SetTMPText(self._mapNode.txtProgressRating, orderedFormat(ConfigTable.GetUIText("Solider_TotalDamage"), totalDPS))
  local nScore = 0
  for i = 3, 1, -1 do
    local msg = self.tabStageAddScore[i]
    if msg ~= nil and totalDPS >= msg.DPS then
      nScore = msg.DPSAddScore
      break
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtNodeRating, orderedFormat(ConfigTable.GetUIText("Solider_TotalScore"), nScore))
  if self.tabStageAddScore[3] == nil or 0 >= self.tabStageAddScore[3].DPS then
    NovaAPI.SetImageFillAmount(self._mapNode.imgProgressRating, 0)
    return
  end
  if totalDPS <= self.tabStageAddScore[1].DPS then
    NovaAPI.SetImageFillAmount(self._mapNode.imgProgressRating, totalDPS / self.tabStageAddScore[1].DPS * 0.33)
  elseif totalDPS > self.tabStageAddScore[1].DPS and totalDPS <= self.tabStageAddScore[2].DPS then
    NovaAPI.SetImageFillAmount(self._mapNode.imgProgressRating, 0.33 + (totalDPS - self.tabStageAddScore[1].DPS) / (self.tabStageAddScore[2].DPS - self.tabStageAddScore[1].DPS) * 0.33)
  elseif totalDPS > self.tabStageAddScore[2].DPS and totalDPS <= self.tabStageAddScore[3].DPS then
    NovaAPI.SetImageFillAmount(self._mapNode.imgProgressRating, 0.66 + (totalDPS - self.tabStageAddScore[2].DPS) / (self.tabStageAddScore[3].DPS - self.tabStageAddScore[2].DPS) * 0.33)
  else
    NovaAPI.SetImageFillAmount(self._mapNode.imgProgressRating, 1)
  end
end

function SoldierRoomInfoCtrl:SetBossTemplateMsg()
  if self.levelData then
    local tId = self.levelData:GetBossTemplateId()
    local mapCfg = ConfigTable.GetData("SoldierBossTemplate", tId)
    if mapCfg then
      if mapCfg == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_3 or mapCfg == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_4 then
        self:SetPngSprite(self._mapNode.imgSkill, mapCfg.SoldierRoleSkillIcon)
        local nSkillType = mapCfg.SoldierRoleSkillType
        self._mapNode.imgSkillPassive.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_1 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_3)
        self._mapNode.imgSkillInitiative.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_2 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_4)
        NovaAPI.SetTMPText(self._mapNode.txtSkillName, mapCfg.Name)
        self._mapNode.SkillItem:SetActive(true)
      else
        self._mapNode.SkillItem:SetActive(false)
      end
    else
      self._mapNode.SkillItem:SetActive(false)
    end
  else
    self._mapNode.SkillItem:SetActive(false)
  end
end

function SoldierRoomInfoCtrl:OnBtnClick_SkillDetail()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBossTemplateTips, self.levelData:GetBossTemplateId())
end

return SoldierRoomInfoCtrl
