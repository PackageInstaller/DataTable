require("loading_system")
_class("ClientLoadingSystem_Render", LoadingSystem)
ClientLoadingSystem_Render = ClientLoadingSystem_Render

function ClientLoadingSystem_Render:_DoRenderMatchStart(TT)
  local battleRenderConfigCmpt = self.world:BattleRenderConfig()
  while not battleRenderConfigCmpt:IsMatchStart() do
    YIELD(TT)
  end
end

function ClientLoadingSystem_Render:_DoRenderLoading(TT)
  local loadingService = self._world:GetService("Loading")
  return GameGlobal.TaskManager():CoreGameStartTask(loadingService.MockLoading, loadingService)
end

function ClientLoadingSystem_Render:_DoRenderCreateRenderBoard()
  local resvc = self._world:GetService("RenderEntity")
  resvc:CreateRenderBoardEntity()
end

function ClientLoadingSystem_Render:_DoRenderPreloadCfg()
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
