module("game.cycle.manager.CycleTalentManager", Class.impl(Manager))
------------------------------------------------------------
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
    self.mTalentConfigVo = {}
    ------------server--------------
    self.mTalentPoint = 0
    self.mOldTalentPoint = 0
    self.mUnlockTalentList = {}
    self.mPlayExpRate = 0
    self.mBattleExpRate = 0
    self.mAddInitCoin = 0 
    self.mAddInitReason = 0 
    self.mUnlockCollage = {}
    self.mTalentAttr = {}
end

-- 析构函数
function dtor(self)
end

function parseTalentConfig(self)
    self.mTalentConfigVo = {}
    local baseData = RefMgr:getData("event_cycle_talent_data")
    for id, data in pairs(baseData) do
        local vo = cycle.CycleTalentVo.new()
        vo:parseData(id, data)
        self.mTalentConfigVo[id] = vo
    end
end

function getTalentConfig(self, talentId)
    if #self.mTalentConfigVo == 0 then
        self:parseTalentConfig()
    end 
    return self.mTalentConfigVo[talentId]
end
------------------------------------------------------------server data------------------------------------

--解析天赋数据
function parseTalentPanel(self,msg)
    local talentInfo = msg.talent_info 
    local talentAttr = msg.talent_attr
    self.mTalentPoint = talentInfo.talent_point
    self.mOldTalentPoint = self.mTalentPoint
    self.mUnlockTalentList = talentInfo.talent_list
    self.mPlayExpRate = talentInfo.play_exp_rate
    self.mBattleExpRate = talentInfo.battle_exp_rate
    self.mAddInitCoin = talentInfo.add_init_coin
    self.mAddInitReason = talentInfo.add_init_reason
    self.mUnlockCollage = talentInfo.unlock_collage

    for k,v in pairs(talentAttr) do
        self.mTalentAttr[v.key] = v.value
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_TALENT_PANEL)
end

function unlockTalentRes(self, msg)
    table.insert(self.mUnlockTalentList, msg.talent_id)
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_TALENT_PANEL)
    gs.Message.Show(_TT(29527))
end

function updateTalentPoint(self, msg)
    self.mOldTalentPoint = self.mTalentPoint
    self.mTalentPoint = msg.talent_point
    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_RED)
    GameDispatcher:dispatchEvent(EventName.UPDATE_TALENT_PANEL)
end

function getTalentPointGap(self)
    return self.mTalentPoint - self.mOldTalentPoint
end

function resetOldTalentPoint(self)
    self.mOldTalentPoint = self.mTalentPoint
end

--获取天赋是否解锁
function getTalentIsUnlock(self, talentId)
    return table.indexof(self.mUnlockTalentList, talentId)
end

function getTalentPoint(self)
    return self.mTalentPoint
end

function getUnlockNum(self)
    return #self.mUnlockTalentList
end

function getTalentAttr(self)
    return self.mTalentAttr
end

function getPlayExpRate(self)
    return self.mPlayExpRate
end

function getBattleExpRate(self)
    return self.mBattleExpRate
end

function getCoin(self)
    return self.mAddInitCoin
end

function getReason(self)
    return self.mAddInitReason
end

function getCollage(self)
    return self.mUnlockCollage
end

function getRedFlag(self)
    for i = 1, 40 do
        local unlock = self:getTalentIsUnlock(i)
        local isCanUnLock = false
        if not unlock then 
            local configVo = self:getTalentConfig(i)
            local needTalentPoint = configVo.needTalent
            if i == 1 then 
                return self:getTalentPoint() >= needTalentPoint
            end

            for k,v in pairs(configVo.preId) do
                if self:getTalentIsUnlock(v) then 
                    isCanUnLock = true
                    break
                end
            end
            isCanUnLock = isCanUnLock and self:getTalentPoint() >= needTalentPoint
        end

        if isCanUnLock then 
            return true
        end
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
