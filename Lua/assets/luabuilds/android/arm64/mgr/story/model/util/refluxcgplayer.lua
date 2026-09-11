local ReFluxCGPlayer = class("ReFluxCGPlayer", import("..animation.StoryAnimtion"))
local var_0_1 = "anim_CG_1_show"
local var_0_2 = "anim_CG_1"
local var_0_3 = "anim_CG_2"
local var_0_4 = "anim_CG_1_hide"
local var_0_5 = "anim_CG_textfx"

function ReFluxCGPlayer:Ctor(arg_1_1)
	ReFluxCGPlayer.super.Ctor(self)

	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.topBox = self._tf:Find("CGbox_top")
	self.bottomBox = self._tf:Find("CGbox_bottom")
	self.topDft = self.topBox:GetComponent(typeof(DftAniEvent))
	self.topAnim = self.topBox:GetComponent(typeof(Animation))
	self.bottomDft = self.bottomBox:GetComponent(typeof(DftAniEvent))
	self.bottomAnim = self.bottomBox:GetComponent(typeof(Animation))
	self.topBg = self.topBox:Find("1/mask/CG1"):GetComponent(typeof(Image))
	self.bottomBg = self.bottomBox:Find("2/CG2"):GetComponent(typeof(Image))
	self.blurSize = pg.UIMgr.GetInstance().cameraBlurs[pg.UIMgr.CameraUI][1].blurSize
	self.title = self.topBox:Find("text")
	self.titleAnim = self.title:GetComponent(typeof(Animation))
	self.titleDft = self.title:GetComponent(typeof(DftAniEvent))
	self.titleTxt = self.title:Find("animroot/text"):GetComponent(typeof(Text))

	return
end

function ReFluxCGPlayer:Play(arg_2_1, arg_2_2)
	assert(#arg_2_1 >= 3, "bgs can not be empty")
	self:UpdateLayout(arg_2_1[1], arg_2_1[2])

	local var_2_0 = {}

	table.insert(var_2_0, function(arg_3_0)
		self:PlayEnterAnimation(arg_3_0)

		return
	end)

	self.speed = 1

	for iter_2_0 = 3, #arg_2_1 do
		local var_2_1 = arg_2_1[iter_2_0]

		if iter_2_0 == #arg_2_1 - 2 then
			table.insert(var_2_0, function(arg_4_0)
				self:PlayTitleAniamtion(arg_4_0)

				return
			end)
		end

		table.insert(var_2_0, function(arg_5_0)
			self:PlayTurnAnimation(self.speed, arg_5_0)

			return
		end)
		table.insert(var_2_0, function(arg_6_0)
			self:ReplaceGC(var_2_1, arg_6_0)

			return
		end)
	end

	parallelAsync({
		function(arg_7_0)
			seriesAsync(var_2_0, arg_7_0)

			return
		end,
		function(arg_8_0)
			self.titleAnimCallback = arg_8_0

			return
		end
	}, function()
		seriesAsync({
			function(arg_10_0)
				self:PlayExitAnimation(arg_10_0)

				return
			end,
			function(arg_11_0)
				self:ResetCG(arg_11_0)

				return
			end
		}, arg_2_2)

		return
	end)

	return
end

function ReFluxCGPlayer:ResetCG(arg_12_1)
	self:ResetLayout()
	self:ResetBlurSize()
	arg_12_1()

	return
end

function ReFluxCGPlayer:UpdateSpeed()
	self.speed = self.speed + 0.2
	self.speed = math.clamp(self.speed, 1, 2)

	return
end

function ReFluxCGPlayer:UpdateLayout(arg_14_1, arg_14_2)
	setActive(self.title, false)
	pg.UIMgr.GetInstance():BlurPanel(self.topBox)
	setParent(self.bottomBox, pg.UIMgr.GetInstance().UIOrigin)

	self.topBg.sprite = LoadSprite("bg/" .. arg_14_1)
	self.bottomBg.sprite = LoadSprite("bg/" .. arg_14_2)

	return
end

function ReFluxCGPlayer:ResetLayout()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.topBox, self._tf)
	setParent(self.bottomBox, self._tf)

	return
end

