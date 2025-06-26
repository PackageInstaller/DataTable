module("game.dna.manager.vo.DnaEggDataConfigVo", Class.impl()) --Class.impl("lib.event.EventDispatcher"))

function ctor(self)
end

function getOrgData(self)
    return self.m_orgData
end

function parseConfigData(self, cusTid, cusData, quality)
    self.m_orgData = cusData
    self.tid = cusTid
    --品质
    self.quality = quality
    --道具id（唯一）
    self.item_id = cusData.item_id
    --战员属性id
    self.hero_ele_type = cusData.hero_ele_type
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
            attr = attr
        }
    end
end

--获取图标
function getDnaEggIconUrl(self)
    return UrlManager:getDnaEggIconUrl(self.item_id)
end

function getLevelData(self, lv)
    return self.level_data[lv]
end

function getFullLevelLimit(self)
    return #self.level_data
end

function getFullAttr(self)
    local levelData = self:getLevelData(self:getFullLevelLimit())
    return levelData.attr
end

--判断是否满级
function checkIsFullLevel(self, lv)
    return lv >= self:getFullLevelLimit()
end

function getName(self)
    local propsConfigVo = props.PropsManager:getTypePropsVoByTid(self.item_id)
    return propsConfigVo.name
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
