--[[ 
-----------------------------------------------------
@filename       : ManualWorldConst
@Description    : 世界观
@date           : 2023-3-14 15:17:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualWorldConst", Class.impl())
-- 图鉴类型
manual.ManualWorldType = {
    -- 总览
    Overview = 1,
    -- 世界观
    Worldview = 2,
    -- 地点
    Location = 3,
}
function getTabWorldList(self)
    local tab = {}
    for _, worldTabVo in ipairs(manual.ManualWorldManager:getManualWorldTabList()) do
        if #manual.ManualWorldManager:getTabList(worldTabVo.type) > 0 then
            table.insert(tab, { page = worldTabVo.type, nomalLan = worldTabVo:getName(), nomalLanEn = "",})
        end
    end
    return tab
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]