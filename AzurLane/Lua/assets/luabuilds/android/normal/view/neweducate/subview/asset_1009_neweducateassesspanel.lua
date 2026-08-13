class = var_0_10000

local var_0_0 = "NewEducateAssessPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.CRIT_PERCENT = 200
var_0_1.SPEED = 3

function var_0_1.getUIName(arg_1_0)
	return "NewEducateAssessPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.rootTF = var_1.Find(var_2_0, "root")

	local var_2_1 = arg_2_0.rootTF

	arg_2_0.assessTF = var_1.Find(var_2_1, "assess")

	local var_2_2 = arg_2_0.assessTF

	arg_2_0.bgTF = var_1.Find(var_2_2, "bg")

	local var_2_3 = arg_2_0.assessTF

	arg_2_0.endlessTF = var_1.Find(var_2_3, "endless")

	local var_2_4 = arg_2_0.assessTF

	arg_2_0.damageBlood = var_1.Find(var_2_4, "content/blood/red")

	local var_2_5 = arg_2_0.assessTF
	local var_2_6 = var_1.Find(var_2_5, "content/blood/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.bloodText = var_2_7(var_2_6, var_3(var_1_10004))

	local var_2_8 = arg_2_0.assessTF

	arg_2_0.bossTF = var_1.Find(var_2_8, "content/boss")

	local var_2_9 = arg_2_0.assessTF

	arg_2_0.roleTF = var_1.Find(var_2_9, "content/role")

	local var_2_10 = arg_2_0.assessTF

	arg_2_0.damageTF = var_1.Find(var_2_10, "content/damage")

	local var_2_11 = arg_2_0.assessTF

	arg_2_0.damageCritTF = var_1.Find(var_2_11, "content/damage_crit")

	local var_2_12 = arg_2_0.assessTF
	local var_2_13 = var_1.Find(var_2_12, "content/attrs")

	UIItemList = var_2_12
	arg_2_0.attrUIList = var_2_12.New(var_2_13, var_2_13:Find("tpl"))

	local var_2_14 = arg_2_0.assessTF

	arg_2_0.resultTF = var_2.Find(var_2_14, "content/result")

	local var_2_15 = arg_2_0.resultTF

	arg_2_0.rankTF = var_2.Find(var_2_15, "rank")

	local var_2_16 = arg_2_0.rootTF

	arg_2_0.tipTF = var_2.Find(var_2_16, "tip")

	local var_2_17 = arg_2_0.tipTF

	arg_2_0.assessTextTF = var_2.Find(var_2_17, "content/assess/Text")
	setText = var_2

	local var_2_18 = arg_2_0.assessTextTF

	i18n = var_4

	var_2(var_2_18, var_4("child2_assess_start_tip"))

	local var_2_19 = arg_2_0.tipTF

	arg_2_0.targetTextTF = var_2.Find(var_2_19, "content/target/Text")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.AdjustSpeed(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	local var_3_3 = arg_3_0.attrUIList

	var_1.make(var_3_3, function(arg_5_0, arg_5_1, arg_5_2)
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventInit then
			arg_5_2.name = arg_3_0.attrIds[arg_5_1 + 1]
			pg = var_4

			local var_5_0 = var_4.child2_attr[var_3].icon

			LoadImageSpriteAtlasAsync = var_2_10005

			var_2_10005("ui/neweducateassesspanel_atlas", var_5_0, arg_5_2)

			LoadImageSpriteAtlasAsync = var_2_10005

			var_2_10005("ui/neweducateassesspanel_atlas", var_5_0 .. "_l", arg_5_2:Find("selected"))
		else
			UIItemList = var_3

			if arg_5_0 == var_3.EventUpdate then
				local var_5_1 = arg_3_0.attrIds[arg_5_1 + 1]

				setActive = var_4

				var_4(arg_5_2:Find("selected"), arg_3_0.curAttrIdx == arg_5_1 + 1)

				setText = var_4

				local var_5_2 = arg_5_2:Find("value")
				local var_5_3 = arg_3_0.contextData.char

				var_4(var_5_2, var_6.GetAttr(var_5_3, var_5_1))

				local var_5_4 = arg_3_0.curAttrIdx == arg_5_1 + 1 and "47b9f4" or "6f6f82"

				setTextColor = var_5

				local var_5_5 = arg_5_2
				local var_5_6 = arg_5_2.Find(var_5_5, "value")

				Color = var_5_5

				var_5(var_5_6, var_5_5.NewHex(var_5_4))
			end
		end

		return
	end)

	return
end

function var_0_1.Show(arg_6_0, arg_6_1)
	var_0_1.super.Show(arg_6_0)

	arg_6_0.callback = arg_6_1

	arg_6_0:OverlayPanel(arg_6_0._tf, {
		groupDelta = 1
	})
	arg_6_0:InitData()
	arg_6_0:InitStaticUI()
	arg_6_0:PlayAnim()

	return
end

function var_0_1.InitData(arg_7_0)
	arg_7_0.speed = 1

	local var_7_0 = arg_7_0.contextData.char
	local var_7_1 = var_1.GetRoundData(var_7_0)

	arg_7_0.isEndless = var_1.IsEndless(var_7_1)
	pg = var_2

	local var_7_2 = var_2.child2_target[var_1:getConfig("target_id")].display
	local var_7_3 = arg_7_0.contextData.char

	arg_7_0.rank = var_7_2[var_4.GetAssessRankIdx(var_7_3)]
	arg_7_0.totolHP = var_2.attr_sum * var_1:GetExtraFactor()

	local var_7_4 = arg_7_0.contextData.char

	arg_7_0.isFail = var_3.GetAttrSum(var_7_4) < arg_7_0.totolHP
	arg_7_0.damageHP = 0

	local var_7_5 = arg_7_0.contextData.char

	arg_7_0.attrIds = var_3.GetAttrIds(var_7_5)
	arg_7_0.curAttrIdx = 1

	local var_7_6 = arg_7_0.contextData.char

	arg_7_0.tag = var_3.GetPersonalityTag(var_7_6)

	local var_7_7 = arg_7_0.contextData.char

	arg_7_0.charConfig = var_3.getConfig(var_7_7, "spine_char")
	arg_7_0.standardValue = arg_7_0.totolHP / #arg_7_0.attrIds

	local var_7_8 = arg_7_0.contextData.char
	local var_7_9 = var_3.getConfig(var_7_8, "exam_action")[arg_7_0.tag]

	arg_7_0.actionConfig = {}
	underscore = var_4

	var_4.each(var_7_9, function(arg_8_0)
		table = var_2_10001

		var_2_10001.insert(arg_7_0.actionConfig, {
			value = arg_7_0.standardValue * arg_8_0[1] / 100,
			name = arg_8_0[2]
		})

		return
	end)

	table = var_4

	local var_7_10 = var_4.sort
	local var_7_11 = arg_7_0.actionConfig

	CompareFuncs = var_6

	var_7_10(var_7_11, var_6({
		function(arg_9_0)
			return -arg_9_0.value
		end
	}))

	if arg_7_0.isEndless then
		local var_7_12, var_7_13, var_7_14 = var_1:GetEndlessProgressInfos()

		setText = var_7

		local var_7_15 = arg_7_0.targetTextTF

		i18n = var_1_10009

		var_7(var_7_15, var_1_10009("child2_assess_tip_target", var_7_14))
	else
		local var_7_16, var_7_17, var_7_18 = var_1:GetProgressInfo()

		setText = var_7

		local var_7_19 = arg_7_0.targetTextTF

		i18n = var_1_10009

		var_7(var_7_19, var_1_10009("child2_assess_tip_target", var_7_18))
	end

	return
end

function var_0_1.GetAtkActionName(arg_10_0, arg_10_1)
	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.actionConfig) do
		if arg_10_1 > iter_10_1.value then
			return iter_10_1.name
		end
	end

	return arg_10_0.actionConfig[#arg_10_0.actionConfig].name
end

function var_0_1.InitStaticUI(arg_11_0)
	local var_11_0 = arg_11_0.contextData.char
	local var_11_1 = var_1.GetRoundData(var_11_0)
	local var_11_2 = var_1.IsEndless(var_11_1)

	setActive = var_11_1

	var_11_1(arg_11_0.endlessTF, var_11_2)

	if var_11_2 then
		var_11_1 = var_1:GetWave()

		local var_11_3 = var_1
		local var_11_4 = var_1.GetHeighestWave(var_11_3)

		setText = var_11_3

		local var_11_5 = arg_11_0.endlessTF
		local var_11_6 = var_6.Find(var_11_5, "Text")

		i18n = var_11_5

		var_11_3(var_11_6, var_11_5("child2_endless_assest_wave", var_11_1))

		setActive = var_11_3

		local var_11_7 = arg_11_0.endlessTF

		var_11_3(var_6.Find(var_11_7, "new"), var_11_4 < var_11_1)
	end

	LoadImageSpriteAtlasAsync = var_11_1

	var_11_1("ui/neweducateassesspanel_atlas", "bg_" .. arg_11_0.tag, arg_11_0.bgTF)

	removeAllChildren = var_11_1

	var_11_1(arg_11_0.bossTF)

	removeAllChildren = var_11_1

	var_11_1(arg_11_0.roleTF)

	setActive = var_11_1

	var_11_1(arg_11_0.resultTF, false)

	setActive = var_11_1

	var_11_1(arg_11_0.damageTF, false)

	setActive = var_11_1

	var_11_1(arg_11_0.damageCritTF, false)

	setActive = var_11_1

	local var_11_8 = arg_11_0.resultTF

	var_11_1(var_4.Find(var_11_8, "title_gold"), arg_11_0.rank == "S")

	setActive = var_11_1

	local var_11_9 = arg_11_0.resultTF

	var_11_1(var_4.Find(var_11_9, "title_red"), arg_11_0.rank ~= "S")

	LoadImageSpriteAtlasAsync = var_11_1

	var_11_1("ui/neweducateassesspanel_atlas", arg_11_0.rank, arg_11_0.rankTF)

	setFillAmount = var_11_1

	var_11_1(arg_11_0.damageBlood, 0)

	local var_11_10 = arg_11_0.bloodText

	var_11_10.text = arg_11_0.totolHP - arg_11_0.damageHP .. "/" .. arg_11_0.totolHP
	table = var_11_10

	var_11_10.sort(arg_11_0.attrIds)

	local var_11_11 = arg_11_0.attrUIList

	var_3.align(var_11_11, #arg_11_0.attrIds)

	return
end

function var_0_1.ShowResult(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.resultTF, true)

	local var_12_0 = arg_12_0.contextData.char
	local var_12_1 = var_1.GetAssessRankIdx(var_12_0)
	local var_12_2

	if arg_12_0.isEndless then
		var_12_2 = arg_12_0.isFail
	end

	local var_12_3 = arg_12_0
	local var_12_4 = arg_12_0.emit

	NewEducateMainMediator = var_1_10005

	var_12_4(var_12_3, var_1_10005.ON_SET_ASSESS_RANK, var_12_1, var_12_2, function()
		existCall = var_2_10000

		var_2_10000(arg_12_0.callback)

		return
	end)

	return
end

function var_0_1.PlayAnim(arg_14_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_15_0)
			local var_15_0 = arg_14_0

			var_1.ShowTip(var_15_0, arg_15_0)

			return
		end,
		function(arg_16_0)
			local var_16_0 = arg_14_0

			var_1.LoadChar(var_16_0, arg_16_0)

			return
		end,
		function(arg_17_0)
			local var_17_0 = arg_14_0

			var_1.CheckGuide(var_17_0, arg_17_0)

			return
		end,
		function(arg_18_0)
			local var_18_0 = arg_14_0

			var_1.PlayOneATK(var_18_0, arg_18_0)

			return
		end
	}, function()
		local var_19_0 = arg_14_0

		var_0.ShowResult(var_19_0)

		return
	end)

	return
end

function var_0_1.ShowTip(arg_20_0, arg_20_1)
	setActive = var_1_10002

	var_1_10002(arg_20_0.assessTF, false)

	setActive = var_1_10002

	var_1_10002(arg_20_0.tipTF, true)

	onDelayTick = var_1_10002

	var_1_10002(function()
		setActive = var_2_10000

		var_2_10000(arg_20_0.tipTF, false)

		setActive = var_2_10000

		var_2_10000(arg_20_0.assessTF, true)
		arg_20_1()

		return
	end, 1)

	return
end

function var_0_1.CheckGuide(arg_22_0, arg_22_1)
	pg = var_1_10002

	local var_22_0 = var_1_10002.NewStoryMgr.GetInstance()

	if var_2.IsPlayed(var_22_0, "tb2_12") then
		arg_22_1()
	else
		pg = var_2

		local var_22_1 = var_2.m02
		local var_22_2 = var_2.sendNotification

		GAME = var_4

		var_22_2(var_22_1, var_4.STORY_UPDATE, {
			storyId = "tb2_12"
		})

		pg = var_22_2

		local var_22_3 = var_22_2.NewGuideMgr.GetInstance()

		var_2.Play(var_22_3, "tb2_12", {
			arg_22_0.contextData.char.id
		}, arg_22_1, arg_22_1)
	end

	return
end

function var_0_1.LoadChar(arg_23_0, arg_23_1)
	pg = var_1_10002

	local var_23_0 = var_1_10002.UIMgr.GetInstance()

	var_2.LoadingOn(var_23_0)

	seriesAsync = var_2

	var_2({
		function(arg_24_0)
			local var_24_0

			if not arg_23_0.isEndless or not arg_23_0.charConfig.endless_boss then
				var_24_0 = arg_23_0.charConfig.boss
			end

			PoolMgr = var_2_10002

			local var_24_1 = var_2_10002.GetInstance()

			var_2.GetSpineChar(var_24_1, var_24_0, true, function(arg_25_0)
				arg_23_0.bossName = var_24_0

				local var_25_0 = arg_23_0

				var_25_0.bossModel = arg_25_0
				tf = var_25_0

				local var_25_1 = var_25_0(arg_25_0)

				Vector3 = var_2
				var_25_1.localScale = var_2(1, 1, 1)

				local var_25_2 = arg_25_0:GetComponent("SpineAnimUI")

				var_1.SetAction(var_25_2, "child2_boss_normal", 0)

				setParent = var_1

				var_1(arg_25_0, arg_23_0.bossTF)
				arg_24_0()

				return
			end)

			return
		end,
		function(arg_26_0)
			PoolMgr = var_2_10001

			local var_26_0 = var_2_10001.GetInstance()

			var_1.GetSpineChar(var_26_0, arg_23_0.charConfig[arg_23_0.tag], true, function(arg_27_0)
				arg_23_0.roleName = arg_23_0.charConfig[arg_23_0.tag]

				local var_27_0 = arg_23_0

				var_27_0.roleModel = arg_27_0
				tf = var_27_0

				local var_27_1 = var_27_0(arg_27_0)

				Vector3 = var_2
				var_27_1.localScale = var_2(1, 1, 1)

				local var_27_2 = arg_27_0:GetComponent("SpineAnimUI")

				var_1.SetAction(var_27_2, arg_23_0.roleName .. "_normal", 0)

				setParent = var_1

				var_1(arg_27_0, arg_23_0.roleTF)
				arg_26_0()

				return
			end)

			return
		end
	}, function()
		pg = var_2_10000

		local var_28_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_28_0)

		existCall = var_0

		var_0(arg_23_1)

		return
	end)

	return
