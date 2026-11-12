local SoldierEventCtrl = class("SoldierEventCtrl", BaseCtrl)
local SELECT_CARD_TYPE_STRATEGY = 2
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
SoldierEventCtrl._mapNodeConfig = {
  blur = {sNodeName = "blurBg"},
  imgMaskMain = {},
  TopBar = {
    sNodeName = "TopBarPanel"
  },
  txtTitle1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Event_Title"
  },
  mainRoot = {
    sNodeName = "----SafeAreaRoot----"
  },
  btnReturn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Return"
  },
  txtBtnBack = {
    sComponentName = "TMP_Text",
    sLanguageId = "SoldierBattleEvent_Back"
  },
  txtHpCount = {sComponentName = "TMP_Text"},
  txtCoinCount = {sComponentName = "TMP_Text"},
  txtEventDesc = {sComponentName = "TMP_Text"},
  imgOptionChar = {sComponentName = "Image"},
  animRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  btnChoose = {
    nCount = 3,
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Choose"
  },
  imgBgDisable = {nCount = 3},
  txtLock = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BattleEvent_Lock"
  },
  imgChaos = {nCount = 3, sComponentName = "Image"},
  TMPChoose = {nCount = 3, sComponentName = "TMP_Text"},
  TMPFunc = {nCount = 3, sComponentName = "TMP_Text"},
  imgFunc = {nCount = 3},
  imgBgEnable = {nCount = 3, sComponentName = "Image"},
  goReward1_ = {nCount = 2},
  goReward2_ = {nCount = 2},
  goReward3_ = {nCount = 2},
  imgTriggerCg1 = {sComponentName = "Image"},
  imgTriggerCg2 = {sComponentName = "Image"},
  ImageLine1 = {},
  ImageLine2 = {},
  ImageLine3 = {},
  goBossInfo = {},
  txtPersonality1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Personality_Intuition"
  },
  txtPersonality2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Personality_Analyze"
  },
  txtPersonality3 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Personality_Chaos"
  },
  imgPersonalityPercent = {nCount = 3, sComponentName = "Image"},
  imgCharHead = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text"},
  rtCharEvent = {},
  imgEventChar = {sComponentName = "Image"},
  txtEventStory = {sComponentName = "TMP_Text"},
  txtStoryTitle = {sComponentName = "TMP_Text"},
  TMP_Click = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_BattleEvent_Click"
  },
  btnCloseStory = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseStory"
  },
  rtTriggerEvent = {},
  imgTriggerCg = {sComponentName = "Image"},
  txtCgTitle = {sComponentName = "TMP_Text"},
  txtCgStory = {sComponentName = "TMP_Text"},
  btnCloseCg = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseCg"
  }
}
SoldierEventCtrl._mapEventConfig = {
  SoldierShowBattleEventPanel = "OnEvent_ShowBattleEventPanel",
  RefreshStoryEventOfCostly = "OnEvent_RefreshStoryEventOfCostly",
  EnterEventSelect = "OnEvent_EnterEventSelect",
  RefreshSoldierRes = "OnEvent_RefreshSoldierRes",
  SoldierHpChange = "OnEvent_RefreshSoldierRes"
}
SoldierEventCtrl._mapRedDotConfig = {}

function SoldierEventCtrl:Awake()
  self.bSkipEvent = false
  self.levelData = nil
  self.mapCurEventData = nil
  self.nBossTemplateId = 0
  self._bPanelHidden = false
  self._bOpeningStoryClosed = false
  self._nStoryNodeId = nil
  self._mapRenderedEventData = nil
  self.bPrevMainRootVisible = true
  self.bPrevBlurVisible = self._mapNode.blur.gameObject.activeSelf
  self.bPrevImgMaskMainVisible = self._mapNode.imgMaskMain.gameObject.activeSelf
  local tbParams = self:GetPanelParam()
  if tbParams ~= nil and 0 < #tbParams then
    self.bSkipEvent = tbParams[1] or false
  end
end

function SoldierEventCtrl:OnEnable()
  if self.bSkipEvent then
    self.bSkipEvent = false
    return
  end
  self:RefreshEvent(true)
end

