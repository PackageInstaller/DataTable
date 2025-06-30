--[[
-----------------------------------------------------
@filename       : OrganizeBackpacksVo
@Description    : 整理背包数据
@date           : 2024-09-24 10:07:15
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.organizeBackpacks.manager.vo.OrganizeBackpacksVo', Class.impl())

function parseConfigData(self, key, cusData)
    self.id = key

    if table.empty(cusData.begin_time) then
        self.startTime = 0
    else
        self.startTime = TimeUtil.transTime2(cusData.begin_time)
    end
    self.preId = cusData.pre_id
    self.name = cusData.name
    self.desc = cusData.desc
    self.help = cusData.help
    self.firstAward = cusData.first_award
end
--获取关卡描述
function getDesc(self)
    return _TT(self.desc)
end
--提示
function getHelp(self)
    return _TT(self.help)
end
--上一关ID
function getPreId(self)
    return self.preId
end

--关卡名称
function getName(self)
    return self.name
end
--是否开启
function getIsTimeOpen(self)
    if self.startTime <= 0 then
        return true
    end

    local gameClientTime = GameManager:getClientTime()
    return gameClientTime >= self.startTime
end

function getIsOpen(self)
    if self.preId == 0 then
        return true
    end

    return table.indexof01(organizeBackpacks.OrganizeBackpacksManager:getPassLevelList(), self.preId) > 0
end

--是否通过
function getIsPass(self)
    return table.indexof01(organizeBackpacks.OrganizeBackpacksManager:getPassLevelList(), self.id) > 0
end
--获取ID
function getId(self)
    return self.id
end
--获取类型
function getType(self)
    return organizeBackpacks.OrganizeBackpacksManager:getStageTypeById(self.id)
end
--获得奖励
function getAwardList(self)
    return AwardPackManager:getAwardListById(self.firstAward)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
