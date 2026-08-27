local base = UIBaseNode
local UINWarChessMain_PlayNode = class("UINWarChessMain_PlayNode", base)
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local UINWarChessMain_PNSelectedTeamInfo = require("Game.WarChess.UI.Main.UINWarChessMain_PNSelectedTeamInfo")
local UINWarChessMain_PNTeamItem = require("Game.WarChess.UI.Main.UINWarChessMain_PNTeamItem")
local UINWarChessMain_PNTeamDeadItem = require("Game.WarChess.UI.Main.UINWarChessMain_PNTeamDeadItem")
local UINWarChessChipBag = require("Game.WarChess.UI.Chip.UINWarChessChipBag")

function UINWarChessMain_PlayNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_TurnEnd, self, self.OnClickTurnOver)
  UIUtil.AddButtonListener(self.ui.btn_DeployNewTeam, self, self.OnClickDeployNewTeam)
  UIUtil.AddButtonListener(self.ui.btn_RewardBag, self, self.OnClickPreviewWCRB)
  self.teamInfo = UINWarChessMain_PNSelectedTeamInfo.New()
  self.teamInfo:Init(self.ui.obj_selectedTeamInfoNode)
  self.teamInfo:BindSelectTeamEvent(BindCallback(self, self.OpenWCTeamChipBag))
  self.strategyBar = nil
  self.ui.obj_StrategyBar:SetActive(false)
  self.teamItemPool = UIItemPool.New(UINWarChessMain_PNTeamItem, self.ui.obj_teamNode)
  self.ui.obj_teamNode:SetActive(false)
  self.teamDeathItemPool = UIItemPool.New(UINWarChessMain_PNTeamDeadItem, self.ui.obj_teamNode_Death)
  self.ui.obj_teamNode_Death:SetActive(false)
  self.__teamItemDic = nil
  self.__deadTeamItemDic = nil
  self.__onClickTeamUI = BindCallback(self, self.OnClickTeamUI)
  self.__onSelectedTeamChange = BindCallback(self, self.OnSelectedTeamChange)
  MsgCenter:AddListener(eMsgEventId.WC_SelectTeam, self.__onSelectedTeamChange)
  self.__onTeamApChange = BindCallback(self, self.OnTeamApChange)
  MsgCenter:AddListener(eMsgEventId.WC_TeamAPChange, self.__onTeamApChange)
  self.__onTeamPowChange = BindCallback(self, self.OnTeamPowChange)
  MsgCenter:AddListener(eMsgEventId.WC_TeamPowerChange, self.__onTeamPowChange)
  self.__onWCChipChanged = BindCallback(self, self.OnWCChipChanged)
  MsgCenter:AddListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
  self.__onTeamHeroUpdate = BindCallback(self, self._OnTeamHeroInfoUpdate)
  MsgCenter:AddListener(eMsgEventId.WC_HeroDynUpdate, self.__onTeamHeroUpdate)
  self.__onChipLimitChange = BindCallback(self, self.OnChipLimitChange)
  MsgCenter:AddListener(eMsgEventId.OnChipLimitChange, self.__onChipLimitChange)
  self.__onTrunStart = BindCallback(self, self.OnTurnStart)
  MsgCenter:AddListener(eMsgEventId.WC_TurnStart, self.__onTrunStart)
  self.__onTrunStartTweenOver = BindCallback(self, self.OnTurnStartTweenOver)
  MsgCenter:AddListener(eMsgEventId.WC_TurnStarTweenOver, self.__onTrunStartTweenOver)
  self.__refreshWCDynDeployShow = BindCallback(self, self.RefreshWCDynDeployShow)
  MsgCenter:AddListener(eMsgEventId.WC_DeployTeamChange, self.__refreshWCDynDeployShow)
  self.__onWCTimeRewind = BindCallback(self, self.OnWCTimeRewind)
  MsgCenter:AddListener(eMsgEventId.WC_TimeRewind, self.__onWCTimeRewind)
  self.__refreshAllTeamInfo = BindCallback(self, self.RefreshAllTeamInfo)
  MsgCenter:AddListener(eMsgEventId.WC_TeamStateUpdate, self.__refreshAllTeamInfo)
  self.__onWCTeamLaderChange = BindCallback(self, self.__OnWCTeamLaderChange)
  MsgCenter:AddListener(eMsgEventId.WC_TeamLeaderChange, self.__onWCTeamLaderChange)
  self._onTeamHeroSTCInfoUpdate = BindCallback(self, self._OnTeamHeroSTCInfoUpdate)
  MsgCenter:AddListener(eMsgEventId.WC_TeamHeroSTCUpdate, self._onTeamHeroSTCInfoUpdate)
