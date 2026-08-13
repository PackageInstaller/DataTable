class = var_0_10000

local var_0_0 = var_0_10000("BeatMonsterMeidator")
local var_0_1 = 1
local var_0_2 = 0.1
local var_0_3 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.controller = arg_1_1

	return
end

function var_0_0.SetUI(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	tf = var_1_10002
	arg_2_0._tf = var_1_10002(arg_2_1)

	local var_2_0 = arg_2_0._tf

	arg_2_0.monsterNian = var_2.Find(var_2_0, "AD/monster")

	local var_2_1 = arg_2_0._tf

	arg_2_0.fushun = var_2.Find(var_2_1, "AD/fushun")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "AD/hp")
	local var_2_4 = var_2.GetComponent

	typeof = var_5
	Slider = var_1_10007
	arg_2_0.hpTF = var_2_4(var_2_3, var_5(var_1_10007))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_2.Find(var_2_5, "AD/attack_count/Text")
	local var_2_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_2_0.attackCntTF = var_2_7(var_2_6, var_5(var_1_10007))

	local var_2_8 = arg_2_0._tf

	arg_2_0.actions = var_2.Find(var_2_8, "AD/actions")

	local var_2_9 = {}
	local var_2_10 = arg_2_0.actions

	var_2_9[1] = var_3.Find(var_2_10, "content/1")

	local var_2_11 = arg_2_0.actions

	var_2_9[2] = var_3.Find(var_2_11, "content/2")

	local var_2_12 = arg_2_0.actions

	var_2_9[3] = var_3.Find(var_2_12, "content/3")
	arg_2_0.actionKeys = var_2_9

	local var_2_13 = arg_2_0._tf

	arg_2_0.curtainTF = var_2.Find(var_2_13, "AD/curtain")

	local var_2_14 = arg_2_0.curtainTF

	arg_2_0.startLabel = var_2.Find(var_2_14, "start_label")

	local var_2_15 = arg_2_0._tf

	arg_2_0.ABtn = var_2.Find(var_2_15, "AD/A_btn")

	local var_2_16 = arg_2_0._tf

	arg_2_0.BBtn = var_2.Find(var_2_16, "AD/B_btn")

	local var_2_17 = arg_2_0._tf

	arg_2_0.joyStick = var_2.Find(var_2_17, "AD/joyStick")

	return
end

function var_0_0.DoCurtainUp(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)

	if var_2.IsShowBeatMonseterNianCurtain(var_3_0) then
		var_2:SetBeatMonseterNianFlag()
		arg_3_0:StartCurtainUp(arg_3_1)
	else
		arg_3_1()
	end

	return
end

function var_0_0.StartCurtainUp(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0.curtainTF, true)

	LeanTween = var_1_10002

	local var_4_0 = var_1_10002.color
	local var_4_1 = arg_4_0.curtainTF

	Color = var_5

	local var_4_2 = var_4_0(var_4_1, var_5.white, var_0_1)
	local var_4_3 = var_2.setFromColor

	Color = var_5

	local var_4_4 = var_4_3(var_4_2, var_5.black)
	local var_4_5 = var_2.setOnComplete

	System = var_5

	var_4_5(var_4_4, var_5.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_4_0.startLabel, true)

		blinkAni = var_2_10000

		local var_5_0 = var_2_10000(arg_4_0.startLabel, var_0_2, 2)
		local var_5_1 = var_0.setOnComplete

		System = var_3

		var_5_1(var_5_0, var_3.Action(function()
			LeanTween = var_3_10000

			local var_6_0 = var_3_10000.alpha(arg_4_0.curtainTF, 0, var_0_3)

			var_0.setFrom(var_6_0, 1)

			LeanTween = var_0

			local var_6_1 = var_0.alpha(arg_4_0.startLabel, 0, var_0_3)
			local var_6_2 = var_0.setFrom(var_6_1, 1)
			local var_6_3 = var_0.setOnComplete

			System = var_3

			var_6_3(var_6_2, var_3.Action(arg_4_1))

			return
		end))

		return
	end))

	return
end

