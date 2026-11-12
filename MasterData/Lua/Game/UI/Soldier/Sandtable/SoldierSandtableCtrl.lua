local SoldierSandtableCtrl = class("SoldierSandtableCtrl", BaseCtrl)
local SoldierAttrData = require("GameCore.Data.DataClass.Soldier.SoldierAttrData")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
local AssetRoot = "Icon/SoldierOtherIcon/"
local chessAnimType = {
  PUTIN = 1,
  DRAGIN = 2,
  COMPOUND = 3,
  COMPOUND_OUT = 4,
  WARRIOR = 5
}
local chessAnimLength = {
  [chessAnimType.PUTIN] = 0.7,
  [chessAnimType.DRAGIN] = 0.7,
  [chessAnimType.COMPOUND] = 1,
  [chessAnimType.COMPOUND_OUT] = 0.4
}
local animQueueType = {
  NodeReward = 1,
  EnterSandtable = 2,
  OpenShop = 3
}
local fxType = {
  Gray = 1,
  Green = 2,
  Blue = 3,
  Purple = 4,
  Gold = 5,
  Coin = 99
}
local nMaxBarWidth = 153.2128
local DragInsType = {
  None = 0,
  Chess = 1,
  Sell = 2
}
local chessCountColor = {
  Normal = {
    sColor = "354154",
    mapColor = Color(0.20784313725490197, 0.2549019607843137, 0.32941176470588235, 1)
  },
  Max = {
    sColor = "565a67",
    mapColor = Color(0.33725490196078434, 0.35294117647058826, 0.403921568627451, 1)
  },
  Overflow = {
    sColor = "e65a72",
    mapColor = Color(0.9019607843137255, 0.35294117647058826, 0.4470588235294118, 1)
  },
  LevelUp = {
    sColor = "fff7d6",
    mapColor = Color(1.0, 0.9686274509803922, 0.8392156862745098, 1)
  }
}
SoldierSandtableCtrl._mapNodeConfig = {
  goRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  btnPause = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnDetails = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Details"
  },
  PartnerList = {
    sCtrlName = "Game.UI.Soldier.Sandtable.SoldierPartnerListCtrl"
  },
  btnHandbook = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Handbook"
  },
  btnPolicy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Policy"
  },
  BuffContainer = {
    sCtrlName = "Game.UI.Soldier.Sandtable.Components.SoldierBuffCtrl"
  },
  SaleContainer = {},
  SellAnimation = {
    sNodeName = "SaleContainer",
    sComponentName = "Animator"
  },
  btn_Sell = {nCount = 2, sComponentName = "UIButton"},
  txt_cell = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Sandtable_ShopCell"
  },
  txtSellPrice = {nCount = 2, sComponentName = "TMP_Text"},
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GO"
  },
  Enable = {},
  Disable = {},
  txt_go = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Sandtable_Go"
  },
  btnExperience = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Experience"
  },
  TextLvTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Sandtable_TextLvTitle"
  },
  TextLv = {nCount = 2, sComponentName = "TMP_Text"},
  imgBuyExpCostIcon = {},
  TextCostNum = {sComponentName = "TMP_Text"},
  TextExpNum = {nCount = 2, sComponentName = "TMP_Text"},
  imgBossTemplateIcon = {nCount = 2, sComponentName = "Image"},
  BarContainer = {sComponentName = "Image"},
  txtExpTitle = {sComponentName = "TMP_Text"},
  TextMaxLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Sandtable_MaxLevel"
  },
  btnMax = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Experience"
  },
  btnShop = {
    sComponentName = "NaviButton",
    sAction = "SoldierOpenShop",
    callback = "OnBtnClick_Shop"
  },
  btnCloseShop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseShop"
  },
  txt_shop = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Sandtable_Shop"
  },
  fx_shop = {sComponentName = "Animator"},
  TextCurCoin = {sComponentName = "TMP_Text"},
  ImgIconFight = {},
  ImgIconFight_lose = {},
  TextFightCount = {sComponentName = "TMP_Text"},
  btn_coinTips = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CoinTips"
  },
  TextReputation = {sComponentName = "TMP_Text"},
  TextPos = {sComponentName = "TMP_Text"},
  NodeLayout = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NodeLayout"
  },
  Node = {nCount = 8},
  ImageAddCharCount = {sComponentName = "Image"},
  TextAddCharCount = {sComponentName = "TMP_Text"},
  TextAddCharCountShow = {sComponentName = "TMP_Text"},
  TextChess = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_Vanguard"
  },
  TextChess2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook_Support"
  },
  SoldierPosEffectTips = {
    sCtrlName = "Game.UI.Soldier.Sandtable.Components.SoldierEffectDesCtrl"
  },
  MiddleContainer = {sComponentName = "Animator"},
  EntranceItemTemplate = {
    nCount = 3,
    sCtrlName = "Game.UI.Soldier.Sandtable.SoldierSandtableCharItemCtrl"
  },
  UpportingItemTemplate = {
    nCount = 6,
    sCtrlName = "Game.UI.Soldier.Sandtable.SoldierSandtableCharItemCtrl"
  },
  WaitingCardItemTemplate = {
    nCount = 9,
    sCtrlName = "Game.UI.Soldier.Sandtable.SoldierSandtableCharItemCtrl"
  },
  OtherChar = {
    nCount = 10,
    sCtrlName = "Game.UI.Soldier.Sandtable.SoldierSandtableOtherCharItemCtrl"
  },
  OtherCharLsit = {sComponentName = "Transform"},
  SoldierNodeTips = {
    sCtrlName = "Game.UI.Soldier.Sandtable.Components.SoldierNodeTipsCtrl"
  },
  SoldierShopComponent = {
    sCtrlName = "Game.UI.Soldier.Sandtable.Components.SoldierShopCtrl"
  },
  go_overflow = {},
  go_overflow_anim = {
    sNodeName = "go_overflow",
    sComponentName = "Animator"
  },
  sandtable_anim = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  btn_GoBackEvent = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoBackEventPanel"
  },
  txtBtnBack = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Sandtable_GoBackEvent"
  },
  charDetaiRoot = {sComponentName = "Transform"},
  parnterDetailRoot = {sComponentName = "Transform"},
  fxFlyRoot = {
    sCtrlName = "Game.UI.Soldier.Sandtable.SoldierSandtableFxCtrl"
  },
  goNodeDeployment = {},
  goNodeSupply = {},
  goNodeReward = {},
  TextReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Sandtable_Reward"
  },
  reward = {
    nCount = 7,
    sCtrlName = "Game.UI.Soldier.Template.Character.SoldierCharItemCtrl"
  },
  rewardItem = {
    sCtrlName = "Game.UI.Soldier.Template.SoldierItemGridCtrl"
  },
  goNodeMatch = {sComponentName = "Canvas"},
  fxFlyRootCanvas = {sNodeName = "fxFlyRoot", sComponentName = "Canvas"},
  blockInput = {},
  btnSkillDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SkillDetail"
  },
  txtSkillDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BossTemplate_Title"
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
  }
}
SoldierSandtableCtrl._mapEventConfig = {
  SoldierShopLevelChange = "OnEvent_SoldierExpUpdate",
  SoldierItemChange = "OnEvent_SoldierItemChange",
  SoldierCharItemChange = "OnEvent_SoldierCharItemChange",
  SoldierNodeChange = "OnEvent_SoldierNodeChange",
  SoldierHpChange = "OnEvent_SoldierHpChange",
  SoldierEffectChange = "OnEvent_SoldierEffectChange",
  SoldierPartnerUpdate = "OnEvent_SoldierEffectChange",
  SoldierBuffCardChange = "OnEvent_SoldierBuffCardChange",
  SoldierShopClose = "OnEvent_SoldierShopClose",
  SoldierSandtableCharItemDragStart = "OnEvent_SoldierSandtableCharItemDragStart",
  SoldierSandtableCharItemDragEnd = "OnEvent_SoldierSandtableCharItemDragEnd",
  SoldierSandtableCharItemDragging = "OnEvent_SoldierSandtableCharItemDragging",
  SoldierSandtableOtherCharItemDragStart = "OnEvent_SoldierSandtableOtherCharItemDragStart",
  SoldierSandtableOtherCharItemDragEnd = "OnEvent_SoldierSandtableOtherCharItemDragEnd",
  EnterCardSelect = "OnEvent_EnterCardSelect",
  EnterEventSelect = "OnEvent_EnterEventSelect",
  EnterStandTable = "OnEvent_EnterStandTable",
  SoldierSandtableSceneReady = "OnEvent_SoldierSandtableSceneReady",
  ShowSoldierPositionEffect = "OnEvent_ShowSoldierPositionEffect",
  SoldierSandtableRefreshStep = "OnEvent_SoldierSandtableRefreshStep",
  RefreshPurchaseExpPrice = "OnEvent_PurchaseExpPrice",
  SoldierGMRefresh = "OnEvent_SoldierGMRefresh",
  Guide_CloseSoldierShop = "OnBtnClick_CloseShop",
  [EventId.ClosePanel] = "OnEvent_CloseDic"
}
SoldierSandtableCtrl._mapRedDotConfig = {}

function SoldierSandtableCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.bIsFirst = param[1]
  end
  self:CreateChessList()
  self._panel.bFirstRefreshed = true
end

