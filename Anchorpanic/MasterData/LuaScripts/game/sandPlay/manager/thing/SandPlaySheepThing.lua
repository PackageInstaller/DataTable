-- @FileName:   SandPlaySheepThing.lua
-- @Description:   家禽 羊
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlaySheepThing', Class.impl(sandPlay.SandPlayPoultryThing))

function resetData(self)
    super.resetData(self)

    self.mAvoidancePriority = 49 --寻路优先级
end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    if self.mData:getStage() == 3 then
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_ADD, self)
    else
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_REMOVE, self.mData.field_id)
    end
end

function getInfoData(self)
    if self.mData:getStage() == 3 then
        local funCall = function ()
            self:stopAI()
            GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERTHING_FINDPOINT, {param = self:getPosition(), stopDistance = 0.5,
                pauseCall = function ()
                    self:startAI()
                end,
                finishCall = function ()
                    local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
                    playThing:addWeapon("arts/character/scene_module/nongchang/nc_jiandao/modelnc_jiandao.prefab", 1, false, function ()
                        local act = SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_JM

                        local aniName = SandPlayConst.HERO_ACTIONSTATE_ACTHASH[act]
                        local frameCount = playThing:GetTotalFrameCount(aniName)
                        if frameCount > 0 then
                            playThing:addFrameCallEvent(aniName, function ()
                                GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_ONREQPLANT, {field_id = self.mData.field_id, params = {0}})

                                playThing:forceActionState(SandPlayConst.HERO_ACTION_STATE.STAND)
                                playThing:removeWeapon()

                                self:startAI()
                            end, frameCount - 1)
                        end

                        playThing:setActionState(act)
                        self:addEffect("arts/fx/3d/sceneModule/dx_101/fx_farm_jianmao.prefab", 10, self:FindNameInChilds("Root_node"))
                    end)
                end,
            })
        end

        return
        {
            id = self.mData.field_id,
            follow_trans = self:getTrans(),
            offset_Y = 0.7,

            funCall = funCall,
            funcPath = "arts/ui/pack/sandPlay/happyfarm_handle_00.png",
            is_reap = true,
        }
    end
end

function setAIRadius(self)
    local radiusList = {0.25, 0.3, 0.35}
    self.mAIRadius = radiusList[self.mData:getStage()]
end

function getPrefabPath(self)
    if self.mData:getStage() == 1 then
        return "arts/character/scene_module/nongchang/nc_yang_01/modelnc_yang_01.prefab"
    elseif self.mData:getStage() == 2 then
        return "arts/character/scene_module/nongchang/nc_yang_03/modelnc_yang_03.prefab"
    elseif self.mData:getStage() == 3 then
        return "arts/character/scene_module/nongchang/nc_yang_02/modelnc_yang_02.prefab"
    end
end

function recover(self)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_REMOVE, self.mData.field_id)

    super.recover(self)
end

return _M
