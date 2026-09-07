local DreamlandHotSpringPage = class("DreamlandHotSpringPage", import("view.base.BaseSubView"))

function DreamlandHotSpringPage:getUIName()
	return "DreamlandHotSpringUI"
end

function DreamlandHotSpringPage:OnLoaded()
	self.slots = {}
	self.uiItemList = UIItemList.New(self._tf:Find("bg/list"), self._tf:Find("bg/list/tpl"))
	self.iconList = {
		"icon_1",
		"icon_2",
		"icon_3"
	}

	setText(self._tf:Find("bg/list/tpl/lock/Text"), i18n("dreamland_spring_lock_tip"))

	return
end

function DreamlandHotSpringPage:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	self:bind(DreamlandScene.ON_SPRING_DATA_UPDATE, function(arg_5_0, arg_5_1)
		self:UpdateSpringActUpdate(arg_5_1.data)

		return
	end)
	self:InitSlots()

	return
end

function DreamlandHotSpringPage:UpdateSpringActUpdate(arg_6_1)
	if not self:isShowing() then
		return
	end

	self:Flush(arg_6_1)

	return
end

function DreamlandHotSpringPage:InitSlots()
	self.uiItemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			self:UpdateSlot(arg_8_2, arg_8_1)
		end

		return
	end)

	return
end

function DreamlandHotSpringPage:Show(arg_9_1)
	DreamlandHotSpringPage.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:Flush(arg_9_1)

	return
end

function DreamlandHotSpringPage:Flush(arg_10_1)
	self.shipList = arg_10_1:GetHotSpringData()

	setText(self._tf:Find("bg/Text"), i18n("dreamland_spring_tip", (arg_10_1:GetHotSpringAddition())))

	self.gameData = arg_10_1

	self.uiItemList:align((arg_10_1:GetHotSpringMaxCnt()))

	return
end

function DreamlandHotSpringPage:UpdateSlot(arg_11_1, arg_11_2)
	local var_11_0 = self.shipList[arg_11_2 + 1]
	local var_11_1 = self.gameData:IsLockSpringSlot(arg_11_2 + 1)
	local var_11_2 = self.shipList[arg_11_2 + 1] and var_11_0 > 0

	setActive(arg_11_1:Find("add"), not var_11_1 and not var_11_2)
	setActive(arg_11_1:Find("ship"), not var_11_1 and var_11_2)
	setActive(arg_11_1:Find("lock"), var_11_1)
	onButton(self, arg_11_1, function()
		if var_11_1 then
			return
		end

		local var_12_0

		if var_11_2 then
			var_12_0 = getProxy(BayProxy):getShipById(var_11_0)
		end

		self:emit(DreamlandScene.ON_SPRING_OP)
		self:emit(DreamlandMediator.HOT_SPRING_OP, arg_11_2 + 1, self.gameData:GetUnlockSpringCnt(), var_12_0)

		return
	end, SFX_PANEL)

	if not var_11_2 then
		return
	end

	self:UpdateShipSlot(arg_11_1, var_11_0)

	return
end

function DreamlandHotSpringPage:UpdateShipSlot(arg_13_1, arg_13_2)
	local var_13_0 = getProxy(BayProxy)

	arg_13_1:Find("ship").GetComponent(var_13_0, typeof(Image)).sprite = LoadSprite("qicon/" .. var_13_0:RawGetShipById(arg_13_2):getPrefab())

	local var_13_1 = arg_13_1:Find("ship/icon"):GetComponent(typeof(Image))

	var_13_1.sprite = GetSpriteFromAtlas("ui/DlHotSpringUI_atlas", self.iconList[math.random(1, #self.iconList)])

	var_13_1:SetNativeSize()

	return
end

function DreamlandHotSpringPage:Hide()
	DreamlandHotSpringPage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function DreamlandHotSpringPage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return DreamlandHotSpringPage
