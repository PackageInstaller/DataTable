monster = {}

require('game/monster/manager/MonsterConst')
monster.MonsterTidConfigVo = require('game/monster/manager/vo/MonsterTidConfigVo')
monster.MonsterConfigVo = require('game/monster/manager/vo/MonsterConfigVo')
monster.MonsterManager = require('game/monster/manager/MonsterManager').new()
local _c = require('game/monster/controller/MonsterController').new(monster.MonsterManager)

local module = { _c }
return module
 
--[[ 替换语言包自动生成，请勿修改！
]]
