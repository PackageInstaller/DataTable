module("cycle.CycleHeroCard2", Class.impl(hero.HeroCard2))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("cycle/item/CycleHeroCard.prefab")

function updateProfession(self)
    if (self.m_isLoadFinish) then
        if (self.mImgProfession == nil) then
            self.mImgProfession = self:getChildGO("mImgProfession"):GetComponent(ty.AutoRefImage)
        end
        self.mImgProfession:SetImg(UrlManager:getHeroJobSmallIconUrl(self:getData().professionType), false)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
