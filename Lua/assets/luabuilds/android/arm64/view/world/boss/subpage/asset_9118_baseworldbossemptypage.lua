local BaseWorldBossEmptyPage = class("BaseWorldBossEmptyPage", import("view.base.BaseSubView"))

BaseWorldBossEmptyPage.Listeners = {
	onPtUpdated = "OnPtUpdated",
	onBossProgressUpdate = "OnBossProgressUpdate"
}

function BaseWorldBossEmptyPage:Setup(arg_1_1)
	for iter_1_0, iter_1_1 in pairs(BaseWorldBossEmptyPage.Listeners) do
		self[iter_1_0] = function(...)
			BaseWorldBossEmptyPage[iter_1_1](self, ...)

			return
		end
	end

	self.proxy = arg_1_1

	self:AddListeners(self.proxy)

	return
end

function BaseWorldBossEmptyPage:AddListeners(arg_3_1)
	arg_3_1:AddListener(WorldBossProxy.EventUnlockProgressUpdated, self.onBossProgressUpdate)
	arg_3_1:AddListener(WorldBossProxy.EventPtUpdated, self.onPtUpdated)

	return
end

function BaseWorldBossEmptyPage:RemoveListeners(arg_4_1)
	arg_4_1:RemoveListener(WorldBossProxy.EventUnlockProgressUpdated, self.onBossProgressUpdate)
	arg_4_1:RemoveListener(WorldBossProxy.EventPtUpdated, self.onPtUpdated)

	return
end

function BaseWorldBossEmptyPage:OnPtUpdated()
	if self:isShowing() then
		self:OnUpdatePt()
	end

	return
end

function BaseWorldBossEmptyPage:OnBossProgressUpdate()
	if self:isShowing() then
		self:OnUpdateRes()
	end

	return
end

function BaseWorldBossEmptyPage:OnLoaded()
	self.helpBtn = self._tf:Find("help")
	self.compass = self._tf:Find("compass")
	self.latitude = self.compass:Find("info/latitude")
	self.altitude = self.compass:Find("info/altitude")
	self.longitude = self.compass:Find("info/longitude")
	self.speed = self.compass:Find("info/speed")
	self.rader = self._tf:Find("rader/rader")
	self.progressTr = self._tf:Find("progress")
	self.progressTxt = self.progressTr:Find("value"):GetComponent(typeof(Text))
	self.activeBtn = self._tf:Find("useItem/list/tpl")
	self.useItem = self._tf:Find("useItem")
	self.noItem = self._tf:Find("noitem")

	return
end

function BaseWorldBossEmptyPage:OnInit()
	setText(self.latitude, "000")
	setText(self.altitude, "000")
	setText(self.longitude, "000")
	setText(self.speed, "000")
	rotateAni(self.rader, 1, 3)

	if self._tf:Find("title") then
		GetComponent(self._tf:Find("title"), typeof(Image)):SetNativeSize()
	end

	return
end

function BaseWorldBossEmptyPage:UpdateUseItemStyle(arg_9_1)
	self._tf:Find("useItem/list/tpl"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("MetaWorldboss/" .. arg_9_1, "useitem")

	self._tf:Find("useItem/list/tpl"):GetComponent(typeof(Image)):SetNativeSize()

	return
end

function BaseWorldBossEmptyPage:Update()
	self:OnUpdate()
	self:OnUpdateRes()
	self:OnUpdatePt()
	self:Show()

	return
end

function BaseWorldBossEmptyPage:OnUpdate()
	return
end

function BaseWorldBossEmptyPage:OnUpdateRes()
	return
end

function BaseWorldBossEmptyPage:OnUpdatePt()
	return
end

function BaseWorldBossEmptyPage:OnDestroy()
	self:RemoveListeners(self.proxy)

	return
end

return BaseWorldBossEmptyPage
