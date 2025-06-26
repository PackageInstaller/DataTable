--[[ 
-----------------------------------------------------
@filename       : MainExplorePlayerProxy
@Description    : 主线探索玩家代理
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExplorePlayerProxy", Class.impl())

function active(self, thing, thingVo)
    self.mThing = thing
    self.mThingVo = thingVo
    -- 重力
    self.mGravity = 0
    -- 移动速度
    self.mMoveSpeed = self.mThing:getPlayerConfigVo().normalSpeed
    -- 交互事件配置列表
    self.mInteracThingList = {}
    -- 环境事件配置列表
    self.mEnviEventThingList = {}
end

function deActive(self)
    self:resetThingVo()
    self:resetThing()
    self.mAttackThing = nil
    self.mRemindThing = nil
    self.mRemindParam = nil
    self.mIntroduceThing = nil
    self.mInteracThingList = nil
    self.mEnviEventThingList = nil
end

function resetThingVo(self)
    if(self.mThingVo)then
        LuaPoolMgr:poolRecover(self.mThingVo)
    end
    self.mThingVo = nil
end

function resetThing(self)
    if(self.mThing)then
        LuaPoolMgr:poolRecover(self.mThing)
    end
    self.mThing = nil
end

function getThing(self)
    return self.mThing
end

function getThingVo(self)
    return self.mThingVo
end

function setGravity(self, gravity)
    self.mGravity = gravity
end

function getGravity(self)
    return self.mGravity
end

function setMoveSpeed(self, speed)
    self.mMoveSpeed = speed
end

function getMoveSpeed(self)
    return self.mMoveSpeed
end

-- 攻击对象
function setAttackThing(self, attackThing)
    if(self.mAttackThing ~= attackThing)then
        self.mAttackThing = attackThing
        mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_TARGET_ATTACK_UPDATE)
    end
end

function getAttackThing(self)
    return self.mAttackThing
end

-- 指引对象
function setReminThing(self, remindThing, allCount, finishCount)
    if(self.mRemindThing == nil and remindThing == nil)then
        return
    end
    self.mRemindThing = remindThing
    self.mRemindParam = {allCount = allCount, finishCount = finishCount}
    mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_TARGET_REMIND_UPDATE)
end

function getRemindThing(self)
    return self.mRemindThing, self.mRemindParam
end

-- 初次对话对象
function setIntroduceThing(self, introduceThing)
    if(self.mIntroduceThing ~= introduceThing)then
        self.mIntroduceThing = introduceThing
        mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_FIRST_INTRODUCE_UPDATE)
    end
end

function getIntroduceThing(self)
    return self.mIntroduceThing
end

-- 交互对象列表
function setInteractThingList(self, interactThingList)
    if(interactThingList)then
        local isChange = false
        if(not isChange)then
            for _, eventConfigVo in pairs(self.mInteracThingList) do
                if(table.indexof(interactThingList, eventConfigVo) == false)then
                    isChange = true
                    -- mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_INTERACT_UPDATE, {delEventThing = eventConfigVo})
                end
            end
        end
        if(not isChange)then
            for _, eventConfigVo in pairs(interactThingList) do
                if(table.indexof(self.mInteracThingList, eventConfigVo) == false)then
                    isChange = true
                    -- mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_INTERACT_UPDATE, {addEventThing = eventConfigVo})
                end
            end
        end

        if(isChange)then
            local playerThing = mainExplore.MainExplorePlayerProxy:getThing()
            table.sort(interactThingList, 
            function(thing1, thing2)
                local dis1 = math.v3Distance(playerThing:getThingVo():getPosition(), thing1:getThingVo():getPosition())
                local dis2 = math.v3Distance(playerThing:getThingVo():getPosition(), thing2:getThingVo():getPosition())
                if(dis1 ~= dis2)then
                    return dis1 < dis2
                else
                    return false
                end
            end)
            self.mInteracThingList = interactThingList
            mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_INTERACT_UPDATE, self.mInteracThingList)
        end
    else
        -- for _, eventConfigVo in pairs(self.mInteracThingList) do
        --     mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_INTERACT_UPDATE, {delEventThing = eventConfigVo})
        -- end
        self.mInteracThingList = {}
        mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_INTERACT_UPDATE, self.mInteracThingList)
    end
end

function getInteractThingList(self)
    return self.mInteracThingList or {}
end

-- 环境对象列表
function setEnvionmentThingList(self, environmentThingList)
    if(environmentThingList)then
        for _, eventConfigVo in pairs(self.mEnviEventThingList) do
            if(table.indexof(environmentThingList, eventConfigVo) == false)then
                mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_ENVIROMENT_UPDATE, {delEventThing = eventConfigVo})
            end
        end
        for _, eventConfigVo in pairs(environmentThingList) do
            if(table.indexof(self.mEnviEventThingList, eventConfigVo) == false)then
                mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_ENVIROMENT_UPDATE, {addEventThing = eventConfigVo})
            end
        end
        self.mEnviEventThingList = environmentThingList
    else
        for _, eventConfigVo in pairs(self.mEnviEventThingList) do
            mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_ENVIROMENT_UPDATE, {delEventThing = eventConfigVo})
        end
        self.mEnviEventThingList = {}
    end
end

function getEnvionmentThingList(self)
    return self.mEnviEventThingList or {}
end

-- 检查清理对象
function checkClearThing(self, checkThing)
    if(checkThing ~= self.mThing)then
        if(self:getAttackThing() == checkThing)then
            self:setAttackThing(nil)
        end
        if(self:getRemindThing() == checkThing)then
            self:setReminThing(nil)
        end
        if(self:getIntroduceThing() == checkThing)then
            self:setIntroduceThing(nil)
        end
    
        for i = #self.mInteracThingList, 1, -1 do
            if(self.mInteracThingList[i] == checkThing)then
                -- mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_INTERACT_UPDATE, {delEventThing = checkThing})
                table.remove(self.mInteracThingList, i)
            end
        end
        mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_INTERACT_UPDATE, self.mInteracThingList)
    
        for i = #self.mEnviEventThingList, 1, -1 do
            if(self.mEnviEventThingList[i] == checkThing)then
                mainExplore.MainExploreSceneManager:dispatchEvent(mainExplore.MainExploreSceneManager.PLAYER_ENVIROMENT_UPDATE, {delEventThing = checkThing})
                table.remove(self.mEnviEventThingList, i)
            end
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
