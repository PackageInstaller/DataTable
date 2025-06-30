module('dup.DupHeroStarUpPanel', Class.impl(dup.DupDailyBasePanel))
-- UIRes = UrlManager:getUIPrefabPath('dupDaily/DupHeroStarUpPanel.prefab')

function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.DupHeroStarUp)
end

-- 副本类型
function getDupType(self)
    return DupType.DUP_HERO_STAR_UP
end
--获取当前打开页签
function getCurPageIndex(self)
    return dup.DupDailyConst.DUPHEROSTARUP
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
