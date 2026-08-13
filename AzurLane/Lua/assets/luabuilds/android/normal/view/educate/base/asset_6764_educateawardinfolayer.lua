class = var_0_10000

local var_0_0 = "EducateAwardInfoLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.EducateBaseUI"))
local var_0_2 = {}

Vector2 = var_2
var_0_2[1] = var_2(0, 115)
Vector2 = var_2
var_0_2[2] = var_2(0, 162)

local var_0_3 = {}

Vector2 = var_3
var_0_3[1] = var_3(0, -280)
Vector2 = var_3
var_0_3[2] = var_3(0, -315)

local var_0_4 = 0.4

function var_0_1.getUIName(arg_1_0)
	return "EducateAwardInfoUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	local var_2_1

	if not arg_2_0.contextData.items then
		var_2_1 = {}
	end

	arg_2_0.drops = var_2_1

	local var_2_2 = arg_2_0._tf

	arg_2_0.awardWindow = var_1.Find(var_2_2, "award_window")

	local var_2_3 = arg_2_0.awardWindow
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.anim = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0.awardWindow
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.animEvent = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_7, function()
		if #arg_2_0.showPolaroidDrops > 0 then
			setActive = var_0

			var_0(arg_2_0.awardWindow, false)

			setActive = var_0

			var_0(arg_2_0.polaroidWindow, true)

			arg_2_0.polaroidIndex = 1

			local var_3_0 = arg_2_0

			var_0.showPolaroidAnim(var_3_0)
		else
			local var_3_1 = arg_2_0

			var_0.emit(var_3_1, var_0_1.ON_CLOSE)
		end

		return
	end)

	local var_2_8 = arg_2_0.awardWindow

	arg_2_0.tipTF = var_1.Find(var_2_8, "tip")
	setText = var_1

	local var_2_9 = arg_2_0.tipTF

	i18n = var_3

	var_1(var_2_9, var_3("child_close_tip"))

	local var_2_10 = arg_2_0.awardWindow

	arg_2_0.itemContent = var_1.Find(var_2_10, "content/items")

	local var_2_11 = arg_2_0.itemContent

	arg_2_0.itemContainer = var_1.Find(var_2_11, "items_scroll/content")

	local var_2_12 = arg_2_0.awardWindow

	arg_2_0.itemTpl = var_1.Find(var_2_12, "item_tpl")
	setActive = var_1

	var_1(arg_2_0.itemTpl, false)

	local var_2_13 = arg_2_0.awardWindow

	arg_2_0.attrContent = var_1.Find(var_2_13, "content/attrs")

	local var_2_14 = arg_2_0.attrContent

	arg_2_0.attrContainer = var_1.Find(var_2_14, "attrs_scroll/content")

	local var_2_15 = arg_2_0.awardWindow

	arg_2_0.attrTpl = var_1.Find(var_2_15, "attr_tpl")
	setActive = var_1

	var_1(arg_2_0.attrTpl, false)

	local var_2_16 = arg_2_0._tf

	arg_2_0.polaroidWindow = var_1.Find(var_2_16, "polaroid_window")

	local var_2_17 = arg_2_0.polaroidWindow

	arg_2_0.polaroidIconTF = var_1.Find(var_2_17, "content/mask/icon")

	local var_2_18 = arg_2_0.polaroidWindow

	arg_2_0.polaroidDescTF = var_1.Find(var_2_18, "content/desc")
	setActive = var_1

	var_1(arg_2_0.awardWindow, false)

	setActive = var_1

	var_1(arg_2_0.polaroidWindow, false)

	local var_2_19 = arg_2_0._tf

	var_1.SetAsLastSibling(var_2_19)

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.awardWindow
	local var_4_2 = var_3.Find(var_4_1, "close")

	local function var_4_3()
		local var_5_0 = arg_4_0

		var_0._close(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_0, var_4_2, var_4_3, var_5)

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.polaroidWindow

	local function var_4_6()
		if arg_4_0.playing then
			return
		end

		pg = var_0

		local var_6_0 = var_0.TipsMgr.GetInstance()
		local var_6_1 = var_0.ShowTips

		i18n = var_2_10002

		var_6_1(var_6_0, var_2_10002("child_polaroid_get_tip"))

		if arg_4_0.polaroidIndex <= #arg_4_0.showPolaroidDrops then
			local var_6_2 = arg_4_0

			var_0.showPolaroidAnim(var_6_2)
		else
			local var_6_3 = arg_4_0

			var_0.emit(var_6_3, var_0_1.ON_CLOSE)
		end

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_4, var_4_5, var_4_6, var_5)

	arg_4_0.showAwardDrops = arg_4_0:getAwardDrops()
	arg_4_0.showAttrDrops = arg_4_0:getAttrDrops()
	arg_4_0.showPolaroidDrops = arg_4_0:getPolaroidDrops()

	local var_4_7 = #arg_4_0.showAttrDrops
	local var_4_8 = 0 < var_4_7

	setActive = var_2

	var_2(arg_4_0.attrContent, var_4_8)
	arg_4_0:showWindow()

	return
