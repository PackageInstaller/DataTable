module("formation.FormationVisionManager", Class.impl("game.formation.normal.manager.FormationManager"))

-- vision 为普通（非固定）编队：不依赖 storyRo/getEffectParam，也无保护平民（固定阵容）逻辑，
-- 直接继承普通编队管理器即可。

-- 异象残境为多队伍编队（最多 3 队），参照巅峰竞技场进攻：同一战员不能在多支队伍中重复上阵。
-- 覆写上阵方法，当战员成功上阵/替换到某队时，自动从其他队伍移除同名战员。
function setSelectFormationHeroList(self, teamId, formationId, selectHeroId, selectHeroTid, selectHeroSourceType,
        targetPos, isCheckCan)
    -- 判断该战员是否已在本队，用于区分"上阵/替换"与"下阵"两种操作（下阵不需要跨队清理）
    local isAlreadyInTeam = false
    local curList = self:getSelectFormationHeroList(teamId)
    for _, v in ipairs(curList) do
        if v.heroId == selectHeroId then
            isAlreadyInTeam = true
            break
        end
    end

    local res = super.setSelectFormationHeroList(self, teamId, formationId, selectHeroId, selectHeroTid,
            selectHeroSourceType, targetPos, isCheckCan)

    -- 仅当成功把战员上阵/替换到本队（非下阵）时，从其他队伍移除同名战员，保证多队不重复
    if res == true and not isAlreadyInTeam then
        local allTeamIdList = self:getAllTeamIdList()
        for _, otherTeamId in ipairs(allTeamIdList) do
            if otherTeamId ~= teamId then
                local otherList = self:getSelectFormationHeroList(otherTeamId)
                for i = #otherList, 1, -1 do
                    if otherList[i].heroId == selectHeroId then
                        LuaPoolMgr:poolRecover(otherList[i])
                        table.remove(otherList, i)
                    end
                end
                self:validateCaptain(otherTeamId)
            end
        end
    end

    return res
end

-- 锚驴在哪个队伍里使用(列表)
function getPetUseTeamIds(self, petId)
    local teamList = {}
    if next(self:instance().mTempPetDic) then
        for k, v in pairs(self:instance().mTempPetDic) do
            if v == petId then
                table.insert(teamList, k)
            end
        end
    end
    return teamList
end

return _M
