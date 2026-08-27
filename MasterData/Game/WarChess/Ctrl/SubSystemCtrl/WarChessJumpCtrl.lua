local base = require("Game.WarChess.Ctrl.SubSystemCtrl.Base.WarChessSubSystemCtrlBase")
local WarChessJumpCtrl = class("WarChessJumpCtrl", base)
local CS_Resloader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local UIWarChessJumpSystem = require("Game.WarChess.UI3D.JumpSystem.UIWarChessJumpSystem")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
WarChessJumpCtrl.eJumpType = {fourWayJump = 1, chess = 2}
WarChessJumpCtrl.jumpDiffTable = {
  [WarChessJumpCtrl.eJumpType.fourWayJump] = {
    enterFunc = function(jumpCtrl)
      local parent = jumpCtrl.wcCtrl.bind.trans_3DUIRoot
      jumpCtrl.resloader:LoadABAssetAsync(PathConsts:GetUIPrefabPath("UI_WarChessJumpSystem"), function(prefab)
        local obj = prefab:Instantiate(parent)
        obj.name = "UI_WarChessJumpSystem"
        jumpCtrl.__jump3DUINode = UIWarChessJumpSystem.New()
        jumpCtrl.__jump3DUINode:Init(obj)
        jumpCtrl.__jump3DUINode:InitWCJumpSystem(jumpCtrl)
      end)
    end,
    jumpInFx = "FXP_blink-in",
    jumpOutFx = "FXP_blink-go",
    groundFx = "FXP_blinkloop"
  },
  [WarChessJumpCtrl.eJumpType.chess] = {
    enterFunc = function(jumpCtrl)
      jumpCtrl.wcCtrl.curState:SetWCCustomInput(true, jumpCtrl.__jumpSystemCustomClick)
    end,
    jumpInFx = "FXP_zq_blink",
    jumpOutFx = nil,
    groundFx = "FXP_blinkloop",
    battleInstaKillFx = "FXP_bisha_GroundEffcte-monster",
    headIconIds = {
      [proto_object_BuffChessType.BuffChessPawn] = 1,
      [proto_object_BuffChessType.BuffChessKnight] = 2,
      [proto_object_BuffChessType.BuffChessBishop] = 3,
      [proto_object_BuffChessType.BuffChessRook] = 4,
      [proto_object_BuffChessType.BuffChessQueen] = 5
    }
  }
}

function WarChessJumpCtrl:ctor(wcCtrl)
  self.resloader = CS_Resloader.Create()
  self.__jumpSystemData = nil
  self.__identify = nil
  self.__curTeamData = nil
  self.__jumpType = nil
  self.__isWaitingMove = false
  self.__isWaitingMoveOverCallback = nil
  self.__jumpTable = nil
  self.__isEarlyJump = false
  self.__jump3DUINode = nil
  self.__fxList = nil
  self.__jumpSystemCustomClick = BindCallback(self, self.__JumpSystemCustomClick)
end

function WarChessJumpCtrl:__GetWCSubSystemCat()
  local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
  return eWarChessEnum.eSystemCat.jump
end

function WarChessJumpCtrl:OpenWCSubSystem(systemState, identify)
  if systemState == nil or systemState.jumpSystemData == nil then
    error("not have data")
    return
  end
  self.__jumpSystemData = systemState.jumpSystemData
  self.__identify = identify
  self.__curTeamData = self.wcCtrl.teamCtrl:GetTeamDataByTeamUid(identify.tid)
  if self.__jumpSystemData.jumpSystemState == proto_object_JumpSystemStateType.JumpSystemBattleMoving then
    self.wcCtrl.wcNetworkCtrl:CS_WarChess_JumpSystemData_Move(self.__identify, self.__isWaitingMoveOverCallback)
    self.__isWaitingMove = false
    self.__isWaitingMoveOverCallback = nil
    self.__isEarlyJump = false
    return
  end
  if self.__curTeamData:GetTeamNumeric(proto_object_WarChessNumeric.WarChessBuffCatAddChessMovePoint) ~= nil then
    self.__jumpType = WarChessJumpCtrl.eJumpType.chess
  else
    self.__jumpType = WarChessJumpCtrl.eJumpType.fourWayJump
  end
  local jumpTable = WarChessJumpCtrl.jumpDiffTable[self.__jumpType]
  if jumpTable == nil then
    error("jump type not exist:" .. tostring(self.__jumpType))
    return
  end
  self.__jumpTable = jumpTable
  local jumpStartFunc = self.__jumpTable.enterFunc
  if jumpStartFunc ~= nil then
    jumpStartFunc(self)
  end
  self.wcCtrl.curState:WCHideInteract()
  self:__ShowJumpTargetFx()