end

function UINWarChessMain_PlayNode:InitWarChessPlayNode(wcPlayState, curTeamData, resloader)
  self.wcPlayerState = wcPlayState
  self.wcCtrl = wcPlayState.wcCtrl
  self.resloader = resloader
  self:RefreshAllTeamInfo()
  self:OnSelectedTeamChange(curTeamData)
  self:RefreshWCDynDeployShow()
  self:RefreshWCStrategyBar()
  self:RefreshPreivewWCRBShow()
  if WarChessSeasonManager:GetIsInWCSeasonIsInLobby() then
    self.ui.btn_TurnEnd.gameObject:SetActive(false)
  end
  if WarChessSeasonManager:GetIsInWCSeason() then
    self.ui.btn_DeployNewTeam.gameObject:SetActive(false)
  end
end

function UINWarChessMain_PlayNode:RefreshAllTeamInfo()
  self.__teamItemDic = {}
  self.__deadTeamItemDic = {}
  self.teamItemPool:HideAll()
  self.teamDeathItemPool:HideAll()
  local maxFmtNum = self.wcCtrl.teamCtrl:GetWCFmtNum()
  for teamIndex = 1, maxFmtNum do
    local teamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamIndexIgnoreDead(teamIndex)
    if teamData ~= nil then
      local isDead = teamData:GetWCTeamIsDead()
      if isDead then
        local deadTeamItem = self.teamDeathItemPool:GetOne()
        deadTeamItem:InitWCPlayTeamItem(teamData, self.wcCtrl, self.resloader)
        self.__deadTeamItemDic[teamIndex] = deadTeamItem
      else
        local teamItem = self.teamItemPool:GetOne()
        teamItem:InitWCPlayTeamItem(teamData, self.wcCtrl, self.resloader)
        teamItem:SetWCPNTeamItemOnClickFunc(self.__onClickTeamUI)
        self.__teamItemDic[teamIndex] = teamItem
      end
    end
  end
end

function UINWarChessMain_PlayNode:OnClickTurnOver()
  if not self.wcCtrl:IsCouldMainMapInteract() then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8516))
    return
  end
  if self.wcCtrl.teamCtrl:WcAllTeamHasAp() then
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
      if win == nil then
        return
      end
      win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(8509), function()
        self.wcCtrl.turnCtrl:SendTurnOver()
      end, nil)
    end)
    return
  end
  self.wcCtrl.turnCtrl:SendTurnOver()
end

function UINWarChessMain_PlayNode:RefreshWCDynDeployShow()
  local maxFmtNum = self.wcCtrl.teamCtrl:GetWCFmtNum()
  local curFmtNum = self.wcCtrl.teamCtrl:GetWCFmtCurNum()
  self.ui.tex_TeamCount:SetIndex(0, tostring(curFmtNum), tostring(maxFmtNum))
end

function UINWarChessMain_PlayNode:OnClickDeployNewTeam()
  if not self.wcCtrl:IsCouldMainMapInteract() then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8516))
    return
  end
  if self.wcCtrl.backPackCtrl:GetWCDeployPointNum() < 1 then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8523))
  end
  self.wcCtrl:ChangeWarChessState(eWarChessEnum.eWarChessState.deploy, {isDynDeploy = true})
end

