module("fight.SceneItemManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self.m_itemDic = {}
    fight.SceneManager:addEventListener(fight.SceneManager.EVENT_REMOVE_THING, self.removeLivething, self)

    -- self.m_xxxLst = {}
    -- self.m_xxIndex = 1
    -- self.m_xxAniLst = nil
end
-- local testAnis = { fight.FightDef.ACT_ATTACK_1, fight.FightDef.ACT_SKILL_1, fight.FightDef.ACT_SKILL_2, fight.FightDef.ACT_SKILL_MIX, fight.FightDef.ACT_SKILL_MAX }
-- function playOneXXXX(self)
--     if table.empty(self.m_xxxLst) then return end
--     if self.m_isxxPlaying == true then return end
--     local livething = self.m_xxxLst[self.m_xxIndex]
--     if livething then
--         self.m_isxxPlaying = true
--         if table.empty(self.m_xxAniLst) then
--             self.m_xxAniLst = table.copy(testAnis)
--         end
--         local hash = self.m_xxAniLst[1]
--         table.remove(self.m_xxAniLst, 1)
--         local function _resultCall()
--             self.m_isxxPlaying = false
--             self:playOneXXXX()
--         end
--         livething:playAttActEft(hash, livething, _resultCall)
--     end
--     self.m_xxIndex = self.m_xxIndex + 1
--     if self.m_xxIndex >= #self.m_xxxLst then
--         self.m_xxIndex = 1
--         self:playOneXXXX()
--     end
-- end


function addLivething(self, cusVo, aysnCall)
    local livething = self:__getLivething()
    if cusVo.id == 0 then
        self.m_itemDic[cusVo.tid] = livething
    else
        self.m_itemDic[cusVo.id] = livething
    end
    livething:setData(cusVo, aysnCall)
    livething:setToParent(fight.SceneGrid:getRootTrans())
    livething:setDynamicBoneEnable(false)
    return livething
end

function removeLivething(self, cusId)
    if self.m_itemDic[cusId] == nil then
        return
    end

    local livething = self.m_itemDic[cusId];
    -- for index, value in ipairs(self.m_xxxLst) do
    --     if value == livething then
    --         table.remove(self.m_xxxLst, index)
    --     end
    -- end
    self.m_itemDic[cusId] = nil;
    livething:destroy()
    -- livething:clearModel();
    -- self:__recoverLivething(livething)
end

function __getLivething(self)
    -- return LuaPoolMgr:poolGet(fight.Livething)
    return fight.Livething.new()
end

function __recoverLivething(self, cusLivething)
    LuaPoolMgr:poolRecover(cusLivething);
end

function getLivething(self, cusId)
    return self.m_itemDic[cusId];
end

function getAllLiveThing(self)
    return self.m_itemDic
end

function getSideLivething(self, side)
    local ret = {}
    for liveID, thing in pairs(self.m_itemDic) do
        local liveVo = fight.SceneManager:getThing(liveID)
        if liveVo:isAttacker() == side then
            table.insert(ret, thing)
        end
    end
    if table.empty(ret) then
        return nil
    end
    return ret
end

function upateThingRate(self)
    -- for _,thing in pairs(self.m_itemDic) do
    -- 	thing:updateAniSpeed()
    -- end
end

function reset(self)
    for _, v in pairs(self.m_itemDic) do
        v:destroy()
    end
    self.m_itemDic = {}
end

function updateLiveHead(self, liveID)
    local live = self:getLivething(liveID)
    if live then
        live:updateHeadBar()
    end
end

function updateLiveHeadBuff(self, liveID)
    local live = self:getLivething(liveID)
    if live then
        live:updateHeadBarBuff()
    end
end

function closeAllHeadBar(self)
    for _, live in pairs(self.m_itemDic) do
        live:closeHeadBar()
    end
end

function eachPlayAction(self, side, actionState, oneFinishCall)
    local beSetCall = false
    for liveID, thing in pairs(self.m_itemDic) do
        local liveVo = fight.SceneManager:getThing(liveID)
        if side == nil or liveVo:isAttacker() == side then
            if beSetCall == false then
                beSetCall = true
                thing:playAction(actionState, nil, oneFinishCall)
            else
                thing:playAction(actionState)
            end
        end
    end
end

function eachPlayWin(self, side, finishCall)
    self:eachPlayAction(side, fight.FightDef.ACT_WIN, finishCall)
end
function eachPlayGoin(self, side, finishCall)
    self:eachPlayAction(side, fight.FightDef.ACT_GOIN, finishCall)
end

local function _liveSort(a, b)
    local al = a:getLiveVo()
    local bl = b:getLiveVo()
    if al and bl and al:getGridID() < bl:getGridID() then
        return true
    end
    return false
end

-- 播放角色进场
function playGoin(self, finishCall)
    self.m_playGoinLList = {}
    self.m_playGoinRList = {}
    self.m_goinFinishCall = finishCall
    for liveID, thing in pairs(self.m_itemDic) do
        local liveVo = fight.SceneManager:getThing(liveID)
        if liveVo and not liveVo:isDead() then
            if liveVo:isAttacker() == 1 then
                table.insert(self.m_playGoinLList, thing)
            else
                table.insert(self.m_playGoinRList, thing)
            end
        end
    end
    table.sort(self.m_playGoinLList, _liveSort)
    table.sort(self.m_playGoinRList, _liveSort)
    RateLooper:setTimeout(0.2, self, self._playGoinOne)
end

function playSideGoin(self, side, finishCall)
    self.m_playGoinList = {}
    for liveID, thing in pairs(self.m_itemDic) do
        local liveVo = fight.SceneManager:getThing(liveID)
        if liveVo and liveVo:isAttacker() == side and not liveVo:isDead() then
            table.insert(self.m_playGoinList, thing)
        end
    end
    table.sort(self.m_playGoinList, _liveSort)

    local function _playGoinOneCall()
        local llive = self.m_playGoinList[1]
        if llive then
            table.remove(self.m_playGoinList, 1)
            llive:setVisible(true)
            llive:setDisplayLayer("Role")
            if table.empty(self.m_playGoinList) then
                llive:playAction(fight.FightDef.ACT_GOIN, nil, finishCall)
                return
            end
            llive:playAction(fight.FightDef.ACT_GOIN)
            RateLooper:setTimeout(0.2, self, _playGoinOneCall)
        end
    end
    RateLooper:setTimeout(0.2, self, _playGoinOneCall)
end

function playGoinList(self, liveIDs, finishCall)
    self.m_playGoinList = self.m_playGoinList or {}
    for liveID, thing in pairs(self.m_itemDic) do
        for _, v in ipairs(liveIDs) do
            local liveVo = fight.SceneManager:getThing(liveID)
            if v == liveID and not liveVo:isDead() then
                table.insert(self.m_playGoinList, thing)
            end
        end
    end
    if table.empty(self.m_playGoinList) then
        print("no entity in to scene ??")
        finishCall()
    end
    table.sort(self.m_playGoinList, _liveSort)
    local function _playGoinOneCall()
        local llive = self.m_playGoinList[1]
        if llive then
            table.remove(self.m_playGoinList, 1)
            llive:setVisible(true)
            llive:setDisplayLayer("Role")
            -- if table.empty(self.m_playGoinList) then
            --     llive:playAction(fight.FightDef.ACT_GOIN, nil, finishCall)
            --     return
            -- end
            -- if #self.m_playGoinList == 1 then
            --     llive:playAction(fight.FightDef.ACT_GOIN, nil, finishCall)
            -- else
            --     llive:playAction(fight.FightDef.ACT_GOIN)
            --     RateLooper:setTimeout(0.2, self, _playGoinOneCall)
            -- end
            llive:playAction(fight.FightDef.ACT_GOIN, nil, finishCall)
            RateLooper:setTimeout(0.2, self, _playGoinOneCall)
        end
    end
    RateLooper:setTimeout(0.2, self, _playGoinOneCall)
end

function _playGoinOne(self)
    local finishCall = nil
    if #self.m_playGoinLList <= 1 and #self.m_playGoinRList <= 1 then
        finishCall = self.m_goinFinishCall
    end
    local llive = self.m_playGoinLList[1]
    if llive then
        table.remove(self.m_playGoinLList, 1)
        llive:setVisible(true)
        llive:setDisplayLayer("Role")
        llive:playAction(fight.FightDef.ACT_GOIN, nil, finishCall)
        finishCall = nil
    end
    local rlive = self.m_playGoinRList[1]
    if rlive then
        table.remove(self.m_playGoinRList, 1)
        rlive:setVisible(true)
        rlive:setDisplayLayer("Role")
        rlive:playAction(fight.FightDef.ACT_GOIN, nil, finishCall)
    end

    if not table.empty(self.m_playGoinLList) or not table.empty(self.m_playGoinRList) then
        RateLooper:setTimeout(0.2, self, self._playGoinOne)
    end
end

-- boss开场表演
function playBossGoinShow(self, finishCall)
    self.m_playGoinList = {}
    self.m_goinFinishCall = finishCall
    for liveID, thing in pairs(self.m_itemDic) do
        local liveVo = fight.SceneManager:getThing(liveID)
        if liveVo and liveVo:getRaceVo().monType == monster.MonsterType.SUPER_BOSS then
            fight.FightCamera:setCameraLock(liveVo:getModelID())
            fight.FightCamera:focusOnLive(liveID)
            thing:setVisible(true)
            thing:setDisplayLayer("Role")
            local _playFinish = function()
                -- GameDispatcher:dispatchEvent(EventName.SHOW_FIGHT_BLACK_MASK)
                -- LoopManager:setTimeout(0.5, self, function()
                fight.LivePerformManager:stopStandby(liveID)
                if self.mFightBossShowSkip then
                    self.mFightBossShowSkip:close()
                end

                fight.FightCamera:checkReturnCamera()
                for i, llive in ipairs(self.m_playGoinList) do
                    llive:setVisible(true)
                    llive:setDisplayLayer("Role")
                end
                self.m_playGoinList = {}
                -- end)
                LoopManager:setTimeout(0.5, self, function()
                    -- GameDispatcher:dispatchEvent(EventName.HIDE_FIGHT_BLACK_MASK)
                    -- GameDispatcher:dispatchEvent(EventName.CLOSE_DUP_APOSTLES_BOSS_INFO_VIEW)
                    UIEffectMgr:removeEffect("BOSSInformationDisplay_" .. liveVo:getModelID(), GameView.pop)

                end)

                if finishCall then
                    finishCall()
                    finishCall = nil
                end
            end
            thing:playAction(fight.FightDef.ACT_STANDBY, nil, _playFinish, true)
            fight.LivePerformManager:playStandby(liveID)

            UIEffectMgr:addEffect("BOSSInformationDisplay_" .. liveVo:getModelID(), GameView.pop)

            local skipCall = function()
                thing:playAction(fight.FightDef.ACT_STAND)
                -- _playFinish()
            end

            if self.mFightBossShowSkip == nil then
                self.mFightBossShowSkip = fightUI.FightBossShowSkip.new()
                self.mFightBossShowSkip:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBossShowSkipViewHandler, self)
            end
            self.mFightBossShowSkip:open()
            self.mFightBossShowSkip:setSkipFunCall(skipCall)
        else
            table.insert(self.m_playGoinList, thing)
        end
    end

end

function onDestroyBossShowSkipViewHandler(self)
    self.mFightBossShowSkip:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBossShowSkipViewHandler, self)
    self.mFightBossShowSkip = nil
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]