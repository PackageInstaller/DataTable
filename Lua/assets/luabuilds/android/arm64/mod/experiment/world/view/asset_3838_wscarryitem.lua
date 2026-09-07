local WSCarryItem = class("WSCarryItem", import(".WSMapTransform"))

WSCarryItem.Fields = {
	wsMapPath = "table",
	carryItem = "table",
	followList = "table",
	theme = "table",
	fleet = "table",
	active = "boolean"
}
WSCarryItem.Listeners = {
	onUpdate = "Update",
	onMoveEnd = "OnMoveEnd"
}

function WSCarryItem:GetResName()
	return "event_tpl"
end

function WSCarryItem:Setup(arg_2_1, arg_2_2, arg_2_3)
	self.fleet = arg_2_1

	self.fleet:AddListener(WorldMapFleet.EventUpdateLocation, self.onUpdate)

	self.carryItem = arg_2_2

	self.carryItem:AddListener(WorldCarryItem.EventUpdateOffset, self.onUpdate)

	self.theme = arg_2_3

	self:Init()

	return
end

function WSCarryItem:Dispose()
	self.fleet:RemoveListener(WorldMapFleet.EventUpdateLocation, self.onUpdate)
	self.carryItem:RemoveListener(WorldCarryItem.EventUpdateOffset, self.onUpdate)

	if self.wsMapPath then
		self.wsMapPath:RemoveListener(WSMapPath.EventArrived, self.onMoveEnd)
		self.wsMapPath:Dispose()
	end

	WSCarryItem.super.Dispose(self)

	return
end

function WSCarryItem:Init()
	self.transform.name = "carry_item_" .. self.carryItem.id
	self.transform.localEulerAngles = Vector3(-self.theme.angle, 0, 0)

	self:Update()
	self:UpdateActive(self.active or true)
	self:UpdateModelScale(self.carryItem:GetScale())

	return
end

function WSCarryItem:Update(arg_5_1)
	local var_5_1 = self.carryItem
	local var_5_2, var_5_3 = self:GetLocation()

	if not self.isMoving and (arg_5_1 == nil or arg_5_1 == WorldMapFleet.EventUpdateLocation or arg_5_1 == WorldCarryItem.EventUpdateOffset) then
		self.transform.anchoredPosition3D = self.theme:GetLinePosition(var_5_2, var_5_3)
	end

	if arg_5_1 == nil or arg_5_1 == WorldMapFleet.EventUpdateLocation or arg_5_1 == WorldCarryItem.EventUpdateOffset then
		self:SetModelOrder(WorldConst.LOFleet, var_5_2)
	end

	if arg_5_1 == nil then
		local var_5_4 = var_5_1:IsAvatar()
		local var_5_5 = self.transform:Find("char")
		local var_5_6 = self.transform:Find("icon")

		setActive(var_5_5, var_5_4)
		setActive(var_5_6, not var_5_4)

		if var_5_4 then
			self:LoadModel(WorldConst.ModelSpine, var_5_1.config.icon, nil, true, function()
				self.model:SetParent(var_5_5:Find("ship"), false)

				return
			end)
		else
			self:LoadModel(WorldConst.ModelPrefab, WorldConst.ResBoxPrefab .. var_5_1.config.icon, var_5_1.config.icon, true, function()
				self.model:SetParent(var_5_6, false)

				return
			end)
		end

		setActive(self.transform:Find("buffs"), false)
		setActive(self.transform:Find("map_buff"), false)
	end

	return
end

function WSCarryItem:UpdateActive(arg_8_1)
	if self.active ~= arg_8_1 then
		self.active = arg_8_1

		setActive(self.transform, self.active)
	end

	return
end

function WSCarryItem:FollowPath(arg_9_1)
	if not self.wsMapPath then
		self.wsMapPath = WSMapPath.New()

		self.wsMapPath:Setup(self.theme)
		self.wsMapPath:AddListener(WSMapPath.EventArrived, self.onMoveEnd)
	end

	self.followList = self.followList or {}

	table.insert(self.followList, function()
		local var_10_0, var_10_1 = self:GetLocation()

		self.wsMapPath:UpdateObject(self)
		self.wsMapPath:UpdateAction(WorldConst.ActionMove)
		self.wsMapPath:UpdateDirType(WorldConst.DirType2)
		self.wsMapPath:StartMove({
			row = var_10_0,
			column = var_10_1
		}, arg_9_1)

		return
	end)

	if not self.isMoving then
		self:OnMoveEnd()
	end

	return self.wsMapPath
end

function WSCarryItem:OnMoveEnd(arg_11_1)
	if #self.followList > 0 then
		table.remove(self.followList, 1)()
	end

	return
end

function WSCarryItem:GetLocation()
	return self.fleet.row + self.carryItem.offsetRow, self.fleet.column + self.carryItem.offsetColumn
end

return WSCarryItem
