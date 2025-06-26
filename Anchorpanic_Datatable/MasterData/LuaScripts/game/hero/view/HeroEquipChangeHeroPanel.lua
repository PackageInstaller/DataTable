module("hero.HeroEquipChangeHeroPanel", Class.impl(hero.HeroPanel))


function configUI(self)
    super.configUI(self)
    self.m_scroll:SetItemRender(hero.HeroListScrollItem_3)
end
-- 英雄列表选择
function __onListSelectHandler(self, args)
    
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
