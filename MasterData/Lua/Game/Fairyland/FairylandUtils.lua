---
--- 乱流幻境工具类
--- Author: dawanfan
--- Date: 2024-1-11 14:19:47
---

local UIModule = CS.Engine.UI.UIModule
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")

---@class FairylandUtils
local FairylandUtils = {}

FairylandUtils.CurrentNearIndex = 0
FairylandUtils.CurrentEnterQuestId = 0
FairylandUtils.LastCombatIndex = 0
FairylandUtils.LastLevelId = 0
FairylandUtils.PlayLevelSettlement = false
FairylandUtils.LastEnergy = 0
FairylandUtils.PlayMirrorOpen = false
FairylandUtils.ShowFinish = true


function FairylandUtils.IsLimitCard(questId, cardId)
    local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
    local secretInfo = FairylandComponent.dojo.secretInfo[questId]
    for _, id in pairs(secretInfo.disableCardIds) do
        if id == cardId then
            return true
        end
    end
    return false
end

function FairylandUtils.IsLimitCat(questId, catId)
    local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
    local secretInfo = FairylandComponent.dojo.secretInfo[questId]
    for _, id in pairs(secretInfo.disableCatIds) do
        if id == catId then
            return true
        end
    end
    return false
end

function FairylandUtils.EnterFairylandScene(params)
    GameUtils.OpenLoadingPanel(
            UIArgs(Constants.UITypeIds.FairylandSceneEnter, params),
            {}, Constants.LoadingType.Others
    )
end


function FairylandUtils.GetQuestProgressRewardVos(questId)
   local data = {}
   local vos = CfUtils.GetCf(AutoIds.IdSetting6161, "FairylandQuestRewardsVo", true)

   for _, vo in pairs(vos) do
        if vo.copyId == questId then
            table.insert(data, vo)
        end
   end

   return data
end

function FairylandUtils.GetMirrorLevelVo(questId)
    local fairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
    local secretInfo = fairylandComponent.dojo.secretInfo[questId]
    local vo = {}
    
    if secretInfo then
        vo.proposalLevel = secretInfo.combatVal
        vo.rounds = 99
        vo.SceneId = 10801
        vo.roleNun = 4
        vo.battleRules = 1
    end

    return vo
end

function FairylandUtils.GetBallPrefabPath(levelId)
    if levelId == Constants.SpecialQuestId.Mirror then
        return nil
    end

    local levelInfo = FairylandUtils.GetLevelVo(levelId)

    local color = FairylandUtils.GetBallColor(levelId)
    if not color then
        printError(string.format("[FairylandUtils][GetBallPrefabPath] color not define, levelId: %s", levelId))
        return nil
    end

    return string.format("Effect/prefab/Mirro_%s_0%s.prefab", color, levelInfo.difficulty)
end

function FairylandUtils.GetBallColor(levelId)
    if levelId == Constants.SpecialQuestId.Mirror then
        return nil
    end

    local levelInfo = FairylandUtils.GetLevelVo(levelId)
    if levelInfo == nil then
        printError(string.format("[FairylandUtils][GetBallPrefabPath] levelInfo is null, levelId: %s", levelId))
        return nil
    end

    local lineupVo = QuestConfMgr:GetInstance():GetAllQuestLineupVo(tostring(levelInfo.id))
    if lineupVo == nil then
        printError(string.format("[FairylandUtils][GetBallPrefabPath] lineupVo is null, levelId: %s", levelInfo.id))
        return nil
    end

    local attribute = lineupVo[1].attribute

    local color = ConstantsFairyland.Colors[tostring(attribute[1])]
    return color
end

---@return FairylandLevelVo | nil
function FairylandUtils.GetLevelVo(levelId)
    if levelId == Constants.SpecialQuestId.Mirror then
        return nil
    end

    local fairylandLevelVo = CfUtils.GetCfVo(AutoIds.IdSetting6162, "FairylandLevelVo", levelId)
    return fairylandLevelVo
end

function FairylandUtils.ResetLevelCache()
    FairylandUtils.LastCombatIndex = 0
    FairylandUtils.LastLevelId = 0
    FairylandUtils.PlayLevelSettlement = false
    FairylandUtils.LastEnergy = 0
    FairylandUtils.PlayMirrorOpen = false
end

return FairylandUtils
