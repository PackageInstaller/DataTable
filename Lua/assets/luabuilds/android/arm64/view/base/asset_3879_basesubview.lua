local BaseSubView = class("BaseSubView", import("view.base.BaseEventLogic"))

BaseSubView.STATES = {
	LOADED = 3,
	DESTROY = 5,
	LOADING = 2,
	INITED = 4,
	NONE = 1
}

function BaseSubView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	BaseSubView.super.Ctor(self, arg_1_2)

	self.contextData = arg_1_3
	self._parentTf = arg_1_1
	self.event = arg_1_2
	self._go = nil
	self._tf = nil
	self._state = BaseSubView.STATES.NONE
	self._funcQueue = {}

	return
end

BaseSubView.InheritFuncs = {
	"getGroupName",
	"Add2Overlay",
	"DelFromOverlay",
	"OverlayPanel",
	"UnOverlayPanel",
	"BlurPanel",
	"TempOverlayPanelPB",
	"TempUnOverlayPanelPB"
}

function BaseSubView:RegisterView(arg_2_1)
	self.viewComponent = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(BaseSubView.InheritFuncs) do
		self[iter_2_1] = self[iter_2_1] or function(arg_3_0, ...)
			return arg_3_0.viewComponent[iter_2_1](arg_3_0.viewComponent, ...)
		end
	end

	return
end

function BaseSubView:Load(arg_4_1)
	if self._state ~= BaseSubView.STATES.NONE then
		return
	end

	self._state = BaseSubView.STATES.LOADING

	pg.UIMgr.GetInstance():LoadingOn()

	local var_4_0 = PoolMgr.GetInstance()

	seriesAsync({
		function(arg_5_0)
			if arg_4_1 then
				self.noReturnPrefab = true

				arg_5_0(arg_4_1)
			else
				var_4_0:GetUI(self:getUIName(), true, arg_5_0)
			end

			return
		end
	}, function(arg_6_0)
		if self._state == BaseSubView.STATES.DESTROY and not self.noReturnPrefab then
			pg.UIMgr.GetInstance():LoadingOff()
			var_4_0:ReturnUI(self:getUIName(), arg_6_0)
		else
			self:Loaded(arg_6_0)
			self:Init()
		end

		return
	end)

	return
end

function BaseSubView:Loaded(arg_7_1)
	pg.UIMgr.GetInstance():LoadingOff()

	if self._state ~= BaseSubView.STATES.LOADING then
		return
	end

	self._state = BaseSubView.STATES.LOADED
	self._go = arg_7_1
	self._tf = tf(arg_7_1)

	setActiveViaLayer(self._tf, true)
	pg.DelegateInfo.New(self)

	if self._tf.parent ~= self._parentTf then
		SetParent(self._tf, self._parentTf, false)
	end

	bindComponent(self, self._go)
	self:OnLoaded()

	return
end

function BaseSubView:Init()
	if self._state ~= BaseSubView.STATES.LOADED then
		return
	end

	self._state = BaseSubView.STATES.INITED

	self:OnInit()
	self:HandleFuncQueue()

	return
end

function BaseSubView:Destroy()
	if self._state == BaseSubView.STATES.DESTROY then
		return
	end

	if not self:GetLoaded() then
		self._state = BaseSubView.STATES.DESTROY

		return
	end

	self._state = BaseSubView.STATES.DESTROY

	pg.DelegateInfo.Dispose(self)
	self:OnDestroy()
	bindComponent(self, self._go, true)
	self:disposeEvent()
	self:cleanManagedTween()

	self._tf = nil

	if self._go ~= nil and not self.noReturnPrefab then
		PoolMgr.GetInstance():ReturnUI(self:getUIName(), self._go)

		self._go = nil
	end

	self.noReturnPrefab = nil

	return
end

function BaseSubView:HandleFuncQueue()
	if self._state == BaseSubView.STATES.INITED then
		while #self._funcQueue > 0 do
			local var_10_0 = table.remove(self._funcQueue, 1)

			var_10_0.func(unpackEx(var_10_0.params))
		end
	end

	return
end

function BaseSubView:Reset()
	self._state = BaseSubView.STATES.NONE

	return
end

function BaseSubView:ActionInvoke(arg_12_1, ...)
	assert(self[arg_12_1], "func not exist >>>" .. arg_12_1)

	self._funcQueue[#self._funcQueue + 1] = {
		funcName = arg_12_1,
		func = self[arg_12_1],
		params = packEx(self, ...)
	}

	self:HandleFuncQueue()

	return
end

function BaseSubView:ActionInvokeExclusive(arg_13_1, ...)
	while #self._funcQueue > 0 do
		if self._funcQueue[#self._funcQueue].funcName == arg_13_1 then
			table.remove(self._funcQueue, #self._funcQueue)
		end
	end

	self:ActionInvoke(arg_13_1, ...)

	return
end

function BaseSubView:CallbackInvoke(arg_14_1, ...)
	self._funcQueue[#self._funcQueue + 1] = {
		func = arg_14_1,
		params = packEx(...)
	}

	self:HandleFuncQueue()

	return
end

function BaseSubView:ExecuteAction(arg_15_1, ...)
	self:Load()
	self:ActionInvoke(arg_15_1, ...)

	return
end

function BaseSubView:GetLoaded()
	return self._state >= BaseSubView.STATES.LOADED
end

function BaseSubView:CheckState(arg_17_1)
	return self._state == arg_17_1
end

function BaseSubView:Show()
	setActive(self._tf, true)
	self:ShowOrHideResUI(true)
	self:PlayBGM()

	return
end

function BaseSubView:Hide()
	setActive(self._tf, false)
	self:ShowOrHideResUI(false)
	self:StopBgm()

	return
end

function BaseSubView:isShowing()
	return self._tf and isActive(self._tf) or false
end

function BaseSubView:getBGM(arg_21_1)
	return getBgm(arg_21_1 or self.__cname)
end

function BaseSubView:PlayBGM()
	local var_22_0 = self:getBGM()

	if var_22_0 then
		pg.BgmMgr.GetInstance():Push(self.__cname, var_22_0)
	end

	return
end

function BaseSubView:StopBgm()
	pg.BgmMgr.GetInstance():Pop(self.__cname)

	return
end

function BaseSubView:getTpl(arg_24_1, arg_24_2)
	local var_24_0 = (arg_24_2 or self._tf):Find(arg_24_1)

	var_24_0:SetParent(self._tf, false)
	SetActive(var_24_0, false)

	return var_24_0
end

function BaseSubView:getUIName()
	return nil
end

function BaseSubView:OnLoaded()
	return
end

function BaseSubView:OnInit()
	return
end

function BaseSubView:OnDestroy()
	return
end

function BaseSubView:ResUISettings()
	return nil
end

function BaseSubView:ShowOrHideResUI(arg_30_1)
	local var_30_0 = self:ResUISettings()

	if not var_30_0 then
		return
	end

	if var_30_0 == true then
		var_30_0 = {
			anim = true,
			showType = PlayerResUI.TYPE_ALL
		}
	end

	local var_30_1 = self:getGroupName()

	if arg_30_1 then
		pg.playerResUI:SetSettings(var_30_1, setmetatable({
			groupName = var_30_1
		}, {
			__index = var_30_0
		}))
	else
		pg.playerResUI:RemoveSettings(var_30_1)
	end

	return
end

function BaseSubView:getGroupName()
	return self.contextData.groupName or self.__cname
end

return BaseSubView
