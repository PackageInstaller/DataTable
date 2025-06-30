module('guide.GuideCondition', Class.impl(Manager))

function ctor(self)
    self.m_happenTypeCall = {}
    self.m_happenTypeArgs = {}

    self.onlyOnce = true
end

function resetTempData(self)
    self.m_happenTypeArgs = {}
    self.m_curRound20 = nil
    self.m_curTid20 = nil
    self.m_skillID20 = nil

    self.m_curRound21 = nil
    self.m_curTid21 = nil
    self.m_skillID21 = nil

    self.m_curRound27 = nil
    self.m_curTid27 = nil
    self.m_skillID27 = nil

    self.onlyOnce = true
end

-- 1.触发完某个对话id后直接进入某个副本（跳过队列选择界面）
function condition01(self, storyID, finishCall)

    local isEditor = storyTalk.StoryTalkManager:getIsEditor()
    if isEditor then
        return
    else
    end

    self.m_happenTypeCall[1] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args and storyID == tonumber(args[1]) then
            return true
        end
    end
    local guideRo = self:_condition(1, _conditionJudgeCall)
    if guideRo then
        guide.GuideManager.m_curGuideRo = guideRo
        -- self:guideCallback(1, true, guideRo)
        guide.GuideManager:switchFinishCall(true)
        local args = guideRo:getDup()
        if not table.empty(args) then
            fight.FightManager:reqBattleEnter(args[1], args[2])
        end
    else
        self:guideCallback(1, false)
    end
    return guideRo
end
-- 返回true表示条件一致
function _checkHappenArge(self, happenType, arges)
    local ret = true
    local happenArgs = self.m_happenTypeArgs[happenType]
    if not happenArgs then
        happenArgs = {}
        self.m_happenTypeArgs[happenType] = happenArgs
        ret = false
    else
        for index, value in ipairs(arges) do
            if value ~= happenArgs[index] then
                ret = false
                break
            end
        end
    end
    if ret == false then
        for index, value in ipairs(arges) do
            happenArgs[index] = value
        end
    end
    return ret
end
-- 2.首次进入某个副本后触发（战斗暂停）介绍战斗界面
function condition02(self, finishCall)
    self.m_happenTypeCall[2] = finishCall

    local battleType = fight.FightManager:getLatestBattleType() or 0
    local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0

    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            if ro:getRefID() == 1026 then
                if fight.FightManager:getIsAutoFight() then
                    return false
                end
            end

            -- print("guide condition02======= ",battleType, battleFieldID, args[1], args[2])
            if battleType == args[1] and battleFieldID == args[2] then
                return true
            end
        end
    end

    return self:tryToGuide(2, self:_condition(2, _conditionJudgeCall))
end
-- 3.触发完某个对话id触发
function condition03(self, storyID, finishCall)
    self.m_happenTypeCall[3] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args and storyID == args[1] then
            return true
        end
    end
    return self:tryToGuide(3, self:_condition(3, _conditionJudgeCall))
end

-- 4.成功挑战通过某个副本后触发
function justCondition04(self)
    local battleType = fight.FightManager:getLatestBattleType() or 0
    local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            -- print("justCondition04", battleType, battleFieldID, args[1], args[2])
            if battleType == args[1] and battleFieldID == args[2] then
                return true
            end
        end
    end
    return self:_condition(4, _conditionJudgeCall)
end

function condition04(self, finishCall)
    self.m_happenTypeCall[4] = finishCall
    return self:tryToGuide(4, self:justCondition04())
end

-- 5.对应副本内相应战员核能值达到1000时并且释放普通攻击期间触发
function condition05(self, tid, skillID, finishCall)
    self.m_happenTypeCall[5] = finishCall

    local battleType = fight.FightManager:getLatestBattleType() or 0
    local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            if battleType == args[1] and battleFieldID == args[2] and tid == args[3] and skillID == args[4] then
                return true
            end
        end
    end
    return self:tryToGuide(5, self:_condition(5, _conditionJudgeCall))
end
-- 6.对应副本内相应战员第一次受到攻击时触发（将要受到攻击）
function condition06(self, tid, finishCall)
    self.m_happenTypeCall[6] = finishCall

    local battleType = fight.FightManager:getLatestBattleType() or 0
    local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            -- if battleType==args[1] and battleFieldID==args[2] and tid==args[3] then
            -- 任意战员
            if battleType == args[1] and battleFieldID == args[2] then
                return true
            end
        end
    end
    return self:tryToGuide(6, self:_condition(6, _conditionJudgeCall))