function SoldierEventCtrl:RefreshEvent(bForce)
  local objLevelData = PlayerData.SoldierData:GetCurLevelData()
  local mapEventData = objLevelData and objLevelData:GetStoryEventData()
  local nNodeId = objLevelData and objLevelData:GetNodeId()
  local bNewStory = self.levelData ~= objLevelData or self._nStoryNodeId ~= nNodeId or self.mapCurEventData == nil or mapEventData ~= nil and self.mapCurEventData.nPersonalityStoryId ~= mapEventData.nPersonalityStoryId
  self.levelData = objLevelData
  self.mapCurEventData = mapEventData
  self.nBossTemplateId = objLevelData and objLevelData:GetBossTemplateId() or 0
  self._nStoryNodeId = nNodeId
  if mapEventData == nil then
    self._mapRenderedEventData = nil
    self:RefreshEventOptions()
    return false
  end
  if bNewStory then
    self._bOpeningStoryClosed = 0 < (mapEventData.nPreOptionId or 0)
  end
  if bForce or self._mapRenderedEventData ~= mapEventData then
    self:RefreshCoinCount()
    self:RefreshBossTemplate()
    self:RefreshStoryContent()
    self:RefreshEventOptions()
    self._mapRenderedEventData = mapEventData
  end
  return (mapEventData.nIndex or 0) == 0
end

function SoldierEventCtrl:OnDisable()
  if self.tbBtns ~= nil then
    for _, btn in pairs(self.tbBtns) do
      btn.onClick:RemoveAllListeners()
    end
  end
  self.tbBtns = nil
  if self.tbItemCtrl ~= nil then
    for _, ctrl in pairs(self.tbItemCtrl) do
      self:UnbindCtrlByNode(ctrl)
    end
  end
  self.tbItemCtrl = nil
end

function SoldierEventCtrl:RefreshCoinCount()
  local nCoin = self.levelData:GetItem(AllEnum.CoinItemId.SoldierCurrency)
  NovaAPI.SetTMPText(self._mapNode.txtCoinCount, nCoin)
  local nHp = self.levelData:GetHp()
  NovaAPI.SetTMPText(self._mapNode.txtHpCount, nHp)
end

function SoldierEventCtrl:RefreshStoryContent()
  if self.mapCurEventData == nil then
    return
  end
  local nEventId = self.mapCurEventData.nPersonalityStoryId or 0
  self.nPreOptionId = self.mapCurEventData.nPreOptionId or 0
  local mapEventData = ConfigTable.GetData("SoldierEventPersonalityStory", nEventId)
  if mapEventData == nil then
    return
  end
  local nStoryTypeId = mapEventData.StoryTypeId or 0
  local mapStoryTypeData = ConfigTable.GetData("SoldierStoryType", nStoryTypeId)
  if mapStoryTypeData == nil then
    return
  end
  self._mapNode.imgTriggerCg1.gameObject:SetActive(false)
  self._mapNode.imgTriggerCg2.gameObject:SetActive(false)
  self._mapNode.ImageLine1.gameObject:SetActive(false)
  self._mapNode.ImageLine2.gameObject:SetActive(false)
  self._mapNode.ImageLine3.gameObject:SetActive(false)
  local bCG = mapStoryTypeData.BossCG ~= nil and mapStoryTypeData.BossCG ~= "" or mapStoryTypeData.AvgElement ~= nil and mapStoryTypeData.AvgElement ~= ""
  if bCG then
    local sCG = ""
    if mapStoryTypeData.BossCG ~= nil and mapStoryTypeData.BossCG ~= "" then
      sCG = mapStoryTypeData.BossCG
    elseif mapStoryTypeData.AvgElement ~= nil and mapStoryTypeData.AvgElement ~= "" then
      sCG = mapStoryTypeData.AvgElement
    end
    if mapStoryTypeData.IsBossCG == true then
      local bMale = PlayerData.Base:GetPlayerSex() == true
      sCG = bMale and sCG .. "_MP" or sCG .. "_FP"
    end
    self:SetPngSprite(self._mapNode.imgTriggerCg, sCG)
    self._mapNode.ImageLine1.gameObject:SetActive(true)
    if mapStoryTypeData.StoryType == GameEnum.soldierEventType.StoryPersonality then
      self._mapNode.imgTriggerCg2.gameObject:SetActive(true)
      self:SetPngSprite(self._mapNode.imgTriggerCg2, sCG)
      self._mapNode.ImageLine2.gameObject:SetActive(true)
    elseif mapStoryTypeData.StoryType == GameEnum.soldierEventType.StoryCost then
      self._mapNode.imgTriggerCg1.gameObject:SetActive(true)
      self:SetPngSprite(self._mapNode.imgTriggerCg1, sCG)
      self._mapNode.ImageLine3.gameObject:SetActive(true)
    end
    self._mapNode.imgOptionChar.gameObject:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtCgTitle, mapStoryTypeData.Title)
    NovaAPI.SetTMPText(self._mapNode.txtCgStory, mapStoryTypeData.Desc)
  else
    NovaAPI.SetTMPText(self._mapNode.txtEventStory, mapStoryTypeData.Desc)
    NovaAPI.SetTMPText(self._mapNode.txtStoryTitle, mapStoryTypeData.Title)
    self._mapNode.imgOptionChar.gameObject:SetActive(true)
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.imgEventChar, PanelId.SoldierEventPanel, mapStoryTypeData.NPCId)
    Actor2DManager.SetBoardNPC2D_PNG(self._mapNode.imgOptionChar, PanelId.SoldierEventPanel, mapStoryTypeData.NPCId)
  end
  self:RefreshOpeningStory(bCG)
  if self.nPreOptionId == nil or 0 >= self.nPreOptionId then
    NovaAPI.SetTMPText(self._mapNode.txtEventDesc, mapStoryTypeData.OptionTitleDesc1)
  else
    local mapOption = ConfigTable.GetData("SoldierStoryPersonalityOption", self.nPreOptionId)
    if mapOption ~= nil then
      local nResultId = mapOption.ResultId or 0
      local mapResult = ConfigTable.GetData("SoldierStoryResult", nResultId)
      if mapResult ~= nil then
        NovaAPI.SetTMPText(self._mapNode.txtEventDesc, mapResult.ResultText)
      end
    end
  end
