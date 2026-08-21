--[[ 
-----------------------------------------------------
@filename       : NoviceActivityRecruitVo
@Description    : 新手活动  招募条件解析
@date           : 2023-6-5 16:50:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("noviceActivity.NoviceActivityRecruitVo", Class.impl())

function parseData(self, id, data)
    --id
    self.id = id
    --达到条件的招募数量 
    self.needNum = data.recruit_num
    --描述
    self.des = data.des
    --奖励列表
    self.reward = {}

    self:parseAwardData(data)
end

function parseAwardData(self, data)
    if next(data.reward) then

        for _, Vo in pairs(data.reward) do
            self.reward[#self.reward + 1] = { tid = Vo[1], num = Vo[2] }
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]