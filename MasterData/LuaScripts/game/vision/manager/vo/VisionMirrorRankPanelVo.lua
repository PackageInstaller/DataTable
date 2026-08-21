module('vision.VisionMirrorRankPanelVo', Class.impl())

function parseMsg(self, msg)
    self.rankId = msg.rank_id
    self.myRank = msg.my_rank
    self.layer = msg.layer
    self.myRankVal = msg.my_rank_val
    self.rankList = {}

    for i, v in ipairs(msg.rank_list or {}) do
        local vo = LuaPoolMgr:poolGet(vision.VisionMirrorRankInfoVo)
        vo:parseMsg(v)
        table.insert(self.rankList, vo)
    end

    table.sort(self.rankList, function(vo1, vo2)
        return vo1.rank < vo2.rank
    end)
end

function getRankList(self)
    return self.rankList
end

return _M
