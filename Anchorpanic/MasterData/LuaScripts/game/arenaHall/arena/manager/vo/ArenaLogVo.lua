module("arena.ArenaLogVo", Class.impl())

function ctor(self)
end

-- 解析消息
function parseMsgData(self, cusData)
    -- 敌方玩家id
    self.playerId = cusData.id
    -- 敌方玩家名字
    self.name = cusData.name
    -- 敌方玩家头像
    self.avatar = cusData.avatar
    -- 敌方玩家头像框
    self.frame = cusData.avatar_frame
    -- 敌方玩家等级
    self.lvl = cusData.lv
    --是否机器人
    self.isRobat = cusData.is_robot == 1
    -- 是否玩家自己进攻,1获胜0失败
    self.isSelfAttack = cusData.is_self_attack == 1 and true or false
    -- 战斗结果,1获胜0失败
    self.isWin = cusData.result == 1 and true or false
    -- 增加积分
    self.oddScore = cusData.old_score
    -- 减少积分
    self.newScore = cusData.new_score
    -- 战斗id
    self.battleId = cusData.battle_id
    -- 时间
    self.time = cusData.time
    -- 己方段位
    self.segment = cusData.self_segment
    -- 敌方段位
    self.enemySegment = cusData.enemy_segment

    self.formationTid = cusData.self_formation_tid

    self.enemyFormationTid = cusData.enemy_formation_tid
    --战报展示id
    self.showId = cusData.show_id
    --是否有回放
    self.can_replay = cusData.can_replay
    --己方站位 
    self.pos = {}
    --敌方站位 
    self.enemyPos = {}

    self:parsePosData(cusData.self_pos, cusData.enemy_pos)
end


function parsePosData(self, myList, enemyList)
    if myList then
        for _, Vo in pairs(myList) do
            local vo = {
                heroTid = Vo.hero_tid,
                lv = Vo.lv,
                evolution = Vo.evolution,
                fashionId = Vo.body_fashion_id,
                x = Vo.pos.x,
                y = Vo.pos.y
            }
            table.insert(self.pos, vo)
        end
    end
    if enemyList then
        for _, Vo in pairs(enemyList) do
            local enemyVo = {
                heroTid = Vo.hero_tid,
                lv = Vo.lv,
                evolution = Vo.evolution,
                fashionId = Vo.body_fashion_id,
                x = Vo.pos.x,
                y = Vo.pos.y
            }
            table.insert(self.enemyPos, enemyVo)
        end
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]