end

function SoldierEventCtrl:RefreshOpeningStory(bCG)
  local sAnim = ""
  if not self._bOpeningStoryClosed and bCG then
    sAnim = "SoldierEventPanel_EventImg_in"
  elseif not self._bOpeningStoryClosed and not bCG then
    sAnim = "SoldierEventPanel_Event_in"
  end
  self._mapNode.rtTriggerEvent.gameObject:SetActive(not self._bOpeningStoryClosed and bCG)
  self._mapNode.rtCharEvent.gameObject:SetActive(not self._bOpeningStoryClosed and not bCG)
  self._mapNode.animRoot:Play(sAnim, 0, 0)
end

function SoldierEventCtrl:RefreshEventOptions()
  for k, v in pairs(self._mapNode.btnChoose) do
    v.gameObject:SetActive(false)
  end
  for _, ctrl in pairs(self.tbItemCtrl or {}) do
    self:UnbindCtrlByNode(ctrl)
  end
  self.tbItemCtrl = {}
  for _, btn in pairs(self.tbBtns or {}) do
    btn.onClick:RemoveAllListeners()
  end
  self.tbBtns = {}
  if self.mapCurEventData == nil or 0 < (self.mapCurEventData.nIndex or 0) then
    return
  end
  self.tbPersonalityOptionId = {}
  self.tbEventType = {}
  local tbOptions = self.mapCurEventData.tbOptions or {}
  for k, v in pairs(tbOptions) do
    local mapOptionData = ConfigTable.GetData("SoldierStoryPersonalityOption", v.PersonalityOptionId)
    self.tbPersonalityOptionId[k] = v.PersonalityOptionId
    local bUnlock = v.Select == true
    if mapOptionData ~= nil then
      self._mapNode.btnChoose[k].gameObject:SetActive(true)
      bUnlock = (not (mapOptionData.OptionalCond ~= nil and 0 < mapOptionData.OptionalCond) or self:CheckOptionCond(mapOptionData.OptionalCond, mapOptionData.OptionalParam, v.PersonalityOptionId)) and bUnlock
      self:SetUnlockCond(mapOptionData.OptionalCond, mapOptionData.OptionalParam, k)
      self._mapNode.imgBgDisable[k].gameObject:SetActive(not bUnlock)
      self._mapNode.btnChoose[k].interactable = self._bOpeningStoryClosed
      local sPath = ""
      if mapOptionData.CheckDimension ~= nil and 0 < mapOptionData.CheckDimension then
        sPath = AllEnum.SoldierPersonalityDB[mapOptionData.CheckDimension]
      else
        sPath = AllEnum.SoldierPersonalityDB[0]
      end
      self:SetPngSprite(self._mapNode.imgBgEnable[k], sPath)
      local mapOptionText = ConfigTable.GetData("SoldierOptionType", mapOptionData.OptionTypeId)
      if mapOptionText ~= nil then
        NovaAPI.SetTMPText(self._mapNode.TMPChoose[k], mapOptionText.OptionDesc)
        self._mapNode.imgFunc[k].gameObject:SetActive(true)
        if mapOptionText.StoryType == GameEnum.soldierEventType.StoryPersonality then
          self._mapNode.imgTriggerCg2.gameObject:SetActive(true)
          self._mapNode.ImageLine2.gameObject:SetActive(true)
          self.tbEventType[k] = GameEnum.soldierEventType.StoryPersonality
          self._mapNode.goBossInfo.gameObject:SetActive(true)
          if mapOptionData.CheckDifficulty ~= nil and 0 < mapOptionData.CheckDifficulty then
            local sText = orderedFormat(ConfigTable.GetUIText("Soldier_BattleEvent_Need"), mapOptionData.CheckDifficulty) or ""
            NovaAPI.SetTMPText(self._mapNode.TMPFunc[k], sText)
          else
            self._mapNode.imgFunc[k].gameObject:SetActive(false)
          end
        elseif mapOptionText.StoryType == GameEnum.soldierEventType.StoryCost then
          self.tbEventType[k] = GameEnum.soldierEventType.StoryCost
          self._mapNode.goBossInfo.gameObject:SetActive(false)
          if mapOptionText.CostDesc ~= nil and mapOptionText.CostDesc ~= "" then
            NovaAPI.SetTMPText(self._mapNode.TMPFunc[k], mapOptionText.CostDesc)
          else
            self._mapNode.imgFunc[k].gameObject:SetActive(false)
          end
        end
      end
    end
    local tbGrids = self._mapNode["goReward" .. k .. "_"] or {}
    for _, go in pairs(tbGrids) do
      go.gameObject:SetActive(false)
    end
    if bUnlock then
      local tbRewards = v.Rewards
      self.nRewardIndex = 1
      for _, mapReward in pairs(tbRewards or {}) do
        local nRewardType = mapReward.RewardType or 0
        if nRewardType == AllEnum.SoldierEventEffectRewardType.Card then
          for _, nCardId in pairs(mapReward.Ids.Values or {}) do
            local mapCfg = ConfigTable.GetData("SoldierStrategyCard", nCardId)
            if mapCfg ~= nil then
              local goItem, goChar, goBuff = self:GetRewardGrid(tbGrids, self.nRewardIndex)
              if goItem == nil then
                break
              end
              local imgBg = goBuff.transform:Find("SmallBuff/AnimRoot/imgBg"):GetComponent("Image")
              local imgIcon = goBuff.transform:Find("SmallBuff/AnimRoot/imgIcon"):GetComponent("Image")
              goBuff:SetActive(true)
              self:SetPngSprite(imgIcon, "Icon/SoldierBuffCard/" .. mapCfg.Icon)
              local sRarityIcon = AllEnum.SoldierStrategyCardRarityIcon[mapCfg.Rarity]
              if sRarityIcon ~= nil then
                self:SetPngSprite(imgBg, "Icon/SoldierOtherIcon/" .. sRarityIcon .. AllEnum.SoldierChessIconSurfix.S)
              end
              local btnBuff = goBuff:GetComponent("UIButton")
              table.insert(self.tbBtns, btnBuff)
              btnBuff.onClick:RemoveAllListeners()
              btnBuff.onClick:AddListener(function()
                EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCardTips, nCardId)
              end)
              self.nRewardIndex = self.nRewardIndex + 1
            end
          end
        elseif nRewardType == AllEnum.SoldierEventEffectRewardType.GainCoin then
          for _, mapCoin in pairs(mapReward.Resource.ResRewards or {}) do
            if mapCoin.Qty ~= nil and 0 < mapCoin.Qty then
              local goItem, goChar, goBuff = self:GetRewardGrid(tbGrids, self.nRewardIndex)
              if goItem == nil then
                break
              end
              goItem:SetActive(true)
              local sCoinIcon = "Icon/Item/item_40"
              local ctrlItem = self:BindCtrlByNode(goItem, "Game.UI.Soldier.Template.SoldierItemGridCtrl")
              ctrlItem:SetItem(1, mapCoin.Qty, sCoinIcon, mapCoin.Tid)
              table.insert(self.tbItemCtrl, ctrlItem)
              self.nRewardIndex = self.nRewardIndex + 1
            end
          end
        elseif nRewardType == AllEnum.SoldierEventEffectRewardType.Hp then
          local nHp = mapReward.Hp
          if not (nHp ~= nil and 0 < nHp) then
            goto lbl_538
          end
          local goItem, goChar, goBuff = self:GetRewardGrid(tbGrids, self.nRewardIndex)
          if goItem == nil then
            break
          end
          goItem:SetActive(true)
          local sHpIcon = "Icon/Item/item_2701005"
          local ctrlItem = self:BindCtrlByNode(goItem, "Game.UI.Soldier.Template.SoldierItemGridCtrl")
          ctrlItem:SetItem(1, nHp, sHpIcon, 2701005)
          table.insert(self.tbItemCtrl, ctrlItem)
          self.nRewardIndex = self.nRewardIndex + 1
        elseif nRewardType == AllEnum.SoldierEventEffectRewardType.Chess then
          for _, mapChar in ipairs(mapReward.Chess.ChessRewards or {}) do
            local goItem, goChar, goBuff = self:GetRewardGrid(tbGrids, self.nRewardIndex)
            if goItem == nil then
              break
            end
            goChar:SetActive(true)
            local ctrlItem = self:BindCtrlByNode(goChar, "Game.UI.Soldier.Template.SoldierCharGridCtrl")
            local cSkin = ConfigTable.GetData("SoldierSkin", mapChar.Tid)
            local cData = ConfigTable.GetData("SoldierCharacter", mapChar.Tid)
            ctrlItem:SetItem(cData.Rarity, mapChar.Qty, cSkin.Icon .. AllEnum.SoldierChessIconSurfix.S, mapChar.Star)
            table.insert(self.tbItemCtrl, ctrlItem)
            local btnChar = goChar:GetComponent("UIButton")
            table.insert(self.tbBtns, btnChar)
            btnChar.onClick:RemoveAllListeners()
            btnChar.onClick:AddListener(function()
              local chessData = {
                nId = mapChar.Tid,
                nStar = mapChar.Star
              }
              EventManager.Hit(EventId.OpenPanel, PanelId.SoldierCharCardTips, btnChar.gameObject.transform, chessData)
            end)
            self.nRewardIndex = self.nRewardIndex + 1
          end
        end
        ::lbl_538::
      end
    end
  end
