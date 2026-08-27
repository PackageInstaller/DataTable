local base = UIBaseNode
local UINWarChessMain_DeployNode = class("UINWarChessMain_DeployNode", base)
local FmtEnum = require("Game.Formation.FmtEnum")
local UINWarChessMain_DNTeamItem = require("Game.WarChess.UI.Main.UINWarChessMain_DNTeamItem")

function UINWarChessMain_DeployNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_BattleStart, self, self.__OnClickBattle)
  UIUtil.AddButtonListener(self.ui.btn_ApplyDynDeploy, self, self.__OnClickApplyDynDeploy)
  UIUtil.AddButtonListener(self.ui.btn_ExitDynDeploy, self, self.__OnClickExitDynDeploy)
  self.teamItemPool = UIItemPool.New(UINWarChessMain_DNTeamItem, self.ui.teamItem)
  self.ui.teamItem:SetActive(false)
  self.__index2TeamItemDic = {}
  self.__onClickCurTeam = BindCallback(self, self.__OnClickCurTeam)
  self.__onEnterFmt = BindCallback(self, self.__OnEnterFmt)
  self.__onExitFmt = BindCallback(self, self.__OnExitFmt)
  self.__onDeployOver = BindCallback(self, self.__OnDeployOver)
  self.__onChangeDrag2Scroll = BindCallback(self, self.__OnChangeDrag2Scroll)
  self.__onDeployTeamChange = BindCallback(self, self.OnDeployTeamChange)
  MsgCenter:AddListener(eMsgEventId.WC_DeployTeamChange, self.__onDeployTeamChange)
  self.__onWCIsDeployingHeroChange = BindCallback(self, self.OnWCIsDeployingHeroChange)
  MsgCenter:AddListener(eMsgEventId.WC_DeployingTeam, self.__onWCIsDeployingHeroChange)
end

function UINWarChessMain_DeployNode:InitWarChessDeployNode(deployState, resloader)
  self.deployState = deployState
  self.wcCtrl = self.deployState.wcCtrl
  self.resloader = resloader
  local isDynDeploy = deployState:GetIsDynDeploy()
  self.ui.obj_deploy:SetActive(not isDynDeploy)
  self.ui.obj_dynDeploy:SetActive(isDynDeploy)
  if not isDynDeploy then
    self:RefreshLevelInfo()
  else
  end
  self:RefreshTeamItems()
  self:OnDeployTeamChange()
end

function UINWarChessMain_DeployNode:RefreshLevelInfo()
  local recommendPower = WarChessManager:GetWCRecommenPower()
  self.ui.tex_RecommendPower.text = tostring(recommendPower)
end

function UINWarChessMain_DeployNode:RefreshTeamItems()
  local maxShowFmtNum = self.wcCtrl.teamCtrl:GetWCFmtShowNum()
  local dTeamDic = self.deployState:GetDTeamDataDic()
  local dTeamList = {}
  for index, dTeamData in pairs(dTeamDic) do
    table.insert(dTeamList, dTeamData)
  end
  table.sort(dTeamList, function(a, b)
    local index_a = a:GetDTeamIndex()
    local index_b = b:GetDTeamIndex()
    local teamData_a = self.deployState:GetTeamDataByIndex(index_a)
    local teamData_b = self.deployState:GetTeamDataByIndex(index_b)
    local isDeploied_a = teamData_a ~= nil
    local isDeploied_b = teamData_b ~= nil
    local isHaveHero_a = a:GetFirstHeroData() ~= nil
    local isHaveHero_b = b:GetFirstHeroData() ~= nil
    local isFixed_a = a:GetDTeamIsFixedTeam()
    local isFixed_b = b:GetDTeamIsFixedTeam()
    if isDeploied_a ~= isDeploied_b then
      return isDeploied_a
    end
    if isFixed_a ~= isFixed_b then
      return isFixed_a
    end
    if isHaveHero_a ~= isHaveHero_b then
      return isHaveHero_a
    end
    return index_a < index_b
  end)
  self.__index2TeamItemDic = {}
  self.teamItemPool:HideAll()
  for _, dTeamData in ipairs(dTeamList) do
    local teamItem = self.teamItemPool:GetOne()
    local index = dTeamData:GetDTeamIndex()
    teamItem:InitWCDeployTeamItem(self.deployState, index, self.__onClickCurTeam, self.resloader)
    teamItem:SetWCDeployTeamDragChange(true, self.__onChangeDrag2Scroll)
    self.__index2TeamItemDic[index] = teamItem
  end
