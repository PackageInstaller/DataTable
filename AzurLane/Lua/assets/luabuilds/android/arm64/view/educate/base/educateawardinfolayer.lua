local var_0_0 = class("EducateAwardInfoLayer", import("..base.EducateBaseUI"))
local var_0_1 = {
	Vector2(0, 115),
	Vector2(0, 162)
}
local var_0_2 = {
	Vector2(0, -280),
	Vector2(0, -315)
}
local var_0_3 = 0.4

function var_0_0.getUIName(arg_1_0)
	return "EducateAwardInfoUI"
end

function var_0_0.init(arg_2_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	arg_2_0.drops = arg_2_0.contextData.items or {}
	arg_2_0.awardWindow = arg_2_0._tf:Find("award_window")
	arg_2_0.anim = arg_2_0.awardWindow:GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0.awardWindow:GetComponent(typeof(DftAniEvent))

	arg_2_0.animEvent:SetEndEvent(function()
		if #arg_2_0.showPolaroidDrops > 0 then
			setActive(arg_2_0.awardWindow, false)
			setActive(arg_2_0.polaroidWindow, true)

			arg_2_0.polaroidIndex = 1

			arg_2_0:showPolaroidAnim()
		else
			arg_2_0:emit(var_0_0.ON_CLOSE)
		end

		return
	end)

	arg_2_0.tipTF = arg_2_0.awardWindow:Find("tip")

	setText(arg_2_0.tipTF, i18n("child_close_tip"))

	arg_2_0.itemContent = arg_2_0.awardWindow:Find("content/items")
	arg_2_0.itemContainer = arg_2_0.itemContent:Find("items_scroll/content")
	arg_2_0.itemTpl = arg_2_0.awardWindow:Find("item_tpl")

	setActive(arg_2_0.itemTpl, false)

	arg_2_0.attrContent = arg_2_0.awardWindow:Find("content/attrs")
	arg_2_0.attrContainer = arg_2_0.attrContent:Find("attrs_scroll/content")
	arg_2_0.attrTpl = arg_2_0.awardWindow:Find("attr_tpl")

	setActive(arg_2_0.attrTpl, false)

	arg_2_0.polaroidWindow = arg_2_0._tf:Find("polaroid_window")
	arg_2_0.polaroidIconTF = arg_2_0.polaroidWindow:Find("content/mask/icon")
	arg_2_0.polaroidDescTF = arg_2_0.polaroidWindow:Find("content/desc")

	setActive(arg_2_0.awardWindow, false)
	setActive(arg_2_0.polaroidWindow, false)
	arg_2_0._tf:SetAsLastSibling()

	return
end

function var_0_0.didEnter(arg_4_0)
	onButton(arg_4_0, arg_4_0.awardWindow:Find("close"), function()
		arg_4_0:_close()

		return
	end, SFX_CANCEL)
	onButton(arg_4_0, arg_4_0.polaroidWindow, function()
		if arg_4_0.playing then
			return
		end

		pg.TipsMgr.GetInstance():ShowTips(i18n("child_polaroid_get_tip"))

		if arg_4_0.polaroidIndex <= #arg_4_0.showPolaroidDrops then
			arg_4_0:showPolaroidAnim()
		else
			arg_4_0:emit(var_0_0.ON_CLOSE)
		end

		return
	end, SFX_CANCEL)

	arg_4_0.showAwardDrops = arg_4_0:getAwardDrops()
	arg_4_0.showAttrDrops = arg_4_0:getAttrDrops()
	arg_4_0.showPolaroidDrops = arg_4_0:getPolaroidDrops()

	setActive(arg_4_0.attrContent, #arg_4_0.showAttrDrops > 0)
	arg_4_0:showWindow()

	return
end

function var_0_0.showWindow(arg_7_0)
	if #arg_7_0.showAwardDrops > 0 then
		arg_7_0.inAnimPlaying = true

		setActive(arg_7_0.awardWindow, true)
		arg_7_0.anim:Play(#arg_7_0.showAttrDrops > 0 and "anim_educate_awardinfo_awardattr_in" or "anim_educate_awardinfo_award_in")
		table.insert({}, function(arg_8_0)
			arg_7_0:managedTween(LeanTween.delayedCall, function()
				arg_8_0()

				return
			end, 0.33, nil)

			return
		end)

		for iter_7_0 = 1, math.max(#arg_7_0.showAttrDrops, #arg_7_0.showAwardDrops) do
			table.insert({}, function(arg_10_0)
				local var_10_0 = arg_7_0.showAwardDrops[iter_7_0]

				if arg_7_0.showAwardDrops[iter_7_0] then
					local var_10_1 = cloneTplTo(arg_7_0.itemTpl, arg_7_0.itemContainer)

					EducateHelper.UpdateDropShow(var_10_1, arg_7_0.showAwardDrops[iter_7_0])
					onButton(arg_7_0, var_10_1, function()
						arg_7_0:emit(var_0_0.EDUCATE_ON_ITEM, {
							drop = var_10_0
						})

						return
					end)
				end

				local var_10_2 = arg_7_0.showAttrDrops[iter_7_0]

				if arg_7_0.showAttrDrops[iter_7_0] then
					EducateHelper.UpdateDropShowForAttr(cloneTplTo(arg_7_0.attrTpl, arg_7_0.attrContainer), var_10_2)
				end

				arg_7_0:managedTween(LeanTween.delayedCall, function()
					arg_10_0()

					return
				end, 0.066, nil)

				return
			end)
		end

		seriesAsync({}, function()
			arg_7_0:managedTween(LeanTween.delayedCall, function()
				arg_7_0.inAnimPlaying = false

				return
			end, 0.066, nil)

			return
		end)
	elseif #arg_7_0.showPolaroidDrops > 0 then
		setActive(arg_7_0.polaroidWindow, true)

		arg_7_0.polaroidIndex = 1

		arg_7_0:showPolaroidAnim()
	else
		assert(nil, "不合法掉落, award/polaroid都为空, 请检查对应配置~")
	end

	return
end

function var_0_0.getAwardDrops(arg_15_0)
	return EducateHelper.FilterDropByTypes(arg_15_0.drops, {
		EducateConst.DROP_TYPE_ATTR,
		EducateConst.DROP_TYPE_RES,
		EducateConst.DROP_TYPE_ITEM,
		EducateConst.DROP_TYPE_BUFF
	})
end

function var_0_0.getAttrDrops(arg_16_0)
	local var_16_0 = {}

	underscore.each(EducateHelper.FilterDropByTypes(arg_16_0.drops, {
		EducateConst.DROP_TYPE_ITEM
	}), function(arg_17_0)
		var_16_0 = table.mergeArray(var_16_0, EducateHelper.GetItemAddDrops(arg_17_0))

		return
	end)

	return {}
end

function var_0_0.getPolaroidDrops(arg_18_0)
	return EducateHelper.FilterDropByTypes(arg_18_0.drops, {
		EducateConst.DROP_TYPE_POLAROID
	})
end

function var_0_0.showPolaroidAnim(arg_19_0)
	arg_19_0.playing = true

	setActive(arg_19_0.polaroidDescTF, false)
	LoadImageSpriteAsync("educatepolaroid/" .. pg.child_polaroid[arg_19_0.showPolaroidDrops[arg_19_0.polaroidIndex].id].pic, arg_19_0.polaroidIconTF)
	setText(arg_19_0.polaroidDescTF, pg.child_polaroid[arg_19_0.showPolaroidDrops[arg_19_0.polaroidIndex].id].title)
	table.insert({}, function(arg_20_0)
		arg_19_0:managedTween(LeanTween.delayedCall, function()
			setActive(arg_19_0.polaroidDescTF, true)
			arg_20_0()

			return
		end, var_0_3, nil)

		return
	end)

	if getProxy(EducateProxy):CheckNewSecretaryTip() then
		table.insert({}, function(arg_22_0)
			arg_19_0:emit(var_0_0.EDUCATE_ON_UNLOCK_TIP, {
				type = EducateUnlockTipLayer.UNLOCK_NEW_SECRETARY,
				onExit = arg_22_0
			})

			return
		end)
	end

	seriesAsync({}, function()
		arg_19_0.playing = false
		arg_19_0.polaroidIndex = arg_19_0.polaroidIndex + 1

		return
	end)

	return
end

function var_0_0._close(arg_24_0)
	if pg.NewGuideMgr.GetInstance():IsBusy() then
		arg_24_0:emit(var_0_0.ON_CLOSE)

		return
	end

	if arg_24_0.inAnimPlaying or arg_24_0.isCloseAnim then
		return
	end

	arg_24_0.anim:Play("anim_educate_awardinfo_award_out")

	arg_24_0.isCloseAnim = true

	return
end

function var_0_0.onBackPressed(arg_25_0)
	arg_25_0:_close()

	return
end

function var_0_0.willExit(arg_26_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_26_0._tf)

	if arg_26_0.contextData.removeFunc then
		arg_26_0.contextData.removeFunc()

		arg_26_0.contextData.removeFunc = nil
	end

	return
end

return var_0_0
