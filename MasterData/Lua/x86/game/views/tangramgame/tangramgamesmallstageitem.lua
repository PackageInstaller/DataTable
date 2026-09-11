local TangramGameSmallstageItem = class("TangramGameSmallstageItem", ReduxView)

function TangramGameSmallstageItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.decodeView = arg_1_2

	self:InitUI()
end

function TangramGameSmallstageItem:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.stateController = self.controller_:GetController("default0")
end

function TangramGameSmallstageItem:AddUIListener()
	self:AddPonitListener(self.iconImg_.gameObject, function()
		if self.RayPointFunc then
			self:RayPointFunc()
		end
	end, function()
		return
	end)
	self:AddPressByTimeListener(self.iconImg_.gameObject, 0.4, function()
		return
	end, function(arg_7_0, arg_7_1, arg_7_2)
		if self.startDragFunc then
			self:startDragFunc(arg_7_1)
		end
	end, function(arg_8_0, arg_8_1, arg_8_2)
		if self.endDragFunc then
			self:endDragFunc(arg_8_1)
		end
	end)
	self:AddDragListener(self.iconImg_.gameObject, function()
		return
	end, function()
		if self.onDragFunc then
			self:onDragFunc()
		end
	end, function()
		return
	end)
	self:AddBtnListener(self.iconBtn_, nil, function()
		if self.onClickFunc then
			self:onClickFunc()
		end
	end)
end

function TangramGameSmallstageItem:RefreshUI(arg_13_1)
	self.stageID = arg_13_1
	self.iconImg_.sprite = getSpriteViaConfig("TangramGameStageIcon", arg_13_1)
	self.index = TangramGameData:GetStageIDinListIndex(arg_13_1)

	if self.index then
		SetActive(self.gameObject_, true)

		if self.moveFunc then
			self.moveFunc(self.index, self, false)
		end

		if self.decodeView.fiexdPosList[self.index] then
			self.stateController:SetSelectedState("state1")
		else
			self.stateController:SetSelectedState("state0")
		end
	else
		SetActive(self.gameObject_, false)
	end
end

function TangramGameSmallstageItem:AddItemMoveFunc(arg_14_1)
	self.moveFunc = arg_14_1
end

function TangramGameSmallstageItem:AddStartDrag(arg_15_1)
	self.startDragFunc = arg_15_1
end

function TangramGameSmallstageItem:AddOnDrag(arg_16_1)
	self.onDragFunc = arg_16_1
end

function TangramGameSmallstageItem:EndDrag(arg_17_1)
	self.endDragFunc = arg_17_1
end

function TangramGameSmallstageItem:RayPoint(arg_18_1)
	self.RayPointFunc = arg_18_1
end

function TangramGameSmallstageItem:AddOnClick(arg_19_1)
	self.onClickFunc = arg_19_1
end

function TangramGameSmallstageItem:Dispose()
	TangramGameSmallstageItem.super.Dispose(self)
end

return TangramGameSmallstageItem
