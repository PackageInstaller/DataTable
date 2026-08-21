local var_0_0 = class("MonopolyCar2024Game")
local var_0_1 = 88
local var_0_2 = 43
local var_0_3 = "redcar"
local var_0_4 = MonopolyCar2024Const.map_dic
local var_0_5 = 0.6
local var_0_6 = {
	"sitelasibao_2",
	"u96_4",
	"xiafei_4"
}
local var_0_7 = {
	Vector3(56, 121, 0),
	Vector3(-557, -447, 0),
	Vector3(590, -344, 0)
}
local var_0_8 = "B-stand"
local var_0_9 = "F-stand"
local var_0_10 = "B-walk"
local var_0_11 = "F-walk"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_2
	arg_1_0._event = arg_1_3

	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.cg = GetOrAddComponent(arg_1_0._tf, typeof(CanvasGroup))
	arg_1_0.maskTr = findTF(arg_1_0._tf.parent, "mask")
	arg_1_0.pickPage = arg_1_0:NewPickPage(arg_1_2, arg_1_3)
	arg_1_0.bubblePage = arg_1_0:NewBubblePage(arg_1_2, arg_1_3)
	arg_1_0.awardWindow = AwardWindow.New(arg_1_2, arg_1_3)
	arg_1_0.resultPage = MonopolyCar2024TotalRewardPanel.New(arg_1_2, arg_1_3)
	arg_1_0.awardCollector = MonopolyCar2024GameAwardCollector.New()

	arg_1_0:UpdateActData(arg_1_1)

	return
end

function var_0_0.UpdateStory(arg_2_0)
	return
end

function var_0_0.NewBubblePage(arg_3_0, arg_3_1, arg_3_2)
	return MonopolyCar2024BubblePage.New(arg_3_1:Find("bubble"), arg_3_2)
end

function var_0_0.NewPickPage(arg_4_0, arg_4_1, arg_4_2)
	return MonopolyCar2024PickPage.New(arg_4_1, arg_4_2)
end

function var_0_0.emit(arg_5_0, ...)
	arg_5_0._event:emit(...)

	return
end

function var_0_0.UpdateActData(arg_6_0, arg_6_1)
	arg_6_0.actId = arg_6_1.id

	local var_6_0 = arg_6_1.data1_list[1] or 0

	arg_6_0.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - arg_6_1.data1) / 0) * arg_6_1:getDataConfig("daily_time") + var_6_0
	arg_6_0.useCount = arg_6_1.data1_list[2] or 0
	arg_6_0.leftCount = arg_6_0.totalCnt - arg_6_0.useCount
	arg_6_0.dialogRecorder = arg_6_1.data4_list
	arg_6_0.pickCharList = arg_6_1.data3_list
	arg_6_0.pos = math.max(arg_6_1.data2, 1)
	arg_6_0.step = arg_6_1.data3 or 0
	arg_6_0.effectId = arg_6_1.data4 or 0
	arg_6_0.turnCnt = arg_6_1.data1_list[3] or 0
	arg_6_0.selectedShipId = arg_6_1.data1_list[4] or 0
	arg_6_0.storys = arg_6_1:getDataConfig("story") or {}
	arg_6_0.lapReward = arg_6_1:getDataConfig("sum_lap_reward_show") or {}
	arg_6_0.titles = {
		i18n("MonopolyCar2024Game_title1"),
		i18n("MonopolyCar2024Game_title2")
	}
	arg_6_0.pickableShipId = _.map(arg_6_1:getDataConfig("ship_reward"), function(arg_7_0)
		return arg_7_0[1]
	end)
	arg_6_0.spEvents = {}

	local var_6_1 = arg_6_1:getDataConfig("ship_dialog") or {}

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		arg_6_0.spEvents[iter_6_1[1]] = iter_6_1[2]
	end

	arg_6_0.cacheTurnCnt = arg_6_0.turnCnt

	return
end

function var_0_0.Setup(arg_8_0)
	arg_8_0:BlocksRaycasts(false)
	seriesAsync({
		function(arg_9_0)
			arg_8_0:InitUI()
			arg_8_0:InitMap()
			arg_8_0:InitCar(arg_9_0)

			return
		end,
		function(arg_10_0)
			arg_8_0:InitCheerLeaders(arg_10_0)

			return
		end,
		function(arg_11_0)
			arg_8_0:OnEnterDone(arg_11_0)

			return
		end,
		function(arg_12_0)
			arg_8_0:RegisterUI()
			arg_8_0:UpdateUI()
			arg_8_0:SetUpMainLoop()
			arg_8_0:CheckEventAndMove(arg_12_0)

			return
		end,
		function(arg_13_0)
			arg_8_0:CheckSpEvent({
				finished = true,
				shipId = arg_8_0.selectedShipId
			}, arg_13_0)

			return
		end,
		function(arg_14_0)
			arg_8_0:CheckPickCharacter(arg_14_0)

			return
		end,
		function(arg_15_0)
			arg_8_0:InitDone(arg_15_0)

			return
		end,
		function(arg_16_0)
			arg_8_0:CheckMainStorys(arg_16_0)

			return
		end
	}, function()
		arg_8_0:BlocksRaycasts(true)

		return
	end)

	return
