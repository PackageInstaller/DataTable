module("fight.AttrManager", Class.impl())

-- 构造函数
function ctor(self)
    self.mAttrShowDic = nil
    self:__parseAttrShowData()
end

-- 初始化配置表
function __parseAttrShowData(self)
    self.mAttrShowDic = {}
    local baseData = RefMgr:getData('attr_show_data')
    for key, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(fight.AttrShowDataRo)
        ro:parseData(key, data)
        self.mAttrShowDic[key] = ro
    end
end

function getAttDic(self)
    return self.mAttrShowDic
end

function getAttName(self, cusKey)
    if self.mAttrShowDic == nil then
        self:__parseAttrShowData()
    end
    local name = ("?" .. cusKey .. "?")
    if (self:getAttrShowVo(cusKey)) then
        return _TT(self:getAttrShowVo(cusKey):getName()) or name
    else
        return name
    end
end

function getAttNameEn(self, cusKey)
    if self.mAttrShowDic == nil then
        self:__parseAttrShowData()
    end
    local name = ("?" .. cusKey .. "?")
    if (self:getAttrShowVo(cusKey)) then
        return _TT(self:getAttrShowVo(cusKey):getEngName()) or name
    else
        return name
    end
end

function isPercentAttr(self, cusKey)
    if self.mAttrShowDic == nil then
        self:__parseAttrShowData()
    end
    return self:getAttrShowVo(cusKey):getShowType() == 2
end

function getType(self, cusKey)
    if self.mAttrShowDic == nil then
        self:__parseAttrShowData()
    end
    return self:getAttrShowVo(cusKey):getType()
end

function getSort(self, cusKey)
    if self.mAttrShowDic == nil then
        self:__parseAttrShowData()
    end
    return self:getAttrShowVo(cusKey):getSort()
end

function isNeedShow(self, cusKey)
    if self.mAttrShowDic == nil then
        self:__parseAttrShowData()
    end
    return self:getAttrShowVo(cusKey):getShow() == 1
end

function getAttrShowVo(self, cusKey)
    local attrShowVo = self.mAttrShowDic[cusKey]
    -- if(not attrShowVo)then
    --     attrShowVo = LuaPoolMgr:poolGet(fight.AttrShowDataRo)
    --     attrShowVo.m_sort = 1
    --     attrShowVo.m_showType = 1
    --     attrShowVo.m_type = 1
    --     attrShowVo.m_engName = 3201
    --     attrShowVo.m_name = 3101
    --     attrShowVo.m_show = 1
    --     logError("记得去掉测试")
    -- end
    return attrShowVo
end

function getAttListByMainSecondaryType(self)
    local attrDic = self.mAttrShowDic
    local dicList = {}
    for key, attrVo in pairs(attrDic) do
        local list = dicList[attrVo:getMainSecondaryType()]
        if(not list)then
            list = {}
            dicList[attrVo:getMainSecondaryType()] = list
        end
        table.insert(list, attrVo)
    end
    for _, list in pairs(dicList) do
        table.sort(list, function(attrVo1, attrVo2) return attrVo1:getSort() > attrVo2:getSort() end)
    end
    return dicList
end

function getAttListByMainSecondaryTypeMerge(self)
    local attrDic = self.mAttrShowDic
    local dicList = {}
    for key, attrVo in pairs(attrDic) do
        if(attrVo:getMainSecondaryType() == AttConst.AttrMainSecondaryType.MainSecondary)then
            local mainList = dicList[AttConst.AttrMainSecondaryType.Main]
            if(not mainList)then
                mainList = {}
                dicList[AttConst.AttrMainSecondaryType.Main] = mainList
            end
            table.insert(mainList, attrVo)
            local secondaryList = dicList[AttConst.AttrMainSecondaryType.Secondary]
            if(not secondaryList)then
                secondaryList = {}
                dicList[AttConst.AttrMainSecondaryType.Secondary] = secondaryList
            end
            table.insert(secondaryList, attrVo)
        else
            local list = dicList[attrVo:getMainSecondaryType()]
            if(not list)then
                list = {}
                dicList[attrVo:getMainSecondaryType()] = list
            end
            table.insert(list, attrVo)
        end
    end
    for _, list in pairs(dicList) do
        table.sort(list, function(attrVo1, attrVo2)
            if attrVo1:getSort() ~= attrVo2:getSort() then
                return attrVo1:getSort() < attrVo2:getSort()
            end
            return false
        end)
    end
    return dicList
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
