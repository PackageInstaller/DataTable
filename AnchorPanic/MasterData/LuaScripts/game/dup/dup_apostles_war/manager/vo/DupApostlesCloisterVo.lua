--[[ 
-----------------------------------------------------
@filename       : DupApostlesCloisterVo
@Description    : 使徒之战boss数据
@date           : 2022-06-13 10:28:47
@Author         : lyx
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.dup_apostles_war.manager.vo.DupApostlesCloisterVo', Class.impl())

-- 解析数据
function parseData(self, cusId, cusData)
    self.id = cusId
    self.level = cusData.level
    self.maxStar = 0
    self.taskRewardList = {}
    for k, v in pairs(cusData.task_reward) do
        local dataVo = dup.DupApostlesTaskVo:new()
        dataVo:parseData(k, v)
        self.maxStar = self.maxStar > v.star and self.maxStar or v.star
        self.taskRewardList[k] = dataVo
    end
    
    self.challengeNum = cusData.challenge_num
    self.bossImgList = string.split(cusData.boss_img, ",") 
    self.bossModelList = cusData.boss_model
    self.name = cusData.name
    self.angle = cusData.angle
    self.tidList = cusData.mon_list
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
