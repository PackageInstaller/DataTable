module("preFight.PreFightDupClimbTowerManager", Class.impl(preFight.BaseManager))

--构造函数
function ctor(self)
	super.ctor(self)
end

--析构函数
function dtor(self)
	super.dtor(self)
end

function getBattleType(self)
	return PreFightBattleType.ClimbTowerDup
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
