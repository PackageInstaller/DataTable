module("cycle.CyclePassHeroItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgHero = self:getChildGO("mImgHero"):GetComponent(ty.AutoRefImage)
end


function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

function setData(self, data)
    super.setData(self, data)
    local heroVo = hero.HeroManager:getHeroVo(data)
    self.mImgHero:SetImg(UrlManager:getIconPath("heroList/hero_bigBody_" .. heroVo:getHeroModel() .. ".png"),false)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