function SoldierSandtableCtrl:CreateChessList()
  self.levelData = PlayerData.SoldierData:GetCurLevelData()
  if self.levelData == nil then
    return
  end
  if self.bIsFirst == false then
    if not self._panel.bFirstRefreshed then
      local tbDeploy, tbWaiting, tbOther = self.levelData:GetDeploy()
      for _, v in ipairs(tbDeploy) do
        local copy = {
          nId = v.nId,
          nStar = v.nStar,
          nUid = v.nUid,
          nPositionType = v.nPositionType,
          nIndex = v.nIndex
        }
        if v.nPositionType == GameEnum.SoldierPositionType.FightPosition then
          table.insert(self._panel.MainChessList, copy)
        else
          table.insert(self._panel.SupportChessList, copy)
        end
      end
      for _, v in ipairs(tbWaiting) do
        local copy = {
          nId = v.nId,
          nStar = v.nStar,
          nUid = v.nUid,
          nIndex = v.nIndex,
          nPositionType = AllEnum.SoldierPositionType.Waiting
        }
        table.insert(self._panel.WaitingChessList, copy)
      end
      for _, v in ipairs(tbOther) do
        for i = 1, v.nCount do
          table.insert(self._panel.OtherChessList, {
            nId = v.nId,
            nStar = v.nStar
          })
        end
      end
      table.sort(self._panel.MainChessList, function(a, b)
        return a.nIndex < b.nIndex
      end)
      table.sort(self._panel.SupportChessList, function(a, b)
        return a.nIndex < b.nIndex
      end)
      table.sort(self._panel.WaitingChessList, function(a, b)
        return a.nIndex < b.nIndex
      end)
      table.sort(self._panel.OtherChessList, function(a, b)
        return a.nId < b.nId
      end)
    end
  elseif not self._panel.bFirstRefreshed then
    self._panel:InitChessList()
  end
  self:InitOtherChessList()
  self:OnEvent_SoldierSandtableFirstInChessListRefresh()
end

function SoldierSandtableCtrl:InitCacheData()
  self.sellTimer = nil
  self.overflowTimer = nil
  self.nCacheChessMaxCount = 0
  self.nCacheShopLevel = 0
  self.nCacheExp = 0
  self.AnimQueue = {}
end

function SoldierSandtableCtrl:OnEnable()
  self._panel:AddGamepadUINode(self:GetGamepadUINode())
  self.animRoot = self.gameObject:GetComponent("Animator")
  self:ShowSandtable(false)
  self.goSceneTimeline1 = nil
  self.goSceneTimeline2 = nil
  self.goSceneTimeline3 = nil
  self.goSceneTimeline4 = nil
  self:InitCacheData()
  self.levelData = PlayerData.SoldierData:GetCurLevelData()
  if self.levelData == nil then
    return
  end
  self:RefreshLimitAction()
  NovaAPI.SetTMPText(self._mapNode.TextReputation, tostring(self.levelData:GetHp()))
  self:InitNodeList()
  self._mapNode.BuffContainer:RefreshBuff()
  self:InitExperience()
  self:InitCoin()
  self:InitFightIcon()
  self:InitSellList()
  self:InitChessListIns()
  self:InitChessList()
  self._mapNode.SoldierNodeTips:HideNodeTips()
  self._mapNode.btnCloseShop.gameObject:SetActive(false)
  self._mapNode.SoldierShopComponent:HideShopPanel()
  self._mapNode.SoldierPosEffectTips:HideTips()
  self:RefreshGoState()
  self:RefreshBossSkill()
  self._mapNode.blockInput:SetActive(false)
  self._mapNode.fxFlyRoot:InitFx()
  self.bInShopAnim = false
  CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_transition")
  if self.levelData:CheckSandTableDisable() then
    self:ShowSandtable(true)
    if self.levelData:IsSandtableSceneLoaded() then
      self:PlaySceneTimeline()
    end
  end
  local fnReady = self.levelData.fnPanelReadyOnce
  if fnReady ~= nil then
    self.levelData.fnPanelReadyOnce = nil
    fnReady()
  elseif self._panel.bReturnFromOverlay then
    self._panel.bReturnFromOverlay = nil
    self:ShowSandtable(true)
  end
end

function SoldierSandtableCtrl:OnDisable()
  if self.timelineTimer ~= nil then
    self.timelineTimer:Cancel()
  end
end

function SoldierSandtableCtrl:PlaySceneTimeline(callback)
  local sSceneName = self.levelData ~= nil and self.levelData:GetSandtableSceneName() or nil
  if sSceneName == nil then
    if callback ~= nil then
      callback()
    end
    return
  end
  if self.timelineTimer ~= nil then
    self.timelineTimer:Cancel()
  end
  local sceneRoot = CS.MainMenuModuleHelper.GetMainMenuSceneRoot(sSceneName)
  if sceneRoot == nil then
    if callback ~= nil then
      callback()
    end
    return
  end
  self:ShowSandtable(false)
  self.goSceneTimeline1 = sceneRoot.transform:Find("==== Environment ====/Timeline1/EnterCamera_SoldierUI")
  self.goSceneTimeline2 = sceneRoot.transform:Find("==== Environment ====/Timeline2/EnterCamera_SoldierUISlow")
  self.goSceneTimeline3 = sceneRoot.transform:Find("==== Environment ====/Timeline3/SoldierUI_Down")
  self.goSceneTimeline4 = sceneRoot.transform:Find("==== Environment ====/Timeline4/SoldierUI_Up")
  local cameraBrain = CS.GameCameraStackManager.Instance.mainCameraBrain
  if self.goSceneTimeline1 ~= nil then
    NovaAPIHotfix.BindTimelineCameraBrain(self.goSceneTimeline1.gameObject, cameraBrain)
  end
  if self.goSceneTimeline2 ~= nil then
    NovaAPIHotfix.BindTimelineCameraBrain(self.goSceneTimeline2.gameObject, cameraBrain)
  end
  if self.goSceneTimeline3 ~= nil then
    NovaAPIHotfix.BindTimelineCameraBrain(self.goSceneTimeline3.gameObject, cameraBrain)
  end
  if self.goSceneTimeline4 ~= nil then
    NovaAPIHotfix.BindTimelineCameraBrain(self.goSceneTimeline4.gameObject, cameraBrain)
  end
  local bFirstEnterScene = self.levelData.sLastTimelineScene ~= sSceneName
  local goTimeline = bFirstEnterScene and self.goSceneTimeline1 or self.goSceneTimeline2
  local nWait = bFirstEnterScene and 1.5 or 0.5
  if goTimeline ~= nil then
    goTimeline.gameObject:SetActive(true)
    NovaAPIHotfix.PlayTimeline(goTimeline.gameObject)
    self.timelineTimer = self:AddTimer(1, nWait, function()
      self.timelineTimer = nil
      self:ShowSandtable(true)
      if callback ~= nil then
        callback()
      end
    end, true, true, true)
    self.levelData.sLastTimelineScene = sSceneName
  end
  NovaAPI.SetComponentEnable(self.canvas, true)
end

function SoldierSandtableCtrl:RefreshLimitAction()
  local bLimitAction = self.levelData:CheckSandTableDisable()
  self._mapNode.btn_GoBackEvent.gameObject:SetActive(bLimitAction)
  self._mapNode.btnPolicy.gameObject:SetActive(not bLimitAction)
  self._mapNode.btnHandbook.gameObject:SetActive(not bLimitAction)
end

function SoldierSandtableCtrl:CheckLimitAction()
  return self.levelData:CheckSandTableDisable()
end

function SoldierSandtableCtrl:InitExperience()
  local nCurLevel, nMaxLevel = self.levelData:GetShopLevel()
  self._mapNode.btnExperience.gameObject:SetActive(nCurLevel < nMaxLevel)
  self._mapNode.btnMax.gameObject:SetActive(nMaxLevel <= nCurLevel)
  self.nCacheShopLevel = nCurLevel
  self.nCacheExp = self.levelData:GetExp()
  for _, v in ipairs(self._mapNode.TextLv) do
    NovaAPI.SetTMPText(v, tostring(nCurLevel))
  end
  self._mapNode.imgBuyExpCostIcon.gameObject:SetActive(nCurLevel < nMaxLevel)
  self._mapNode.TextCostNum.gameObject:SetActive(nCurLevel < nMaxLevel)
  if nCurLevel == nMaxLevel then
    NovaAPI.SetImageFillAmount(self._mapNode.BarContainer, 1)
    for _, v in ipairs(self._mapNode.TextExpNum) do
      NovaAPI.SetTMPText(v, ConfigTable.GetUIText("Soldier_Sandtable_MaxLevel"))
    end
    NovaAPI.SetTMPText(self._mapNode.txtExpTitle, ConfigTable.GetUIText("Soldier_Sandtable_MaxLevel"))
  else
    local nNeedExp = ConfigTable.GetData("SoldierShopLevel", nCurLevel).Exp
    local nCurExp = self.levelData:GetExp()
    NovaAPI.SetImageFillAmount(self._mapNode.BarContainer, nCurExp / nNeedExp)
    for _, v in ipairs(self._mapNode.TextExpNum) do
      NovaAPI.SetTMPText(v, tostring(nCurExp) .. "/" .. tostring(nNeedExp))
    end
    local shopData = self.levelData:GetShopData()
    if shopData ~= nil then
      NovaAPI.SetTMPText(self._mapNode.TextCostNum, shopData.nPurchaseExpPrice)
    else
      local tbCost = ConfigTable.GetConfigArray("SoldierBuyExp", nCurLevel)
      NovaAPI.SetTMPText(self._mapNode.TextCostNum, tbCost[1])
    end
    NovaAPI.SetTMPText(self._mapNode.txtExpTitle, ConfigTable.GetUIText("Soldier_Sandtable_BuyExpTitle"))
  end
end

function SoldierSandtableCtrl:InitPartnerList()
  local tbDeployChess = self.levelData:GetDeploy()
  local tbActivePartner, tbUIData = SoldierAttrData.CalcActivePartners(tbDeployChess)
  self._mapNode.PartnerList:SetData(tbUIData)
  self._mapNode.PartnerList:SetTipsRoot(self._mapNode.parnterDetailRoot)
end

