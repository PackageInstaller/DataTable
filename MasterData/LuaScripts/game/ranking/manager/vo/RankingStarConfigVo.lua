-- @FileName:   RankingStarConfigVo.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-07-25 11:52:14
-- @Copyright:   (LY) 2023 雷焰网络

module('game.ranking.manager.vo.RankingStarConfigVo', Class.impl())

function parseCogfigData(self, key, cusData)
    self.id = key
    self.star = cusData.star
    self.correct = cusData.correct
    self.des = cusData.des
end

function getDesc(self)
    return _TT(self.des)
end

return _M
