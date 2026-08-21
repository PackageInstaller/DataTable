require("test_robot_module")

function TestRobotModule:__AsyncSendGM(TT, status, cmd)
  self:Log(self, "GMCommand: ", cmd)
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  local _, reply = gmproxy:SendCmdTask(TT, cmd)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
  YIELD(TT, 5)
end

function TestRobotModule:AsyncGM_AddAsset(TT, status, id, count)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("add_asset %s %d %d", self:GetTestAccountOpenID(), id, count)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_AllPetFull(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("all_pet_full %s", self:GetTestAccountOpenID())
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_ModifyAllSvcTimeBias(TT, status, time)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("modify_allsvc_time_bias 54 1 %d", time)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_RevivePets(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("revive_pets %s", self:GetTestAccountOpenID())
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_TaleCallPet(TT, status, id)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("tale_call_pet %s %d", self:GetTestAccountOpenID(), id)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_CompleteAllExtTask(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("CompleteAllExtTask %s 0", self:GetTestAccountOpenID())
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_OpenAllCampaign(TT, status, campaignID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("open_all_campaign %s %s", self:GetTestAccountOpenID(), campaignID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassTowerLevel(TT, status, type, level)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("pass_tower_level %s %d %d", self:GetTestAccountOpenID(), type, level)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_UnlockResdungeonRoom(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("unlock_resdungeonroom %s", self:GetTestAccountOpenID())
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_ResetMaze(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("reset_maze %s", self:GetTestAccountOpenID())
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_CompleteAllMission(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("CompleteAllMission %s", self:GetTestAccountOpenID())
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassLineCampMission(TT, status, componentID, lastMissionID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("PassLineCampMission %s %s %s", self:GetTestAccountOpenID(), componentID, lastMissionID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassLineCampMissionSingle(TT, status, componentID, lastMissionID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("PassLineCampMissionSingle %s %s %s", self:GetTestAccountOpenID(), componentID, lastMissionID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassCampMission(TT, status, missionComponentID, componentID, lastMissionID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("PassCampMission %s %s %s %s", self:GetTestAccountOpenID(), missionComponentID, componentID, lastMissionID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassMultiLineCampMission(TT, status, componentID, lastMissionID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("PassMultiLineCampMission %s %s %s", self:GetTestAccountOpenID(), componentID, lastMissionID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassCampMission(TT, status, missionComponentID, componentID, lastMissionID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("PassCampMission %s %s %s %s", self:GetTestAccountOpenID(), missionComponentID, componentID, lastMissionID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassSumIICampMission(TT, status, componentID, lastMissionID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("PassSumIICampMission %s %s %s", self:GetTestAccountOpenID(), componentID, lastMissionID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassTreeCampMission(TT, status, componentID, lastMissionID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("PassTreeCampMission %s %s %s", self:GetTestAccountOpenID(), componentID, lastMissionID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_TacticIgnoreFightLimit(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("tactic_ignore_fight_limit %s", self:GetTestAccountOpenID())
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_UnlockAllRoom(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("unlock_allroom %s", self:GetTestAccountOpenID())
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassAllDifficultyMission(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("pass_all %s %s", self:GetTestAccountOpenID(), 0)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassAllActivityDifficultyMission(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("pass_all %s %s", self:GetTestAccountOpenID(), 1)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_SailingPassAll(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("sailing_pass_all %s", self:GetTestAccountOpenID())
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_FakeMidasProvide(TT, status, midas_id)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("FakeMidasProvide %s %s", self:GetTestAccountOpenID(), midas_id)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_PassMiniMazeMission(TT, status, componentID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("pass_bloodsucker_mission %s %d", self:GetTestAccountOpenID(), componentID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_MiniMazeTalentMax(TT, status, componentID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("talent_max_level %s %d", self:GetTestAccountOpenID(), componentID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_AddAllPet(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("add_all_pet %s", self:GetTestAccountOpenID())
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_SetShopWindowsMsgBoxFalse(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("modify_game_limit_switch_param 513 1 ShopWindowsMsgBox false")
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_SetWhiteTestSeasonMazeTrue(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("modify_game_limit_switch_param 513 1 whiteTestSeasonMazeFight true")
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_ChangePet(TT, status, templateID, level, awakening, grade, intimacy, equip)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("ChangePet %s %s %s %s %s %s %s", self:GetTestAccountOpenID(), templateID, level, awakening, grade, intimacy, equip)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_SeasonSetProcess(TT, status, campaignID, componentID, progress)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("SeasonSetProcess %s %s %s %s", self:GetTestAccountOpenID(), campaignID, componentID, progress)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_UnlockChallengeMission(TT, status, componentID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("unlock_challenge_mission %s %s", self:GetTestAccountOpenID(), componentID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_SetCampaignTalentList(TT, status, talentList)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("GMSetTalentSkill %s ", self:GetTestAccountOpenID())
  if talentList then
    for index, value in ipairs(talentList) do
      if index ~= 1 then
        cmd = cmd .. ","
      end
      cmd = cmd .. tostring(value)
    end
  end
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_SeasonMazeLevelDifficulty(TT, status, componentID, level)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("season_maze_hard %s %s %s", self:GetTestAccountOpenID(), componentID, level)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_ResetCampDat(TT, status, activityID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("ResetCampData %s %s", self:GetTestAccountOpenID(), activityID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_SeasonMazeAddItem(TT, status, componentID, itemType, itemID, itemCount)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("add_season_maze_item %s %s %s %s %s", self:GetTestAccountOpenID(), componentID, itemType, itemID, itemCount)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_SeasonMazeAddAllRelic(TT, status, componentID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("add_season_maze_all_relic %s %s", self:GetTestAccountOpenID(), componentID)
  self:__AsyncSendGM(TT, status, cmd)
end

function TestRobotModule:AsyncGM_SeasonMazeAddAllBead(TT, status, componentID)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local cmd = string.format("season_maze_all_bead %s %s", self:GetTestAccountOpenID(), componentID)
  self:__AsyncSendGM(TT, status, cmd)
end
