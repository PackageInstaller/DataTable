local var_0_0 = class("BeatMonsterMeidator")
local var_0_1 = 1
local var_0_2 = 0.1
local var_0_3 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.controller = arg_1_1

	return
end

function var_0_0.SetUI(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._tf = tf(arg_2_1)
	arg_2_0.monsterNian = arg_2_0._tf:Find("AD/monster")
	arg_2_0.fushun = arg_2_0._tf:Find("AD/fushun")
	arg_2_0.hpTF = arg_2_0._tf:Find("AD/hp"):GetComponent(typeof(Slider))
	arg_2_0.attackCntTF = arg_2_0._tf:Find("AD/attack_count/Text"):GetComponent(typeof(Text))
	arg_2_0.actions = arg_2_0._tf:Find("AD/actions")
	arg_2_0.actionKeys = {
		arg_2_0.actions:Find("content/1"),
		arg_2_0.actions:Find("content/2"),
		arg_2_0.actions:Find("content/3")
	}
	arg_2_0.curtainTF = arg_2_0._tf:Find("AD/curtain")
	arg_2_0.startLabel = arg_2_0.curtainTF:Find("start_label")
	arg_2_0.ABtn = arg_2_0._tf:Find("AD/A_btn")
	arg_2_0.BBtn = arg_2_0._tf:Find("AD/B_btn")
	arg_2_0.joyStick = arg_2_0._tf:Find("AD/joyStick")

	return
end

function var_0_0.DoCurtainUp(arg_3_0, arg_3_1)
	local var_3_0 = getProxy(SettingsProxy)

	if var_3_0:IsShowBeatMonseterNianCurtain() then
		var_3_0:SetBeatMonseterNianFlag()
		arg_3_0:StartCurtainUp(arg_3_1)
	else
		arg_3_1()
	end

	return
end

function var_0_0.StartCurtainUp(arg_4_0, arg_4_1)
	setActive(arg_4_0.curtainTF, true)
	LeanTween.color(arg_4_0.curtainTF, Color.white, var_0_1):setFromColor(Color.black):setOnComplete(System.Action(function()
		setActive(arg_4_0.startLabel, true)
		blinkAni(arg_4_0.startLabel, var_0_2, 2):setOnComplete(System.Action(function()
			LeanTween.alpha(arg_4_0.curtainTF, 0, var_0_3):setFrom(1)
			LeanTween.alpha(arg_4_0.startLabel, 0, var_0_3):setFrom(1):setOnComplete(System.Action(arg_4_1))

			return
		end))

		return
	end))

	return
end

function var_0_0.OnInited(arg_7_0)
	arg_7_0:OnTrigger(arg_7_0.ABtn, function()
		if arg_7_0.attackCnt <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_hit_monster_nocount"))

			return false
		end

		if arg_7_0.hp <= 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("activity_hit_monster_reset_tip"),
				onYes = function()
					arg_7_0.controller:ReStartGame()

					return
				end
			})

			return false
		end

		return true
	end, function()
		arg_7_0.controller:Input(BeatMonsterNianConst.ACTION_NAME_A)

		return
	end)
	arg_7_0:OnTrigger(arg_7_0.BBtn, function()
		if arg_7_0.attackCnt <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_hit_monster_nocount"))

			return false
		end

		if arg_7_0.hp <= 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("activity_hit_monster_reset_tip"),
				onYes = function()
					arg_7_0.controller:ReStartGame()

					return
				end
			})

			return false
		end

		return true
	end, function()
		arg_7_0.controller:Input(BeatMonsterNianConst.ACTION_NAME_B)

		return
	end)
	arg_7_0:OnJoyStickTrigger(arg_7_0.joyStick, function()
		if arg_7_0.attackCnt <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("activity_hit_monster_nocount"))

			return false
		end

		if arg_7_0.hp <= 0 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("activity_hit_monster_reset_tip"),
				onYes = function()
					arg_7_0.controller:ReStartGame()

					return
				end
			})

			return false
		end

		return true
	end, function(arg_12_0)
		if arg_12_0 > 0 then
			arg_7_0.controller:Input(BeatMonsterNianConst.ACTION_NAME_R)
		elseif arg_12_0 < 0 then
			arg_7_0.controller:Input(BeatMonsterNianConst.ACTION_NAME_L)
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

	arg_14_0.fuShun:SetInteger("hp", arg_14_1)
	arg_14_0.nian:SetInteger("hp", arg_14_1)

	return
end

