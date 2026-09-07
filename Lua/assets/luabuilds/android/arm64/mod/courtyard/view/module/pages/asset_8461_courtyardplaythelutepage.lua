local CourtyardPlayTheLutePage = class("CourtyardPlayTheLutePage", import(".CourtYardBaseSubPage"))

function CourtyardPlayTheLutePage:getUIName()
	return "CourtyardPlayTheLuteui"
end

function CourtyardPlayTheLutePage:OnLoaded()
	self.backBtn = self._tf:Find("back")
	self.tpl = self._tf:Find("keys/key")
	self.noteTr = self._tf:Find("prints/tansou_yinfu")
	self.keyTplPool = {
		self.tpl
	}
	self.tpls = {}

	return
end

function CourtyardPlayTheLutePage:Show(arg_3_1)
	self.furniture = arg_3_1
	Input.multiTouchEnabled = true

	if self.isInit then
		self:BlurPanel()
	else
		seriesAsync({
			function(arg_4_0)
				self:InitKeys(arg_4_0)

				return
			end,
			function(arg_5_0)
				self.isInit = true

				self:RegisetEvent()
				onNextTick(arg_5_0)

				return
			end,
			function(arg_6_0)
				self:BlurPanel()
				arg_6_0()

				return
			end
		})
	end

	return
end

function CourtyardPlayTheLutePage:BlurPanel()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	CourtyardPlayTheLutePage.super.Show(self)

	return
end

function CourtyardPlayTheLutePage:GetKeys()
	return {
		{
			"7D",
			"pipa_1"
		},
		{
			"1",
			"pipa_2"
		},
		{
			"2",
			"pipa_5"
		},
		{
			"3",
			"pipa_7"
		},
		{
			"4",
			"pipa_9"
		},
		{
			"5",
			"pipa_11"
		},
		{
			"6",
			"pipa_13"
		},
		{
			"7",
			"pipa_15"
		},
		{
			"D1",
			"pipa_3"
		},
		{
			"D2",
			"pipa_6"
		},
		{
			"D3",
			"pipa_8"
		},
		{
			"D4",
			"pipa_10"
		},
		{
			"D5",
			"pipa_12"
		},
		{
			"D6",
			"pipa_14"
		},
		{
			"D7",
			"pipa_16"
		},
		{
			"DD1",
			"pipa_4"
		}
	}
end

function CourtyardPlayTheLutePage:GetTpl()
	if #self.keyTplPool > 0 then
		return table.remove(self.keyTplPool, 1)
	else
		return Object.Instantiate(self.tpl, self.tpl.parent)
	end

	return
end

function CourtyardPlayTheLutePage:InitKeys(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs((self:GetKeys())) do
		table.insert(var_10_0, function(arg_11_0)
			local var_11_0 = self:GetTpl()

			self:InitKey(var_11_0, iter_10_1[1], iter_10_1[2])
			table.insert(self.tpls, var_11_0)

			if iter_10_0 % 3 == 0 then
				onNextTick(arg_11_0)
			else
				arg_11_0()
			end

			return
		end)
	end

	seriesAsync(var_10_0, arg_10_1)

	return
end

function CourtyardPlayTheLutePage:InitKey(arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1:Find("Text"):GetComponent(typeof(Image))

	var_12_0.sprite = GetSpriteFromAtlas("ui/CourtyardLute_atlas", arg_12_2)

	var_12_0:SetNativeSize()

	local var_12_1 = arg_12_1:Find("sel")

	onButton(self, arg_12_1, function()
		setActive(var_12_1, true)
		self:AnimationForKey(arg_12_1)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. arg_12_3)
		self:OnStartPlay(arg_12_2)

		return
	end)
	arg_12_1:Find("animation"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(var_12_1, false)
		self:OnEndPlay(arg_12_2)

		return
	end)

	return
end

function CourtyardPlayTheLutePage:OnStartPlay(arg_15_1)
	return
end

function CourtyardPlayTheLutePage:OnEndPlay(arg_16_1)
	return
end

function CourtyardPlayTheLutePage:AnimationForKey(arg_17_1)
	local var_17_0 = arg_17_1:Find("animation"):GetComponent(typeof(Animation))

	var_17_0:Stop()
	var_17_0:Play()

	return
end

function CourtyardPlayTheLutePage:ClearAnimationForKey(arg_18_1)
	arg_18_1:Find("animation"):GetComponent(typeof(Animation)):Stop()
	arg_18_1:Find("animation"):GetComponent(typeof(DftAniEvent)):SetEndEvent(nil)

	return
end

function CourtyardPlayTheLutePage:RegisetEvent()
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX)

	return
end

function CourtyardPlayTheLutePage:Hide()
	Input.multiTouchEnabled = false

	CourtyardPlayTheLutePage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	self:Emit("StopPlayMusicalInstruments", self.furniture.id)

	return
end

function CourtyardPlayTheLutePage:ClearAllAnimation()
	for iter_22_0, iter_22_1 in ipairs(self.tpls) do
		self:ClearAnimationForKey(iter_22_1)
	end

	return
end

function CourtyardPlayTheLutePage:OnDestroy()
	self:ClearAllAnimation()

	if self:isShowing() then
		self:Hide()
	end

	return
end

return CourtyardPlayTheLutePage
