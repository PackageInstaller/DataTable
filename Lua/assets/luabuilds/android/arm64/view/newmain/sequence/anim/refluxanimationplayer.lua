local RefluxAnimationPlayer = class("RefluxAnimationPlayer", import("view.base.BaseSubView"))

function RefluxAnimationPlayer:getUIName()
	return "RefluxAnimationUI"
end

function RefluxAnimationPlayer:OnLoaded()
	self.s1SpineAnim = self._tf:Find("s1/spine"):GetComponent(typeof(SpineAnimUI))
	self.s2SpineAnim = self._tf:Find("s2/spine"):GetComponent(typeof(SpineAnimUI))
	self.s3SpineAnim = self._tf:Find("a4/Bg/spine/s3/spine"):GetComponent(typeof(SpineAnimUI))
	self.a1Animation = self._tf:Find("s1"):GetComponent(typeof(Animation))
	self.a1AnimationDft = self._tf:Find("s1"):GetComponent(typeof(DftAniEvent))
	self.a1AnimationEffect = self._tf:Find("s1/a1/VX_glow")
	self.a2Animation = self._tf:Find("a2"):GetComponent(typeof(Animation))
	self.a2AnimationDft = self._tf:Find("a2"):GetComponent(typeof(DftAniEvent))
	self.a3Animation = self._tf:Find("a3"):GetComponent(typeof(Animation))
	self.a3AnimationDft = self._tf:Find("a3"):GetComponent(typeof(DftAniEvent))
	self.a4Animation = self._tf:Find("a4"):GetComponent(typeof(Animation))
	self.a4AnimationDft = self._tf:Find("a4"):GetComponent(typeof(DftAniEvent))
	self.a5Animation = self._tf:Find("a5"):GetComponent(typeof(Animator))
	self.a5AnimationDft = self._tf:Find("a5"):GetComponent(typeof(DftAniEvent))
	self.cGContainer = self._tf:Find("a5/Bg/CG")
	self.cgTpl = self._tf:Find("a5/Bg/tpl")
	self.s1ClickBtn = self._tf:Find("s1/a1/click")
	self.a3ReviewBtn = self._tf:Find("a3/Bg/btn")
	self.backBtn = self._tf:Find("a3/Bg/bg")
	self.a5bgAlpha = self._tf:Find("a5/Bg"):GetComponent(typeof(CanvasGroup))
	self.yearText = self._tf:Find("a3/Bg/xinfen/bg_3/billboard/year")
	self.monthText = self._tf:Find("a3/Bg/xinfen/bg_3/billboard/month")
	self.dateText = self._tf:Find("a3/Bg/xinfen/bg_3/billboard/date")
	self.daysText = self._tf:Find("a3/Bg/xinfen/bg_3/billboard/days")
	self.countText = self._tf:Find("a3/Bg/xinfen/bg_3/billboard/count")

	self:updateUI()

	return
end

function RefluxAnimationPlayer:updateUI()
	local var_3_0 = getProxy(RefluxProxy)
	local var_3_1 = pg.TimeMgr.GetInstance()
	local var_3_2 = var_3_1:STimeDescS(var_3_0.returnLastTimestamp, "*t")

	setText(self.yearText, var_3_2.year % 100)
	setText(self.monthText, var_3_2.month)
	setText(self.dateText, var_3_2.day)
	setText(self.daysText, var_3_1:DiffDay(var_3_0.returnLastTimestamp, var_3_0.returnTimestamp))
	setText(self.countText, var_3_0.returnShipNum)

	return
end

function RefluxAnimationPlayer:Play(arg_4_1, arg_4_2)
	self.bgs = arg_4_1

	seriesAsync({
		function(arg_5_0)
			self:OnStart()
			self:EnterAnimation(arg_5_0)

			return
		end,
		function(arg_6_0)
			self:EnterClickAnimation(arg_6_0)

			return
		end,
		function(arg_7_0)
			self:RegiserOpenClick(arg_7_0)

			return
		end,
		function(arg_8_0)
			self:OpenAnimation(arg_8_0)

			return
		end,
		function(arg_9_0)
			self:OpenDisplayAnimation(arg_9_0)

			return
		end,
		function(arg_10_0)
			self:ReigerReviewClick(arg_10_0)
			self:ReigerBackClick(arg_10_0)

			return
		end
	}, arg_4_2)

	return
end

