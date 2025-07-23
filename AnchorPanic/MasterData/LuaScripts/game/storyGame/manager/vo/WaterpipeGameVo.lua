--[[ 
-----------------------------------------------------
@filename       : WaterpipeGameVo
@Description    : 接水管小游戏类型
@date           : 2020-12-24 19:25:42
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.manager.vo.WaterpipeGameVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.waterpipeList = cusData.waterpipe_arr
    self.row = cusData.row
    self.column = cusData.column
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
