local var_0_0 = class("IslandUpgradeDisplayPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandCommonUpgradeDisplayUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.onlnyLevelTr = arg_2_0._tf:Find("small")
	arg_2_0.dropPanelTr = arg_2_0._tf:Find("module")
	arg_2_0.unlockUIList = UIItemList.New(arg_2_0.dropPanelTr:Find("Board/Content/award/content"), arg_2_0.dropPanelTr:Find("Board/Content/award/content/tpl"))
	arg_2_0.canvasGroup = GetOrAddComponent(arg_2_0._tf, typeof(CanvasGroup))

	setText(arg_2_0._tf:Find("module/tip"), i18n("island_3Dshop_close"))
	setText(arg_2_0._tf:Find("small/tip"), i18n("island_3Dshop_close"))
	GetComponent(arg_2_0._tf:Find("module/bg/Top/title"), "Image"):SetNativeSize()
	GetComponent(arg_2_0._tf:Find("module/bg/Top/title/title_item"), "Image"):SetNativeSize()
	GetComponent(arg_2_0._tf:Find("module/bg/Top/star"), "Image"):SetNativeSize()
	GetComponent(arg_2_0._tf:Find("module/bg/Top/star/title_item"), "Image"):SetNativeSize()

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:PlayExitAnimation(function()
			arg_3_0:Hide()

			if arg_3_0.callback then
				arg_3_0.callback()
			end

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.PlayExitAnimation(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.targetTr:GetComponent(typeof(Animation))
	local var_6_1 = arg_6_0.targetTr:GetComponent(typeof(DftAniEvent))

	arg_6_0.canvasGroup.blocksRaycasts = false

	arg_6_0.targetTr:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		var_6_1:SetEndEvent(nil)

		arg_6_0.canvasGroup.blocksRaycasts = true

		arg_6_1()

		return
	end)

	if arg_6_0.targetTr == arg_6_0.onlnyLevelTr then
		var_6_0:Play("anim_Island_commonget_onlylv_out")
	else
		var_6_0:Play("anim_Island_commonget_single_out")
	end

	return
end

function var_0_0.Show(arg_8_0, arg_8_1, arg_8_2)
	var_0_0.super.Show(arg_8_0)

	arg_8_0.callback = arg_8_2

	local var_8_0 = arg_8_0:GetIsland()
	local var_8_1 = arg_8_1 and #arg_8_1 > 0

	if arg_8_1 and #arg_8_1 > 0 then
		arg_8_0:CommonSettings(var_8_0, arg_8_0.dropPanelTr)
		arg_8_0:UpdateUnlockList(arg_8_1)
	else
		arg_8_0:CommonSettings(var_8_0, arg_8_0.onlnyLevelTr)
	end

	setActive(arg_8_0.onlnyLevelTr, not var_8_1)
	setActive(arg_8_0.dropPanelTr, var_8_1)

	if var_8_1 then
		arg_8_0.targetTr = arg_8_0.dropPanelTr or arg_8_0.onlnyLevelTr

		local var_8_2 = arg_8_0.targetTr:GetComponent(typeof(Animation))

		if arg_8_0.targetTr == arg_8_0.onlnyLevelTr then
			var_8_2:Play("anim_Island_commonget_onlylv_in")
		else
			var_8_2:Play("anim_Island_commonget_single_in")
		end

		pg.UIMgr.GetInstance():OverlayPanel(arg_8_0._tf)

		return
	end
end

function var_0_0.Hide(arg_9_0)
	arg_9_0.callback = nil

	var_0_0.super.Hide(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf, arg_9_0._parentTf)

	return
end

function var_0_0.OnShow(arg_10_0)
	arg_10_0.canvasGroup.interactable = true
	arg_10_0.canvasGroup.blocksRaycasts = true

	return
end

function var_0_0.OnHide(arg_11_0)
	arg_11_0.canvasGroup.interactable = false
	arg_11_0.canvasGroup.blocksRaycasts = false

	return
end

function var_0_0.CommonSettings(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:GetLevel()

	setText(arg_12_2:Find("Board/Top/LV/prev/prev_1"), "<size=50>" .. var_12_0 - 1 .. "</size>")
	setText(arg_12_2:Find("Board/Top/LV/next/next_1"), "<size=50>" .. var_12_0 .. "</size>")

	return
end

function var_0_0.UpdateUnlockList(arg_13_0, arg_13_1)
	arg_13_0.unlockUIList:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_14_2, arg_13_1[arg_14_1 + 1])
			setText(arg_14_2:Find("icon_bg/name_bg/Text"), shortenString(arg_13_1[arg_14_1 + 1]:getConfigTable().unlock_text, 5))
			GetImageSpriteFromAtlasAsync("ui/islandupgradedisplayui_atlas", "ability_type" .. arg_13_1[arg_14_1 + 1]:getConfigTable().show_type, arg_14_2:Find("icon_bg/type"))
		end

		return
	end)
	arg_13_0.unlockUIList:align(#arg_13_1)

	return
end

function var_0_0.OnDestroy(arg_15_0)
	return
end

return var_0_0
