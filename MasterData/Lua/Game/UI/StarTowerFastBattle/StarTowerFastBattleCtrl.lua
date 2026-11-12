local StarTowerFastBattleCtrl = class("StarTowerFastBattleCtrl", BaseCtrl)
local StarTowerSettingGate = require("Game.Adventure.StarTower.StarTowerSettingGate")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
StarTowerFastBattleCtrl._mapNodeConfig = {
  imgRed = {},
  imgBg_4 = {sComponentName = "Image"},
  imgBg_2_L = {nCount = 2, sComponentName = "Image"},
  imgBg_2_R = {nCount = 2, sComponentName = "Image"},
  imgBg_Flag_L = {nCount = 2, sComponentName = "Image"},
  rtImgBgFlagL = {
    nCount = 2,
    sNodeName = "imgBg_Flag_L",
    sComponentName = "RectTransform"
  },
  imgBg_Flag_R = {nCount = 2, sComponentName = "Image"},
  rtImgBgFlagR = {
    nCount = 2,
    sNodeName = "imgBg_Flag_R",
    sComponentName = "RectTransform"
  },
  trRoot = {
    sNodeName = "----Actor2D_L2DInUI----",
    sComponentName = "Transform"
  },
  SlipInOutAnim = {sComponentName = "Animator"},
  trActor2D_PNG = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Transform"
  },
  actor2DPNGAnim = {
    sNodeName = "----Actor2D_PNG----",
    sComponentName = "Animator"
  },
  btnBack = {
    sComponentName = "UIButton",
    callback = "OnBackButtonClick"
  },
  btnLog = {
    sComponentName = "UIButton",
    callback = "OnLogButtonClick"
  },
  imgFloorUpArrow = {sComponentName = "Image"},
  imgFloorNum = {
    sNodeName = "imgFloorNum_",
    sComponentName = "Image",
    nCount = 4
  },
  imgFloorIcon = {sComponentName = "Image", nCount = 2},
  Tips = {
    sCtrlName = "Game.UI.StarTower.DiscTips.StarTowerTipsCtrl"
  },
  TipsCanvas = {sNodeName = "Tips", sComponentName = "Canvas"},
  imgBuildRank = {sComponentName = "Image"},
  textBulidScoreNum = {sComponentName = "TMP_Text"},
  textBulidScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "StartowerFastBattle_BuildScore"
  },
  btnBulidDetails = {
    sComponentName = "UIButton",
    callback = "OnBulidDetailsButtonClick"
  },
  imgRoleIcon = {
    sNodeName = "imgRoleIcon_",
    sComponentName = "Image",
    nCount = 3
  },
  textPerkCount = {
    sNodeName = "textPerkCount_",
    sComponentName = "TMP_Text",
    nCount = 3
  },
  btnRoleDetails = {
    sComponentName = "UIButton",
    callback = "OnRoleDetailsButtonClick"
  },
  imgNote = {
    sNodeName = "imgNote_",
    sComponentName = "Image",
    nCount = 9
  },
  textNote = {
    sNodeName = "textNote_",
    sComponentName = "TMP_Text",
    nCount = 9
  },
  btnNoteDetails = {
    sComponentName = "UIButton",
    callback = "OnNoteDetailsButtonClick"
  },
  textLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Reward_Level"
  },
  textLevelNum = {sComponentName = "TMP_Text"},
  imgLevelBar = {sComponentName = "Image"},
  imgCoin = {sComponentName = "Image"},
  textCoinCount = {sComponentName = "TMP_Text"},
  btnFastBattle = {
    sComponentName = "UIButton",
    callback = "OnFastBattleButtonClick"
  },
  goAuto = {},
  textAutomatic = {
    sComponentName = "TMP_Text",
    sLanguageId = "StartowerFastBattle_Automatic"
  },
  goPause = {},
  textPause = {
    sComponentName = "TMP_Text",
    sLanguageId = "StartowerFastBattle_Pause"
  }
}
StarTowerFastBattleCtrl._mapEventConfig = {
  InitRoom = "OnEvent_InitRoom",
  EventHandleOver = "OnEvent_EventHandleOver",
  SweepEnterDangerRoom = "OnEvent_EnterDangerRoom",
  RefreshFastBattleInfo = "OnEvent_RefreshFastBattleInfo",
  StarTowerFastBattleOpenShop = "OnEvent_StarTowerFastBattleOpenShop",
  StarTowerFastBattleOpenMachine = "OnEvent_StarTowerFastBattleOpenMachine",
  DiscSkillActive = "OnEvent_DiscSkillActive",
  [EventId.StarTowerDepot] = "OnEvent_OpenStarTowerDepot",
  RefreshNoteCount = "OnEvent_RefreshNoteCount",
  TryCloseStarTowerLastShop = "OnEvent_TryCloseStarTowerLastShop",
  ShowNPCAffinity = "OnEvent_AffinityTips",
  LeaveStarTowerFastBattle = "OnEvent_Leave",
  StarTowerFastBattleLeaveForRecharge = "OnEvent_LeaveForRecharge",
  StarTowerAutoDecisionStateChanged = "OnEvent_AutoDecisionStateChanged",
  StarTowerAutoDecisionRequestManual = "OnEvent_AutoDecisionRequestManual",
  StarTowerAutoDecisionRequestFailed = "OnEvent_AutoDecisionRequestFailed",
  StarTowerFastBattleOptionReady = "OnEvent_StarTowerFastBattleOptionReady"
}
StarTowerFastBattleCtrl._mapRedDotConfig = {}
local theme_sprite_path = "UI/big_sprites/"
local Flag_Random = {-330, 660}
local room_bg = {
  [GameEnum.starTowerRoomType.ShopRoom] = "bg_fastBattle_shop_1",
  [GameEnum.starTowerRoomType.EventRoom] = "bg_fastBattle_2",
  [GameEnum.starTowerRoomType.BattleRoom] = "bg_fastBattle_3",
  [GameEnum.starTowerRoomType.EliteBattleRoom] = "bg_fastBattle_4",
  [GameEnum.starTowerRoomType.BossRoom] = "bg_fastBattle_5",
  [GameEnum.starTowerRoomType.FinalBossRoom] = "bg_fastBattle_6"
}

