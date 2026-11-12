local SoldierPauseCtrl = class("SoldierPauseCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
SoldierPauseCtrl._mapNodeConfig = {
  goBlur = {
    sNodeName = "t_fullscreen_blur_01"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_01",
    sComponentName = "Animator"
  },
  safeAreaRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Battle_Pause"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  snapshot = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnRestart = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Restart"
  },
  txtBtnRestart = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Btn_Restart"
  },
  btnResult = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Result"
  },
  txtBtnResult = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Btn_Result"
  },
  btnLeave = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Leave"
  },
  txtBtnLeave = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Btn_Leave"
  },
  goNodeInfo = {},
  Node = {nCount = 8},
  txtProgress = {sComponentName = "TMP_Text"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtExp = {sComponentName = "TMP_Text"},
  txtHp = {sComponentName = "TMP_Text"},
  txtCoin = {sComponentName = "TMP_Text"},
  btnCoin = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CoinTips"
  },
  BarContainer = {
    sComponentName = "RectTransform"
  },
  goChar = {},
  goCharItem = {},
  goCharList = {nCount = 2, sComponentName = "Transform"},
  txtCharTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Battle_Char_Title"
  },
  txtPartnerTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Battle_Partner_Title"
  },
  goPartnerList = {sComponentName = "Transform"},
  goPartnerList = {sComponentName = "Transform"},
  goPartnerItem = {sComponentName = "Transform"},
  txtCardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Battle_Card_Title"
  },
  btnStarterCard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_StarterCard"
  },
  imgCardStarter = {sComponentName = "Image"},
  imgCardIconStarter = {sComponentName = "Image"},
  imgemptyStarter = {},
  goStrategyCardList = {sComponentName = "Transform"},
  btnStrategyCardItem = {sComponentName = "Transform"},
  btnSetting = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Setting"
  },
  charDetialRoot = {sComponentName = "Transform"},
  parnterDetialRoot = {sComponentName = "Transform"},
  goSkill = {},
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
SoldierPauseCtrl._mapEventConfig = {
  OpenSoldierPause = "OnEvent_OpenSoldierPause",
  RefreshSoldierCoin = "OnEvent_RefreshCoin"
}
SoldierPauseCtrl._mapRedDotConfig = {}
local iconPath = "Icon/SoldierOtherIcon/"
local iconCardPath = "Icon/SoldierBuffCard/"
local iconPartnerPath = "Icon/SoldierPartner/"

function SoldierPauseCtrl:OpenUI()
  self._mapNode.goBlur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self.bShow then
      self._mapNode.safeAreaRoot:SetActive(true)
    end
  end
  
  cs_coroutine.start(wait)
end

function SoldierPauseCtrl:Refresh()
  local nStage, nNodexIndex = PlayerData.SoldierData:GetCurChallengeState()
  NovaAPI.SetTMPText(self._mapNode.txtProgress, orderedFormat(ConfigTable.GetUIText("Soldier_Pause_Schedule"), nStage .. "-" .. nNodexIndex))
  local nLevel, nMaxLevel = self.levelData:GetShopLevel()
  NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("Soldier_Battle_LevelPause"), nLevel))
  local mapLevelCfg = ConfigTable.GetData("SoldierShopLevel", nLevel)
  local nNeedExp = 0
  if mapLevelCfg ~= nil then
    nNeedExp = mapLevelCfg.Exp
  end
  local nExp = self.levelData:GetExp()
  NovaAPI.SetTMPText(self._mapNode.txtExp, string.format("%s/%s", nExp, nNeedExp))
  local nHp = self.levelData:GetHp()
  NovaAPI.SetTMPText(self._mapNode.txtHp, nHp)
  local nCount = self.levelData:GetItem(AllEnum.CoinItemId.SoldierCurrency)
  NovaAPI.SetTMPText(self._mapNode.txtCoin, tostring(nCount))
  if self.isRefreshMSg then
    return
  end
  self:RefreshShopLv()
  self:InitNodeList()
  self:RefreshCharList()
  self:RefreshCardList()
  self.isRefreshMSg = true
end

