local MainActivityBtnMellowAdapt = class("MainActivityBtnMellowAdapt")

function MainActivityBtnMellowAdapt:Ctor(arg_1_1)
	self.activityBtn = arg_1_1

	pg.DelegateInfo.New(self)

	self.__cname = arg_1_1.__cname

	setmetatable(self, {
		__index = function(arg_2_0, arg_2_1)
			local var_2_0 = rawget(arg_2_0, "class")

			return (var_2_0[arg_2_1] or nil) and (var_2_0[arg_2_1] or self.activityBtn[arg_2_1])
		end
	})

	return
end

function MainActivityBtnMellowAdapt:UpdatePosition(arg_3_1)
	return
end

function MainActivityBtnMellowAdapt:ResPath()
	return "LinkButton_mellow"
end

function MainActivityBtnMellowAdapt:Dispose()
	pg.DelegateInfo.Dispose(self)
	self.activityBtn:Dispose()

	self.activityBtn = nil

	return
end

return MainActivityBtnMellowAdapt
