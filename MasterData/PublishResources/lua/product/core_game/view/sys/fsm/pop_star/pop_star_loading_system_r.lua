require("pop_star_loading_system")
_class("PopStarLoadingSystem_Render", PopStarLoadingSystem)
PopStarLoadingSystem_Render = PopStarLoadingSystem_Render

function PopStarLoadingSystem_Render:_DoRenderCreateRenderBoard()
  local entitySvc = self._world:GetService("RenderEntity")
  entitySvc:CreateRenderBoardEntity()
end

function PopStarLoadingSystem_Render:_DoRenderLoading(TT)
  local loadingRSvc = self._world:GetService("Loading")
  return GameGlobal.TaskManager():CoreGameStartTask(loadingRSvc.MockLoading, loadingRSvc)
end

function PopStarLoadingSystem_Render:_DoRenderMatchStart(TT)
  local battleRenderConfigCmpt = self.world:BattleRenderConfig()
  while not battleRenderConfigCmpt:IsMatchStart() do
    YIELD(TT)
  end
end

function PopStarLoadingSystem_Render:_DoRenderPreloadCfg()
  local bEnable = true
  if EDITOR and bEnable then
    local testRobot = GameGlobal.GetModule(TestRobotModule)
    local isRunAutoTest = testRobot:GetIsEnableRobot()
    if not isRunAutoTest then
      return
    end
    local board_guide = Cfg.cfg_board_guide()
    local trap = Cfg.cfg_trap()
    local ai = Cfg.cfg_ai()
    local passive_skill = Cfg.cfg_passive_skill()
  end
end
