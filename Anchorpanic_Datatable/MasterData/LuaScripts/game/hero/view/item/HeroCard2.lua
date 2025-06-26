module("hero.HeroCard2", Class.impl(hero.HeroCard))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/HeroCard2.prefab")

function updateBody(self)
    if (self.m_isLoadFinish) then
        -- if (self.mImgBody == nil) then
            self.mImgBody = self:getChildGO("mImgBody"):GetComponent(ty.AutoRefImage)
        -- end
        self.mImgBody:SetImg(UrlManager:getHeroBodyImgUrl(self:getData():getHeroModel()))

        -- if (self.mImgColorBar == nil) then
        self.mImgColorBar = self:getChildGO("mImgColorBar"):GetComponent(ty.Image)
        -- end
        local color = "ffae00ff"
        if self:getData().color == 2 then
            color = "00aeffff"
        elseif self:getData().color == 3 then
            color = "ff83e6ff"
        end
        self.mImgColorBar.color = gs.ColorUtil.GetColor(color)
    end
end

-- function updateBody(self)
--     if (self.m_isLoadFinish) then
--         if (self.mImgBody == nil) then
--             self.mImgBody = self:getChildGO("mImgBody"):GetComponent(ty.AutoRefImage)
--         end
        
--         self.mImgBody:SetImg(UrlManager:getHeroBodyImgUrl(self:getData():getHeroModel()), true)
--     end
-- end

return _M