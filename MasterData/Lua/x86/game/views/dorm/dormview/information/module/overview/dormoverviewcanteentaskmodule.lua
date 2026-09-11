local DormOverviewCanteenTaskModule = class("DormOverviewCanteenTaskModule", ReduxView)

function DormOverviewCanteenTaskModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function DormOverviewCanteenTaskModule:InitUI()
	self.levelmap = {
		"B",
		"A",
		"S"
	}

	self:BindCfgUI()
	self:AddBtnListener(self.btn, nil, function()
		JumpTools.OpenPageByJump("/dormTaskDispatchView", {
			roomID = DormConst.CANTEEN_ID
		})
	end)

	self.stateController = self.controller:GetController("stata")
	self.levelController = self.controller:GetController("level")
end

function DormOverviewCanteenTaskModule:Render(arg_4_1)
	self:UnbindRedPoint()

	self.pos = arg_4_1.pos
	self.entrust = arg_4_1

	self.levelController:SetSelectedState(self.levelmap[BackHomeCanteenTaskCfg[arg_4_1.id].task_level])

	self.heroList = arg_4_1.hero_list

	if #self.heroList > 0 then
		local var_4_0 = false

		for iter_4_0, iter_4_1 in ipairs((CanteenEntrustData:CheckHasTimeOverEntrust())) do
			if iter_4_1 == self.pos then
				self:BindRedPoint()

				var_4_0 = true
			end
		end

		self.stateController:SetSelectedState(var_4_0 and "finish" or "sending")
	else
		self.stateController:SetSelectedState("delegable")
	end

	DormRedPointTools:UpdateCanteenNotify()
end

function DormOverviewCanteenTaskModule:BindRedPoint()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.CANTEEN_DISPATCH_FINISHED, self.pos))
end

function DormOverviewCanteenTaskModule:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.CANTEEN_DISPATCH_FINISHED, self.pos))
end

function DormOverviewCanteenTaskModule:Dispose()
	self:UnbindRedPoint()
	DormOverviewCanteenTaskModule.super.Dispose(self)
end

return DormOverviewCanteenTaskModule
