module("hero.HeroMilitaryRankSucItem", Class.impl(hero.HeroMilitaryRankListItem))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/HeroMilitaryRankSucItem.prefab")

function __updateContent(self)
    super.__updateContent(self)
    self.m_textMilitaryTip.text = _TT(1043)--"军阶"
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
