local BattlePassCtrl = class("BattlePassCtrl", BaseCtrl)
local nExpBarLength = 560
local nExpBarHeight = 25
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local LocalData = require("GameCore.Data.LocalData")
BattlePassCtrl._mapNodeConfig = {
  rtMainContent = {sComponentName = "Animator"},
  rtCoverRootAnim = {
    sNodeName = "rtCoverRoot",
    sComponentName = "Animator"
  },
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rtBuyLevel = {
    sCtrlName = "Game.UI.BattlePass.BattlePassBuyLevelCtrl"
  },
  rtBuyPremiumBattlepass = {
    sCtrlName = "Game.UI.BattlePass.BattlePassPremiumBuyCtrl"
  },
  rtSkinPopup = {
    sCtrlName = "Game.UI.BattlePass.BattlePassPopupSkinCtrl"
  },
  rtCoverRoot = {sComponentName = "Transform"},
  panelRoot = {
    sNodeName = "rtMainContent",
    sComponentName = "Transform"
  },
  btnLevelDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BuyLevel"
  },
  rt_RewardList = {
    sCtrlName = "Game.UI.BattlePass.BattlePassRewardCtrl"
  },
  rt_QuestList = {
    sCtrlName = "Game.UI.BattlePass.BattlePassQuestCtrl"
  },
  CGReward = {
    sNodeName = "rt_RewardList",
    sComponentName = "CanvasGroup"
  },
  CGQuest = {
    sNodeName = "rt_QuestList",
    sComponentName = "CanvasGroup"
  },
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  TMPLevel = {sComponentName = "TMP_Text"},
  TMPProgress = {sComponentName = "TMP_Text"},
  imgProgressBarFillMask = {
    sComponentName = "RectTransform"
  },
  imgProgressBarFillHighLight = {sComponentName = "Image"},
  btnUnlockVip = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BuyPremium",
    nCount = 2
  },
  txtbtnUnlockVip = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "BattlePassPremiumBuy"
  },
  rtToggleTop = {
    sCtrlName = "Game.UI.TemplateEx.TemplateTogTabCtrl"
  },
  redDotReward = {},
  redDotQuest = {},
  TMPLevelTitleHome = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassLevelTitle"
  },
  TMPProgressTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassLevelProgressTitle"
  },
  txtBtnLevelDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassLevelBuyTitle"
  },
  TMPRewardDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePass_RewardDesc"
  },
  TMPRewardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePass_RewardTitle"
  },
  TMPSeasonTImeTitle = {sComponentName = "TMP_Text"},
  txtBtnRewardDetail = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePass_BtnRewardDetail"
  },
  TMPLevelMax = {
    sComponentName = "TMP_Text",
    sLanguageId = "BattlePassQusetLevelMax"
  },
  btnRewardDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OutfitInfo"
  },
  imgDiscCover = {sComponentName = "Image", nCount = 2},
  imgCoverDiscRare = {sComponentName = "Image", nCount = 2}
}
BattlePassCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  BattlePassQuestReceive = "OnEvent_BattlePassQuestReceive",
  UpdateBattlePassReward = "OnEvent_UpdateBattlePassReward",
  BattlePassBuyLevel = "OnEvent_BattlePassBuyLevel",
  BattlePassPremiumSuccess = "OnEvent_BattlePassPremiumSuccess",
  BattlePassLevelUpPanelClose = "OnEvent_LevelUpPanelClose",
  BattlePassOpenDiscInfo = "OnBtnClick_OutfitInfo",
  BattlePassNeedRefresh = "OnEvent_BattlePassNeedRefresh"
}
BattlePassCtrl._mapRedDotConfig = {
  [RedDotDefine.BattlePass_Reward] = {
    sNodeName = "redDotReward"
  },
  [RedDotDefine.BattlePass_Quest] = {
    sNodeName = "redDotQuest"
  }
}

function BattlePassCtrl:Awake()
  self.curShowDiscIdx = 1
end

