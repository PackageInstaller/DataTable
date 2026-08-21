_class("MatchEnterPreFerenceData", Object)
MatchEnterPreFerenceData = MatchEnterPreFerenceData

function MatchEnterPreFerenceData:Constructor(joined_players)
  if joined_players == nil then
    return
  end
  local petList = {}
  local timeModule = GameGlobal.GetModule(SvrTimeModule)
  self.enterTime = math.floor(timeModule:GetServerTime() / 1000)
  self.localDBKey = GameGlobal.GetModule(RoleModule):SkillAnimationLocalDBKey()
  self.preferenceSkillSpine = self:GetSkillAnimationPermissionType()
  if self.preferenceSkillSpine == SkillAnimationPermissionType.Once then
    for key, value in pairs(joined_players) do
      local pet_list = value.pet_list
      for i = 1, #pet_list do
        local petId = pet_list[i].template_id
        local canPlay = self:GetCanPlaySkillSpine(petId, self.localDBKey)
        if canPlay and not table.intable(petList, petId) then
          table.insert(petList, petId)
        end
      end
    end
  end
  self.preferenceSkillSpineLastPlayList = petList
  self.hadPlaySkillSpineNameList = {}
end

function MatchEnterPreFerenceData:GetSkillAnimationPermissionType()
  local skillPermission = LocalDB.GetInt(self.localDBKey, SkillAnimationPermissionType.Open)
  return skillPermission
end

function MatchEnterPreFerenceData:GetCanPlaySkillSpine(petId, dbKey)
  local skillKey = dbKey .. petId
  local petSkillLastPlayTimeStamp = LocalDB.GetInt(skillKey, 0)
  local daysInclude = self:DaysInclude(self.enterTime, petSkillLastPlayTimeStamp, 5)
  if not daysInclude then
    return true
  end
  return false
end

function MatchEnterPreFerenceData:SameDay(t1, t2)
  return os.date("%Y", t1) == os.date("%Y", t2) and os.date("%m", t1) == os.date("%m", t2) and os.date("%d", t1) == os.date("%d", t2)
end

function MatchEnterPreFerenceData:DaysInclude(t1, t2, hour)
  if t2 == 0 then
    return false
  end
  return self:SameDay(t1 - hour * 60 * 60, t2 - hour * 60 * 60)
end
