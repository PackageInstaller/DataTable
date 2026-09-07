local SpineCellView = class("SpineCellView")

function SpineCellView:Ctor()
	return
end

function SpineCellView:InitCellTransform()
	self.tfShip = self.tf:Find("ship")
	self.tfShadow = self.tf:Find("shadow")

	return
end

function SpineCellView:GetRotatePivot()
	return self.tfShip
end

function SpineCellView:GetAction()
	return self.action
end

function SpineCellView:SetAction(arg_5_1)
	self.action = arg_5_1

	if self.spineRole then
		self.spineRole:SetAction(arg_5_1)
	end

	return
end

function SpineCellView:GetSpineRole()
	return self.spineRole
end

function SpineCellView:LoadSpine(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if self.lastPrefab == arg_7_1 then
		if self.spineRole:CheckInited() then
			existCall(arg_7_4)
		end

		return
	end

	self:UnloadSpine()

	self.lastPrefab = arg_7_1
	self.spineRole = SpineRole.New()

	self.spineRole:SetData(arg_7_1, arg_7_3)
	self.spineRole:Load(function()
		self.spineRole:SetParent(self.tfShip)
		self.spineRole:SetRaycastTarget(false)
		self.spineRole:SetLocalPosition(Vector3.zero)

		if arg_7_2 then
			arg_7_2 = arg_7_2 * 0.01 or 1
		end

		self.spineRole:SetLocalScale(Vector3(0.4 * arg_7_2, 0.4 * arg_7_2, 1))
		self:SetAction(self:GetAction())
		existCall(arg_7_4)

		return
	end, nil, self.spineRole.ORBIT_KEY_SLG)

	return
end

function SpineCellView:UnloadSpine()
	self.lastPrefab = nil

	if self.spineRole then
		self.spineRole:Dispose()

		self.spineRole = nil
	end

	return
end

function SpineCellView:UpdateSortingOrder()
	local var_10_0 = GetComponent(self.tf, typeof(Canvas)).sortingOrder

	return
end

function SpineCellView:SetSpineVisible(arg_11_1)
	if self.spineRole then
		self.spineRole:SetVisible(arg_11_1)
	end

	return
end

function SpineCellView:ClearSpine()
	self:UnloadSpine()

	return
end

return SpineCellView
