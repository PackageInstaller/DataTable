--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:luqucheng
    time:2020-06-28 18:39:07
]]
local AIAgent = CS.CustomBehavior.AIAgent
local gameUtils = CS.GameUtils
local MonsterAI = {}
MonsterAI = Class("MonsterAI")

MonsterAI.role = nil-- 挂载ai的角色
MonsterAI.useSkills = nil
MonsterAI.aiAgents = nil

--@RefType [Game.Battle.Entity.Role#Role<>]
MonsterAI.targets = nil

MonsterAI.actionTimes = nil

function MonsterAI:__init()
    self.useSkills = {}
    self.aiAgents = {}
end

function MonsterAI:LoadBt( team )
    for j,wave in ipairs(team) do
        for i,v in ipairs(wave) do
            --读取怪物表获得ai行为树
            if not Tools.isNullKey(v.ai) then
                print("MonsterAI", v.ai)
                local behaviorTree = self:GetBt(v.ai)
                self.aiAgents[v.id] = behaviorTree
            end
        end
    end
end

function MonsterAI:GetBt( ai )
    -- --@RefType [Game.Setting.Vo.MonsterTypeVo#MonsterTypeVo]
    -- local monsterTypeVo = setting:Get(typeId)

    -- assert(monsterTypeVo, "找不到对应的怪物:"..typeId)

    -- local agent = AIAgent(monsterTypeVo.ai)
    -- agent:SetEnv(self)
    -- self.aiAgents[v.id] = agent

    local behaviorTree = b3.BehaviorTree.New()
    local jsonData = CS.CustomBehavior.BehaviorFileManager.ReadJson(ai)
    local d = table.deserialize(jsonData)
    behaviorTree:load(d, {})
    return behaviorTree
end

function MonsterAI:GetAIAction( camp, isSpecialSummonOnly)
    local rs = BattleMgr:GetAliveRoles(camp)
    local actions = {}
    --如果当前波次是自由分配类型的战斗，则需要分配行动次数
    local waveData = BattleMgr:GetWaveData()
    if (waveData and waveData.useRandomAction) or BattleInfo.isSimulator then
        local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting39, "MonsterTypeVo")
         --先获取行动总量
        local totalActionTimes = 0
        for i,v in ipairs(rs) do
            if not v.isPlayer then
                --@RefType [Game.Setting.Vo.MonsterTypeVo#MonsterTypeVo]
                local monsterTypeVo = setting:Get(v.typeId, true)
                if monsterTypeVo then
                    totalActionTimes  = totalActionTimes + monsterTypeVo.behavior
                end
            end
        end

        --先根据有大招的人，每人分配一点
        for i,v in ipairs(rs) do
            if not v.isPlayer then
                if v:IsUltraPointMax() and totalActionTimes > 0 then
                    local t = actions[i] or 0
                    actions[i] = t + 1
                    totalActionTimes = totalActionTimes - 1
                end
            end
        end

        if waveData and waveData.useRandomAction then
            if waveData.useRandomAction == 1 then
                --随机分配
                for i=1,totalActionTimes do
                    local index = Core.Random(#rs, 1)
                    local t = actions[index] or 0
                    actions[index] = t + 1
                end
            elseif waveData.useRandomAction == 2 then
                -- 找到id最小的，all in one
                actions[1] = totalActionTimes
            else
                -- 默认每人使用自己的行动点
                for i,v in ipairs(rs) do
                    if not v.isPlayer then
                        --@RefType [Game.Setting.Vo.MonsterTypeVo#MonsterTypeVo]
                        local monsterTypeVo = setting:Get(v.typeId, true)
                        actions[i] = monsterTypeVo.behavior
                    end
                end
            end
        else
            -- 模拟器
            -- 默认每人使用自己的行动点
            for i,v in ipairs(rs) do
                if not v.isPlayer then
                    --@RefType [Game.Setting.Vo.MonsterTypeVo#MonsterTypeVo]
                    local monsterTypeVo = setting:Get(v.typeId, true)
                    actions[i] = monsterTypeVo.behavior
                end
            end
        end
    end

    local skills = {}
    for i,v in ipairs(rs) do
        if not Tools.isNullKey(v.rawData.ai) and (not isSpecialSummonOnly or BattleMgr:IsSpecialSummonRole(v.id)) then
             --找到对应的
            local s = self:StartBehaviorTree(v, actions[i] or 0)
            table.link(skills, s)
        end
    end

    --根据优先级排序
    table.inPlaceBubbleSort(skills, function(a, b)
        return a.priority > b.priority
    end)

    -- print(table.toString(skills, "GetAIAction"))
    return skills
end

function MonsterAI:GetAIAgent( role )
    local agent = self.aiAgents[role.id]
    if not agent then
        --可能是召唤生物，尝试加载
        local behaviorTree = self:GetBt(role.rawData.ai)
        agent = behaviorTree
        self.aiAgents[role.id] = agent
    end
    assert(agent, "找不到对应的aiagent")
    -- if not agent:HasEnv() then
    --     agent:SetEnv(self)
    -- end
    return agent
end

function MonsterAI:StartBehaviorTree( role, actionTimes )
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "开始", "->  id ", role.id, "行动次数", actionTimes)
    end
    local agent = self:GetAIAgent(role)
    self.role = role
    self.useSkills = {}
    self.targets = {}
    self.actionTimes = actionTimes
    -- agent:DoAI()
    agent:tick(self, b3.Blackboard.New())
    return self.useSkills
end

function MonsterAI:UseSkill( data )
    local skillIndex = data.skillIndex
    local star = data.star
    local coolDown = data.coolDown
    local priority = data.priority

    --记录技能cd
    if not self.role.aiSkillCd then
        self.role.aiSkillCd = {}
    end
    --设置下次可以释放的回合数
    self.role.aiSkillCd[skillIndex] = BattleMgr.totalTurnCount + coolDown
    --根据技能id，获取技能index
    local targetId = 0
    --获取目标id
    --如果targets存在，就取第一个，不存在就随机取一个
    if #self.targets > 0 then
        targetId = self.targets[1].id
    end

    local skill = {skillIndex = skillIndex, targetId = targetId, star = star, roleId = self.role.id, combo = 1, priority = priority}
    table.insert(self.useSkills,  skill)
    
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "使用技能        ", "->  id ", self.role.id, "技能", table.dump(skill))
    end
end

function MonsterAI:ClearTargets(data)
    self.targets = {}

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "清除筛选结果", "->  id ", self.role.id, "结果", self.targets)
    end
end

function MonsterAI:PickTargets( data )
    local isFriend = self:IsTrue(data.isFriend)
    local c = isFriend and self.role.camp or BattleMgr:GetOppoCamp(self.role.camp)
    self.targets = table.link({}, BattleMgr:GetAliveRoles(c))

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        local targets = {}
        for i, v in ipairs(self.targets) do
            table.insert(targets, {id = v.id})
        end
        print("[行为树] ", "选取阵容目标", "->  id ", self.role.id, "结果", table.dump(targets))
    end
end

--根据当前选定范围做反选
function MonsterAI:PickTargetsInverse( data )
    local isFriend = self:IsTrue(data.isFriend)
    local c = isFriend and self.role.camp or BattleMgr:GetOppoCamp(self.role.camp)
    local rs = BattleMgr:GetAliveRoles(c)
    local targets = {}

end

function MonsterAI:__delete(  )
    -- for k,agent in pairs(self.aiAgents) do
    --     agent:Dispose()
    -- end
    self.aiAgents = nil
    self.useSkills = nil
end

function MonsterAI:NotInCD( data )
    local skillIndex = data.skillIndex

    if not self.role.aiSkillCd or not self.role.aiSkillCd[skillIndex] then

        if BattleMgr.BATTLE_AI_SHOW_LOG then
            print("[行为树] ", "技能不在cd        ", "->  id ", self.role.id, "结果", true)
        end

        return true
    end
 
    local result = self.role.aiSkillCd[skillIndex] <= BattleMgr.totalTurnCount

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "技能不在cd        ", "->  id ", self.role.id, "结果", result, "cd", self.role.aiSkillCd[skillIndex])
    end
    return result
end

function MonsterAI:SPEnough(data)
    local num = data.num

    local result = self.role:GetUltraPoint() >= num
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "SP足够    ", "->  id ", self.role.id, "结果", result, "当前", self.role:GetUltraPoint(), "目标", num)
    end
    return result
