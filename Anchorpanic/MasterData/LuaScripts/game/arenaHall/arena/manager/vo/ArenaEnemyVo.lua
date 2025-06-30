module("arena.ArenaEnemyVo", Class.impl())

function ctor(self)
end

-- 解析消息
function parseMsgData(self, cusData)
    -- 玩家id
    self.playerId = cusData.id
    -- 排名
    self.rank = cusData.rank
    -- 是否机器人，1是0否
    self.isRobot = cusData.is_robot == 1
    -- 积分
    self.score = cusData.score
    -- 等级
    self.lvl = cusData.lv
    -- 头像
    self.avatar = cusData.avatar
    -- 战力
    self.fightNum = cusData.power
    -- 玩家名字
    self.name = cusData.name
    -- 头像框
    self.frame = cusData.avatar_frame
    --段位
    self.segment = cusData.segment
    --出战队列
    self.heroList = {}
    for i, Vo in ipairs(cusData.hero_list) do
        local heroVo = hero.HeroVo.new()
        heroVo:parseMsgData(Vo)
        heroVo.fashionId = Vo.body_fashion_id
        table.insert(self.heroList, heroVo)
    end
end

function getFightHeroList(self)
    if not self.heroList then
        self.heroList = {}
    end
    return self.heroList
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]