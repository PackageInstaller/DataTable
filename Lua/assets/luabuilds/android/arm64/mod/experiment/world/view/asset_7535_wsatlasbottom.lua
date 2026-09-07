local WSAtlasBottom = class("WSAtlasBottom", import("...BaseEntity"))

WSAtlasBottom.Fields = {
	btnShop = "userdata",
	rtBg = "userdata",
	btnOverview = "userdata",
	transform = "userdata",
	wsTimer = "table",
	rtButton = "userdata",
	btnBoss = "userdata",
	comSilder = "userdata",
	twId = "number",
	btnCollection = "userdata",
	btnDailyTask = "userdata"
}
WSAtlasBottom.EventUpdateScale = "WSAtlasBottom.EventUpdateScale"

function WSAtlasBottom:Setup()
	pg.DelegateInfo.New(self)
	self:Init()

	return
end

function WSAtlasBottom:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:Clear()

	return
end

function WSAtlasBottom:Init()
	self.rtBg = self.transform:Find("bg")
	self.rtButton = self.transform:Find("button")
	self.btnBoss = self.rtButton:Find("btn_boss")
	self.btnShop = self.rtButton:Find("btn_shop")
	self.btnOverview = self.rtButton:Find("btn_overview")
	self.btnCollection = self.rtButton:Find("btn_collection")
	self.btnDailyTask = self.rtButton:Find("btn_daily")
	self.comSilder = self.transform:Find("scale/Slider"):GetComponent("Slider")
	self.comSilder.interactable = CAMERA_MOVE_OPEN

	if CAMERA_MOVE_OPEN then
		self.comSilder.onValueChanged:AddListener(function(arg_4_0)
			self:DispatchEvent(WSAtlasBottom.EventUpdateScale, arg_4_0)

			return
		end)
	end

	return
end

function WSAtlasBottom:UpdateScale(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 then
		setImageAlpha(self.btnOverview, self.comSilder.value)
		setActive(self.btnOverview, true)

		self.twId = LeanTween.value(go(self.comSilder), self.comSilder.value, arg_5_1, WSAtlasWorld.baseDuration):setEase(LeanTweenType.easeInOutSine):setOnUpdate(System.Action_float(function(arg_6_0)
			self.comSilder.value = arg_6_0

			setImageAlpha(self.btnOverview, arg_6_0)

			return
		end)):setOnComplete(System.Action(function()
			setActive(self.btnOverview, arg_5_1 == 1)

			return existCall(arg_5_3)
		end)).uniqueId

		self.wsTimer:AddTween(self.twId)
	else
		setImageAlpha(self.btnOverview, arg_5_1)
		setActive(self.btnOverview, arg_5_1 == 1)

		self.comSilder.value = arg_5_1

		return existCall(arg_5_3)
	end

	return
end

function WSAtlasBottom:CheckIsTweening()
	return self.twId and LeanTween.isTweening(self.twId)
end

function WSAtlasBottom:SetOverSize(arg_9_1)
	self.rtBg.offsetMin = Vector2(arg_9_1, self.rtBg.offsetMin.y)
	self.rtBg.offsetMax = Vector2(-arg_9_1, self.rtBg.offsetMax.y)

	return
end

return WSAtlasBottom
