module("MoneyBar", Class.impl())

--构造函数
function ctor(self)
end

-- 初始化数据
function setData(self, cusParent)
    self.m_parentTrans = cusParent
    self.frontType = nil
    self:__removeItemList()
    self:__updateItemList()
end

function resetData(self)
    self:__removeItemList()
    self.m_parentTrans = nil
end

function active(self)
    MoneyManager:addEventListener(MoneyManager.MONEY_LIST_CHANGE, self.__onMoneyListChangeHandler, self)
end

function deActive(self)
    MoneyManager:removeEventListener(MoneyManager.MONEY_LIST_CHANGE, self.__onMoneyListChangeHandler, self)
end

function __onMoneyListChangeHandler(self, args)
    local isClear = args.isClear
    self.frontType = args.frontType
    self:__removeItemList()
    if (not isClear) then
        self:__updateItemList()
    end
end

function __updateItemList(self)
    local list = MoneyManager:getMoneyTidList()
    for i = 1, #list do
        local item = MoneyItem:poolGet()
        item:setData(self.m_parentTrans, { tid = list[i], frontType = self.frontType })
        -- item:setParent(self.m_parentTrans)
        table.insert(self.m_itemList, item)
    end
end

function __removeItemList(self)
    if (self.m_itemList) then
        for i = 1, #self.m_itemList do
            self.m_itemList[i]:poolRecover()
        end
    end
    self.m_itemList = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
