local NewYear23SkinShowPage = class("NewYear23SkinShowPage", import("...base.BaseActivityPage"))

function NewYear23SkinShowPage:OnLoaded()
	return
end

function NewYear23SkinShowPage:OnInit()
	self.goBtn = self._tf:Find("BtnGO")
	self.skinShopBtn = self._tf:Find("BtnShop")

	onButton(self, self.skinShopBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	onButton(self, self.goBtn, function()
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.NEWYEAR_BACKHILL_2023)

		return
	end, SFX_PANEL)

	self.rtBg = self._tf:Find("AD")
	self.rtFront = self.rtBg:Find("front")

	return
end

function NewYear23SkinShowPage:OnDataSetting()
	local var_5_0 = pg.TimeMgr.GetInstance()

	self.showList = {}

	for iter_5_0, iter_5_1 in ipairs(self.activity:getConfig("config_client").display_link) do
		if iter_5_1[2] == 0 or var_5_0:inTime(pg.shop_template[iter_5_1[2]].time) then
			table.insert(self.showList, math.random(#self.showList + 1), iter_5_1[1])
		end
	end

	return
end

function NewYear23SkinShowPage:OnFirstFlush()
	self:ActionInvoke("ShowOrHide", false)

	self.index = 1

	GetSpriteFromAtlasAsync("clutter/newyear23skinshowpage_" .. self.showList[self.index], "", function(arg_7_0)
		if self._state == NewYear23SkinShowPage.STATES.DESTROY then
			return
		end

		setImageSprite(self.rtBg, arg_7_0)
		setImageAlpha(self.rtFront, 0)
		self:ActionInvoke("ShowOrHide", true)
		self:DelayCall()

		return
	end)

	return
end

function NewYear23SkinShowPage:DelayCall()
	local var_8_0 = {}

	table.insert(var_8_0, function(arg_9_0)
		self.uniqueId = LeanTween.delayedCall(3, System.Action(arg_9_0)).uniqueId

		return
	end)
	table.insert(var_8_0, function(arg_10_0)
		self.index = self.index % #self.showList + 1

		GetSpriteFromAtlasAsync("clutter/newyear23skinshowpage_" .. self.showList[self.index], "", function(arg_11_0)
			if self._state == NewYear23SkinShowPage.STATES.DESTROY then
				return
			end

			self.nextSprite = arg_11_0

			arg_10_0()

			return
		end)

		return
	end)
	parallelAsync(var_8_0, function()
		setImageSprite(self.rtFront, getImageSprite(self.rtBg))
		setImageAlpha(self.rtFront, 1)
		setImageSprite(self.rtBg, self.nextSprite)

		self.uniqueId = LeanTween.alpha(self.rtFront, 0, 0.5):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(function()
			self:DelayCall()

			return
		end)).uniqueId

		return
	end)

	return
end

function NewYear23SkinShowPage:OnDestroy()
	if self.uniqueId then
		LeanTween.cancel(self.uniqueId)
	end

	return
end

return NewYear23SkinShowPage
