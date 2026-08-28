--
-- Author:luqucheng
-- Date: 2019-11-13 15:51:01
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')
local Weak = Class("Weak", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function Weak:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)
    local data = self.data
    local owner = self.buff.owner
    local attacker = self.buff.attacker


    print( "weak weak" )
    owner.weakCount  = owner.weakCount + 1
    RecordMgr:AddRecord(RecordMgr.WeakRecord.New(owner.id, self.buff.remainRound))
end

return  Weak