end

function UINWarChessMain_DeployNode:GetWCDeployTeamItem(index)
  return self.__index2TeamItemDic[index]
end

function UINWarChessMain_DeployNode:OnDeployTeamChange()
  local deployLimit = self.wcCtrl.teamCtrl:GetWCFmtNum()
  local dpTeamCount = 0
  local isDynDeploy = self.deployState:GetIsDynDeploy()
  if isDynDeploy then
    self:RefreshTeamItems()
    dpTeamCount = self.wcCtrl.teamCtrl:GetWCFmtCurNum()
    local dTeamDic = self.deployState:GetDTeamDataDic()
    for index, dTeamData in pairs(dTeamDic) do
      if dTeamData:GetIsDeploied() then
        dpTeamCount = dpTeamCount + 1
      end
    end
    self.ui.tex_DynTeamCount.text = tostring(dpTeamCount) .. "/" .. tostring(deployLimit)
    return
  end
  local totalPower = 0
  local dTeamDic = self.deployState:GetDTeamDataDic()
  for index, dTeamData in pairs(dTeamDic) do
    local isDeploied = false
    if dTeamData:GetIsDeploied() then
      isDeploied = true
      dpTeamCount = dpTeamCount + 1
      totalPower = totalPower + dTeamData:GetDTeamTeamPower()
    end
    local teamItem = self.__index2TeamItemDic[index]
    teamItem:RefreshTeamIsDeployed(isDeploied)
  end
  self.ui.tex_TeamCount.text = tostring(dpTeamCount) .. "/" .. tostring(deployLimit)
  self.ui.tex_CurTotalPower.text = tostring(totalPower)
end

function UINWarChessMain_DeployNode:OnWCIsDeployingHeroChange(bool, inStage)
  if bool and not inStage then
    return
  end
  if bool then
    self.ui.obj_normalMode.transform:DOLocalMoveY(-300, 0.1)
  else
    self.ui.obj_normalMode.transform:DOLocalMoveY(165, 0.1)
  end
  self.ui.obj_quitMode:SetActive(bool)
end

function UINWarChessMain_DeployNode:__OnClickBattle()
  self.deployState:WCStartPlay()
end

function UINWarChessMain_DeployNode:__OnClickApplyDynDeploy()
  self.deployState:ApplyDynDeploy()
end

function UINWarChessMain_DeployNode:__OnClickExitDynDeploy()
  self.deployState:ExitDynDeploy()
end

function UINWarChessMain_DeployNode:__OnClickCurTeam(teamItem)
  if WarChessSeasonManager:GetIsInWCSeasonNotFirstLevel() then
    return
  end
  self:__OpenFormation(teamItem)
end

