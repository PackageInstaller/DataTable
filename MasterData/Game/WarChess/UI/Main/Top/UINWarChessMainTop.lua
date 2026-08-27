local base = UIBaseNode
local UINWarChessMainTop = class("UINWarChessMainTop", UIBaseNode)
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINWCBuffList = require("Game.WarChess.UI.Main.BuffList.UINWCBuffList")
local UINWarChessMainTop_PressBar = require("Game.WarChess.UI.Main.Top.UINWarChessMainTop_PressBar")
local UINWarChessMainTop_PressPanel = require("Game.WarChess.UI.Main.Top.UINWarChessMainTop_PressPanel")
local UINWarChessMainTop_Goal = require("Game.WarChess.UI.Main.Top.UINWarChessMainTop_Goal")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = CS.DG.Tweening.DOTween

function UINWarChessMainTop:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_pressureBar, self, self.ShowWCPressFrameNode)
  UIUtil.AddButtonListener(self.ui.btn_Menu, self, self.OnClickMenu)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnClickBtnInfo)
  UIUtil.AddButtonListener(self.ui.btn_Rewind, self, self.OnClickWCTimeRewind)
  UIUtil.AddButtonListener(self.ui.btn_SelectDungeon, self, self.OnClickWCSSelectLevel)
  self.resloader = CS.ResLoader.Create()
  self.resourceGroup = UINResourceGroup.New()
  self.resourceGroup:Init(self.ui.obj_gameResourceGroup)
  self.resourceGroup:Hide()
  self.buffList = UINWCBuffList.New()
  self.buffList:Init(self.ui.obj_buffList)
  self.buffList:Hide()
  self.pressBarNode = UINWarChessMainTop_PressBar.New()
  self.pressBarNode:Init(self.ui.obj_pressureBar)
  self.pressBarNode:Hide()
  self.pressNode = UINWarChessMainTop_PressPanel.New()
  self.pressNode:Init(self.ui.obj_pressureFrame)
  self.pressNode:Hide()
  self.GoalNode = UINWarChessMainTop_Goal.New()
  self.GoalNode:Init(self.ui.obj_goalNode)
  self.GoalNode:Hide()
  self.pressBarNode:BindPressResloader(self.resloader)
  self.pressNode:BindPressResloader(self.resloader)
  self.__onTrunNumChange = BindCallback(self, self.OnTrunNumChange)
  MsgCenter:AddListener(eMsgEventId.WC_TurnStart, self.__onTrunNumChange)
  self.__onCoinNumChange = BindCallback(self, self.OnCoinNumChange)
  MsgCenter:AddListener(eMsgEventId.WC_CoinNumChange, self.__onCoinNumChange)
  self.__refreshBuffList = BindCallback(self, self.RefreshBuffList)
  MsgCenter:AddListener(eMsgEventId.WC_BuffChange, self.__refreshBuffList)
  self.__onWCPressChange = BindCallback(self, self.OnWCPressChange)
  MsgCenter:AddListener(eMsgEventId.WC_StressPointChange, self.__onWCPressChange)
  self.__onTimeRewind = BindCallback(self, self.OnTimeRewind)
  MsgCenter:AddListener(eMsgEventId.WC_TimeRewind, self.__onTimeRewind)
end

function UINWarChessMainTop:ShowWCDeployInfo()
  self.ui.obj_ResList:SetActive(false)
  self.resourceGroup:Hide()
  self.wcCtrl = WarChessManager:GetWarChessCtrl()
  self.resourceGroup:SetResourceIds({
    ConstGlobalItem.SKey
  })
  self.GoalNode:Show()
  self:RefreshWCGameGoal()
  self:RefreshLobbyCouldShowUI(false)
  self:__RefreshWCInfoBtn()
end