function SoldierSandtableCtrl:InitNodeList()
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
      self:SetPngSprite(imgIcon, AssetRoot .. AllEnum.SoliderNoteTypeCfg[curStageNodeList[i].nNodeType].Icon)
      for j = 1, 3 do
        local imgDot = node.transform:Find("imgDot" .. j)
        imgDot.gameObject:SetActive(i < #curStageNodeList)
      end
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
  self._mapNode.SoldierNodeTips:HideNodeTips()
end

function SoldierSandtableCtrl:InitCoin()
  local nCount = self.levelData:GetItem(AllEnum.CoinItemId.SoldierCurrency)
  NovaAPI.SetTMPText(self._mapNode.TextCurCoin, tostring(nCount))
end

function SoldierSandtableCtrl:InitFightIcon()
  local nWiningStreak, nLosingStreak = self.levelData:GetStreakCount()
  self._mapNode.ImgIconFight_lose:SetActive(0 < nLosingStreak)
  self._mapNode.ImgIconFight:SetActive(nLosingStreak == 0)
  if 0 < nLosingStreak then
    NovaAPI.SetTMPText(self._mapNode.TextFightCount, tostring(nLosingStreak))
  else
    NovaAPI.SetTMPText(self._mapNode.TextFightCount, tostring(nWiningStreak))
  end
end

function SoldierSandtableCtrl:InitChessListIns()
  self.MainChessListIns = {}
  self.SupportChessListIns = {}
  self.WaitingChessListIns = {}
  for i = 1, #self._mapNode.EntranceItemTemplate do
    table.insert(self.MainChessListIns, self._mapNode.EntranceItemTemplate[i]:GetItemBtnInstanceId())
    self._mapNode.EntranceItemTemplate[i]:InitSortingOrder(self._nSortingOrder)
    self._mapNode.EntranceItemTemplate[i]:SetPositionIndex(i)
    self._mapNode.EntranceItemTemplate[i]:SetDetailRoot(self._mapNode.charDetaiRoot)
  end
  for i = 1, #self._mapNode.UpportingItemTemplate do
    table.insert(self.SupportChessListIns, self._mapNode.UpportingItemTemplate[i]:GetItemBtnInstanceId())
    self._mapNode.UpportingItemTemplate[i]:InitSortingOrder(self._nSortingOrder)
    self._mapNode.UpportingItemTemplate[i]:SetDetailRoot(self._mapNode.charDetaiRoot)
  end
  for i = 1, #self._mapNode.WaitingCardItemTemplate do
    table.insert(self.WaitingChessListIns, self._mapNode.WaitingCardItemTemplate[i]:GetItemBtnInstanceId())
    self._mapNode.WaitingCardItemTemplate[i]:InitSortingOrder(self._nSortingOrder)
    self._mapNode.WaitingCardItemTemplate[i]:SetDetailRoot(self._mapNode.charDetaiRoot)
  end
  for i = 1, #self._mapNode.OtherChar do
    self._mapNode.OtherChar[i]:InitSortingOrder(self._nSortingOrder)
  end
end

function SoldierSandtableCtrl:InitChessList()
  self:RefreshChessList()
  self:InitChessCount()
  self:InitPartnerList()
  self:RefreshGoState()
end

function SoldierSandtableCtrl:InitChessCount()
  local nCurLevel, nMaxLevel = self.levelData:GetShopLevel()
  local shopCfg = ConfigTable.GetData("SoldierShopLevel", nCurLevel)
  local nMaxCount = shopCfg.Count
  local nCurCount = 0
  local tbDeployChess, tbWaitingChess, tbOtherChess = self.levelData:GetDeploy()
  for k, v in ipairs(tbDeployChess) do
    if v.nId ~= 0 then
      nCurCount = nCurCount + 1
    end
  end
  nCurCount = nCurCount + #tbOtherChess
  self.nCacheChessMaxCount = nMaxCount
  self._mapNode.go_overflow:SetActive(nMaxCount < nCurCount)
  if self.overflowTimer ~= nil then
    self.overflowTimer:_Stop()
  end
  if nMaxCount < nCurCount then
    self._mapNode.go_overflow_anim:Play("Overflow_in")
  else
    self.overflowTimer = self:AddTimer(1, 0.26, function()
      self._mapNode.go_overflow_anim:Play("Overflow_out")
    end, true, true, true)
  end
  local tbCurChessColor
  if nMaxCount > nCurCount then
    tbCurChessColor = chessCountColor.Normal
  elseif nCurCount == nMaxCount then
    tbCurChessColor = chessCountColor.Max
  else
    tbCurChessColor = chessCountColor.Overflow
  end
  if tbCurChessColor ~= nil then
    NovaAPI.SetImageColor(self._mapNode.ImageAddCharCount, tbCurChessColor.mapColor)
    NovaAPI.SetTMPText(self._mapNode.TextAddCharCount, string.format("<color=#%s>%d/%d</color>", tbCurChessColor.sColor, nCurCount, nMaxCount))
    NovaAPI.SetTMPText(self._mapNode.TextAddCharCountShow, string.format("%d/%d", nCurCount, nMaxCount))
  end
end

function SoldierSandtableCtrl:InitSellList()
  self.SellListIns = {}
  for i = 1, #self._mapNode.btn_Sell do
    table.insert(self.SellListIns, self._mapNode.btn_Sell[i].gameObject:GetInstanceID())
  end
  if self._mapNode.SoldierShopComponent ~= nil then
    table.insert(self.SellListIns, self._mapNode.SoldierShopComponent:GetSellBtnInstanceId())
  end
  self._mapNode.SaleContainer:SetActive(false)
end

function SoldierSandtableCtrl:RefreshSell(nCount)
  for _, v in ipairs(self._mapNode.txtSellPrice) do
    NovaAPI.SetTMPText(v, nCount)
  end
end

function SoldierSandtableCtrl:RefreshChessList()
  for i = 1, #self._mapNode.EntranceItemTemplate do
    local item = self._mapNode.EntranceItemTemplate[i]
    item:SetData(self._panel.MainChessList[i])
  end
  for i = 1, #self._mapNode.UpportingItemTemplate do
    local item = self._mapNode.UpportingItemTemplate[i]
    item:SetData(self._panel.SupportChessList[i])
  end
  for i = 1, #self._mapNode.WaitingCardItemTemplate do
    local item = self._mapNode.WaitingCardItemTemplate[i]
    item:SetData(self._panel.WaitingChessList[i])
  end
  for k, v in ipairs(self._mapNode.OtherChar) do
    v.gameObject:SetActive(false)
  end
  self:RefreshOtherChessData()
end

function SoldierSandtableCtrl:InitOtherChessList()
  self._panel.OtherChessList = {}
  local _, _, tbOther = self.levelData:GetDeploy()
  for _, v in ipairs(tbOther) do
    for i = 1, v.nCount do
      table.insert(self._panel.OtherChessList, {
        nId = v.nId,
        nStar = v.nStar
      })
    end
  end
  table.sort(self._panel.OtherChessList, function(a, b)
    return a.nId < b.nId
  end)
  self:RefreshOtherChessData()
end

function SoldierSandtableCtrl:RefreshOtherChessData()
  for k, v in ipairs(self._mapNode.OtherChar) do
    v.gameObject:SetActive(false)
  end
  for i = 1, #self._panel.OtherChessList do
    local item = self._mapNode.OtherChar[i]
    if item ~= nil then
      item:SetData(self._panel.OtherChessList[i])
      item.gameObject:SetActive(true)
    end
  end
end

function SoldierSandtableCtrl:RefreshGoState()
  if self:CheckLimitAction() then
    self:SetGoState(false)
    return
  end
  local nCurLevel, nMaxLevel = self.levelData:GetShopLevel()
  local tbDeployChess = self.levelData:GetDeploy()
  local shopCfg = ConfigTable.GetData("SoldierShopLevel", nCurLevel)
  local nMaxCount = shopCfg.Count
  local nCurCount = 0
  for k, v in ipairs(tbDeployChess) do
    if v.nId ~= 0 then
      nCurCount = nCurCount + 1
    end
  end
  if nCurCount == 0 then
    self:SetGoState(false)
    return
  end
  if nMaxCount < nCurCount then
    self:SetGoState(false)
    return
  end
  self:SetGoState(true)
end

function SoldierSandtableCtrl:SetGoState(bCanGo)
  self._mapNode.Enable:SetActive(bCanGo)
  self._mapNode.Disable:SetActive(not bCanGo)
end

function SoldierSandtableCtrl:CalSellPrice(chessData)
  local charCfg = ConfigTable.GetData("SoldierCharacter", chessData.nId)
  if charCfg == nil then
    return 0
  end
  local nCount = 1
  for i = 1, chessData.nStar - 1 do
    nCount = nCount * 3
  end
  return charCfg.Cost * nCount
end

function SoldierSandtableCtrl:GetDragInsData(nInsId)
  if table.indexof(self.MainChessListIns, nInsId) > 0 then
    return DragInsType.Chess, self._panel.MainChessList[table.indexof(self.MainChessListIns, nInsId)]
  elseif 0 < table.indexof(self.SupportChessListIns, nInsId) then
    return DragInsType.Chess, self._panel.SupportChessList[table.indexof(self.SupportChessListIns, nInsId)]
  elseif 0 < table.indexof(self.WaitingChessListIns, nInsId) then
    return DragInsType.Chess, self._panel.WaitingChessList[table.indexof(self.WaitingChessListIns, nInsId)]
  elseif 0 < table.indexof(self.SellListIns, nInsId) then
    return DragInsType.Sell, nil
  end
  return DragInsType.None, nil
end

function SoldierSandtableCtrl:ResetPostionType()
  for k, v in ipairs(self._panel.MainChessList) do
    v.nPositionType = GameEnum.SoldierPositionType.FightPosition
    v.nIndex = k
  end
  for k, v in ipairs(self._panel.SupportChessList) do
    v.nPositionType = GameEnum.SoldierPositionType.SupportPosition
    v.nIndex = k
  end
  for k, v in ipairs(self._panel.WaitingChessList) do
    v.nPositionType = 3
    v.nIndex = k
  end
end

function SoldierSandtableCtrl:SwapChess(dragChessData, targetChessData)
  local sourceList, targetList
  if dragChessData.nPositionType == GameEnum.SoldierPositionType.FightPosition then
    sourceList = self._panel.MainChessList
  elseif dragChessData.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
    sourceList = self._panel.SupportChessList
  else
    sourceList = self._panel.WaitingChessList
  end
  if targetChessData.nPositionType == GameEnum.SoldierPositionType.FightPosition then
    targetList = self._panel.MainChessList
  elseif targetChessData.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
    targetList = self._panel.SupportChessList
  else
    targetList = self._panel.WaitingChessList
  end
  if not self:CheckSwapCondition(sourceList, targetList, dragChessData, targetChessData) then
    self:RefreshChessList()
    return
  end
  local nUid = dragChessData.nUid
  if nUid == nil or nUid == 0 then
    printError("[Soldier] SwapChess 拖拽源无 UID")
    return
  end
  local nTargetSlot = self.levelData:PosIndexToSlot(targetChessData.nPositionType, targetChessData.nIndex)
  if nTargetSlot == 0 then
    return
  end
  self:ResetPostionType()
  EventManager.Hit(EventId.BlockInput, true)
  local nPositionType = targetChessData.nPositionType
  self.levelData:SendMove(nUid, nTargetSlot, function(tbChange)
    EventManager.Hit("Guide_SwapSoldierSuccess")
    if nPositionType == AllEnum.SoldierPositionType.Waiting then
      CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_selectCard_downChair")
    elseif nPositionType == GameEnum.SoldierPositionType.FightPosition or nPositionType == GameEnum.SoldierPositionType.SupportPosition then
      CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_selectCard_prepareBattle")
    end
    EventManager.Hit(EventId.BlockInput, false)
    local tbStep = tbChange and tbChange.tbChessChangeStep
    if tbStep ~= nil and 0 < #tbStep then
      local bNeedLock = false
      for _, s in ipairs(tbStep) do
        if s.tbConsume ~= nil and 0 < #s.tbConsume or s.tbObtain ~= nil and 0 < #s.tbObtain then
          bNeedLock = true
          break
        end
      end
      if bNeedLock then
        self._mapNode.blockInput:SetActive(true)
      end
      self:InitChessCount()
      self:InitPartnerList()
      self:RefreshGoState()
      self:PlayStepsAnimation(tbStep, function()
        if bNeedLock then
          self._mapNode.blockInput:SetActive(false)
        end
      end)
    end
  end)
end

function SoldierSandtableCtrl:CheckSwapCondition(sourceList, targetList, dragChessData, targetChessData)
  if sourceList == targetList then
    return true
  end
  local waitingList = self._panel.WaitingChessList
  if sourceList ~= waitingList and targetList ~= waitingList then
    return true
  end
  local deployedSideData, waitingSideData
  if sourceList == waitingList then
    waitingSideData = dragChessData
    deployedSideData = targetChessData
  else
    waitingSideData = targetChessData
    deployedSideData = dragChessData
  end
  local nIncomingId = waitingSideData.nId
  if nIncomingId ~= 0 then
    local function hasSameIdExcept(list, exceptData, nId)
      for _, v in ipairs(list) do
        if v ~= exceptData and v.nId == nId then
          return true
        end
      end
      return false
    end
    
    if hasSameIdExcept(self._panel.MainChessList, deployedSideData, nIncomingId) or hasSameIdExcept(self._panel.SupportChessList, deployedSideData, nIncomingId) then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_SwapChess_Tips"))
      return false
    end
  end
  if sourceList == waitingList and deployedSideData.nId == 0 then
    local nCurLevel = self.levelData:GetShopLevel()
    local shopCfg = ConfigTable.GetData("SoldierShopLevel", nCurLevel)
    local nMaxCount = shopCfg.Count
    local nCurCount = 0
    for _, v in ipairs(self._panel.MainChessList) do
      if v.nId ~= 0 then
        nCurCount = nCurCount + 1
      end
    end
    for _, v in ipairs(self._panel.SupportChessList) do
      if v.nId ~= 0 then
        nCurCount = nCurCount + 1
      end
    end
    if nMaxCount <= nCurCount then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_OverChessCount_Tips"))
      return false
    end
  end
  return true
end

function SoldierSandtableCtrl:GetCharCtrlByChessData(chessData, bOtherAdd)
  if bOtherAdd == nil then
    bOtherAdd = false
  end
  if chessData.nPositionType == GameEnum.SoldierPositionType.FightPosition then
    return self._mapNode.EntranceItemTemplate[chessData.nIndex]
  elseif chessData.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
    return self._mapNode.UpportingItemTemplate[chessData.nIndex]
  end
  if (chessData.nPositionType == nil or chessData.nPositionType == AllEnum.SoldierPositionType.Other) and (chessData.nIndex == nil or chessData.nIndex == 0) then
    if not bOtherAdd then
      for k, v in ipairs(self._panel.OtherChessList) do
        if v.nId == chessData.nId and v.nStar == chessData.nStar then
          return self._mapNode.OtherChar[k]
        end
      end
    else
      return self._mapNode.OtherChar[#self._panel.OtherChessList + 1]
    end
  else
    return self._mapNode.WaitingCardItemTemplate[chessData.nIndex]
  end
  return nil
end

function SoldierSandtableCtrl:RefreshBossSkill()
  local nTemplateId = self.levelData:GetBossTemplateId()
  if nTemplateId == 0 then
    return
  end
  local mapCfg = ConfigTable.GetData("SoldierBossTemplate", nTemplateId)
  if mapCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgSkill, mapCfg.SoldierRoleSkillIcon)
    for _, v in ipairs(self._mapNode.imgBossTemplateIcon) do
      self:SetPngSprite(v, mapCfg.SoldierPlayerHead)
    end
    local nSkillType = mapCfg.SoldierRoleSkillType
    self._mapNode.imgSkillPassive.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_1 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_3)
    self._mapNode.imgSkillInitiative.gameObject:SetActive(nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_2 or nSkillType == GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_4)
  end
