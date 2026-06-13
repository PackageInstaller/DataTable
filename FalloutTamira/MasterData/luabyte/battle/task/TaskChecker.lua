local TaskChecker = BaseClass("TaskChecker")
local M = TaskChecker 

function M:Init(_heroId,taskId)
    local taskData = ConfigHelper.GetCfg("task",taskId)
    if taskData then
        self.taskType = taskData.limit
        self.mtaskData = taskData
        if self.taskType == EnumConst.EBattleTaskType.PassMissionHasHero then -- 使用指定战员0通关1关卡
            self.heroId = taskData.limitValue2
            self.missionId = taskData.limitValue3;
        elseif self.taskType == EnumConst.EBattleTaskType.PassMissionHasHeroPersonnNumber then -- 编队0人携带战员1通关2关卡
            self.teamNumber = taskData.limitValue2;
            self.heroId = taskData.limitValue3;
            self.missionId = taskData.limitValue4;   
        elseif self.taskType == EnumConst.EBattleTaskType.PassMissionHasHeroWithoutProfessional then -- 编队内不带0职业并携带1通关2关卡
            self.unProfessionalType = taskData.limitValue2;
            self.heroId = taskData.limitValue3;
            self.missionId = taskData.limitValue4;
        elseif self.taskType == EnumConst.EBattleTaskType.PassMissionUseBattleLevel then -- 指定战员0通关1关卡 战中使用2技能
            self.heroId = taskData.limitValue3;
            self.missionId = taskData.limitValue4;
            self.battleLevel = taskData.limitValue2;
        elseif self.taskType == EnumConst.EBattleTaskType.HeroKillEmNumber then -- 使用指定战员0击杀1个敌人
            self.heroId = taskData.limitValue2;
        elseif self.taskType == EnumConst.EBattleTaskType.HeroKillTargetEm then -- 使用指定战员0击杀指定的敌人1
            self.heroId = taskData.limitValue3;
            self.enemyId = taskData.limitValue2;
        elseif self.taskType == EnumConst.EBattleTaskType.HeroKillEmNumberByBattleLevel then -- 战员0使用1战中升级击杀2敌人
            self.heroId = taskData.limitValue3;
            self.battleLevel = taskData.limitValue2;
        elseif self.taskType == EnumConst.EBattleTaskType.HeroKillTargetEmByBattleLevel then -- 战员0使用1技能击杀指定2敌人
            self.heroId = taskData.limitValue4;
            self.battleLevel = taskData.limitValue2;
            self.enemyId = taskData.limitValue3;
        end
    end
end

function M:CheckPassMission(_heroId,_missionId,teamHeroNumber,professionalType)
    if self.heroId ~= _heroId then
        return false
    end

    if self.taskType == EnumConst.EBattleTaskType.PassMissionHasHero then 
        if (self.missionId ~= _missionId) then
            return false;
        end
    elseif self.taskType == EnumConst.EBattleTaskType.PassMissionHasHeroPersonnNumber then
        if (teamHeroNumber > self.teamNumber) then
            return false;
        end
    elseif self.taskType == EnumConst.EBattleTaskType.PassMissionHasHeroWithoutProfessional then
        for key, value in pairs(professionalType) do
            if  value == self.unProfessionalType and key ~= _heroId then
                return false
            end
        end
        if _missionId ~= self.missionId then
            return false
        end
    else
        return false        
    end
    return true
end

function M:CheckBattleLevel(_heroId,_battleLevel)
    if self.heroId ~= _heroId then
        return false
    end
    if self.taskType == EnumConst.EBattleTaskType.PassMissionUseBattleLevel then
        if  self.battleLevel == _battleLevel then 
            return true
        end
    end
    return false
end

function M:CheckKillEnemy(_heroId,_battleLevel,skillId,_enemyId)
    if self.heroId ~= _heroId then
        return false
    end

    if self.taskType == EnumConst.EBattleTaskType.HeroKillEmNumber then 
        return true
    elseif self.taskType == EnumConst.EBattleTaskType.HeroKillTargetEm then
        return _enemyId == self.enemyId
    elseif self.taskType == EnumConst.EBattleTaskType.HeroKillEmNumberByBattleLevel then
        return self.battleLevel == _battleLevel
    elseif self.taskType == EnumConst.EBattleTaskType.HeroKillTargetEmByBattleLevel then
        return self.battleLevel == _battleLevel and _enemyId == self.enemyId
    end
    return false
end

function M:GetTaskType()
    return self.taskType
end

return TaskChecker 

