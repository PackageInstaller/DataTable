--[[ 
-----------------------------------------------------
@filename       : RankInfoVo
@Description    : 排行榜类型数据
@date           : 2021-08-19 19:51:29
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.rank.manager.vo.RankInfoVo', Class.impl())

function parseMsg(self, cusMsg)
    self.type = cusMsg.rank_id
    -- 我的排名
    self.myRank = cusMsg.my_rank
    -- 我的排行值
    self.myRankVal = cusMsg.my_rank_val
    -- self.myAllRankCount = cusMsg.rank_player_num
    self.rankList = {}
    for i, v in ipairs(cusMsg.rank_list) do
        local vo = rank.RankBaseVo.new()
        vo:parseMsg(v, self.type)
        table.insert(self.rankList, vo)
    end
    table.sort(self.rankList,function (vo1,vo2)
        return vo1.rank < vo2.rank
    end)
end

function getRankList(self)
    return self.rankList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
