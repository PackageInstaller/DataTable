module("fashion.FashionWeaponTabView", Class.impl(fashion.FashionClothesTabView))

-- UIRes = UrlManager:getUIPrefabPath("fashion/tab/FashionWeaponTabView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

function configUI(self)
    super.configUI(self)
end

function active(self, args)
    super.active(self, args)
end

function deActive(self)
    super.deActive(self)
end

function initViewText(self)
    super.initViewText(self)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
end

function getFashionType(self)
    return fashion.Type.WEAPON
end

function getFashionSource(self, sortIndex)
    local heroVo = hero.HeroManager:getHeroVo(fashion.FashionManager:getHeroId())
    local fashionConfigVo = fashion.FashionManager:getHeroFashionConfigVoBySort(self:getFashionType(), heroVo.tid, sortIndex)
    return UrlManager:getFashionWeaponUrl(fashionConfigVo.model)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