end

function SoldierEventCtrl:GetRewardGrid(tbGrids, nIndex)
  local goGrid = tbGrids[nIndex]
  if goGrid == nil then
    return
  end
  goGrid = goGrid.gameObject
  goGrid:SetActive(true)
  local goItem = goGrid.transform:Find("OptionItem").gameObject
  local goChar = goGrid.transform:Find("CharItem").gameObject
  local goBuff = goGrid.transform:Find("BuffItem").gameObject
  goItem:SetActive(false)
  goChar:SetActive(false)
  goBuff:SetActive(false)
  return goItem, goChar, goBuff
end

local tbPersonalityTextKey = {
  [GameEnum.SoldierRolePersonality.Personality_Intuition] = "Soldier_Personality_Intuition",
  [GameEnum.SoldierRolePersonality.Personality_Analysis] = "Soldier_Personality_Analyze",
  [GameEnum.SoldierRolePersonality.Personality_Chaos] = "Soldier_Personality_Chaos"
}

function SoldierEventCtrl:SetUnlockCond(nCond, param, nIndex)
  local sUnlockText = ""
  local sIcon = ""
  self._mapNode.imgChaos[nIndex].gameObject:SetActive(false)
  if nCond == GameEnum.SoldierStoryOptionCond.BossPersonalityGrade then
    local sPre = ConfigTable.GetUIText("Soldier_BattleEvent_Lock")
    local sTextKey = param and tbPersonalityTextKey[param[1]]
    local sPost = sTextKey and ConfigTable.GetUIText(sTextKey) or ""
    sUnlockText = orderedFormat(sPre, sPost)
    sIcon = param and AllEnum.SoldierPersonalityLevelIconByEnum[param[2]] or ""
    if sTextKey ~= nil and sIcon ~= "" then
      self._mapNode.imgChaos[nIndex].gameObject:SetActive(true)
      self:SetPngSprite(self._mapNode.imgChaos[nIndex], sIcon)
    end
  elseif nCond == GameEnum.SoldierStoryOptionCond.GradeLevelUnlocked then
    local sRank = "M" .. param[1]
    sUnlockText = orderedFormat(ConfigTable.GetUIText("Soldier_Event_NeedChallengeGrade"), sRank)
  elseif nCond == GameEnum.SoldierStoryOptionCond.EndingUnlocked then
    local mapEnding = ConfigTable.GetData("SoldierEndingPlan", param[1])
    sUnlockText = orderedFormat(ConfigTable.GetUIText("Soldier_Event_NeedEnding"), mapEnding.EndingTitle)
  elseif nCond == GameEnum.SoldierStoryOptionCond.OptionChosenInRun then
  elseif nCond == GameEnum.SoldierStoryOptionCond.CoinUnlocked then
    sUnlockText = orderedFormat(ConfigTable.GetUIText("Soldier_Event_NeedCoin"), param[1])
  elseif nCond == GameEnum.SoldierStoryOptionCond.HpUnlocked then
    sUnlockText = orderedFormat(ConfigTable.GetUIText("Soldier_Event_NeedHp"), param[1])
  end
  NovaAPI.SetTMPText(self._mapNode.txtLock[nIndex], sUnlockText)