function StarTowerFastBattleCtrl:Awake()
  self.bHandleOver = false
  self.bOpenOption = false
  self.bAutoAdvance = true
  self.bPause = false
  self.nNextCaseId = -1
  self.nNextRoomType = -1
  self.tbTips = {}
  self.tbHistoryLog = {}
  self.Animator = self.gameObject:GetComponent("Animator")
  self:Init()
end

function StarTowerFastBattleCtrl:FadeIn()
  local bL2d = LocalSettingData.mapData.UseLive2D
  self._mapNode.trRoot.gameObject:SetActive(bL2d)
  self._mapNode.trActor2D_PNG.gameObject:SetActive(not bL2d)
  if bL2d then
    Actor2DManager.SetActor2DInUI(self:GetPanelId(), self._mapNode.trRoot, self._panel.tbTeam[1], nil, true)
    self._mapNode.SlipInOutAnim:Play("Actor2D_right_in")
  else
    Actor2DManager.SetActor2D_PNG(self._mapNode.trActor2D_PNG, self:GetPanelId(), self._panel.tbTeam[1], nil)
    self._mapNode.actor2DPNGAnim:Play("Actor2D_PNG_right_in")
  end
end

function StarTowerFastBattleCtrl:FadeOut()
end

function StarTowerFastBattleCtrl:OnEnable()
  StarTowerSettingGate.Begin()
  StarTowerSettingGate.Transition(self, 1.3)
  self.bAutoAdvance = true
  self.bPause = false
  self:RefreshPauseStatus()
  self:InitGroupTheme()
  self:RefreshRoomFloor()
  self:RefreshRoomBg()
  self:RefreshRoomIcon()
  self:RefreshBuildScore()
  self:RefreshNoteCount()
  self:RefreshPerkCount()
  self:RefreshLevelExp()
  self:RefreshCoin()
  NovaAPI.SetCanvasSortingName(self._mapNode.TipsCanvas, AllEnum.SortingLayerName.UI_Top)
  EventManager.Hit(EventId.TemporaryBlockInput, 1.3)
  self:AddTimer(1, 1, "StartFastBattle", true, true, true)
  GamepadUIManager.EnableGamepadUI("StarTowerFastBattleCtrl", {}, nil, true)
end

function StarTowerFastBattleCtrl:OnDisable()
  StarTowerSettingGate.Clear(self)
  self._panel.LevelData:SetAutoDecisionEnabled(false)
  self.nNextCaseId = -1
  self.nNextRoomType = -1
  self.tbHistoryLog = nil
  GamepadUIManager.DisableGamepadUI("StarTowerFastBattleCtrl")
end

function StarTowerFastBattleCtrl:OnDestroy()
  local func_OpenRecharge = self._func_OpenRechargeAfterLeave
  self._func_OpenRechargeAfterLeave = nil
  if type(func_OpenRecharge) == "function" then
    cs_coroutine.start(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      if PanelManager.GetCurPanelId() == PanelId.MainView and not PanelManager.CheckPanelOpen(PanelId.StarTowerFastBattle) and not PanelManager.CheckNextPanelOpening() then
        func_OpenRecharge()
      end
    end)
  end
end

function StarTowerFastBattleCtrl:OnRelease()
end

