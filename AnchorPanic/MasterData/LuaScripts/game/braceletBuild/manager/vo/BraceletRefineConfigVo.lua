

module("braceletBuild.BraceletRefineConfigVo", Class.impl())

function ctor(self)
    self:__init()
end

function __init(self)
    self.tid = nil
    self.refineLvl = nil
    -- 需要消耗的手环tid
    self.needEquipTid = nil
    -- 需要消耗的手环数量
    self.needEquipNum = nil
    -- 消耗的货币
    self.cost = nil
    -- 对应变化的属性key列表
    self.keyList = {}
end

function parseConfigData(self, cusTid, cusData)
    self.tid = cusTid
    self.refineLvl = cusData.star
    self.needEquipTid = cusData.tid
    self.needEquipNum = cusData.num
    self.cost = {cusData.pay_id, cusData.pay_num}
    for k, v in pairs(cusData.attr) do
        table.insert(self.keyList, v.key)
    end

    self.skillBuffList = cusData.skill_attr
    self.des = cusData.des
    self.desc = cusData.desc
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


function getDesc(self)
    return self.des
end

function getTipsDesc(self)
    return self.desc
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
