local MainOverDueAttireSequence = class("MainOverDueAttireSequence")

function MainOverDueAttireSequence:Execute(arg_1_1)
	local var_1_0 = getProxy(AttireProxy):getExpiredChaces()

	if #var_1_0 > 0 then
		self:Display(AttireExpireDisplayPage, var_1_0, arg_1_1)
	else
		arg_1_1()
	end

	return
end

function MainOverDueAttireSequence:Display(arg_2_1, arg_2_2, arg_2_3)
	self.page = arg_2_1.New(pg.UIMgr.GetInstance().UIMain)

	function self.page.Hide()
		self:Clear()
		arg_2_3()

		return
	end

	self.page:ExecuteAction("Show", arg_2_2)

	return
end

function MainOverDueAttireSequence:Clear()
	if self.page then
		self.page:Destroy()

		self.page = nil
	end

	return
end

function MainOverDueAttireSequence:Dispose()
	self:Clear()

	return
end

return MainOverDueAttireSequence
