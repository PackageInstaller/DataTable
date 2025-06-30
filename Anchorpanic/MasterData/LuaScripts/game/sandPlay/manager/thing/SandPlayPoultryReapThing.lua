-- @FileName:   SandPlayPoultryReapThing.lua
-- @Description:   一键收取所有作物NPC
-- @Author: ZDH
-- @Date:   2023-07-25 12:00:06
-- @Copyright:   (LY) 2023 雷焰网络
module('game.sandPlay.thing.SandPlayPoultryReapThing', Class.impl(sandPlay.SandPlayOtherNPCThing))

function resetData(self)
    super.resetData(self)

    self.mSeed_id = 0
    for _, eventConfigVo in pairs(self.mData.config.base_config.event_ConfigVoList) do
        if eventConfigVo.event_type == SandPlayConst.EventType.PoultryReap then
            self.mSeed_id = eventConfigVo.event_param[1]
            break
        end
    end

    self.mSeedConfigVo = sandPlay.SandPlayManager:getHappyFarmSeedConfigVo(self.mSeed_id)
end

function createModel(self)
    super.createModel(self)
    self:addEventListener()
end

function addEventListener(self)
    GameDispatcher:addEventListener(EventName.SANDPLAY_HAPPYFARM_EVENT_UPDATE, self.fieldInfoUpdate, self)

end

function removeEventListener(self)
    GameDispatcher:removeEventListener(EventName.SANDPLAY_HAPPYFARM_EVENT_UPDATE, self.fieldInfoUpdate, self)
end

function onModelLoadFinish(self)
    super.onModelLoadFinish(self)

    self:fieldInfoUpdate()
end

function refreshInfoData(self)
    local refrshDt = 0
    for _, field_info in pairs(self.mFieldInfoList) do
        local growDt = GameManager:getClientTime() - field_info.grow_time --成长时间
        local get_interval = self.mSeedConfigVo.production_cycle[1] --收割间隔
        local grow_interval = self.mSeedConfigVo.ripe_time[1] --成长间隔

        local canGetCount = 0 --可收获次数
        local grow_dt = growDt - grow_interval
        if grow_dt >= 0 then
            canGetCount = math.floor(grow_dt / get_interval)
        end

        if canGetCount <= self.mSeedConfigVo.production_cycle[2] then
            local nextGetDt = ((canGetCount + 1) * get_interval) + grow_interval --可收获次数+1*收获的间隔 + 成长间隔 = 下一次收获的时间
            local time = nextGetDt - growDt
            if refrshDt == 0 or refrshDt > time then
                refrshDt = time
            end
        end
    end

    if refrshDt > 0 then
        self:clearModelRefreshTimeOutSn()
        self.mRefreshTimeOutSn = self:setTimeOut(refrshDt, function ()
            GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_ADD, self)
        end)

    end
end

function clearModelRefreshTimeOutSn(self)
    if self.mRefreshTimeOutSn then
        self:clearTimeOutSn(self.mRefreshTimeOutSn)
        self.mRefreshTimeOutSn = nil
    end
end

function fieldInfoUpdate(self, fieldId)
    self.mFieldInfoList = {}
    local fieldInfoDic = sandPlay.SandPlayManager:getHappyFarmEventInfoDic()
    for field_id, field_info in pairs(fieldInfoDic) do
        if field_info.seed_id == self.mSeed_id then
            table.insert(self.mFieldInfoList, field_info)
        end
    end

    self:refreshInfoData()

    GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_REMOVE, self.mData.config.base_config.npc_id)
    GameDispatcher:dispatchEvent(EventName.SANDPLAY_NPC_ADD, self)
end

function getInfoData(self)
    if not self.mSeedConfigVo then
        return nil
    end

    if table.empty(self.mFieldInfoList) then
        return nil
    else
        if self.mSeedConfigVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Chicken then --(鸡)不需要等待收获即可成熟
            for _, field_info in pairs(self.mFieldInfoList) do
                local growDt = GameManager:getClientTime() - field_info.grow_time --成长时间

                local get_interval = self.mSeedConfigVo.production_cycle[1] --收割间隔
                local grow_interval = self.mSeedConfigVo.ripe_time[1] --成长间隔

                local canGetCount = 0 --可收获次数
                local grow_dt = growDt - grow_interval
                if grow_dt >= 0 then
                    canGetCount = math.floor(grow_dt / get_interval)
                end

                if canGetCount > field_info.reap_num then
                    local funCall = function ()
                        if self.mSeedConfigVo == nil then
                            logError("没有这个种子，无法进行收获 id = " .. self.mSeed_id)
                            return
                        end

                        GameDispatcher:dispatchEvent(EventName.SANDPLAY_PLAYERTHING_FINDPOINT, {param = self:getPosition(), stopDistance = 0.5})

                        GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_REAPCHICKEN, self.mSeed_id)
                    end

                    return
                    {
                        id = self.mData.config.base_config.npc_id,
                        follow_trans = self:getTrans(),
                        offset_Y = 0.5,

                        funCall = funCall,
                        funcPath = "arts/ui/pack/sandPlay/happyfarm_handle_00.png",
                        is_reap = true,
                    }
                end
            end
        end
    end
end

function recover(self)
    super.recover(self)

    self:removeEventListener()
end

return _M
