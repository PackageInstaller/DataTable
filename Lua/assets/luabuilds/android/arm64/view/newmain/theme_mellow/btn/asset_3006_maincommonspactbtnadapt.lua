local MainCommonSpActBtnAdapt = class("MainCommonSpActBtnAdapt")

function MainCommonSpActBtnAdapt:Ctor(arg_1_1)
	self.spActBtn = arg_1_1

	pg.DelegateInfo.New(self)
	setmetatable(self, {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = rawget(arg_2_0, "class")

			return (var_2_0[arg_2_1] or nil) and (var_2_0[arg_2_1] or self.spActBtn[arg_2_1])
		end
	})

	return
end

function MainCommonSpActBtnAdapt:GetUIName()
	return self.spActBtn:GetUIName()
end

function MainCommonSpActBtnAdapt:Dispose()
	pg.DelegateInfo.Dispose(self)
	self.spActBtn:Dispose()

	self.spActBtn = nil

	return
end

return MainCommonSpActBtnAdapt
