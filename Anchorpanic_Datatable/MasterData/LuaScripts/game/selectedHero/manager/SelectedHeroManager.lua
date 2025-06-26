module('selectedHero.SelectedHeroManager',Class.impl(Manager))

--卡牌被选择
EVENT_HERO_SELECT = "EVENT_HERO_SELECT"



function ctor(self)
    self.dataList = {}
    self.selectList = {}
    self.currentCount = 0
    self.maxCount = 0
end

function setInit(self,vo)
    self.dataList = AwardPackManager:getAwardListById(vo.effectList[1])
    self.maxCount = vo.effectList[2]

    for i = 1, #self.dataList do
        table.insert(self.selectList,false)
    end

    self.currentCount = 0
end

function getDataList(self)
    return self.dataList
end

function getMaxCount(self)
    return self.maxCount
end

function getCurrentCount(self)
    return self.currentCount 
end

function setItemChange(self,id)
    self.selectList[id] = not self.selectList[id]

    self.currentCount = 0
    for i = 1, #self.selectList do
        if self.selectList[i] == true then
            self.currentCount = self.currentCount+1
        end
    end
end

function clearSelectList(self)
    for i = 1, #self.selectList do
        self.selectList[i] = false
    end
    self.currentCount =0
end

function getSelectHero(self)
    local list = {}

    for i = 1, #self.selectList do
        if self.selectList[i] == true then
            table.insert(list,self.dataList[i].tid)
        end
    end

    return list
end

function clearAllData(self)
    self:clearSelectList()
    
    self.dataList = {}
    self.selectList = {}
    self.currentCount = 0
    self.maxCount = 0
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