function UINWarChessMainTop:ShowWCPlayInfo(wcCtrl)
  self.ui.obj_ResList:SetActive(true)
  self.resourceGroup:Hide()
  self.buffList:Show()
  self.pressBarNode:Show()
  self.wcCtrl = wcCtrl
  self:OnTrunNumChange(self.wcCtrl.turnCtrl:GetWCTurnNum())
  self:OnCoinNumChange(ConstGlobalItem.WCMoney, self.wcCtrl.backPackCtrl:GetWCCoinNum())
  self:OnCoinNumChange(ConstGlobalItem.WCDeployPoint, self.wcCtrl.backPackCtrl:GetWCDeployPointNum())
  self:RefreshBuffList()
  self.GoalNode:Show()
  self:RefreshWCGameGoal()
  self:OnWCPressChange()
  self:__RefreshWCTimeRewindBtnCouldShow()
  self:RefreshLobbyCouldShowUI(true)
  self:__RefreshWCInfoBtn()
end

function UINWarChessMainTop:RefreshLobbyCouldShowUI(isPlay)
  if not WarChessSeasonManager:GetIsInWCSeason() then
    return
  end
  local wcsCtrl = WarChessSeasonManager:GetWCSCtrl()
  if WarChessSeasonManager:GetIsInWCSeasonIsInLobby() then
    self.GoalNode:Hide()
    self.pressBarNode:Hide()
    self.ui.obj_turn:SetActive(false)
    self.ui.obj_seasonTitle:SetActive(true)
    local towerID = WarChessSeasonManager:GetWCSSeasonTowerID()
    local floorIndex = WarChessSeasonManager:GetWCSCtrl():WCSGetFloor()
    local floorCfg = ConfigData.warchess_season_floor[towerID][floorIndex]
    self.ui.tex_Title.text = LanguageUtil.GetLocaleText(floorCfg.hall_level_name)
    self.ui.btn_SelectDungeon.gameObject:SetActive(isPlay)
  end
  if not WarChessSeasonManager:GetIsInWCSeasonIsInLobby() then
    local roomData = wcsCtrl:WCSGetSurWCSRoomData()
    if roomData == nil then
      error("roomData not exist")
      return
    end
    local roomId = roomData.RoomId
    local seasonLevelCfg = ConfigData.warchess_season_level[roomId]
    if seasonLevelCfg == nil then
      error("seasonLevelCfg not exist id:" .. tostring(roomId))
      return
    end
    self.ui.tex_WCSLevelName.gameObject:SetActive(true)
    self.ui.tex_WCSLevelName.text = LanguageUtil.GetLocaleText(seasonLevelCfg.level_explain)
  else
    self.ui.tex_WCSLevelName.gameObject:SetActive(false)
  end
end

function UINWarChessMainTop:RefreshWCGameGoal()
  self.GoalNode:RefreshWCGoal()
end

function UINWarChessMainTop:OnTrunNumChange(num)
  self.ui.tex_turnNum.text = tostring(num)
end

function UINWarChessMainTop:OnCoinNumChange(itemId, num)
  if itemId == ConstGlobalItem.WCMoney then
    self.ui.tex_CoinNum2.text = tostring(num)
  else
    self.ui.tex_CoinNum1.text = tostring(num)
  end
end

function UINWarChessMainTop:OnTimeRewind()
  self:OnTrunNumChange(self.wcCtrl.turnCtrl:GetWCTurnNum())
  self:OnCoinNumChange(ConstGlobalItem.WCMoney, self.wcCtrl.backPackCtrl:GetWCCoinNum())
  self:OnCoinNumChange(ConstGlobalItem.WCDeployPoint, self.wcCtrl.backPackCtrl:GetWCDeployPointNum())
  self:RefreshBuffList()
  self.GoalNode:Show()
  self:RefreshWCGameGoal()
  self.pressBarNode:RefreshWCPress(true)
  self:__RefreshWCTimeRewindBtnCouldShow()
end

function UINWarChessMainTop:OnWCPressChange()
  self.pressBarNode:RefreshWCPress()
end

function UINWarChessMainTop:RefreshBuffList()
  local buffDic = self.wcCtrl.backPackCtrl:GetWCBuffDic()
  self.buffList:RefreshWCBuffList(buffDic)
end

function UINWarChessMainTop:ShowWCPressFrameNode()
  self.pressNode:RefreshWCPressFrame()
  self.pressNode:Show()
  if self.wcCtrl.state == eWarChessEnum.eWarChessState.play then
    self.wcCtrl.curState:WCHideInteract()
  end