function SoldierPauseCtrl:RefreshShopLv()
  local nCurLevel, nMaxLevel = self.levelData:GetShopLevel()
  NovaAPI.SetTMPText(self._mapNode.txtLevel, orderedFormat(ConfigTable.GetUIText("Soldier_Battle_LevelPause"), nCurLevel))
  if nCurLevel == nMaxLevel then
    self._mapNode.BarContainer.sizeDelta = Vector2(134, 22)
    NovaAPI.SetTMPText(self._mapNode.txtExp, ConfigTable.GetUIText("Soldier_Sandtable_MaxLevel"))
  else
    local ShopMsg = ConfigTable.GetData("SoldierShopLevel", nCurLevel)
    if ShopMsg then
      local nNeedExp = ShopMsg.Exp
      local nCurExp = self.levelData:GetExp()
      self._mapNode.BarContainer.sizeDelta = Vector2(134 * (nCurExp / nNeedExp), 22)
      NovaAPI.SetTMPText(self._mapNode.txtExp, tostring(nCurExp) .. "/" .. tostring(nNeedExp))
    else
      printError("商店表找不到，商店当前等级为 === " .. nCurLevel)
    end
  end
end

function SoldierPauseCtrl:InitNodeList()
  local nStage, nNodexIndex = PlayerData.SoldierData:GetCurChallengeState()
  NovaAPI.SetTMPText(self._mapNode.TextPos, tostring(nStage) .. "-" .. tostring(nNodexIndex))
  local tbAllNodeList = self.levelData:GetNodeList()
  local curStageNodeList = {}
  for _, v in ipairs(tbAllNodeList) do
    if v.nNodeType ~= GameEnum.soldierNodeType.CheckStage then
      table.insert(curStageNodeList, v)
    end
  end
  for i = 1, #self._mapNode.Node do
    local node = self._mapNode.Node[i]
    if i > #curStageNodeList then
      node.gameObject:SetActive(false)
    else
      local imgIcon = node.transform:Find("imgIcon"):GetComponent("Image")
      self:SetPngSprite(imgIcon, iconPath .. AllEnum.SoliderNoteTypeCfg[curStageNodeList[i].nNodeType].Icon)
      local imgCurrent = node.transform:Find("imgCurrent")
      imgCurrent.gameObject:SetActive(i == nNodexIndex)
      if nNodexIndex > i then
        NovaAPI.SetImageColor(imgIcon, Color(0.7098039215686275, 0.7647058823529411, 0.8156862745098039, 0.3))
      elseif nNodexIndex < i then
        NovaAPI.SetImageColor(imgIcon, Color(0.7098039215686275, 0.7647058823529411, 0.8156862745098039, 1))
      elseif i == nNodexIndex then
        NovaAPI.SetImageColor(imgIcon, Color(1.0, 1.0, 1.0, 1))
      end
      node.gameObject:SetActive(true)
    end
  end
end

function SoldierPauseCtrl:RefreshCharList()
  self._mapNode.goCharItem:SetActive(false)
  local tabMain = {}
  local tabSub = {}
  for k, v in ipairs(self.tChess) do
    local nIndex = v.nIndex
    if v.nPositionType == GameEnum.SoldierPositionType.FightPosition then
      tabMain[nIndex] = v
    elseif v.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
      tabSub[nIndex] = v
    end
  end
  local tbActivePartner, tbPartner = SoldierAttrData.CalcActivePartners(self.tChess)
  for i, v in pairs(tabMain) do
    local goChar = instantiate(self._mapNode.goCharItem, self._mapNode.goCharList[1])
    goChar:SetActive(true)
    if not self.tbMainCtrl[v.nIndex] then
      self.tbMainCtrl[v.nIndex] = self:BindCtrlByNode(goChar, "Game.UI.Soldier.Template.Character.SoldierCharCardItemCtrl")
      if v.nId > 0 then
        self.tbMainCtrl[v.nIndex]:SetItemData(v.nId, GameEnum.SoldierPositionType.FightPosition)
        self.tbMainCtrl[v.nIndex]:SetStar(v.nStar)
        self.tbMainCtrl[v.nIndex]:SetAttribute(v.nIndex)
        self.tbMainCtrl[v.nIndex]:SetClickCallback(_, function()
          local chessData = {
            nPositionType = GameEnum.SoldierPositionType.FightPosition,
            nId = v.nId,
            nStar = math.max(v.nStar, 1)
          }
          self:ClickCharactorTips(v.nUId, v.nId, goChar, chessData, self.tChess, tbActivePartner)
        end)
      else
        self.tbMainCtrl[v.nIndex]:SetItemData(nil)
      end
    end
  end
  for i, v in pairs(tabSub) do
    local goChar = instantiate(self._mapNode.goCharItem, self._mapNode.goCharList[2])
    goChar:SetActive(true)
    if not self.tbSubCtrl[v.nIndex] then
      self.tbSubCtrl[v.nIndex] = self:BindCtrlByNode(goChar, "Game.UI.Soldier.Template.Character.SoldierCharCardItemCtrl")
      if 0 < v.nId then
        self.tbSubCtrl[v.nIndex]:SetItemData(v.nId, GameEnum.SoldierPositionType.SupportPosition)
        self.tbSubCtrl[v.nIndex]:SetStar(v.nStar)
        self.tbSubCtrl[v.nIndex]:SetAttribute(0)
        self.tbSubCtrl[v.nIndex]:SetClickCallback(_, function()
          local chessData = {
            nPositionType = GameEnum.SoldierPositionType.SupportPosition,
            nId = v.nId,
            nStar = math.max(v.nStar, 1)
          }
          self:ClickCharactorTips(v.nUId, v.nId, goChar, chessData, self.tChess, tbActivePartner)
        end)
      else
        self.tbSubCtrl[v.nIndex]:SetItemData(nil)
      end
    end
  end
  if tbPartner == nil then
    return
  end
  self._mapNode.goPartnerItem.gameObject:SetActive(false)
  self:RefreshPartnerList(tbPartner)
