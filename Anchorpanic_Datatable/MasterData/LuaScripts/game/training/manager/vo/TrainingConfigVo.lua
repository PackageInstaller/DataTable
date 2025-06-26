module("training.TrainingConfigVo", Class.impl())

function ctor(self)
end

function parseData(self, stepId, cusData)
    self.stepId = stepId
    self.monList = cusData.mon_tid
    self.preGainList = {}
    for i = 1, #cusData.gain do
        table.insert(self.preGainList, {tid = cusData.gain[i][1], num = cusData.gain[i][2]})
    end
end

-- 获取随机怪物tid
function getRandomMonsterTid(self, filterTid)
    if(#self.monList == 1)then
        return self.monList[1]
    else
        local isFilterSuc = false
        if(table.removebyvalue(self.monList, filterTid) ~= 0)then
            isFilterSuc = true
        end
        local randomIndex = math.random(1, #self.monList)
        local randomTid = self.monList[randomIndex]
        if(isFilterSuc)then
            table.insert(self.monList, filterTid)
        end
        return randomTid
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