function UINWarChessMain_PlayNode:OnClickTeamUI(teamItem)
  if self.wcCtrl.state == eWarChessEnum.eWarChessState.play then
    local teamData = teamItem.teamData
    local teamIndex = teamData:GetWCTeamIndex()
    local heroEntity = self.wcCtrl.teamCtrl:GetWCHeroEntity(teamIndex, nil, nil)
    local showPos = heroEntity:WCHeroEntityGetShowPos()
    local isSucess, isSelected = self.wcCtrl.curState:WCPlayStateSelectTeam(teamData, true)
    if isSucess and isSelected then
      self.wcCtrl.wcCamCtrl:SetWcCamFollowPos(showPos)
    end
  end
end

function UINWarChessMain_PlayNode:OnSelectedTeamChange(teamData)
  if teamData == nil then
    self.teamInfo:Hide()
  else
    self.teamInfo:Show()
    self.teamInfo:RefreshWCTeamInfo(teamData, self.resloader)
  end
  local isUpdated = false
  if teamData == nil then
    for teamIndex, teamItem in pairs(self.__teamItemDic) do
      isUpdated = teamItem:ChangeWCPNTeamApperance(true) or isUpdated
    end
  else
    local curIndex = teamData:GetWCTeamIndex()
    for teamIndex, teamItem in pairs(self.__teamItemDic) do
      if teamIndex == curIndex then
        isUpdated = teamItem:ChangeWCPNTeamApperance(false) or isUpdated
      else
        isUpdated = teamItem:ChangeWCPNTeamApperance(true) or isUpdated
      end
    end
  end
  if isUpdated then
    CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.teamRect)
  end
end

function UINWarChessMain_PlayNode:OnTeamApChange(teamData)
  if self.__teamItemDic == nil or teamData == nil then
    return
  end
  local teamIndex = teamData:GetWCTeamIndex()
  local teamItem = self.__teamItemDic[teamIndex]
  if teamItem ~= nil then
    teamItem:RefreshTeamAP(teamData)
  end
end

function UINWarChessMain_PlayNode:OnWCTimeRewind()
  self:RefreshAllTeamInfo()
end

function UINWarChessMain_PlayNode:OnTeamPowChange(teamData)
  if self.__teamItemDic == nil or teamData == nil then
    return
  end
  local teamIndex = teamData:GetWCTeamIndex()
  local teamItem = self.__teamItemDic[teamIndex]
  if teamItem ~= nil then
    teamItem:RefreshTeamPower(teamData)
  end
end

function UINWarChessMain_PlayNode:OpenWCTeamChipBag(teamData, callbcak)
  local wcDynPlayer = teamData:GetTeamDynPlayer()
  if #wcDynPlayer.chipList <= 0 then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8505))
    return false
  end
  if self._wcChipBag == nil then
    self._wcChipBag = UINWarChessChipBag.New()
    self._wcChipBag:Init(self.ui.obj_chipBag)
  end
  self._wcChipBag:SetWCCBCloseCallback(callbcak)
  self._wcChipBag:Show()
  self._wcChipBag:InitWCTeamChipBag(teamData)
  return true
end

function UINWarChessMain_PlayNode:OnWCChipChanged(chipList, dynPlayer)
  local teamData = self.teamInfo:GetWCSelectTeamData()
  if teamData == nil then
    return
  end
  local wcDynPlayer = teamData:GetTeamDynPlayer()
  if wcDynPlayer ~= dynPlayer then
    return
  end
  self.teamInfo:RefreshWCTeamInfoChip(true)
  if self._wcChipBag ~= nil and self._wcChipBag.active then
    self._wcChipBag:InitWCTeamChipBag(teamData)
  end
end

function UINWarChessMain_PlayNode:_OnTeamHeroInfoUpdate()
  local steamData = self.teamInfo:GetWCSelectTeamData()
  if steamData == nil then
    return
  end
  self.teamInfo:RefreshWCTeamInfoHeroHp()
  if self.__teamItemDic ~= nil then
    for teamIndex, teamItem in pairs(self.__teamItemDic) do
      local teamData = teamItem.teamData
      local isDead = teamData:GetWCTeamIsDead()
      if not isDead then
        teamItem:RefreshTeamHp(teamData)
      end
    end
  end
end

function UINWarChessMain_PlayNode:_OnTeamHeroSTCInfoUpdate()
  local steamData = self.teamInfo:GetWCSelectTeamData()
  if steamData == nil then
    return
  end
  self.teamInfo:RefreshWCTeamHeroList()