end

function SoldierPauseCtrl:ClickCharactorTips(nUId, nId, obj, chessData, tbChess, tbActivePartner)
  local tmpEnergy = self.tabCacheSoldierEnergy[nUId]
  if tmpEnergy.death == true then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Death_Tips"))
    return
  end
  local Info = CS.AdventureModuleHelper.GetSoldierActorInfo(nId)
  local HealthInfo = CS.AdventureModuleHelper.GetSoldierHealthInfo(nId)
  local atk = Info ~= nil and Info.atk:AsFloat() or 0
  local def = Info ~= nil and Info.def:AsFloat() or 0
  local critRate = Info ~= nil and Info.critRate:AsFloat() or 0
  local critPower = Info ~= nil and Info.critPower:AsFloat() or 0
  local attackSpeed = Info ~= nil and Info.normalAttackSpd:AsFloat() or 0
  local hp = HealthInfo ~= nil and HealthInfo.hp or 0
  local hpMax = HealthInfo ~= nil and HealthInfo.hpMax or 0
  local tab = {}
  tab.atk = atk
  tab.def = def
  tab.critRate = critRate
  tab.critPower = critPower
  tab.attackSpeed = attackSpeed
  tab.hp = hp
  tab.hpMax = hpMax
  tab.nEnergy = tmpEnergy ~= nil and tmpEnergy.energy or 0
  tab.nMaxEnergy = tmpEnergy ~= nil and tmpEnergy.maxEnergy or 0
  tab.nRecoverRate = tmpEnergy ~= nil and tmpEnergy.recoverRate or 0
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, self._mapNode.charDetialRoot, chessData, tbChess, tbActivePartner, tab)
  EventManager.Hit("OnSetTipsPosition", self._mapNode.charDetialRoot:GetChild(0).position, self._mapNode.charDetialRoot:GetChild(1).position, self._mapNode.charDetialRoot:GetChild(2).position)
  EventManager.Hit("SoldierCharTips_ShowBg")
end

function SoldierPauseCtrl:RefreshPartnerList(tbPartner)
  self.tabPartnerBtn = {}
  for _, v in ipairs(tbPartner) do
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
      local goU = instantiate(self._mapNode.goPartnerItem, self._mapNode.goPartnerList)
      goU.gameObject:SetActive(true)
      local imgPartner = goU:Find("imgPartner"):GetComponent("Image")
      local imgPartnerIcon = goU:Find("imgPartnerIcon"):GetComponent("Image")
      local txtPartnerCount = goU:Find("txtPartnerCount"):GetComponent("TMP_Text")
      if v.nActiveLevel == 0 then
        self:SetPngSprite(imgPartner, iconPath .. AllEnum.SoldierPartnerLevelIcon[GameEnum.PartnerLevelQuality.None].bg)
      else
        self:SetPngSprite(imgPartner, iconPath .. AllEnum.SoldierPartnerLevelIcon[partnerCfg.PartnerLevelQuality].bg)
      end
      self:SetPngSprite(imgPartnerIcon, iconPartnerPath .. mapPartnerGroupCfg.Icon .. AllEnum.SoldierChessIconSurfix.M)
      NovaAPI.SetTMPText(txtPartnerCount, tostring(v.nCurNum or 0))
      
      local function clickCb()
        local bTrace = PlayerData.SoldierData:GetCurLevelData():CheckPartnerTrace(v.nType)
        EventManager.Hit(EventId.OpenPanel, PanelId.SoldierPartnerTips, self._mapNode.parnterDetialRoot, v.nType, v.nActiveLevel, bTrace)
        EventManager.Hit("OnSetParnterTipsPosition", self._mapNode.parnterDetialRoot:GetChild(0).position, self._mapNode.parnterDetialRoot:GetChild(1).position, self._mapNode.parnterDetialRoot:GetChild(2).position)
        EventManager.Hit("SoldierCharTips_ShowBg")
      end
      
      local btn = imgPartner.gameObject:GetComponent("UIButton")
      btn.onClick:RemoveAllListeners()
      btn.onClick:AddListener(clickCb)
      table.insert(self.tabPartnerBtn, btn)
    end
  end