function StarTowerFastBattleCtrl:Init()
  NovaAPI.SetTMPText(self._mapNode.textBulidScoreNum, 0)
  for nIndex, nCharId in ipairs(self._panel.tbTeam) do
    if nil ~= self._mapNode.imgRoleIcon[nIndex] then
      local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
      local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
      if nil ~= mapSkin then
        self:SetPngSprite(self._mapNode.imgRoleIcon[nIndex], mapSkin.Icon, AllEnum.CharHeadIconSurfix.S)
      end
    end
    if nil ~= self._mapNode.textPerkCount[nIndex] then
      NovaAPI.SetTMPText(self._mapNode.textPerkCount[nIndex], 0)
    end
  end
  self:RefreshNoteCount()
  self:SetSprite_Coin(self._mapNode.imgCoin, AllEnum.CoinItemId.FixedRogCurrency)
  NovaAPI.SetTMPText(self._mapNode.textCoinCount, 0)
  self._mapNode.imgRed:SetActive(false)
  self:RefreshPauseStatus()
end

function StarTowerFastBattleCtrl:StartFastBattle()
  StarTowerSettingGate.Begin()
  StarTowerSettingGate.Transition(self, NovaAPI.GetAnimClipLength(self.Animator, {
    "StarTowerFastBattlePanel_open"
  }))
  EventManager.Hit("InitStarTowerNote", self._panel.LevelData._mapNote)
  self.Animator:Play("StarTowerFastBattlePanel_open")
  CS.WwiseAudioManager.Instance:PlaySound("ui_startower_fastBattle_elevator_door")
  self:AddTimer(1, 0.3, function()
    self._panel.LevelData:HandleCases()
  end, true, true, true)
end

function StarTowerFastBattleCtrl:EnterRoom()
  if self._panel.LevelData:EnterRoom(self.nNextCaseId, self.nNextRoomType) then
    self.bHandleOver = false
  end
end

function StarTowerFastBattleCtrl:InitGroupTheme()
  local mapStarTowerCfg = ConfigTable.GetData("StarTower", self._panel.nStarTowerId)
  if mapStarTowerCfg ~= nil then
    self.nGroupId = mapStarTowerCfg.GroupId
    local mapGroup = ConfigTable.GetData("StarTowerGroup", self.nGroupId)
    if nil ~= mapGroup then
      local nTheme = mapGroup.GroupTheme or 1
      self.bShowFlag = #mapGroup.EET > 0
      for _, v in ipairs(self._mapNode.imgBg_2_L) do
        self:SetPngSprite(v, theme_sprite_path .. string.format(AllEnum.StarTowerFastBattleBg.Bg_L, nTheme))
      end
      for _, v in ipairs(self._mapNode.imgBg_2_R) do
        self:SetPngSprite(v, theme_sprite_path .. string.format(AllEnum.StarTowerFastBattleBg.Bg_R, nTheme))
      end
      for _, v in ipairs(self._mapNode.imgBg_Flag_L) do
        if self.bShowFlag then
          self:SetPngSprite(v, theme_sprite_path .. string.format(AllEnum.StarTowerFastBattleBg.Flag, nTheme))
        end
      end
      for _, v in ipairs(self._mapNode.imgBg_Flag_R) do
        if self.bShowFlag then
          self:SetPngSprite(v, theme_sprite_path .. string.format(AllEnum.StarTowerFastBattleBg.Flag, nTheme))
        end
      end
      self.nRandomLR = math.random(1, 2)
      self.nRandomPosYL = math.random(Flag_Random[1], Flag_Random[2])
      self.nRandomPosYR = math.random(Flag_Random[1], Flag_Random[2])
      self._mapNode.imgBg_Flag_L[1].gameObject:SetActive(self.nRandomLR == 1 and self.bShowFlag)
      self._mapNode.imgBg_Flag_R[1].gameObject:SetActive(self.nRandomLR == 2 and self.bShowFlag)
      self._mapNode.rtImgBgFlagL[1].anchoredPosition = Vector2(0, self.nRandomPosYL)
      self._mapNode.rtImgBgFlagR[1].anchoredPosition = Vector2(0, self.nRandomPosYR)
    end
  end
end

function StarTowerFastBattleCtrl:RefreshThemeFlag(nTime)
  self.nRandomLR = math.random(1, 2)
  self.nRandomPosYL = math.random(Flag_Random[1], Flag_Random[2])
  self.nRandomPosYR = math.random(Flag_Random[1], Flag_Random[2])
  self._mapNode.imgBg_Flag_L[2].gameObject:SetActive(self.nRandomLR == 1 and self.bShowFlag)
  self._mapNode.imgBg_Flag_R[2].gameObject:SetActive(self.nRandomLR == 2 and self.bShowFlag)
  self._mapNode.rtImgBgFlagL[2].anchoredPosition = Vector2(0, self.nRandomPosYL)
  self._mapNode.rtImgBgFlagR[2].anchoredPosition = Vector2(0, self.nRandomPosYR)
  self:AddTimer(1, nTime, function()
    self._mapNode.imgBg_Flag_L[1].gameObject:SetActive(self.nRandomLR == 1 and self.bShowFlag)
    self._mapNode.imgBg_Flag_R[1].gameObject:SetActive(self.nRandomLR == 2 and self.bShowFlag)
    self._mapNode.rtImgBgFlagL[1].anchoredPosition = Vector2(0, self.nRandomPosYL)
    self._mapNode.rtImgBgFlagR[1].anchoredPosition = Vector2(0, self.nRandomPosYR)
  end, true, true, true)