end

function UINWarChessMain_PlayNode:__OnWCTeamLaderChange()
  local maxFmtNum = self.wcCtrl.teamCtrl:GetWCFmtNum()
  for teamIndex = 1, maxFmtNum do
    local teamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamIndexIgnoreDead(teamIndex)
    if teamData ~= nil then
      local isDead = teamData:GetWCTeamIsDead()
      if isDead then
        local deadTeamItem = self.__deadTeamItemDic[teamIndex]
        deadTeamItem:RefreshTeamLeaderPic()
      else
        local teamItem = self.__teamItemDic[teamIndex]
        teamItem:RefreshTeamLeaderPic()
      end
    end
  end
end

function UINWarChessMain_PlayNode:OnChipLimitChange()
  self.teamInfo:RefreshWCTeamInfoChip()
end

function UINWarChessMain_PlayNode:OnTurnStart()
  self.ui.tween_window:DOPlayForward()
  self.ui.tween_window:DORestartById("Out")
  self.ui.obj_BlockClick:SetActive(true)
end

function UINWarChessMain_PlayNode:OnTurnStartTweenOver()
  self.ui.tween_window:DOPlayBackwards()
  self.ui.tween_window:DOPlayBackwardsById("Out")
  self.ui.obj_BlockClick:SetActive(false)
end

function UINWarChessMain_PlayNode:RefreshWCStrategyBar()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local isHaveStrategy = wcCtrl.wcStragegyCtrl:GetWCIsHaveStrategy()
  if not isHaveStrategy then
    return
  end
  if self.strategyBar == nil then
    local UINWarChessMain_PNStrategyBar = require("Game.WarChess.UI.Main.UINWarChessMain_PNStrategyBar")
    self.strategyBar = UINWarChessMain_PNStrategyBar.New()
    self.strategyBar:Init(self.ui.obj_StrategyBar)
    self.strategyBar:InitWCStrategyBar()
    self.strategyBar:Show()
  end
end

function UINWarChessMain_PlayNode:RefreshPreivewWCRBShow()
  local isHaveRB = self.wcCtrl.backPackCtrl:GetIsWCHaveRewardBag()
  self.ui.btn_RewardBag.gameObject:SetActive(isHaveRB)
end

function UINWarChessMain_PlayNode:OnClickPreviewWCRB()
  if not self.wcCtrl:IsCouldMainMapInteract() then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EpRewardPreview, function(window)
    if window == nil then
      return
    end
    local rewardList = self.wcCtrl.backPackCtrl:GetIsWCRewardBagItemList()
    local epModuleId, stageId
    local isInWCS = WarChessSeasonManager:IsInWCS()
    if isInWCS then
      local towerId = WarChessSeasonManager:GetWCSSeasonTowerID()
      local wcsTowerShopDropCfg = ConfigData.warchess_tower_shop_drop[towerId]
      epModuleId = proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason
      if wcsTowerShopDropCfg == nil then
        error("wcs not have reward bag config, but server send it, pls check")
      end
      local fakeStageId = wcsTowerShopDropCfg.stage_id
      stageId = fakeStageId
    else
      local sectorStageCfg = WarChessManager:GetWCSectorStageCfg()
      epModuleId = proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess
      stageId = sectorStageCfg.id
    end
    window:InitEpRewardPreview(rewardList, epModuleId, stageId)
  end)
end