function BattlePassCtrl:FadeIn()
end

function BattlePassCtrl:FadeOut()
end

function BattlePassCtrl:OnEnable()
  self.nAnimState = 1
  self._mapNode.rtCoverRootAnim:Play("rtCoverRoot_switch1_loop")
  NovaAPI.SetImageColor(self._mapNode.imgProgressBarFillHighLight, Color(1, 1, 1, 0))
  self._mapNode.panelRoot.gameObject:SetActive(false)
  
  local function callback(mapData)
    if self.gameObject == nil then
      return
    end
    self.mapBattlePassInfo = mapData
    self._mapNode.panelRoot.gameObject:SetActive(true)
    local bHasComplete, nQuestIdx, bQuestAllComplete, bFullLevel = self:Refresh()
    local bHasRewardReceive = self._mapNode.rt_RewardList.bAllReceive
    EventManager.Hit(EventId.SetTransition)
    self._mapNode.rtMainContent:Play("BattlePassPanel_in")
    self._mapNode.rt_RewardList:PlayInAnim()
    self._mapNode.rtCoverRoot.localScale = Vector3.one
    local mapBattlePassCfgData = ConfigTable.GetData("BattlePass", self.mapBattlePassInfo.nSeasonId)
    if mapBattlePassCfgData ~= nil then
      local sSeasonId = LocalData.GetPlayerLocalData("BattlePass_ShowPopUp")
      local nLocalSeasonId = tonumber(sSeasonId)
      if nLocalSeasonId == nil or nLocalSeasonId ~= self.mapBattlePassInfo.nSeasonId then
        local function waitTransion()
          self._mapNode.rtSkinPopup:ShowPanel(mapBattlePassCfgData)
          
          LocalData.SetPlayerLocalData("BattlePass_ShowPopUp", self.mapBattlePassInfo.nSeasonId)
        end
        
        self:AddTimer(1, 0.4, waitTransion, true, true, true)
      end
    end
    if nQuestIdx ~= 0 then
      self._mapNode.rt_QuestList:SetToggle(nQuestIdx)
    end
    if not (not bHasRewardReceive or bHasComplete) or bFullLevel or self._panel.tog == 1 then
      self.curTog = 1
      self._mapNode.rtToggleTop:SetState(false)
      NovaAPI.SetCanvasGroupAlpha(self._mapNode.CGReward, 1)
      NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.CGReward, true)
      NovaAPI.SetCanvasGroupAlpha(self._mapNode.CGQuest, 0)
      NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.CGQuest, false)
    else
      self.curTog = 2
      self._panel.tog = 2
      self._mapNode.rtToggleTop:SetState(true)
      NovaAPI.SetCanvasGroupAlpha(self._mapNode.CGReward, 0)
      NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.CGReward, false)
      NovaAPI.SetCanvasGroupAlpha(self._mapNode.CGQuest, 1)
      NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.CGQuest, true)
    end
    self._mapNode.rt_RewardList:SetLevelPos()
    if self._panel.bOpenPremium then
      self:OnBtnClick_BuyPremium()
    else
      self._mapNode.rtBuyPremiumBattlepass.gameObject:SetActive(false)
    end
  end
  
  PlayerData.BattlePass:GetBattlePassInfo(callback)
  self._mapNode.rtToggleTop:SetText(ConfigTable.GetUIText("BattlePassTogQuest"), ConfigTable.GetUIText("BattlePassTogReward"))
  self.tbShowRewardIdx = {}
  self.timerShowDisc = self:AddTimer(0, 5, self.SwitchShowDiscAnim, true, true, true)
end

function BattlePassCtrl:OnDisable()
end

function BattlePassCtrl:OnDestroy()
end

function BattlePassCtrl:OnRelease()
end

