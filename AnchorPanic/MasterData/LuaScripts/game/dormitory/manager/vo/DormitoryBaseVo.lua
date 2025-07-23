--[[ 
-----------------------------------------------------
@filename       : DormitoryBaseVo
@Description    : 宿舍家具基础信息
@date           : 2021-07-29 19:41:43
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.manager.vo.DormitoryBaseVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.tid = key
    self.subType = cusData.sub_type
    self.length = cusData.length
    self.width = cusData.width
    self.height = cusData.height
    self.resName = cusData.res_name
    self.isRotate = cusData.is_rotate
    self.quota = cusData.quota
    self.posType = cusData.pos_type
    self.interact_name = cusData.interact_name
    self.aura = cusData.mood
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