end

function WarChessJumpCtrl:__ShowJumpTargetFx()
  self.__curTeamData:SetIsShowHead3DUI(false)
  self.wcCtrl.curState:WCPlayDeselectTeam()
  self.__fxList = {}
  local showedPos = {}
  for _, jumpElem in pairs(self.__jumpSystemData.jumpPos) do
    local dir = jumpElem.dir
    for _, WCPos in pairs(jumpElem.pos) do
      if showedPos[WCPos.pos] == nil then
        showedPos[WCPos.pos] = true
        local x, y = WarChessHelper.Coordination2Pos(WCPos.pos)
        local showPos = Vector3.Temp(x, 0, y)
        local moveableFX = self.wcCtrl.animaCtrl:ShowWCEffect(self.__jumpTable.groundFx or "FXP_blinkloop", showPos)
        table.insert(self.__fxList, moveableFX)
      end
    end
  end
end

function WarChessJumpCtrl:__HideJumpTargetFx()
  for _, moveableFX in pairs(self.__fxList) do
    self.wcCtrl.animaCtrl:RecycleWCEffect(self.__jumpTable.groundFx or "FXP_blinkloop", moveableFX)
  end
  self.__curTeamData:SetIsShowHead3DUI(true)
  self.wcCtrl.curState:WCPlayStateSelectTeam(self.__curTeamData, true, true)
end

function WarChessJumpCtrl:WCJumpGetTeamData()
  return self.__curTeamData
end

function WarChessJumpCtrl:WCJumpSubSysCancle()
  if self.__isWaitingMove then
    return
  end
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_JumpSystemData_Quit(self.__identify, function()
    self:__HideJumpTargetFx()
  end)
end

