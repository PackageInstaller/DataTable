--[[ 
-----------------------------------------------------
@filename       : DupChipConst
@Description    : 芯片Const
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("dup.DupChipConst", Class.impl())
LOWLEVEL = 1 -- 低级副本
MIDDLELEVEL = 2 -- 中级副本
HIGHLEVEL = 3 -- 高级副本

function getTabList(self)
    local tab = {}

    for i, vo in ipairs(dup.DupEquipMainManager:getDupEquipData()) do
        tab[i] = { page = i, nomalLan = vo:getName(), nomalLanEn = "", funcId = vo.funcId }
    end
    
    return tab
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