end

function var_0_0.CheckMainStorys(arg_18_0, arg_18_1)
	arg_18_1()

	return
end

function var_0_0.OnEnterDone(arg_19_0, arg_19_1)
	arg_19_1()

	return
end

function var_0_0.InitDone(arg_20_0, arg_20_1)
	arg_20_1()

	return
end

function var_0_0.InitCheerLeaders(arg_21_0, arg_21_1)
	arg_21_0.cheerLeaders = {}

	for iter_21_0, iter_21_1 in ipairs(var_0_6) do
		table.insert({}, function(arg_22_0)
			PoolMgr.GetInstance():GetSpineChar(iter_21_1, true, function(arg_23_0)
				arg_23_0.transform.localScale = Vector3(0.6, 0.6, 1)
				arg_23_0.transform.localPosition = var_0_7[iter_21_0]

				arg_23_0.transform:SetParent(arg_21_0._tf, false)
				arg_23_0:GetComponent(typeof(SpineAnimUI)):SetAction("stand", 0)

				arg_21_0.cheerLeaders[iter_21_1] = arg_23_0

				arg_22_0()

				return
			end)

			return
		end)
	end

	seriesAsync({}, arg_21_1)

	return
end

function var_0_0.SetUpMainLoop(arg_24_0)
	arg_24_0.handle = arg_24_0.handle or UpdateBeat:CreateListener(arg_24_0.Update, arg_24_0)

	UpdateBeat:AddListener(arg_24_0.handle)

	return
end

function var_0_0.Update(arg_25_0)
	arg_25_0:MoveCar()

	return
end

function var_0_0.InitUI(arg_26_0)
	arg_26_0.tplMapCell = findTF(arg_26_0._tf, "mapContainer/tplMapCell")
	arg_26_0.mapContainer = findTF(arg_26_0._tf, "mapContainer")
	arg_26_0.car = findTF(arg_26_0._tf, "mapContainer/char")
	arg_26_0.btnStart = findTF(arg_26_0._tf, "btnStart")
	arg_26_0.btnHelp = findTF(arg_26_0._tf, "btnHelp")
	arg_26_0.topTr = arg_26_0._tf.parent:Find("top")
	arg_26_0.btnAuto = findTF(arg_26_0.topTr, "btnAuto")
	arg_26_0.btnAutoImg = findTF(arg_26_0.topTr, "btnAuto"):GetComponent(typeof(Image))
	arg_26_0.btnAutoSel = findTF(arg_26_0.topTr, "btnAuto/Text")
	arg_26_0.btnAutoAct = findTF(arg_26_0.topTr, "btnAuto/actvie")
	arg_26_0.btnBack = findTF(arg_26_0._tf.parent, "adapt_1/btnBack")
	arg_26_0.labelLeftCount = findTF(arg_26_0.btnStart, "Text")
	arg_26_0.register = findTF(arg_26_0._tf, "register")
	arg_26_0.registerTxt = findTF(arg_26_0._tf, "register/Text")
	arg_26_0.rollStep = findTF(arg_26_0._tf, "step")
	arg_26_0.hideList = {
		arg_26_0.btnStart,
		arg_26_0.btnHelp,
		arg_26_0.btnBack,
		arg_26_0.btnAuto,
		arg_26_0.register
	}

	arg_26_0:SetRollStepAct(false)

	return
end

function var_0_0.RegisterUI(arg_27_0)
	onButton(arg_27_0, arg_27_0.btnStart, function()
		if arg_27_0.leftCount and arg_27_0.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		arg_27_0:Roll()

		return
	end, SFX_PANEL)
	onButton(arg_27_0, arg_27_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_car2024.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_27_0, arg_27_0.btnAuto, function()
		if arg_27_0.autoFlag then
			arg_27_0:DisableAuto()
		else
			arg_27_0:EnableAuto()
		end

		return
	end, SFX_PANEL)
	onButton(arg_27_0, arg_27_0.btnBack, function()
		arg_27_0:emit(BaseUI.ON_CLOSE)

		return
	end, SFX_BACK)
	onButton(arg_27_0, arg_27_0.register, function()
		arg_27_0.awardWindow:ExecuteAction("Flush", arg_27_0.lapReward, arg_27_0.turnCnt - 1, arg_27_0.titles)

		return
	end, SFX_PANEL)
	arg_27_0:UpdateAutoBtn()

	return
