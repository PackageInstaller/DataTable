module("hero.HeroEquipManager", Class.impl(Manager))

-- 英雄装备列表更新
HERO_EQUIP_LIST_UPDATE = "HERO_EQUIP_LIST_UPDATE"

-------------------- 界面操作事件 --------------------
-- 英雄背包套装选中
HERO_BAG_SUIT_SELECT = "HERO_BAG_SUIT_SELECT"
-- 英雄背包装备选中
HERO_BAG_EQUIP_SELECT = "HERO_BAG_EQUIP_SELECT"
-- 芯片界面装备选中
HERO_EQUIP_TAB_VIEW_SELECT_EQUIP = 'HERO_EQUIP_TAB_VIEW_SELECT_EQUIP'
-- 芯片材料界面选中装备
HERO_EQUIP_MATERIAL_VIEW_SELECT_EQUIP = 'HERO_EQUIP_MATERIAL_VIEW_SELECT_EQUIP'
-- 芯片更换
HERO_BAG_EQUIP_CHANGE = 'HERO_BAG_EQUIP_CHANGE'
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

function __init(self)
    -- self.mHasSelect = nil
    self.mSelectPos = nil 
end

function setPos(self, pos)
    self.mSelectPos = pos
end

function getPos(self)
    return self.mSelectPos
end

-- function getHasSelect(self)
--     return self.mHasSelect
-- end

-- function setHasSelect(self, value)
--     self.mHasSelect = value
-- end

-- 英雄装备更新
function parseHeroUpdateEquipMsg(self, msg)
    local heroId = msg.hero_id
    local heroVo = hero.HeroManager:getHeroVo(heroId)
    if (heroVo) then
        heroVo:delEquipList(msg.del_list)
        heroVo:updateEquipList(msg.update_list)
    end
    self:dispatchEvent(self.HERO_EQUIP_LIST_UPDATE, {})
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
