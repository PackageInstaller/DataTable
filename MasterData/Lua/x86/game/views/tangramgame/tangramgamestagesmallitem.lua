local TangramGameStageSmallItem = class("TangramGameStageSmallItem", ReduxView)

function TangramGameStageSmallItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function TangramGameStageSmallItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.lockController = self.showController:GetController("lock")
end

function TangramGameStageSmallItem:AddUIListener()
	self:AddPressByTimeListener(self.buttonBtn_.gameObject, GameDisplayCfg.dorm_area_swap_time.value[1], function()
		if self.clickFunc then
			self.clickFunc(self.roomID, self.oriPos)
		end
	end, function(arg_5_0, arg_5_1, arg_5_2)
		if self.startDrag then
			self:startDrag()
		end
	end, function(arg_6_0, arg_6_1, arg_6_2)
		if self.endDrag then
			self:endDrag()
		end
	end, self.oriPos)
	self:AddDragListener(self.buttonBtn_.gameObject, function()
		return
	end, function()
		if self.onDrag then
			self:onDrag()
		end
	end, function()
		return
	end)
end

function TangramGameStageSmallItem:RefreshUI(arg_10_1)
	self.stageID = arg_10_1

	if self.stageID then
		local var_10_0, var_10_1 = TangramGameTools:CheckStageIsOpen(self.stageID)

		if var_10_0 then
			self.lockController:SetSelectedState("false")
		else
			self.lockController:SetSelectedState("true")
		end
	end
end

function TangramGameStageSmallItem:RegisterStartDrag(arg_11_1)
	if arg_11_1 then
		self.startDrag = arg_11_1
	end
end

function TangramGameStageSmallItem:RegisterOnDrag(arg_12_1)
	if arg_12_1 then
		self.onDrag = arg_12_1
	end
end

function TangramGameStageSmallItem:RegisterEndDrag(arg_13_1)
	if arg_13_1 then
		self.endDrag = arg_13_1
	end
end

function TangramGameStageSmallItem:Dispose()
	TangramGameStageSmallItem.super.Dispose(self)
end

return TangramGameStageSmallItem