function var_0_0.OnUIHpUpdate(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	LeanTween.value(arg_15_0.hpTF.gameObject, arg_15_0.hpTF.value, arg_15_1 / arg_15_2, 0.3):setOnUpdate(System.Action_float(function(arg_16_0)
		arg_15_0.hpTF.value = arg_16_0

		return
	end)):setOnComplete(System.Action(function()
		if arg_15_3 then
			arg_15_3()
		end

		return
	end))

	return
end

function var_0_0.OnAddFuShun(arg_18_0, arg_18_1)
	arg_18_0.fuShun = arg_18_0.fushun:GetComponent(typeof(Animator))

	arg_18_0.fuShun:SetInteger("hp", arg_18_1)

	return
end

function var_0_0.OnAddMonsterNian(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.hp = arg_19_1
	arg_19_0.nian = arg_19_0.monsterNian:GetComponent(typeof(Animator))
	arg_19_0.hpTF.value = arg_19_1 / arg_19_2

	arg_19_0.nian:SetInteger("hp", arg_19_1)

	return
end

function var_0_0.OnChangeFuShunAction(arg_20_0, arg_20_1)
	arg_20_0.fuShun:SetTrigger(arg_20_1)

	return
end

function var_0_0.OnChangeNianAction(arg_21_0, arg_21_1)
	arg_21_0.nian:SetTrigger(arg_21_1)

	return
end

function var_0_0.BanJoyStick(arg_22_0, arg_22_1)
	setActive(arg_22_0.joyStick:Find("ban"), arg_22_1)

	GetOrAddComponent(arg_22_0.joyStick, typeof(EventTriggerListener)).enabled = not arg_22_1

	return
end

function var_0_0.OnInputChange(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1 and arg_23_1 ~= ""

	if arg_23_1 and arg_23_1 ~= "" then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.actionKeys) do
			local var_23_1 = string.sub(arg_23_1, iter_23_0, iter_23_0) or ""

			setActive(iter_23_1:Find("A"), var_23_1 == BeatMonsterNianConst.ACTION_NAME_A)
			setActive(iter_23_1:Find("L"), var_23_1 == BeatMonsterNianConst.ACTION_NAME_L)
			setActive(iter_23_1:Find("R"), var_23_1 == BeatMonsterNianConst.ACTION_NAME_R)
			setActive(iter_23_1:Find("B"), var_23_1 == BeatMonsterNianConst.ACTION_NAME_B)
		end
	end

	setActive(arg_23_0.actions, var_23_0)
	arg_23_0:BanJoyStick(#arg_23_1 == 2)

	return
end

function var_0_0.PlayStory(arg_24_0, arg_24_1, arg_24_2)
	pg.NewStoryMgr.GetInstance():Play(arg_24_1, arg_24_2)

	return
end

function var_0_0.DisplayAwards(arg_25_0, arg_25_1, arg_25_2)
	pg.m02:sendNotification(ActivityProxy.ACTIVITY_SHOW_AWARDS, {
		awards = arg_25_1,
		callback = arg_25_2
	})

	return
end

function var_0_0.Dispose(arg_26_0)
	pg.DelegateInfo.Dispose(arg_26_0)

	return
end

function var_0_0.OnTrigger(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_1:Find("off")
	local var_27_1 = true
	local var_27_2 = GetOrAddComponent(arg_27_1, typeof(EventTriggerListener))

	var_27_2:AddPointDownFunc(function(arg_28_0, arg_28_1)
		var_27_1 = arg_27_2()

		if var_27_1 then
			setActive(var_27_0, false)
		end

		return
	end)
	var_27_2:AddPointUpFunc(function(arg_29_0, arg_29_1)
		if var_27_1 then
			setActive(var_27_0, true)

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
	local var_30_1 = arg_30_1:Find("l")
	local var_30_2 = arg_30_1:Find("r")
	local var_30_3 = GetOrAddComponent(arg_30_1, typeof(EventTriggerListener))
	local var_30_4
	local var_30_5 = false

	var_30_3:AddBeginDragFunc(function(arg_31_0, arg_31_1)
		var_30_5 = arg_30_2()
		var_30_4 = arg_31_1.position

		return
	end)
	var_30_3:AddDragFunc(function(arg_32_0, arg_32_1)
		if not var_30_5 then
			return
		end

		local var_32_0 = arg_32_1.position.x - var_30_4.x

		setActive(var_30_0, arg_32_1.position.x - var_30_4.x == 0)
		setActive(var_30_1, var_32_0 < 0)
		setActive(var_30_2, var_32_0 > 0)

		return
	end)
	var_30_3:AddDragEndFunc(function(arg_33_0, arg_33_1)
		if not var_30_5 then
			return
		end

		arg_30_3(arg_33_1.position.x - var_30_4.x)
		setActive(var_30_0, true)
		setActive(var_30_1, false)
		setActive(var_30_2, false)

		return
	end)

	return
end

return var_0_0