function var_0_0.OnInited(arg_7_0)
	local function var_7_0()
		if arg_7_0.attackCnt <= 0 then
			pg = var_0

			local var_8_0 = var_0.TipsMgr.GetInstance()
			local var_8_1 = var_0.ShowTips

			i18n = var_2_10003

			var_8_1(var_8_0, var_2_10003("activity_hit_monster_nocount"))

			return false
		end

		if arg_7_0.hp <= 0 then
			pg = var_0

			local var_8_2 = var_0.MsgboxMgr.GetInstance()
			local var_8_3 = var_0.ShowMsgBox
			local var_8_4 = {}

			i18n = var_2_10004
			var_8_4.content = var_2_10004("activity_hit_monster_reset_tip")

			function var_8_4.onYes()
				local var_9_0 = arg_7_0.controller

				var_0.ReStartGame(var_9_0)

				return
			end

			var_8_3(var_8_2, var_8_4)

			return false
		end

		return true
	end

	arg_7_0:OnTrigger(arg_7_0.ABtn, var_7_0, function()
		local var_10_0 = arg_7_0.controller
		local var_10_1 = var_0.Input

		BeatMonsterNianConst = var_2_10003

		var_10_1(var_10_0, var_2_10003.ACTION_NAME_A)

		return
	end)
	arg_7_0:OnTrigger(arg_7_0.BBtn, var_7_0, function()
		local var_11_0 = arg_7_0.controller
		local var_11_1 = var_0.Input

		BeatMonsterNianConst = var_2_10003

		var_11_1(var_11_0, var_2_10003.ACTION_NAME_B)

		return
	end)
	arg_7_0:OnJoyStickTrigger(arg_7_0.joyStick, var_7_0, function(arg_12_0)
		if arg_12_0 > 0 then
			local var_12_0 = arg_7_0.controller
			local var_12_1 = var_1.Input

			BeatMonsterNianConst = var_2_10004

			var_12_1(var_12_0, var_2_10004.ACTION_NAME_R)
		elseif arg_12_0 < 0 then
			local var_12_2 = arg_7_0.controller
			local var_12_3 = var_1.Input

			BeatMonsterNianConst = var_2_10004

			var_12_3(var_12_2, var_2_10004.ACTION_NAME_L)
		end

		return
	end)

	return
end