end

function SoldierSandtableCtrl:CheckAnimQueue()
  if #self.AnimQueue == 0 then
    self:InitOtherChessList()
    self:RefreshGoState()
    return
  end
  local animaData = self.AnimQueue[1]
  table.remove(self.AnimQueue, 1)
  if animaData.nType == animQueueType.NodeReward then
    self:PlayNodeReward(animaData, function()
      self:InitChessCount()
      self:InitPartnerList()
      self:RefreshGoState()
      self:CheckAnimQueue()
    end)
  elseif animaData.nType == animQueueType.EnterSandtable then
    self._mapNode.goNodeDeployment:SetActive(true)
    self._mapNode.blockInput:SetActive(true)
    self:AddTimer(1, 1.5, function()
      self._mapNode.blockInput:SetActive(false)
      self._mapNode.goNodeDeployment:SetActive(false)
      self:CheckAnimQueue()
    end, true, true, true)
  elseif animaData.nType == animQueueType.OpenShop then
    self:OpenShop(true)
    self:CheckAnimQueue()
  end
end

function SoldierSandtableCtrl:PlayNodeReward(animaData, callback)
  local rewardData = animaData.rewardData
  if (rewardData.tbSteps == nil or #rewardData.tbSteps == 0) and (rewardData.data == nil or rewardData.data.nCoin == 0) then
    if callback ~= nil then
      callback()
    end
    return
  end
  if rewardData.nType == AllEnum.SoldierRewardSource.Apply then
    self._mapNode.goNodeSupply:SetActive(true)
    self._mapNode.blockInput:SetActive(true)
    self:AddTimer(1, 0.5, function()
      local tbChess = {}
      if rewardData.tbSteps[1] ~= nil and rewardData.tbSteps[1].tbObtain ~= nil then
        tbChess = rewardData.tbSteps[1].tbObtain
      end
      for k, v in ipairs(tbChess) do
        local chessData = {
          nId = v.nId,
          nStar = v.nStar,
          nUid = v.nUid,
          nPositionType = v.nTargetType,
          nIndex = v.nIndex
        }
        self:AddChessData2list(chessData)
      end
      self:PlayRewardFly(tbChess, rewardData.data.nCoin, function()
        self:PlayStepsAnimation(rewardData.tbSteps, function()
          self._mapNode.goNodeSupply:SetActive(false)
          if callback ~= nil then
            self._mapNode.blockInput:SetActive(false)
            callback()
          end
        end)
      end)
    end, true, true, true)
  elseif rewardData.nType == AllEnum.SoldierRewardSource.CardWipe then
    self._mapNode.blockInput:SetActive(true)
    self:PlayStepsAnimation(rewardData.tbSteps, function()
      self._mapNode.blockInput:SetActive(false)
      if callback ~= nil then
        callback()
      end
    end)
  elseif rewardData.nType == AllEnum.SoldierRewardSource.EventBattle or rewardData.nType == AllEnum.SoldierRewardSource.Battle then
    for k, v in ipairs(self._mapNode.reward) do
      v.gameObject:SetActive(false)
    end
    local tbChessReward = rewardData.data.tbChess or {}
    for i, p in ipairs(tbChessReward) do
      local item = self._mapNode.reward[i]
      item:SetItemData(p.Tid)
      item:SetCharLevel(p.Star)
      item.gameObject:SetActive(true)
    end
    local nCoin = rewardData.data.nCoin or 0
    self._mapNode.rewardItem.gameObject:SetActive(false)
    if 0 < nCoin then
      local mapItemCfg = ConfigTable.GetData_Item(AllEnum.CoinItemId.SoldierCurrency)
      if mapItemCfg ~= nil then
        self._mapNode.rewardItem.gameObject:SetActive(true)
        self._mapNode.rewardItem:SetItem(GameEnum.itemRarity.SSR, nCoin, mapItemCfg.Icon, AllEnum.CoinItemId.SoldierCurrency)
      end
    end
    self._mapNode.blockInput:SetActive(true)
    self._mapNode.goNodeReward:SetActive(true)
    self:AddTimer(1, 0.5, function()
      local tbChess = {}
      if rewardData.tbSteps[1] ~= nil and rewardData.tbSteps[1].tbObtain ~= nil then
        tbChess = rewardData.tbSteps[1].tbObtain
      end
      self:PlayRewardFly(tbChess, rewardData.data.nCoin, function()
        self:PlayStepsAnimation(rewardData.tbSteps, function()
          self._mapNode.goNodeReward:SetActive(false)
          if callback ~= nil then
            self._mapNode.blockInput:SetActive(false)
            callback()
          end
        end)
        self:InitCoin()
      end)
    end, true, true, true)
  end
end

function SoldierSandtableCtrl:AddChessData2list(chessData, bLose)
  if bLose == nil then
    bLose = false
  end
  if chessData.nPositionType == GameEnum.SoldierPositionType.FightPosition then
    self._panel.MainChessList[chessData.nIndex] = chessData
  elseif chessData.nPositionType == GameEnum.SoldierPositionType.SupportPosition then
    self._panel.SupportChessList[chessData.nIndex] = chessData
  elseif chessData.nPositionType == 3 then
    self._panel.WaitingChessList[chessData.nIndex] = chessData
  else
    if bLose then
      local index = 0
      for k, v in ipairs(self._panel.OtherChessList) do
        if v.nId == chessData.nId and v.nStar == chessData.nStar then
          index = k
        end
        if 0 < index then
          table.remove(self._panel.OtherChessList, index)
          break
        end
      end
    else
      table.insert(self._panel.OtherChessList, {
        nId = chessData.nId,
        nStar = chessData.nStar
      })
    end
    table.sort(self._panel.OtherChessList, function(a, b)
      return a.nId < b.nId
    end)
    self:RefreshOtherChessData()
  end
end

function SoldierSandtableCtrl:PlayRewardFly(tbChess, nCoin, callback)
  local tbFx = {}
  if nCoin ~= nil and 0 < nCoin then
    tbFx[fxType.Coin] = {}
    table.insert(tbFx[fxType.Coin], {
      from = self._mapNode.fxFlyRoot.gameObject.transform,
      to = self._mapNode.TextCurCoin.gameObject.transform
    })
  end
  for k, v in ipairs(tbChess) do
    local cfg = ConfigTable.GetData("SoldierCharacter", v.nId)
    if cfg ~= nil then
      local to
      if v.nTargetType == GameEnum.SoldierPositionType.FightPosition then
        to = self._mapNode.EntranceItemTemplate[v.nIndex].gameObject.transform
      elseif v.nTargetType == GameEnum.SoldierPositionType.SupportPosition then
        to = self._mapNode.UpportingItemTemplate[v.nIndex].gameObject.transform
      elseif v.nTargetType == AllEnum.SoldierPositionType.Waiting then
        to = self._mapNode.WaitingCardItemTemplate[v.nIndex].gameObject.transform
      elseif v.nTargetType == nil or v.nTargetType == AllEnum.SoldierPositionType.Other then
        to = self._mapNode.OtherCharLsit
      end
      if tbFx[cfg.Rarity] == nil then
        tbFx[cfg.Rarity] = {}
      end
      table.insert(tbFx[cfg.Rarity], {
        from = self._mapNode.fxFlyRoot.gameObject.transform,
        to = to
      })
    end
  end
  self._mapNode.fxFlyRoot:PlayFx(tbFx, callback)
end

function SoldierSandtableCtrl:PlayStepsAnimation(tbSteps, callback)
  local bPartnerChanged = false
  if self.levelData ~= nil and self.levelData.HasPartnerSetChanged ~= nil then
    bPartnerChanged = self.levelData:HasPartnerSetChanged()
  end
  if bPartnerChanged then
    self._nStepsSession = (self._nStepsSession or 0) + 1
    
    local function _stopSlots(slotList)
      for _, slotCtrl in ipairs(slotList or {}) do
        if slotCtrl ~= nil and slotCtrl.itemCtrl ~= nil and slotCtrl.itemCtrl._StopPartnerActiveAnim ~= nil then
          slotCtrl.itemCtrl:_StopPartnerActiveAnim()
        end
      end
    end
    
    _stopSlots(self._mapNode.EntranceItemTemplate)
    _stopSlots(self._mapNode.UpportingItemTemplate)
    if self.levelData.ClearPartnerSetChangedFlag ~= nil then
      self.levelData:ClearPartnerSetChangedFlag()
    end
  end
  local nMySession = self._nStepsSession or 0
  if tbSteps == nil or #tbSteps == 0 then
    if callback ~= nil then
      callback()
    end
    if NovaAPI.IsEditorPlatform() then
      self:PrintChessList()
    end
    return
  end
  for _, v in ipairs(tbSteps) do
    for _, n in ipairs(v.tbConsume) do
      if n.nSourceType == AllEnum.SoldierPositionType.Other then
        local chessData = {
          nId = n.nId,
          nStar = n.nStar,
          nUid = n.nUid,
          nPositionType = n.nSourceType,
          nIndex = n.nIndex
        }
        self:AddChessData2list(chessData, true)
      else
        local chessData = {
          nId = 0,
          nStar = 0,
          nUid = 0,
          nPositionType = n.nSourceType,
          nIndex = n.nIndex
        }
        self:AddChessData2list(chessData, true)
      end
    end
    for _, n in ipairs(v.tbObtain) do
      local chessData = {
        nId = n.nId,
        nStar = n.nStar,
        nUid = n.nUid,
        nPositionType = n.nTargetType,
        nIndex = n.nIndex
      }
      self:AddChessData2list(chessData)
    end
    if v.tbUpdate ~= nil then
      local mapDstKey = {}
      for _, n in ipairs(v.tbUpdate) do
        mapDstKey[tostring(n.nTargetType) .. "_" .. tostring(n.nTargetIndex)] = true
      end
      for _, n in ipairs(v.tbUpdate) do
        if n.nSourceType ~= AllEnum.SoldierPositionType.Other then
          local sSrcKey = tostring(n.nSourceType) .. "_" .. tostring(n.nSourceIndex)
          if not mapDstKey[sSrcKey] then
            local srcData = {
              nId = 0,
              nStar = 0,
              nUid = 0,
              nPositionType = n.nSourceType,
              nIndex = n.nSourceIndex
            }
            self:AddChessData2list(srcData, true)
          end
        end
        local dstData = {
          nId = n.nId,
          nStar = n.nStar,
          nUid = n.nUid,
          nPositionType = n.nTargetType,
          nIndex = n.nTargetIndex
        }
        self:AddChessData2list(dstData)
      end
    end
  end
  
  local function wait()
    local bGuide510 = false
    while 0 < #tbSteps do
      local step = table.remove(tbSteps, 1)
      local nAnimLength = 0
      if step.sSpecial == "CardWipeAll" then
      end
      for k, v in ipairs(step.tbConsume) do
        local chessData = {
          nId = v.nId,
          nStar = v.nStar,
          nUid = v.nUid,
          nPositionType = v.nSourceType,
          nIndex = v.nIndex
        }
        local sourceCharCtrl = self:GetCharCtrlByChessData(chessData)
        if sourceCharCtrl ~= nil then
          sourceCharCtrl:SetAnimator(chessAnimType.COMPOUND_OUT)
          nAnimLength = math.max(nAnimLength, chessAnimLength[chessAnimType.COMPOUND_OUT])
        end
      end
      coroutine.yield(CS.UnityEngine.WaitForSeconds(nAnimLength))
      nAnimLength = 0
      for k, v in ipairs(step.tbConsume) do
        if v.nSourceType == AllEnum.SoldierPositionType.Other then
          local chessData = {
            nId = v.nId,
            nStar = v.nStar,
            nUid = v.nUid,
            nPositionType = v.nSourceType,
            nIndex = v.nIndex
          }
          local sourceCharCtrl = self:GetCharCtrlByChessData(chessData)
          if sourceCharCtrl ~= nil then
            sourceCharCtrl:SetData(chessData)
          end
        else
          local chessData = {
            nId = 0,
            nStar = 0,
            nUid = 0,
            nPositionType = v.nSourceType,
            nIndex = v.nIndex
          }
          local sourceCharCtrl = self:GetCharCtrlByChessData(chessData)
          if sourceCharCtrl ~= nil then
            sourceCharCtrl:SetData(chessData)
          end
        end
      end
      for k, v in ipairs(step.tbObtain) do
        local chessData = {
          nId = v.nId,
          nStar = v.nStar,
          nUid = v.nUid,
          nPositionType = v.nTargetType,
          nIndex = v.nIndex
        }
        local targetCharCtrl = self:GetCharCtrlByChessData(chessData)
        if targetCharCtrl ~= nil then
          targetCharCtrl:SetData(chessData)
        end
      end
      for k, v in ipairs(step.tbObtain) do
        local chessData = {
          nId = v.nId,
          nStar = v.nStar,
          nUid = v.nUid,
          nPositionType = v.nTargetType,
          nIndex = v.nIndex
        }
        local targetCharCtrl = self:GetCharCtrlByChessData(chessData, true)
        if targetCharCtrl ~= nil then
          if 0 < #step.tbConsume then
            nAnimLength = math.max(nAnimLength, chessAnimLength[chessAnimType.COMPOUND])
            targetCharCtrl:SetAnimator(chessAnimType.COMPOUND)
            CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_chair_combine")
          else
            nAnimLength = math.max(nAnimLength, chessAnimLength[chessAnimType.PUTIN])
            targetCharCtrl:SetAnimator(chessAnimType.PUTIN)
          end
        end
      end
      if step.tbUpdate ~= nil then
        local mapDstKey = {}
        for _, v in ipairs(step.tbUpdate) do
          mapDstKey[tostring(v.nTargetType) .. "_" .. tostring(v.nTargetIndex)] = true
        end
        for k, v in ipairs(step.tbUpdate) do
          if v.nSourceType == AllEnum.SoldierPositionType.Other then
            for idx, item in ipairs(self._panel.OtherChessList) do
              if item.nId == v.nId and item.nStar == v.nStar then
                local srcCtrl = self._mapNode.OtherChar[idx]
                if srcCtrl ~= nil then
                  srcCtrl:SetData({
                    nId = 0,
                    nStar = 0,
                    nUid = 0,
                    nPositionType = AllEnum.SoldierPositionType.Other
                  })
                end
                table.remove(self._panel.OtherChessList, idx)
                break
              end
            end
          else
            local sSrcKey = tostring(v.nSourceType) .. "_" .. tostring(v.nSourceIndex)
            if not mapDstKey[sSrcKey] then
              local srcChessData = {
                nId = v.nId,
                nStar = v.nStar,
                nUid = v.nUid,
                nPositionType = v.nSourceType,
                nIndex = v.nSourceIndex
              }
              local srcCharCtrl = self:GetCharCtrlByChessData(srcChessData)
              if srcCharCtrl ~= nil then
                local newSrcChessData = {
                  nId = 0,
                  nStar = 0,
                  nUid = 0,
                  nPositionType = v.nSourceType,
                  nIndex = v.nSourceIndex
                }
                srcCharCtrl:SetData(newSrcChessData)
              end
            end
          end
          local dstChessData = {
            nId = v.nId,
            nStar = v.nStar,
            nUid = v.nUid,
            nPositionType = v.nTargetType,
            nIndex = v.nTargetIndex
          }
          local dstCharCtrl = self:GetCharCtrlByChessData(dstChessData)
          if dstCharCtrl ~= nil then
            dstCharCtrl:SetData(dstChessData)
            nAnimLength = math.max(nAnimLength, chessAnimLength[chessAnimType.PUTIN])
            dstCharCtrl:SetAnimator(chessAnimType.PUTIN)
          end
        end
      end
      coroutine.yield(CS.UnityEngine.WaitForSeconds(nAnimLength))
      if step.sSpecial ~= "CardWipeAll" and step.tbConsume ~= nil and 0 < #step.tbConsume and step.tbObtain ~= nil and 0 < #step.tbObtain then
        bGuide510 = true
        local nId = 0
        for _, v in ipairs(step.tbObtain) do
          if 1 < v.nStar then
            nId = v.nId
            break
          end
        end
        PlayerData.SoldierData:SetGuideData(510, nId)
      end
      if #tbSteps == 0 then
        if callback ~= nil then
          callback()
          if NovaAPI.IsEditorPlatform() then
            self:PrintChessList()
          end
        end
        if bGuide510 and not PlayerData.Guide:CheckGuideFinishById(510) then
          EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_510")
        end
        if self.levelData ~= nil and self.levelData.GetPendingNewPartner ~= nil then
          local tbPending = self.levelData:GetPendingNewPartner()
          self.levelData:ClearPendingNewPartner()
          if tbPending ~= nil then
            local tbOrdered = {}
            for nType, info in pairs(tbPending) do
              table.insert(tbOrdered, {nType = nType, info = info})
            end
            table.sort(tbOrdered, function(a, b)
              return a.nType < b.nType
            end)
            local nPartnerAnimLength = 1
            
            local function _probeAnimLength(slotList)
              for _, slotCtrl in ipairs(slotList or {}) do
                if slotCtrl ~= nil and slotCtrl.itemCtrl ~= nil and slotCtrl.itemCtrl._mapNode ~= nil and slotCtrl.itemCtrl._mapNode.HeadRoot ~= nil then
                  local len = NovaAPI.GetAnimClipLength(slotCtrl.itemCtrl._mapNode.HeadRoot, {"HeadActive"})
                  if type(len) == "number" and 0 < len then
                    return len
                  end
                end
              end
              return nil
            end
            
            if 0 < #tbOrdered then
              nPartnerAnimLength = _probeAnimLength(self._mapNode.EntranceItemTemplate) or _probeAnimLength(self._mapNode.UpportingItemTemplate) or 1
            end
            for i, item in ipairs(tbOrdered) do
              if nMySession ~= self._nStepsSession then
                return
              end
              local tbSinglePartner = {
                [item.nType] = item.info
              }
              
              local function _dispatch(slotList)
                for _, slotCtrl in ipairs(slotList or {}) do
                  if slotCtrl ~= nil and slotCtrl.itemCtrl ~= nil and slotCtrl.itemCtrl.OnEvent_SoldierPartnerNewActive ~= nil then
                    slotCtrl.itemCtrl:OnEvent_SoldierPartnerNewActive(tbSinglePartner)
                  end
                end
              end
              
              _dispatch(self._mapNode.EntranceItemTemplate)
              _dispatch(self._mapNode.UpportingItemTemplate)
              if i < #tbOrdered then
                coroutine.yield(CS.UnityEngine.WaitForSeconds(nPartnerAnimLength))
              end
            end
          end
        end
      end
    end
  end
  
  cs_coroutine.start(wait)
end

function SoldierSandtableCtrl:ShowChessCanPutIn(bShow, chessData)
  if not bShow then
    EventManager.Hit("SoldierChessCanPutIn", false)
  else
    local nCurLevel, nMaxLevel = self.levelData:GetShopLevel()
    local shopCfg = ConfigTable.GetData("SoldierShopLevel", nCurLevel)
    local nMaxCount = shopCfg.Count
    local nCurCount = 0
    for k, v in ipairs(self._panel.MainChessList) do
      if v.nId ~= 0 then
        nCurCount = nCurCount + 1
      end
    end
    for k, v in ipairs(self._panel.SupportChessList) do
      if v.nId ~= 0 then
        nCurCount = nCurCount + 1
      end
    end
    if nMaxCount <= nCurCount then
      if chessData ~= nil and (chessData.nPositionType == GameEnum.SoldierPositionType.FightPosition or chessData.nPositionType == GameEnum.SoldierPositionType.SupportPosition) then
        EventManager.Hit("SoldierChessCanPutIn", true)
      else
        EventManager.Hit("SoldierChessCanPutIn", false)
      end
    else
      EventManager.Hit("SoldierChessCanPutIn", true)
    end
  end
end

function SoldierSandtableCtrl:OpenShop(bOpen)
  if self.goSceneTimeline3 ~= nil then
    self.goSceneTimeline3.gameObject:SetActive(bOpen)
  end
  if self.goSceneTimeline4 ~= nil then
    self.goSceneTimeline4.gameObject:SetActive(not bOpen)
  end
  local timeline = bOpen and self.goSceneTimeline3 or self.goSceneTimeline4
  if timeline ~= nil then
    NovaAPIHotfix.PlayTimeline(timeline.gameObject)
  end
  if bOpen then
    self._mapNode.btnCloseShop.gameObject:SetActive(true)
    self._mapNode.SoldierShopComponent:ShowShopPanel()
    local btn_shopAnimator = self._mapNode.btnShop.transform:Find("AnimRoot"):GetComponent("Animator")
    btn_shopAnimator:Play("ShopContainer")
    self._mapNode.sandtable_anim:Play("SandtableMiddle_S")
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_shop_button")
  else
    self._mapNode.btnCloseShop.gameObject:SetActive(false)
    self._mapNode.SoldierShopComponent:HideShopPanel()
    self._mapNode.sandtable_anim:Play("SandtableMiddle_L")
    local btn_shopAnimator = self._mapNode.btnShop.transform:Find("AnimRoot"):GetComponent("Animator")
    btn_shopAnimator:Play("ShopContainer_close")
    if self.goSceneTimeline4 ~= nil then
      self.goSceneTimeline4.gameObject:SetActive(true)
      NovaAPIHotfix.PlayTimeline(self.goSceneTimeline4.gameObject)
    end
  end
end

function SoldierSandtableCtrl:ShowSandtable(bShow)
  self._mapNode.goRoot.gameObject:SetActive(bShow)
  if bShow then
    self.animRoot:Play("SoldierSandtablePanel_in", 0, 0)
    NovaAPI.SetCanvasOverrideSorting(self._mapNode.goNodeMatch, true)
    NovaAPI.SetCanvasSortingName(self._mapNode.goNodeMatch, self._panel._sSortingLayerName)
    NovaAPI.SetCanvasSortingOrder(self._mapNode.goNodeMatch, self._nSortingOrder + 2)
    NovaAPI.SetCanvasOverrideSorting(self._mapNode.fxFlyRootCanvas, true)
    NovaAPI.SetCanvasSortingName(self._mapNode.fxFlyRootCanvas, self._panel._sSortingLayerName)
    NovaAPI.SetCanvasSortingOrder(self._mapNode.fxFlyRootCanvas, self._nSortingOrder + 2)
    for i = 1, #self._mapNode.EntranceItemTemplate do
      self._mapNode.EntranceItemTemplate[i]:InitSortingOrder(self._nSortingOrder)
    end
    for i = 1, #self._mapNode.UpportingItemTemplate do
      self._mapNode.UpportingItemTemplate[i]:InitSortingOrder(self._nSortingOrder)
    end
    for i = 1, #self._mapNode.WaitingCardItemTemplate do
      self._mapNode.WaitingCardItemTemplate[i]:InitSortingOrder(self._nSortingOrder)
    end
    for i = 1, #self._mapNode.OtherChar do
      self._mapNode.OtherChar[i]:InitSortingOrder(self._nSortingOrder)
    end
  end
end

function SoldierSandtableCtrl:OnBtnClick_Policy()
  if self.bInShopAnim then
    return
  end
  if self:CheckLimitAction() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Sandtable_TemporaryReturn_Tips"))
    return
  end
  self._panel.bReturnFromOverlay = true
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierRecommendPanel, true)
end