end

function var_0_0.DisableAuto(arg_33_0)
	arg_33_0.autoFlag = false

	arg_33_0:DisplayResult()
	arg_33_0:UpdateAutoBtn()

	return
end

function var_0_0.EnableAuto(arg_34_0)
	if arg_34_0.rolling then
		return
	end

	if arg_34_0.leftCount <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

		return
	end

	if arg_34_0.useCount < 10 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("MonopolyCar2024Game_lock_auto_tip", arg_34_0.useCount))

		return
	end

	arg_34_0.awardCollector:SetUp()

	arg_34_0.autoFlag = true

	arg_34_0:RollAuto()
	arg_34_0:UpdateAutoBtn()
	pg.TipsMgr.GetInstance():ShowTips(i18n("MonopolyCar2024Game_open_auto_tip"))

	return
end

function var_0_0.UpdateAutoBtn(arg_35_0)
	local var_35_0 = arg_35_0.useCount >= 10

	setActive(arg_35_0.btnAutoSel, arg_35_0.useCount >= 10)

	arg_35_0.btnAutoImg.enabled = not var_35_0

	setActive(arg_35_0.btnAutoAct, arg_35_0.autoFlag)

	return
end

function var_0_0.DisplayResult(arg_36_0)
	local var_36_0 = arg_36_0.awardCollector:Fetch()

	if #var_36_0 <= 0 then
		return
	end

	arg_36_0.resultPage:ExecuteAction("Show", var_36_0)

	return
end

function var_0_0.RollAuto(arg_37_0)
	if not arg_37_0.autoFlag then
		return
	end

	if arg_37_0.leftCount <= 0 then
		arg_37_0.autoFlag = false

		arg_37_0:DisplayResult()
		arg_37_0:UpdateAutoBtn()

		return
	end

	arg_37_0:Roll(function()
		arg_37_0:RollAuto()

		return
	end)

	return
end

function var_0_0.BlocksRaycasts(arg_39_0, arg_39_1)
	arg_39_0.cg.blocksRaycasts = arg_39_1

	setActive(arg_39_0.maskTr, not arg_39_1)

	arg_39_0.isBlocksRaycasts = not arg_39_1

	return
end

function var_0_0.Roll(arg_40_0, arg_40_1)
	local var_40_0 = 0

	arg_40_0:BlocksRaycasts(false)

	arg_40_0.rolling = true

	seriesAsync({
		function(arg_41_0)
			arg_40_0:emit(MonopolyCar2024Mediator.ON_START, arg_40_0.actId, function(arg_42_0)
				if arg_42_0 and arg_42_0 > 0 then
					var_40_0 = arg_42_0

					arg_41_0()
				end

				return
			end)

			return
		end,
		function(arg_43_0)
			arg_40_0:PlayRollAnimation(var_40_0, arg_43_0)

			return
		end,
		function(arg_44_0)
			arg_40_0:CheckSpEvent({
				result = var_40_0,
				shipId = arg_40_0.selectedShipId
			}, arg_44_0)

			return
		end,
		function(arg_45_0)
			arg_40_0:CheckEventAndMove(arg_45_0)

			return
		end,
		function(arg_46_0)
			arg_40_0:CheckSpStory(arg_40_0.selectedShipId, arg_46_0)

			return
		end,
		function(arg_47_0)
			arg_40_0:CheckSpEvent({
				finished = true,
				shipId = arg_40_0.selectedShipId
			}, arg_47_0)

			return
		end,
		function(arg_48_0)
			arg_40_0:CheckMainStorys(arg_48_0)

			return
		end
	}, function()
		arg_40_0:UpdateAutoBtn()
		arg_40_0:BlocksRaycasts(true)

		arg_40_0.rolling = false

		if arg_40_1 then
			arg_40_1()
		end

		return
	end)

	return
end

