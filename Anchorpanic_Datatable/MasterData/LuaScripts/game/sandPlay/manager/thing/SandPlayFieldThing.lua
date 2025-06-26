-- @FileName:   SandPlayFieldThing.lua
-- @Description:   种植农田
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayFieldThing', Class.impl(sandPlay.SandPlayOtherNPCThing))

function resetData(self)
    super.resetData(self)

    self.mField_id = 0
    for _, eventConfigVo in pairs(self.mData.config.base_config.event_ConfigVoList) do
        if eventConfigVo.event_type == SandPlayConst.EventType.Field then
            self.mField_id = eventConfigVo.event_param[1]
            break
        end
    end
end

function createModel(self)
    super.createModel(self)
    self:addEventListener()
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_FIELDSTATE_UPDATE, self.fieldInfoUpdate, self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_EVENT_REFRESH, self.fieldInfoUpdate, self)

end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_HAPPYFARM_FIELDSTATE_UPDATE, self.fieldInfoUpdate, self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_HAPPYFARM_EVENT_REFRESH, self.fieldInfoUpdate, self)
end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_ADD, self)
end

function onTriggerEnterCall(self)
    local fieldState = self:getStage()

    if fieldState == SandPlayConst.HappyFarm_FieldState.Space_land then
        GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_HAPPYFARM_FIELD, {tab = 1})

        local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
        if playThing then
            playThing:setField_Id(self.mField_id)
        end
    end

    self:showGrowTime()
end

function onTriggerExitCall(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_SANDPLAY_HAPPYFARM_FIELD)

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_SHOW_FIELDINFO, {active = false})

    local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
    if playThing then
        playThing:setField_Id(nil)
    end
end

function showGrowTime(self)
    local stage = self:getStage()
    ---浇完水同时不是成熟期，实时显示成熟时间
    if stage > SandPlayConst.HappyFarm_FieldState.Dry_land and stage < SandPlayConst.HappyFarm_FieldState.grow_up4 then
        local fieldVo = self:getFieldVO()
        if fieldVo then
            local seedConfigVo = sandPlay.SandPlayManager:getHappyFarmSeedConfigVo(fieldVo.seed_id)

            local reapDt = 0
            for _, v in pairs(seedConfigVo.ripe_time) do
                reapDt = reapDt + v
            end

            reapDt = reapDt + fieldVo.grow_time

            GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_SHOW_FIELDINFO, {id = self.mData.id, active = true, name = seedConfigVo:getName(), reapTime = reapDt})
        end
    end
end

function fieldInfoUpdate(self, fieldId)
    if fieldId ~= self.mField_id then
        return
    end

    self:refreshFieldState()
end

function refreshFieldState(self)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_REMOVE, self.mData.config.base_config.npc_id)

    -- self:addEffectToScene("arts/fx/3d/sceneModule/dx_101/fx_farm_jinhua.prefab")
    self:recoverModel()
    self:setupModel()
end

