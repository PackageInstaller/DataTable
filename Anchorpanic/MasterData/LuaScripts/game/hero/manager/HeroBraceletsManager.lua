module("hero.HeroBraceletsManager", Class.impl(Manager))

-------------------- 界面操作事件 --------------------
BRACELETS_BAG_EQUIP_SELECT = "BRACELETS_BAG_EQUIP_SELECT"

--选择
BRACELETS_SELECT_CHANGE = "BRACELETS_SELECT_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

function __init(self)
end

--析构函数
function dtor(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