end

function SoldierEventCtrl:CheckOptionCond(nCond, param, nOptionId)
  if nCond == GameEnum.SoldierStoryOptionCond.BossPersonalityGrade then
    local nGrade = param and param[2]
    local nPersonalityType = param and param[1]
    local nCurGrade = self.tbPersonalityGrade and self.tbPersonalityGrade[nPersonalityType]
    if tbPersonalityTextKey[nPersonalityType] == nil or AllEnum.SoldierPersonalityLevelIconByEnum[nGrade] == nil or AllEnum.SoldierPersonalityLevelIconByEnum[nCurGrade] == nil then
      return false
    end
    return nGrade >= nCurGrade
  elseif nCond == GameEnum.SoldierStoryOptionCond.CoinUnlocked then
    local nCoin = self.levelData:GetItem(AllEnum.CoinItemId.SoldierCurrency)
    return nCoin >= param[1]
  elseif nCond == GameEnum.SoldierStoryOptionCond.HpUnlocked then
    local nHp = self.levelData:GetHp()
    return nHp >= param[1]
  elseif nCond == GameEnum.SoldierStoryOptionCond.GradeLevelUnlocked then
    local nChallengeGrade = PlayerData.SoldierData:GetHighestChallengeId()
    local mapChallenge = ConfigTable.GetData("SoldierGradeChallenge", nChallengeGrade)
    return mapChallenge ~= nil and mapChallenge.GradeLevel >= param[1]
  elseif nCond == GameEnum.SoldierStoryOptionCond.OptionChosenInRun then
  elseif nCond == GameEnum.SoldierStoryOptionCond.EndingUnlocked then
  end
  return false