function SoldierSandtableCtrl:OnBtnClick_Handbook()
  if self.bInShopAnim then
    return
  end
  if self:CheckLimitAction() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Sandtable_TemporaryReturn_Tips"))
    return
  end
  self._panel.bReturnFromOverlay = true
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierHandbookSelectPanel)
end

function SoldierSandtableCtrl:OnBtnClick_Close()
  if self.bInShopAnim then
    return
  end
  if self:CheckLimitAction() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Sandtable_TemporaryReturn_Tips"))
    return
  end
  local nStage, nNodexIndex = PlayerData.SoldierData:GetCurChallengeState()
  local sStage = tostring(nStage) .. "-" .. tostring(nNodexIndex)
  local sContent = orderedFormat(ConfigTable.GetUIText("Soldier_FinishTips"), sStage)
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sTitle = ConfigTable.GetUIText("Soldier_FinishTitle"),
    sContent = sContent,
    callbackCancel = function()
      PlayerData.SoldierData:SendStepOut(function()
      end)
    end,
    callbackConfirm = function()
      PlayerData.SoldierData:SendGiveUp(function()
      end)
    end,
    bDisableSnap = false,
    sConfirm = ConfigTable.GetUIText("Soldier_SaveAndQuit"),
    sCancel = ConfigTable.GetUIText("Soldier_SaveAndExit"),
    bCloseNoHandler = true
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function SoldierSandtableCtrl:OnBtnClick_Details()
  if self.bInShopAnim then
    return
  end
  if self:CheckLimitAction() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Sandtable_TemporaryReturn_Tips"))
    return
  end
  local nSeasonId = PlayerData.SoldierData:GetCurSelectSeasonId()
  local mapCfg = ConfigTable.GetData("SoldierSeason", nSeasonId)
  if mapCfg ~= nil then
    local nDicId = mapCfg.DictionaryId
    self._panel.bReturnFromOverlay = true
    EventManager.Hit(EventId.OpenPanel, PanelId.DictionaryEntry, nDicId, true)
  end
