--[[ 
-----------------------------------------------------
@filename       : ManualHeroManager
@Description    : 图鉴-战员
@date           : 2023-3-27 17:42:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("game.manual.manualHero.manager.ManualHeroManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

--初始化
function __init(self)
    self.mManualHeroList = {}
    self.mManualHeroDic = nil
    self.mManualHeroCampList = {}
    self.mManualHeroCampDic = nil
end

-- 解析图鉴配置
function parseManualHeroConfig(self)
    self.mManualHeroList = {}
    self.mManualHeroDic = {}
    self.mManualHeroCampList = {}
    self.mManualHeroCampDic = {}
    local baseData = hero.HeroManager:getHeroConfigDic()
    for key, data in pairs(baseData) do
        local vo = manual.ManualHeroVo.new()
        vo:parseData(key, data)
        if not self.mManualHeroCampDic[vo.camp] then
            self.mManualHeroCampDic[vo.camp] = {}
        end
        if table.indexof(self.mManualHeroCampDic[vo.camp], vo) == false then
            table.insert(self.mManualHeroCampDic[vo.camp], vo)
        end
        if table.indexof(self.mManualHeroCampList, vo.camp) == false then
            table.insert(self.mManualHeroCampList, vo.camp)
        end
        self.mManualHeroDic[vo.index] = vo
        table.insert(self.mManualHeroList, vo)
    end
    table.sort(self.mManualHeroList, function(vo1, vo2) return vo1:getSort() < vo2:getSort() end)
end

function getManualHeroList(self)
    if #self.mManualHeroList <= 0 then
        self:parseManualHeroConfig()
    end
    return self.mManualHeroList or {}
end

function getManualHeroCampList(self)
    if #self.mManualHeroCampList <= 0 then
        self:parseManualHeroConfig()
    end
    return self.mManualHeroCampList or {}
end

function getManualHeroCampDicListByCamp(self, camp)
    if #self.mManualHeroCampDic <= 0 then
        self:parseManualHeroConfig()
    end
    if self.mManualHeroCampDic[camp] then
        table.sort(self.mManualHeroCampDic[camp], function(vo1, vo2)
            return vo1:getSort() > vo2:getSort()
        end)
    end
    return self.mManualHeroCampDic[camp] or {}
end

function getIsNew(self, camp)
    for _, manualHeroVo in ipairs(self:getManualHeroCampDicListByCamp(camp)) do
        if manualHeroVo:getIsNew() then
            return true
        end
    end
    return false
end

function reqUpdateNew(self, camp)
    for _, manualHeroVo in ipairs(self:getManualHeroCampDicListByCamp(camp)) do
        if manualHeroVo:getIsNew() then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_HERO, id = manualHeroVo.tid })
        end
    end
end

function getAllHaveNew(self)
    for _, camp in ipairs(self:getManualHeroCampList()) do
        if self:getIsNew(camp) then
            return true
        end
    end
    return false
end

function getUnlockListPercentByCamp(self, camp)
    local count = 0
    for _, herovo in ipairs(self:getManualHeroCampDicListByCamp(camp)) do
        if herovo:getIsUnlock() then
            count = count + 1
        end
    end
    return math.floor((count / #self:getManualHeroCampDicListByCamp(camp)) * 100)
end
function getAllUnlockListPercent(self)
    local count = 0
    local allCount = 0
    for _, camp in ipairs(self:getManualHeroCampList()) do
        for _, herovo in ipairs(self:getManualHeroCampDicListByCamp(camp)) do
            if herovo:getIsUnlock() then
                count = count + 1
            end
            allCount = allCount + 1
        end
    end
    return math.floor((count / allCount) * 100)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]