function BattlePassCtrl:Refresh()
  self.tbDisc = {}
  local mapBattlePassCfgData = ConfigTable.GetData("BattlePass", self.mapBattlePassInfo.nSeasonId)
  if mapBattlePassCfgData == nil then
    printError("BattlePassCfgData missing:" .. self.mapBattlePassInfo.nSeasonId)
    return false, 0
  end
  local sTimeStr = PlayerData.BattlePass:GetRefreshTime()
  NovaAPI.SetTMPText(self._mapNode.TMPSeasonTImeTitle, orderedFormat(ConfigTable.GetUIText("BattlePass_RemainTimeTitle") or "", sTimeStr))
  if mapBattlePassCfgData ~= nil then
    local nPackageId = mapBattlePassCfgData.OutfitPackageShowItem
    local mapItemCfgData = ConfigTable.GetData_Item(nPackageId)
    if not mapItemCfgData then
      return false, 0
    end
    local mapItemUseCfg = decodeJson(mapItemCfgData.UseArgs)
    for sTid, nCount in pairs(mapItemUseCfg) do
      local nItemTid = tonumber(sTid)
      if nItemTid ~= nil then
        local mapDisc = PlayerData.Disc:GenerateLocalDiscData(nItemTid)
        table.insert(self.tbDisc, mapDisc)
      end
    end
    
    local function sort(a, b)
      return a.nRarity < b.nRarity or a.nRarity == b.nRarity and a.nEET < b.nEET or a.nRarity == b.nRarity and a.nEET == b.nEET and a.nId < b.nId
    end
    
    table.sort(self.tbDisc, sort)
  end
  NovaAPI.SetTMPText(self._mapNode.TMPLevel, self.mapBattlePassInfo.nLevel)
  local bFullLevel = false
  if ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false) == nil then
    bFullLevel = true
    self._mapNode.TMPProgress.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.TMPProgress, string.format("%d/%d", self.mapBattlePassInfo.nExp, self.mapBattlePassInfo.nExp))
    self._mapNode.imgProgressBarFillMask.sizeDelta = Vector2(nExpBarLength, nExpBarHeight)
    self._mapNode.btnLevelDetail.gameObject:SetActive(false)
    self._mapNode.TMPLevelMax.gameObject:SetActive(true)
  else
    self._mapNode.TMPProgress.gameObject:SetActive(true)
    local nExp = ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false).Exp
    NovaAPI.SetTMPText(self._mapNode.TMPProgress, string.format("%d/%d", self.mapBattlePassInfo.nExp, nExp))
    self._mapNode.imgProgressBarFillMask.sizeDelta = Vector2(nExpBarLength * self.mapBattlePassInfo.nExp / nExp, nExpBarHeight)
    self._mapNode.btnLevelDetail.gameObject:SetActive(true)
    self._mapNode.TMPLevelMax.gameObject:SetActive(false)
  end
  if self.tbDisc ~= nil and #self.tbDisc > 0 then
    self._mapNode.rtCoverRoot.localScale = Vector3.one
    local mapItemCfgData = ConfigTable.GetData_Item(self.tbDisc[self.curShowDiscIdx].nId)
    if mapItemCfgData ~= nil then
      self:SetPngSprite(self._mapNode.imgDiscCover[self.nAnimState], mapItemCfgData.Icon)
      self:SetPngSprite(self._mapNode.imgCoverDiscRare[self.curShowDiscIdx], "UI/big_sprites/rare_scenery_" .. AllEnum.FrameColor[mapItemCfgData.Rarity])
    end
  else
    self._mapNode.rtCoverRoot.localScale = Vector3.zero
  end
  local bHasComplete, nQuestIdx, bQuestAllComplete = self._mapNode.rt_QuestList:Refresh(self.mapBattlePassInfo.nExpThisWeek, self.mapBattlePassInfo.nLevel, true)
  self._mapNode.rt_RewardList:Refresh(self.mapBattlePassInfo.tbReward, 0 < self.mapBattlePassInfo.nCurMode, self.mapBattlePassInfo.nLevel)
  return bHasComplete and not bFullLevel, nQuestIdx, bQuestAllComplete, bFullLevel
end

