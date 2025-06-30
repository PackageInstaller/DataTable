--[[ 
-----------------------------------------------------
@filename       : WaterpipeBaseVo
@Description    : 接水管游戏的格子数据
@date           : 2020-12-24 16:57:29
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.manager.vo.WaterpipeBaseVo', Class.impl())

function parseData(self, key, cusData)
    -- 格子id
    self.id = key
    -- 图片资源id
    self.img = cusData.img
    -- 是否可操作旋转
    self.canRotate = cusData.is_rotate
    -- 正确方向列表
    self.direction = cusData.direction
    -- 格子初始方向（1234）
    self.initDir = cusData.init_dir
    -- 格子位置
    self.pos = cusData.pos
end

-- 方向是否争取
function isCorrect(self, dir)
    if table.indexof(self.direction, dir) ~= false then
        return true
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