function RefluxAnimationPlayer:Play4Review(arg_11_1, arg_11_2)
	self:Show()

	self.bgs = arg_11_1

	seriesAsync({
		function(arg_12_0)
			self:OnStart()
			self:OpenDisplayAnimation(arg_12_0)

			return
		end,
		function(arg_13_0)
			self:ReigerReviewClick(arg_13_0)
			self:ReigerBackClick(arg_13_0)

			return
		end
	}, arg_11_2)

	return
end

function RefluxAnimationPlayer:PlayNextStage(arg_14_1)
	self.a5bgAlpha.alpha = 1

	removeAllChildren(self.cGContainer)
	seriesAsync({
		function(arg_15_0)
			self:EnterCGAnimation(arg_15_0)

			return
		end,
		function(arg_16_0)
			self:StartCGAnimation(arg_16_0)

			return
		end,
		function(arg_17_0)
			self:PlayCGLoop(self.bgs, arg_17_0)

			return
		end,
		function(arg_18_0)
			self:EndCGAnimation(arg_18_0)

			return
		end,
		function(arg_19_0)
			self:ExitCGAnimation(arg_19_0)

			return
		end,
		function(arg_20_0)
			self:OpenDisplayAnimation(arg_20_0)

			return
		end,
		function(arg_21_0)
			self:ReigerBackClick(arg_14_1)
			self:ReigerReviewClick(arg_14_1)

			return
		end
	})

	return
end

