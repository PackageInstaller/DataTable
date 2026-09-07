local CourtYardRightPanel = class("CourtYardRightPanel", import(".CourtYardBasePanel"))

function CourtYardRightPanel:GetUIName()
	return "main/rightPanel"
end

function CourtYardRightPanel:init()
	self.buffBtn = self._tf:Find("buff")
	self.oneKeyBtn = self._tf:Find("onekey")
	self.buffPage = CourtYardBuffPage.New(self._tf.parent.parent, self.parent)

	return
end

function CourtYardRightPanel:GenBuffData()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(BuffHelper.GetBackYardPlayerBuffs()) do
		if iter_3_1:isActivate() then
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function CourtYardRightPanel:OnRegister()
	onButton(self, self.buffBtn, function()
		local var_5_0 = self.buffList or self:GenBuffData()

		if #var_5_0 > 0 then
			self.buffPage:ExecuteAction("Show", var_5_0)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.oneKeyBtn, function()
		self:emit(CourtYardMediator.ONE_KEY)

		return
	end, SFX_PANEL)

	return
end

function CourtYardRightPanel:OnVisitRegister()
	setActive(self._tf, false)

	return
end

function CourtYardRightPanel:OnFlush(arg_8_1)
	arg_8_1 = arg_8_1 or bit.bor(BackYardConst.DORM_UPDATE_TYPE_LEVEL, BackYardConst.DORM_UPDATE_TYPE_USEFOOD, BackYardConst.DORM_UPDATE_TYPE_SHIP)

	local var_8_0 = self.dorm

	if bit.band(arg_8_1, BackYardConst.DORM_UPDATE_TYPE_USEFOOD) > 0 and self:IsInner() then
		self.buffList = self:GenBuffData()

		setActive(self.buffBtn, #self.buffList > 0)
	end

	if bit.band(arg_8_1, BackYardConst.DORM_UPDATE_TYPE_SHIP) > 0 then
		setActive(self.oneKeyBtn, var_8_0:AnyShipExistIntimacyOrMoney())
	end

	return
end

function CourtYardRightPanel:GetMoveX()
	return {
		{
			self._tf,
			1
		}
	}
end

function CourtYardRightPanel:OnDispose()
	if self.buffPage then
		self.buffPage:Destroy()

		self.buffPage = nil
	end

	return
end

return CourtYardRightPanel
