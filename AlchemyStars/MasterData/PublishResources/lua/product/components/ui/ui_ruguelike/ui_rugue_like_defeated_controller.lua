_class("UIRugueLikeDefeatedController", UIController)
UIRugueLikeDefeatedController = UIRugueLikeDefeatedController

function UIRugueLikeDefeatedController:OnShow(uiParam)
  local show_save = uiParam[1]
  if show_save then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_maze_sava_archieve_or_not"), function(param)
      self:SaveBattleArchive(true)
      GameGlobal.UIStateManager():Lock("SaveBattleArchive")
    end, nil, function(param)
      self:SaveBattleArchive(false)
    end, nil)
  else
    self:SaveBattleArchive(false)
  end
  local funcModule = self:GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(false)
  local againFightBtn = self:GetGameObject("againFightBtn")
  local againActive = HelperProxy:GetInstance():AgainFightActive(MatchType.MT_Maze, false)
  againFightBtn:SetActive(againActive)
  self:AttachEvent(GameEventType.MazeInfoUpdate, function()
    GameGlobal.UIStateManager():UnLock("SaveBattleArchive")
  end)
end

function UIRugueLikeDefeatedController:OnHide()
  GameGlobal.UIStateManager():UnLock("SaveBattleArchive")
end

function UIRugueLikeDefeatedController:bgOnClick()
  GameGlobal:GetInstance():ExitCoreGame()
  GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Maze_Enter, "mj_01")
end

function UIRugueLikeDefeatedController:againFightBtnOnClick()
  local ctx = self:GetModule(MissionModule):TeamCtx()
  local teamInfo = self:GetModule(MazeModule):GetFormationInfo()
  ctx:InitMazeTeam(teamInfo)
  GameGlobal:GetInstance():ExitCoreGame()
  local ctx = self:GetModule(MissionModule):TeamCtx()
  ctx:SetFightAgain(true)
  ctx:ShowDialogUITeams(true)
end

function UIRugueLikeDefeatedController:SaveBattleArchive(save)
  local md = GameGlobal.GetModule(MatchModule)
  local result = md:GetMatchResult()
  result.maze_result[1].save_archive = save
  md:GameOver(result)
end

function UIRugueLikeDefeatedController:bgOnClick_MazeTest()
  GameGlobal:GetInstance():ExitCoreGame()
  self:CloseDialog()
end
