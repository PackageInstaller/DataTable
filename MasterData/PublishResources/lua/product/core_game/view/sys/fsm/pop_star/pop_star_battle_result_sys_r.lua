require("pop_star_battle_result_system")
_class("PopStarBattleResultSystem_Render", PopStarBattleResultSystem)
PopStarBattleResultSystem_Render = PopStarBattleResultSystem_Render

function PopStarBattleResultSystem_Render:_DoRenderShowExit(TT, victory, defeatType)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTGameOver:New(victory, defeatType))
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnSetGraphicRaycaster, false)
  if victory == 1 then
    local guideService = self._world:GetService("Guide")
    guideService:Trigger(GameEventType.GuideBattleFinish)
    guideService:YieldComplete()
  end
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local utilData = self._world:GetService("UtilData")
  if victory ~= 0 and not utilData:PlayerIsDead(teamEntity) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowTransitionEffect)
    YIELD(TT, 1000)
  end
  UnityEngine.Shader.DisableKeyword("_CELL_CLIP")
end

function PopStarBattleResultSystem_Render:_DoRenderBattleResult()
  local battleSvcRender = self._world:GetService("RenderBattle")
  battleSvcRender:NotifyUIBattleGameOver(self.battleMatchResult)
end
