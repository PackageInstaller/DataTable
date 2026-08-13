class = var_0_10000

local var_0_0 = "LinkDunHuangPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".JavelinComicSkinPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_1, "items/item")

	local var_1_2 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_2, "items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_3 = arg_1_0.bg
	local var_1_4 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_1_0.bgImg = var_1_4(var_1_3, var_3(var_1_10004))
	arg_1_0.isReplaceBG = false

	return
end

function var_0_1.GetLinkId(arg_2_0)
	local var_2_0 = arg_2_0.activity

	return var_1.getConfig(var_2_0, "config_client").link_act
end

function var_0_1.UpdatePuzzle(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 then
		table = var_1_10004

		if not var_1_10004.contains(arg_3_0.chargeIDList, arg_3_3) then
			table = var_1_10004

			var_1_10004.insert(arg_3_0.chargeIDList, arg_3_3)
			arg_3_0:DoPieceAnimation(arg_3_1, 1, 0, function()
				setActive = var_2_10000

				var_2_10000(arg_3_1, not arg_3_2)

				local var_4_0 = arg_3_0

				var_0.CheckFinalAward(var_4_0)

				return
			end)

			goto label_3_0
		end
	end

	setActive = var_1_10004

	var_1_10004(arg_3_1, not arg_3_2)

	::label_3_0::

	return
end

function var_0_1.DoPieceAnimation(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	LeanTween = var_1_10005

	local var_5_0

	if var_1_10005.isTweening(arg_5_1) then
		LeanTween = var_5_0
		var_5_0 = var_5_0.cancel
		go = var_6

		var_5_0(var_6(arg_5_1), true)

		var_5_0 = arg_5_0.animations
		var_5_0[arg_5_1] = nil
	end

	pg = var_5_0

	local var_5_1 = var_5_0.UIMgr.GetInstance()

	var_5.LoadingOn(var_5_1, false)

	local var_5_2 = arg_5_0.animations

	var_5_2[arg_5_1] = true
	LeanTween = var_5_2

	local var_5_3 = var_5_2.value(arg_5_1.gameObject, 1, 0, 1)
	local var_5_4 = var_5.setOnUpdate

	System = var_7

	local var_5_5 = var_5_4(var_5_3, var_7.Action_float(function(arg_6_0)
		setFillAmount = var_2_10001

		var_2_10001(arg_5_1, arg_6_0)

		return
	end))
	local var_5_6 = var_5.setFrom(var_5_5, 1)
	local var_5_7 = var_5.setOnComplete

	System = var_7

	var_5_7(var_5_6, var_7.Action(function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.UIMgr.GetInstance()

		var_0.LoadingOff(var_7_0)
		arg_5_4()

		return
	end))

	return
end

function var_0_1.RegisterEvent(arg_8_0)
	return
end

function var_0_1.UpdateMainView(arg_9_0, arg_9_1)
	if arg_9_1 and not arg_9_0.isReplaceBG then
		arg_9_0:ReplaceBg()
	end

	return
end

function var_0_1.PlayStory(arg_10_0)
	return
end

function var_0_1.FetchFinalAward(arg_11_0)
	var_0_1.super.FetchFinalAward(arg_11_0)

	local var_11_0 = arg_11_0.activity
	local var_11_1

	if not var_1.getConfig(var_11_0, "config_client").story[arg_11_0.nday] then
		var_11_1 = {}
	end

	if var_11_1[1] then
		pg = var_3

		local var_11_2 = var_3.NewStoryMgr.GetInstance()

		var_3.Play(var_11_2, var_11_1[1])
	end

	return
end

function var_0_1.OnFetchFinalAwardDone(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = arg_12_0.activity
	local var_12_2 = var_2.getConfig(var_12_1, "config_client").story

	ipairs = var_12_1

	for iter_12_0, iter_12_1 in var_12_1(var_12_2 or {}) do
		local var_12_3

		if not var_12_2[iter_12_0] then
			var_12_3 = {}
		end

		if var_12_3[1] then
			pg = var_9

			local var_12_4 = var_9.NewStoryMgr.GetInstance()

			if not var_9.IsPlayed(var_12_4, var_12_3[1]) then
				table = var_9

				var_9.insert(var_12_0, var_12_3[1])
			end
		end
	end

	pg = var_3

	local var_12_5 = var_3.NewStoryMgr.GetInstance()

	var_3.SeriesPlay(var_12_5, var_12_0)

	return
end

function var_0_1.ReplaceBg(arg_13_0)
	arg_13_0.isReplaceBG = true

	local var_13_0 = arg_13_0.bgImg

	GetSpriteFromAtlas = var_1_10002
	var_13_0.sprite = var_1_10002("ui/activityuipage/LinkDunhuangPage_atlas", "bg_finish")

	return
end

return var_0_1