end

function SoldierEventCtrl:RefreshBossTemplate()
  local mapCfg = ConfigTable.GetData("SoldierBossTemplate", self.nBossTemplateId or 0)
  self.tbPersonalityGrade = {}
  if mapCfg ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtCharName, mapCfg.Name)
    local sIntGrade = AllEnum.SoldierPersonalityLevelIconByEnum[mapCfg.Personality_Intuition] or ""
    self.tbPersonalityGrade[GameEnum.SoldierRolePersonality.Personality_Intuition] = mapCfg.Personality_Intuition
    self:SetPngSprite(self._mapNode.imgPersonalityPercent[1], sIntGrade)
    local sAnalyzeGrade = AllEnum.SoldierPersonalityLevelIconByEnum[mapCfg.Personality_Analysis] or ""
    self.tbPersonalityGrade[GameEnum.SoldierRolePersonality.Personality_Analysis] = mapCfg.Personality_Analysis
    self:SetPngSprite(self._mapNode.imgPersonalityPercent[2], sAnalyzeGrade)
    local sChaosGrade = AllEnum.SoldierPersonalityLevelIconByEnum[mapCfg.Personality_Chaos] or ""
    self.tbPersonalityGrade[GameEnum.SoldierRolePersonality.Personality_Chaos] = mapCfg.Personality_Chaos
    self:SetPngSprite(self._mapNode.imgPersonalityPercent[3], sChaosGrade)
    self:SetPngSprite(self._mapNode.imgCharHead, mapCfg.SoldierPlayerHead)
  end