end
-- 7.对应功能id开启后触发（对应功能配置表id）
function condition07(self, functID, finishCall)
    self.m_happenTypeCall[7] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            if functID == tonumber(args[1]) then
                return true
            end
        end
    end
    return self:tryToGuide(7, self:_condition(7, _conditionJudgeCall))
end
-- 8.指挥官达到x级触发
function condition08(self, lv, finishCall)
    self.m_happenTypeCall[8] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            if lv >= tonumber(args[1]) then
                return true
            end
        end
    end
    return self:tryToGuide(8, self:_condition(8, _conditionJudgeCall))
end
-- 9.打开某个界面时触发（对应界面编码表）
function condition09(self, uiID, finishCall)
    self.m_happenTypeCall[9] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            if uiID == tonumber(args[1]) then
                return true
            end
        end
    end
    return self:tryToGuide(9, self:_condition(9, _conditionJudgeCall))
end

-- 10.对应副本内“己方”战员释放技能期间触发
function condition10(self, skillID, finishCall)
    self.m_happenTypeCall[10] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            local tmpVo = fight.FightManager:getHeroSkill02(tonumber(args[4]))
            if tmpVo and not tmpVo:getBeUse() then
                if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then
                    if skillID == tonumber(args[3]) then
                        return true
                    end
                end
            end
        end
    end
    return self:tryToGuide(10, self:_condition(10, _conditionJudgeCall))
end

-- 12.对应副本内“敌方”释放技能期间触发
function condition12(self, skillID, finishCall)
    self.m_happenTypeCall[12] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then
                if skillID == tonumber(args[3]) then
                    return true
                end
            end
        end
    end
    return self:tryToGuide(12, self:_condition(12, _conditionJudgeCall))
end

-- 13.触发完某个对话组id中的对话id后触发
function condition13(self, storyID, talkID, finishCall)
    self.m_happenTypeCall[13] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args and storyID == tonumber(args[1]) and talkID == tonumber(args[2]) then
            return true
        end
    end
    return self:tryToGuide(13, self:_condition(13, _conditionJudgeCall))
end

