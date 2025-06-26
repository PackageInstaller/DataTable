--[[ 
-----------------------------------------------------
@filename       : DupApostlesPanelInfoVo
@Description    : 使徒之战面板数据
@date           : 2022-06-13 10:28:47
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostles_war.manager.vo.DupApostlesPanelInfoVo', Class.impl())

-- 解析数据
function parseData(self, cusData)
    self.id = cusData.id
    self.challengeTimes = cusData.challenge_times
    self.starNum = cusData.star_num == nil and 0 or cusData.star_num
    self.receivedStarId = cusData.received_star_id
    self.bossList = {}
    for k, v in pairs(cusData.boss_list) do
        local dataVo = dup.DupApostlesBossVo:new()
        dataVo:parseData(v)
        self.bossList[v.id] = dataVo
    end
    self.endTime = cusData.end_time
end

function getEndTime(self)
    return self.endTime or 0
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]