local var_0_0 = class("IslandAwardDisplayWindow", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandAwardDisplayUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.frameTr = arg_2_0._tf:Find("frame")
	arg_2_0.title = arg_2_0._tf:Find("frame/Board/Top/text/text"):GetComponent("Text")
	arg_2_0.uiitemList = UIItemList.New(arg_2_0._tf:Find("frame/Board/Content/award/content"), arg_2_0._tf:Find("frame/Board/Content/award/content/tpl"))

	setText(arg_2_0._tf:Find("frame/tip"), i18n("island_click_close"))

	arg_2_0.animator = arg_2_0.frameTr:GetComponent(typeof(Animation))
	arg_2_0.aniDft = arg_2_0.frameTr:GetComponent(typeof(DftAniEvent))
	arg_2_0.scrollRect = arg_2_0._tf:Find("frame/Board/Content/award_scroll/content"):GetComponent("LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_0.Show(arg_5_0, arg_5_1)
	var_0_0.super.Show(arg_5_0)

	local var_5_0 = arg_5_1.title or ""
	local var_5_1 = arg_5_1.titleColor or "#393a3c"

	arg_5_0.title.text = setColorStr(var_5_0, var_5_1)

	arg_5_0:UpdateAwards(arg_5_1.awards)

	return
end

function var_0_0.OnUpdateItem(arg_6_0, arg_6_1, arg_6_2)
	updateCustomDrop(arg_6_2.transform, arg_6_0.awards[arg_6_1 + 1], {
		style = "island"
	})
	setText(findTF(arg_6_2.transform, "icon_bg/count_bg/count"), "x" .. arg_6_0.awards[arg_6_1 + 1].count)

	return
end

function var_0_0.UpdateAwards(arg_7_0, arg_7_1)
	local var_7_0 = #arg_7_1 > 10

	arg_7_0.awards = arg_7_1

	setActive(arg_7_0._tf:Find("frame/Board/Content/award_scroll"), var_7_0)
	setActive(arg_7_0._tf:Find("frame/Board/Content/award"), not var_7_0)

	if var_7_0 then
		arg_7_0.scrollRect:SetTotalCount(#arg_7_0.awards, -1)
	else
		arg_7_0.uiitemList:make(function(arg_8_0, arg_8_1, arg_8_2)
			if arg_8_0 == UIItemList.EventUpdate then
				updateCustomDrop(arg_8_2, arg_7_1[arg_8_1 + 1], {
					style = "island"
				})
				setText(findTF(arg_8_2, "icon_bg/count_bg/count"), "x" .. arg_7_1[arg_8_1 + 1].count)
			end

			return
		end)
		arg_7_0.uiitemList:align(#arg_7_1)
	end

	return
end

function var_0_0.PlayExitAniamtion(arg_9_0, arg_9_1)
	arg_9_0.aniDft:SetEndEvent(function()
		arg_9_0.aniDft:SetEndEvent(nil)
		arg_9_1()

		return
	end)
	arg_9_0.animator:Play("anim_Island_commonget_single_out")

	return
end

function var_0_0.OnDestroy(arg_11_0)
	arg_11_0.aniDft:SetEndEvent(nil)
	ClearLScrollrect(arg_11_0.scrollRect)

	return
end

return var_0_0
