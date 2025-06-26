module('preFight.PreFightMainMapStagePanel', Class.impl(preFight.BasePanel))

--构造函数
function ctor(self)
	super.ctor(self)
end

function configUI(self)
	super.configUI(self)
end

function active(self)
	super.active(self)
end

function deActive(self)
	super.deActive(self)
end

-- function getItemGoName(self)
-- 	return nil
-- end

function getManager(self)
    return preFight.PreFightMainMapStageManager
end

function getItemName(self)
	return preFight.PreFightMainMapStageItem
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
