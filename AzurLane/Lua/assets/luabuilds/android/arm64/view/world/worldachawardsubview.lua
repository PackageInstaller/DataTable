local var_0_0 = class("WorldAchAwardSubview", import("view.base.BaseSubView"))

var_0_0.ShowDrop = "WorldAchAwardSubview.ShowDrop"

function var_0_0.getUIName(arg_1_0)
	return "WorldAchAwardSubview"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.textTitle = arg_3_0._tf:Find("title/Text")
	arg_3_0.btnBG = arg_3_0._tf:Find("bg")
	arg_3_0.itemContent = arg_3_0._tf:Find("award_list/content")
	arg_3_0.itemList = UIItemList.New(arg_3_0.itemContent, arg_3_0.itemContent:Find("item"))

	arg_3_0.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_3_0.awards[arg_4_1]
			local var_4_1 = not arg_3_0.nextStar or var_4_0.star < arg_3_0.nextStar
			local var_4_2 = arg_3_0.nextStar and var_4_0.star == arg_3_0.nextStar
			local var_4_3 = arg_3_0.nextStar and var_4_0.star > arg_3_0.nextStar
			local var_4_4 = arg_4_2:Find("award")

			setActive(var_4_4, true)
			setActive(arg_4_2:Find("lock_award"), false)
			updateDrop(var_4_4, var_4_0.drop)
			setGray(var_4_4:Find("icon_bg"), var_4_1 or var_4_3)
			onButton(arg_3_0, var_4_4, function()
				arg_3_0:emit(var_0_0.ShowDrop, var_4_0.drop)

				return
			end, SFX_PANEL)
			setText(arg_4_2:Find("star/count"), var_4_0.star)
			setActive(arg_4_2:Find("star/bg_on"), var_4_2)
			setActive(arg_4_2:Find("star/bg_off"), not var_4_2)
			setActive(arg_4_2:Find("star/lock"), var_4_3)
			setActive(arg_4_2:Find("ready_mark"), var_4_2 and not var_4_1 and not arg_3_0.hasAward)
			setActive(arg_4_2:Find("get_mark"), var_4_2 and arg_3_0.hasAward)
			setActive(arg_4_2:Find("got_mark"), var_4_1)
			setActive(arg_4_2:Find("lock_mark"), var_4_3)
			setActive(arg_4_2:Find("mark/on"), var_4_1)
			setActive(arg_4_2:Find("mark/off"), not var_4_1)
		end

		return
	end)
	onButton(arg_3_0, arg_3_0.btnBG, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_7_0)
	return
end

function var_0_0.Show(arg_8_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf)
	setActive(arg_8_0._tf, true)

	return
end

function var_0_0.Hide(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf, arg_9_0._parentTf)
	setActive(arg_9_0._tf, false)

	return
end

function var_0_0.isShowing(arg_10_0)
	return arg_10_0._tf and isActive(arg_10_0._tf)
end

function var_0_0.Setup(arg_11_0, arg_11_1)
	arg_11_0.awards = arg_11_1:GetAchievementAwards()

	local var_11_0, var_11_1 = nowWorld():AnyUnachievedAchievement(arg_11_1)

	arg_11_0.hasAward = var_11_0

	if var_11_1 then
		arg_11_0.nextStar = var_11_1.star or nil

		arg_11_0.itemList:align(#arg_11_0.awards)
		setText(arg_11_0._tf:Find("title/Text"), arg_11_1:GetBaseMap():GetName())

		return
	end
end

return var_0_0
