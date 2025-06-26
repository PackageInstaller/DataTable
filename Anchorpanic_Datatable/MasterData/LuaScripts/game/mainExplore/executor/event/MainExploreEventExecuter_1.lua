--[[ 
-----------------------------------------------------
@filename       : MainExploreEventExecuter_1
@Description    : 主线探索事件执行器，判断玩家怪物的攻击
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreEventExecuter_1", Class.impl('game.mainExplore.executor.event.MainExploreBaseEventExecuter'))

function onAwake(self)
    super.onAwake(self)
end

function onRecover(self)
    super.onRecover(self)
end

function initData(self)
    super.initData(self)
end

function addUpdateFrameSn(self)
    super.addUpdateFrameSn(self)
end

function removeUpdateFrameSn(self)
    super.removeUpdateFrameSn(self)
end

function onUpdateFrameHandler(self)
    super.onUpdateFrameHandler(self)
end

-- 准备请求检查触发事件
function checkTriggerEvent(self, mapId, eventConfigVo, paramsDic)
    local playerThing = mainExplore.MainExplorePlayerProxy:getThing()
    local attacker = paramsDic.attacker
    local orderIndex = nil
    if(attacker == playerThing)then -- 玩家主动触发攻击
        local attackThing = mainExplore.MainExplorePlayerProxy:getAttackThing()
        if(attackThing)then
            if(attackThing:getEventConfigVo().eventType == mainExplore.EventType.DUP_MONSTER)then
                if(mainExplore.isInUmbrella(playerThing:getTrans(), attackThing:getTrans(), attackThing:getEventConfigVo().findAngle, attackThing:getEventConfigVo().attackRange))then
                    -- print("玩家主动触发攻击，但处于怪物攻击视野范围内，双方同手")
                    orderIndex = fight.FightDef.HAND_NORMAL
                else
                    -- print("玩家主动触发攻击，背后偷袭，玩家先手")
                    orderIndex = fight.FightDef.HAND_SNEAK_ATTACK
                    -- mainExplore.MainExploreSceneManager:setShowTip(eventConfigVo, "偷袭成功")
                end
            elseif(attackThing:getEventConfigVo().eventType == mainExplore.EventType.DUP_BOSS)then
                -- BOSS不分先后手
                orderIndex = fight.FightDef.HAND_NORMAL
            end
        else
            print("玩家播放完攻击动作怪物已经超出索敌距离撤退了,不做处理")
            return
        end
    else                            -- 事件主动触发攻击
        if(attacker:getEventConfigVo().eventType == mainExplore.EventType.DUP_MONSTER)then
            if(mainExplore.isInUmbrella(attacker:getTrans(), playerThing:getTrans(), playerThing:getPlayerConfigVo().findAngle, playerThing:getPlayerConfigVo().findRange))then
                -- print("怪物主动触发攻击，正面偷袭，怪物先手")
                orderIndex = fight.FightDef.HAND_BE_SNEAK_ATTACK
            else
                -- print("怪物主动触发攻击，背后偷袭，怪物先手")
                orderIndex = fight.FightDef.HAND_BE_SNEAK_ATTACK
                -- mainExplore.MainExploreSceneManager:setShowTip(eventConfigVo, "遭遇奇袭")
            end
        elseif(attacker:getEventConfigVo().eventType == mainExplore.EventType.DUP_BOSS)then
            -- BOSS不分先后手
            orderIndex = fight.FightDef.HAND_NORMAL
        end
    end
    if(orderIndex ~= nil)then
        -- self:dispatchTrigger(eventConfigVo, orderIndex)
        -- 音频播放需要手动移除，表现类放到效果池里去执行
        local function _effectCallFun()
            GameDispatcher:dispatchEvent(EventName.REQ_TRIGGER_MAIN_EXPLORE_EVENT, {eventId = eventConfigVo.eventId, paramList = {orderIndex}})
        end
        mainExplore.MainExploreEffectExecutor:createEffect(eventConfigVo, nil, nil, nil, nil, _effectCallFun)
    else
        Debug:log_error("MainExploreEventExecuter_1", "出手异常")
    end
end

-- 触发之后检测触发事件效果
function checkTriggerEventEffect(self, mapId, eventConfigVo, awardMsgList, dataMsgList, delEventList, addEventList, updateEventList, finishCall)
    super.checkTriggerEventEffect(self, mapId, eventConfigVo, awardMsgList, dataMsgList, delEventList, addEventList, updateEventList, finishCall)
end

-- 触发之后更新事件列表
function afterUpdateEventList(self, mapId, delEventList, addEventList, updateEventList)
    super.afterUpdateEventList(self, mapId, delEventList, addEventList, updateEventList)
end

-- -- 相机表现后请求后端
-- function dispatchTrigger(self, eventConfigVo, orderIndex)
--     -- 更新触发状态：设置
--     mainExplore.MainExploreEventExecutor:updateTriggerStateList(eventConfigVo.triggerStateList, false)

--     local playerTrans = mainExplore.MainExplorePlayerProxy:getThing():getTrans()
--     AudioManager:playSoundEffect(UrlManager:getMainExploreSoundPath("ui_ey_fight.prefab"), nil, nil, playerTrans, 
--     function()
--         AudioManager:playSoundEffect(UrlManager:getMainExploreSoundPath("ui_battle_move.prefab"), nil, nil, playerTrans, nil)
--         local sceneCameraTrans = gs.CameraMgr:GetSceneCamera()
--         if sceneCameraTrans and not gs.GoUtil.IsCompNull(sceneCameraTrans) then
--             local sceneCamera = sceneCameraTrans:GetComponent(ty.PostProcessing)
--             sceneCamera.PostProcessToggle = true
--             sceneCamera.RadialBlurToggle = true
--             sceneCamera.QualityRadialBlurToggle = true
--             sceneCamera.RadialAmount = 0
            
--             local delayFrame = sysParam.SysParamManager:getValue(SysParamType.MAIN_EXPLORE_FIGHT_EFFECT_TIME, 30)
--             LoopManager:addFrame(1, delayFrame, self,
--             function()
--                 delayFrame = delayFrame - 1
--                 if(delayFrame <= 0)then
--                     GameDispatcher:dispatchEvent(EventName.REQ_TRIGGER_MAIN_EXPLORE_EVENT, {eventId = eventConfigVo.eventId, paramList = {orderIndex}})
--                 else
--                     sceneCamera.RadialAmount = 1 / delayFrame
--                 end
--             end)
--         else
--             GameDispatcher:dispatchEvent(EventName.REQ_TRIGGER_MAIN_EXPLORE_EVENT, {eventId = eventConfigVo.eventId, paramList = {orderIndex}})
--         end
    
--         -- 这里屏蔽不恢复，禁止操作直至进入战斗
--         -- -- 更新触发状态：恢复
--         -- mainExplore.MainExploreEventExecutor:updateTriggerStateList(eventConfigVo.triggerStateList, true)
--     end)
-- end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
