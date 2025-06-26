--[[ 
-----------------------------------------------------
@filename       : HeroAssistConfigVo
@Description    : 英雄助战配置数据
@date           : 2022-3-1 14:54:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroAssistConfigVo",Class.impl())

function parseData(self, tid, cusData)
    self.tid = tid
    self.skillId = cusData.skill_id
    -- 1:战员等级达到x级解锁 2:战员增幅等级达到x级解锁 3:战员星级达到x星解锁
    self.type = cusData.type
    self.subtype = cusData.subtype
    self.des = cusData.des
end

function getDes(self)
    return _TT(self.des)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