end

function var_0_1.PlayOneATK(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.attrIds[arg_29_0.curAttrIdx]
	local var_29_1 = arg_29_0.contextData.char
	local var_29_2 = var_3.GetAttr(var_29_1, var_29_0)

	arg_29_0.damageHP = arg_29_0.damageHP + var_29_2

	local var_29_3 = arg_29_0:GetAtkActionName(var_29_2)
	local var_29_4

	if not (var_29_2 >= arg_29_0.standardValue * var_0_1.CRIT_PERCENT / 100) or not arg_29_0.damageCritTF then
		var_29_4 = arg_29_0.damageTF
	end

	setText = var_1_10007

	var_1_10007(var_29_4, "-" .. var_29_2)

	local var_29_5 = arg_29_0.bossModel
	local var_29_6 = var_7.GetComponent

	typeof = var_9
	SpineAnimUI = var_10

	local var_29_7 = var_29_6(var_29_5, var_9(var_10))

	var_7.SetAction(var_29_7, "child2_boss_normal", 0)

	local var_29_8 = arg_29_0.roleModel
	local var_29_9 = var_8.GetComponent

	typeof = var_10
	SpineAnimUI = var_11

	local var_29_10 = var_29_9(var_29_8, var_10(var_11))

	var_8.SetAction(var_29_10, arg_29_0.roleName .. "_normal", 0)

	seriesAsync = var_9

	var_9({
		function(arg_30_0)
			local var_30_0 = arg_29_0.attrUIList

			var_1.align(var_30_0, #arg_29_0.attrIds)

			blinkAni = var_1

			local var_30_1 = arg_29_0.attrUIList.container
			local var_30_2 = var_2.Find

			tostring = var_2_10004

			var_1(var_30_2(var_30_1, var_2_10004(var_29_0)), 0.2 / arg_29_0.speed, 3)

			local var_30_3 = arg_29_0
			local var_30_4 = var_1.managedTween

			LeanTween = var_3

			var_30_4(var_30_3, var_3.delayedCall, function()
				arg_30_0()

				return
			end, 1 / arg_29_0.speed, nil)

			return
		end,
		function(arg_32_0)
			local var_32_0 = var_0

			var_1.SetActionCallBack(var_32_0, function(arg_33_0)
				if arg_33_0 == "finish" then
					arg_32_0()

					local var_33_0 = var_0

					var_1.SetActionCallBack(var_33_0, nil)

					local var_33_1 = var_0

					var_1.SetAction(var_33_1, arg_29_0.roleName .. "_normal", 0)
				end

				return
			end)

			local var_32_1 = var_0

			var_1.SetAction(var_32_1, var_29_3, 0)

			return
		end,
		function(arg_34_0)
			setActive = var_2_10001

			var_2_10001(var_29_4, true)

			setFillAmount = var_2_10001

			local var_34_0 = arg_29_0.damageBlood

			math = var_3

			var_2_10001(var_34_0, var_3.min(arg_29_0.damageHP / arg_29_0.totolHP, 1))

			local var_34_1 = arg_29_0.bloodText

			math = var_34_0
			var_34_1.text = var_34_0.max(0, arg_29_0.totolHP - arg_29_0.damageHP) .. "/" .. arg_29_0.totolHP

			if arg_29_0.damageHP < arg_29_0.totolHP then
				local var_34_2 = var_0

				var_1.SetActionCallBack(var_34_2, function(arg_35_0)
					if arg_35_0 == "finish" then
						setActive = var_3_10001

						var_3_10001(var_29_4, false)
						arg_34_0()

						local var_35_0 = var_0

						var_1.SetActionCallBack(var_35_0, nil)

						local var_35_1 = var_0

						var_1.SetAction(var_35_1, "child2_boss_normal", 0)
					end

					return
				end)

				local var_34_3 = var_0

				var_1.SetAction(var_34_3, "child2_boss_shouji", 0)
			else
				local var_34_4 = var_0

				var_1.SetActionCallBack(var_34_4, function(arg_36_0)
					if arg_36_0 == "finish" then
						setActive = var_3_10001

						var_3_10001(var_29_4, false)
						arg_34_0()

						local var_36_0 = var_0

						var_1.SetActionCallBack(var_36_0, nil)

						local var_36_1 = var_0

						var_1.Pause(var_36_1)
					end

					return
				end)

				local var_34_5 = var_0

				var_1.SetAction(var_34_5, "child2_boss_jidao", 0)
			end

			return
		end
	}, function()
		if arg_29_0.damageHP >= arg_29_0.totolHP or arg_29_0.curAttrIdx == #arg_29_0.attrIds then
			arg_29_1()
		else
			arg_29_0.curAttrIdx = arg_29_0.curAttrIdx + 1

			local var_37_0 = arg_29_0
			local var_37_1 = var_0.managedTween

			LeanTween = var_2_10002

			var_37_1(var_37_0, var_2_10002.delayedCall, function()
				local var_38_0 = arg_29_0

				var_0.PlayOneATK(var_38_0, arg_29_1)

				return
			end, 0.5 / arg_29_0.speed, nil)
		end

		return
	end)

	return
end

function var_0_1.AdjustSpeed(arg_39_0)
	arg_39_0.speed = var_0_1.SPEED

	if arg_39_0.bossModel then
		arg_39_0:GetAnimationState(arg_39_0.bossModel).TimeScale = arg_39_0.speed
	end

	if arg_39_0.roleModel then
		arg_39_0:GetAnimationState(arg_39_0.roleModel).TimeScale = arg_39_0.speed
	end

	return
end

function var_0_1.GetAnimationState(arg_40_0, arg_40_1)
	return arg_40_1:GetComponent("Spine.Unity.SkeletonGraphic").AnimationState
end

function var_0_1.Hide(arg_41_0)
	arg_41_0:UnOverlayPanel(arg_41_0._tf)

	if arg_41_0.bossName and arg_41_0.bossModel then
		arg_41_0:GetAnimationState(arg_41_0.bossModel).TimeScale = 1
		PoolMgr = var_2

		local var_41_0 = var_2.GetInstance()

		var_2.ReturnSpineChar(var_41_0, arg_41_0.bossName, arg_41_0.bossModel)

		arg_41_0.bossName = nil
		arg_41_0.bossModel = nil
	end

	if arg_41_0.roleName and arg_41_0.roleModel then
		arg_41_0:GetAnimationState(arg_41_0.roleModel).TimeScale = 1
		PoolMgr = var_2

		local var_41_1 = var_2.GetInstance()

		var_2.ReturnSpineChar(var_41_1, arg_41_0.roleName, arg_41_0.roleModel)

		arg_41_0.roleName = nil
		arg_41_0.roleModel = nil
	end

	var_0_1.super.Hide(arg_41_0)

	return
end

function var_0_1.OnDestroy(arg_42_0)
	arg_42_0:Hide()

	return
end

return var_0_1
