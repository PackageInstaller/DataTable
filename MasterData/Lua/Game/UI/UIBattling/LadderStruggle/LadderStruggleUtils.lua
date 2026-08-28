
local LadderStruggleUtils = {}


--- 获取我自己的编队信息
function LadderStruggleUtils.GetMyselfPlayerInfo(questId)
    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    ---@type PlayerDojo
    local playerDojo = playerComponent:GetPlayerDojo()

    local data = {}
    data.name = playerDojo.playerName
    data.avatar = playerDojo.playerAvatar
    data.avatarFrame = playerDojo.playerAvatarFrame
    data.level = playerDojo.level
    data.combatValue = LadderStruggleUtils.GetMyStruggleCombatValue(questId)

    local teamComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TeamComponent)
    data.team = DeepCopy(teamComponent:GetTeamInfoByQuestId(questId))
    -- print("[大乱斗] 我的队伍", table.dump(data.team, nil, 5))

    local catEggComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    -- 计算每队分别的战力
    for i, teamInfo in ipairs(data.team) do
        local cardComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.CardComponent)
        for i, cardInfo in ipairs(teamInfo.cardsInfo) do
            local cardDojo = cardComponent:GetCardById(cardInfo.refId)
            if not isNull(cardDojo) then
                cardInfo.advanceLevel = cardDojo.advanceLevel
                cardInfo.awakeningLevel = cardDojo.awakeningLevel
                cardInfo.weaponUnlocked = cardDojo.weaponUnlocked
                cardInfo.star = cardDojo.star
                cardInfo.cardLevel = cardDojo.cardLevel
                cardInfo.cardSkin = cardDojo.cardSkin
            end
        end
        teamInfo.combatValue = teamComponent:GetTeamFightingPower(teamInfo.cardsInfo, teamInfo.catsInfo)
        -- 处理合卡技
        local catId = teamInfo.mergeSkill
        local catInfo = catEggComponent:GetCat(catId)
        if catInfo then
            teamInfo.mergeSkill = catInfo
        end
    end

    return data
end

--- 获取我的编队战力
function LadderStruggleUtils.GetMyStruggleCombatValue(questId)
    local cardComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.CardComponent)
    local teamComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.TeamComponent)
    local teams = teamComponent:GetTeamInfoByQuestId(questId)

    local totalCombatValue = 0
    for i, teamInfo in ipairs(teams) do
        totalCombatValue = totalCombatValue + teamComponent:GetTeamFightingPower(teamInfo.cardsInfo, teamInfo.catsInfo)
    end

    return totalCombatValue
end

return LadderStruggleUtils