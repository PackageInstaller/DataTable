module('doundless.DoundlessSingleCityVo', Class.impl())

function parseData(self,id,cusData)
    self.id = id 

    self.maxRoomNum  = cusData.max_room_num  --人数上限

    self.demoteNum = cusData.demote_num  --降级人数

    self.stayNum = cusData.stay_num --保级人数

    self.promoteNum = cusData.promote_num --晋级人数

    self.disturbanceRank = cusData.disturbance_rank -- 扰动系数统计排名区间

    self.stayPoint = cusData.stay_point --保级积分

    self.stayDrop = cusData.stay_drop  --保级奖励

    self.promoteDrop = cusData.promote_drop -- 晋级奖励

end

return _M