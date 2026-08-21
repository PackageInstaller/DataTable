local var_0_0 = class("LinkDunHuangPage", import(".JavelinComicSkinPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.item = arg_1_0.bg:Find("items/item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.bgImg = arg_1_0.bg:GetComponent(typeof(Image))
	arg_1_0.isReplaceBG = false

	return
end

function var_0_0.GetLinkId(arg_2_0)
	return arg_2_0.activity:getConfig("config_client").link_act
end

function var_0_0.UpdatePuzzle(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 and not table.contains(arg_3_0.chargeIDList, arg_3_3) then
		table.insert(arg_3_0.chargeIDList, arg_3_3)
		arg_3_0:DoPieceAnimation(arg_3_1, 1, 0, function()
			setActive(arg_3_1, not arg_3_2)
			arg_3_0:CheckFinalAward()

			return
		end)
	else
		setActive(arg_3_1, not arg_3_2)
	end

	return
end

function var_0_0.DoPieceAnimation(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if LeanTween.isTweening(arg_5_1) then
		LeanTween.cancel(go(arg_5_1), true)

		arg_5_0.animations[arg_5_1] = nil
	end

	pg.UIMgr.GetInstance():LoadingOn(false)

	arg_5_0.animations[arg_5_1] = true

	LeanTween.value(arg_5_1.gameObject, 1, 0, 1):setOnUpdate(System.Action_float(function(arg_6_0)
		setFillAmount(arg_5_1, arg_6_0)

		return
	end)):setFrom(1):setOnComplete(System.Action(function()
		pg.UIMgr.GetInstance():LoadingOff()
		arg_5_4()

		return
	end))

	return
end

function var_0_0.RegisterEvent(arg_8_0)
	return
end

function var_0_0.UpdateMainView(arg_9_0, arg_9_1)
	if arg_9_1 and not arg_9_0.isReplaceBG then
		arg_9_0:ReplaceBg()
	end

	return
end

function var_0_0.PlayStory(arg_10_0)
	return
end

function var_0_0.FetchFinalAward(arg_11_0)
	var_0_0.super.FetchFinalAward(arg_11_0)

	local var_11_0 = arg_11_0.activity:getConfig("config_client").story[arg_11_0.nday] or {}

	if var_11_0[1] then
		pg.NewStoryMgr.GetInstance():Play(var_11_0[1])
	end

	return
end

function var_0_0.OnFetchFinalAwardDone(arg_12_0)
	local var_12_0 = arg_12_0.activity:getConfig("config_client").story

	for iter_12_0, iter_12_1 in ipairs(var_12_0 or {}) do
		local var_12_1 = var_12_0[iter_12_0] or {}

		if var_12_1[1] then
			local var_12_2 = pg.NewStoryMgr.GetInstance()

			if not var_12_2:IsPlayed(var_12_1[1]) then
				table.insert({}, var_12_1[1])
			end
		end
	end

	pg.NewStoryMgr.GetInstance():SeriesPlay({})

	return
end

function var_0_0.ReplaceBg(arg_13_0)
	arg_13_0.isReplaceBG = true
	arg_13_0.bgImg.sprite = GetSpriteFromAtlas("ui/activityuipage/LinkDunhuangPage_atlas", "bg_finish")

	return
end

return var_0_0
