--hero相关的表 用于扩展ConfigHelper 暂时先不开放
local HeroConfigHelper = ConfigHelper or {}
local m_dictBreak = nil

function HeroConfigHelper.Clean()
    m_dictBreak = nil
end

function HeroConfigHelper.InitAll()
    m_dictBreak = {}
    local allHeroBreaks = ConfigHelper.GetCfg("heroBreak")
    for i,heroBreakCfg in ipairs(allHeroBreaks) do
        if m_dictBreak[heroBreakCfg.hero] == nil then 
            m_dictBreak[heroBreakCfg.hero] = {}
        end
        local lst = m_dictBreak[heroBreakCfg.hero]
        table.insert( lst , heroBreakCfg )
    end
    --根据等级再排序一次
    for heroId,list in pairs(m_dictBreak) do
        table.sort(list,_SortByBreakLevel)
    end
end

--排序，从突破等级由低到高
function _SortByBreakLevel(a,b)
    return a.breakLevel < b.breakLevel
end

--获取指定英雄的所有突破
function HeroConfigHelper.GetBreaks(heroId)
    if m_dictBreak == nil then 
        HeroConfigHelper.InitAll()
    end
    return m_dictBreak[heroId]
end

--获得英雄的特定突破
function HeroConfigHelper.GetBreak(heroId,breakLevel)
    local heroList = HeroConfigHelper.GetBreaks(heroId)
    if heroList then 
        for i,heroCfg in ipairs(heroList) do
            if heroCfg.breakLevel == breakLevel then 
                return heroCfg
            end
        end
    end
    return nil 
end

--获得英雄最大突破
function HeroConfigHelper.GetMaxBreakLevel(heroId)
    local heroList = HeroConfigHelper.GetBreaks(heroId)
    if heroList and #heroList > 0 then 
        return heroList[#heroList]
    end
    return nil 
end


return HeroConfigHelper