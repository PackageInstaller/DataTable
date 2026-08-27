local HotfixCameraCtrl = class("HotfixCameraController", HotfixBase)
local CameraController = CS.CameraController
local util = require("XLua.Common.xlua_util")
xlua.private_accessible(CS.CameraController)

local function PlaySettlementCut(self, battleController, mvpRole)
  local m_playerTeam = battleController.PlayerTeamController
  local m_enemyTeam = battleController.EnemyTeamController
  local deadRole = battleController.EnemyTeamController:GetBattleRole()
  local posDeadRole = battleController:GetGridData(deadRole.curCoord).fixLogicPosition:ToVector3() + Vector3.New(0, 0.5, 0)
  local posMVPRole = mvpRole.lsObject.transform.position + self.m_mvpViewOffset
  self.m_dollyTrackViewEnd.position = posDeadRole
  self.m_dollyTrackViewMVP.position = posMVPRole
  self.m_dollyTrackViewMVP.rotation = mvpRole.lsObject.transform.rotation * CS.UnityEngine.Quaternion.AngleAxis(-self.m_mvpViewAngleOffset, Vector3.up)
  m_playerTeam:SetAliceHeroUIInfo(false)
  self.m_settlementDirector:Play()
  self.m_cameraCulling = true
  self:StartCoroutine(self:StarCharactersCulling(mvpRole, m_playerTeam.battleRoleList, m_enemyTeam.deadbattleCharacterList, battleController.PropDropController.propsList, 3.0))
  warn("HOTFIX TEST:PlaySettlementCut")
end

local function StarCharactersCulling(self, mvpRole, listBattleRole, listBattleEnemy, dropedItems, setDistance)
  warn("HOTFIX TEST:StarCharactersCulling")
  return util.cs_generator(function()
    while self.m_cameraCulling do
      coroutine.yield(nil)
      self:CharactersCullingByViewPos(mvpRole, listBattleRole, listBattleEnemy, dropedItems, setDistance, 1.8, 1.0)
    end
  end)
end

function HotfixCameraCtrl:Register()
  self:RegisterHotfix(CameraController, "PlaySettlementCut", PlaySettlementCut)
  self:RegisterHotfix(CameraController, "StarCharactersCulling", StarCharactersCulling)
end

return HotfixCameraCtrl
