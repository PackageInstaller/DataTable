local ShipProfileSkinBtn = class("ShipProfileSkinBtn")

function ShipProfileSkinBtn:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.sctxt = self._tf:Find("mask/Text"):GetComponent("ScrollText")
	self.lockTF = self._tf:Find("lock")
	self.selected = self._tf:Find("selected")
	self.timelimitTF = self._tf:Find("timelimit")
	self.timelimitTxt = self._tf:Find("timelimit/Text"):GetComponent(typeof(Text))

	return
end

function ShipProfileSkinBtn:Update(arg_2_1, arg_2_2, arg_2_3)
	self.shipGroup = arg_2_2

	self.sctxt:SetText(arg_2_1.name)

	if arg_2_1.skin_type ~= ShipSkin.SKIN_TYPE_DEFAULT then
		if not arg_2_3 then
			::label_2_0::

			local var_2_0

			if arg_2_1.skin_type == ShipSkin.SKIN_TYPE_REMAKE then
				var_2_0 = self.shipGroup.trans or not (arg_2_1.skin_type ~= ShipSkin.SKIN_TYPE_PROPOSE or self.shipGroup.married ~= 1)
			end
		end
	end

	self.unlock = var_2_0

	setActive(self.lockTF, not self.unlock)
	self:AddTimer(arg_2_1)

	return
end

function ShipProfileSkinBtn:AddTimer(arg_3_1)
	local var_3_0 = getProxy(ShipSkinProxy):getSkinById(arg_3_1.id)
	local var_3_1 = var_3_0 and var_3_0:isExpireType() and not var_3_0:isExpired()

	setActive(self.timelimitTF, var_3_1)
	self:RemoveTimer()

	if var_3_1 then
		self.timer = Timer.New(function()
			self.timelimitTxt.text = skinTimeStamp(var_3_0:getRemainTime())

			return
		end, 1, -1)

		self.timer:Start()
		self.timer.func()
	end

	return
end

function ShipProfileSkinBtn:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function ShipProfileSkinBtn:Shift()
	setActive(self.selected, true)

	return
end

function ShipProfileSkinBtn:UnShift()
	setActive(self.selected, false)

	return
end

function ShipProfileSkinBtn:Dispose()
	self:RemoveTimer()

	return
end

return ShipProfileSkinBtn
