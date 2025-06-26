-- @FileName:   DanKeStageConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.danke.manager.vo.DanKeStageConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key

    self.stage_name = cusData.stage_name
    self.figure = cusData.figure
    self.map_id = cusData.map_id
    self.reward = cusData.reward
    self.skill_list = cusData.skill_list
    self.skill_weight = cusData.skill_weight
    self.key_monster = cusData.key_monster
    self.star_list = cusData.star_list
    self.pre_id = cusData.pre_id

    if not table.empty(cusData.begin_time) then
        self.begin_time =
        {
            year = cusData.begin_time[1][1],
            month = cusData.begin_time[1][2],
            day = cusData.begin_time[1][3],
            hour = cusData.begin_time[2][1],
            min = cusData.begin_time[2][2],
            sec = cusData.begin_time[2][3],
        }
    end
end

function isOpen(self)
    if table.empty(self.begin_time) then
        return true
    end
    local openDt = os.time(self.begin_time)
    return GameManager:getClientTime() >= openDt
end

function getStageStarConfigList(self)
    if not self.m_starConfigList then
        self.m_starConfigList = {}

        for i = 1, #self.star_list do
            local starConfig = danke.DanKeManager:getStarConfigVo(self.star_list[i])
            self.m_starConfigList[i] = starConfig
        end
    end

    return self.m_starConfigList
end

function getInitSkill(self)
    local skillConfig_list = {}
    for i = 1, #self.skill_list do
        local skillConfig = danke.DanKeManager:getPlayerSkillConfigVo(self.skill_list[i])
        table.insert(skillConfig_list, skillConfig)
    end
    return skillConfig_list
end

function getAward(self)
    return AwardPackManager:getAwardListById(self.reward[1])
end

function getIcon(self)
    return "arts/ui/bg/danke/" .. self.figure
end

function getRandomSkill(self)
    local playThing = danke.DanKeSceneController:getPlayerThing()

    local skill_list = {}
    local totalWeight = 0
    for i = 1, #self.skill_weight do
        local skill_weight = self.skill_weight[i]

        local skillConfig = danke.DanKeManager:getPlayerSkillConfigVo(skill_weight.skill_id)
        if skillConfig then
            local isLock = false
            local weight = skill_weight.weight

            local skill = playThing:getSkill(skill_weight.skill_id)
            if skill then
                --判断是否满级了
                local skillVo = skill:getDataVo()
                if skillVo:isMaxLevel() then
                    isLock = true
                else
                    local need_skill = skillVo:getNeedSkill()
                    ---判断是不是前置技能是否解锁了
                    for _, condition_list in pairs(need_skill) do
                        for k, condition in pairs(condition_list) do
                            local skill_id = condition[1]
                            local level = condition[2]

                            if skillVo.level < level then
                                isLock = true
                                break
                            end
                        end

                        if isLock then
                            break
                        end
                    end
                end
            elseif playThing:getSkillCount(skillConfig.type) >= DanKeConst.PlayerMaxSkillCount then--技能栏是不是满了
                isLock = true
            end

            if not isLock then
                table.insert(skill_list, {skill_config = skillConfig, weight = weight})

                totalWeight = totalWeight + weight
            end
        end
    end

    local skill_num = table.nums(skill_list)
    local get_num = skill_num < 3 and skill_num or 3

    local skill_randomList = {}
    for k = 1, get_num do
        local skill_index = 0

        local random = math.random(1, totalWeight)
        for i = 1, #skill_list do
            local weight = skill_list[i].weight
            if random <= weight then
                skill_index = i
                totalWeight = totalWeight - weight
                table.insert(skill_randomList, skill_list[i].skill_config)
                break
            else
                random = random - weight
            end
        end

        if skill_index ~= 0 then
            table.remove(skill_list, skill_index)
        end
    end

    return skill_randomList
end

return _M