function BattlePassCtrl:SwitchShowDiscAnim()
  if self.tbDisc ~= nil and #self.tbDisc > 0 then
    self.curShowDiscIdx = self.curShowDiscIdx % #self.tbDisc + 1
    self.nAnimState = self.nAnimState % 2 + 1
    local mapItemCfgData = ConfigTable.GetData_Item(self.tbDisc[self.curShowDiscIdx].nId)
    if mapItemCfgData ~= nil then
      self:SetPngSprite(self._mapNode.imgDiscCover[self.nAnimState], mapItemCfgData.Icon)
      self:SetPngSprite(self._mapNode.imgCoverDiscRare[self.nAnimState], "UI/big_sprites/rare_scenery_" .. AllEnum.FrameColor[mapItemCfgData.Rarity])
    end
    local sAnimName = "rtCoverRoot_switch" .. self.nAnimState
    self._mapNode.rtCoverRootAnim:Play(sAnimName)
  end
end

function BattlePassCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self._panel.bOpenPremium then
    self._mapNode.rtBuyPremiumBattlepass:ClosePanel()
    self._mapNode.panelRoot.gameObject:SetActive(true)
    self._panel.bOpenPremium = false
    self:OnEvent_LevelUpPanelClose()
    self._mapNode.rtMainContent:Play("BattlePassPanel_in1")
    self._mapNode.rtCoverRoot.localScale = Vector3.one
    self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetData("TopBar", "BattlePass").Title)
  else
    self._panel.tog = 1
    self._panel.questTab = 1
    EventManager.Hit(EventId.CloesCurPanel)
  end
end

function BattlePassCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self._panel.tog = 1
  self._panel.questTab = 1
  PanelManager.Home()
end

function BattlePassCtrl:OnBtnClick_Reward()
  self._panel.tog = 1
  if self.curTog == 1 then
    return
  end
  self.curTog = 1
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.CGReward, 1)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.CGReward, true)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.CGQuest, 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.CGQuest, false)
  self._mapNode.rtToggleTop:SetState(false)
  if #self.tbShowRewardIdx ~= 0 then
    self._mapNode.rt_RewardList:PlayUnlockAnim(self.tbShowRewardIdx)
    self.tbShowRewardIdx = {}
  end
end

function BattlePassCtrl:OnBtnClick_Quest()
  self._panel.tog = 2
  if self.curTog == 2 then
    return
  end
  self.curTog = 2
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.CGReward, 0)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.CGReward, false)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.CGQuest, 1)
  NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.CGQuest, true)
  self._mapNode.rtToggleTop:SetState(true)
  self._mapNode.rt_QuestList:PlayListInAnim()
end

function BattlePassCtrl:OnBtnClick_BuyLevel()
  self._mapNode.rtBuyLevel:ShowPanel(self.mapBattlePassInfo.nLevel, self.mapBattlePassInfo.tbReward, self.mapBattlePassInfo.nSeasonId, self.mapBattlePassInfo.nCurMode > 0)
end

function BattlePassCtrl:OnBtnClick_BuyPremium()
  self._mapNode.TopBar:SetTitleTxt(ConfigTable.GetUIText("BattlePassPremiumBuy"))
  self._mapNode.rtBuyPremiumBattlepass:OpenPanel(self.mapBattlePassInfo.nCurMode, self.mapBattlePassInfo.nSeasonId, self.mapBattlePassInfo.nVersion)
  self._mapNode.panelRoot.gameObject:SetActive(false)
  self._mapNode.rtCoverRoot.localScale = Vector3.zero
  self._panel.bOpenPremium = true
end

function BattlePassCtrl:OnBtnClick_OutfitInfo()
  local mapBattlePassCfgData = ConfigTable.GetData("BattlePass", self.mapBattlePassInfo.nSeasonId)
  if mapBattlePassCfgData == nil then
    return
  end
  local nPackageId = mapBattlePassCfgData.OutfitPackageShowItem
  EventManager.Hit(EventId.OpenPanel, PanelId.DiscPreview, nPackageId, true)
