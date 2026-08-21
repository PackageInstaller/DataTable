local var_0_0 = class("NewNavalTacticsShipCard", import(".NewNavalTacticsBaseCard"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.skillNameTxt = findTF(arg_1_0._tf, "skill/name_Text"):GetComponent(typeof(Text))
	arg_1_0.skillIcon = findTF(arg_1_0._tf, "skill/icon"):GetComponent(typeof(Image))
	arg_1_0.skillExpSlider = findTF(arg_1_0._tf, "skill/exp"):GetComponent(typeof(Slider))
	arg_1_0.skillLevelTxt = findTF(arg_1_0._tf, "skill/level"):GetComponent(typeof(Text))
	arg_1_0.skillNextExp = findTF(arg_1_0._tf, "skill/next"):GetComponent(typeof(Text))
	arg_1_0.timeTxt = findTF(arg_1_0._tf, "timer_Text"):GetComponent(typeof(Text))
	arg_1_0.cancelBtn = findTF(arg_1_0._tf, "cancel_btn")
	arg_1_0.quickFinishBtn = findTF(arg_1_0._tf, "quick_finish_btn")

	onButton(arg_1_0, arg_1_0.cancelBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("tactics_lesson_cancel"),
			onYes = function()
				arg_1_0:OnCancel()

				return
			end
		})

		return
	end, SFX_CANCEL)
	onButton(arg_1_0, findTF(arg_1_0._tf, "skill"), function()
		arg_1_0:emit(NewNavalTacticsMediator.ON_SKILL, arg_1_0.skillVO:GetDisplayId(), arg_1_0.skillVO)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.quickFinishBtn, function()
		arg_1_0:emit(NewNavalTacticsMediator.ON_QUICK_FINISH, arg_1_0.student.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.LoadShipCard(arg_6_0)
	ResourceMgr.Inst:getAssetAsync("template/shipcardtpl", "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_7_0)
		local var_7_0 = Object.Instantiate(arg_7_0, arg_6_0._tf)

		var_7_0.transform.localScale = Vector3(1.28, 1.28, 1)
		var_7_0.transform.localPosition = Vector3(0, 251, 0)
		arg_6_0.shipCard = DockyardShipItem.New(var_7_0, ShipStatus.TAG_HIDE_ALL)

		arg_6_0:UpdateShipCard()

		return
	end), true, true)

	return
end

function var_0_0.OnUpdate(arg_8_0, arg_8_1)
	arg_8_0.student = arg_8_1
	arg_8_0.ship = getProxy(BayProxy):RawGetShipById(arg_8_0.student.shipId)
	arg_8_0.skillVO = ShipSkill.New(arg_8_0.ship.skills[arg_8_0.student:getSkillId(arg_8_0.ship)], arg_8_0.ship.id)

	arg_8_0:UpdateSkill()

	if not arg_8_0.shipCard then
		arg_8_0:LoadShipCard()
	else
		arg_8_0:UpdateShipCard()
	end

	arg_8_0:AddTimer()

	local var_8_0 = getProxy(NavalAcademyProxy)

	setActive(arg_8_0.quickFinishBtn, var_8_0:getDailyFinishCnt() > 0)

	return
end

function var_0_0.UpdateSkill(arg_9_0)
	arg_9_0.skillNameTxt.text = shortenString(arg_9_0.skillVO:GetName(), 8)
	arg_9_0.skillLevelTxt.text = arg_9_0.skillVO.level

	LoadSpriteAsync("skillicon/" .. arg_9_0.skillVO:GetIcon(), function(arg_10_0)
		arg_9_0.skillIcon.sprite = arg_10_0

		return
	end)

	if arg_9_0.skillVO:IsMaxLevel() then
		arg_9_0.skillNextExp.text = "MAX"
		arg_9_0.skillExpSlider.value = 1
	else
		local var_9_2 = arg_9_0.skillVO:GetNextLevelExp()

		arg_9_0.skillNextExp.text = arg_9_0.skillVO.exp .. "/" .. var_9_2
		arg_9_0.skillExpSlider.value = arg_9_0.skillVO.exp / var_9_2
	end

	return
end

function var_0_0.AddTimer(arg_11_0)
	arg_11_0:RemoveTimer()

	local var_11_0 = arg_11_0.student:getFinishTime()

	arg_11_0.timer = Timer.New(function()
		local var_12_0 = var_11_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_12_0 < 0 then
			arg_11_0:OnFinish()
		else
			local var_12_1 = arg_11_0.timeTxt

			var_12_1.text = pg.TimeMgr.GetInstance():DescCDTime(var_12_0)
		end

		return
	end, 1, -1)

	arg_11_0.timer:Start()
	arg_11_0.timer.func()

	return
end

function var_0_0.OnFinish(arg_13_0)
	arg_13_0:RemoveTimer()

	arg_13_0.timeTxt.text = ""

	arg_13_0:emit(NewNavalTacticsMediator.ON_CANCEL, arg_13_0.student.id, Student.CANCEL_TYPE_AUTO)

	return
end

function var_0_0.OnCancel(arg_14_0)
	arg_14_0:emit(NewNavalTacticsMediator.ON_CANCEL, arg_14_0.student.id, Student.CANCEL_TYPE_MANUAL)

	return
end

function var_0_0.RemoveTimer(arg_15_0)
	if arg_15_0.timer then
		arg_15_0.timer:Stop()

		arg_15_0.timer = nil
	end

	return
end

function var_0_0.UpdateShipCard(arg_16_0)
	if arg_16_0.ship.id == arg_16_0.shipID then
		return
	end

	arg_16_0.shipCard:update(arg_16_0.ship)

	arg_16_0.shipID = arg_16_0.ship.id

	return
end

function var_0_0.OnDispose(arg_17_0)
	arg_17_0:RemoveTimer()

	if LeanTween.isTweening(arg_17_0.skillExpSlider.gameObject) then
		LeanTween.cancel(arg_17_0.skillExpSlider.gameObject)
	end

	if LeanTween.isTweening(arg_17_0.skillNextExp.gameObject) then
		LeanTween.cancel(arg_17_0.skillNextExp.gameObject)
	end

	return
end

function var_0_0.DoAddExpAnim(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_2.level - arg_18_1.level > 0 then
		arg_18_0:DoLevelUpAnim(arg_18_1, arg_18_2, arg_18_3)
	else
		arg_18_0:DoUnLevelUpAnim(arg_18_1, arg_18_2, arg_18_3)
	end

	return
end

function var_0_0.DoLevelUpAnim(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	seriesAsync({
		function(arg_20_0)
			arg_19_0:Curr2One(arg_19_1, arg_20_0)

			return
		end,
		function(arg_21_0)
			arg_19_0:Zero2One(arg_19_1, arg_19_2, arg_21_0)

			return
		end,
		function(arg_22_0)
			arg_19_0:Zero2New(arg_19_2, arg_22_0)

			return
		end
	}, arg_19_3)

	return
end

function var_0_0.Curr2One(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:GetNextLevelExp()

	LeanTween.value(arg_23_0.skillExpSlider.gameObject, arg_23_1.exp / var_23_0, 1, 1 - arg_23_1.exp / var_23_0):setOnUpdate(System.Action_float(function(arg_24_0)
		arg_23_0.skillExpSlider.value = arg_24_0

		return
	end))
	LeanTween.value(arg_23_0.skillNextExp.gameObject, arg_23_1.exp, var_23_0, 1 - arg_23_1.exp / var_23_0 + 0.001):setOnUpdate(System.Action_float(function(arg_25_0)
		arg_23_0.skillNextExp.text = math.ceil(arg_25_0) .. "/" .. var_23_0

		return
	end)):setOnComplete(System.Action(function()
		arg_23_0.skillLevelTxt.text = arg_23_1.level + 1

		arg_23_2()

		return
	end))

	return
end

function var_0_0.Zero2One(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_1.level + 1 == arg_27_2.level then
		arg_27_3()

		return
	end

	local function var_27_0(arg_28_0)
		LeanTween.value(arg_27_0.skillExpSlider.gameObject, 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_29_0)
			arg_27_0.skillExpSlider.value = arg_29_0

			return
		end))
		LeanTween.value(arg_27_0.skillNextExp.gameObject, 0, ShipSkill.StaticGetNextLevelExp(var_0), 0.3 + 0.001):setOnUpdate(System.Action_float(function(arg_30_0)
			arg_27_0.skillNextExp.text = math.ceil(arg_30_0) .. "/" .. var_0

			return
		end)):setOnComplete(System.Action(function()
			arg_27_0.skillLevelTxt.text = var_0 + 1
			var_0 = var_0 + 1

			arg_28_0()

			return
		end))

		return
	end

	for iter_27_0 = 1, arg_27_2.level - arg_27_1.level - 1 do
		table.insert({}, var_27_0)
	end

	seriesAsync({}, arg_27_3)

	return
end

function var_0_0.Zero2New(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_1:GetNextLevelExp()

	if arg_32_1.exp / var_32_0 == 0 or arg_32_1:IsMaxLevel() then
		arg_32_2()

		return
	end

	LeanTween.value(arg_32_0.skillExpSlider.gameObject, 0, arg_32_1.exp / var_32_0, arg_32_1.exp / var_32_0):setOnUpdate(System.Action_float(function(arg_33_0)
		arg_32_0.skillExpSlider.value = arg_33_0

		return
	end))
	LeanTween.value(arg_32_0.skillNextExp.gameObject, 0, var_32_0, arg_32_1.exp / var_32_0 + 0.001):setOnUpdate(System.Action_float(function(arg_34_0)
		arg_32_0.skillNextExp.text = math.ceil(arg_34_0) .. "/" .. var_32_0

		return
	end)):setOnComplete(System.Action(arg_32_2))

	return
end

function var_0_0.DoUnLevelUpAnim(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_2:GetNextLevelExp()

	LeanTween.value(arg_35_0.skillExpSlider.gameObject, arg_35_1.exp / var_35_0, arg_35_2.exp / var_35_0, 1):setOnUpdate(System.Action_float(function(arg_36_0)
		arg_35_0.skillExpSlider.value = arg_36_0

		return
	end))
	LeanTween.value(arg_35_0.skillNextExp.gameObject, arg_35_1.exp, arg_35_2.exp, 1.001):setOnUpdate(System.Action_float(function(arg_37_0)
		arg_35_0.skillNextExp.text = math.ceil(arg_37_0) .. "/" .. var_35_0

		return
	end)):setOnComplete(System.Action(arg_35_3))

	return
end

return var_0_0