end

function SoldierPauseCtrl:RefreshCardList()
  local strategyCard = self.levelData:GetCardData()
  if self._mapNode.imgCardStarter ~= nil then
    self._mapNode.imgCardStarter.gameObject:SetActive(false)
  end
  if self._mapNode.imgCardIconStarter ~= nil then
    self._mapNode.imgCardIconStarter.gameObject:SetActive(false)
  end
  if self._mapNode.imgemptyStarter ~= nil then
    self._mapNode.imgemptyStarter.gameObject:SetActive(false)
  end
  self._mapNode.btnStrategyCardItem.gameObject:SetActive(false)
  self.tabStrategyCard = {}
  if strategyCard ~= nil then
    for k, v in ipairs(strategyCard) do
      local goStrategy = instantiate(self._mapNode.btnStrategyCardItem, self._mapNode.goStrategyCardList)
      goStrategy.gameObject:SetActive(true)
      
      local function clickCb()
        self:OnBtnClick_StrategyCard(v.nId)
      end
      
      local cardBg = goStrategy:Find("AnimRoot/imgCardStrategy"):GetComponent("Image")
      local cardIcon = goStrategy:Find("AnimRoot/imgCardIconStrategy"):GetComponent("Image")
      local btn = goStrategy:GetComponent("UIButton")
      btn.onClick:RemoveAllListeners()
      btn.onClick:AddListener(clickCb)
      table.insert(self.tabStrategyCard, btn)
      local SoldierStrategyCardCfg = ConfigTable.GetData("SoldierStrategyCard", v.nId)
      local cardBgPath = iconPath .. AllEnum.SoldierStrategyCardRarityIcon[SoldierStrategyCardCfg.Rarity] .. AllEnum.SoldierChessIconSurfix.S
      self:SetPngSprite(cardBg, cardBgPath)
      local cardIconPath = iconCardPath .. SoldierStrategyCardCfg.Icon
      self:SetPngSprite(cardIcon, cardIconPath)
    end
  end
end

function SoldierPauseCtrl:CloseUI(callback)
  if self._mapNode == nil then
    return
  end
  self:AddTimer(1, 0.2, "ClosePanel", true, true, true, callback)
end

function SoldierPauseCtrl:ClosePanel(_, callback)
  if self._mapNode == nil or not self.bShow then
    return
  end
  self:OnPanelClose(callback)
end

function SoldierPauseCtrl:OnPanelClose(callback)
  self.bShow = false
  PanelManager.InputEnable()
  EventManager.Hit(EventId.BattleDashboardVisible, true)
  self._mapNode.safeAreaRoot:SetActive(false)
  self._mapNode.goBlur:SetActive(false)
  if callback then
    callback()
  end
end

function SoldierPauseCtrl:Awake()
  self.nAllChallengeTime = ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max")
  self.nTotalTime = self._panel.nTotalTime
  self._mapNode.safeAreaRoot:SetActive(false)
  self.tbGamepadUINode = self:GetGamepadUINode()
  self.tbMainCtrl = {}
  self.tbSubCtrl = {}
end

function SoldierPauseCtrl:OnEnable()
  self.nOpenTime = 0
  self.nRemainTime = 0
  if self._panel.nType ~= nil then
    if self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_1 then
      self.nOpenTime = PlayerData.JointDrill_1:GetJointDrillStartTime()
    elseif self._panel.nType == GameEnum.JointDrillMode.JointDrill_Mode_2 then
      self.nOpenTime = PlayerData.JointDrill_2:GetJointDrillStartTime()
    end
  end
end

function SoldierPauseCtrl:OnDisable()
end