end

function BattlePassCtrl:OnBtnClick_ButtonTest1()
  local function callback()
  end
  
  local mapBefore = {
    nLevel = 0,
    nExp = 0,
    nMaxLevel = 60,
    nMaxExp = 1000
  }
  local mapAfter = {
    nLevel = 0,
    nExp = 900,
    nMaxLevel = 60,
    nMaxExp = 1000
  }
  self:ExpBarAnim(mapBefore, mapAfter, callback, self._mapNode.TMPLevel)
end

function BattlePassCtrl:OnBtnClick_ButtonTest2()
  local function callback()
  end
  
  local mapBefore = {
    nLevel = 0,
    nExp = 0,
    nMaxLevel = 60,
    nMaxExp = 1000
  }
  local mapAfter = {
    nLevel = 5,
    nExp = 900,
    nMaxLevel = 60,
    nMaxExp = 1000
  }
  self:ExpBarAnim(mapBefore, mapAfter, callback, self._mapNode.TMPLevel)
end

function BattlePassCtrl:OnEvent_BattlePassQuestReceive()
  local beforeLevel = self.mapBattlePassInfo.nLevel
  local beforeExp = self.mapBattlePassInfo.nExp
  local mapBefore = {
    nLevel = beforeLevel,
    nExp = beforeExp,
    nMaxLevel = -1,
    nMaxExp = 1
  }
  if ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false) ~= nil then
    mapBefore.nMaxExp = ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false).Exp
  end
  
  local function callback(mapData)
    self.mapBattlePassInfo = mapData
    local afterLevel = self.mapBattlePassInfo.nLevel
    local afterExp = self.mapBattlePassInfo.nExp
    local mapAfter = {
      nLevel = afterLevel,
      nExp = afterExp,
      nMaxLevel = -1,
      nMaxExp = 0
    }
    if ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false) == nil then
      mapAfter.nExp = 1
      mapAfter.nMaxExp = 1
      mapAfter.nMaxLevel = afterLevel
    else
      mapAfter.nMaxExp = ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false).Exp
    end
    
    local function animCallback()
      if beforeLevel ~= afterLevel then
        local mapLevelData = {
          nOldLevel = beforeLevel,
          nOldExp = beforeExp,
          nLevel = afterLevel,
          nExp = afterExp
        }
        
        local function callabck()
          EventManager.Hit("BattlePassLevelUpPanelClose")
        end
        
        EventManager.Hit(EventId.OpenPanel, PanelId.BattlePassUpgrade, callabck, mapLevelData)
      end
      NovaAPI.SetTMPText(self._mapNode.TMPLevel, self.mapBattlePassInfo.nLevel)
      if ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false) == nil then
        self._mapNode.TMPProgress.gameObject:SetActive(false)
        NovaAPI.SetTMPText(self._mapNode.TMPProgress, string.format("%d/%d", self.mapBattlePassInfo.nExp, self.mapBattlePassInfo.nExp))
        self._mapNode.imgProgressBarFillMask.sizeDelta = Vector2(nExpBarLength, nExpBarHeight)
        self._mapNode.btnLevelDetail.gameObject:SetActive(false)
        self._mapNode.TMPLevelMax.gameObject:SetActive(true)
      else
        self._mapNode.TMPProgress.gameObject:SetActive(true)
        local nExp = ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false).Exp
        NovaAPI.SetTMPText(self._mapNode.TMPProgress, string.format("%d/%d", self.mapBattlePassInfo.nExp, nExp))
        self._mapNode.imgProgressBarFillMask.sizeDelta = Vector2(nExpBarLength * self.mapBattlePassInfo.nExp / nExp, nExpBarHeight)
        self._mapNode.btnLevelDetail.gameObject:SetActive(true)
        self._mapNode.TMPLevelMax.gameObject:SetActive(false)
      end
      if beforeLevel ~= self.mapBattlePassInfo.nLevel then
        self.tbShowRewardIdx = {}
        for i = beforeLevel + 1, self.mapBattlePassInfo.nLevel do
          if #self.tbShowRewardIdx < 5 then
            table.insert(self.tbShowRewardIdx, i)
          end
        end
        self._mapNode.rt_RewardList:Refresh(self.mapBattlePassInfo.tbReward, self.mapBattlePassInfo.nCurMode > 0, self.mapBattlePassInfo.nLevel)
        self._mapNode.rt_QuestList:Refresh(self.mapBattlePassInfo.nExpThisWeek, self.mapBattlePassInfo.nLevel)
      end
    end
    
    self:ExpBarAnim(mapBefore, mapAfter, animCallback, self._mapNode.TMPLevel)
  end
  
  PlayerData.BattlePass:GetBattlePassInfo(callback)
