local var_0_0 = class("CourtyardPlayTheLutePage", import(".CourtYardBaseSubPage"))

function var_0_0.getUIName(arg_1_0)
	return "CourtyardPlayTheLuteui"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("back")
	arg_2_0.tpl = arg_2_0._tf:Find("keys/key")
	arg_2_0.noteTr = arg_2_0._tf:Find("prints/tansou_yinfu")
	arg_2_0.keyTplPool = {
		arg_2_0.tpl
	}
	arg_2_0.tpls = {}

	return
end

function var_0_0.Show(arg_3_0, arg_3_1)
	arg_3_0.furniture = arg_3_1
	Input.multiTouchEnabled = true

	if arg_3_0.isInit then
		arg_3_0:BlurPanel()
	else
		seriesAsync({
			function(arg_4_0)
				arg_3_0:InitKeys(arg_4_0)

				return
			end,
			function(arg_5_0)
				arg_3_0.isInit = true

				arg_3_0:RegisetEvent()
				onNextTick(arg_5_0)

				return
			end,
			function(arg_6_0)
				arg_3_0:BlurPanel()
				arg_6_0()

				return
			end
		})
	end

	return
end

function var_0_0.BlurPanel(arg_7_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)
	var_0_0.super.Show(arg_7_0)

	return
end

function var_0_0.GetKeys(arg_8_0)
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

function var_0_0.GetTpl(arg_9_0)
	if #arg_9_0.keyTplPool > 0 then
		return table.remove(arg_9_0.keyTplPool, 1)
	else
		return Object.Instantiate(arg_9_0.tpl, arg_9_0.tpl.parent)
	end

	return
end

function var_0_0.InitKeys(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs((arg_10_0:GetKeys())) do
		table.insert({}, function(arg_11_0)
			local var_11_0 = arg_10_0:GetTpl()

			arg_10_0:InitKey(var_11_0, iter_10_1[1], iter_10_1[2])
			table.insert(arg_10_0.tpls, var_11_0)

			if iter_10_0 % 3 == 0 then
				onNextTick(arg_11_0)
			else
				arg_11_0()
			end

			return
		end)
	end

	seriesAsync({}, arg_10_1)

	return
end

function var_0_0.InitKey(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_1:Find("Text"):GetComponent(typeof(Image))

	var_12_0.sprite = GetSpriteFromAtlas("ui/CourtyardLute_atlas", arg_12_2)

	var_12_0:SetNativeSize()

	local var_12_1 = arg_12_1:Find("sel")

	onButton(arg_12_0, arg_12_1, function()
		setActive(var_12_1, true)
		arg_12_0:AnimationForKey(arg_12_1)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. arg_12_3)
		arg_12_0:OnStartPlay(arg_12_2)

		return
	end)
	arg_12_1:Find("animation"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		setActive(var_12_1, false)
		arg_12_0:OnEndPlay(arg_12_2)

		return
	end)

	return
end

function var_0_0.OnStartPlay(arg_15_0, arg_15_1)
	return
end

function var_0_0.OnEndPlay(arg_16_0, arg_16_1)
	return
end

function var_0_0.AnimationForKey(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:Find("animation"):GetComponent(typeof(Animation))

	var_17_0:Stop()
	var_17_0:Play()

	return
end

function var_0_0.ClearAnimationForKey(arg_18_0, arg_18_1)
	arg_18_1:Find("animation"):GetComponent(typeof(Animation)):Stop()
	arg_18_1:Find("animation"):GetComponent(typeof(DftAniEvent)):SetEndEvent(nil)

	return
end

function var_0_0.RegisetEvent(arg_19_0)
	onButton(arg_19_0, arg_19_0.backBtn, function()
		arg_19_0:Hide()

		return
	end, SFX)

	return
end

function var_0_0.Hide(arg_21_0)
	Input.multiTouchEnabled = false

	var_0_0.super.Hide(arg_21_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_21_0._tf, arg_21_0._parentTf)
	arg_21_0:Emit("StopPlayMusicalInstruments", arg_21_0.furniture.id)

	return
end

function var_0_0.ClearAllAnimation(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.tpls) do
		arg_22_0:ClearAnimationForKey(iter_22_1)
	end

	return
end

function var_0_0.OnDestroy(arg_23_0)
	arg_23_0:ClearAllAnimation()

	if arg_23_0:isShowing() then
		arg_23_0:Hide()
	end

	return
end

return var_0_0