function var_0_0.CheckSpStory(arg_50_0, arg_50_1, arg_50_2)
	if not arg_50_0.mapCells[arg_50_0.pos] then
		arg_50_2()

		return
	end

	local var_50_0 = _.detect(pg.activity_event_monopoly_map[arg_50_0.mapCells[arg_50_0.pos].mapId].ship_event, function(arg_51_0)
		return arg_51_0[1] == arg_50_1
	end)

	if not var_50_0 then
		arg_50_2()

		return
	end

	local var_50_1 = var_50_0[2] or {}

	if #var_50_1 <= 0 then
		arg_50_2()

		return
	end

	local var_50_2 = var_50_1[math.random(1, #var_50_1)]

	arg_50_0:HideOrShowUI(false)

	if arg_50_0.autoFlag then
		pg.NewStoryMgr.GetInstance():ForceAutoPlay(var_50_2, function()
			arg_50_0:HideOrShowUI(true)
			arg_50_2()

			return
		end, true, true)
	else
		pg.NewStoryMgr.GetInstance():Play(var_50_2, function()
			arg_50_0:HideOrShowUI(true)
			arg_50_2()

			return
		end, true)
	end

	return
end

function var_0_0.PlayRollAnimation(arg_53_0, arg_53_1, arg_53_2)
	setText(findTF(arg_53_0.rollStep, "animroot/Image/Text"), "00")

	local var_53_0 = arg_53_0.btnStart:GetComponent(typeof(Animation))
	local var_53_1 = arg_53_0.btnStart:GetComponent(typeof(Animation)):GetComponent(typeof(DftAniEvent))
	local var_53_2 = findTF(arg_53_0.rollStep, "animroot"):GetComponent(typeof(Animation))
	local var_53_3 = findTF(arg_53_0.rollStep, "animroot"):GetComponent(typeof(Animation)):GetComponent(typeof(DftAniEvent))

	findTF(arg_53_0.rollStep, "animroot"):GetComponent(typeof(Animation)):GetComponent(typeof(DftAniEvent)):SetTriggerEvent(function()
		setText(findTF(arg_53_0.rollStep, "animroot/Image/Text"), "0" .. arg_53_1)

		return
	end)
	seriesAsync({
		function(arg_55_0)
			var_53_1:SetEndEvent(function()
				setActive(arg_53_0.btnStart, false)
				arg_55_0()

				return
			end)
			var_53_0:Play("anim_monopolycar_mainui_btn_hide")

			return
		end,
		function(arg_57_0)
			arg_53_0:SetRollStepAct(true)
			arg_57_0()

			return
		end,
		function(arg_58_0)
			var_53_3:SetEndEvent(function()
				arg_58_0()

				return
			end)
			var_53_2:Play("anim_monopolycar_mainui_step_0" .. arg_53_1)

			return
		end,
		function(arg_60_0)
			var_53_3:SetEndEvent(function()
				arg_53_0:SetRollStepAct(false)
				arg_60_0()

				return
			end)
			var_53_2:Play("anim_monopolycar_mainui_step_hide")

			return
		end
	}, function()
		setActive(arg_53_0.btnStart, true)
		var_53_0:Play("anim_monopolycar_mainui_btn_show")
		arg_53_2()

		return
	end)

	return
end

function var_0_0.SetRollStepAct(arg_63_0, arg_63_1)
	setActive(arg_63_0.rollStep, arg_63_1)

	return
end

function var_0_0.CheckEventAndMove(arg_64_0, arg_64_1)
	if arg_64_0.selectedShipId == 0 then
		arg_64_0:CheckPickCharacter(function()
			arg_64_0:CheckEventAndMove(arg_64_1)

			return
		end)
	elseif arg_64_0.effectId and arg_64_0.effectId > 0 then
		arg_64_0:CheckEvent(function()
			arg_64_0:CheckEventAndMove(arg_64_1)

			return
		end)
	elseif arg_64_0.step and arg_64_0.step > 0 then
		arg_64_0:CheckMove(function()
			arg_64_0:CheckEventAndMove(arg_64_1)

			return
		end)
	else
		arg_64_1()
	end

	return
end

function var_0_0.CheckEvent(arg_66_0, arg_66_1)
	if not arg_66_0.effectId or arg_66_0.effectId <= 0 then
		if arg_66_1 then
			arg_66_1()
		end

		return
	end

	local var_66_1 = {}

	seriesAsync({
		function(arg_67_0)
			if not pg.activity_event_monopoly_event[arg_66_0.effectId].story or tonumber(pg.activity_event_monopoly_event[arg_66_0.effectId].story) == 0 then
				arg_67_0()

				return
			end

			arg_66_0:HideOrShowUI(false)

			if arg_66_0.autoFlag then
				pg.NewStoryMgr.GetInstance():ForceAutoPlay(pg.activity_event_monopoly_event[arg_66_0.effectId].story, arg_67_0, true, true)
			else
				pg.NewStoryMgr.GetInstance():Play(pg.activity_event_monopoly_event[arg_66_0.effectId].story, arg_67_0, true, true)
			end

			return
		end,
		function(arg_68_0)
			arg_66_0:HideOrShowUI(true)
			arg_66_0:TriggerEvent(function(arg_69_0)
				var_66_1 = arg_69_0

				arg_68_0()

				return
			end)

			return
		end,
		function(arg_70_0)
			arg_66_0:ReadyMoveCar(var_66_1, arg_70_0)

			return
		end,
		function(arg_71_0)
			arg_66_0:CheckCountStory(arg_71_0)

			return
		end
	}, arg_66_1)

	return
end

function var_0_0.HideOrShowUI(arg_72_0, arg_72_1)
	for iter_72_0, iter_72_1 in ipairs(arg_72_0.hideList) do
		setActive(iter_72_1, arg_72_1)
	end

	return
end

function var_0_0.TriggerEvent(arg_73_0, arg_73_1)
	arg_73_0:emit(MonopolyCar2024Mediator.ON_TRIGGER, arg_73_0.actId, function(arg_74_0, arg_74_1)
		if arg_74_0 and #arg_74_0 >= 0 then
			arg_73_1(arg_74_0)
		end

		return
	end)

	return
end

function var_0_0.CheckCountStory(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0.useCount
	local var_75_1 = _.detect(arg_75_0.storys, function(arg_76_0)
		return arg_76_0[1] == var_75_0
	end)

	if var_75_1 then
		pg.NewStoryMgr.GetInstance():Play(var_75_1[2], arg_75_1)
	else
		arg_75_1()
	end

	return
end

function var_0_0.CheckSpEvent(arg_77_0, arg_77_1, arg_77_2)
	if arg_77_1.result and arg_77_1.result > 0 then
		arg_77_0:CheckRollResultForSpEvent(arg_77_1.result, arg_77_1.shipId)

		if arg_77_2 then
			arg_77_2()
		end
	elseif arg_77_1.repeatChat then
		arg_77_0:CheckRepeatCharForSpEvent(arg_77_1.shipId)

		if arg_77_2 then
			arg_77_2()
		end
	elseif arg_77_1.finished then
		arg_77_0:CheckFinishedForSpEvent(arg_77_1.shipId)

		if arg_77_2 then
			arg_77_2()
		end
	elseif arg_77_2 then
		arg_77_2()
	end

	return
end

function var_0_0.CheckFinishedForSpEvent(arg_78_0, arg_78_1)
	if arg_78_0.turnCnt <= arg_78_0.cacheTurnCnt then
		return
	end

	arg_78_0.cacheTurnCnt = arg_78_0.turnCnt

	local var_78_0 = _.select(arg_78_0.spEvents[arg_78_1], function(arg_79_0)
		return arg_79_0[1] == 4
	end)

	if #var_78_0 <= 0 then
		return
	end

	local var_78_1 = var_78_0[1][2] or {}

	arg_78_0.bubblePage:Show(arg_78_0.actId, arg_78_1, (arg_78_0:GetUnReadDialogue(var_78_1)))

	return
end

function var_0_0.CheckRepeatCharForSpEvent(arg_80_0, arg_80_1)
	if not table.contains(arg_80_0.pickCharList, arg_80_1) then
		return
	end

	local var_80_1 = arg_80_0.spEvents[arg_80_1] or {}
	local var_80_2 = var_80_0(var_80_1, function(arg_81_0)
		return arg_81_0[1] == 5
	end)

	if #var_80_2 <= 0 then
		return
	end

	local var_80_3 = var_80_2[1][2] or {}

	arg_80_0.bubblePage:Show(arg_80_0.actId, arg_80_1, (arg_80_0:GetUnReadDialogue(var_80_3)))

	return
end

function var_0_0.GetUnReadDialogue(arg_82_0, arg_82_1)
	for iter_82_0, iter_82_1 in ipairs(arg_82_1) do
		if not table.contains(arg_82_0.dialogRecorder, iter_82_1) then
			table.insert({}, iter_82_1)
		end
	end

	if #{} <= 0 then
		return arg_82_1[math.random(1, #arg_82_1)]
	end

	return ({})[math.random(1, #{})]
end

function var_0_0.CheckRollResultForSpEvent(arg_83_0, arg_83_1, arg_83_2)
	local var_83_0 = {
		{
			1,
			2
		},
		{
			3,
			4
		},
		{
			5,
			6
		}
	}

	assert(arg_83_0.spEvents[arg_83_2], arg_83_2)

	local var_83_1 = arg_83_0.spEvents[arg_83_2] or {}
	local var_83_2 = _.select(var_83_1, function(arg_84_0)
		local var_84_0 = var_83_0[arg_84_0[1]] or {
			99,
			99
		}

		return arg_83_1 == var_84_0[1] or arg_83_1 == var_84_0[2]
	end)

	if #var_83_2 <= 0 then
		return
	end

	local var_83_3 = var_83_2[1][2] or {}

	arg_83_0.bubblePage:Show(arg_83_0.actId, arg_83_2, (arg_83_0:GetUnReadDialogue(var_83_3)))

	return
end

function var_0_0.CheckMove(arg_85_0, arg_85_1)
	local var_85_0 = {}

	seriesAsync({
		function(arg_86_0)
			arg_85_0:emit(MonopolyCar2024Mediator.ON_MOVE, arg_85_0.actId, function(arg_87_0, arg_87_1, arg_87_2)
				if not arg_87_0 or not arg_87_1 or not arg_87_2 then
					warning(arg_87_0, arg_87_1, arg_87_2)

					return
				end

				var_85_0 = arg_87_1

				arg_86_0()

				return
			end)

			return
		end,
		function(arg_88_0)
			arg_85_0:ReadyMoveCar(var_85_0, arg_88_0)

			return
		end
	}, arg_85_1)

	return
end

function var_0_0.ReadyMoveCar(arg_89_0, arg_89_1, arg_89_2)
	if not arg_89_1 or #arg_89_1 <= 0 then
		if arg_89_2 then
			arg_89_2()
		end

		return
	end

	local var_89_0 = {}
	local var_89_2 = {}
	local var_89_3 = {}

	for iter_89_0 = 1, #arg_89_1 do
		if arg_89_0:CheckPathTurn(arg_89_1[iter_89_0]) then
			table.insert({}, arg_89_0.mapCells[arg_89_1[iter_89_0]].position)
			table.insert({}, arg_89_1[iter_89_0])
		elseif iter_89_0 == #arg_89_1 then
			table.insert({}, arg_89_0.mapCells[arg_89_1[iter_89_0]].position)
			table.insert({}, arg_89_1[iter_89_0])
		end
	end

	arg_89_0.speedX = 0
	arg_89_0.speedY = 0
	arg_89_0.baseSpeed = 6
	arg_89_0.baseASpeed = 0.1

	for iter_89_1 = 1, #{} do
		table.insert(var_89_0, function(arg_90_0)
			arg_89_0.moveComplete = arg_90_0
			arg_89_0.stopOnEnd = false
			arg_89_0.targetPosition = var_89_2[iter_89_1]
			arg_89_0.targetPosIndex = var_89_3[iter_89_1]
			arg_89_0.moveX = arg_89_0.targetPosition.x - arg_89_0.car.localPosition.x
			arg_89_0.moveY = arg_89_0.targetPosition.y - arg_89_0.car.localPosition.y
			arg_89_0.baseSpeedX = arg_89_0.baseSpeed * (arg_89_0.moveX / math.abs(arg_89_0.moveX))
			arg_89_0.baseASpeedX = arg_89_0.baseASpeed * (arg_89_0.moveX / math.abs(arg_89_0.moveX))
			arg_89_0.baseSpeedY = math.abs(arg_89_0.baseSpeedX) / (math.abs(arg_89_0.moveX) / arg_89_0.moveY)
			arg_89_0.baseASpeedY = math.abs(arg_89_0.baseASpeedX) / (math.abs(arg_89_0.moveX) / arg_89_0.moveY)

			if iter_89_1 == 1 then
				arg_89_0.speedX = 0
				arg_89_0.speedY = 0
			else
				arg_89_0.speedX = arg_89_0.baseSpeedX
				arg_89_0.speedY = arg_89_0.baseSpeedY
			end

			return
		end)
	end

	table.insert(var_89_0, function(arg_91_0)
		arg_89_0.moveComplete = nil

		arg_89_0:UpdateCarPos(arg_89_1[#arg_89_1], false)
		arg_91_0()

		return
	end)
	table.insert(var_89_0, function(arg_92_0)
		LeanTween.value(go(arg_89_0._tf), 1, 0, 0.1):setOnComplete(System.Action(arg_92_0))

		return
	end)
	seriesAsync(var_89_0, arg_89_2)

	return
end

function var_0_0.MoveCar(arg_93_0)
	if not arg_93_0.targetPosition then
		return
	end

	if math.abs(arg_93_0.targetPosition.x - arg_93_0.car.localPosition.x) <= 6.5 and math.abs(arg_93_0.targetPosition.y - arg_93_0.car.localPosition.y) <= 6.5 then
		arg_93_0.targetPosition = nil

		if arg_93_0.moveComplete then
			arg_93_0:UpdateCarPos(arg_93_0.targetPosIndex, true)
			arg_93_0.moveComplete()
		end
	end

	if math.abs(arg_93_0.speedX + arg_93_0.baseASpeedX) > math.abs(arg_93_0.baseSpeedX) then
		arg_93_0.speedX = arg_93_0.baseSpeedX or arg_93_0.speedX + arg_93_0.baseASpeedX

		if math.abs(arg_93_0.speedY + arg_93_0.baseASpeedY) > math.abs(arg_93_0.baseSpeedY) then
			arg_93_0.speedY = arg_93_0.baseSpeedY or arg_93_0.speedY + arg_93_0.baseASpeedY
			arg_93_0.car.localPosition = Vector3(arg_93_0.car.localPosition.x + arg_93_0.speedX, arg_93_0.car.localPosition.y + arg_93_0.speedY, 0)

			return
		end
	end
end

function var_0_0.CheckPathTurn(arg_94_0, arg_94_1)
	local var_94_0 = arg_94_1 + 1 > #arg_94_0.mapCells and 1 or arg_94_1 + 1

	if arg_94_1 - 1 < 1 then
		local var_94_1 = #arg_94_0.mapCells or arg_94_1 - 1

		if arg_94_0.mapCells[var_94_0].col == arg_94_0.mapCells[var_94_1].col or arg_94_0.mapCells[var_94_0].row == arg_94_0.mapCells[var_94_1].row then
			return false
		end

		return true
	end
end

function var_0_0.CheckPickCharacter(arg_95_0, arg_95_1)
	if arg_95_0.selectedShipId == 0 or #arg_95_0.pickCharList == 0 then
		arg_95_0.pickPage:ExecuteAction("Show", arg_95_0.actId, _.map(arg_95_0.pickCharList, function(arg_100_0)
			return table.indexof(arg_95_0.pickableShipId, arg_100_0)
		end), arg_95_0.autoFlag, arg_95_0.turnCnt, function(arg_96_0)
			arg_95_0:CheckSpEvent({
				repeatChat = true,
				shipId = arg_95_0.pickableShipId[arg_96_0]
			})
			arg_95_0:emit(MonopolyCar2024Mediator.ON_PICK, arg_95_0.actId, arg_95_0.pickableShipId[arg_96_0], function(arg_97_0)
				arg_95_0.pickPage:Hide()
				seriesAsync({
					function(arg_98_0)
						arg_95_0:ReadyMoveCar(arg_97_0, arg_98_0)

						return
					end,
					function(arg_99_0)
						arg_95_0:CheckEventAndMove(arg_99_0)

						return
					end
				}, arg_95_1)

				return
			end)

			return
		end)
	else
		arg_95_1()
	end

	return
end

function var_0_0.InitMap(arg_101_0)
	arg_101_0.mapCells = {}

	for iter_101_0 = 1, #var_0_4 do
		for iter_101_1 = 1, #var_0_4[iter_101_0] do
			if var_0_4[iter_101_0][iter_101_1] > 0 then
				local var_101_0 = cloneTplTo(arg_101_0.tplMapCell, arg_101_0.mapContainer, tostring(var_0_4[iter_101_0][iter_101_1]))
				local var_101_1 = Vector2(var_0_1 * (iter_101_1 - 1) + ({
					x = -(iter_101_0 - 1) * var_0_1,
					y = -(iter_101_0 - 1) * var_0_2
				}).x, -var_0_2 * (iter_101_1 - 1) + ({
					x = -(iter_101_0 - 1) * var_0_1,
					y = -(iter_101_0 - 1) * var_0_2
				}).y)

				var_101_0.localPosition = var_101_1
				var_101_0:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/MonopolyCar2024_atlas", pg.activity_event_monopoly_map[var_0_4[iter_101_0][iter_101_1]].icon)

				var_101_0:GetComponent(typeof(Image)):SetNativeSize()
				table.insert(arg_101_0.mapCells, {
					col = iter_101_1 - 1,
					row = iter_101_0 - 1,
					mapId = var_0_4[iter_101_0][iter_101_1],
					tf = var_101_0,
					icon = pg.activity_event_monopoly_map[var_0_4[iter_101_0][iter_101_1]].icon,
					position = var_101_1
				})
			end
		end
	end

	table.sort(arg_101_0.mapCells, function(arg_102_0, arg_102_1)
		return arg_102_0.mapId < arg_102_1.mapId
	end)

	return
end

function var_0_0.InitCar(arg_103_0, arg_103_1)
	PoolMgr.GetInstance():GetSpineChar(var_0_3, true, function(arg_104_0)
		arg_103_0.model = arg_104_0
		arg_103_0.model.transform.localScale = Vector3.one
		arg_103_0.model.transform.localPosition = Vector3.zero

		arg_103_0.model.transform:SetParent(arg_103_0.car, false)

		arg_103_0.anim = arg_103_0.model:GetComponent(typeof(SpineAnimUI))

		if arg_103_0.pos then
			arg_103_0:UpdateCarPos(arg_103_0.pos, false)
		end

		arg_103_1()

		return
	end)

	return
end

function var_0_0.UpdateCarPos(arg_105_0, arg_105_1, arg_105_2)
	if arg_105_0.model then
		assert(arg_105_0.mapCells[arg_105_1], arg_105_1)

		local var_105_0 = arg_105_0.mapCells[arg_105_1].position
		local var_105_2, var_105_3 = arg_105_0:GetCarMoveType(arg_105_0.mapCells[arg_105_1].mapId, arg_105_0.mapCells[arg_105_1 + 1 > #arg_105_0.mapCells and 1 or arg_105_1 + 1].mapId, arg_105_2)

		arg_105_0.car.localScale = var_105_3

		arg_105_0.anim:SetActionCallBack(nil)
		arg_105_0.anim:SetAction(var_105_2, 0)

		arg_105_0.car.localPosition = var_105_0

		arg_105_0.car:SetAsLastSibling()
	end

	return
end

function var_0_0.GetCarMoveType(arg_106_0, arg_106_1, arg_106_2, arg_106_3)
	local var_106_0 = {}
	local var_106_1 = {}

	for iter_106_0 = 1, #var_0_4 do
		for iter_106_1 = 1, #var_0_4[iter_106_0] do
			if var_0_4[iter_106_0][iter_106_1] == arg_106_1 then
				var_106_0 = {
					x = iter_106_1,
					y = iter_106_0
				}
			end

			if var_0_4[iter_106_0][iter_106_1] == arg_106_2 then
				var_106_1 = {
					x = iter_106_1,
					y = iter_106_0
				}
			end
		end
	end

	local var_106_2
	local var_106_3

	if var_106_1.y > var_106_0.y then
		var_106_2 = arg_106_3 and var_0_11 or var_0_9
		var_106_3 = Vector3(var_0_5, var_0_5, var_0_5)
	elseif var_106_1.y < var_106_0.y then
		var_106_2 = arg_106_3 and var_0_10 or var_0_8
		var_106_3 = Vector3(var_0_5, var_0_5, var_0_5)
	elseif var_106_1.x > var_106_0.x then
		var_106_2 = arg_106_3 and var_0_11 or var_0_9
		var_106_3 = Vector3(-var_0_5, var_0_5, var_0_5)
	elseif var_106_1.x < var_106_0.x then
		var_106_2 = arg_106_3 and var_0_10 or var_0_8
		var_106_3 = Vector3(-var_0_5, var_0_5, var_0_5)
	end

	return var_106_2, var_106_3
end

function var_0_0.UpdateUI(arg_107_0)
	setText(arg_107_0.labelLeftCount, arg_107_0.leftCount)
	setText(arg_107_0.registerTxt, arg_107_0.turnCnt - 1)

	return
end

function var_0_0.UpdateActivity(arg_108_0, arg_108_1)
	arg_108_0:UpdateActData(arg_108_1)
	arg_108_0:UpdateUI()

	return
end

function var_0_0.Dispose(arg_109_0)
	local var_109_0 = arg_109_0.cheerLeaders or {}

	for iter_109_0, iter_109_1 in pairs(var_109_0) do
		PoolMgr.GetInstance():ReturnSpineChar(iter_109_0, iter_109_1)
	end

	if arg_109_0.handle then
		UpdateBeat:RemoveListener(arg_109_0.handle)

		arg_109_0.handle = nil
	end

	if arg_109_0.awardWindow then
		arg_109_0.awardWindow:Destroy()

		arg_109_0.awardWindow = nil
	end

	if arg_109_0.pickPage then
		if arg_109_0.pickPage:isShowing() then
			arg_109_0.pickPage:Hide()
		end

		arg_109_0.pickPage:Destroy()

		arg_109_0.pickPage = nil
	end

	if arg_109_0.resultPage then
		arg_109_0.resultPage:Destroy()

		arg_109_0.resultPage = nil
	end

	if arg_109_0.awardCollector then
		arg_109_0.awardCollector:Dispose()

		arg_109_0.awardCollector = nil
	end

	arg_109_0.bubblePage:Dispose()
	pg.DelegateInfo.Dispose(arg_109_0)
	PoolMgr.GetInstance():ReturnSpineChar(var_0_3, arg_109_0.model)

	return
end

return var_0_0