end

function BattlePassCtrl:ExpBarAnim(mapBefore, mapAfter, callback, txt)
  local bMaxLv = mapAfter.nLevel == mapAfter.nMaxLevel
  local nAddLevel = mapAfter.nLevel - mapBefore.nLevel
  local nAddCount = 0
  if nAddLevel == 0 then
    nAddCount = 1
  elseif 0 < mapAfter.nExp then
    nAddCount = nAddLevel + 1
  else
    nAddCount = nAddLevel
  end
  local nAniTime = 0.4
  if nAddCount < 6 then
    nAniTime = 0.4
  elseif 6 <= nAddCount then
    nAniTime = 0.2
  end
  local nBeforeToMaxTime = nAniTime * (1 - mapBefore.nExp / mapBefore.nMaxExp)
  local nBeforeToAfterTime = nAniTime * ((mapAfter.nExp - mapBefore.nExp) / mapAfter.nMaxExp)
  local nZeroToAfterTime = nAniTime * mapAfter.nExp / mapAfter.nMaxExp
  local nAllTime = 0
  local sequence = DOTween.Sequence()
  for i = 1, nAddCount - 1 do
    local nTime = i == 1 and nBeforeToMaxTime or nAniTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(self._mapNode.imgProgressBarFillMask:DOSizeDelta(Vector2(nExpBarLength, nExpBarHeight), nTime))
    sequence:AppendCallback(function()
      self._mapNode.imgProgressBarFillMask.sizeDelta = Vector2(0, nExpBarHeight)
      NovaAPI.SetTMPText(txt, mapBefore.nLevel + i)
    end)
  end
  if bMaxLv then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(self._mapNode.imgProgressBarFillMask:DOSizeDelta(Vector2(nExpBarLength, nExpBarHeight), nTime))
  elseif mapAfter.nExp > 0 then
    local nTime = 1 < nAddCount and nZeroToAfterTime or nBeforeToAfterTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(self._mapNode.imgProgressBarFillMask:DOSizeDelta(Vector2(mapAfter.nExp / mapAfter.nMaxExp * nExpBarLength, nExpBarHeight), nTime))
  elseif mapAfter.nExp == 0 then
    local nTime = 1 < nAddCount and nAniTime or nBeforeToMaxTime
    nAllTime = nAllTime + nTime
    sequence:AppendCallback(function()
      WwiseAudioMgr:PlaySound("ui_common_levelUp")
    end)
    sequence:Append(self._mapNode.imgProgressBarFillMask:DOSizeDelta(Vector2(nExpBarLength, nExpBarHeight), nTime))
    sequence:AppendCallback(function()
      self._mapNode.imgProgressBarFillMask.sizeDelta = Vector2(0, nExpBarHeight)
    end)
  end
  NovaAPI.SetImageColor(self._mapNode.imgProgressBarFillHighLight, Color(1, 1, 1, 1))
  local tweener = NovaAPI.ImageDoFade(self._mapNode.imgProgressBarFillHighLight, 0, nAllTime * 0.5)
  tweener:SetDelay(nAllTime * 0.5)
  sequence:SetUpdate(true)
  
  local function _cb()
    if callback then
      callback()
    end
    NovaAPI.SetTMPText(txt, mapAfter.nLevel)
  end
  
  sequence.onComplete = dotween_callback_handler(self, _cb)
  EventManager.Hit(EventId.TemporaryBlockInput, nAllTime)
