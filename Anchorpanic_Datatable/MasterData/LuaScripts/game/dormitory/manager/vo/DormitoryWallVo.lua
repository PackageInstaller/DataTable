--[[ 
-----------------------------------------------------
@filename       : DormitoryWallVo
@Description    : 宿舍墙面样式信息
@date           : 2021-11-04 11:26:51
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dormitory.manager.vo.DormitoryWallVo', Class.impl())

function parseData(self, key, cusData)
    self.tid = key
    self.frontRes = cusData.front
    self.backRes = cusData.back
    self.leftRes = cusData.left
    self.rightRes = cusData.right
    self.doorRes = cusData.door
    self.col = cusData.col
    self.wallId = cusData.wall_id
    self.doorWidth = cusData.door_width
    self.doorHeight = cusData.door_height
    self.doorDeep = cusData.door_deep
end

function getWallResByWallId(self, wallId)
    local wallResDic = {}
    wallResDic[DormitoryCost.SITE_WALL_FRONT] = self.frontRes
    wallResDic[DormitoryCost.SITE_WALL_LEFT] = self.leftRes
    wallResDic[DormitoryCost.SITE_WALL_BACK] = self.backRes
    wallResDic[DormitoryCost.SITE_WALL_RIGHT] = self.rightRes
    return wallResDic[wallId]
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
