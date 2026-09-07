local MainChangeSkinView = class("MainChangeSkinView", import("...base.MainBaseView"))

function MainChangeSkinView:Ctor(arg_1_1, arg_1_2)
	MainChangeSkinView.super.Ctor(self, arg_1_1, arg_1_2)

	self._changeSkinToggle = ChangeSkinToggle.New(findTF(arg_1_1, "toggleUI"))

	self._changeSkinToggle:SetAsmrTurnning(true)

	self.inChange = false
	self._parentTF = self._tf.parent
	self._anchoredPosition = self._tf.anchoredPosition

	onButton(self, findTF(self._tf, "click"), function()
		if self.inChange then
			return
		end

		if self._changeSkinToggle:IsAsmrSkin() then
			getProxy(SettingsProxy):setCharacterSetting(self._flagShip.id, SHIP_FLAG_L2D, true)
			getProxy(SettingsProxy):setCharacterSetting(self._flagShip.id, SHIP_FLAG_SP, true)
		end

		self.inChange = true

		self.event:emit(NewMainMediator.CHANGE_SKIN_TOGGLE, {
			skin_id = self._flagShip:getSkinId()
		})

		return
	end, SFX_CONFIRM)

	return
end

function MainChangeSkinView:Init(arg_3_1)
	self._flagShip = arg_3_1

	self:updateUI()

	return
end

function MainChangeSkinView:Refresh(arg_4_1)
	self.inChange = false
	self._flagShip = arg_4_1

	self:updateUI()

	return
end

function MainChangeSkinView:updateUI()
	local var_5_0 = self._flagShip:getSkinId()
	local var_5_1 = ShipSkin.GetChangeSkinGroupId(var_5_0)

	if not var_5_1 then
		setActive(self._tf, false)
	else
		setActive(self._tf, true)
	end

	if self._changeSkinToggle and var_5_1 and var_5_1 > 0 then
		self._changeSkinToggle:setShipData(var_5_0, self._flagShip:GetShipPhantomMark())
	end

	if self._asmrTurnningParent then
		if ShipSkin.GetChangeSkinCustomDataId(var_5_0, "asmr") == 1 then
			setParent(self._tf, self._asmrTurnningParent)

			self._tf.anchoredPosition = Vector2(0, 0)
		else
			setParent(self._tf, self._parentTF)

			self._tf.anchoredPosition = self._anchoredPosition
		end
	end

	return
end

function MainChangeSkinView:SetAsmrTurnningParent(arg_6_1)
	self._asmrTurnningParent = arg_6_1

	return
end

function MainChangeSkinView:Dispose()
	MainChangeSkinView.super.Dispose(self)

	self._asmrTurnningParent = nil

	return
end

return MainChangeSkinView
