--[[ 
-----------------------------------------------------
@filename       : DormitoryMenuVo
@Description    : 家具菜单数据
@date           : 2021-10-18 11:39:41
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('recruit.DormitoryMenuVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.type = cusData.type
    self.langId = cusData.lang_id
    self.sort = cusData.sort
    self.icon = cusData.icon
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
