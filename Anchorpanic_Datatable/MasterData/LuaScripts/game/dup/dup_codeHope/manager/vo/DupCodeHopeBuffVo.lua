--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeBuffVo
@Description    : 代号·希望增益buff数据
@date           : 2021-05-10 15:58:09
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup.dup_codeHope.manager.vo.DupCodeHopeBuffVo', Class.impl())

function parseData(self, cusId, cusData)
    self.id = cusId
    self.skillId = cusData.skill_id
    self.type = cusData.type
    self.subtype = cusData.subtype
    self.icon = cusData.icon
    self.langId = cusData.language_id

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