end

function SoldierSandtableCtrl:OnBtnClick_Shop()
  if self:CheckLimitAction() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Sandtable_TemporaryReturn_Tips"))
    return
  end
  if self._mapNode.SoldierShopComponent:IsShopOpen() then
    self:OpenShop(false)
  else
    self:OpenShop(true)
  end
end

function SoldierSandtableCtrl:OnBtnClick_CloseShop()
  self:OpenShop(false)
end

function SoldierSandtableCtrl:OnBtnClick_GO()
  if self.bInShopAnim then
    return
  end
  if self:CheckLimitAction() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Sandtable_TemporaryReturn_Tips"))
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_Go_unprepare")
    return
  end
  if #self._panel.OtherChessList > 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_OverChessCount_Tips"))
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_Go_unprepare")
    return
  end
  local nCurLevel, nMaxLevel = self.levelData:GetShopLevel()
  local shopCfg = ConfigTable.GetData("SoldierShopLevel", nCurLevel)
  local nMaxCount = shopCfg.Count
  local nCurCount = 0
  for k, v in ipairs(self._panel.MainChessList) do
    if v.nId ~= 0 then
      nCurCount = nCurCount + 1
    end
  end
  if nCurCount == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_NoFightChess_Tips"))
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_Go_unprepare")
    return
  end
  for k, v in ipairs(self._panel.SupportChessList) do
    if v.nId ~= 0 then
      nCurCount = nCurCount + 1
    end
  end
  if nMaxCount < nCurCount then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_OverChessCount_Tips"))
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_Go_unprepare")
    return
  elseif nMaxCount > nCurCount then
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("Soldier_NotEnoughChess_Tips"),
      callbackConfirm = function()
        CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_Go")
        self.levelData:SendFight()
      end,
      bDisableSnap = false,
      bCloseNoHandler = true
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
    return
  else
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_Go")
    self.levelData:SendFight()
  end
