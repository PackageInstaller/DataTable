local var_0_0 = class("NewYear23SkinShowPage", import("...base.BaseActivityPage"))

function var_0_0.OnLoaded(arg_1_0)
	return
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.goBtn = arg_2_0._tf:Find("BtnGO")
	arg_2_0.skinShopBtn = arg_2_0._tf:Find("BtnShop")

	onButton(arg_2_0, arg_2_0.skinShopBtn, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.goBtn, function()
		arg_2_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.NEWYEAR_BACKHILL_2023)

		return
	end, SFX_PANEL)

	arg_2_0.rtBg = arg_2_0._tf:Find("AD")
	arg_2_0.rtFront = arg_2_0.rtBg:Find("front")

	return
end

function var_0_0.OnDataSetting(arg_5_0)
	local var_5_0 = pg.TimeMgr.GetInstance()

	arg_5_0.showList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.activity:getConfig("config_client").display_link) do
		if iter_5_1[2] == 0 or var_5_0:inTime(pg.shop_template[iter_5_1[2]].time) then
			table.insert(arg_5_0.showList, math.random(#arg_5_0.showList + 1), iter_5_1[1])
		end
	end

	return
end

function var_0_0.OnFirstFlush(arg_6_0)
	arg_6_0:ActionInvoke("ShowOrHide", false)

	arg_6_0.index = 1

	GetSpriteFromAtlasAsync("clutter/newyear23skinshowpage_" .. arg_6_0.showList[arg_6_0.index], "", function(arg_7_0)
		if arg_6_0._state == var_0_0.STATES.DESTROY then
			return
		end

		setImageSprite(arg_6_0.rtBg, arg_7_0)
		setImageAlpha(arg_6_0.rtFront, 0)
		arg_6_0:ActionInvoke("ShowOrHide", true)
		arg_6_0:DelayCall()

		return
	end)

	return
end

function var_0_0.DelayCall(arg_8_0)
	table.insert({}, function(arg_9_0)
		arg_8_0.uniqueId = LeanTween.delayedCall(3, System.Action(arg_9_0)).uniqueId

		return
	end)
	table.insert({}, function(arg_10_0)
		arg_8_0.index = arg_8_0.index % #arg_8_0.showList + 1

		GetSpriteFromAtlasAsync("clutter/newyear23skinshowpage_" .. arg_8_0.showList[arg_8_0.index], "", function(arg_11_0)
			if arg_8_0._state == var_0_0.STATES.DESTROY then
				return
			end

			arg_8_0.nextSprite = arg_11_0

			arg_10_0()

			return
		end)

		return
	end)
	parallelAsync({}, function()
		setImageSprite(arg_8_0.rtFront, getImageSprite(arg_8_0.rtBg))
		setImageAlpha(arg_8_0.rtFront, 1)
		setImageSprite(arg_8_0.rtBg, arg_8_0.nextSprite)

		arg_8_0.uniqueId = LeanTween.alpha(arg_8_0.rtFront, 0, 0.5):setEase(LeanTweenType.easeOutSine):setOnComplete(System.Action(function()
			arg_8_0:DelayCall()

			return
		end)).uniqueId

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_14_0)
	if arg_14_0.uniqueId then
		LeanTween.cancel(arg_14_0.uniqueId)
	end

	return
end

return var_0_0
