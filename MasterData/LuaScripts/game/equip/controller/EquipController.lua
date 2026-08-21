module("equip.EquipController", Class.impl(Controller))

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    
    local mgr = equip.EquipSkillManager
    if mgr and mgr.resetData then
        mgr:resetData()
    end

    mgr = equip.EquipManager
    if mgr and mgr.resetData then
        mgr:resetData()
    end

    mgr = equip.EquipSuitManager
    if mgr and mgr.resetData then
        mgr:resetData()
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