end

function SoldierSandtableCtrl:OnBtnClick_NodeLayout()
  self._mapNode.SoldierNodeTips:OpenNodeTips()
end

function SoldierSandtableCtrl:OnBtnClick_Experience()
  if self:CheckLimitAction() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Sandtable_TemporaryReturn_Tips"))
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_buyExperience_poor")
    return
  end
  local nCurLevel, nMaxLevel = self.levelData:GetShopLevel()
  if nCurLevel == nMaxLevel then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_BuyExp_Tips1"))
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_buyExperience_poor")
    return
  else
    local nCost = 0
    local shopData = self.levelData:GetShopData()
    if shopData ~= nil then
      nCost = shopData.nPurchaseExpPrice
    else
      local nCurLevel = self.levelData:GetShopLevel()
      local tbCost = ConfigTable.GetConfigArray("SoldierBuyExp", nCurLevel)
      nCost = tbCost[1]
    end
    local nItemCount = self.levelData:GetItem(AllEnum.CoinItemId.SoldierCurrency)
    if nItemCount < tonumber(nCost) then
      EventManager.Hit("Guide_ExperienceLevelUp_CostNotEnough")
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_BuyExp_Tips2"))
      CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_buyExperience_poor")
      return
    end
  end
  
  local function callback(callbackData)
    self:InitExperience()
    self._mapNode.SoldierShopComponent:RefreshShopData()
    if PlayerData.Guide:CheckInGuideGroup(507) then
      if callbackData.nLevelChange > 0 then
        EventManager.Hit("Guide_ExperienceLevelChange", true)
      else
        EventManager.Hit("Guide_ExperienceLevelChange", false)
      end
    end
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_buyExperience")
    if callbackData.tbChessChangeStep ~= nil and 0 < #callbackData.tbChessChangeStep then
      local tbStep = {}
      for k, v in ipairs(callbackData.tbChessChangeStep) do
        table.insert(tbStep, v)
      end
      self._mapNode.blockInput:SetActive(true)
      self:PlayStepsAnimation(tbStep, function()
        self:InitOtherChessList()
        self:InitChessList()
        self._mapNode.blockInput:SetActive(false)
      end)
    end
  end
  
  self.levelData:SendShopBuyExp(callback)
end

function SoldierSandtableCtrl:OnBtnClick_CoinTips()
  if self:CheckLimitAction() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_Sandtable_TemporaryReturn_Tips"))
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierGoldTips)
end

function SoldierSandtableCtrl:OnBtnClick_GoBackEventPanel()
  EventManager.Hit("SoldierShowBattleEventPanel")
end

function SoldierSandtableCtrl:OnBtnClick_SkillDetail()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierBossTemplateTips, self.levelData:GetBossTemplateId())
end

function SoldierSandtableCtrl:OnEvent_SoldierExpUpdate()
  local nOldChessMaxCount = self.nCacheChessMaxCount
  local nOldLevel = self.nCacheShopLevel
  local nOldExp = self.nCacheExp
  local oldShopCfg = ConfigTable.GetData("SoldierShopLevel", nOldLevel)
  local nOldMaxCount = oldShopCfg.Count
  self:InitExperience()
  self:InitChessCount()
  local expAnimator = self._mapNode.btnExperience.transform:Find("AnimRoot"):GetComponent("Animator")
  local levelUpAnimator = self._mapNode.btnExperience.transform:Find("AnimRoot/FxLevelUp"):GetComponent("Animator")
  if 0 < nOldLevel and nOldLevel ~= self.nCacheShopLevel then
    levelUpAnimator:Play("ExperienceLevelUp_in")
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_ExperienceReward")
    local nCurLevel = self.levelData:GetShopLevel()
    local shopCfg = ConfigTable.GetData("SoldierShopLevel", nCurLevel)
    local nMaxCount = shopCfg.Count
    if nOldMaxCount < nMaxCount then
      self._mapNode.MiddleContainer:Play("LevelUpGrade")
      local nAnimLength = NovaAPI.GetAnimClipLength(self._mapNode.MiddleContainer, {
        "LevelUpGrade"
      })
      local nCurCount = 0
      local tbDeployChess, tbWaitingChess, tbOtherChess = self.levelData:GetDeploy()
      for k, v in ipairs(tbDeployChess) do
        if v.nId ~= 0 then
          nCurCount = nCurCount + 1
        end
      end
      nCurCount = nCurCount + #tbOtherChess
      local tbColor = chessCountColor.LevelUp
      NovaAPI.SetImageColor(self._mapNode.ImageAddCharCount, tbColor.mapColor)
      NovaAPI.SetTMPText(self._mapNode.TextAddCharCount, string.format("<color=#%s>%d/%d</color>", tbColor.sColor, nCurCount, nMaxCount))
      self:AddTimer(1, nAnimLength, function()
        self:InitChessCount()
      end, true, true, true)
    end
  elseif nOldExp ~= self.nCacheExp then
    expAnimator:Play("ExperienceContainer")
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_ExperienceReward")
  end
  if 0 < nOldChessMaxCount and nOldChessMaxCount ~= self.nCacheChessMaxCount then
    self._mapNode.go_overflow_anim:Play("Overflow_in")
  end
end

function SoldierSandtableCtrl:OnEvent_SoldierItemChange(itemChange)
  self:InitCoin()
  for k, v in pairs(itemChange) do
    if k == AllEnum.CoinItemId.SoldierCurrency and 0 < v then
      self._mapNode.fx_shop:Play("ShopFx_in")
    end
  end
  if self._mapNode.SoldierShopComponent:IsShopOpen() then
    self._mapNode.SoldierShopComponent:RefreshShopData()
  end
end

function SoldierSandtableCtrl:OnEvent_SoldierHpChange()
  NovaAPI.SetTMPText(self._mapNode.TextReputation, tostring(self.levelData:GetHp()))
end

function SoldierSandtableCtrl:OnEvent_SoldierEffectChange()
  self:RefreshLimitAction()
  self:InitNodeList()
  self:InitChessList()
  self:InitExperience()
end

function SoldierSandtableCtrl:OnEvent_SoldierShopClose()
  self._mapNode.sandtable_anim:Play("SandtableMiddle_L")
  local btn_shopAnimator = self._mapNode.btnShop.transform:Find("AnimRoot"):GetComponent("Animator")
  btn_shopAnimator:Play("ShopContainer_close")
end

function SoldierSandtableCtrl:OnEvent_SoldierSandtableCharItemDragStart(objInsId)
  CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_selectCard")
  local dragInsType, chessData = self:GetDragInsData(objInsId)
  local nPrice
  if dragInsType == DragInsType.Chess then
    nPrice = self:CalSellPrice(chessData)
    self:RefreshSell(nPrice)
  end
  if self.sellTimer ~= nil then
    self.sellTimer:_Stop()
  end
  self._mapNode.SellAnimation:Play("sellbtn_in")
  if not PlayerData.Guide:CheckInGuideGroup(505) then
    self._mapNode.SaleContainer:SetActive(true)
    if self._mapNode.SoldierShopComponent:IsShopOpen() then
      self._mapNode.SoldierShopComponent:SetSellMode(true, nPrice)
    end
  end
  self:ShowChessCanPutIn(true, chessData)
end

