-- @FileName:   RankingThingConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.ranking.manager.vo.RankingThingConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.icon = cusData.icon
end

function getIcon(self)
    return "arts/ui/pack/ranking/" .. self.icon
end

return _M
