--[[ 
-----------------------------------------------------
@filename       : ManualManager
@Description    : 模组
@date           : 2022-2-22 10:25:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualModuleManager", Class.impl(Manager))
--打开界面
OPEN_MODULE_VIEW = "OPEN_MODULE_VIEW"
--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self.moduleInfos = {}
    self.moduleInfos = nil 
end

function __init(self)
    --模组套装列表
    self.moduleInfos = {}
end

-- -------------------------------MSG-----------------------
function parserModuleInfo(self, msg)
    if msg.is_init == 1 then
        self.moduleInfos = msg.equip_suit_list
    else
        for _, v in pairs(msg.equip_suit_list) do
            if not table.indexof(self.moduleInfos, v) then
                table.insert(self.moduleInfos, v)
            end
        end
    end
end
------------------------------------------------------------------------

function getCurLength(self)
    if self.moduleInfos ~= nil then
        return #self.moduleInfos
    end
end

function checkModuleIsUnlock(self, suitId)
    if not self.moduleInfos then
        return false
    end
    return table.indexof(self.moduleInfos, suitId)
end
function getUnlockModuleList(self)
    if self.moduleInfos ~= nil then
        table.sort(self.moduleInfos)
        return self.moduleInfos
    end
end

function getAllHaveNew(self)
    for _, suitVo in ipairs(equip.EquipSuitManager:getSuitConfigList()) do
        if suitVo:getIsNew() then
            return true
        end
    end
    return false
end

function getSelfProgress(self)
    local equipList = equip.EquipSuitManager:getSuitConfigList()
    local hasTarget = 0
    for k, v in pairs(equipList) do
        if self:checkModuleIsUnlock(v.suitId) then
            hasTarget = hasTarget + 1
        end
    end
    return math.floor(hasTarget / #equipList * 100)
end
return _M

--[[ 替换语言包自动生成，请勿修改！
]]