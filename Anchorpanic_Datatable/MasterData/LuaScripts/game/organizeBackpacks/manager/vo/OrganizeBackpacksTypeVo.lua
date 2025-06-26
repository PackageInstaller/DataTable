--[[
-----------------------------------------------------
@filename       : OrganizeBackpacksTypeVo
@Description    : 整理背包类型数据
@date           : 2024-09-24 10:07:15
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.organizeBackpacks.manager.vo.OrganizeBackpacksTypeVo', Class.impl())

function parseConfigData(self, key, cusData)
    self.id = key
    self.name = cusData.name
    self.stageList = cusData.stage_list
    
    if table.empty(cusData.begin_time) then
        self.beginTime = 0
    else
        self.beginTime = TimeUtil.transTime2(cusData.begin_time)
    end
end
function getName(self)
    return _TT(self.name)
end

function getStageList(self)
    return self.stageList
end

function getId(self)
    return self.id
end

function getIsTimeOpen(self)
    if self.beginTime <= 0 then
        return true
    end

    local gameClientTime = GameManager:getClientTime()
    return gameClientTime >= self.beginTime

end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