function SoldierPauseCtrl:OnDestroy()
  for nInstanceId, objCtrl in pairs(self.tbMainCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbMainCtrl[nInstanceId] = nil
  end
  self.tbMainCtrl = {}
  for nInstanceId, objCtrl in pairs(self.tbSubCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbSubCtrl[nInstanceId] = nil
  end
  self.tbSubCtrl = {}
  if self.tabPartnerBtn then
    for i, v in pairs(self.tabPartnerBtn) do
      v.onClick:RemoveAllListeners()
    end
    self.tabPartnerBtn = nil
  end
  if self.tabStrategyCard then
    for i, v in pairs(self.tabStrategyCard) do
      v.onClick:RemoveAllListeners()
    end
    self.tabStrategyCard = nil
  end
end

function SoldierPauseCtrl:OnBtnClick_Result()
  local function confirmCallback()
    local function callback()
      EventManager.Hit("SettleSoldierBattle")
      
      self:CloseUI(function()
        local function levelEndCallback()
          EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
          
          NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
        end
        
        EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
        EventManager.Hit(EventId.ClosePanel, PanelId.SoldierBattlePanel)
      end)
    end
    
    PlayerData.SoldierData:SendGiveUp(callback)
  end
  
  local nStage, nNodexIndex = PlayerData.SoldierData:GetCurChallengeState()
  local str = orderedFormat(ConfigTable.GetUIText("Soldier_Battle_GiveUp"), nStage .. "-" .. nNodexIndex)
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = str,
    callbackConfirm = confirmCallback,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function SoldierPauseCtrl:OnBtnClick_Close()
  self:CloseUI()
end

function SoldierPauseCtrl:OnBtnClick_Restart()
  self:CloseUI()
  EventManager.Hit("RestartSoldier")
end

function SoldierPauseCtrl:OnBtnClick_Leave()
  local tabM, tabS, tabO = self.levelData:GetDeploy()
  local tbMain = {}
  local tbSup = {}
  for i, v in pairs(tabM) do
    if v.nPositionType == GameEnum.SoldierPositionType.FightPosition then
      table.insert(tbMain, v)
    elseif v.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
      table.insert(tbSup, v)
    end
  end
  
  local function callback()
    self:CloseUI(function()
      local function levelEndCallback()
        EventManager.Remove("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
        
        NovaAPI.EnterModule("MainMenuModuleScene", true, 17)
        EventManager.Hit(EventId.ClosePanel, PanelId.SoldierBattlePanel)
      end
      
      EventManager.Add("ADVENTURE_LEVEL_UNLOAD_COMPLETE", self, levelEndCallback)
      CS.AdventureModuleHelper.LevelStateChanged(true, 0, true)
    end)
  end
  
  PlayerData.SoldierData:SendStepOut(callback)
end

function SoldierPauseCtrl:OnBtnClick_StarterCard()
  if self.nStarterCardId and self.nStarterCardId > 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierSelectStarterCardItem, self.nStarterCardId)
  end
end

function SoldierPauseCtrl:OnBtnClick_StrategyCard(StrategyCardId)
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCardTips, StrategyCardId)
end

function SoldierPauseCtrl:OnBtnClick_CoinTips()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierGoldTips)
end

function SoldierPauseCtrl:OnBtnClick_Setting()
  EventManager.Hit(EventId.OpenPanel, PanelId.BattleSettings)
end

function SoldierPauseCtrl:OnEvent_OpenSoldierPause(tabChess, tabCacheSoldierEnergy)
  self.tChess = tabChess
  self.tabCacheSoldierEnergy = tabCacheSoldierEnergy
  self.bShow = true
  self.levelData = PlayerData.SoldierData:GetCurLevelData()
  PanelManager.InputDisable()
  self:OpenUI()
  self:Refresh()
  self:SetBossTemplateMsg()
end

function SoldierPauseCtrl:OnEvent_RefreshCoin(nCount)
  NovaAPI.SetTMPText(self._mapNode.txtCoin, nCount)
end

function SoldierPauseCtrl:SetBossTemplateMsg()
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
        self._mapNode.goSkill:SetActive(true)
      else
        self._mapNode.goSkill:SetActive(false)
      end
    else
      self._mapNode.goSkill:SetActive(false)
    end
  else
    self._mapNode.goSkill:SetActive(false)
  end
end

function SoldierPauseCtrl:OnBtnClick_SkillDetail()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBossTemplateTips, self.levelData:GetBossTemplateId())
end

return SoldierPauseCtrl
