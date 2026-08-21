module("game.dna.manager.vo.DnaHeroEggDataConfigVo", Class.impl()) --Class.impl("lib.event.EventDispatcher"))

frameAniType = {
    smile = 1,
    happy = 2
}

function ctor(self)
end

function getOrgData(self)
    return self.m_orgData
end

function parseConfigData(self, cusTid, cusData)
    self.m_orgData = cusData
    self.tid = cusTid

    --战员形象名字
    self.name = cusData.name
    --点击气泡文本配置
    self.bubble_txt = {}
    for _, btCfg in pairs(cusData.bubble_txt) do
        table.insert(self.bubble_txt, {
            --动画类型
            type = btCfg.type,
            --气泡文本
            txt = btCfg.txt,
        })
    end
    --升级配置
    self.level_data = {}
    for _, levelData in pairs(cusData.level_data) do
        local attr = {}
        for _, data in pairs(levelData.attr) do
            table.insert(attr, data)
        end
        table.sort(attr, function(a, b)
            return a.key < b.key
        end)
        local de_blocking = next(levelData.de_blocking) ~= nil and levelData.de_blocking or nil
        self.level_data[levelData.lv] = {
            --等级 和 i一致
            lv = levelData.lv,
            --所需道具
            cost_tid_list = levelData.cost_tid_list,
            --所需货币id
            pay_id = levelData.pay_id,
            --所需货币数量
            pay_num = levelData.pay_num,
            --属性(list, 元素是table table的key value对应属性id和值)
            attr = attr,
            --解锁技能效果id(list, table[1]是技能id, table[2]是等级)
            de_blocking = de_blocking
        }
    end
end

--获取头像
function getDnaHeroHeadUrl(self)
    return UrlManager:getDnaHeroHeadUrl(self.tid)
end

--获取形象
function getDnaHeroRoleUrl(self)
    return UrlManager:getDnaHeroRoleUrl(self.tid)
end

--获取形象
function getDnaRoleFrameAniUrl(self)
    return UrlManager:getDnaRoleFrameAniUrl(self.tid)
end

function getLevelData(self, lv)
    return self.level_data[lv]
end

function getFullLevelLimit(self)
    return #self.level_data
end

--判断是否满级
function checkIsFullLevel(self, lv)
    return lv >= self:getFullLevelLimit()
end

function getFullAttr(self)
    local levelData = self:getLevelData(self:getFullLevelLimit())
    return levelData.attr
end

--根据目标等级获取该lv拥有的最高技能数据
function getSkillHeroEggLvDataByLv(self, lv)
    lv = lv or 1
    local de_blocking = nil
    for i = lv, 1, -1 do
        local data = self.level_data[i]
        if data.de_blocking then
            if not de_blocking then
                de_blocking = {}
                de_blocking[1] = data.de_blocking[1] --技能id
                de_blocking[2] = 0 --技能等级
            end
            de_blocking[2] = de_blocking[2] + (data.de_blocking[2] or 1)
        end
    end
    return de_blocking
end

--获取配置里配置的所有技能和技能等级数据
function getAllSkillInfoDataList(self)
    local lvDataList = {}
    local skillLv = 0
    for _, data in ipairs(self.level_data) do
        if data.de_blocking then
            skillLv = skillLv + (data.de_blocking[2] or 1)
            table.insert(lvDataList, {
                id = data.de_blocking[1],
                lv = skillLv,
                needLv = data.lv
            })
        end
    end
    return lvDataList
end

function getName(self)
    return _TT(self.name)
end

local lastRandomBubbleK
function getRandomBubbleDataByType(self, frameAniType)
    local dataList = {}
    for _, data in pairs(self.bubble_txt) do
        if not frameAniType or data.type == frameAniType then
            table.insert(dataList,  data)
        end
    end

    local k
    local repeatCount = 0
    local randomLimit = #dataList
    if randomLimit <= 0 then
       logError(string.format("心智体HeroEggDataConfig没有气泡配置，类型是%s, 配置id是%s", frameAniType, self.tid)) 
    end
    repeat
        k = math.random(1, randomLimit)
        repeatCount = repeatCount + 1
    until k ~= lastRandomBubbleK or repeatCount == 100
    lastRandomBubbleK = k or 1
    return dataList[k]
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
