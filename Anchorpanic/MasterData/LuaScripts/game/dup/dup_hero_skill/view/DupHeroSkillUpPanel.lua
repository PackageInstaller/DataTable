module('dup.DupHeroSkillUpPanel', Class.impl(dup.DupDailyBasePanel))
-- UIRes = UrlManager:getUIPrefabPath('dupDaily/DupHeroGrowUpPanel.prefab')

function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.DupHeroGrowUp)
end

-- 副本类型
function getDupType(self)
    return DupType.DUP_HERO_SKILL
end
--获取当前打开页签
function getCurPageIndex(self)
    return dup.DupDailyConst.DUPHEROSKILL
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