function var_0_0.OnAttackCntUpdate(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.attackCnt = arg_13_1
	arg_13_0.attackCntTF.text = arg_13_2 and "-" or arg_13_1

	return
end

function var_0_0.OnMonsterHpUpdate(arg_14_0, arg_14_1)
	arg_14_0.hp = arg_14_1

	local var_14_0 = arg_14_0.fuShun

	var_2.SetInteger(var_14_0, "hp", arg_14_1)

	local var_14_1 = arg_14_0.nian

	var_2.SetInteger(var_14_1, "hp", arg_14_1)

	return
end

function var_0_0.OnUIHpUpdate(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0.hpTF.value
	local var_15_1 = arg_15_1 / arg_15_2

	LeanTween = var_1_10006

	local var_15_2 = var_1_10006.value(arg_15_0.hpTF.gameObject, var_15_0, var_15_1, 0.3)
	local var_15_3 = var_6.setOnUpdate

	System = var_9

	local var_15_4 = var_15_3(var_15_2, var_9.Action_float(function(arg_16_0)
		arg_15_0.hpTF.value = arg_16_0

		return
	end))
	local var_15_5 = var_6.setOnComplete

	System = var_9

	var_15_5(var_15_4, var_9.Action(function()
		if arg_15_3 then
			arg_15_3()
		end

		return
	end))

	return
end

function var_0_0.OnAddFuShun(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.fushun
	local var_18_1 = var_2.GetComponent

	typeof = var_1_10005
	Animator = var_1_10007
	arg_18_0.fuShun = var_18_1(var_18_0, var_1_10005(var_1_10007))

	local var_18_2 = arg_18_0.fuShun

	var_2.SetInteger(var_18_2, "hp", arg_18_1)

	return
end

function var_0_0.OnAddMonsterNian(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.hp = arg_19_1

	local var_19_0 = arg_19_0.monsterNian
	local var_19_1 = var_3.GetComponent

	typeof = var_1_10006
	Animator = var_1_10008
	arg_19_0.nian = var_19_1(var_19_0, var_1_10006(var_1_10008))
	arg_19_0.hpTF.value = arg_19_1 / arg_19_2

	local var_19_2 = arg_19_0.nian

	var_3.SetInteger(var_19_2, "hp", arg_19_1)

	return
end

function var_0_0.OnChangeFuShunAction(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.fuShun

	var_2.SetTrigger(var_20_0, arg_20_1)

	return
end

function var_0_0.OnChangeNianAction(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.nian

	var_2.SetTrigger(var_21_0, arg_21_1)

	return
end

function var_0_0.BanJoyStick(arg_22_0, arg_22_1)
	setActive = var_1_10002

	local var_22_0 = arg_22_0.joyStick

	var_1_10002(var_4.Find(var_22_0, "ban"), arg_22_1)

	GetOrAddComponent = var_1_10002

	local var_22_1 = arg_22_0.joyStick

	typeof = var_5
	EventTriggerListener = var_7
	var_1_10002(var_22_1, var_5(var_7)).enabled = not arg_22_1

	return
end

function var_0_0.OnInputChange(arg_23_0, arg_23_1)
	if arg_23_1 and arg_23_1 ~= "" then
		ipairs = var_1_10003

		for iter_23_0, iter_23_1 in var_1_10003(arg_23_0.actionKeys) do
			string = var_1_10008

			if not var_1_10008.sub(arg_23_1, iter_23_0, iter_23_0) then
				var_1_10008 = ""
			end

			setActive = var_1_10009

			local var_23_0 = iter_23_1:Find("A")

			BeatMonsterNianConst = var_12

			var_1_10009(var_23_0, var_1_10008 == var_12.ACTION_NAME_A)

			setActive = var_1_10009

			local var_23_1 = iter_23_1:Find("L")

			BeatMonsterNianConst = var_12

			var_1_10009(var_23_1, var_1_10008 == var_12.ACTION_NAME_L)

			setActive = var_1_10009

			local var_23_2 = iter_23_1:Find("R")

			BeatMonsterNianConst = var_12

			var_1_10009(var_23_2, var_1_10008 == var_12.ACTION_NAME_R)

			setActive = var_1_10009

			local var_23_3 = iter_23_1:Find("B")

			BeatMonsterNianConst = var_12

			var_1_10009(var_23_3, var_1_10008 == var_12.ACTION_NAME_B)
		end
	end

	setActive = var_1_10003

	var_1_10003(arg_23_0.actions, var_2)
	arg_23_0:BanJoyStick(#arg_23_1 == 2)

	return
end

function var_0_0.PlayStory(arg_24_0, arg_24_1, arg_24_2)
	pg = var_1_10003

	local var_24_0 = var_1_10003.NewStoryMgr.GetInstance()

	var_3.Play(var_24_0, arg_24_1, arg_24_2)

	return
end

function var_0_0.DisplayAwards(arg_25_0, arg_25_1, arg_25_2)
	pg = var_1_10003

	local var_25_0 = var_1_10003.m02
	local var_25_1 = var_3.sendNotification

	ActivityProxy = var_1_10006

	var_25_1(var_25_0, var_1_10006.ACTIVITY_SHOW_AWARDS, {
		awards = arg_25_1,
		callback = arg_25_2
	})

	return
end

function var_0_0.Dispose(arg_26_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_26_0)

	return
end

function var_0_0.OnTrigger(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_1
	local var_27_1 = arg_27_1.Find(var_27_0, "off")
	local var_27_2 = true

	GetOrAddComponent = var_27_0

	local var_27_3 = arg_27_1

	typeof = var_1_10009
	EventTriggerListener = var_1_10011

	local var_27_4 = var_27_0(var_27_3, var_1_10009(var_1_10011))

	var_6.AddPointDownFunc(var_27_4, function(arg_28_0, arg_28_1)
		var_27_2 = arg_27_2()

		if var_27_2 then
			setActive = var_2

			var_2(var_27_1, false)
		end

		return
	end)
	var_6:AddPointUpFunc(function(arg_29_0, arg_29_1)
		if var_27_2 then
			setActive = var_2

			var_2(var_27_1, true)

			if arg_27_3 then
				arg_27_3()
			end
		end

		return
	end)

	return
end

function var_0_0.OnJoyStickTrigger(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_1:Find("m")
	local var_30_1 = arg_30_1
	local var_30_2 = arg_30_1.Find(var_30_1, "l")
	local var_30_3 = arg_30_1:Find("r")

	GetOrAddComponent = var_30_1

	local var_30_4 = arg_30_1

	typeof = var_1_10010
	EventTriggerListener = var_1_10012

	local var_30_5 = var_30_1(var_30_4, var_1_10010(var_1_10012))
	local var_30_6
	local var_30_7 = false

	var_30_5:AddBeginDragFunc(function(arg_31_0, arg_31_1)
		var_30_7 = arg_30_2()
		var_30_6 = arg_31_1.position

		return
	end)
	var_30_5:AddDragFunc(function(arg_32_0, arg_32_1)
		if not var_30_7 then
			return
		end

		local var_32_0 = arg_32_1.position.x - var_30_6.x

		setActive = var_3

		var_3(var_30_0, var_32_0 == 0)

		setActive = var_3

		var_3(var_30_2, var_32_0 < 0)

		setActive = var_3

		var_3(var_30_3, var_32_0 > 0)

		return
	end)
	var_30_5:AddDragEndFunc(function(arg_33_0, arg_33_1)
		if not var_30_7 then
			return
		end

		local var_33_0 = arg_33_1.position.x - var_30_6.x

		arg_30_3(var_33_0)

		setActive = var_3

		var_3(var_30_0, true)

		setActive = var_3

		var_3(var_30_2, false)

		setActive = var_3

		var_3(var_30_3, false)

		return
	end)

	return
end

return var_0_0
