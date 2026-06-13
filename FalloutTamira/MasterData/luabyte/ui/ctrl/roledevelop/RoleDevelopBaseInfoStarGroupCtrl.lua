--- 共用组件，改名小心 RoleBaseInfoUICtrl 也在用
local RoleDevelopBaseInfoStarGroupCtrl = BaseClass("RoleDevelopBaseInfoStarGroupCtrl",UIBaseComponent)
local M = RoleDevelopBaseInfoStarGroupCtrl 

---allBreakCount 所有突破的数量， breakLevel 突破等级
function M:SetHeroData(allBreakCount,breakLevel)
    if breakLevel == nil then 
        breakLevel = 0
    end
    for i = 1 , allBreakCount do 
        local isBreak = breakLevel >= i 
        if self._view["star"..i] then 
            self._view["star"..i]:SetActive(true)
        end
        if self._view["starEnable"..i] then 
            self._view["starEnable"..i]:SetActive(isBreak)
        end
    end
end

return RoleDevelopBaseInfoStarGroupCtrl