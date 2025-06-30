--[[ 
-----------------------------------------------------
@filename       : TeachingBaseVo
@Description    : 上阵教学数据
@date           : 2021-09-08 10:52:58
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.teaching.manager.vo.TeachingBaseVo', Class.impl())

function parseData(self, key, cusData)
    self.id = key
    self.dupId = cusData.battle_field_id
    self.heroFormation = cusData.hero_formation
    self.monFormation = cusData.mon_formation
    self.heroDesList = cusData.hero_des
    self.teachingDes = cusData.teaching_des
    self.heroBanFormation = cusData.hero_ban_formation
    self.tipsRes = cusData.tips_res
    self.pointTitle = cusData.point_title
    self.pointDes = cusData.point_des
end

-- 获取己方阵型id
function getHeroFormationId(self)
    return self.heroFormation[1][1]
end
-- 获取己方指定使用英雄（怪物id）
function getHeroList(self)
    local list = {}
    for i = 2, #self.heroFormation[1] do
        table.insert(list, self.heroFormation[1][i])
    end
    return list
end
-- 获取己方阵型固定位置的英雄
function getFixedHeroTidByPos(self, pos)
    for i = 2, #self.heroFormation do
        local data = self.heroFormation[i]
        if data[1] == 1 and data[2] == pos then
            return data[3]
        end
    end
    return nil
end
-- 英雄注明列表 语言包id
function getHeroDesByPos(self, pos)
    return self.heroDesList[pos]
end
-- 获取己方阵型不可放置位置
function getHeroFormationTileIsBan(self, c, r)
    for i = 1, #self.heroBanFormation do
        local data = self.heroBanFormation[i]
        if data[2] and data[2][1]==c and data[2][2] == r then
            return true
        end
    end
    return false
end


-- 获取怪物阵型id
function getMonFormationId(self)
    return self.monFormation[1]
end
-- 怪物上阵列表
function getMonsterIdByPos(self, pos)
    return self.monFormation[pos + 1]
end

function getTeachingDes(self)
    return _TT(self.teachingDes)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