function RefluxAnimationPlayer:OnStart()
	removeAllOnButton(self.a3ReviewBtn)
	removeAllOnButton(self.s1ClickBtn)
	eachChild(self._tf, function(arg_23_0)
		if arg_23_0.name ~= "bg_low" then
			setActive(arg_23_0, false)
		end

		return
	end)
	setActive(self.a3ReviewBtn, #self.bgs > 0)

	return
end

function RefluxAnimationPlayer:EnterAnimation(arg_24_1)
	self.s1SpineAnim:SetActionCallBack(nil)
	setActive(self.s1SpineAnim.gameObject.transform.parent, true)
	self.s1SpineAnim:SetActionCallBack(function(arg_25_0)
		if arg_25_0 == "finish" then
			self.s1SpineAnim:SetActionCallBack(nil)
			self.s1SpineAnim:SetAction("normal", 0)
			arg_24_1()
		end

		return
	end)
	self.s1SpineAnim:SetAction("action", 0)

	return
end

function RefluxAnimationPlayer:EnterClickAnimation(arg_26_1)
	setActive(self.a1AnimationEffect, false)
	setActive(go(self.a1Animation).transform.parent, true)
	self.a1AnimationDft:SetEndEvent(nil)
	self.a1AnimationDft:SetEndEvent(function()
		self.a1AnimationDft:SetEndEvent(nil)
		setActive(self.a1AnimationEffect, true)
		arg_26_1()

		return
	end)
	self.a1Animation:Play("ShadowCityFramePage_in")

	return
end

function RefluxAnimationPlayer:RegiserOpenClick(arg_28_1)
	onButton(self, self.s1ClickBtn, function()
		removeAllOnButton(self.s1ClickBtn)
		arg_28_1()

		return
	end, SFX_PANEL)

	return
end

function RefluxAnimationPlayer:ReigerBackClick(arg_30_1)
	onButton(self, self.backBtn, function()
		removeAllOnButton(self.a3ReviewBtn)
		removeAllOnButton(self.backBtn)
		arg_30_1()

		return
	end, SFX_PANEL)

	return
end

function RefluxAnimationPlayer:ReigerReviewClick(arg_32_1)
	onButton(self, self.a3ReviewBtn, function()
		removeAllOnButton(self.a3ReviewBtn)
		removeAllOnButton(self.backBtn)
		self:PlayNextStage(arg_32_1)

		return
	end, SFX_PANEL)

	return
end

function RefluxAnimationPlayer:OpenAnimation(arg_34_1)
	setActive(self.s1SpineAnim.gameObject.transform.parent, false)
	setActive(tf(self.a1Animation), false)
	parallelAsync({
		function(arg_35_0)
			self:PlayOpenAnimation(arg_35_0)

			return
		end,
		function(arg_36_0)
			self:PlayOpenSpineAnimation(arg_36_0)

			return
		end
	}, arg_34_1)

	return
end

function RefluxAnimationPlayer:PlayOpenAnimation(arg_37_1)
	setActive(self.a2Animation.gameObject, true)
	self.a2AnimationDft:SetEndEvent(nil)
	self.a2AnimationDft:SetEndEvent(function()
		self.a2AnimationDft:SetEndEvent(nil)
		arg_37_1()

		return
	end)
	self.a2Animation:Play("ShadowCityFramePage_2_in")

	return
end

function RefluxAnimationPlayer:PlayOpenSpineAnimation(arg_39_1)
	self.s2SpineAnim:SetActionCallBack(nil)
	setActive(self.s2SpineAnim.gameObject.transform.parent, true)
	self.s2SpineAnim:SetActionCallBack(function(arg_40_0)
		if arg_40_0 == "finish" then
			self.s2SpineAnim:SetActionCallBack(nil)
			self.s2SpineAnim:SetAction("action2", 0)
			arg_39_1()
		end

		return
	end)
	self.s2SpineAnim:SetAction("action", 0)

	return
end

function RefluxAnimationPlayer:OpenDisplayAnimation(arg_41_1)
	setActive(self.s2SpineAnim.gameObject.transform.parent, false)
	setActive(self.a3Animation.gameObject, true)
	setActive(self.a4Animation.gameObject, false)
	self.a3AnimationDft:SetEndEvent(nil)
	self.a3AnimationDft:SetEndEvent(function()
		self.a3AnimationDft:SetEndEvent(nil)
		arg_41_1()

		return
	end)
	self.a3AnimationDft:SetTriggerEvent(nil)
	self.a3AnimationDft:SetTriggerEvent(function()
		setActive(self.a2Animation.gameObject, false)

		return
	end)
	self.a3Animation:Play("ShadowCityFramePage_3_in")

	return
end

function RefluxAnimationPlayer:EnterCGAnimation(arg_44_1)
	setActive(self.a3Animation.gameObject, false)
	seriesAsync({
		function(arg_45_0)
			self:PlayEnterCGAnimation(arg_45_0)

			return
		end,
		function(arg_46_0)
			self:PlayEnterCGSpineAnimation(arg_46_0)

			return
		end
	}, arg_44_1)

	return
end

function RefluxAnimationPlayer:PlayEnterCGAnimation(arg_47_1)
	setActive(self.a4Animation.gameObject, true)
	self.a4AnimationDft:SetEndEvent(nil)
	self.a4AnimationDft:SetEndEvent(function()
		self.a4AnimationDft:SetEndEvent(nil)
		arg_47_1()

		return
	end)
	self.a4Animation:Play("ShadowCityFramePage_4_in")
	self.s3SpineAnim:SetActionCallBack(nil)
	self.s3SpineAnim:SetAction("normal1", 0)

	return
end

function RefluxAnimationPlayer:PlayEnterCGSpineAnimation(arg_49_1)
	self.s3SpineAnim:SetActionCallBack(nil)
	setActive(self.s3SpineAnim.gameObject.transform.parent, true)
	self.s3SpineAnim:SetActionCallBack(function(arg_50_0)
		if arg_50_0 == "finish" then
			self.s3SpineAnim:SetActionCallBack(nil)
			self.s3SpineAnim:SetAction("normal2", 0)
			arg_49_1()
		end

		return
	end)
	self.s3SpineAnim:SetAction("action1", 0)

	return
end

function RefluxAnimationPlayer:ExitCGAnimation(arg_51_1)
	setActive(self.a3Animation.gameObject, false)
	seriesAsync({
		function(arg_52_0)
			self:PlayExitCGAnimation(arg_52_0)

			return
		end,
		function(arg_53_0)
			self:PlayExitCGSpineAnimation(arg_53_0)

			return
		end
	}, arg_51_1)

	return
end

function RefluxAnimationPlayer:PlayExitCGAnimation(arg_54_1)
	setActive(self.a4Animation.gameObject, true)
	self.a4AnimationDft:SetEndEvent(nil)
	self.a4AnimationDft:SetEndEvent(function()
		self.a4AnimationDft:SetEndEvent(nil)
		arg_54_1()

		return
	end)
	self.a4Animation:Play("ShadowCityFramePage_4_out")
	self.s3SpineAnim:SetActionCallBack(nil)
	self.s3SpineAnim:SetAction("normal2", 0)

	return
end

function RefluxAnimationPlayer:PlayExitCGSpineAnimation(arg_56_1)
	self.s3SpineAnim:SetActionCallBack(nil)
	setActive(self.s3SpineAnim.gameObject.transform.parent, true)
	self.s3SpineAnim:SetActionCallBack(function(arg_57_0)
		if arg_57_0 == "finish" then
			self.s3SpineAnim:SetActionCallBack(nil)
			self.s3SpineAnim:SetAction("normal1", 0)
			arg_56_1()
		end

		return
	end)
	self.s3SpineAnim:SetAction("action2", 0)

	return
end

function RefluxAnimationPlayer:StartCGAnimation(arg_58_1)
	setActive(self.a5Animation.gameObject, true)
	self.a5AnimationDft:SetEndEvent(nil)
	self.a5AnimationDft:SetEndEvent(function()
		self.a5AnimationDft:SetEndEvent(nil)
		arg_58_1()

		return
	end)
	self.a5AnimationDft:SetTriggerEvent(nil)
	self.a5AnimationDft:SetTriggerEvent(function()
		self.a5AnimationDft:SetTriggerEvent(nil)
		setActive(self.a4Animation.gameObject, false)

		return
	end)
	self.a5Animation:SetTrigger("in")

	return
end

local function var_0_1(arg_61_0, arg_61_1, arg_61_2, arg_61_3)
	local var_61_0 = arg_61_0:Find("root/cg")

	setImageSprite(var_61_0, LoadSprite("bg/" .. arg_61_2), false)
	setLocalPosition(var_61_0, Vector3(-10000, -10000, 0))

	var_61_0.sizeDelta = Vector3(1920, 1080)

	setActive(arg_61_0, true)

	local var_61_1 = arg_61_0:Find("root"):GetComponent(typeof(DftAniEvent))

	var_61_1:SetEndEvent(nil)
	var_61_1:SetEndEvent(function()
		var_61_1:SetEndEvent(nil)
		arg_61_3()

		return
	end)
	arg_61_0:Find("root"):GetComponent(typeof(Animation)):Play("ShadowCityFramePage_photo_" .. arg_61_1)

	return
end

local function var_0_2(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_0:Find("root/cg")

	setImageSprite(var_63_0, LoadSprite("bg/" .. arg_63_1), false)

	var_63_0.sizeDelta = Vector3(1920, 1080)

	setLocalPosition(var_63_0, Vector3(-10000, -10000, 0))

	var_63_0.sizeDelta = Vector3(1920, 1080)

	setActive(arg_63_0, true)

	local var_63_1 = arg_63_0:Find("root"):GetComponent(typeof(DftAniEvent))

	var_63_1:SetEndEvent(nil)
	var_63_1:SetEndEvent(function()
		var_63_1:SetEndEvent(nil)
		arg_63_2()

		return
	end)
	arg_63_0:Find("root"):GetComponent(typeof(Animation)):Play("ShadowCityFramePage_photo")

	return
end

function RefluxAnimationPlayer:PlayCGLoop(arg_65_1, arg_65_2)
	local var_65_0 = {}

	removeAllChildren(self.cGContainer)

	local var_65_1 = cloneTplTo(self.cgTpl, self.cGContainer)

	for iter_65_0 = 2, #arg_65_1 do
		local var_65_2 = cloneTplTo(self.cgTpl, self.cGContainer)

		setActive(var_65_2, false)
		table.insert(var_65_0, var_65_2)
	end

	local var_65_3 = {}

	table.insert(var_65_3, function(arg_66_0)
		var_0_2(var_65_1, arg_65_1[1], arg_66_0)

		return
	end)

	for iter_65_1, iter_65_2 in ipairs(var_65_0) do
		local var_65_4 = iter_65_1 % 4

		if iter_65_1 % 4 == 0 then
			var_65_4 = 4
		end

		local var_65_5 = arg_65_1[iter_65_1 + 1]

		table.insert(var_65_3, function(arg_67_0)
			var_0_1(iter_65_2, var_65_4, var_65_5, arg_67_0)

			return
		end)
	end

	seriesAsync(var_65_3, arg_65_2)

	return
end

function RefluxAnimationPlayer:EndCGAnimation(arg_68_1)
	setActive(self.a4Animation.gameObject, true)
	self.a5AnimationDft:SetEndEvent(nil)
	self.a5AnimationDft:SetEndEvent(function()
		self.a5AnimationDft:SetEndEvent(nil)
		setActive(self.a5Animation.gameObject, false)
		arg_68_1()

		return
	end)
	self.a5Animation:SetTrigger("out")

	return
end

function RefluxAnimationPlayer:OnDestroy()
	self.a1AnimationDft:SetEndEvent(nil)
	self.a2AnimationDft:SetEndEvent(nil)
	self.a3AnimationDft:SetEndEvent(nil)
	self.a4AnimationDft:SetEndEvent(nil)
	self.a5AnimationDft:SetEndEvent(nil)
	self.a5AnimationDft:SetTriggerEvent(nil)

	return
end

return RefluxAnimationPlayer