function SoldierSandtableCtrl:OnEvent_SoldierSandtableCharItemDragEnd(nDragInsId, nPointerInsId)
  self:ShowChessCanPutIn(false)
  if nPointerInsId == 0 then
    self:RefreshChessList()
    if self.sellTimer ~= nil then
      self.sellTimer:_Stop()
    end
    self._mapNode.SellAnimation:Play("sellbtn_out")
    self._mapNode.SoldierShopComponent:SetSellMode(false)
    self.sellTimer = self:AddTimer(1, 0.4, function()
      self._mapNode.SaleContainer:SetActive(false)
    end, true, true, true)
    return
  end
  local dragInsType, chessData = self:GetDragInsData(nDragInsId)
  local targetInsType, targetChessData = self:GetDragInsData(nPointerInsId)
  local dragChessData = chessData
  local targetChessData = targetChessData
  if targetInsType == DragInsType.Sell then
    self.levelData:SendShopSell(dragChessData, function(callbackData)
      local ctrl = self:GetCharCtrlByChessData(dragChessData)
      dragChessData.nId = 0
      dragChessData.nStar = 0
      dragChessData.nUid = 0
      self:AddChessData2list(dragChessData, true)
      ctrl:SetData(dragChessData)
      local tbStep = {}
      for k, v in ipairs(callbackData.tbChessChangeStep) do
        if 1 < k then
          table.insert(tbStep, v)
        end
      end
      CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_shop_sell")
      self._mapNode.blockInput:SetActive(true)
      self:PlayStepsAnimation(tbStep, function()
        self:InitOtherChessList()
        self:InitChessList()
        self._mapNode.blockInput:SetActive(false)
      end)
    end)
  elseif targetChessData == nil then
    self:RefreshChessList()
  else
    self:SwapChess(dragChessData, targetChessData)
  end
  if self.sellTimer ~= nil then
    self.sellTimer:_Stop()
  end
  self._mapNode.SellAnimation:Play("sellbtn_out")
  self._mapNode.SoldierShopComponent:SetSellMode(false)
  self.sellTimer = self:AddTimer(1, 0.4, function()
    self._mapNode.SaleContainer:SetActive(false)
  end, true, true, true)
end

function SoldierSandtableCtrl:OnEvent_SoldierSandtableCharItemDragging(nDragInsId, nPointerInsId)
end

function SoldierSandtableCtrl:OnEvent_SoldierSandtableOtherCharItemDragStart(objInsId, chessData)
  local nPrice = self:CalSellPrice(chessData)
  self:RefreshSell(nPrice)
  if self.sellTimer ~= nil then
    self.sellTimer:_Stop()
  end
  self._mapNode.SellAnimation:Play("sellbtn_in")
  self._mapNode.SaleContainer:SetActive(true)
  if self._mapNode.SoldierShopComponent:IsShopOpen() then
    self._mapNode.SoldierShopComponent:SetSellMode(true, nPrice)
  end
end

function SoldierSandtableCtrl:OnEvent_SoldierSandtableOtherCharItemDragEnd(chessData, nPointerInsId)
  local targetInsType, targetChessData = self:GetDragInsData(nPointerInsId)
  if targetInsType == DragInsType.Sell then
    self.levelData:SendShopSell(chessData, function(callbackData)
      local tbStep = {}
      for k, v in ipairs(callbackData.tbChessChangeStep) do
        if 1 < k then
          table.insert(tbStep, v)
        end
      end
      self._mapNode.blockInput:SetActive(true)
      self:PlayStepsAnimation(tbStep, function()
        self:InitOtherChessList()
        self:InitChessList()
        self._mapNode.blockInput:SetActive(false)
      end)
    end)
  else
    self:RefreshChessList()
  end
  if self.sellTimer ~= nil then
    self.sellTimer:_Stop()
  end
  self._mapNode.SellAnimation:Play("sellbtn_out")
  self._mapNode.SoldierShopComponent:SetSellMode(false)
  self.sellTimer = self:AddTimer(1, 0.4, function()
    self._mapNode.SaleContainer:SetActive(false)
  end, true, true, true)
end

function SoldierSandtableCtrl:OnEvent_SoldierCharItemChange(tbChessChangeStep, tr)
  if tbChessChangeStep == nil or #tbChessChangeStep == 0 then
    return
  end
  local tbFx = {}
  local tempData = tbChessChangeStep[1].tbObtain[1]
  local chessData = {
    nId = tempData.nId,
    nStar = tempData.nStar,
    nUid = tempData.nUid,
    nPositionType = tempData.nTargetType,
    nIndex = tempData.nIndex
  }
  local cfg = ConfigTable.GetData("SoldierCharacter", tempData.nId)
  local ctrl = self:GetCharCtrlByChessData(chessData, true)
  local to
  if ctrl == nil then
    to = self._mapNode.OtherCharLsit
  else
    to = ctrl.gameObject.transform
  end
  tbFx[cfg.Rarity] = {}
  table.insert(tbFx[cfg.Rarity], {from = tr, to = to})
  self.bInShopAnim = true
  local nStepLength = #tbChessChangeStep
  if 1 < nStepLength then
    self._mapNode.blockInput:SetActive(true)
  end
  self._mapNode.fxFlyRoot:PlayFx(tbFx, function()
    self:PlayStepsAnimation(tbChessChangeStep, function()
      if 1 < nStepLength then
        self._mapNode.blockInput:SetActive(false)
      end
      self:InitChessCount()
      self:InitPartnerList()
      self:RefreshGoState()
      self.bInShopAnim = false
    end)
  end)
end

function SoldierSandtableCtrl:OnEvent_SoldierBuffCardChange()
  self._mapNode.BuffContainer:RefreshBuff()
end

function SoldierSandtableCtrl:OnEvent_SoldierNodeChange()
  self:RefreshLimitAction()
  NovaAPI.SetTMPText(self._mapNode.TextReputation, tostring(self.levelData:GetHp()))
  self:InitNodeList()
  self._mapNode.BuffContainer:RefreshBuff()
  self:InitExperience()
  self:InitCoin()
  self:InitFightIcon()
  self:InitSellList()
end

function SoldierSandtableCtrl:OnEvent_EnterCardSelect()
  self:RefreshLimitAction()
end

function SoldierSandtableCtrl:OnEvent_EnterEventSelect()
  self:RefreshLimitAction()
end

function SoldierSandtableCtrl:OnEvent_EnterStandTable()
  self:RefreshBossSkill()
  self:OpenShop(false)
  local bSuppressEnterAnim = self.levelData.bSuppressEnterAnim
  self.levelData.bSuppressEnterAnim = false
  
  local function callback()
    local tbPendingReward = self.levelData:GetPendingReward()
    for k, v in ipairs(tbPendingReward) do
      if v.data ~= nil then
        local animaData = {
          nType = animQueueType.NodeReward,
          rewardData = v
        }
        table.insert(self.AnimQueue, animaData)
      end
    end
    if not bSuppressEnterAnim then
      local enterSandtableData = {
        nType = animQueueType.EnterSandtable
      }
      table.insert(self.AnimQueue, enterSandtableData)
      if not self.levelData:IsFirstStageFirstNode() then
        local openShop = {
          nType = animQueueType.OpenShop
        }
        table.insert(self.AnimQueue, openShop)
      end
      if not PlayerData.Guide:CheckGuideFinishById(505) then
        EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_505")
      end
      if not PlayerData.Guide:CheckGuideFinishById(504) then
        EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_504")
      end
    end
    self:CheckAnimQueue()
  end
  
  self:PlaySceneTimeline(callback)
end

function SoldierSandtableCtrl:OnEvent_SoldierSandtableSceneReady()
  if not self.levelData:CheckSandTableDisable() then
    return
  end
  self:ShowSandtable(true)
  self:PlaySceneTimeline()
end

function SoldierSandtableCtrl:OnEvent_ShowSoldierPositionEffect(nPositionIndex)
  self._mapNode.SoldierPosEffectTips:ShowTips(nPositionIndex)
end

function SoldierSandtableCtrl:OnEvent_SoldierSandtableFirstInChessListRefresh()
  self:InitChessListIns()
  self:InitChessList()
end

function SoldierSandtableCtrl:OnEvent_SoldierSandtableRefreshStep(tbSteps)
  if tbSteps == nil then
    return
  end
  local tbStep = {}
  for k, v in ipairs(tbSteps) do
    table.insert(tbStep, v)
  end
  self:PlayStepsAnimation(tbStep, function()
    self:InitOtherChessList()
    self:InitChessList()
  end)
end

function SoldierSandtableCtrl:OnEvent_PurchaseExpPrice()
  local shopData = self.levelData:GetShopData()
  if shopData ~= nil then
    NovaAPI.SetTMPText(self._mapNode.TextCostNum, shopData.nPurchaseExpPrice)
  else
    local nCurLevel = self.levelData:GetShopLevel()
    local tbCost = ConfigTable.GetConfigArray("SoldierBuyExp", nCurLevel)
    NovaAPI.SetTMPText(self._mapNode.TextCostNum, tbCost[1])
  end
end

function SoldierSandtableCtrl:OnEvent_SoldierGMRefresh(tbStepChange)
  self._mapNode.blockInput:SetActive(true)
  self:PlayStepsAnimation(tbStepChange, function()
    self:InitOtherChessList()
    self:InitChessList()
    self:InitChessCount()
    self:InitPartnerList()
    self:RefreshGoState()
    self._mapNode.blockInput:SetActive(false)
  end)
end

function SoldierSandtableCtrl:PrintChessList()
  for k, v in ipairs(self._panel.MainChessList) do
    print("[Soldier]", "MainChessList:", "Id:", v.nId, "star:", v.nStar, "index:", v.nIndex, v.nPositionType)
  end
  for k, v in ipairs(self._panel.SupportChessList) do
    print("[Soldier]", "SupportChessList:", "Id:", v.nId, "star:", v.nStar, "index:", v.nIndex, v.nPositionType)
  end
  for k, v in ipairs(self._panel.WaitingChessList) do
    print("[Soldier]", "WaitingChessList:", "Id", v.nId, "star:", v.nStar, "index:", v.nIndex, v.nPositionType)
  end
  for k, v in ipairs(self._panel.OtherChessList) do
    print("[Soldier]", "OtherChessList:", "Id:", v.nId, "star:", v.nStar)
  end
end

function SoldierSandtableCtrl:OnEvent_CloseDic(panelId)
  if panelId == PanelId.DictionaryEntry and not PlayerData.Guide:CheckGuideFinishById(505) then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_505")
  end
end

return SoldierSandtableCtrl