function UINWarChessMain_DeployNode:__OpenFormation(teamItem)
  local index = teamItem.index
  local fmtId
  local teamData = self.deployState:GetTeamDataByIndex(index)
  if teamData ~= nil and teamData:GetWCTeamIsDead() then
    self.deployState:CleanTeamDataByIndex(index)
  end
  local dTeamData = self.deployState:GetDTeamDataByIndex(index)
  if dTeamData ~= nil then
    fmtId = dTeamData:GetFmtId()
  end
  local dTeamDataDic = self.deployState:GetDTeamDataDic()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local wcLevelId = WarChessManager:GetWCLevelId()
  local wcLevelCfg = WarChessManager:GetWCLevelCfg()
  local wcsCtrl = WarChessSeasonManager:GetWCSCtrl()
  local wcStageCfg = WarChessManager:GetWCSectorStageCfg()
  local officialCfgId, floorCfg
  if wcsCtrl ~= nil then
    officialCfgId = wcsCtrl:GetWCSOfficialSupportCfgId()
    local towerId = wcsCtrl:GetWCSTowerId()
    floorCfg = ConfigData.warchess_season_floor[towerId][WarChessSeasonManager:GetWCSCtrl():WCSGetFloor()]
  else
    officialCfgId = WarChessManager:GetWCOfficialSupportCfgId()
  end
  fmtCtrl:ResetFmtCtrlState()
  fmtCtrl:GetNewEnterFmtData():SetFmtIsWarChessDeploy(true, self.__onDeployOver, wcLevelCfg, index):SetFmtWarChessDTeamDataDic(dTeamDataDic):SetFmtCtrlBaseInfo(FmtEnum.eFmtFromModule.WarChess, wcLevelId, fmtId):SetFmtCtrlCallback(self.__onEnterFmt, self.__onExitFmt, nil):SetIsOpenChangeFmt(not self.deployState:GetIsDynDeploy()):SetOfficialSupportCfgId(officialCfgId)
  if wcStageCfg ~= nil then
    fmtCtrl:GetCurEnterFmtData():SetFmtRecommendCfg(wcStageCfg.recommend_hero, wcStageCfg.recommend_team, wcStageCfg.recommend_skill)
  end
  if floorCfg ~= nil then
    fmtCtrl:GetCurEnterFmtData():SetFmtRecommendCfg(floorCfg.recommend_hero, floorCfg.recommend_team, floorCfg.recommend_skill)
  end
  fmtCtrl:EnterFormation()
end

function UINWarChessMain_DeployNode:__OnEnterFmt()
  UIManager:HideWindow(UIWindowTypeID.WarChessMain)
  UIManager:HideWindow(UIWindowTypeID.WarChessInfo)
  self.wcCtrl.wcCamCtrl:SetIsCouldNormalMoveCamera(false)
end

function UINWarChessMain_DeployNode:__OnExitFmt()
  UIManager:ShowWindowOnly(UIWindowTypeID.WarChessMain)
  UIManager:ShowWindowOnly(UIWindowTypeID.WarChessInfo)
  self.wcCtrl.wcCamCtrl:SetIsCouldNormalMoveCamera(true)
  self:__RefreshAllTeamData()
  local dTeamDic = self.deployState:GetDTeamDataDic()
  for index, dTeamData in pairs(dTeamDic) do
    if dTeamData:GetIsDeploied() then
      local firstHeroData = dTeamData:GetFirstHeroData()
      local fairyData = dTeamData:GetFmtFairyData()
      self.wcCtrl.teamCtrl:RefreshDeployHeroEntity(firstHeroData, index, fairyData)
    end
  end
end

function UINWarChessMain_DeployNode:__OnDeployOver(fmtData, callbcak)
  self:__RefreshAllTeamData()
  if callbcak ~= nil then
    callbcak()
  end
end

function UINWarChessMain_DeployNode:__RefreshAllTeamData()
  self.deployState:RefreshAllDTeamData()
  for _, teamItem in pairs(self.teamItemPool.listItem) do
    teamItem:RefreshTeamItem()
  end
end

function UINWarChessMain_DeployNode:__OnChangeDrag2Scroll(eventData)
  eventData.pointerDrag = self.ui.scroll_mask.gameObject
  self.ui.scroll_mask:OnBeginDrag(eventData)
end

function UINWarChessMain_DeployNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.WC_DeployTeamChange, self.__onDeployTeamChange)
  MsgCenter:RemoveListener(eMsgEventId.WC_DeployingTeam, self.__onWCIsDeployingHeroChange)
  self.teamItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINWarChessMain_DeployNode
