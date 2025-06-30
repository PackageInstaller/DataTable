--[[ 
-----------------------------------------------------
@filename       : RankManager
@Description    : 排行榜数据管理器
@date           : 2021-08-16 14:36:19
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.rank.manager.RankManager', Class.impl(Manager))

-- 排行榜数据更新
EVENT_RANK_UPDATE = "EVENT_RANK_UPDATE"

--构造
function ctor(self)
    super.ctor(self)
    self:init()
end

--析构
function dtor(self)
end

--初始化
function init(self)
    self.curRankType = nil
    self.mRankData = {}
    self.mRankShowList = {}
    self.mIsRoll = false
end

-- 解析排行榜数据
function onRecRankInfoMsg(self, msg)
    local infoVo = self.mRankData[msg.rank_id]
    if not infoVo then
        infoVo = rank.RankInfoVo.new()
        self.mRankData[msg.rank_id] = infoVo
    end
    infoVo:parseMsg(msg)

    self:dispatchEvent(self.EVENT_RANK_UPDATE, { type = msg.rank_id })
end

-- 取各类型排行榜数据
function getRankInfoVo(self, cusType)
    return self.mRankData[cusType]
end

-- 获取我的排行，用于奖励显示
function getMyRank(self)
    local vo = self:getRankInfoVo(self.curRankType)
    return vo.myRank
end

-- -- 取各模块排行奖励数据
-- function getRewardList(self, cusType)
--     if cusType == rank.RankConst.RANK_CODE_HOPE then
--         return dup.DupCodeHopeManager:getRewardList()
--     elseif cusType == rank.RankConst.RANK_IMPLIED then
--         return dup.DupImpliedManager:getRewardList()
--     elseif cusType == rank.RankConst.RANK_MAZE then
--         return maze.MazeManager:getRankAwardList()
--     elseif cusType == rank.RankConst.RANK_APOSTLES then
--         return dup.DupApostlesWarManager:getRewardList()
--     elseif cusType == rank.RankConst.RANK_ROGUELIKE then
--         return rogueLike.RogueLikeManager:getRankAwardList()
--     end
-- end

-- -- 解析排行榜展示人数
-- function paserRankNum(self)
--     self.mRankNumDic = {}
--     local baseData = RefMgr:getData("rank_data")
--     for id,num in pairs(baseData) do
--         self.mRankNumDic[id] = num.show_num
--     end
-- end

-- 解析排行榜显示配置
function parseConfigData(self, cusData)
    self.mRankShowList = {}
    local baseData = RefMgr:getData("rank_show_data")
    for key, data in pairs(baseData) do
        local vo = rank.RankShowVo.new()
        vo:parseConfigData(key, data)
        table.insert(self.mRankShowList, vo)
    end
end

function getRankShowList(self)
    if #self.mRankShowList == 0 then
        self:parseConfigData()
    end
    return self.mRankShowList
end

-- 获取排行榜展示人数
function getRankNum(self,cusId)
    return 100
end

--修改滑动显示
function setRoll(self, isRoll)
    self.mIsRoll = isRoll
end
--获取滚动状态
function getRollState(self)
    return self.mIsRoll
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