end

function var_0_1.showWindow(arg_7_0)
	if #arg_7_0.showAwardDrops > 0 then
		arg_7_0.inAnimPlaying = true
		setActive = var_1

		var_1(arg_7_0.awardWindow, true)

		local var_7_0 = #arg_7_0.showAttrDrops > 0 and "anim_educate_awardinfo_awardattr_in" or "anim_educate_awardinfo_award_in"
		local var_7_1 = arg_7_0.anim

		var_2.Play(var_7_1, var_7_0)

		local var_7_2 = {}

		table = var_7_1

		var_7_1.insert(var_7_2, function(arg_8_0)
			local var_8_0 = arg_7_0
			local var_8_1 = var_1.managedTween

			LeanTween = var_2_10003

			var_8_1(var_8_0, var_2_10003.delayedCall, function()
				arg_8_0()

				return
			end, 0.33, nil)

			return
		end)

		math = var_3

		local var_7_3 = var_3.max(#arg_7_0.showAttrDrops, #arg_7_0.showAwardDrops)

		for iter_7_0 = 1, var_7_3 do
			table = var_1_10008

			var_1_10008.insert(var_7_2, function(arg_10_0)
				if arg_7_0.showAwardDrops[iter_7_0] then
					cloneTplTo = var_2

					local var_10_0 = var_2(arg_7_0.itemTpl, arg_7_0.itemContainer)

					EducateHelper = var_3

					var_3.UpdateDropShow(var_10_0, var_1)

					onButton = var_3

					var_3(arg_7_0, var_10_0, function()
						local var_11_0 = arg_7_0

						var_0.emit(var_11_0, var_0_1.EDUCATE_ON_ITEM, {
							drop = var_0
						})

						return
					end)
				end

				if arg_7_0.showAttrDrops[iter_7_0] then
					cloneTplTo = var_3

					local var_10_1 = var_3(arg_7_0.attrTpl, arg_7_0.attrContainer)

					EducateHelper = var_4

					var_4.UpdateDropShowForAttr(var_10_1, var_2)
				end

				local var_10_2 = arg_7_0
				local var_10_3 = var_3.managedTween

				LeanTween = var_2_10005

				var_10_3(var_10_2, var_2_10005.delayedCall, function()
					arg_10_0()

					return
				end, 0.066, nil)

				return
			end)
		end

		seriesAsync = var_4

		var_4(var_7_2, function()
			local var_13_0 = arg_7_0
			local var_13_1 = var_0.managedTween

			LeanTween = var_2_10002

			var_13_1(var_13_0, var_2_10002.delayedCall, function()
				arg_7_0.inAnimPlaying = false

				return
			end, 0.066, nil)

			return
		end)
	elseif #arg_7_0.showPolaroidDrops > 0 then
		setActive = var_1

		var_1(arg_7_0.polaroidWindow, true)

		arg_7_0.polaroidIndex = 1

		arg_7_0:showPolaroidAnim()
	else
		assert = var_1

		var_1(nil, "不合法掉落, award/polaroid都为空, 请检查对应配置~")
	end

	return
end

function var_0_1.getAwardDrops(arg_15_0)
	EducateHelper = var_1_10001

	local var_15_0 = var_1_10001.FilterDropByTypes
	local var_15_1 = arg_15_0.drops
	local var_15_2 = {}

	EducateConst = var_1_10004
	var_15_2[1] = var_1_10004.DROP_TYPE_ATTR
	EducateConst = var_4
	var_15_2[2] = var_4.DROP_TYPE_RES
	EducateConst = var_4
	var_15_2[3] = var_4.DROP_TYPE_ITEM
	EducateConst = var_4
	var_15_2[4] = var_4.DROP_TYPE_BUFF

	return var_15_0(var_15_1, var_15_2)
end

function var_0_1.getAttrDrops(arg_16_0)
	EducateHelper = var_1_10001

	local var_16_0 = var_1_10001.FilterDropByTypes
	local var_16_1 = arg_16_0.drops
	local var_16_2 = {}

	EducateConst = var_1_10004
	var_16_2[1] = var_1_10004.DROP_TYPE_ITEM

	local var_16_3 = var_16_0(var_16_1, var_16_2)
	local var_16_4 = {}

	underscore = var_16_2

	var_16_2.each(var_16_3, function(arg_17_0)
		table = var_2_10001

		local var_17_0 = var_2_10001.mergeArray
		local var_17_1 = var_16_4

		EducateHelper = var_2_10003
		var_16_4 = var_17_0(var_17_1, var_2_10003.GetItemAddDrops(arg_17_0))

		return
	end)

	return var_16_4
end

function var_0_1.getPolaroidDrops(arg_18_0)
	EducateHelper = var_1_10001

	local var_18_0 = var_1_10001.FilterDropByTypes
	local var_18_1 = arg_18_0.drops
	local var_18_2 = {}

	EducateConst = var_1_10004
	var_18_2[1] = var_1_10004.DROP_TYPE_POLAROID

	return var_18_0(var_18_1, var_18_2)
end

function var_0_1.showPolaroidAnim(arg_19_0)
	arg_19_0.playing = true

	local var_19_0 = arg_19_0.showPolaroidDrops[arg_19_0.polaroidIndex]

	setActive = var_2

	var_2(arg_19_0.polaroidDescTF, false)

	pg = var_2

	local var_19_1 = var_2.child_polaroid[var_19_0.id]

	LoadImageSpriteAsync = var_3

	var_3("educatepolaroid/" .. var_19_1.pic, arg_19_0.polaroidIconTF)

	setText = var_3

	var_3(arg_19_0.polaroidDescTF, var_19_1.title)

	local var_19_2 = {}

	table = var_4

	var_4.insert(var_19_2, function(arg_20_0)
		local var_20_0 = arg_19_0
		local var_20_1 = var_1.managedTween

		LeanTween = var_2_10003

		var_20_1(var_20_0, var_2_10003.delayedCall, function()
			setActive = var_3_10000

			var_3_10000(arg_19_0.polaroidDescTF, true)
			arg_20_0()

			return
		end, var_0_4, nil)

		return
	end)

	getProxy = var_4
	EducateProxy = var_5

	local var_19_3 = var_4(var_5)

	if var_4.CheckNewSecretaryTip(var_19_3) then
		table = var_4

		var_4.insert(var_19_2, function(arg_22_0)
			local var_22_0 = arg_19_0
			local var_22_1 = var_1.emit
			local var_22_2 = var_0_1.EDUCATE_ON_UNLOCK_TIP
			local var_22_3 = {}

			EducateUnlockTipLayer = var_2_10005
			var_22_3.type = var_2_10005.UNLOCK_NEW_SECRETARY
			var_22_3.onExit = arg_22_0

			var_22_1(var_22_0, var_22_2, var_22_3)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_19_2, function()
		arg_19_0.playing = false
		arg_19_0.polaroidIndex = arg_19_0.polaroidIndex + 1

		return
	end)

	return
end

function var_0_1._close(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.NewGuideMgr.GetInstance()

	if var_1.IsBusy(var_24_0) then
		arg_24_0:emit(var_0_1.ON_CLOSE)

		return
	end

	if arg_24_0.inAnimPlaying or arg_24_0.isCloseAnim then
		return
	end

	local var_24_1 = arg_24_0.anim

	var_1.Play(var_24_1, "anim_educate_awardinfo_award_out")

	arg_24_0.isCloseAnim = true

	return
end

function var_0_1.onBackPressed(arg_25_0)
	arg_25_0:_close()

	return
end

function var_0_1.willExit(arg_26_0)
	pg = var_1_10001

	local var_26_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_26_0, arg_26_0._tf)

	if arg_26_0.contextData.removeFunc then
		arg_26_0.contextData.removeFunc()

		arg_26_0.contextData.removeFunc = nil
	end

	return
end

return var_0_1
