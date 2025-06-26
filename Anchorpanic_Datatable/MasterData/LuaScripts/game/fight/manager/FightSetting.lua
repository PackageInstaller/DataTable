module('fight.FightSetting', Class.impl())

function ctor(self)
    -- 副本配置的速度类型和实际速度关系
    self.mSpeedDic = {}
    self.mSpeedDic[1] = 1 --初始1倍速
    self.mSpeedDic[2] = 2 --初始2倍速
    self.mSpeedDic[3] = 1 --锁定1倍速
    self.mSpeedDic[4] = 2 --锁定2倍速
    self.mSpeedDic[5] = 3 --初始3倍速
    self.mSpeedDic[6] = 3 --锁定3倍速
end


function getAutoCfg(self)
    local bType = fight.FightManager:getBattleType()
    local autoType = StorageUtil:getNumber1(gstor.FIGHT_UI_AUTO .. bType)
    -- print("====getAutoCfg======", bType, autoType)
    if autoType == nil or autoType == 0 then

        local dupSettingData = fight.FightManager:getDupSettingData(bType)
        if dupSettingData then
            autoType = dupSettingData:getAutoFight()
            -- print("====getAutoCfg222======", bType, autoType)
        else
            autoType = 1
        end
        StorageUtil:saveNumber1(gstor.FIGHT_UI_AUTO .. bType, autoType)
    end
    return autoType
end

function setAutoCfg(self, autoType)
    local bType = fight.FightManager:getBattleType()
    if bType then
        local dupSettingData = fight.FightManager:getDupSettingData(bType)
        if dupSettingData then
            local tmpVal = dupSettingData:getAutoFight()
            if tmpVal == 3 or tmpVal == 4 then
                --    print("====setAutoCfg======", bType, tmpVal)
                return
            end
        end
        -- print("====setAutoCfg22222======", bType, autoType)
        StorageUtil:saveNumber1(gstor.FIGHT_UI_AUTO .. bType, autoType)
    end
end

-- 获取倍速缓存或者配置
function getSpeedCfg(self)
    local bType = fight.FightManager:getBattleType()
    local speedType = StorageUtil:getNumber1(gstor.FIGHT_UI_SPEED .. bType)
    local dupSpeedType = 0
    if speedType == nil or speedType == 0 then
        local dupSettingData = fight.FightManager:getDupSettingData(bType)
        if dupSettingData then
            speedType = self:getSpeedByType(dupSettingData:getFightSpeed())
            dupSpeedType = dupSettingData:getFightSpeed()
        else
            speedType = 1
        end
        StorageUtil:saveNumber1(gstor.FIGHT_UI_SPEED .. bType, speedType)
    end
    return speedType, dupSpeedType
end

-- 保存倍速设置
function setSpeedCfg(self, speedType)
    local bType = fight.FightManager:getBattleType()
    if bType then
        local dupSettingData = fight.FightManager:getDupSettingData(bType)
        if dupSettingData then
            local tmpVal = dupSettingData:getFightSpeed()
            if tmpVal == 3 or tmpVal == 4 then
                -- 3副本锁定1倍速，4副本锁定2倍速
                return
            end
        end
        StorageUtil:saveNumber1(gstor.FIGHT_UI_SPEED .. bType, speedType)
    end
end

-- 获取副本配置的速度类型对应的实际速度
function getSpeedByType(self, type)
    return self.mSpeedDic[type]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]