end

function StarTowerFastBattleCtrl:RefreshRoomIcon()
  local nRoomType = self._panel.LevelData.nRoomType
  for _, v in ipairs(self._mapNode.imgFloorIcon) do
    self:SetAtlasSprite(v, "11_ico", AllEnum.StarTowerRoomName[nRoomType].SweepIcon)
  end
  if nRoomType == GameEnum.starTowerRoomType.HorrorRoom then
    self._mapNode.imgRed:SetActive(true)
    local _, color = ColorUtility.TryParseHtmlString("#FF2B53")
    for _, v in ipairs(self._mapNode.imgFloorNum) do
      NovaAPI.SetImageColor(v, color)
    end
  else
    self._mapNode.imgRed:SetActive(false)
    local _, color = ColorUtility.TryParseHtmlString("#08D3D4")
    NovaAPI.SetImageColor(self._mapNode.imgFloorNum[1], color)
    NovaAPI.SetImageColor(self._mapNode.imgFloorNum[2], color)
    local _, color2 = ColorUtility.TryParseHtmlString("#4CFEFF")
    NovaAPI.SetImageColor(self._mapNode.imgFloorNum[3], color2)
    NovaAPI.SetImageColor(self._mapNode.imgFloorNum[4], color2)
  end
end

function StarTowerFastBattleCtrl:RefreshRoomBg()
  local nRoomType = self._panel.LevelData.nRoomType
  local sIcon = room_bg[nRoomType]
  if sIcon ~= nil then
    self:SetPngSprite(self._mapNode.imgBg_4, theme_sprite_path .. sIcon)
  end
end

function StarTowerFastBattleCtrl:RefreshRoomFloor()
  local nFloorNum = self._panel.LevelData.nCurLevel
  self:SetAtlasSprite(self._mapNode.imgFloorNum[1], "05_number", "zs_fastBattle_floor_" .. nFloorNum % 10)
  NovaAPI.SetImageNativeSize(self._mapNode.imgFloorNum[1])
  self:SetAtlasSprite(self._mapNode.imgFloorNum[3], "05_number", "zs_fastBattle_floor_" .. nFloorNum % 10)
  NovaAPI.SetImageNativeSize(self._mapNode.imgFloorNum[3])
  nFloorNum = math.floor(nFloorNum / 10)
  self:SetAtlasSprite(self._mapNode.imgFloorNum[2], "05_number", "zs_fastBattle_floor_" .. nFloorNum % 10)
  NovaAPI.SetImageNativeSize(self._mapNode.imgFloorNum[2])
  self:SetAtlasSprite(self._mapNode.imgFloorNum[4], "05_number", "zs_fastBattle_floor_" .. nFloorNum % 10)
  NovaAPI.SetImageNativeSize(self._mapNode.imgFloorNum[4])
end

function StarTowerFastBattleCtrl:RefreshBuildScore()
  local nLastScore = tonumber(NovaAPI.GetTMPText(self._mapNode.textBulidScoreNum))
  local nAfterScore = self._panel.LevelData:CalBuildScore()
  if nAfterScore ~= nLastScore then
    StarTowerSettingGate.Transition(self, 1)
    local twCoin = DOTween.To(function()
      return nLastScore
    end, function(score)
      NovaAPI.SetTMPText(self._mapNode.textBulidScoreNum, math.floor(score))
    end, nAfterScore, 1)
    
    local function _cb()
      NovaAPI.SetTMPText(self._mapNode.textBulidScoreNum, nAfterScore)
    end
    
    twCoin.onComplete = dotween_callback_handler(self, _cb)
  end
  local rank = PlayerData.Build:CalBuildRank(nAfterScore)
  local imagePath = "Icon/BuildRank/BuildRank_" .. rank.Id
  self:SetPngSprite(self._mapNode.imgBuildRank, imagePath)
end