end

function BattlePassCtrl:OnEvent_UpdateBattlePassReward(mapData)
  local mapReward = PlayerData.Item:ProcessRewardChangeInfo(mapData)
  
  local function rewardCallback()
    local tbSelectedItem = {}
    for _, mapItemData in ipairs(mapReward.tbReward) do
      local mapItemCfgData = ConfigTable.GetData_Item(mapItemData.id)
      if mapItemCfgData == nil then
        return
      end
      if mapItemCfgData.Stype == GameEnum.itemStype.OutfitCYO then
        table.insert(tbSelectedItem, mapItemData.id)
      end
    end
    if 0 < #tbSelectedItem then
      EventManager.Hit(EventId.OpenPanel, PanelId.Consumable, tbSelectedItem)
    end
  end
  
  UTILS.OpenReceiveByReward(mapReward, rewardCallback)
  
  local function callback(mapBattlePassData)
    self.mapBattlePassInfo = mapBattlePassData
    self._mapNode.rt_RewardList:Refresh(self.mapBattlePassInfo.tbReward, self.mapBattlePassInfo.nCurMode > 0, self.mapBattlePassInfo.nLevel)
  end
  
  PlayerData.BattlePass:GetBattlePassInfo(callback)
end

function BattlePassCtrl:OnEvent_BattlePassBuyLevel()
  local beforeLevel = self.mapBattlePassInfo.nLevel
  local beforeExp = self.mapBattlePassInfo.nExp
  local mapBefore = {
    nLevel = beforeLevel,
    nExp = beforeExp,
    nMaxLevel = -1,
    nMaxExp = 1
  }
  
  local function callback(mapData)
    if not self or not self.gameObject then
      return
    end
    self.mapBattlePassInfo = mapData
    local afterLevel = self.mapBattlePassInfo.nLevel
    local afterExp = self.mapBattlePassInfo.nExp
    local mapAfter = {
      nLevel = afterLevel,
      nExp = afterExp,
      nMaxLevel = -1,
      nMaxExp = 1
    }
    if ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false) ~= nil then
      mapAfter.nMaxExp = ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false).Exp
      mapBefore.nMaxExp = ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false).Exp
    else
      mapAfter.nExp = 1
      mapAfter.nMaxExp = 1
      mapAfter.nMaxLevel = afterLevel
    end
    
    local function animCallback()
      self.mapBattlePassInfo = mapData
      NovaAPI.SetTMPText(self._mapNode.TMPLevel, self.mapBattlePassInfo.nLevel)
      if ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false) == nil then
        self._mapNode.TMPProgress.gameObject:SetActive(false)
        NovaAPI.SetTMPText(self._mapNode.TMPProgress, string.format("%d/%d", self.mapBattlePassInfo.nExp, self.mapBattlePassInfo.nExp))
        self._mapNode.imgProgressBarFillMask.sizeDelta = Vector2(nExpBarLength, nExpBarHeight)
        self._mapNode.btnLevelDetail.gameObject:SetActive(false)
        self._mapNode.TMPLevelMax.gameObject:SetActive(true)
      else
        self._mapNode.TMPProgress.gameObject:SetActive(true)
        local nExp = ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false).Exp
        NovaAPI.SetTMPText(self._mapNode.TMPProgress, string.format("%d/%d", self.mapBattlePassInfo.nExp, nExp))
        self._mapNode.imgProgressBarFillMask.sizeDelta = Vector2(nExpBarLength * self.mapBattlePassInfo.nExp / nExp, nExpBarHeight)
        self._mapNode.btnLevelDetail.gameObject:SetActive(true)
        self._mapNode.TMPLevelMax.gameObject:SetActive(false)
      end
      if beforeLevel ~= self.mapBattlePassInfo.nLevel then
        self.tbShowRewardIdx = {}
        for i = beforeLevel + 1, self.mapBattlePassInfo.nLevel do
          if #self.tbShowRewardIdx < 5 then
            table.insert(self.tbShowRewardIdx, i)
          end
        end
        self._mapNode.rt_RewardList:Refresh(self.mapBattlePassInfo.tbReward, self.mapBattlePassInfo.nCurMode > 0, self.mapBattlePassInfo.nLevel)
        self._mapNode.rt_QuestList:Refresh(self.mapBattlePassInfo.nExpThisWeek, self.mapBattlePassInfo.nLevel)
      end
    end
    
    animCallback()
  end
  
  PlayerData.BattlePass:GetBattlePassInfo(callback)