end

function SoldierEventCtrl:HidePanel()
  if self._bPanelHidden then
    return
  end
  self._bPanelHidden = true
  self.bPrevMainRootVisible = self._mapNode.mainRoot.gameObject.activeSelf or false
  self.bPrevBlurVisible = self._mapNode.blur.gameObject.activeSelf or false
  self.bPrevImgMaskMainVisible = self._mapNode.imgMaskMain.gameObject.activeSelf or false
  self._mapNode.mainRoot.gameObject:SetActive(false)
  self._mapNode.blur.gameObject:SetActive(false)
  self._mapNode.imgMaskMain.gameObject:SetActive(false)
end

function SoldierEventCtrl:ShowPanel()
  if not self:RefreshEvent(true) then
    return
  end
  self._bPanelHidden = false
  self._mapNode.mainRoot.gameObject:SetActive(self.bPrevMainRootVisible)
  self._mapNode.blur.gameObject:SetActive(self.bPrevBlurVisible)
  self._mapNode.imgMaskMain.gameObject:SetActive(self.bPrevImgMaskMainVisible)
end

function SoldierEventCtrl:OpenDicePanel(mapParam)
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierResolveadisputePanel, mapParam)
end

function SoldierEventCtrl:OnBtnClick_Choose(btn, nIndex)
  local objLevelData = PlayerData.SoldierData:GetCurLevelData()
  local mapEventData = objLevelData and objLevelData:GetStoryEventData()
  if mapEventData == nil or mapEventData ~= self.mapCurEventData or 0 < (mapEventData.nIndex or 0) then
    self:RefreshEvent(true)
    return
  end
  
  local function callback(tbChange)
  end
  
  self.levelData:SendStoryEventSelect(nIndex, callback)
end

function SoldierEventCtrl:OnBtnClick_Return()
  CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_ingame_transition")
  self:HidePanel()
end

function SoldierEventCtrl:OnEvent_ShowSoldierEventPanel()
  self:ShowPanel()
  self._mapNode.animRoot:Play("SoldierEventPanel_SelectEvent_in", 0, 0)
end

function SoldierEventCtrl:OnEvent_SoldierEventSelect(nIndex, nCardId)
end

function SoldierEventCtrl:RefreshOptionInteractable()
  for _, btn in pairs(self._mapNode.btnChoose) do
    btn.interactable = self._bOpeningStoryClosed
  end
end

function SoldierEventCtrl:OnBtnClick_CloseStory()
  self._bOpeningStoryClosed = true
  self._mapNode.rtCharEvent.gameObject:SetActive(false)
  self:RefreshOptionInteractable()
  self._mapNode.animRoot:Play("SoldierEventPanel_SelectEvent_in", 0, 0)
end

function SoldierEventCtrl:OnBtnClick_CloseCg()
  self._bOpeningStoryClosed = true
  self._mapNode.rtTriggerEvent.gameObject:SetActive(false)
  self:RefreshOptionInteractable()
  self._mapNode.animRoot:Play("SoldierEventPanel_SelectEvent_in", 0, 0)
end

function SoldierEventCtrl:OnEvent_ShowBattleEventPanel()
  self:ShowPanel()
  self._mapNode.animRoot:Play("SoldierEventPanel_SelectEvent_in", 0, 0)
end

function SoldierEventCtrl:OnEvent_RefreshStoryEventOfCostly()
  self:RefreshEvent()
end

function SoldierEventCtrl:OnEvent_EnterEventSelect()
  self:RefreshEvent()
end

function SoldierEventCtrl:OnEvent_RefreshSoldierRes()
  self:RefreshEvent(true)
end

return SoldierEventCtrl