function StarTowerFastBattleCtrl:RefreshNoteCount()
  local goLastNoteObj
  local LevelData = self._panel.LevelData
  for i = 1, 9 do
    local nNoteId = self._panel.tbShowNote[i]
    self._mapNode.imgNote[i].gameObject:SetActive(false)
    if nNoteId ~= nil then
      local noteCfg = ConfigTable.GetData("SubNoteSkill", nNoteId)
      if nil ~= noteCfg then
        local sIconPath = noteCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small
        local nNoteNeed = self._panel.mapNoteNeed[noteCfg.Id]
        if nNoteNeed ~= nil and 0 < nNoteNeed then
          sIconPath = noteCfg.Icon .. AllEnum.DiscSkillIconSurfix.S_Light
        end
        self:SetPngSprite(self._mapNode.imgNote[i], sIconPath)
        NovaAPI.SetTMPText(self._mapNode.textNote[i], LevelData._mapNote[nNoteId] or 0)
        self._mapNode.imgNote[i].gameObject:SetActive(true)
        goLastNoteObj = self._mapNode.imgNote[i].gameObject
      end
    end
  end
  if nil ~= goLastNoteObj then
    goLastNoteObj.transform:Find("ImgLine").gameObject:SetActive(false)
  end
end

function StarTowerFastBattleCtrl:RefreshPerkCount()
  local LevelData = self._panel.LevelData
  for nIndex, nCharId in ipairs(self._panel.tbTeam) do
    local tbPerk = LevelData._mapPotential[nCharId]
    local count = 0
    for _, _ in pairs(tbPerk) do
      count = count + 1
    end
    if nil ~= self._mapNode.textPerkCount[nIndex] then
      NovaAPI.SetTMPText(self._mapNode.textPerkCount[nIndex], count)
    end
  end
end

function StarTowerFastBattleCtrl:RefreshLevelExp()
  local LevelData = self._panel.LevelData
  local nAllExp, bMaxLevel = self:GetTeamNeedExpByLevel(1, LevelData.nTeamLevel)
  if bMaxLevel then
    NovaAPI.SetImageFillAmount(self._mapNode.imgLevelBar, 1)
  else
    NovaAPI.SetImageFillAmount(self._mapNode.imgLevelBar, LevelData.nTeamExp / nAllExp)
  end
  NovaAPI.SetTMPText(self._mapNode.textLevelNum, LevelData.nTeamLevel)
end

function StarTowerFastBattleCtrl:RefreshCoin()
  local nCoinCount = 0
  local LevelData = self._panel.LevelData
  if LevelData._mapItem[AllEnum.CoinItemId.FixedRogCurrency] ~= nil then
    nCoinCount = LevelData._mapItem[AllEnum.CoinItemId.FixedRogCurrency]
    NovaAPI.SetTMPText(self._mapNode.textCoinCount, self:ThousandsNumber(nCoinCount))
  else
    NovaAPI.SetTMPText(self._mapNode.textCoinCount, 0)
  end
  EventManager.Hit("RefreshStarTowerCoin", nCoinCount)
end

function StarTowerFastBattleCtrl:RefreshPauseStatus(bRestart)
  self._mapNode.goAuto.gameObject:SetActive(not self.bPause)
  self._mapNode.goPause.gameObject:SetActive(self.bPause)
end

function StarTowerFastBattleCtrl:GetTeamNeedExpByLevel(nGroupId, nLevel)
  local bMaxLevel = false
  local nNeedExp = 0
  if CacheTable.GetData("_StarTowerTeamExpGroup", nGroupId) ~= nil then
    local nMaxLevel = #CacheTable.GetData("_StarTowerTeamExpGroup", nGroupId)
    bMaxLevel = nLevel >= nMaxLevel
    if nLevel < nMaxLevel then
      local expCfg = CacheTable.GetData("_StarTowerTeamExpGroup", nGroupId)[nLevel + 1]
      nNeedExp = expCfg.NeedExp
    end
  end
  return nNeedExp, bMaxLevel
end

function StarTowerFastBattleCtrl:LeaveStarTower(callback)
  if self._panel.LevelData.bEnd then
    return
  end
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("StarTower_Sweep_BackTips_Content"),
    sConfirm = ConfigTable.GetUIText("StarTower_Sweep_Leave_Btn"),
    sCancel = ConfigTable.GetUIText("StarTower_Sweep_GiveUp_Btn"),
    callbackConfirm = function()
      if self._panel.LevelData.bEnd then
        return
      end
      self._panel.LevelData:StarTowerLeave()
      if callback ~= nil then
        callback()
      end
      PanelManager.Home()
    end,
    callbackCancel = function()
      local function giveUpCallBack()
        if not self._panel.LevelData:EndExploration() then
          return
        end
        local mapStarTowerState = PlayerData.State:GetStarTowerState()
        PlayerData.StarTower:GiveUpReconnect(mapStarTowerState.Id, mapStarTowerState.CharIds, false, function()
          local function wait()
            coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
            
            if callback ~= nil then
              callback()
            end
            EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerFastBattle)
          end
          
          cs_coroutine.start(wait)
        end)
      end
      
      local sContent = ConfigTable.GetUIText("StarTower_Pause_Tips")
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = sContent or "",
        callbackConfirm = giveUpCallBack
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    end,
    bCloseNoHandler = true,
    bRedCancel = true
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function StarTowerFastBattleCtrl:OnHandleCasesOver()
  local function CurHandleCasesOver()
    self:ContinueAfterShop()
  end
  
  local bShop, bMachine, nMachineCount, nDiscount, bFirstFree = self._panel.LevelData:GetShopAndMachine()
  if bShop or bMachine then
    self:OpenShopOption(CurHandleCasesOver, bShop, bMachine, nMachineCount, nDiscount, bFirstFree)
  else
    CurHandleCasesOver()
  end