end

function BattlePassCtrl:OnEvent_BattlePassPremiumSuccess()
  local beforeLevel = self.mapBattlePassInfo.nLevel
  
  local function callback(mapData)
    self.mapBattlePassInfo = mapData
    NovaAPI.SetTMPText(self._mapNode.TMPLevel, self.mapBattlePassInfo.nLevel)
    if ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false) == nil then
      self._mapNode.TMPProgress.gameObject:SetActive(false)
      NovaAPI.SetTMPText(self._mapNode.TMPProgress, string.format("%d/%d", self.mapBattlePassInfo.nExp, self.mapBattlePassInfo.nExp))
      self._mapNode.imgProgressBarFillMask.sizeDelta = Vector2(nExpBarLength, nExpBarHeight)
      self._mapNode.btnLevelDetail.gameObject:SetActive(false)
      self._mapNode.TMPLevelMax.gameObject:SetActive(true)
    else
      self._mapNode.TMPProgress.gameObject:SetActive(true)
      local nExp = ConfigTable.GetData("BattlePassLevel", self.mapBattlePassInfo.nLevel + 1, false).Exp
      NovaAPI.SetTMPText(self._mapNode.TMPProgress, string.format("%d/%d", self.mapBattlePassInfo.nExp, nExp))
      self._mapNode.imgProgressBarFillMask.sizeDelta = Vector2(nExpBarLength * self.mapBattlePassInfo.nExp / nExp, nExpBarHeight)
      self._mapNode.btnLevelDetail.gameObject:SetActive(true)
      self._mapNode.TMPLevelMax.gameObject:SetActive(false)
    end
    self._mapNode.rt_RewardList:Refresh(self.mapBattlePassInfo.tbReward, self.mapBattlePassInfo.nCurMode > 0, self.mapBattlePassInfo.nLevel)
    self._mapNode.rt_QuestList:Refresh(self.mapBattlePassInfo.nExpThisWeek, self.mapBattlePassInfo.nLevel)
    if self._panel.bOpenPremium then
      self.tbShowRewardIdx = {}
      if beforeLevel ~= self.mapBattlePassInfo.nLevel then
        for i = beforeLevel + 1, self.mapBattlePassInfo.nLevel do
          if #self.tbShowRewardIdx < 5 then
            table.insert(self.tbShowRewardIdx, i)
          end
        end
      else
        for i = 1, 5 do
          table.insert(self.tbShowRewardIdx, i)
        end
      end
      self._mapNode.rtBuyPremiumBattlepass:Refresh(self.mapBattlePassInfo.nCurMode, self.mapBattlePassInfo.nSeasonId, self.mapBattlePassInfo.nVersion)
    end
  end
  
  PlayerData.BattlePass:GetBattlePassInfo(callback)
end

function BattlePassCtrl:OnEvent_LevelUpPanelClose()
  if #self.tbShowRewardIdx ~= 0 and self.curTog == 1 then
    self._mapNode.rt_RewardList:PlayUnlockAnim(self.tbShowRewardIdx)
    self.tbShowRewardIdx = {}
  end
end

function BattlePassCtrl:OnEvent_BattlePassNeedRefresh()
  EventManager.Hit(EventId.CloesCurPanel)
end

return BattlePassCtrl
