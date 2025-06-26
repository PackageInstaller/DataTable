--[[ 
-----------------------------------------------------
@filename       : HeroAssistVo
@Description    : 英雄助战数据
@date           : 2022-3-1 14:54:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroAssistVo",Class.impl())

function parseMsgData(self, cusData)
    self.heroId = cusData.hero_id
    self.skillIdList = cusData.skill_id_list
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
