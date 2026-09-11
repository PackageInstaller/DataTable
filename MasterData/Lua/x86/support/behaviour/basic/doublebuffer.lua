local DoubleBuffer = class("DoubleBuffer", (import("..BehaviourBase")))
local var_0_1 = 0

function DoubleBuffer:Ctor()
	return
end

function DoubleBuffer:Next()
	return 1 - var_0_1
end

function DoubleBuffer:Swap()
	var_0_1 = DoubleBuffer.Next()
end

function DoubleBuffer:OnBind_()
	self:ExportMethods_({
		"Next"
	})

	return self.target_
end

function DoubleBuffer:OnUnbind_()
	return
end

return DoubleBuffer
