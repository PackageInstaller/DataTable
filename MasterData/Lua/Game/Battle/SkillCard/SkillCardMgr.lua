--
-- Author:luqucheng
-- Date: 2019-11-27 11:48:09
--
local SkillCard = import('Game.Battle.SkillCard.SkillCard')
local CatSkillCard = import('Game.Battle.SkillCard.CatSkillCard')

local SkillCardMgr = {}
SkillCardMgr = Class("SkillCardMgr")

--当前手牌
--@RefType [Game.Battle.SkillCard.SkillCard#SkillCard<>]
SkillCardMgr.row1 = nil--上排
--@RefType [Game.Battle.SkillCard.SkillCard#SkillCard<>]
SkillCardMgr.row2 = nil--下排
SkillCardMgr.recs = nil
SkillCardMgr.ultraCardQueue = nil
SkillCardMgr.forceCardQueue = nil
SkillCardMgr.forceCardQueueLoop = false
SkillCardMgr.forceCardQueueIndex = nil


SkillCardMgr.row1Backup = nil
SkillCardMgr.row2Backup = nil
SkillCardMgr.recsBackup = nil
SkillCardMgr.ultraCardBackup = nil
SkillCardMgr.camp = nil

--为试炼记录用卡数量
SkillCardMgr.totalUnitedCard = nil
SkillCardMgr.totalUsedCard = nil
SkillCardMgr.totalUsedSp = nil

SkillCardMgr.statistics = nil

SkillCardMgr.rolesSkillDatas = nil

SkillCardMgr.nowTurnUsedCards = nil

SkillCardMgr.catSkillCardPos = nil      -- 猫卡position
SkillCardMgr.catSkillCard = nil         -- 猫球主动技能卡
SkillCardMgr.catSkillCardBackup = nil   -- 猫球主动技能卡备份

--初始化
--@TODO 2019-11-27 10:26:14 传入初始牌库
function  SkillCardMgr:Init(camp, roleDatas, skillCatDatas, playerId)
    self.camp = camp
    self.playerId = playerId
    self.row1 = {}
    self.row2 = {}
    self.ultraCardQueue = {}
    self.totalUnitedCard = {0, 0, 0}
    self.totalUsedCard = {0, 0, 0}
    self.totalUsedSp = 0
    self.statistics = {}
    self.forceCardQueue = {}

    self.rolesSkillDatas = {}
    for j,wave in ipairs(roleDatas) do
        for i,roleData in ipairs(wave) do
            --技能初始化
            local skillCardInfos = {}
            for k,v in pairs(roleData.generalSkills) do
                if not Tools.isNullKey(v) then
                    skillCardInfos[tonumber(k)] = {id = v, lv = 1}
                end
            end
    
            local ultraInfo = Tools.splitToNum( roleData.finalSkills, '=')
            skillCardInfos[0] = {id = ultraInfo[1], lv = ultraInfo[2]}
    
            self.rolesSkillDatas[roleData.id] = skillCardInfos
        end
    end

    -- 猫球
    self.catSkillCardPos = {-1,-1}
    if skillCatDatas and table.count(skillCatDatas) > 0 then
        for i, catData in ipairs(skillCatDatas) do  -- 目前这个数组里应该只有两个数据，一个主动猫球，一个被动猫球
            if catData.type == 1 then
                -- 把主动猫球的技能放进rolesSkillDatas里面
                -- 因为猫也按角色来做的，主要功能就是为了放技能，所以都放进self.rolesSkillDatas里面
                local skillCardInfos = {}
                local ultraInfo = Tools.splitToNum( catData.finalSkills, '=')
                skillCardInfos[0] = {id = ultraInfo[1], lv = ultraInfo[2]}
                self.rolesSkillDatas[catData.id] = skillCardInfos
                -- 构造主动技能猫卡
                local skillParam = Core:GetSkillCatSkillParam(catData.catId, catData.star)
                self.catSkillCard = CatSkillCard.New(catData.id, ultraInfo[2], skillParam.initCD, skillParam.skillCD, skillParam.maxNum, nil, skillParam.aiSlotIndex)
            end
        end
    end
    -- 是否自动使用猫球
    self.autoUseCatCard = true
end

function SkillCardMgr:SetForceCardQueue( teamData, forceQueue, isForceLoop )
    self.forceCardQueue = {}
    if not Tools.isNullKey(forceQueue) then
        local cs = Tools.splitToNum(forceQueue, '&', '=')
        -- print(table.toString(cs,"SkillCardMgr1"))
        -- print(table.toString(teamData,"SkillCardMgr2"))
        for i,v in ipairs(cs) do
            local index = v[1]
            local skillIndex = v[2]
            local star = v[3]
            local roleData = teamData[index]
            if roleData then
                table.insert(self.forceCardQueue, SkillCard.New(roleData.id, skillIndex, star, false))
            end
        end
    end
    -- print(table.toString(self.forceCardQueue,"SkillCardMgr3"))
    -- self.forceCardQueue = {SkillCard.New(1, 1, 1, false)}
    self.forceCardQueueLoop = isForceLoop == 1
    self.forceCardQueueIndex = 1
end

function SkillCardMgr:Test(  )
    -- self:LocalPushCard()
    -- self:PrintCards()
    -- self:UnitCard()
    -- self:PrintCards()
    -- -- self:MoveCard({5,1}, {4,1})
    
    self:LocalStartRound()
    self:PrintCards()
    self:UseCard({4,1})
    self:PrintCards()
    self:UseCard({4,2})
    self:PrintCards()
    self:MoveCard({4,2}, {1,2})
    self:PrintCards()
    self:LocalEndRound()
end

function SkillCardMgr:PrintCards(  )
    -- if self.camp == Constants.TargetCamp.Enemy then
    --     return
    -- end
    -- print('**************************************************')
    -- print('-----------------------------------------')
    -- print(table.concat( self:ToData(), '      '))
    -- print('-----------------------------------------')
    -- print('**************************************************')
end

function SkillCardMgr:GameStartRound(  )
    self.recs = {}
    self.nowTurnUsedCards = {}
    self.usedSkillNum = 0
    --特殊逻辑添加
    --每个人都直接出两张牌，最后两张随机
    --@ 2020-09-01 13:47:16 测试后新增需求，第一轮的卡星级全部为1，不受幸运影响
    local roles = self:GetRoles()
    if #roles <= 0 then
        return {}
    end
    for i,role in ipairs(roles) do
        -- local star1 = self:GetCardLevel(role)
        local card1 = SkillCard.New(role.id, 1, self:GetCardLevel(role), false)
        table.insert(self.row1, card1)

        -- local star2 = self:GetCardLevel(role)
        local card2 = SkillCard.New(role.id, 2, self:GetCardLevel(role), false)
        table.insert(self.row2, card2)
    end

    -- for i=1,1000 do
    --     local seed = "5de9cdd7978db" .. i
    --     local rr = Tools.baRandFactory(seed)
    --     local index = rr(#roles, 1)
    --     print("GameStartRound", index, seed, tonumber(seed, 16))
    -- end
    
    self:HandleUltraQueue()

    if #roles < 5 then
        --最后两张卡随机角色
        for i=1,2 do
            local card = self:GetUltraOrForceCard()
            if not card then
                local index = Core.Random(#roles, 1)
                local role = roles[index]
                card = SkillCard.New(role.id, i, self:GetCardLevel(role), false)
            end

            local row = i == 2 and self.row1 or self.row2
            table.insert(row, card)
        end
    end
    
    local rec = RecordMgr.PushSkillCardRecord.New(self.row1, self.row2, self)
    table.insert(self.recs, rec)

    -- 构造猫卡
    if isNotNull(self.catSkillCard) then
        self.catSkillCard:SetCD(0)
        local rec1 = RecordMgr.PushCatSkillCardRecord.New(self.catSkillCard, self.camp, self.playerId)
        table.insert(self.recs, rec1)
    end

    -- local rs = self:UnitCard()
    -- if #rs > 0 then
    --     table.link(self.recs, rs)
    --     --补卡后检测合卡，直到不需要补卡
    --     while true do
    --         local rec = self:LocalPushCard()
    --         if #rec.pushRow1 <=0 and #rec.pushRow2 <= 0 then
    --             break
    --         end
    --         table.insert(self.recs, rec)
        
    --         local rs = self:UnitCard()
    --         if #rs <= 0 then
    --             break
    --         end
    --         table.link(self.recs, rs)
    --     end
    -- end

    return self.recs
end

function SkillCardMgr:HandleUltraQueue(  )
    self.ultraCardQueue = {}
    --检查身上有没有大招卡，大招点有没有满，符合条件则塞入大招卡池
    local roles = self:GetRoles()
    if #roles <= 0 then
        return {}
    end
    for i,v in ipairs(roles) do
        if v.ultraPoint >= v.maxUltraPoint and self:GetRoleSkillCardCount(v.id, 0) <= 0
        and v.spPointType == 1 -- sp类型2的时候，不补大招牌
        then
            table.insert(self.ultraCardQueue, SkillCard.New(v.id, 0, v.ultraStar, true))
        end
    end
end

--本地逻辑开始卡牌回合
function SkillCardMgr:LocalStartRound(  )
    self.recs = {}
    self.usedSkillNum = 0
    local recs = {}
    self.nowTurnUsedCards = {}
    
    self:HandleUltraQueue()

    --补卡后检测合卡，直到不需要补卡
    while true do
        local rec = self:LocalPushCard()
        if #rec.pushRow1 <=0 and #rec.pushRow2 <= 0 then
            break
        end
        table.insert(recs, rec)
    
        local rs = self:UnitCard()
        if #rs <= 0 then
            break
        end
        table.link(recs, rs)
    end

    -- 刷新猫卡
    if isNotNull(self.catSkillCard) then
    -- and self.catSkillCard:HasRemainNum() then
        self.catSkillCard:ReduceCD(1)
        local rec = RecordMgr.PushCatSkillCardRecord.New(self.catSkillCard, self.camp, self.playerId)
        table.insert(self.recs, rec)
        table.link(recs, rec)
    end

    return recs
end

function SkillCardMgr:LocalEndRound( )
    local recs = self.recs
    --分析战报获得数据，当前技能卡数据，使用技能卡数据，能量点数据，下次大招数据
    local skills = {}
    local comboInfo = {}
    local unitCount = 0

    --获得这个技能的combo类型
    -- for i,rec in ipairs(recs) do
    --     --使用技能数据
    --     if rec.recordType == Constants.RecordType.UseCard then
    --         local role = Core:FindRole(rec.roleId)
    --         local skill = role:GetSkillByIndex(rec.skillIndex, rec.star)
    --         table.insert(comboInfo, skill.comboType)
    --     elseif rec.recordType == Constants.RecordType.MoveCard then
    --         table.insert(comboInfo, Constants.CardComboType.X)
    --     end
    -- end
    --获取combo组
    -- local comboResult = Core:GetCardCombo(comboInfo)
    -- --把combo转化成对应技能次序的combo数
    -- local combos = Core:CardComboResultToCombos(comboResult, comboInfo)
    -- print("OnActionInput", table.toString(comboInfo, "comboInfo"), table.toString(comboResult, "comboResult"), table.toString(combos, "combos"))
    for i,rec in ipairs(recs) do
        --使用技能数据
        if rec.recordType == Constants.RecordType.UseCard then
            table.insert(skills, {skillIndex = rec.skillIndex, targetId = rec.targetId, star = rec.star, roleId = rec.roleId, combo = 1, params = rec.params})   --combos[#skills + 1]
            if not self:IsCatCard(rec.dst) then
                if rec.isUltra then
                    self.totalUsedSp  = self.totalUsedSp + 1
                else
                    self.totalUsedCard[rec.star]  = self.totalUsedCard[rec.star] + 1

                    -- 战斗统计
                    local roleId = rec.roleId
                    self.statistics[roleId] = self.statistics[roleId] or {}
                    self.statistics[roleId].useCard = self.statistics[roleId].useCard or 0
                    self.statistics[roleId].useCard = self.statistics[roleId].useCard + 1
                end
            end
        end
        if rec.recordType == Constants.RecordType.UnitCard then
            unitCount = unitCount + 1
            self.totalUnitedCard[rec.resultStar]  = self.totalUnitedCard[rec.resultStar] + 1
        end
    end


    for i,v in ipairs(self.recs) do
        v.camp = self.camp
    end

    --清空一下
    self.recs = {}
    return skills, recs, unitCount
end

function SkillCardMgr:UpdateMission( skills, recs )
    -- --处理任务
    -- for i,v in ipairs(skills) do
    --     local role = Core:FindRole(v.roleId)
    --     local skill = role:GetSkillByIndex(v.skillIndex, v.star)
    --     ConditionMgr:UpdateConditionData(Constants.GameOverCondition.UseSomeElementCard, role.elementType)
    --     ConditionMgr:UpdateConditionData(Constants.GameOverCondition.UseSomeTypeSkill, skill.label)
    --     if v.skillIndex == 0 then
    --         ConditionMgr:UpdateConditionData(Constants.GameOverCondition.UseUltraSkill)
    --     end
    -- end
    --合成任务
    for i,rec in ipairs(recs) do
        if rec.recordType == Constants.RecordType.UnitCard then
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.UnitSomeStarCards, rec.resultStar)
            ConditionMgr:UpdateConditionData(Constants.GameOverCondition.UnitCard, rec.resultStar)
        end
    end
end

function SkillCardMgr:OnChangeUseCardTargetId( recIndex, targetId )
    local recs = self.recs
    local index = 0
    --获得这个技能的combo类型
    for i,rec in ipairs(recs) do
        --使用技能数据
        if rec.recordType == Constants.RecordType.UseCard then
            index  = index + 1
            if index == recIndex then
                rec.targetId = targetId
                return
            end
        end
    end
end

function SkillCardMgr:AddUltraPoint( recs )
    for i,rec in ipairs(recs) do
        --能量点积累
        if 
        rec.recordType == Constants.RecordType.MoveCard or 
        rec.recordType == Constants.RecordType.UnitCard then
            local point = rec.point
            --找到角色
            --@RefType [Game.Battle.Entity.Role#Role]
            local role = Core:FindRole(point[1])
            assert(role, '找不到增加大招点数的角色：'..point[1])

            role:SetUltraPoint(role.ultraPoint + point[2], Constants.AddSPType.UnitCard)
            -- print("add point", role.id, point[2], role.ultraPoint, rec.recordType)
        end
    end
end

function SkillCardMgr:Reset(  )
    self.usedSkillNum = 0
    -- self.row1 = table.link({}, self.row1Backup) 
    -- self.row2 = table.link({}, self.row2Backup)
    self.nowTurnUsedCards = {}
    self.row1 = {}
    self.row2 = {}
    for i,v in ipairs(self.row1Backup) do
        table.insert(self.row1, SkillCard.New(v.roleId, v.skillIndex, v.star, v.isUltra, v.id))
    end
    for i,v in ipairs(self.row2Backup) do
        table.insert(self.row2, SkillCard.New(v.roleId, v.skillIndex, v.star, v.isUltra, v.id))
    end
    -- self.ultraCardQueue = self.ultraCardBackup
    if self.catSkillCardBackup then
        self.catSkillCard = DeepCopy(self.catSkillCardBackup)
    end
    if self.recsBackup then
        self.recs = table.link({}, self.recsBackup)
    else
        self.recs = {}
    end

    -- print('**************************************************')
    -- print('-----------------------------------------')
    -- print(table.concat( self:ToData(self.row1), '      '))
    -- print(table.concat( self:ToData(self.row2), '      '))
    -- print('-----------------------------------------')
    -- print('**************************************************')
end

-- function SkillCardMgr:SyncCards( record )
--     self.row1 = {}
--     for i,v in ipairs(record.r1) do
--         -- print("SyncCards", v)
--         local cs = Tools.splitToNum(v, '_')
--         local card = SkillCard.New(cs[1], cs[2], cs[3], cs[2] == 0)
--         table.insert(self.row1, card)
--     end

--     self.row2 = {}
--     for i,v in ipairs(record.r2) do
--         -- print("SyncCards2", v)

--         local cs = Tools.splitToNum(v, '_')
--         local card = SkillCard.New(cs[1], cs[2], cs[3], cs[2] == 0)
--         table.insert(self.row2, card)
--     end
--     self.row1Backup = {}
--     self.row2Backup = {}
--     self.ultraCardBackup = {}
--     for i,v in ipairs(self.row1) do
--         table.insert(self.row1Backup, SkillCard.New(v.roleId, v.skillIndex, v.star, v.isUltra))
--     end
--     for i,v in ipairs(self.row2) do
--         table.insert(self.row2Backup, SkillCard.New(v.roleId, v.skillIndex, v.star, v.isUltra))
--     end
--     for i,v in ipairs(self.ultraCardQueue) do
--         table.insert(self.ultraCardBackup, SkillCard.New(v.roleId, v.skillIndex, v.star, v.isUltra))
--     end
--     --当前录像备份
--     -- self.recsBackup = {}
--     -- table.link(self.recsBackup, self.recs)
--     self.recs = {}
-- end

function SkillCardMgr:Backup(  )
    --当前卡牌备份,深度备份
    self.row1Backup = {}
    self.row2Backup = {}
    self.ultraCardBackup = {}
    for i,v in ipairs(self.row1) do
        table.insert(self.row1Backup, SkillCard.New(v.roleId, v.skillIndex, v.star, v.isUltra, v.id))
    end
    for i,v in ipairs(self.row2) do
        table.insert(self.row2Backup, SkillCard.New(v.roleId, v.skillIndex, v.star, v.isUltra, v.id))
    end
    for i,v in ipairs(self.ultraCardQueue) do
        table.insert(self.ultraCardBackup, SkillCard.New(v.roleId, v.skillIndex, v.star, v.isUltra, v.id))
    end
    --当前录像备份
    self.recsBackup = {}
    table.link(self.recsBackup, self.recs)

    -- 备份猫卡
    if isNotNull(self.catSkillCard) then
        self.catSkillCardBackup = DeepCopy(self.catSkillCard)
    end

    --记录
    RecordMgr:AddRecord(RecordMgr.SyncSkillCardRecord.New(self) )
end

--- 获取猫卡的坐标
function SkillCardMgr:GetCatSkillCardPos()
    return self.catSkillCardPos
end

--- 根据卡牌位置判断是否是猫卡
---@param pos any
function SkillCardMgr:IsCatCard(pos)
    return pos[1] == -1 and pos[2] == -1
end

--- 猫卡是否处于可使用状态
function SkillCardMgr:CanUseCatCard()
    return isNotNull(self.catSkillCard) and self.catSkillCard:CanUse()
end

--- 自动出牌时，猫卡是否满足出牌条件
---@param slotIndex integer 出牌的顺序id
function SkillCardMgr:AiCanUseCatCard(slotIndex)
    if isNotNull(self.catSkillCard) and self.catSkillCard:CanUse() and self.autoUseCatCard then
        local aiIndex = self.catSkillCard.aiSlotIndex
        if aiIndex > 0 then
            return slotIndex == aiIndex
        else
            local maxIndex = self:GetSkillCardMaxUseCount()
            return slotIndex == (maxIndex + aiIndex + 1)
        end
    end
    return false
end

function SkillCardMgr:GetCard( pos )
    if self:IsCatCard(pos) then
        return self.catSkillCard
    else
        local row = pos[2] == 1 and self.row1 or self.row2
        local card = row[pos[1]]
        return card
    end
end

--@return [Game.Setting.Vo.SkillCardVo#Game.Setting.Vo.SkillCardVo]
-- function SkillCardMgr:GetCardSkill( pos )
--     local role, card = self:GetCardRole(pos)
--     local skillCardData = role:GetSkillCardDataByIndex(card.skillIndex)
--     return skillCardData, role, card
-- end

function SkillCardMgr:GetSkillCard(card)
    local infos = self.rolesSkillDatas[card.roleId]
    if infos then
        return Core:GetSkillCardData(infos[card.skillIndex].id), card
    end
end

function SkillCardMgr:GetCardSkillByPos(pos)
    local card = self:GetCard(pos)
    local infos = self.rolesSkillDatas[card.roleId]
    if infos then
        return Core:GetSkillCardData(infos[card.skillIndex].id), card
    end
end

function SkillCardMgr:GetSkillCardId(card)
    local infos = self.rolesSkillDatas[card.roleId]
    if infos then
        return infos[card.skillIndex].id
    end
end

--移动就是直接交换这两张卡
function SkillCardMgr:MoveCard( src, dst )
    local srcRow = src[2] == 1 and self.row1 or self.row2
    local dstRow = dst[2] == 1 and self.row1 or self.row2
    local cardSrc = srcRow[src[1]]
    local cardDst = dstRow[dst[1]]
    local rec = nil
    if self:CanUnit(cardSrc, cardDst) then
        --同卡移动特殊合成
        cardDst.star = cardDst.star + 1
        local point = {cardDst.roleId, 1}
        rec = RecordMgr.UnitSkillCardRecord.New(src, dst, point, cardDst.star, true, self)
        table.insert(self.recs, rec)
        table.remove(srcRow, src[1])
    else
        srcRow[src[1]] = dstRow[dst[1]]
        dstRow[dst[1]] = cardSrc
    
        local point = {cardSrc.roleId, 1}
        rec = RecordMgr.MoveSkillCardRecord.New(src, dst, point, self)
        table.insert(self.recs, rec)
    end

    --检测合成
    local rs = self:UnitCard()
    table.insert(rs, 1, rec)
    return rs
end

function SkillCardMgr:UseCard( dst, targetId, params )
    self.usedSkillNum  = self.usedSkillNum + 1
    local row = dst[2] == 1 and self.row1 or self.row2
    local skillCardData, card = self:GetCardSkillByPos(dst)
    -- print("UseCard", table.toString(params, "params"))
    table.insert(self.nowTurnUsedCards, card)

    -- print(card.star)
    local pointAdd = Constants.ReleaseCardPoint[card.star]
    local point = {card.roleId, pointAdd}

    local recs = {}
    local skillData = nil

    local handleUseCard = function ()
        local rec = RecordMgr.UseSkillCardRecord.New(dst, targetId, point, card, self, {}, params)
        skillData = {skillIndex = rec.skillIndex, targetId = rec.targetId, star = rec.star, roleId = rec.roleId, combo = 1, params = rec.params}   --combos[#skills + 1]
        table.insert(recs, rec)
        if self:IsCatCard(dst) then
            self.catSkillCard:ReduceUseNum(1)
            self.catSkillCard:ResetCD()     -- 先resetCD，然后push数据(这样给到UI的数据是准确的)
            local rec1 = RecordMgr.PushCatSkillCardRecord.New(DeepCopy(self.catSkillCard), self.camp, self.playerId)
            table.insert(recs, rec1)
            self.catSkillCard:ResetCD1()     -- 再重置到+1的状态
        else
            table.remove(row, dst[1])
        end
        return rec
    end

     --处理吞噬
     if skillCardData.cardBehavior == Constants.CardBehavior.Swallow and params then
        --移除被吞噬的卡
        local pos = params
        -- print("Swallow", pos[1], pos[2])
        local skillCardDataS, cardS = self:GetCardSkillByPos(pos)

        local r = RecordMgr.RemoveSkillCardRecord.New({pos}, self, 1)
        table.insert(recs, r)
        local rowS = pos[2] == 1 and self.row1 or self.row2
        table.remove(rowS, pos[1])

        --防止坐标错乱
        if pos[2] == dst[2] and pos[1] < dst[1] then
            dst[1] = dst[1] - 1
        end

        local rec = handleUseCard()
        rec.params.swallowCard = cardS
        if self:HasCardBehaviorTrigger(skillCardData, skillCardDataS) then
            --吞噬时候源头牌是被吞噬牌
            self:CardBehaviorTrig(skillCardData, skillCardDataS, cardS, card, pos[2], recs)
        end
    elseif skillCardData.cardBehavior == Constants.CardBehavior.Search and params and not Tools.isNullKey(params.skillIndex) then
        local rec = handleUseCard()
        local searchCard = SkillCard.New(params.roleId, params.skillIndex, params.star, params.skillIndex == 0)

        local infos = self.rolesSkillDatas[searchCard.roleId]
        local skillCardDataS = Core:GetSkillCardData(infos[searchCard.skillIndex].id)
        if self:HasCardBehaviorTrigger(skillCardData, skillCardDataS) then
            self:CardBehaviorTrig(skillCardData, skillCardDataS, card, searchCard, dst[2], recs)
        end
        local pushRec = self:PushCardWithOutUnit(searchCard, dst[2])
        if pushRec then
            table.insert(recs, pushRec)
        end
    elseif skillCardData.cardBehavior == Constants.CardBehavior.Choose and params and not Tools.isNullKey(params.skillIndex) then
        local chooseCard = SkillCard.New(card.roleId, params.skillIndex, card.star, card.isUltra)
        local infos = self.rolesSkillDatas[chooseCard.roleId]
        local skillCardDataS = Core:GetSkillCardData(infos[chooseCard.skillIndex].id)
        if self:HasCardBehaviorTrigger(skillCardData, skillCardDataS) then
            self:CardBehaviorTrig(skillCardData, skillCardDataS, chooseCard, card, dst[2], recs)
        end
        local r = self:ChangeCard(dst, chooseCard)
        table.insert(recs, r)
        local rec = handleUseCard()
    elseif skillCardData.cardBehavior == Constants.CardBehavior.Discard then
        local rec = handleUseCard()
        local rec2 = self:RemoveCard( card.roleId, true )
        table.insert(recs, rec2)
    elseif skillCardData.cardBehavior == Constants.CardBehavior.Upgrade and params then
        -- 升星卡
        local pos = params
        local c = self:FindCard(pos)
        local paramStar = skillCardData.cardBehaviorParam[1]
        c.star = paramStar > 0 and paramStar or (card.isUltra and 3 or card.star)
        c.star = math.range(c.star, 1, 3)

        local rec = self:ChangeCard(pos, c)
        table.insert(recs, rec)
        
        local rec = handleUseCard()
    else
        local rec = handleUseCard()
    end


    table.link(self.recs, recs)

    --检测合成
    local rs = self:UnitCard()
    table.link(recs, rs)
    self:PrintCards()
    return recs, skillData
end

--出牌行为触发器 card是源头牌,吞噬弃牌时为丢弃的牌,发现时为当时使用发现效果的牌
function SkillCardMgr:HasCardBehaviorTrigger(skillCardData, paramCardData)
    if paramCardData == nil then
        return false
    end
    local CardBehavior = Constants.CardBehavior
    local CardBehaviorTrigger = Constants.CardBehaviorTrigger

    --先判断是否满足触发扳机,触发器在目标牌上,行为在发起牌上
    if paramCardData.cardTrigger == CardBehaviorTrigger.AfterSwallow and skillCardData.cardBehavior == CardBehavior.Swallow then
        --1目标被移除时
        return true
    elseif  paramCardData.cardTrigger == CardBehaviorTrigger.BeforeSearch and skillCardData.cardBehavior == CardBehavior.Search then
        --2目标被发现时
        return true
    else
        return false
    end
end

--出牌行为触发器 card是源头牌,吞噬弃牌时为丢弃的牌,发现时为当时使用发现效果的牌
function SkillCardMgr:CardBehaviorTrig(skillCardData, paramCardData, srcCard, dstCard, srcRowIndex, recs)
    --根据触发结果和触发参数生效
    local CBTRT = Constants.CardBehaviorTriggerResultType;
    local switch = {
        [CBTRT.InsertAnotherCardWithRelateStar] = function (triggerPara)
            --如果控制星级参数为0,则设置卡牌星级与源头牌相同
            local skillStar = srcCard.star
            local skillIndex =  triggerPara[1] or 1
            if triggerPara[2] ~= 0 then
                skillStar = math.max(math.min(triggerPara[2] + srcCard.star, 3), 1)
            end
            local addCard = SkillCard.New(srcCard.roleId, skillIndex, skillStar, skillIndex == 0)
            local pushRec = self:PushCardWithOutUnit(addCard, srcRowIndex)
            if pushRec then
                table.insert(recs, pushRec)
            end
        end,
        [CBTRT.InsertAnotherCardWithConfigStar] = function (  triggerPara )
            local skillStar = srcCard.star
            local skillIndex =  triggerPara[1] or 1
            if triggerPara[2] ~= 0 then
                skillStar = math.max(math.min(triggerPara[2], 3), 1)
            end
            local addCard = SkillCard.New(srcCard.roleId, skillIndex, skillStar, skillIndex == 0)
            local pushRec = self:PushCardWithOutUnit(addCard, srcRowIndex)
            if pushRec then
                table.insert(recs, pushRec)
            end
        end,
        [CBTRT.ChangeDestCardStar] = function ( triggerPara )
            local skillStar = dstCard.star
            local skillIndex = dstCard.skillIndex
            if triggerPara[1] ~= 0 then
                skillStar = math.max( math.min( triggerPara[1] + dstCard.star, 3) ,1  )
            end
            dstCard.star = skillStar
        end,
    }
    return switch[paramCardData.triggerEffect]( paramCardData.triggerPara)
end

function SkillCardMgr:PushCardWithOutUnit(card, rowIndex)
    local row = rowIndex == 1 and self.row1 or self.row2

    if BattleInfo.gameMode == Constants.GameMode.PVE  then
        local roles = self:GetRoles()
        if #roles <= 0 then
            return
        end
        local maxCount = Constants.SkillCardMax[#roles]
        if #row >= maxCount / 2 then
            return
        end
    else
        --pvp暂时不处理了
    end
   
    table.insert(row, card)
    local r = RecordMgr.PushSkillCardRecord.New(rowIndex == 1 and {card} or {}, rowIndex == 2 and {card} or {}, self)
    return r
end

--加牌的本地逻辑
function SkillCardMgr:LocalPushCard(  )
    local roles = self:GetRoles()
    if #roles <= 0 then
        local rec = RecordMgr.PushSkillCardRecord.New({}, {}, self)
        table.insert(self.recs, rec)
    end

    -- --根据不同的剩余角色会改变卡池上限
    local maxCount = Constants.SkillCardMax[#roles] or 0
    -- print('maxcount', maxCount, #roles)
    local pushRow1 = {}
    local pushRow2 = {}
    local row1 = self.row1
    local row2 = self.row2

    -- print( "aaaaaaaaaaaaa111", #row1, #row2, maxCount )
    --如果卡的数量已经超过了上限的话，就不补卡了
    local pushCount = maxCount - #row1 - #row2
    for i = 1, pushCount, 1 do
        --根据由下到上由左到右的顺序补卡
        if #row2 < maxCount / 2 then
            local card = self:GetNextCard(roles)
            if card then
                table.insert(pushRow2, card)
                table.insert(row2, card)

                -- if card.skillIndex == 3 then
                --     print('pppppp'..self.camp, table.concat( self:ToData(self.row1), '      '))
                --     print('pppppp'..self.camp,table.concat( self:ToData(self.row2), '      '))
                -- end
            end
        end

        if #row1 < maxCount / 2 then
            local card = self:GetNextCard(roles)
            if card then
                table.insert(pushRow1, card)
                table.insert(row1, card)
                
                -- if card.skillIndex == 3 then
                --     print('pppppp'..self.camp, table.concat( self:ToData(self.row1), '      '))
                --     print('pppppp'..self.camp,table.concat( self:ToData(self.row2), '      '))
                -- end
            end
        end
    end

    local rec = RecordMgr.PushSkillCardRecord.New(pushRow1, pushRow2, self)
    table.insert(self.recs, rec)
    -- print("push card", table.toString(rec))
    -- if self.camp == Constants.TargetCamp.Friend then
    --     print(table.toString(rec, "ppppppppp2"))
    -- end
    self:PrintCards()
    return rec
end

--技能效果的补牌逻辑
function SkillCardMgr:EffectPushCard( roleId, skillIndex, star, preferRow )
    local roles = self:GetRoles()
    if #roles <= 0 then
        return {}
    end
    local pushRow1 = {}
    local pushRow2 = {}
    local row1 = self.row1
    local row2 = self.row2
    local maxCount = Constants.SkillCardMax[#roles]

    if #row1 + #row2 >= maxCount then
        return {}
    end
    --  print("EffectPushCard", #row1, #row2, maxCount, skillIndex, star, preferRow)

    local ws = {1, 1}
    if #row1 >= maxCount / 2 then
        ws[1] = 0
    end

    if #row2 >= maxCount / 2 then
        ws[2] = 0
    end

    if preferRow == 1 and #row1 < maxCount / 2 then
        ws[2] = 0
    elseif preferRow == 2 and #row2 < maxCount / 2 then
        ws[1] = 0
    end

    local card = SkillCard.New(roleId, skillIndex, star, skillIndex == 0)
    local index = Core:GetRandomIndexByWeight(ws)
    local pr = index == 1 and pushRow1 or pushRow2
    local r = index == 1 and row1 or row2
    table.insert(pr, card)
    table.insert(r, card)
    local rec = RecordMgr.PushSkillCardRecord.New(pushRow1, pushRow2, self)
   

    local rs = self:UnitCard()
    --增加大招点
    self:AddUltraPoint(rs)
    table.insert(rs, 1, rec)
    print(card)
    return rs
end

function SkillCardMgr:RemoveCard( roleId, skipUnitCard )
    -- print("BattleMyCard RemoveCard", roleId)
    --找到对应的角色的卡来移除
    local posArray = {}
    for i,v in fipairs(self.row1) do
        if v.roleId == roleId then
            table.remove(self.row1, i)
            table.insert(posArray, {i, 1})
        end
    end

    for i,v in fipairs(self.row2) do
        if v.roleId == roleId then
            table.remove(self.row2, i)
            table.insert(posArray, {i, 2})
        end
    end

    local rec = RecordMgr.RemoveSkillCardRecord.New(posArray, self)

    if skipUnitCard then
        return rec
    end

    local rs = self:UnitCard()
    --增加大招点
    self:AddUltraPoint(rs)
    table.insert(rs, 1, rec)
    -- table.insert(self.recs,rec)
    return rs
end

function SkillCardMgr:RemoveCards(cards, skipAddSP)
    local isFit = function (card)
        for i,v in ipairs(cards) do
            if v.id == card.id then
                return true
            end
        end
        return false
    end
    local posArray = {}
    for i,v in fipairs(self.row1) do
        if isFit(v) then
            table.remove(self.row1, i)
            table.insert(posArray, {i, 1})
        end
    end

    for i,v in fipairs(self.row2) do
        if isFit(v) then
            table.remove(self.row2, i)
            table.insert(posArray, {i, 2})
        end
    end

    local rec = RecordMgr.RemoveSkillCardRecord.New(posArray, self)
    local rs = self:UnitCard()
    if skipAddSP then
    else
        --增加大招点
        self:AddUltraPoint(rs)
    end
    table.insert(rs, 1, rec)
    return rs
end

function SkillCardMgr:RemoveAllCards(  )
    local posArray = {}
    for i,v in fipairs(self.row1) do
        table.remove(self.row1, i)
        table.insert(posArray, {i, 1})
    end

    for i,v in fipairs(self.row2) do
        table.remove(self.row2, i)
        table.insert(posArray, {i, 2})
    end

    local rec = RecordMgr.RemoveSkillCardRecord.New(posArray, self)
    local rs = self:UnitCard()
    --增加大招点
    self:AddUltraPoint(rs)
    table.insert(rs, 1, rec)
    -- table.insert(self.recs,rec)
    return rs
end

function SkillCardMgr:RemoveRoleCard( roleId, skillIndex )
    local posArray = {}
    for i,v in fipairs(self.row1) do
        if v.roleId == roleId and skillIndex == v.skillIndex then
            table.remove(self.row1, i)
            table.insert(posArray, {i, 1})
        end
    end

    for i,v in fipairs(self.row2) do
        if v.roleId == roleId and skillIndex == v.skillIndex then
            table.remove(self.row2, i)
            table.insert(posArray, {i, 2})
        end
    end

    local rec = RecordMgr.RemoveSkillCardRecord.New(posArray, self)
    local rs = self:UnitCard()
    --增加大招点
    self:AddUltraPoint(rs)
    table.insert(rs, 1, rec)
    -- table.insert(self.recs,rec)
    return rs
end

--@card: [Game.Battle.SkillCard.SkillCard#SkillCard]
function SkillCardMgr:ChangeCard( pos, card )
    local c = self:FindCard(pos)
    if c and card then
        c.roleId = card.roleId
        c.skillIndex = card.skillIndex
        c.star = card.star
        c.isUltra = card.isUltra

        local rec = RecordMgr.ChangeSkillCardRecord.New(pos, c, self)
        return rec
    end
end

--检测手牌合成
function SkillCardMgr:UnitCard(  )
    --合成会影响角色的能量值
    --合成顺序按照先左右后上下
    --不会一次判断多对合成，按照优先级判断一对之后再次处理
    local unitRec = {}

    local row1 = self.row1
    local row2 = self.row2

    local unit = function ( srcCard, dstCard, srcCoord, dstcoord )
        local card = dstCard
        --星级+1
        card.star = card.star + 1
        local pointAdd = Constants.UnitCardPoint[card.star]
        -- self.points[card.roleId] = self.points[card.roleId] and self.points[card.roleId] + pointAdd or pointAdd
        local point = {card.roleId, pointAdd}
        local rec = RecordMgr.UnitSkillCardRecord.New(srcCoord, dstcoord, point, card.star, false, self)
        return rec
    end

    local rowUnit = function ( row, lineIndex )
        for i=#row, 2, -1 do
            --相邻的两张是否相同
            local card1, card2 = row[i - 1], row[i]
            if self:CanUnit(card1, card2)  then
                local src = {i, lineIndex}
                local dst = {i - 1, lineIndex}
                 --移除被合成的卡
                table.remove(row, i)
                return unit(card2, card1, src, dst)
            end
        end
    end
   
    local colUnit = function ( row1, row2 )
        --只需要取短的一边来判断合成就可以
        local len = #row1 < #row2 and #row1 or #row2
        for i=len, 1, -1 do
            local card1, card2 = row1[i], row2[i]
            if self:CanUnit(card1, card2)  then
                local src = {i, 1}
                local dst = {i, 2}
                 --移除被合成的卡
                table.remove(row1, i)
                return unit(card1, card2, src, dst)
            end
        end
    end
    
    --先判断行再判断列
    while true do
        local rec = rowUnit(row2, 2) or rowUnit(row1, 1) or colUnit(row1, row2)
        if not rec then
            break
        end
        table.insert(unitRec, rec)
    end
    table.link(self.recs, unitRec)

    -- print('unitcard')
    -- print(table.toString(unitRec,'unitRec'))
    self:PrintCards()
    return unitRec
end

--[[
    @desc: 
    author:luqucheng
    time:2019-11-27 15:03:59
    --@card1:[Game.Battle.SkillCard.SkillCard#SkillCard]
	--@card2: [Game.Battle.SkillCard.SkillCard#SkillCard]
    @return:
]]
function SkillCardMgr:CanUnit( card1, card2 )
    return card1.star < 3 and card1.roleId == card2.roleId and card1.skillIndex == card2.skillIndex and card1.star == card2.star and not card1.isUltra and not card2.isUltra
end

function SkillCardMgr:GetUltraOrForceCard(  )
     -- 当角色的能量点为满的状态时，必然按照能量满的前后顺序获得大招技能卡。大招技能卡同样占用一次技能卡获取概率。但是不会影响该角色的其他两个技能的单技能分配概率
     if #self.ultraCardQueue > 0 then
        local card = self.ultraCardQueue[1]
        -- print('22pppppp'..self.camp, card:ToData())
        table.remove(self.ultraCardQueue, 1)
        return card
    end

    local forceLen = #self.forceCardQueue
    if forceLen > 0 and (self.forceCardQueueIndex <= forceLen or self.forceCardQueueLoop) then
        local card = self.forceCardQueue[self.forceCardQueueIndex]
        self.forceCardQueueIndex = self.forceCardQueueIndex + 1
        if self.forceCardQueueLoop and self.forceCardQueueIndex > forceLen then
            self.forceCardQueueIndex = 1
        end
        return SkillCard.New(card.roleId, card.skillIndex, card.star, card.isUltra) 
    end
end

--@roles: [Game.Battle.Entity.Role#Role<>]
--@return [Game.Battle.SkillCard.SkillCard#SkillCard]
function SkillCardMgr:GetNextCard( roles )
    -- if self.camp == Constants.TargetCamp.Friend then
    --     return SkillCard.New(1, 1, 1, true)
    -- end

    local card = self:GetUltraOrForceCard()
    if card then
        return card
    end

    --先按角色随机
    local row1 = self.row1
    local row2 = self.row2
    local inRandomRoles = {}
    local weights = {}
    -- print('11pppppp'..self.camp)

    for i,v in ipairs(roles) do
        --根据每个角色的情况计算权重

        local prob = v.buffMgr:ChangePushCardProb()
        if prob ~= nil and prob == 0 then
            -- 跳过这个角色
        else
            -- 每个角色在初始补牌的时候获得该角色的技能卡的权重为100.若卡库中每有一个该角色的技能卡时,则获获取权重降低对应的数值
            local w = 100
            local count = self:GetRoleCardCount(v.id)
            -- 当卡库中的技能卡数量大于等于7时，对卡库中无技能卡的角色进行补偿。补偿为必然获得该角色的技能卡。技能卡类型随机分配。
            local CardMakeUpLimit = Core:GetBattleParamNum(Constants.BattleParam.CardMakeUpLimit)
            if count <= 0 and #row1 + #row2 >= CardMakeUpLimit then
                return self:GetRoleCard(v)
            end
            -- 当一个角色的技能卡数量在卡库中大于等于4个，则该角色获取新技能卡的权重为0.
            local MultiCardDecrease = Core:GetBattleParamNum(Constants.BattleParam.CardWeightArray, true)
            if count > #MultiCardDecrease then
                w = 0
            elseif count > 0 then
                w = w - MultiCardDecrease[count]
            end
            table.insert(weights, prob or w)
            table.insert(inRandomRoles, v)
        end
    end
    if #inRandomRoles == 0 then
        return nil
    end
    local ri = Core:GetRandomIndexByWeight(weights)
    return self:GetRoleCard(inRandomRoles[ri])
end

--根据角色来随机其技能
function SkillCardMgr:GetRoleCard( role )
    --获取角色
    local roleId = role.id
    --检测两个技能的技能卡数量
    local count1 = self:GetRoleSkillCardCount(roleId, 1)
    local count2 = self:GetRoleSkillCardCount(roleId, 2)

    -- 单个角色的每个技能卡分配概率为50%,若获得一个技能卡则该技能卡的分配概率降低25%,并且将降低的概率补偿至另外一个技能卡。
    local d = count1 - count2
    local rate = Core:GetBattleParamNum(Constants.BattleParam.CardWeightValue)
    local w1 = math.range(0, 50 - d * rate, 100)
    local w2 = math.range(0, 50 + d * rate, 100)

    local r = Core.Random() * (w1 + w2)
    local star = self:GetCardLevel(role)
    if r <= w1 then
        return SkillCard.New(roleId, 1, star, false)
    else
        return SkillCard.New(roleId, 2, star, false)
    end
end

--@role: [Game.Battle.Entity.Role#Role]
function SkillCardMgr:GetCardLevel( role )
    -- 幸运值计算公式
    -- 幸运值基础概率公式: LK*((pi^(1/2)*N)-1)/400+0.02
    -- N为在未获得2星卡时获得的1星卡数量
    -- 则当LK*((pi^(1/2)*N)-1)/400+0.02>=1时,则第N张卡必然为2星卡。并且在获得2星卡后，N重置为0，重新开始计数。
    -- 当LK*((pi^(1/2)*N)-1)/400+0.02<1时，同时已经获得一张2星卡,则N重置为0，重新开始计数。
    --获取累计的概率
    -- local count = role.unluckCount or 1
    local luckMultiplier = Core:GetBattleParamNum(Constants.BattleParam.LuckMultiplier)
    local luckAdd = Core:GetBattleParamNum(Constants.BattleParam.LuckAdd)
    local rate = role:GetAttr(Constants.AttrTypeId.Luck) * luckMultiplier + luckAdd
    -- local rate = role:GetAttr(Constants.AttrTypeId.Luck) * (1.77245 * count - 1) / luckParam + 0.02
    if rate >= 1 then
        print("[幸运]", role.id, rate)
        return 2
    end
    local r = Core.Random()
    print("[幸运]", role.id, rate, r)
    if r <= rate then
        --判断二星成功
        -- role.unluckCount = 1
        return 2
    else
        -- role.unluckCount = count + 1
        return 1
    end
end

--获得某个角色拥有的技能卡数量
function SkillCardMgr:GetRoleCardCount( roleId )
    local count = 0
    local row1 = self.row1
    for i,v in ipairs(row1) do
        if v.roleId == roleId then
            count = count + 1
        end
    end
    local row2 = self.row2
    for i,v in ipairs(row2) do
        if v.roleId == roleId then
            count = count + 1
        end
    end
    return count
end

--获取某个角色的某个技能卡数量
function SkillCardMgr:GetRoleSkillCardCount( roleId, skillIndex )
    local count = 0
    local row1 = self.row1
    for i,v in ipairs(row1) do
        if v.roleId == roleId and v.skillIndex == skillIndex then
            count = count + 1
        end
    end
    local row2 = self.row2
    for i,v in ipairs(row2) do
        if v.roleId == roleId and v.skillIndex == skillIndex then
            count = count + 1
        end
    end

    return count
end

--@return [Game.Battle.SkillCard.SkillCard#SkillCard]
function SkillCardMgr:FindCard( pos )
    if self:IsCatCard(pos) then
        return self.catSkillCard
    end
    local row = pos[2] == 1 and self.row1 or self.row2
    return row[pos[1]]
end

function SkillCardMgr:GetCardPos(card)
    for i,v in ipairs(self.row1) do
        if card.id == v.id then
            return {i, 1}
        end
    end
    for i,v in ipairs(self.row2) do
        if card.id == v.id then
            return {i, 2}
        end
    end
    if isNotNull(self.catSkillCard) then
        if card.id == self.catSkillCard.id then
            return self:GetCatSkillCardPos()
        end
    end
end

function SkillCardMgr:FindRoleCards(roleId)
    local cards = {}
    for i,v in ipairs(self.row1) do
        if v.roleId == roleId then
            table.insert(cards, v)
        end
    end
    for i,v in ipairs(self.row2) do
        if v.roleId == roleId then
            table.insert(cards, v)
        end
    end
    if isNotNull(self.catSkillCard) then
        if self.catSkillCard.roleId == roleId then
            table.insert(cards, self.catSkillCard)
        end
    end

    return cards
end

function SkillCardMgr:FindCardsByFunc(findFunc)
    local cards = {}
    for i,v in ipairs(self.row1) do
        if findFunc(v, {i, 1}) then
            table.insert(cards, v)
        end
    end
    for i,v in ipairs(self.row2) do
        if findFunc(v, {i, 2}) then
            table.insert(cards, v)
        end
    end
    -- if isNotNull(self.catSkillCard) then
    --     if findFunc(self.catSkillCard, self:GetCatSkillCardPos()) then
    --         table.insert(cards, self.catSkillCard)
    --     end
    -- end

    return cards
end

function SkillCardMgr:GetRoles()
    local playerRoles = {}
    local campRoles = BattleMgr:GetAliveRolesWithoutSpecialSummon(self.camp)

    for i, roleData in ipairs(campRoles) do
        if roleData.playerId == self.playerId then
            table.insert(playerRoles, roleData)
        end
    end
    return playerRoles
end

function SkillCardMgr:ToData( )
    local data = {"卡池数据\n|"}
    for i,v in ipairs(self.row2) do
        table.insert(data, v:ToData())
        table.insert(data, "|")
    end
    table.insert(data, "\n|")
    for i,v in ipairs(self.row1) do
        table.insert(data, v:ToData())
        table.insert(data, "|")
    end
    return data
end

function SkillCardMgr:GetSkillCardMaxUseCount()
    local rs = self:GetRoles()
    return math.min(#rs + BattleInfo.gameRule.actionsNum, 5)
end

return  SkillCardMgr