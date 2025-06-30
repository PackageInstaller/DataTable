--[[ 
-----------------------------------------------------
@filename       : OrderConfigVo
@Description    : 战盟序列物配置数据
@date           : 2021-06-22 16:02:10
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.covenantTalent.manager.vo.OrderConfigVo', Class.impl())

function parseConfigData(self, cusTid, cusData)
    self.tid = cusTid
    self.skillId = cusData.skill_id
    self.skillBuffList = cusData.skill_attr
end

-- 获取buff效果值类型（固定还是万分比）
function getBuffValueIsPercent(self, buffId)
    for i = 1, #self.skillBuffList do
        local skillBuffData = self.skillBuffList[i]
        if(buffId == skillBuffData.id)then
            if(skillBuffData.type == 1)then
                return false
            elseif(skillBuffData.type == 2)then
                return true
            end
        end
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
