--
-- Author:luqucheng
-- Date: 2019-11-13 15:51:01
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')
local SPTypeChange = Class("SPTypeChange", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function SPTypeChange:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)
    local data = self.data
    local owner = self.buff.owner
    local attacker = self.buff.attacker

    local fromType = owner.spPointType
    local totype = 2
    owner.spPointType = totype
    RecordMgr:AddRecord(RecordMgr.SPTypeChangeRecord.New(owner.id, fromType, totype))
end

function SPTypeChange:OnRemove()
    local owner = self.buff.owner
    local fromType = owner.spPointType
    local totype = 1
    owner.spPointType = totype
    RecordMgr:AddRecord(RecordMgr.SPTypeChangeRecord.New(owner.id, fromType, totype))
end

return  SPTypeChange