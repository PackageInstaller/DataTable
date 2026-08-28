--
-- Author:luqucheng
-- Date: 2019-11-13 15:51:01
--
local BuffEffect = import('Game.Battle.Core.BuffEffect')

local LockAttrNumBuffType = Constants.SpecialBuffType.LockAttrNum

local LockAttrNum = Class("LockAttrNum", BuffEffect)

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function LockAttrNum:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)
    local data = self.data
    local owner = self.buff.owner

    local attrId = data.effectNum1[1]

    owner.buffMgr:AddLockAttrId(attrId)
end

function LockAttrNum:OnRemove()
    local data = self.data
    local owner = self.buff.owner

    local attrId = data.effectNum1[1]

    owner.buffMgr:RemoveLockAttrId(attrId)
end

return  LockAttrNum