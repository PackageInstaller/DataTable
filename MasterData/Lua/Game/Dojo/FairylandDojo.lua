---
--- 乱流幻境数据
--- Author: dawanfan
--- Date: 2024-1-9 11:18:15
---

---@type ConstantsFairyland
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")


---@class FairylandDojo
---@field currentQuestData table 当前进入关卡数据
---@field secretInfo {unlock:number, status:number, consume:table, showChallengeRewards:table, showProgressRewards:table}
---@field hpData {buyTimes:number, hp:number, lastCdTime:number}
local FairylandDojo = Class("FairylandDojo")

function FairylandDojo:__init()
    self.currentQuestData = {}
    self.secretInfo = {}
    self.hpData = {}
end

function FairylandDojo:__delete()
    self.currentQuestData = {}
    self.secretInfo = {}
    self.hpData = {}
end

function FairylandDojo:Fill(json)
    for id, secretInfo in pairs(checkTable(json.secretInfo)) do
        self.secretInfo[tonumber(id)] = secretInfo
    end
    self.questGradeTaskProgress = json.questGradeTaskProgress
    self.hpData = json.hpData
end

function FairylandDojo:UpdateSecretInfo(questId, info)
    for key, value in pairs(checkTable(info)) do
        self.secretInfo[questId][key] = value
    end
end

function FairylandDojo:GetRewardProgress(questId)
    if IsNull(questId) then
        questId = import("Game.Fairyland.FairylandUtils").CurrentEnterQuestId
    end

    local secretInfo = self.secretInfo[questId]
    if secretInfo then
        return secretInfo.progress
    end

    return 0
end

--- 自动领取，满足条件均为true
function FairylandDojo:IsProgressRewardTake(questId, progress)
    if IsNull(questId) then
        questId = import("Game.Fairyland.FairylandUtils").CurrentEnterQuestId
    end

    local secretInfo = self.secretInfo[questId]
    if secretInfo == nil then
        return false
    end

    return secretInfo.progress >= progress
end

function FairylandDojo:GetLevelInfo(questId, index)
    local secretInfo = self.secretInfo[questId]

    if index ~= ConstantsFairyland.SelectNodeIndex.Mirror then
        local levelId = secretInfo.questInfo[tostring(index)]
        ---@type FairylandLevelVo
        local fairylandLevelVo = CfUtils.GetCfVo(AutoIds.IdSetting6162, "FairylandLevelVo", levelId)

        local data = fairylandLevelVo
        return data
    else
        return {difficulty=4, energy=tonumber(secretInfo.energy) / 10, rewards=secretInfo.showChallengeRewards, proposalLevel=secretInfo.combatVal}
    end
    
end

function FairylandDojo:GetLevelId(questId, index)
    if index == ConstantsFairyland.SelectNodeIndex.Mirror then
        return Constants.SpecialQuestId.Mirror
    end

    local secretInfo = self.secretInfo[questId]
    return secretInfo.questInfo[tostring(index)]
end

function FairylandDojo:IsQuestFinished(questId)
    local secretInfo = self.secretInfo[questId]

    return secretInfo.status == ConstantsFairyland.QuestStatus.Finish
end

function FairylandDojo:GetQuestDifficultChallengeTimes(questId, index)
    local secretInfo = self.secretInfo[questId]
    if secretInfo == nil then
        return 0
    end

    local times = secretInfo.questLog[index]
    if IsNull(times) then
        return 0
    end

    return times
end

function FairylandDojo:GetQuestMirrorAllWaveEnemyData(questId)
    local secretInfo = self.secretInfo[questId]
    if secretInfo == nil then
        return nil
    end

    local enemyTeam = secretInfo.imageTeam.enemyTeam
    local allLineUp = {}
    local result = {}
    for wave, waveTeam in ipairs(enemyTeam) do
        local waveVo = {}
        local lineUp = {
            wave=wave,
            wave1NpcId={},
            wave1Level={},
            wave1NpcType={},
        }
        for i, enemyInfo in ipairs(waveTeam) do
            waveVo[i] = {
                attribute=enemyInfo.attribute,
                skinId=enemyInfo.skinId,
                monsterClass=2,
                role=1,
                weakness=0,
                skillData = self:GeneralImageHeroSkillInfo(enemyInfo)
            }
            lineUp.wave1Level[i] = enemyInfo.level
            lineUp.wave1NpcId[i] = enemyInfo.id
            lineUp.wave1NpcType[i] = 1
        end
        result[wave] = waveVo
    end

    return allLineUp, result
end

function FairylandDojo:GeneralImageHeroSkillInfo(enemyInfo)
    local UIBattlingTools = import("Game.UI.UIBattling.UIBattlingTools")


    local spSkill = parse_strings(enemyInfo.finalSkills, "=")
    local atkSkillIdList = enemyInfo.generalSkills
    local passiveSkills = parse_strings(enemyInfo.passiveSkills, "&")

    local result = {}

    local spSkillId, spSkillLevel = checkNumber(spSkill[1]), checkNumber(spSkill[2])
    if spSkillId > 0 and spSkillLevel > 0 then
        local vo = UIBattlingTools.GetSkillCardInfoByTwoParam(checkNumber(spSkill[1]))
        local skillDescList = CardUtils.ParseSkillDescBySkillId(spSkillId, 1, 1, 1, spSkillLevel)
        local skillDesc = table.concat(skillDescList)
    
        table.insert(result, {isSp = true, titleName = vo.skillName, desc = skillDesc})
    end
    
    for i, skillId in pairs(atkSkillIdList) do
        if checkNumber(skillId) > 0 then
            ---@type SkillCardVo
            local skillVo = UIBattlingTools.GetSkillCardInfoByTwoParam(skillId)
            local skillName = skillVo.skillName
            local desc = table.concat(CardUtils.ParseSkillDescBySkillId(skillId, 1))
            table.insert(result, {titleName = skillName, desc = desc, skillTypeName = localize("主动")})
        end
    end

    local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
    for i, passiveSkillStr in pairs(passiveSkills) do
        local passiveSkill = parse_strings(passiveSkillStr, "=")
        local passiveSkillId, passiveSkillLevel = checkNumber(passiveSkill[1]), checkNumber(passiveSkill[3])

        if passiveSkillId > 0 and passiveSkillLevel > 0 then
            local buffRow = CfUtils.GetCfLine(AutoIds.IdSetting573, passiveSkillId)
            if checkNumber(buffRow:Get("showDesc")) > 0 then
                local titleName, desc = CardProgressionSkillUtils.ParseSkillBuffDesc(passiveSkillId, 1, passiveSkillLevel)
                table.insert(result, {titleName = titleName, desc = desc, skillTypeName = localize("被动")})
            end
        end
    end

    return result
end

function FairylandDojo:GetMirrorCatIds(questId)
    local secretInfo = self.secretInfo[questId]
    if secretInfo == nil then
        return {}
    end

    local enemyTeam = secretInfo.imageTeam.enemyTeam[1]
    local catIds = {}
    for i, enemyInfo in ipairs(enemyTeam) do
        local cardId = enemyInfo.cardId
        local vo = CardConfMgr:GetCardByRefId(cardId)
        if vo ~= nil then
            local characterId = vo.characterId
            local roleVo = CardConfMgr:GetRolesVo(characterId)
            if roleVo ~= nil then
                table.insert(catIds, roleVo.catId)
            end
        end
    end

    return catIds
end

return FairylandDojo
