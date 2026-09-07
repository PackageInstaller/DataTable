local CourtYardBaseSubPage = class("CourtYardBaseSubPage")

CourtYardBaseSubPage.STATES = {
	LOADED = 3,
	DESTROY = 5,
	LOADING = 2,
	INITED = 4,
	NONE = 1
}

function CourtYardBaseSubPage:Ctor(arg_1_1, arg_1_2)
	self.contextData = arg_1_2
	self.parent = arg_1_1
	self._parentTf = arg_1_1._tf
	self._go = nil
	self._tf = nil
	self._state = CourtYardBaseSubPage.STATES.NONE
	self._funcQueue = {}

	return
end

function CourtYardBaseSubPage:Load()
	if self._state ~= CourtYardBaseSubPage.STATES.NONE then
		return
	end

	self._state = CourtYardBaseSubPage.STATES.LOADING

	pg.UIMgr.GetInstance():LoadingOn()

	local var_2_0 = PoolMgr.GetInstance()

	var_2_0:GetUI(self:getUIName(), true, function(arg_3_0)
		if self._state == CourtYardBaseSubPage.STATES.DESTROY then
			pg.UIMgr.GetInstance():LoadingOff()
			var_2_0:ReturnUI(self:getUIName(), arg_3_0)
		else
			self:Loaded(arg_3_0)
			self:Init()
		end

		return
	end)

	return
end

function CourtYardBaseSubPage:Loaded(arg_4_1)
	pg.UIMgr.GetInstance():LoadingOff()

	if self._state ~= CourtYardBaseSubPage.STATES.LOADING then
		return
	end

	self._state = CourtYardBaseSubPage.STATES.LOADED
	self._go = arg_4_1
	self._tf = tf(arg_4_1)

	pg.DelegateInfo.New(self)
	SetParent(self._tf, self._parentTf, false)
	self:OnLoaded()

	return
end

function CourtYardBaseSubPage:Init()
	if self._state ~= CourtYardBaseSubPage.STATES.LOADED then
		return
	end

	self._state = CourtYardBaseSubPage.STATES.INITED

	self:OnInit()
	self:HandleFuncQueue()

	return
end

function CourtYardBaseSubPage:Destroy()
	if self._state == CourtYardBaseSubPage.STATES.DESTROY then
		return
	end

	if not self:GetLoaded() then
		self._state = CourtYardBaseSubPage.STATES.DESTROY

		return
	end

	self._state = CourtYardBaseSubPage.STATES.DESTROY

	pg.DelegateInfo.Dispose(self)
	self:OnDestroy()

	self._tf = nil

	local var_6_0 = self:getUIName()

	if self._go ~= nil and var_6_0 then
		PoolMgr.GetInstance():ReturnUI(var_6_0, self._go)

		self._go = nil
	end

	return
end

function CourtYardBaseSubPage:HandleFuncQueue()
	if self._state == CourtYardBaseSubPage.STATES.INITED then
		while #self._funcQueue > 0 do
			local var_7_0 = table.remove(self._funcQueue, 1)

			var_7_0.func(unpack(var_7_0.params, 1, var_7_0.params.len))
		end
	end

	return
end

function CourtYardBaseSubPage:Reset()
	self._state = CourtYardBaseSubPage.STATES.NONE

	return
end

function CourtYardBaseSubPage:ActionInvoke(arg_9_1, ...)
	assert(self[arg_9_1], "func not exist >>>" .. arg_9_1)

	self._funcQueue[#self._funcQueue + 1] = {
		funcName = arg_9_1,
		func = self[arg_9_1],
		params = {
			len = 1 + select("#", ...),
			self,
			...
		}
	}

	self:HandleFuncQueue()

	return
end

function CourtYardBaseSubPage:CallbackInvoke(arg_10_1, ...)
	self._funcQueue[#self._funcQueue + 1] = {
		func = arg_10_1,
		params = packEx(...)
	}

	self:HandleFuncQueue()

	return
end

function CourtYardBaseSubPage:ExecuteAction(arg_11_1, ...)
	self:Load()
	self:ActionInvoke(arg_11_1, ...)

	return
end

function CourtYardBaseSubPage:GetLoaded()
	return self._state >= CourtYardBaseSubPage.STATES.LOADED
end

function CourtYardBaseSubPage:CheckState(arg_13_1)
	return self._state == arg_13_1
end

function CourtYardBaseSubPage:Show()
	setActive(self._tf, true)

	return
end

function CourtYardBaseSubPage:Hide()
	setActive(self._tf, false)

	return
end

function CourtYardBaseSubPage:isShowing()
	return self._tf and isActive(self._tf)
end

function CourtYardBaseSubPage:Emit(arg_17_1, ...)
	self.parent:Emit(arg_17_1, ...)

	return
end

function CourtYardBaseSubPage:getTpl(arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2:Find(arg_18_1)

	var_18_0:SetParent(self._tf, false)
	SetActive(var_18_0, false)

	return var_18_0
end

function CourtYardBaseSubPage:getUIName()
	return nil
end

function CourtYardBaseSubPage:OnLoaded()
	return
end

function CourtYardBaseSubPage:OnInit()
	return
end

function CourtYardBaseSubPage:OnDestroy()
	return
end

return CourtYardBaseSubPage