function WarChessJumpCtrl:WCJumpSubSysJump(dir, movePos)
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_JumpSystemData_Start(self.__identify, dir, movePos, function(argList)
    if argList.Count < 1 then
      error("argList.Count error:" .. tostring(argList.Count))
      return
    end
    local isSucess = argList[0]
    local msg = argList[1]
    if isSucess then
      local jumpInFx = self.__jumpTable.jumpInFx
      local jumpOutFx = self.__jumpTable.jumpOutFx
      local sx, sy = WarChessHelper.Coordination2Pos(msg.wcStartPos.pos)
      local ex, ey = WarChessHelper.Coordination2Pos(msg.wcEndPos.pos)
      local startPos = Vector3.New(sx, 0, sy)
      local endPos = Vector3.New(ex, 0, ey)
      local endLoigicPos = Vector2.New(ex, ey)
      
      local function ShowJumpFx()
        local s_fxgo, e_fxgo
        if jumpOutFx ~= nil then
          s_fxgo = self.wcCtrl.animaCtrl:ShowWCEffect(jumpOutFx, startPos)
        end
        if jumpInFx ~= nil then
          e_fxgo = self.wcCtrl.animaCtrl:ShowWCEffect(jumpInFx, endPos)
        end
        TimerManager:StartTimer(5, function()
          if not (self.wcCtrl ~= nil and self.wcCtrl:GetIsInWarChessScene()) or self.wcCtrl.animaCtrl == nil then
            return
          end
          if jumpOutFx ~= nil then
            self.wcCtrl.animaCtrl:RecycleWCEffect(jumpOutFx, s_fxgo)
          end
          if jumpInFx ~= nil then
            self.wcCtrl.animaCtrl:RecycleWCEffect(jumpInFx, e_fxgo)
          end
        end, self, true)
      end
      
      self:__HideJumpTargetFx()
      local systemType = msg.systemType
      self.__isWaitingMove = true
      if systemType == proto_object_JumpSystemStateType.JumpSystemMoving then
        self.wcCtrl.wcNetworkCtrl:CS_WarChess_JumpSystemData_Move(self.__identify, ShowJumpFx)
        self.__isWaitingMove = false
      elseif systemType == proto_object_JumpSystemStateType.JumpSystemBattle then
        self.wcCtrl.battleCtrl:SetInstaKillName(self.__jumpTable.battleInstaKillFx)
        ShowJumpFx()
        local teamData = self:WCJumpGetTeamData()
        local startGrid = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, teamData:GetWCTeamLogicPos())
        local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicXY(nil, ex, ey)
        if startGrid ~= nil then
          startGrid:SetWCGridIsStandTeam(false)
        end
        if gridData ~= nil then
          gridData:SetWCGridIsStandTeam(true)
        end
        teamData:SetWCTeamLogicPos(endLoigicPos)
        local heroEntity = self.wcCtrl.teamCtrl:GetWCHeroEntity(teamData:GetWCTeamIndex(), nil, nil)
        heroEntity:WCHeroEntitySetPos(endPos)
        self.wcCtrl.teamCtrl:CalTeamCouldMoveGridDic(teamData)
        MsgCenter:Broadcast(eMsgEventId.WC_TeamInfoUpdate, teamData)
        teamData:SetEarlySettedPos(msg.wcEndPos.pos)
        
        function self.__isWaitingMoveOverCallback()
          local startGrid = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, teamData:GetWCTeamLogicPos())
          local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicXY(nil, ex, ey)
          if startGrid ~= nil then
            startGrid:SetWCGridIsStandTeam(false)
          end
          if gridData ~= nil then
            gridData:SetWCGridIsStandTeam(true)
          end
          self.wcCtrl.teamCtrl:CalTeamCouldMoveGridDic(teamData)
        end
      else
        self.__isWaitingMove = false
      end
      self.wcCtrl.curState:SetWCCustomInput(false)
      self.wcCtrl.animaCtrl:UpdateWCSelectedFX(true, endLoigicPos)
    end
  end)
end

function WarChessJumpCtrl:__JumpSystemCustomClick(pos)
  if pos == nil then
    return
  end
  local x = math.floor(pos.x + 0.5)
  local y = math.floor(pos.z + 0.5)
  local clickLogicPos = Vector2.New(x, y)
  if not self.wcCtrl.curState:IsCorrectGuideClick(clickLogicPos) then
    return
  end
  self.wcCtrl.curState:CheckWCGuideClick()
  for _, jumpElem in pairs(self.__jumpSystemData.jumpPos) do
    for _, WCPos in pairs(jumpElem.pos) do
      local x, y = WarChessHelper.Coordination2Pos(WCPos.pos)
      if Vector2.Temp(x, y) == clickLogicPos then
        local entityData = self.wcCtrl.mapCtrl:GetEntityDataByLogicPos(nil, clickLogicPos)
        if entityData ~= nil and entityData:IsBossMonster() then
          cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7135))
          return
        end
        self:WCJumpSubSysJump(nil, WCPos)
        return
      end
    end
  end
  self:WCJumpSubSysCancle()
end

function WarChessJumpCtrl:GetIsEarlyJump(teamData)
end

function WarChessJumpCtrl:CloseWCSubSystem(isSwitchClose)
  base.CloseWCSubSystem()
  if self.__jumpType == WarChessJumpCtrl.eJumpType.fourWayJump then
    if self.__jump3DUINode ~= nil then
      self.__jump3DUINode:Delete()
    end
  elseif self.__jumpType == WarChessJumpCtrl.eJumpType.chess then
    self.wcCtrl.curState:SetWCCustomInput(false)
  end
  if not self.__isWaitingMove then
    local teamData = self:WCJumpGetTeamData()
    teamData:SetEarlySettedPos(nil)
  end
  self.__jumpSystemData = nil
  self.__identify = nil
  self.__curTeamData = nil
end

function WarChessJumpCtrl:Delete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return WarChessJumpCtrl