end

function MonsterAI:SPFull(data)
    local result = self.role:GetUltraPoint() >= self.role.maxUltraPoint
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "SP满(参数无视)    ", "->  id ", self.role.id, "结果", result)
    end
    return result
end

function MonsterAI:IsHpPercentEnough( data )
    local num = data.num
    
    local result = self.role:GetNowHPPercent() >= num
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "自身血量百分比足够", "->  id ", self.role.id, "结果", result, "当前", self.role:GetNowHPPercent(), "目标", num)
    end
    return result
end

--拥有者的某个id的buff是否大于等于层数
function MonsterAI:IsMyBuffLayNumEnough( data )
    local buffId = data.buffId
    local layNum = data.layNum
    
    local result = self.role.buffMgr:GetBuffLayNumByBuffTypeID(buffId) >= layNum
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "自身buff层数  ", "->  id ", self.role.id, "结果", result, "buffId", buffId, "当前", self.role.buffMgr:GetBuffLayNumByBuffTypeID(buffId), "目标", layNum)
    end
    return result
end

function MonsterAI:WaveRoundMatch( data )
    local num = data.num

    local result = BattleMgr.turnCount == num
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "回合数等于    ", "->  id ", self.role.id, "结果", result, "当前", BattleMgr.turnCount, "目标", num)
    end
    return result
