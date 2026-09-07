local ShipLoad = class("ShipLoad")

function ShipLoad:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.meshImageList = {}
	self.meshCallback = arg_1_1
	self.l2dCallback = arg_1_2
	self.spineCallback = arg_1_3

	return
end

function ShipLoad:LoadShip(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0, var_2_1, var_2_2 = self:GetShipPaintingName(arg_2_1)

	if self.spineCallback and MainPaintingView.Live2dIsDownload(var_2_1) and checkABExist(var_2_1) then
		if self.live2dClass then
			self.live2dClass:Dispose()

			self.live2dClass = nil
		end

		self.live2dClass = Live2DPainting.New(Live2DPainting.GenerateData(arg_2_2), function(arg_3_0)
			if self.exit == true then
				return
			end

			self.l2dCallback(arg_3_0)

			return
		end)
	elseif self.l2dCallback and checkABExist(var_2_2) then
		if self.spinePaintingClass then
			self.spinePaintingClass:Dispose()

			self.spinePaintingClass = nil
		end

		self.spinePaintingClass = SpinePainting.New(SpinePainting.GenerateData(arg_2_3), function(arg_4_0)
			if self.exit == ture then
				return
			end

			self.spineCallback(arg_4_0)

			return
		end)
	else
		self:LoadMeshShip(arg_2_1, self.meshCallback)
	end

	return
end

function ShipLoad:LoadMeshShip(arg_5_1, arg_5_2)
	local var_5_0 = self:GetShipPaintingName(arg_5_1)

	PoolMgr:GetInstance():GetPainting(var_5_0, true, function(arg_6_0)
		if self.exit then
			self:ReturnPainting(arg_5_1)

			return
		end

		self.meshImageList[var_5_0] = arg_6_0

		arg_5_2(arg_6_0)

		return
	end)

	return
end

function ShipLoad:ReturnPainting(arg_7_1)
	local var_7_0 = self:GetShipPaintingName(arg_7_1)

	PoolMgr.GetInstance():ReturnPainting(self.paintingName, self.actorPainting)

	return
end

function ShipLoad:GetLive2dClass()
	return self.live2dClass
end

function ShipLoad:GetSpinePaintingClass()
	return self.spinePaintingClass
end

function ShipLoad:GetShipPaintingName(arg_10_1)
	local var_10_0 = getProxy(BayProxy):getShipById(arg_10_1):getPainting()
	local var_10_2 = HXSet.autoHxShiftPath((self:IsHideMeshBg(var_10_0) or nil) and string.format("%s_n", var_10_0))

	return var_10_2, HXSet.autoHxShiftPath(string.format("live2d/%s", var_10_2)), (HXSet.autoHxShiftPath(string.format("spinepainting/%s", var_10_2)))
end

function ShipLoad:IsHideMeshBg(arg_11_1)
	return checkABExist(string.format("painting/%s_n", arg_11_1)) and PlayerPrefs.GetInt(string.format("paint_hide_other_obj_%s", arg_11_1), 0) ~= 0
end

function ShipLoad:ClearShip()
	for iter_12_0, iter_12_1 in pairs(self.meshImageList) do
		PoolMgr.GetInstance():ReturnPainting(iter_12_0, iter_12_1)
	end

	self.meshImageList = {}

	if self.live2dClass then
		self.live2dClass:Dispose()

		self.live2dClass = nil
	end

	if self.spinePaintingClass then
		self.spinePaintingClass:Dispose()

		self.spinePaintingClass = nil
	end

	return
end

function ShipLoad:Dispose()
	self.exit = true

	self:ClearShip()

	return
end

return ShipLoad
