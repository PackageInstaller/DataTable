local GuildBasePage = class("GuildBasePage", import("...base.BaseSubView"))

function GuildBasePage:getUIName()
	local var_1_0, var_1_1 = self:getTargetUI()
	local var_1_2 = getProxy(GuildProxy):getRawData()

	if not var_1_2 then
		return self.uiname
	end

	local var_1_3 = var_1_2:getFaction()

	if var_1_3 == GuildConst.FACTION_TYPE_BLHX then
		self.uiname = var_1_0
	elseif var_1_3 == GuildConst.FACTION_TYPE_CSZZ then
		self.uiname = var_1_1
	end

	return self.uiname
end

function GuildBasePage:getTargetUI()
	assert(false)

	return
end

function GuildBasePage:Destroy()
	if self._state == GuildBasePage.STATES.DESTROY then
		return
	end

	if not self:GetLoaded() then
		self._state = GuildBasePage.STATES.DESTROY

		return
	end

	self._state = GuildBasePage.STATES.DESTROY

	pg.DelegateInfo.Dispose(self)
	self:OnDestroy()
	self:disposeEvent()
	self:cleanManagedTween()

	self._tf = nil

	if self._go ~= nil and self.uiname then
		PoolMgr.GetInstance():ReturnUI(self.uiname, self._go)

		self._go = nil
	end

	return
end

return GuildBasePage