end

function MonsterAI:WaveRoundBigThan( data )
    local num = data.num

    local result = BattleMgr.turnCount > num
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "回合数大于    ", "->  id ", self.role.id, "结果", result, "当前", BattleMgr.turnCount, "目标", num)
    end
    return result
end

function MonsterAI:WaveRoundOdd(data)
    local isOdd = self:IsTrue(data.isOdd)
    local odd = BattleMgr.turnCount % 2 == 1

    local result = odd == isOdd
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "回合数为奇    ", "->  id ", self.role.id, "结果", result, "当前", BattleMgr.turnCount, "目标", isOdd)
    end
    return result
end

function MonsterAI:IsFriendMinHpPercentLessThan( data )
    local num = data.num

    local rs = BattleMgr:GetAliveRoles(self.role.camp)
    local min = 1
    for i,v in ipairs(rs) do
        --找到对应的
        local per = v:GetNowHPPercent()
        if per < min then
            min = per
        end
    end

    local result = min < num
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "友最低Hp百分比小于", "->  id ", self.role.id, "结果", result, "当前", min, "目标", num)
    end
    return result
end

function MonsterAI:IsFriendMaxHpPercentLessThan( data )
    local num = data.num

    local rs = BattleMgr:GetAliveRoles(self.role.camp)
    local max = 0
    for i,v in ipairs(rs) do
        --找到对应的
        local per = v:GetNowHPPercent()
        if per > max then
            max = per
        end
    end

    local result = max < num
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "友最高Hp百分比小于", "->  id ", self.role.id, "结果", result, "当前", max, "目标", num)
    end
    return result
end

function MonsterAI:IsAliveNumberEnough( data )
    local num = data.num
    local isFriend = self:IsTrue(data.isFriend)
    local c = isFriend and self.role.camp or BattleMgr:GetOppoCamp(self.role.camp)
    local ts = BattleMgr:GetAliveRoles(c)

    local result = #ts >= num
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "阵营存活人数大于等于", "->  id ", self.role.id, "结果", result, "阵营", c, "当前", #ts, "目标", num)
    end
    return result
end

--涨价身上某类型的buff层数是否足够
function MonsterAI:IsBuffTypeEnough( data )
    local main = data.main
    local sub = data.sub
    local mini = data.mini
    local type = data.type
    local num = data.num

    local curNum = self.role.buffMgr:GetBuffTypeNumber(main, sub, mini, type)
    local result = curNum >= num
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "自身某类型的buff层数", "->  id ", self.role.id, "结果", result, "参数", main, sub, mini, type, "当前", curNum, "目标", num)
    end
    return result
end

--行动次数是否足够
function MonsterAI:IsActionTimeEnough(data)
    local num = data.num

    local actionTime = self.actionTimes or 0
    local result = actionTime >= num
    
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "行动次数大于等于", "->  id ", self.role.id, "结果", result, "当前", self.actionTimes, "目标", num)
    end
    return result
end

--isAsc是否升序
function MonsterAI:SortByAttribute( data )
    local attrType = data.attrType
    local isAsc = self:IsTrue(data.isAsc)


    table.inPlaceBubbleSort(self.targets, function(a, b)
        if isAsc then
            return a:GetAttr(attrType) < b:GetAttr(attrType)
        else
            return a:GetAttr(attrType) > b:GetAttr(attrType)
        end
    end)

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        local targets = {}
        for i, v in ipairs(self.targets) do
            table.insert(targets, {id = v.id})
        end
        print("[行为树] ", "属性排序    ", "->  id ", self.role.id, "结果", table.dump(targets))
    end
end

