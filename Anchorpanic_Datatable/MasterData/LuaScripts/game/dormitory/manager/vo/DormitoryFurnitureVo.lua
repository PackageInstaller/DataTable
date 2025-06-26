--[[ 
-----------------------------------------------------
@filename       : DormitoryFurnitureVo
@Description    : 宿舍家具信息
@date           : 2021-07-29 10:24:05
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.manager.vo.DormitoryFurnitureVo', Class.impl())

function parseMsg(self, cusMsg)
    -- 家具唯一id
    self.id = cusMsg.id
    -- 家具tid
    self.tid = cusMsg.tid
    -- 挪动信息 0-宿舍里面自己挪动，1-从宿舍到包，2-从包到宿舍
    self.move = cusMsg.move
    -- 中心点行的位置
    self.row = cusMsg.put_info.row
    -- 中心点列位置
    self.col = cusMsg.put_info.columns
    -- 位置1-地板，2-左边的墙等等
    self.location = cusMsg.put_info.location
    -- 家具摆放的方向
    self.dir = cusMsg.put_info.direction

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
