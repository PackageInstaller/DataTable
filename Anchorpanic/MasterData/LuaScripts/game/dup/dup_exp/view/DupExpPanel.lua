module('dup.DupExpPanel', Class.impl(dup.DupDailyBasePanel))
-- UIRes = UrlManager:getUIPrefabPath('dupDaily/DupExpPanel.prefab')

function ctor(self)
    super.ctor(self)
    self:setUICode(LinkCode.DupExp)
end

-- 副本类型
function getDupType(self)
    return DupType.DUP_EXP
end
--获取当前打开页签
function getCurPageIndex(self)
    return dup.DupDailyConst.DUPEXP
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