end

function StarTowerFastBattleCtrl:ContinueAfterShop()
  if self._panel.LevelData.bEnd then
    return
  end
  self.bOpenOption = false
  self.Animator:Play("StarTowerFastBattlePanel_idle")
  if self.bAutoAdvance and not self.bPause then
    self:EnterRoom()
  else
    StarTowerSettingGate.Ready(self, StarTowerSettingGate.Begin())
  end
end

function StarTowerFastBattleCtrl:OpenShopOption(closeCallback, bShop, bMachine, nMachineCount, nDiscount, bFirstFree)
  StarTowerSettingGate.Begin()
  self.bOpenOption = true
  if bShop == nil then
    bShop, bMachine, nMachineCount, nDiscount, bFirstFree = self._panel.LevelData:GetShopAndMachine()
  end
  if bShop or bMachine then
    local bLastShopRoom = self._panel.LevelData:CheckLastShopRoom()
    local nItemCount = self._panel.LevelData._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
    local bAutoDisplay = self._panel.LevelData:IsAutoDecisionEnabled()
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerFastBattleOption, bShop, bMachine, nMachineCount, nItemCount, closeCallback, nDiscount, bFirstFree, bLastShopRoom, bAutoDisplay)
  end
end

function StarTowerFastBattleCtrl:TryResumeAutoShopOption()
  if not self.bOpenOption or not self._panel.LevelData:IsAutoDecisionEnabled() then
    return false
  end
  if self._panel.LevelData:IsAutoDecisionBusy() then
    return true
  end
  return self._panel.LevelData:TryAutoShopEntry(function()
    local bPanelOpen, bPanelActive = PanelManager.CheckPanelOpen(PanelId.StarTowerFastBattleOption)
    if bPanelOpen and bPanelActive then
      EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerFastBattleOption)
    else
      self:ContinueAfterShop()
    end
  end)
end

function StarTowerFastBattleCtrl:OnEvent_StarTowerFastBattleOptionReady()
  self:TryResumeAutoShopOption()
end

function StarTowerFastBattleCtrl:OnBackButtonClick()
  if not self.bHandleOver then
    return
  end
  self:LeaveStarTower()
end

function StarTowerFastBattleCtrl:OnLogButtonClick()
  if not self.bHandleOver then
    return
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerFastBattleLog, self.tbHistoryLog)
end

function StarTowerFastBattleCtrl:OnBulidDetailsButtonClick()
  if not self.bHandleOver then
    return
  end
  local LevelData = self._panel.LevelData
  EventManager.Hit("OpenStarTowerDepot", LevelData._mapPotential, LevelData._mapNote, LevelData._mapFateCard, LevelData._mapItem, LevelData.tbActiveSecondaryIds, AllEnum.StarTowerDepotTog.Potential)
end

function StarTowerFastBattleCtrl:OnRoleDetailsButtonClick()
  if not self.bHandleOver then
    return
  end
  local LevelData = self._panel.LevelData
  EventManager.Hit("OpenStarTowerDepot", LevelData._mapPotential, LevelData._mapNote, LevelData._mapFateCard, LevelData._mapItem, LevelData.tbActiveSecondaryIds, AllEnum.StarTowerDepotTog.Potential)
end

function StarTowerFastBattleCtrl:OnNoteDetailsButtonClick()
  if not self.bHandleOver then
    return
  end
  local LevelData = self._panel.LevelData
  EventManager.Hit("OpenStarTowerDepot", LevelData._mapPotential, LevelData._mapNote, LevelData._mapFateCard, LevelData._mapItem, LevelData.tbActiveSecondaryIds, AllEnum.StarTowerDepotTog.DiscSkill)
end

function StarTowerFastBattleCtrl:OnFastBattleButtonClick()
  if self.bPause and PanelManager.CheckPanelOpen(PanelId.StarTowerAutoDecisionSettingPanel) then
    return
  end
  self.bPause = not self.bPause
  self._panel.LevelData:SetAutoDecisionPaused(self.bPause)
  self:RefreshPauseStatus(true)
  if self.bPause and self.bHandleOver and not self.bOpenOption then
    StarTowerSettingGate.Ready(self, StarTowerSettingGate.Begin())
  end
  if not self.bHandleOver or self.bPause then
    return
  end
  if self.bOpenOption then
    self:TryResumeAutoShopOption()
    return
  end
  if self.nNextCaseId < 0 or 0 > self.nNextRoomType then
    return
  end
  self:EnterRoom()
