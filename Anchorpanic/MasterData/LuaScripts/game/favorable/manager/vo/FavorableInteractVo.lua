--[[ 
-----------------------------------------------------
@filename       : FavorableInteractVo
@Description    : 战员档案cv数据
@date           : 2021-08-23 14:48:49
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.heroFile.manager.vo.FavorableInteractVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.action = cusData.action
    self.cvId = cusData.cv_id
    self.relationLv = cusData.relation_lv
    self.time = cusData.time
    self.title = cusData.title
end

function getTitle(self)
    return _TT(self.title)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