-- 14.进入副本选择阵容前触发
function condition14(self, battleType, battleFieldID, finishCall)
    self.m_happenTypeCall[14] = finishCall
    local lastBattleType = fight.FightManager:getLatestBattleType()
    local lastBattleFieldID = fight.FightManager:getLatestBattleFieldID()
    fight.FightManager:setLatestBattleData(battleType, battleFieldID)

    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            -- print("justCondition04", battleType, battleFieldID, args[1], args[2])
            if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then

                --特殊判断1032这个步骤，若元雅星级大于0星则不触发
                if ro:getRefID() == 1032 then
                    local heroTid = sysParam.SysParamManager:getValue(87)
                    local heroVo = hero.HeroManager:getHeroVoByTid(heroTid)
                    if heroVo then
                        if heroVo.evolutionLvl < 1 then
                            local teamId = formation.FormationManager:getFightTeamId()
                            local heroList = formation.FormationManager:getSelectFormationHeroList(teamId)
                            for i = 1, #heroList do
                                if heroList[i]:getHeroTid() == heroTid then
                                    return true
                                end
                            end
                        end
                    end

                    GameDispatcher:dispatchEvent(EventName.REQ_GUIDE_REPORT, {guidId = ro:getRefID(), stepId = #ro:getGuideGroup()})
                    guide.GuideManager:reqCS_GUIDE_END(ro:getRefID())
                    return false
                end

                return true
            end
        end
    end
    local ro = self:tryToGuide(14, self:_condition(14, _conditionJudgeCall))
    fight.FightManager:setLatestBattleData(lastBattleType, lastBattleFieldID)
    return ro
end

-- 15.打开某个界面后触发（程序给界面id）
function condition15(self, uiFlag, finishCall)
    self.m_happenTypeCall[15] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        local functID = args[2]
        if functID ~= nil and functID ~= 0 then
            if not funcopen.FuncOpenManager:isOpen(functID) then
                return false
            end
        end

        if args and uiFlag == args[1] then
            return true
        end
    end
    return self:tryToGuide(15, self:_condition(15, _conditionJudgeCall))
end

-- 16.真正挑战完毕某个副本后出发
function condition16(self, finishCall)
    self.m_happenTypeCall[16] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            -- print("justCondition04", battleType, battleFieldID, args[1], args[2])
            if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then
                return true
            end
        end
    end
    return self:tryToGuide(16, self:_condition(16, _conditionJudgeCall))
end

-- 17.触发隐藏格挡按钮（只有触发释放格挡按钮时才出现)
function condition17(self, finishCall)
    self.m_happenTypeCall[17] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            -- print("justCondition04", battleType, battleFieldID, args[1], args[2])
            if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then
                return true
            end
        end
    end
    return self:tryToGuide(17, self:_condition(17, _conditionJudgeCall))
end

-- 18.对应副本内相应怪物战员核能值达到1000时并且释放普通攻击期间触发
function condition18(self, tid, skillID, finishCall)
    self.m_happenTypeCall[5] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then
                if tid == tonumber(args[3]) and skillID == tonumber(args[4]) then
                    return true
                end
            end
        end
    end
    return self:tryToGuide(18, self:_condition(18, _conditionJudgeCall))
end

-- 19.进入副本时触发（触发后右下角技能不可点击，只能通过引导去点击）
function condition19(self, finishCall)
    self.m_happenTypeCall[19] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            -- print("justCondition04", battleType, battleFieldID, args[1], args[2])
            if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then
                fight.FightManager.m_stopClipSkill = true
                return true
            end
        end
    end
    self:_condition(19, _conditionJudgeCall)

    -- return self:tryToGuide(19, self:_condition(19, _conditionJudgeCall))
end
-- 20.当对应技能造成伤害0.5秒后触发
function condition20(self, tid, skillID, finishCall)
    if self.m_curRound20 == fight.FightManager:getCurRound() and self.m_curTid20 == tid and self.m_skillID20 == skillID then
        return
    end
    self.m_curRound20 = fight.FightManager:getCurRound()
    self.m_curTid20 = tid
    self.m_skillID20 = skillID

    self.m_happenTypeCall[20] = finishCall

    local function _checkGuideCondition(xx, loadingRo)
        self:tryToGuide(20, loadingRo)
    end
    local function _conditionJudgeCall(ro)
        if ro.__loading == true then
            return
        end
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then
                if tid == tonumber(args[3]) and skillID == tonumber(args[4]) then
                    ro.__loading = true
                    local delaytime = args[5] or 5
                    LoopManager:setTimeout(delaytime / 10.0, self, _checkGuideCondition, ro)
                    return true
                end
            end
        end
    end
    self:_condition(20, _conditionJudgeCall)
    -- return self:tryToGuide(20, self:_condition(20, _conditionJudgeCall))
end
-- 21.当对应技能造成伤害0.5秒后触发
function condition21(self, tid, skillID, finishCall)
    if self.m_curRound21 == fight.FightManager:getCurRound() and self.m_curTid21 == tid and self.m_skillID21 == skillID then
        return
    end
    self.m_curRound21 = fight.FightManager:getCurRound()
    self.m_curTid21 = tid
    self.m_skillID21 = skillID

    self.m_happenTypeCall[21] = finishCall

    local function _checkGuideCondition(xx, loadingRo)
        self:tryToGuide(21, loadingRo)
    end
    local function _conditionJudgeCall(ro)
        if ro.__loading == true then
            return
        end
        local args = ro:getHappenArg()
        if args then
            if fight.FightManager:getCurRound() == tonumber(args[1]) then
                local battleType = fight.FightManager:getLatestBattleType() or 0
                local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
                if battleType == tonumber(args[2]) and battleFieldID == tonumber(args[3]) then
                    if tid == tonumber(args[4]) and skillID == tonumber(args[5]) then
                        ro.__loading = true
                        local delaytime = args[6] or 5
                        LoopManager:setTimeout(delaytime / 10.0, self, _checkGuideCondition, ro)
                        return true
                    end
                end
            end
        end
    end
    self:_condition(21, _conditionJudgeCall)
    -- return self:tryToGuide(20, self:_condition(20, _conditionJudgeCall))
end

-- 22.关闭某个界面后触发（程序给界面id）
-- function condition22(self, uiFlag, finishCall)
--     self.m_happenTypeCall[22] = finishCall
--     local function _conditionJudgeCall(ro)
--         local args = ro:getHappenArg()
--         if args and uiFlag==args[1] then
--             return true
--         end
--     end
--     return self:tryToGuide(22, self:_condition(22, _conditionJudgeCall))
-- end

-- 23.隐藏奥义的两个技能（不能点击释放），包括核能值也不显示。
function condition23(self, finishCall)
    self.m_happenTypeCall[23] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            -- print("justCondition04", battleType, battleFieldID, args[1], args[2])
            if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then
                return true
            end
        end
    end
    return self:tryToGuide(23, self:_condition(23, _conditionJudgeCall))
end

-- 24.对应副本内第x回合，受到对应技能id攻击时触发（将要受到攻击）
function condition24(self, skillID, finishCall)

    self.m_happenTypeCall[24] = finishCall

    local battleType = fight.FightManager:getLatestBattleType() or 0
    local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            -- if battleType==args[1] and battleFieldID==args[2] and tid==args[3] then
            -- 任意战员
            if battleType == args[1] and battleFieldID == args[2] and fight.FightManager:getCurRound() == args[3] and skillID == args[4] then
                return true
            end
        end
    end
    return self:tryToGuide(24, self:_condition(24, _conditionJudgeCall))
end

-- 25.进入副本时触发（触发后右下角技能不可点击，只能通过引导去点击）
function condition25(self, finishCall)
    self.m_happenTypeCall[25] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            -- print("justCondition04", battleType, battleFieldID, args[1], args[2])
            if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then
                fight.FightManager.m_stopClipSkillMax = true
                return true
            end
        end
    end
    self:_condition(25, _conditionJudgeCall)

    -- return self:tryToGuide(19, self:_condition(19, _conditionJudgeCall))
end

-- 26.返回招募界面触发 最后引导
function condition26(self, uiFlag, finishCall)
    self.m_happenTypeCall[26] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args and uiFlag == args[1] then
            if ro:getRefID() == 1033 then
                local formationData = formation.FormationManager:getData()
                if formationData then
                    local battleType = formationData.battleType or 0
                    local battleFieldID = formationData.dupId or 0
                    if battleType == tonumber(args[2]) and battleFieldID == tonumber(args[3]) then
                        local heroTid = sysParam.SysParamManager:getValue(95)

                        --元雅上阵了，不触发
                        local teamId = formation.FormationManager:getFightTeamId()
                        local heroList = formation.FormationManager:getSelectFormationHeroList(teamId)
                        for i = 1, #heroList do
                            if heroList[i]:getHeroTid() == heroTid then
                                GameDispatcher:dispatchEvent(EventName.REQ_GUIDE_REPORT, {guidId = ro:getRefID(), stepId = #ro:getGuideGroup()})
                                guide.GuideManager:reqCS_GUIDE_END(ro:getRefID())
                                return false
                            end
                        end

                        --元雅没有不触发
                        local heroVo = hero.HeroManager:getHeroVoByTid(heroTid)
                        if not heroVo then
                            GameDispatcher:dispatchEvent(EventName.REQ_GUIDE_REPORT, {guidId = ro:getRefID(), stepId = #ro:getGuideGroup()})
                            guide.GuideManager:reqCS_GUIDE_END(ro:getRefID())
                            return false
                        end

                        return true
                    end
                end
            else
                return true
            end
        end

        return false
    end
    return self:tryToGuide(26, self:_condition(26, _conditionJudgeCall))
end

-- 21.当对应技能造成伤害0.5秒后触发
function condition27(self, tid, skillID, skillTime, finishCall)
    if self.m_curRound27 == fight.FightManager:getCurRound() and self.m_curTid27 == tid and self.m_skillID27 == skillID then
        return
    end
    self.m_curRound27 = fight.FightManager:getCurRound()
    self.m_curTid27 = tid
    self.m_skillID27 = skillID

    self.m_happenTypeCall[27] = finishCall

    local function _checkGuideCondition(xx, loadingRo)
        self:tryToGuide(27, loadingRo)
    end
    local function _conditionJudgeCall(ro)
        if ro.__loading == true then
            return
        end
        local args = ro:getHappenArg()
        if args then
            if fight.FightManager:getCurRound() == tonumber(args[1]) then
                local battleType = fight.FightManager:getLatestBattleType() or 0
                local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
                if battleType == tonumber(args[2]) and battleFieldID == tonumber(args[3]) then
                    if tid == tonumber(args[4]) and skillID == tonumber(args[5]) then
                        ro.__loading = true
                        local delaytime = skillTime - 0.5
                        LoopManager:setTimeout(delaytime, self, _checkGuideCondition, ro)
                        return true
                    end
                end
            end
        end
    end
    local ro = self:_condition(27, _conditionJudgeCall)
    return ro ~= nil
    -- return self:tryToGuide(20, self:_condition(20, _conditionJudgeCall))
end

-- 28.进入副本时触发（触发后右下角技能不可点击，只能通过引导去点击）
function condition28(self, finishCall)
    self.m_happenTypeCall[28] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local battleType = fight.FightManager:getLatestBattleType() or 0
            local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
            -- print("justCondition04", battleType, battleFieldID, args[1], args[2])
            if battleType == tonumber(args[1]) and battleFieldID == tonumber(args[2]) then
                fight.FightManager.m_canGuideAuto = true
                return true
            end
        end
    end
    self:_condition(28, _conditionJudgeCall)

    -- return self:tryToGuide(19, self:_condition(19, _conditionJudgeCall))
end

-- 29.进入锚点时触发
function condition29(self, finishCall)
    self.m_happenTypeCall[29] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local mainExploreMapConfigVo = mainExplore.MainExploreManager:getTriggerDupData()
            if mainExploreMapConfigVo.mapId == tonumber(args[1]) then
                return true
            end
        end
    end
    self:tryToGuide(29, self:_condition(29, _conditionJudgeCall))

    -- self.m_happenTypeCall[24] = finishCall

    -- local battleType = fight.FightManager:getLatestBattleType() or 0
    -- local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
    -- local function _conditionJudgeCall(ro)
    --     local args = ro:getHappenArg()
    --     if args then
    --         -- if battleType==args[1] and battleFieldID==args[2] and tid==args[3] then
    --         -- 任意战员
    --         if battleType == args[1] and battleFieldID == args[2] and fight.FightManager:getCurRound() == args[3] and skillID == args[4] then
    --             return true
    --         end
    --     end
    -- end
    -- return self:tryToGuide(24, self:_condition(24, _conditionJudgeCall))
end

-- 30.进入小游戏触发
function condition30(self, finishCall)
    self.m_happenTypeCall[30] = finishCall
    local function _conditionJudgeCall(ro)
        local args = ro:getHappenArg()
        if args then
            local dup_id = fieldExploration.FieldExplorationManager:getDupId()
            if dup_id == tonumber(args[1]) then
                return true
            end
        end
    end
    self:tryToGuide(30, self:_condition(30, _conditionJudgeCall))

    -- self.m_happenTypeCall[24] = finishCall

    -- local battleType = fight.FightManager:getLatestBattleType() or 0
    -- local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
    -- local function _conditionJudgeCall(ro)
    --     local args = ro:getHappenArg()
    --     if args then
    --         -- if battleType==args[1] and battleFieldID==args[2] and tid==args[3] then
    --         -- 任意战员
    --         if battleType == args[1] and battleFieldID == args[2] and fight.FightManager:getCurRound() == args[3] and skillID == args[4] then
    --             return true
    --         end
    --     end
    -- end
    -- return self:tryToGuide(24, self:_condition(24, _conditionJudgeCall))
end

-- 触发条件判断 (通用)
-- conditionType 条件成立唯一的数据
-- conditionJudgeCall 为额外参数作判断的方法调用
function _condition(self, conditionType, conditionJudgeCall)
    local roLst = guide.GuideManager:getGuideRosByHapplyType(conditionType)
    if roLst then
        for _, ro in ipairs(roLst) do
            if guide.GuideManager:canPlayGuide(ro:getRefID()) then
                if conditionJudgeCall then
                    if conditionJudgeCall(ro) then
                        return ro
                    end
                else
                    return ro
                end
            end
        end
    end
    -- local ros = guide.GuideManager:guideRos()
    -- for refID,v in pairs(ros) do

    --     if guide.GuideManager:canPlayGuide(refID) and v:getHappenType()==conditionType then
    --         if conditionJudgeCall then
    --             if conditionJudgeCall(v) then
    --                 -- print("guide _condition ", conditionType, refID)
    --                 return v
    --             end
    --         else
    --             -- print("guide _condition ", conditionType, refID)
    --             -- print("_condition 111111 ", conditionType, refID)
    --             return v
    --         end
    --     end
    -- end
end

function tryToGuide(self, happenType, guideRo)
    if guideRo then
        -- print("tryToGuide ", guideRo:getRefID())
        guide.GuideManager:startGuide(guideRo:getRefID())
        return true
    end

    -- guide.GuideManager:switchFinishCall(false)
    self:guideCallback(happenType, false)
    return false
end

function setGuideCallback(self, happenType, finishCall)
    self.m_happenTypeCall[happenType] = finishCall
end

function guideCallback(self, happenType, beSuccess, guideRo)
    local gcall = self.m_happenTypeCall[happenType]
    if gcall then
        self.m_happenTypeCall[happenType] = nil
        gcall(beSuccess, guideRo)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
