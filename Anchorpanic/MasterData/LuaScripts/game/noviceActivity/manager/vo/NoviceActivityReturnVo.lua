--[[ 
-----------------------------------------------------
@filename       : NoviceActivityReturnVo
@Description    : 新手活动 手环铸痕解析
@date           : 2023-6-5 16:50:35
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("noviceActivity.NoviceActivityReturnVo", Class.impl())

function parseData(self, id, data)
    --id
    self.id = id
    --1.特定战员升级到X级别  2.特定战员突破阶段到x阶 
    self.type = data.type
    -- 战员id
    self.heroTid = data.param[1]
    --type 1.特定战员升级到X级别  type 2.特定战员突破阶段到x阶 
    self.reachLv = data.param[2]
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