end

function StarTowerFastBattleCtrl:OnEvent_InitRoom()
  StarTowerSettingGate.Begin()
  StarTowerSettingGate.Transition(self, 0.1 + math.max(1, NovaAPI.GetAnimClipLength(self.Animator, {
    "StarTowerFastBattlePanel_up"
  })))
  self.Animator:Play("StarTowerFastBattlePanel_close")
  self:AddTimer(1, 0.1, function()
    CS.WwiseAudioManager.Instance:PlaySound("ui_startower_fastBattle_elevator")
    self.Animator:Play("StarTowerFastBattlePanel_up")
    local nAnimLen = NovaAPI.GetAnimClipLength(self.Animator, {
      "StarTowerFastBattlePanel_up"
    })
    self:RefreshThemeFlag(nAnimLen)
    self:RefreshRoomBg()
    self:AddTimer(1, nAnimLen, function()
      self:RefreshRoomFloor()
      self:RefreshRoomIcon()
    end, true, true, true)
    self:AddTimer(1, 1, function()
      self._panel.LevelData:HandleCases()
    end, true, true, true)
  end, true, true, true)
end

function StarTowerFastBattleCtrl:OnEvent_EventHandleOver()
  self.bHandleOver = true
  self.nNextCaseId, self.nNextRoomType = self._panel.LevelData:GetDoorCase()
  if self.bOpenOption then
    self:TryResumeAutoShopOption()
    return
  end
  self:OnHandleCasesOver()
end

function StarTowerFastBattleCtrl:OnEvent_EnterDangerRoom(nCaseId, nRoomType)
  self.bHandleOver = true
  self.nNextCaseId = nCaseId
  self.nNextRoomType = nRoomType
  if self.bOpenOption then
    self:TryResumeAutoShopOption()
    return
  end
  self:OnHandleCasesOver()
end

function StarTowerFastBattleCtrl:OnEvent_RefreshFastBattleInfo(tbChangeFateCard, mapChangeNote, mapItemChange, nLevelChange, nExpChange, mapPotentialChange)
  local LevelData = self._panel.LevelData
  self:RefreshPerkCount()
  self:RefreshBuildScore()
  self:RefreshNoteCount()
  self:RefreshLevelExp()
  self:RefreshCoin()
  local mapTower = ConfigTable.GetData("StarTower", LevelData.nTowerId)
  local ntowerName = orderedFormat(ConfigTable.GetUIText("Dungeon_Difficulty") or "", mapTower.Name, ConfigTable.GetUIText("Diffculty_" .. mapTower.Difficulty) or "")
  local towerName = mapTower and ntowerName
  for nId, tbData in pairs(mapChangeNote) do
    if tbData.Qty > 0 then
      local mapItem = ConfigTable.GetData_Item(nId)
      if nil ~= mapItem then
      end
    end
  end
  for nId, changeCount in pairs(mapItemChange) do
    local mapItem = ConfigTable.GetData_Item(nId)
    if nil ~= mapItem then
      if 0 < changeCount then
        table.insert(self.tbTips, {
          bSkill = false,
          nTid = nId,
          nCount = changeCount,
          nTipType = AllEnum.StarTowerTipsType.ItemTip
        })
        table.insert(self.tbHistoryLog, orderedFormat(ConfigTable.GetUIText("StarTower_Sweep_Log_1"), towerName, LevelData.nCurLevel, changeCount, mapItem.Title))
      else
        table.insert(self.tbHistoryLog, orderedFormat(ConfigTable.GetUIText("StarTower_Sweep_Log_4"), towerName, LevelData.nCurLevel, math.abs(changeCount), mapItem.Title))
      end
    end
  end
  for nId, changeInfo in pairs(mapPotentialChange) do
    if 0 < changeInfo.nNextLevel - changeInfo.nLevel then
      local mapItem = ConfigTable.GetData_Item(nId)
      if nil ~= mapItem then
        table.insert(self.tbHistoryLog, orderedFormat(ConfigTable.GetUIText("StarTower_Sweep_Log_2"), towerName, LevelData.nCurLevel, mapItem.Title))
      end
    end
  end
  for _, changeInfo in ipairs(tbChangeFateCard) do
    if changeInfo[4] == 1 then
      local mapItem = ConfigTable.GetData_Item(changeInfo[1])
      if nil ~= mapItem then
        table.insert(self.tbHistoryLog, orderedFormat(ConfigTable.GetUIText("StarTower_Sweep_Log_3"), towerName, LevelData.nCurLevel, mapItem.Title))
      end
    end
  end
  if 0 < #self.tbTips then
    self._mapNode.Tips:StartShowTips(self.tbTips)
    self.tbTips = {}
  end
