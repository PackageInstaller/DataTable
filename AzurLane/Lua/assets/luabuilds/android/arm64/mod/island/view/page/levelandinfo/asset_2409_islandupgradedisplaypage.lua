class = var_0_10000

local var_0_0 = "IslandUpgradeDisplayPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))
local var_0_2 = 1
local var_0_3 = 2

function var_0_1.getUIName(arg_1_0)
	return "IslandCommonUpgradeDisplayUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.onlnyLevelTr = var_1.Find(var_2_0, "small")

	local var_2_1 = arg_2_0._tf

	arg_2_0.dropPanelTr = var_1.Find(var_2_1, "module")
	UIItemList = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0.dropPanelTr
	local var_2_4 = var_3.Find(var_2_3, "Board/Content/award/content")
	local var_2_5 = arg_2_0.dropPanelTr

	arg_2_0.unlockUIList = var_2_2(var_2_4, var_4.Find(var_2_5, "Board/Content/award/content/tpl"))
	GetOrAddComponent = var_1

	local var_2_6 = arg_2_0._tf

	typeof = var_4
	CanvasGroup = var_2_5
	arg_2_0.canvasGroup = var_1(var_2_6, var_4(var_2_5))
	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "module/tip")

	i18n = var_4

	var_1(var_2_8, var_4("island_3Dshop_close"))

	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "small/tip")

	i18n = var_4

	var_1(var_2_10, var_4("island_3Dshop_close"))

	GetComponent = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1(var_3.Find(var_2_11, "module/bg/Top/title"), "Image")

	var_1.SetNativeSize(var_2_12)

	GetComponent = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1(var_3.Find(var_2_13, "module/bg/Top/title/title_item"), "Image")

	var_1.SetNativeSize(var_2_14)

	GetComponent = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_1(var_3.Find(var_2_15, "module/bg/Top/star"), "Image")

	var_1.SetNativeSize(var_2_16)

	GetComponent = var_1

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_1(var_3.Find(var_2_17, "module/bg/Top/star/title_item"), "Image")

	var_1.SetNativeSize(var_2_18)

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.PlayExitAnimation(var_4_0, function()
			local var_5_0 = arg_3_0.callback
			local var_5_1 = arg_3_0

			var_1.Hide(var_5_1)

			if var_5_0 then
				var_5_0()
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.PlayExitAnimation(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.targetTr
	local var_6_1 = var_2.GetComponent

	typeof = var_1_10005
	Animation = var_1_10007

	local var_6_2 = var_6_1(var_6_0, var_1_10005(var_1_10007))
	local var_6_3 = arg_6_0.targetTr
	local var_6_4 = var_3.GetComponent

	typeof = var_1_10006
	DftAniEvent = var_1_10008

	local var_6_5 = var_6_4(var_6_3, var_1_10006(var_1_10008))

	arg_6_0.canvasGroup.blocksRaycasts = false

	var_6_5:SetEndEvent(function()
		local var_7_0 = var_6_5

		var_0.SetEndEvent(var_7_0, nil)

		arg_6_0.canvasGroup.blocksRaycasts = true

		arg_6_1()

		return
	end)

	if arg_6_0.targetTr == arg_6_0.onlnyLevelTr then
		var_6_2:Play("anim_Island_commonget_onlylv_out")
	else
		var_6_2:Play("anim_Island_commonget_single_out")
	end

	return
end

function var_0_1.Show(arg_8_0, arg_8_1, arg_8_2)
	var_0_1.super.Show(arg_8_0)

	arg_8_0.callback = arg_8_2

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.GetIsland(var_8_0)
	local var_8_3

	if arg_8_1 then
		::label_8_0::

		local var_8_2 = #arg_8_1

		var_8_3 = 0 < var_8_2
	end

	if var_8_3 then
		arg_8_0:CommonSettings(var_8_1, arg_8_0.dropPanelTr)
		arg_8_0:UpdateUnlockList(arg_8_1)
	else
		arg_8_0:CommonSettings(var_8_1, arg_8_0.onlnyLevelTr)
	end

	setActive = var_8_0

	var_8_0(arg_8_0.onlnyLevelTr, not var_8_3)

	setActive = var_8_0

	var_8_0(arg_8_0.dropPanelTr, var_8_3)

	local var_8_4

	if not var_8_3 or not arg_8_0.dropPanelTr then
		var_8_4 = arg_8_0.onlnyLevelTr
	end

	arg_8_0.targetTr = var_8_4

	local var_8_5 = arg_8_0.targetTr
	local var_8_6 = var_5.GetComponent

	typeof = var_8
	Animation = var_1_10010

	local var_8_7 = var_8_6(var_8_5, var_8(var_1_10010))

	if arg_8_0.targetTr == arg_8_0.onlnyLevelTr then
		var_8_7:Play("anim_Island_commonget_onlylv_in")
	else
		var_8_7:Play("anim_Island_commonget_single_in")
	end

	pg = var_6

	local var_8_8 = var_6.UIMgr.GetInstance()

	var_6.OverlayPanel(var_8_8, arg_8_0._tf)

	return
end

function var_0_1.Hide(arg_9_0)
	arg_9_0.callback = nil

	var_0_1.super.Hide(arg_9_0)

	pg = var_1

	local var_9_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_9_0, arg_9_0._tf, arg_9_0._parentTf)

	return
end

function var_0_1.OnShow(arg_10_0)
	arg_10_0.canvasGroup.interactable = true
	arg_10_0.canvasGroup.blocksRaycasts = true

	return
end

function var_0_1.OnHide(arg_11_0)
	arg_11_0.canvasGroup.interactable = false
	arg_11_0.canvasGroup.blocksRaycasts = false

	return
end

function var_0_1.CommonSettings(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:GetLevel()

	setText = var_1_10004

	var_1_10004(arg_12_2:Find("Board/Top/LV/prev/prev_1"), "<size=50>" .. var_12_0 - 1 .. "</size>")

	setText = var_1_10004

	var_1_10004(arg_12_2:Find("Board/Top/LV/next/next_1"), "<size=50>" .. var_12_0 .. "</size>")

	return
end

function var_0_1.UpdateUnlockList(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.unlockUIList

	var_2.make(var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			local var_14_0 = arg_13_1[arg_14_1 + 1]

			updateCustomDrop = var_4

			var_4(arg_14_2, var_14_0)

			setText = var_4

			local var_14_1 = arg_14_2:Find("icon_bg/name_bg/Text")

			shortenString = var_7

			var_4(var_14_1, var_7(var_14_0:getConfigTable().unlock_text, 5))

			local var_14_2 = var_14_0:getConfigTable().show_type

			GetImageSpriteFromAtlasAsync = var_2_10005

			var_2_10005("ui/islandupgradedisplayui_atlas", "ability_type" .. var_14_2, arg_14_2:Find("icon_bg/type"))
		end

		return
	end)

	local var_13_1 = arg_13_0.unlockUIList

	var_2.align(var_13_1, #arg_13_1)

	return
end

function var_0_1.OnDestroy(arg_15_0)
	return
end

return var_0_1
