local MainOpenSystemSequence = class("MainOpenSystemSequence")

function MainOpenSystemSequence:Execute(arg_1_1)
	pg.SystemOpenMgr.GetInstance():notification(getProxy(PlayerProxy):getRawData().level)
	arg_1_1()

	return
end

return MainOpenSystemSequence
