local IslandOrderSlot = class("IslandOrderSlot")

IslandOrderSlot.STATE_EMPTY = 1
IslandOrderSlot.STATE_NORMAL = 2
IslandOrderSlot.STATE_LOADING = 3
IslandOrderSlot.STATE_CAN_FINISH = 4
IslandOrderSlot.SHOW_FLAG_TODAY = 0
IslandOrderSlot.SHOW_FLAG_TOMORROW = 1
IslandOrderSlot.TENDENCY_TYPE_COMMON = 0
IslandOrderSlot.TENDENCY_TYPE_EASY = 1
IslandOrderSlot.TENDENCY_TYPE_HARD = 2

function IslandOrderSlot:TENDENCY2TIP()
	IslandOrderSlot.TENDENCY_2_TIP = IslandOrderSlot.TENDENCY_2_TIP or {
		i18n("island_order_desc_1"),
		i18n("island_order_desc_2"),
		i18n("island_order_desc_3")
	}

	return IslandOrderSlot.TENDENCY_2_TIP[self + 1]
end

function IslandOrderSlot:TENDENCY2CN()
	IslandOrderSlot.TENDENCY_2_CN = IslandOrderSlot.TENDENCY_2_CN or {
		i18n("island_order_difficulty_1"),
		i18n("island_order_difficulty_2"),
		i18n("island_order_difficulty_3")
	}

	return IslandOrderSlot.TENDENCY_2_CN[self + 1]
end

function IslandOrderSlot:Ctor(arg_3_1)
	self:Flush(arg_3_1)

	return
end

function IslandOrderSlot:Flush(arg_4_1)
	self.id = arg_4_1.id
	self.position = arg_4_1.position
	self.order = self:GenOrder(arg_4_1)

	return
end

function IslandOrderSlot:GenOrder(arg_5_1)
	if arg_5_1.type == IslandOrder.TYPE_NORMAL then
		return IslandOrder.New(arg_5_1)
	elseif arg_5_1.type == IslandOrder.TYPE_URGENCY then
		return IslandUrgencyOrder.New(arg_5_1)
	elseif arg_5_1.type == IslandOrder.TYPE_FORM then
		if pg.island_order[arg_5_1.id].type == IslandFirmOrder.FIRM_ORDER_TYPE_URGENCY then
			return IslandFirmUrgencyOrder.New(arg_5_1)
		elseif pg.island_order[arg_5_1.id].type == IslandFirmOrder.FIRM_ORDER_TYPE_ACT then
			return IslandFirmActivityOrder.New(arg_5_1)
		elseif pg.island_order[arg_5_1.id].type == IslandFirmOrder.FIRM_ORDER_TYPE_COMMON then
			return IslandFirmOrder.New(arg_5_1)
		else
			assert(false, "typ is nil" .. pg.island_order[arg_5_1.id].type)
		end
	end

	assert(false, "order should be exist" .. arg_5_1.type)

	return
end

function IslandOrderSlot:GetPosition()
	return Vector3(pg.island_order_position[(pg.island_order_position[self.position] or nil) and (self.position or 1)].position[1], pg.island_order_position[(pg.island_order_position[self.position] or nil) and (self.position or 1)].position[2], 0)
end

function IslandOrderSlot:GetState()
	if self:IsLoading() then
		return IslandOrderSlot.STATE_LOADING
	end

	if self:IsEmpty() then
		return IslandOrderSlot.STATE_EMPTY
	end

	if self:CanSubmit() then
		return IslandOrderSlot.STATE_CAN_FINISH
	end

	return IslandOrderSlot.STATE_NORMAL
end

function IslandOrderSlot:GetCanSubmitTime()
	return self.order:GetCanSubmitTime()
end

function IslandOrderSlot:GetDisappearTime()
	return self.order:GetDisappearTime()
end

function IslandOrderSlot:GetTotalTime()
	return self.order:GetTotalTime()
end

function IslandOrderSlot:CanSubmit()
	if self:IsEmpty() then
		return false
	end

	if self:IsLoading() then
		return false
	end

	return self.order:CanFinish()
end

function IslandOrderSlot:IsEmpty()
	return self.order:IsEmpty()
end

function IslandOrderSlot:IsLoading()
	return self.order:IsLoading()
end

function IslandOrderSlot:CanReplace()
	return self.order:CanReplace()
end

function IslandOrderSlot:GetOrder()
	return self.order
end

function IslandOrderSlot:SetReduceTime(arg_16_1)
	self.order:SetReduceTime(arg_16_1)

	return
end

function IslandOrderSlot:AddReduceTime(arg_17_1)
	self.order:AddReduceTime(arg_17_1)

	return
end

return IslandOrderSlot
