-- @FileName:   SandPlayHappyFarmFieldVo.lua
-- @Description:   特效效果
-- @Author: ZDH
-- @Date:   2023-09-01 14:30:25
-- @Copyright:   (LY) 2023 雷焰网络

module("sandPlay.SandPlayHappyFarmFieldVo", Class.impl())

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

-- 通过已有资源创建新实例
function create(self, field_data)
    local item = self:poolGet()

    return item
end

function setData(self, field_data)
    self.field_id = field_data.field_id
    self.state = field_data.field_state + 1
    self.seed_id = field_data.crop_id
    self.grow_time = field_data.start_time
    self.reap_num = field_data.reap_count

    if self.seed_id ~= nil and self.seed_id ~= 0 then
        self.configVo = sandPlay.SandPlayManager:getHappyFarmSeedConfigVo(self.seed_id)
    else
        self.configVo = nil
    end

    self:refreshStage()
end

function refreshStage(self)
    self:clearRefreshStateTimeOutSn()

    if self.seed_id ~= nil and self.seed_id ~= 0 then
        local growDt = GameManager:getClientTime() - self.grow_time --成长时间

        if self.configVo.type == SandPlayConst.HappyFarm_Seed_Type.Poultry then
            if self.configVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Chicken then
                local stage = 1
                local growDt = GameManager:getClientTime() - self.grow_time --成长时间
                if growDt >= self.configVo.ripe_time[1] then
                    stage = 2
                else
                    self.mRefreshStageTimeOutSn = LoopManager:setTimeout(self.configVo.ripe_time[1] - growDt, self, self.refreshStage)
                end

                if self.state ~= stage then
                    self.state = stage
                    GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_FIELDSTATE_UPDATE, self.field_id)
                end

            elseif self.configVo.subtype == SandPlayConst.HappyFarm_Poultry_Type.Sheep then
                local stage = 1 -- 1幼崽、2无毛成长期、3收获期
                if self.reap_num == 0 then
                    if growDt >= (self.configVo.ripe_time[1] + self.configVo.production_cycle[1]) then
                        stage = 3
                    else if growDt >= self.configVo.ripe_time[1] then
                            stage = 2
                        end
                    end
                else
                    if growDt >= self.configVo.production_cycle[1] then
                        stage = 3
                    else
                        stage = 2
                    end
                end

                if self.state ~= stage then
                    self.state = stage
                    GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_FIELDSTATE_UPDATE, self.field_id)
                end

                local dt = 0
                if stage == 1 then
                    dt = self.configVo.ripe_time[1] - growDt
                elseif stage == 2 then
                    dt = self.configVo.production_cycle[1] - growDt
                    if self.reap_num == 0 then
                        dt = (self.configVo.production_cycle[1] + self.configVo.ripe_time[1]) - growDt
                    end
                end

                if dt > 0 then
                    self.mRefreshStageTimeOutSn = LoopManager:setTimeout(dt, self, self.refreshStage)
                end
            end
        elseif self.configVo.type == SandPlayConst.HappyFarm_Seed_Type.Crop then
            if self.state >= SandPlayConst.HappyFarm_FieldState.grow_up0 then
                local stage = SandPlayConst.HappyFarm_FieldState.grow_up0
                for i = 1, #self.configVo.ripe_time do
                    growDt = growDt - self.configVo.ripe_time[i]
                    if growDt >= 0 then
                        stage = stage + 1
                    else
                        break
                    end
                end

                if self.state ~= stage then
                    self.state = stage
                    GameDispatcher:dispatchEvent(EventName.SANDPLAY_HAPPYFARM_FIELDSTATE_UPDATE, self.field_id)
                end

                local dt = 0
                local nextStageDt = 0 --下一阶段的时间间隔
                for i = 1, #self.configVo.ripe_time do
                    dt = dt + self.configVo.ripe_time[i]

                    if (self.state - SandPlayConst.HappyFarm_FieldState.grow_up0 + 1) == i then
                        nextStageDt = (self.grow_time + dt) - GameManager:getClientTime()
                        break
                    end
                end

                if nextStageDt > 0 then
                    self.mRefreshStageTimeOutSn = LoopManager:setTimeout(nextStageDt, self, self.refreshStage)
                end
            end
        end
    end

    GameDispatcher:dispatchEvent(EventName.MAINACTIVITY_REDSTATE_UPDATE)
end

function getStage(self)
    return self.state
end

function clearRefreshStateTimeOutSn(self)
    if self.mRefreshStageTimeOutSn then
        LoopManager:clearTimeout(self.mRefreshStageTimeOutSn)
        self.mRefreshStageTimeOutSn = nil
    end
end

-- 回收
function recover(self)
    self:clearRefreshStateTimeOutSn()

    LuaPoolMgr:poolRecover(self)
end
return _M