function UINWarChessMain_PlayNode:StartFlyWCRewardBag(worldPos, Overfunc)
  self.__worldPos = worldPos
  self.__Overfunc = Overfunc
  local matBg = self.ui.fx_lineBg:GetMaterial()
  local mat = self.ui.fx_line:GetMaterial()
  matBg:SetFloat("_BFAlpha", 0)
  mat:SetFloat("_BFAlpha", 0)
  matBg:SetFloat("_BFPanner01", 0)
  if self.__rewardFlyTween == nil then
    local CS_DOTween = CS.DG.Tweening.DOTween
    local sequence = CS_DOTween.Sequence()
    sequence:SetAutoKill(false)
    sequence:AppendInterval(1)
    sequence:AppendCallback(function()
      local wcMain = UIManager:GetWindow(UIWindowTypeID.WarChessMain)
      local pos = UIManager:World2UIPosition(self.__worldPos, wcMain.transform)
      local dpos = wcMain.transform:InverseTransformPoint(self.ui.fx_RewardBag.transform.position)
      local startPos = Vector3.New(pos.x, pos.y)
      local destPos = Vector3.New(dpos.x, dpos.y)
      local width = destPos.x - startPos.x
      local height = startPos.y - destPos.y
      local numPos = #ConfigData.buildinConfig.RewardBagFlyOffset + 2
      self.ui.fx_lineBg.positionCount = numPos
      self.ui.fx_line.positionCount = numPos
      self.ui.fx_lineBg:SetPosition(0, startPos)
      self.ui.fx_line:SetPosition(0, startPos)
      for index, v in pairs(ConfigData.buildinConfig.RewardBagFlyOffset) do
        local x = startPos.x + v[1] * width
        local y = destPos.y + v[2] * height
        local newPos = Vector3.New(x, y, 0)
        self.ui.fx_lineBg:SetPosition(index, newPos)
        self.ui.fx_line:SetPosition(index, newPos)
      end
      self.ui.fx_lineBg:SetPosition(numPos - 1, destPos)
      self.ui.fx_line:SetPosition(numPos - 1, destPos)
      self.ui.fX_RoomMap_Linerender:SetActive(true)
      self.ui.fx_RewardBag:SetActive(false)
    end)
    sequence:Append(matBg:DOFloat(1, "_BFAlpha", ConfigData.buildinConfig.RewardBagFlyAppear))
    sequence:Join(mat:DOFloat(1, "_BFAlpha", ConfigData.buildinConfig.RewardBagFlyAppear))
    sequence:AppendCallback(function()
      self.ui.fx_RewardBag:SetActive(true)
    end)
    sequence:Append(matBg:DOFloat(1, "_BFPanner01", ConfigData.buildinConfig.RewardBagFlyTime))
    sequence:Join(mat:DOFloat(0, "_BFAlpha", ConfigData.buildinConfig.RewardBagFlyDisappear):SetDelay(ConfigData.buildinConfig.RewardBagFlyTime * ConfigData.buildinConfig.RewardBagDisappearRatio))
    sequence:AppendCallback(function()
      self.ui.fX_RoomMap_Linerender:SetActive(false)
      if self.__Overfunc ~= nil then
        self.__Overfunc()
      end
    end)
    self.__rewardFlyTween = sequence
  else
    self.__rewardFlyTween:Restart()
  end
end

function UINWarChessMain_PlayNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WC_SelectTeam, self.__onSelectedTeamChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_TeamAPChange, self.__onTeamApChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_TeamPowerChange, self.__onTeamPowChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_ChipChange, self.__onWCChipChanged)
  MsgCenter:RemoveListener(eMsgEventId.WC_HeroDynUpdate, self.__onTeamHeroUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnChipLimitChange, self.__onChipLimitChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_TurnStart, self.__onTrunStart)
  MsgCenter:RemoveListener(eMsgEventId.WC_TurnStarTweenOver, self.__onTrunStartTweenOver)
  MsgCenter:RemoveListener(eMsgEventId.WC_DeployTeamChange, self.__refreshWCDynDeployShow)
  MsgCenter:RemoveListener(eMsgEventId.WC_TimeRewind, self.__onWCTimeRewind)
  MsgCenter:RemoveListener(eMsgEventId.WC_TeamStateUpdate, self.__refreshAllTeamInfo)
  MsgCenter:RemoveListener(eMsgEventId.WC_TeamLeaderChange, self.__onWCTeamLaderChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_TeamHeroSTCUpdate, self._onTeamHeroSTCInfoUpdate)
  if self.teamInfo ~= nil then
    self.teamInfo:Delete()
  end
  if self._wcChipBag ~= nil then
    self._wcChipBag:Delete()
  end
  if self.strategyBar ~= nil then
    self.strategyBar:Delete()
  end
  base.OnDelete(self)
end

return UINWarChessMain_PlayNode
