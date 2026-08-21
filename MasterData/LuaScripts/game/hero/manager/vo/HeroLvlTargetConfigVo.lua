--[[ 
-----------------------------------------------------
@filename       : HeroLvlTargetConfigVo
@Description    : 英雄等级目标数据vo
@date           : 2022-2-18 14:54:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroLvlTargetConfigVo", Class.impl())

function parseConfigData(self, heroTid, targetId, cusData)
    self.heroTid = heroTid
    self.id = targetId
    self.heroLvl = cusData.need_level
    self.awardId = cusData.drop_id
    self.des = cusData.des
end

function getState(self, heroVo)
    local recList = hero.HeroLvlTargetManager:getRecTargetList(heroVo.tid)
    if (recList) then
        if (not table.indexof(recList, self.id)) then
            if (heroVo.lvl >= self.heroLvl) then
                return task.AwardRecState.CAN_REC
            else
                return task.AwardRecState.UN_REC
            end
        else
            return task.AwardRecState.HAS_REC
        end
    end

    return task.AwardRecState.UN_REC
end

function getIsAllRec(self, heroVo)
    local recList = hero.HeroLvlTargetManager:getRecTargetList(heroVo.tid)
    local alltargetList = hero.HeroLvlTargetManager:getLvlTargetList(heroVo.tid)
    if (#recList == #alltargetList) then
        return true
    end
    return false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]