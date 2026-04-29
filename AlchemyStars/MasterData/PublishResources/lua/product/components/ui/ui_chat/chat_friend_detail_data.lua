_class("ChatFriendDetailData", Object)
ChatFriendDetailData = ChatFriendDetailData

function ChatFriendDetailData:Constructor(friendData, playerDetailInfo)
  local fightInfo = playerDetailInfo.fight_info
  self._friendData = friendData
  self._des = playerDetailInfo.role_sign_text
  local missionid = fightInfo.mission_id
  local chapterid = 1
  local cfg_chapter = Cfg.cfg_mission_chapter({MissionID = missionid})
  if cfg_chapter and table.count(cfg_chapter) > 0 then
    chapterid = cfg_chapter[1].MainChapterID
  end
  if not self:IsChapterReachUnlockTime(chapterid) then
    chapterid = chapterid - 1
    local cfg_chapter_2 = Cfg.cfg_mission_chapter({MainChapterID = chapterid})
    if cfg_chapter_2 and table.count(cfg_chapter_2) > 0 then
      missionid = cfg_chapter_2[#cfg_chapter_2].MissionID
    end
  end
  self._currentMissionId = missionid
  self._difficultyMission = playerDetailInfo.simple_info.difficulty_mission
  self._sailingMission = playerDetailInfo.simple_info.sailing_mission
  self._titleUsed = playerDetailInfo.simple_info.title_used
  self._fifureUsed = playerDetailInfo.simple_info.fifure_used
  self._worldBossInfo = playerDetailInfo.simple_info.world_boss_info
  self._medalPlacementInfo = playerDetailInfo.simple_info.medal_placement
  self._star = fightInfo.pass_star_num
  self._petCount = fightInfo.pet_num
  self._achievementPoint = fightInfo.achievement_num
  self._towerWater = fightInfo.tower_water
  self._towerFire = fightInfo.tower_fire
  self._towerWood = fightInfo.tower_wood
  self._towerThunder = fightInfo.tower_thunder
  local questModule = GameGlobal.GetModule(QuestModule)
  local achievementPoint = 0
  local achievementPointAll = 0
  achievementPoint, achievementPointAll = questModule:GetAchieveCount(AchieveType.AT_All)
  self._allAchievementPoint = achievementPointAll
  local rankScore = playerDetailInfo.simple_info.peak_score
  self:SetRankValue(rankScore)
end

function ChatFriendDetailData:IsChapterReachUnlockTime(chapterId)
  local cfg = Cfg.cfg_global.ui_chapter_unlock_time.TableValue
  if not cfg then
    return false
  end
  local unlockTimestamp = cfg[chapterId] or 0
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local isUnlock = unlockTimestamp < nowTimestamp
  return isUnlock
end

function ChatFriendDetailData:SetRankValue(expValue)
  local exp = expValue
  local airModule = GameGlobal.GetModule(AircraftModule)
  local lv = airModule:GetLvByExp(exp)
  self._rankValue = lv
end

function ChatFriendDetailData:GetFriendData()
  return self._friendData
end

function ChatFriendDetailData:GetDes()
  return self._des
end

function ChatFriendDetailData:GetCurrentMissionId()
  return self._currentMissionId
end

function ChatFriendDetailData:GetStar()
  return self._star
end

function ChatFriendDetailData:GetPetCount()
  return self._petCount
end

function ChatFriendDetailData:GetAchievementPoint()
  return self._achievementPoint
end

function ChatFriendDetailData:GetAllAchievementPoint()
  return self._allAchievementPoint
end

function ChatFriendDetailData:GetTowerWater()
  return self._towerWater
end

function ChatFriendDetailData:GetTowerFire()
  return self._towerFire
end

function ChatFriendDetailData:GetTowerWood()
  return self._towerWood
end

function ChatFriendDetailData:GetTowerThunder()
  return self._towerThunder
end

function ChatFriendDetailData:GetDifficultyMission()
  return self._difficultyMission
end

function ChatFriendDetailData:GetSailingMission()
  return self._sailingMission
end

function ChatFriendDetailData:GetTitleUsed()
  return self._titleUsed
end

function ChatFriendDetailData:GetFifureUsed()
  return self._fifureUsed
end

function ChatFriendDetailData:GetRankValue()
  return self._rankValue
end

function ChatFriendDetailData:GetWorldBossRecordDan()
  return self._worldBossInfo.dan
end

function ChatFriendDetailData:GetWorldBossRecordRank()
  return self._worldBossInfo.grading
end

function ChatFriendDetailData:GetMedalPlacementInfo()
  return self._medalPlacementInfo
end
