local MainSpineIcon = class("MainSpineIcon", import(".MainBaseIcon"))

function MainSpineIcon:Resume()
	if self.spineChar and self.spineChar:GetPauseStatue() ~= nil and not IsNil(self.spineChar:GetAnimationState()) then
		self.spineChar:Resume()
	end

	return
end

function MainSpineIcon:Pause()
	if self.spineChar and self.spineChar:GetPauseStatue() ~= nil and not IsNil(self.spineChar:GetAnimationState()) then
		self.spineChar:Pause()
	end

	return
end

function MainSpineIcon:Load(arg_3_1)
	self.loading = true
	self.spineChar = SpineAnimChar.New()

	self.spineChar:SetPaint(arg_3_1)
	self.spineChar:Load(true, function(arg_4_0)
		if self.exited then
			self:Unload()

			return
		end

		self.loading = false
		self.shipModel = arg_4_0:GetModel()

		LeanTween.cancel(self.shipModel)
		arg_4_0:SetNormalAction("normal")
		arg_4_0:SetAction("normal", 0)
		arg_4_0:SetLocalScale(Vector3(0.75, 0.75, 1))

		local var_4_0 = pg.ship_spine_shift[arg_3_1]
		local var_4_1

		if pg.ship_spine_shift[arg_3_1] then
			var_4_1 = var_4_0.mainui_shift[1] or 0

			local var_4_2

			if var_4_0 then
				var_4_2 = var_4_0.mainui_shift[2] or 0
			end
		end

		local var_4_3 = -130 + var_4_2

		arg_4_0:SetParent(self._tf)
		arg_4_0:SetLocalPosition(Vector3(var_4_1, var_4_3, 0))
		onNextTick(function()
			arg_4_0:Resume()

			return
		end)

		return
	end)

	self.name = arg_3_1

	return
end

function MainSpineIcon:Unload()
	if self.spineChar then
		self.spineChar:Resume()
		self.spineChar:Dispose()

		self.spineChar = nil
	end

	self.name = nil
	self.shipModel = nil
	self.spineAnim = nil

	return
end

return MainSpineIcon