function ReFluxCGPlayer:PlayTitleAniamtion(arg_16_1)
	self.titleAnim:Stop()

	self.titleTxt.text = ""

	self:SetTriggerEvent(self.titleDft, function()
		self.titleTxt.text = i18n("refux_cg_title")

		return
	end)
	self:SetEndEvent(self.titleDft, function()
		if self.titleAnimCallback then
			self.titleAnimCallback()

			self.titleAnimCallback = nil
		end

		return
	end)
	self.titleAnim:Play(var_0_5)
	setActive(self.title, true)
	arg_16_1()

	return
end

function ReFluxCGPlayer:PlayEnterAnimation(arg_19_1)
	self:SetEndEvent(self.topDft, arg_19_1)
	self.topAnim:Play(var_0_1)

	return
end

function ReFluxCGPlayer:PlayExitAnimation(arg_20_1)
	setActive(self.bottomBox, false)
	self:SetEndEvent(self.topDft, arg_20_1)
	self.topAnim:Play(var_0_4)

	return
end

function ReFluxCGPlayer:PlayTurnAnimation(arg_21_1, arg_21_2)
	self:StopAniamtion(self.topAnim, var_0_2)
	self:StopAniamtion(self.bottomAnim, var_0_3)
	parallelAsync({
		function(arg_22_0)
			self:SetEndEvent(self.topDft, arg_22_0)
			self:PlayAniamtion(self.topAnim, arg_21_1, var_0_2)

			return
		end,
		function(arg_23_0)
			self:SetEndEvent(self.bottomDft, arg_23_0)
			self:PlayAniamtion(self.bottomAnim, arg_21_1, var_0_3)

			return
		end,
		function(arg_24_0)
			self:UpdateBlurSize(3, 0, 0.35 / arg_21_1, arg_24_0)

			return
		end
	}, arg_21_2)

	return
end

function ReFluxCGPlayer:UpdateBlurSize(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = pg.UIMgr.GetInstance().cameraBlurs[pg.UIMgr.CameraUI][1]

	self:TweenValue(self._tf, arg_25_1, arg_25_2, arg_25_3, 0, function(arg_26_0)
		var_25_0.blurSize = arg_26_0

		return
	end, arg_25_4)

	return
end

function ReFluxCGPlayer:ResetBlurSize()
	pg.UIMgr.GetInstance().cameraBlurs[pg.UIMgr.CameraUI][1].blurSize = self.blurSize

	return
end

function ReFluxCGPlayer:ReplaceGC(arg_28_1, arg_28_2)
	self:UpdateSpeed()
	self:StopAniamtion(self.topAnim, var_0_2)
	self:StopAniamtion(self.bottomAnim, var_0_3)

	self.topBg.sprite = self.bottomBg.sprite
	self.bottomBg.sprite = LoadSprite("bg/" .. arg_28_1)

	arg_28_2()

	return
end

function ReFluxCGPlayer:SetEndEvent(arg_29_1, arg_29_2)
	arg_29_1:SetEndEvent(nil)
	arg_29_1:SetEndEvent(function()
		arg_29_1:SetEndEvent(nil)
		arg_29_2()

		return
	end)

	return
end

function ReFluxCGPlayer:SetTriggerEvent(arg_31_1, arg_31_2)
	arg_31_1:SetTriggerEvent(nil)
	arg_31_1:SetTriggerEvent(function()
		arg_31_1:SetTriggerEvent(nil)
		arg_31_2()

		return
	end)

	return
end

function ReFluxCGPlayer:PlayAniamtion(arg_33_1, arg_33_2, arg_33_3)
	arg_33_1:get_Item(arg_33_3).speed = arg_33_2

	arg_33_1:Play(arg_33_3)

	return
end

function ReFluxCGPlayer:StopAniamtion(arg_34_1, arg_34_2)
	arg_34_1:get_Item(arg_34_2).speed = 1
	arg_34_1:get_Item(arg_34_2).time = 0

	arg_34_1:Rewind(arg_34_2)
	arg_34_1:Sample()

	return
end

function ReFluxCGPlayer:Dispose()
	self.topDft:SetEndEvent(nil)
	self.bottomDft:SetEndEvent(nil)
	self.titleDft:SetEndEvent(nil)
	self.titleDft:SetTriggerEvent(nil)
	self:ResetLayout()

	self._go = nil
	self._tf = nil
	self.topBox = nil
	self.bottomBox = nil
	self.topDft = nil

	self:ClearAnimation()

	return
end

return ReFluxCGPlayer
