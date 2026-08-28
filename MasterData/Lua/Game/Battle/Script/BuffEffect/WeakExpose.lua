--
-- Author:luqucheng
-- Date: 2019-11-13 15:51:01
--
local gameUtils = CS.GameUtils
local BuffEffect = import('Game.Battle.Core.BuffEffect')
local WeakExpose = Class("WeakExpose", BuffEffect)

WeakExpose.remainStars = nil
WeakExpose.totalStars = nil

--@effectParams: [Game.Battle.Data.EffectParam#EffectParam]
function WeakExpose:__init(buff, buffEffectData, effectParams)
    BuffEffect.__init(self, buff, buffEffectData, effectParams)
    local data = self.data
    local owner = self.buff.owner
    local attacker = self.buff.attacker

    --记录和读取怪物的弱点暴露次数
    --读取弱点
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting568, "WeakVo")
    --@RefType [Game.Setting.Vo.WeakVo#WeakVo]
    local weakVo = setting:Get(owner.weakId)
    local els = weakVo.weakStars[owner.weakCount + 1]
    assert(els, "没有对应的弱点信息，但是进入了弱点暴露状态:"..owner.typeId)

    --记录弱点
    self.remainStars = els
    self.totalStars = els
    --战报
    RecordMgr:AddRecord(RecordMgr.WeakExposeRecord.New(owner.id, self.remainStars))
end

function WeakExpose:ElementBreak( stars )
    local data = self.data
    local owner = self.buff.owner
    local attacker = self.buff.attacker
    --判断第一个弱点是否很攻击属性对应
    if self.remainStars > 0 then
        --破坏，战报
        self.remainStars  = self.remainStars - stars
        RecordMgr:AddRecord(RecordMgr.ElementBreakRecord.New(owner.id, self.remainStars))
    end
    --返回是否所有的弱点都被击破
    return self.remainStars <= 0
end
return  WeakExpose