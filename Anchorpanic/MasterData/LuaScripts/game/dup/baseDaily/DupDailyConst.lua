--[[ 
-----------------------------------------------------
@filename       : DupDailyConst
@Description    : 物资Const
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module("dup.DupDailyConst", Class.impl())
DUPEXP = 1 -- 经验副本
DUPMONEY = 2 -- 金币副本
DUPHEROSTARUP = 3 -- 晋升材料副本
DUPEQUIPTUPO = 4--芯片突破
DUPHEROGROWUP = 5--增幅材料
DUPBRACELETS = 6--手环材料
DUPHEROSKILL = 7--技能副本

function getTabList(self)
    local tab = {}

    for i, vo in ipairs(dup.DupDailyMainManager:getDupEntryList()) do
        tab[i] = { page = i, nomalLan = vo:getName(), nomalLanEn = "", funcId = vo.funcId }
    end

    return tab
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