end

function UINWarChessMainTop:OnClickMenu()
  if self.wcCtrl ~= nil and (self.wcCtrl:IsWCInSubSystem() or not self.wcCtrl.curState:IsCanOpenMenu()) then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.BattlePause, function(win)
    if win == nil then
      return
    end
    win:InitBattlePause(function()
      local isHaveReward = #(self.wcCtrl.backPackCtrl:GetIsWCRewardBagItemList() or table.emptytable) > 0
      local tipStr
      if isHaveReward then
        tipStr = ConfigData:GetTipContent(8534)
      else
        tipStr = ConfigData:GetTipContent(8517)
      end
      cs_MessageCommon.ShowMessageBox(tipStr, function()
        WarChessManager:GiveUpWarchess()
      end, nil)
    end)
    win:SetAboutBattleUIActive(false)
    win:SetBtPauseReturn2HomeFunc(function()
      WarChessManager:ExitWarChess(Consts.SceneName.Main)
    end)
  end)
end

function UINWarChessMainTop:__RefreshWCInfoBtn()
  local introId = ConfigData.game_config.guideTipWarChess
  if WarChessSeasonManager:GetIsInWCSeason() then
    local wcsCtrl = WarChessSeasonManager:GetWCSCtrl()
    introId = wcsCtrl:GetWCSSeasonTipId()
  end
  if introId == nil or introId == 0 then
    self.ui.btn_Info.gameObject:SetActive(false)
  else
    self.ui.btn_Info.gameObject:SetActive(true)
  end
end

function UINWarChessMainTop:OnClickBtnInfo()
  local introId = ConfigData.game_config.guideTipWarChess
  if WarChessSeasonManager:GetIsInWCSeason() then
    local wcsCtrl = WarChessSeasonManager:GetWCSCtrl()
    introId = wcsCtrl:GetWCSSeasonTipId()
  end
  self:__OpenWarChessGuidePicture(introId)
end

function UINWarChessMainTop:__RefreshWCTimeRewindBtnCouldShow()
  local rewindTotalTime, rewindLeftTime = self.wcCtrl.turnCtrl:GetWCRewindTimes()
  self.ui.btn_Rewind.gameObject:SetActive(0 < rewindTotalTime)
end

function UINWarChessMainTop:OnClickWCTimeRewind()
  if self.wcCtrl == nil or self.wcCtrl:IsWCInSubSystem() or self.wcCtrl.state ~= eWarChessEnum.eWarChessState.play then
    return
  end
  local rewindTotalTime, rewindLeftTime = self.wcCtrl.turnCtrl:GetWCRewindTimes()
  if rewindLeftTime <= 0 then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8528))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessTimeRewind, function(win)
    if win ~= nil then
      win:InitWCTimeRewind()
    end
  end)
end

function UINWarChessMainTop:OnClickWCSSelectLevel()
  if self.wcCtrl:IsWCInSubSystem() then
    return
  end
  if WarChessSeasonManager:GetIsInWCSeasonIsInLobby() then
    local datas = WarChessSeasonManager:GetWCSCtrl():WCSGetLobbyNextRoomDataMsg()
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessSeasonSelectLevel, function(win)
      if win == nil then
        return
      end
      win:InitWCSLevelInfo(datas)
      win:WCSPlayAniSelectLevel(false, nil, 1.25)
    end)
  end
end

function UINWarChessMainTop:__OpenWarChessGuidePicture(introId)
  local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
  GuidePicture.OpenGuidePicture(introId, nil)
end

function UINWarChessMainTop:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WC_TurnStart, self.__onTrunNumChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_CoinNumChange, self.__onCoinNumChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_BuffChange, self.__refreshBuffList)
  MsgCenter:RemoveListener(eMsgEventId.WC_StressPointChange, self.__onWCPressChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_TimeRewind, self.__onTimeRewind)
  self.resourceGroup:Delete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.pressBarNode:Delete()
end

return UINWarChessMainTop