end

function StarTowerFastBattleCtrl:OnEvent_StarTowerFastBattleOpenShop(bAuto)
  if not self.bOpenOption then
    return
  end
  local bSuccess = self._panel.LevelData:OpenShop(bAuto)
  if not bSuccess then
    printError("打开商店界面失败")
  end
end

function StarTowerFastBattleCtrl:OnEvent_StarTowerFastBattleOpenMachine(bAuto)
  if not self.bOpenOption then
    return
  end
  local bSuccess = self._panel.LevelData:OpenStrengthMachine(bAuto)
  if not bSuccess then
    printError("打开强化界面失败")
  end
end

function StarTowerFastBattleCtrl:OnEvent_DiscSkillActive(tbParam)
  self._panel.LevelData:DiscSkillActive(tbParam)
end

function StarTowerFastBattleCtrl:OnEvent_OpenStarTowerDepot(nTog, nParam)
  if nTog == AllEnum.StarTowerDepotTog.CharInfo then
    printError("星塔扫荡无法打开星塔背包角色页签")
    return
  end
  local LevelData = self._panel.LevelData
  EventManager.Hit("OpenStarTowerDepot", LevelData._mapPotential, LevelData._mapNote, LevelData._mapFateCard, LevelData._mapItem, LevelData.tbActiveSecondaryIds, nTog, nParam)
end

function StarTowerFastBattleCtrl:OnEvent_RefreshNoteCount()
  self:RefreshNoteCount()
end

function StarTowerFastBattleCtrl:OnEvent_TryCloseStarTowerLastShop(bMachine, nMachineCost)
  local nMinPrice = self._panel.LevelData:GetShopMinPrice()
  if bMachine then
    nMinPrice = -1 < nMinPrice and math.min(nMinPrice, nMachineCost) or nMachineCost
  end
  local nCurCoin = self._panel.LevelData._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  
  local function closePanel()
    EventManager.Hit(EventId.ClosePanel, PanelId.StarTowerFastBattleOption)
  end
  
  if nMinPrice <= nCurCoin and -1 < nMinPrice then
    local data = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = ConfigTable.GetUIText("StarTower_FastBattle_Shop_Tip"),
      callbackConfirm = closePanel
    }
    EventManager.Hit(EventId.OpenMessageBox, data)
  else
    closePanel()
  end
end

function StarTowerFastBattleCtrl:OnEvent_AffinityTips(nNpcId, nAffinity)
  local tbTips = {}
  table.insert(tbTips, {
    nNPCId = nNpcId,
    nAffinity = nAffinity,
    nTipType = AllEnum.StarTowerTipsType.NPCAffinity
  })
  self._mapNode.Tips:StartShowTips(tbTips)
end

function StarTowerFastBattleCtrl:OnEvent_Leave(callback)
  self:LeaveStarTower(callback)
end

function StarTowerFastBattleCtrl:OnEvent_LeaveForRecharge(callback)
  self._panel.LevelData:StarTowerLeave()
  self._func_OpenRechargeAfterLeave = callback
  PanelManager.Home()
end

function StarTowerFastBattleCtrl:OnEvent_AutoDecisionStateChanged(mapState)
  if self._panel.LevelData.bEnd then
    return
  end
  if type(mapState) ~= "table" or mapState.bEnabled ~= true or mapState.bPaused == true then
    return
  end
  if self.bAutoAdvance and not self.bPause then
    return
  end
  self.bAutoAdvance = true
  self.bPause = false
  self:RefreshPauseStatus()
end

function StarTowerFastBattleCtrl:OnEvent_AutoDecisionRequestFailed(objLevelData)
  if self._panel.LevelData ~= objLevelData or objLevelData.bEnd then
    return
  end
  self.bPause = true
  self:RefreshPauseStatus()
  if not objLevelData:HasPendingCases() then
    local bShop, bMachine = objLevelData:GetShopAndMachine()
    if bShop or bMachine then
      self:OnEvent_AutoDecisionRequestManual()
    end
  end
end

function StarTowerFastBattleCtrl:OnEvent_AutoDecisionRequestManual()
  local bNpcOptionOpen = PanelManager.CheckPanelOpen(PanelId.NpcOptionPanel)
  if bNpcOptionOpen then
    return
  end
  if self._panel.LevelData:HasPendingCases() then
    self._panel.LevelData:HandleCases()
    return
  end
  local bShop, bMachine = self._panel.LevelData:GetShopAndMachine()
  if bShop or bMachine then
    if not self.bOpenOption then
      self:OpenShopOption(function()
        self:ContinueAfterShop()
      end)
    end
    return
  end
  self._panel.LevelData:HandleCases()
end

return StarTowerFastBattleCtrl
