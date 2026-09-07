local SpineCellView = import(".SpineCellView")
local FleetCellView = class("FleetCellView", DecorateClass(import(".DynamicCellView"), SpineCellView))

function FleetCellView:Ctor(arg_1_1)
	FleetCellView.super.Ctor(self, arg_1_1)
	SpineCellView.Ctor(self)
	SpineCellView.InitCellTransform(self)

	self.tfArrow = self.tf:Find("arrow")
	self.tfAmmo = self.tf:Find("ammo")
	self.tfAmmoText = self.tfAmmo:Find("text")
	self.tfOp = self.tf:Find("op")
	self.tfIconRecorded = nil
	self.RecordedFlag = nil

	return
end

function FleetCellView:GetOrder()
	return ChapterConst.CellPriorityFleet
end

function FleetCellView:showPoisonDamage(arg_3_1)
	local var_3_0 = self.tfShip.localPosition

	self:GetLoader():GetPrefab("ui/" .. "dexiv4_SLG_poison", "dexiv4_SLG_poison", function(arg_4_0)
		setParent(arg_4_0.transform, self.tf, false)
		LeanTween.moveY(self.tfShip, var_3_0.y - 10, 0.1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

		local var_4_0 = arg_4_0:GetComponent(typeof(ParticleSystemEvent))

		if not IsNil(var_4_0) then
			var_4_0:AddEndEvent(function()
				self.tfShip.localPosition = var_3_0

				self.loader:ClearRequest("PoisonDamage")
				LeanTween.cancel(self.tfShip.gameObject)

				if arg_3_1 then
					arg_3_1()
				end

				return
			end)
		end

		return
	end, "PoisonDamage")

	return
end

function FleetCellView:SetActiveNoPassIcon(arg_6_1)
	if not arg_6_1 then
		if self.loader then
			self.loader:ClearRequest("NoPassIcon")
		end
	else
		if self:GetLoader():GetRequestPackage("NoPassIcon") then
			return
		end

		self:GetLoader():GetPrefabBYStopLoading("boxprefab/" .. "event_task_small", "event_task_small", function(arg_7_0)
			setParent(arg_7_0.transform, self.tf, false)
			setLocalPosition(arg_7_0, Vector3(0, 150, 0))
			LeanTween.moveY(rtf(arg_7_0), 150 - 10, 1):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()

			return
		end, "NoPassIcon")
	end

	return
end

function FleetCellView:UpdateIconRecordedFlag(arg_8_1)
	self.RecordedFlag = arg_8_1

	self:UpdateIconRecorded()

	return
end

function FleetCellView:UpdateIconRecorded()
	if not (self.RecordedFlag and self.visible) then
		if not IsNil(self.tfIconRecorded) then
			setActive(self.tfIconRecorded, false)
		end
	else
		if IsNil(self.tfIconRecorded) then
			pg.PoolMgr.GetInstance():GetPrefab("effect/fleet_status_recorded", "", false, function(arg_10_0)
				self.tfIconRecorded = tf(arg_10_0)

				setParent(arg_10_0, self.tf, false)

				return
			end)
		end

		setActive(self.tfIconRecorded, true)
	end

	return
end

function FleetCellView:TweenShining()
	local var_11_0 = self:GetSpineRole()

	if not var_11_0 then
		return
	end

	local var_11_1 = Color.black

	var_11_1.a = 0
	Color.gray.a = 0

	var_11_0:TweenShining(0.2, 2, 0, 1, var_11_1, Color.gray, true, true)

	return
end

function FleetCellView:SetSpineVisible(arg_12_1)
	self.visible = arg_12_1

	FleetCellView.super.SetSpineVisible(self, arg_12_1)
	setActive(self.tfShadow, arg_12_1)
	self:UpdateIconRecorded()

	return
end

function FleetCellView:StopTween()
	local var_13_0 = self:GetSpineRole()

	if not var_13_0 then
		return
	end

	var_13_0:StopTweenShining()

	return
end

function FleetCellView:unloadSpine()
	FleetCellView.super.UnloadSpine(self)

	return
end

function FleetCellView:OnCanvasUpDate()
	SpineCellView.UpdateSortingOrder(self)

	return
end

function FleetCellView:Clear()
	SpineCellView.ClearSpine(self)
	FleetCellView.super.Clear(self)

	return
end

return FleetCellView