function getInfoData(self)
    local fieldState = self:getStage()
    if fieldState > SandPlayConst.HappyFarm_FieldState.Dry_land and fieldState < SandPlayConst.HappyFarm_FieldState.grow_up4 then
        return nil
    end

    local funCall = function ()
        local finishCall = nil

        local params = nil
        if fieldState == SandPlayConst.HappyFarm_FieldState.Waste_land then
            finishCall = function ()
                local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
                playThing:addWeapon("arts/character/scene_module/nongchang/nc_chutou/modelnc_chutou.prefab", 1, false, function ()
                    local act = SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_CD

                    local aniName = SandPlayConst.HERO_ACTIONSTATE_ACTHASH[act]
                    local frameCount = playThing:GetTotalFrameCount(aniName)
                    if frameCount > 0 then
                        playThing:addFrameCallEvent(aniName, function ()
                            GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_ONREQPLANT, {field_id = self.mField_id, params = {1}})

                            playThing:forceActionState(SandPlayConst.HERO_ACTION_STATE.STAND)
                            playThing:removeWeapon()
                        end, frameCount - 1)
                    end

                    playThing:setActionState(act)
                    playThing:addEffect("arts/fx/3d/sceneModule/dx_101/fx_farm_chutou.prefab", 10, playThing.mModel.m_points[fight.FightDef.POINT_ROOT])
                end)
            end
        elseif fieldState == SandPlayConst.HappyFarm_FieldState.Space_land then
            finishCall = function ()
                GameDispatcher:dispatchEvent(EventName.OPEN_SANDPLAY_HAPPYFARM_FIELD, {tab = 1, field_id = self.mField_id})
            end
        elseif fieldState == SandPlayConst.HappyFarm_FieldState.Dry_land then
            finishCall = function ()
                local playThing = sandPlay.SandPlaySceneController:getPlayerThing()
                playThing:addWeapon("arts/character/scene_module/nongchang/nc_sashuihu/modelnc_sashuihu.prefab", 1, false, function ()
                    local act = SandPlayConst.HERO_ACTION_STATE.HAPPYFARM_SS

                    local aniName = SandPlayConst.HERO_ACTIONSTATE_ACTHASH[act]
                    local frameCount = playThing:GetTotalFrameCount(aniName)
                    if frameCount > 0 then
                        playThing:addFrameCallEvent(aniName, function ()
                            GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_ONREQPLANT, {field_id = self.mField_id, params = {3}})

                            playThing:forceActionState(SandPlayConst.HERO_ACTION_STATE.STAND)
                            playThing:removeWeapon()
                        end, frameCount - 1)
                    end

                    playThing:setActionState(act)
                    playThing:addEffect("arts/fx/3d/sceneModule/dx_101/fx_farm_jiaoshui.prefab", 10, playThing.mModel.m_points[fight.FightDef.POINT_ROOT])
                end)
            end
        elseif fieldState == SandPlayConst.HappyFarm_FieldState.grow_up4 then
            finishCall = function ()
                GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_ONREQPLANT, {field_id = self.mField_id, params = {0}})
            end
        end

        GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERTHING_FINDPOINT, {param = self:getPosition(), finishCall = finishCall})
    end

    local is_reap = false
    local funcPath = ""
    if fieldState == SandPlayConst.HappyFarm_FieldState.Waste_land then
        funcPath = "arts/ui/pack/sandPlay/happyfarm_handle_01.png"
    elseif fieldState == SandPlayConst.HappyFarm_FieldState.Space_land then
        funcPath = "arts/ui/pack/sandPlay/happyfarm_handle_02.png"
    elseif fieldState == SandPlayConst.HappyFarm_FieldState.Dry_land then
        funcPath = "arts/ui/pack/sandPlay/happyfarm_handle_03.png"
    elseif fieldState == SandPlayConst.HappyFarm_FieldState.grow_up4 then
        funcPath = "arts/ui/pack/sandPlay/happyfarm_handle_00.png"
        is_reap = true
    end

    return
    {
        id = self.mData.config.base_config.npc_id,
        follow_trans = self:getTrans(),
        offset_Y = 0.5,

        funCall = funCall,
        funcPath = funcPath,
        is_reap = is_reap,
    }
end

function getPrefabPath(self)
    local fieldState = self:getStage()

    if fieldState < SandPlayConst.HappyFarm_FieldState.grow_up3 then
        return string.format("arts/sceneModule/farm/prefabs/farm_crops_00_%02d.prefab", fieldState)
    else
        local fieldVo = self:getFieldVO()
        return string.format("arts/sceneModule/farm/prefabs/farm_crops_%02d_%02d.prefab", fieldVo.seed_id, fieldState)
    end
end

function getFieldId(self)
    return self.mField_id
end

function getFieldVO(self)
    if not self.mFieldVo then
        self.mFieldVo = sandPlay.SandPlayManager:getHappyFarmEventInfo(self.mField_id)
    end

    return self.mFieldVo
end

function getStage(self)
    local fieldVo = self:getFieldVO()
    local fieldState = SandPlayConst.HappyFarm_FieldState.Waste_land
    if fieldVo then
        fieldState = fieldVo:getStage()
    end

    return fieldState
end

function recoverModel(self)
    if self.mModel then
        self.mModel:onRecover()
        self.mModel = nil
    end
end

function recover(self)
    super.recover(self)

    self:removeEventListener()

    self.mFieldVo = nil
end

return _M