function MonsterAI:SortByBuffNum( data )
    local isDebuff = self:IsTrue(data.isDebuff)
    local isAsc = self:IsTrue(data.isAsc)

    table.inPlaceBubbleSort(self.targets, function(a, b)
        if isAsc then
            return a.buffMgr:GetBuffOrDebuffNum(isDebuff) < b.buffMgr:GetBuffOrDebuffNum(isDebuff)
        else
            return a.buffMgr:GetBuffOrDebuffNum(isDebuff) > b.buffMgr:GetBuffOrDebuffNum(isDebuff)
        end
    end)
    
    if BattleMgr.BATTLE_AI_SHOW_LOG then
        local targets = {}
        for i, v in ipairs(self.targets) do
            table.insert(targets, {id = v.id})
        end
        print("[行为树] ", "buff数排序    ", "->  id ", self.role.id, "结果", table.dump(targets))
    end
end

function MonsterAI:SortBySpNum( data )
    local isAsc = self:IsTrue(data.isAsc)

    table.inPlaceBubbleSort(self.targets, function(a, b)
        if isAsc then
            return a:GetUltraPoint() < b:GetUltraPoint()
        else
            return a:GetUltraPoint() > b:GetUltraPoint()
        end
    end)

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        local targets = {}
        for i, v in ipairs(self.targets) do
            table.insert(targets, {id = v.id})
        end
        print("[行为树] ", "sp排序     ", "->  id ", self.role.id, "结果", table.dump(targets))
    end
end

function MonsterAI:SortRandom( )
    Core:Shuffle(self.targets)
    -- table.shuffle(self.targets)

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        local targets = {}
        for i, v in ipairs(self.targets) do
            table.insert(targets, {id = v.id})
        end
        print("[行为树] ", "随机排序      ", "->  id ", self.role.id, "结果", table.dump(targets))
    end
end

--过滤出第几个目标
function MonsterAI:FilterByIndex( data )
    local index = data.index
    while index > 0 do
        if index <= #self.targets then
            self.targets = {self.targets[index]}
            break
        end
        index = index - 1
    end

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        local targets = {}
        for i, v in ipairs(self.targets) do
            table.insert(targets, {id = v.id})
        end
        print("[行为树] ", "序号过滤      ", "->  id ", self.role.id, "结果", table.dump(targets))
    end
end

function MonsterAI:FilterByBuffId( data )
    local buffId = data.buffId

    for i,v in fipairs(self.targets) do
        if not v.buffMgr:HasBuffByBuffTypeID(buffId) then
            table.remove(self.targets, i)
        end
    end

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        local targets = {}
        for i, v in ipairs(self.targets) do
            table.insert(targets, {id = v.id})
        end
        print("[行为树] ", "buff过滤      ", "->  id ", self.role.id, "结果", table.dump(targets))
    end
end

function MonsterAI:FilterByCareer( data )
    local career = data.career

    for i,v in fipairs(self.targets) do
        if v.career ~= career then
            table.remove(self.targets, i)
        end
    end

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        local targets = {}
        for i, v in ipairs(self.targets) do
            table.insert(targets, {id = v.id})
        end
        print("[行为树] ", "职业过滤     ", "->  id ", self.role.id, "结果", table.dump(targets))
    end
end

function MonsterAI:FilterByElement( data )
    local element = data.element

    for i,v in fipairs(self.targets) do
        if v.elementType ~= element then
            table.remove(self.targets, i)
        end
    end

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        local targets = {}
        for i, v in ipairs(self.targets) do
            table.insert(targets, {id = v.id})
        end
        print("[行为树] ", "元素属性过滤     ", "->  id ", self.role.id, "结果", table.dump(targets))
    end
end

function MonsterAI:FilterByPos( data )
    local pos = data.pos

    for i,v in fipairs(self.targets) do
        if v.standPosition ~= pos then
            table.remove(self.targets, i)
        end
    end

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        local targets = {}
        for i, v in ipairs(self.targets) do
            table.insert(targets, {id = v.id})
        end
        print("[行为树] ", "位置过滤", "->  id ", self.role.id, "结果", table.dump(targets))
    end
end

function MonsterAI:CostActionTime( data )
    local beforeCost = self.actionTimes
    if self.actionTimes and self.actionTimes > 0 then
        self.actionTimes = self.actionTimes - 1
    end

    if BattleMgr.BATTLE_AI_SHOW_LOG then
        print("[行为树] ", "消耗行动次数    ", "->  id ", self.role.id, "消耗前", beforeCost, "消耗后", self.actionTimes)
    end
end

function MonsterAI:IsTrue( data )
    return data == "true" or data == true
end

return MonsterAI