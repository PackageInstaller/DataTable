module("maze.MazeEventThingVo", Class.impl(maze.MazeBaseEventThingVo))

-- 怪物重生
MONSTER_REBORN_UPDATE = "MONSTER_REBORN_UPDATE"

function getType(self)
    return maze.THING_TYPE_EVENT
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
