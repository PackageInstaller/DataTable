local var_0_0 = class("EducateUnlockTipLayer", import("..base.EducateBaseUI"))

var_0_0.UNLOCK_TYPE_SYSTEM = 1
var_0_0.UNLOCK_TYPE_SITE = 2
var_0_0.UNLOCK_TYPE_PLAN = 3
var_0_0.UNLOCK_NEW_SECRETARY = 4

function var_0_0.getUIName(arg_1_0)
	return "EducateUnlockTip"
end

function var_0_0.init(arg_2_0)
	arg_2_0.anim = arg_2_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_2_0.animEvent:SetEndEvent(function()
		arg_2_0:emit(var_0_0.ON_CLOSE)

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(arg_2_0._tf)

	arg_2_0._tipTF = arg_2_0._tf:Find("anim_root/tip")
	arg_2_0.contentTF = arg_2_0._tipTF:Find("tip_bg/layout/title/name")

	setText(arg_2_0._tipTF:Find("tip_bg/layout/title/unlock"), i18n("child_unlock_tip"))

	return
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:setContent()

	return
end

function var_0_0.setContent(arg_5_0)
	local var_5_0 = ""

	switch(arg_5_0.contextData.type, {
		[var_0_0.UNLOCK_TYPE_SYSTEM] = function()
			var_5_0 = EducateTipHelper.system_tip_list[arg_5_0.contextData.single]

			return
		end,
		[var_0_0.UNLOCK_TYPE_SITE] = function()
			for iter_7_0, iter_7_1 in ipairs(arg_5_0.contextData.list) do
				var_5_0 = var_5_0 .. pg.child_site[iter_7_1].name .. " "
			end

			return
		end,
		[var_0_0.UNLOCK_TYPE_PLAN] = function()
			for iter_8_0, iter_8_1 in ipairs(arg_5_0.contextData.list) do
				var_5_0 = var_5_0 .. pg.child_plan[iter_8_1].name .. " "
			end

			return
		end,
		[var_0_0.UNLOCK_NEW_SECRETARY] = function()
			var_5_0 = i18n("child_unlock_new_secretary")

			return
		end
	})
	setText(arg_5_0.contentTF, shortenString("", 15))

	return
end

function var_0_0.saveTipRecord(arg_10_0)
	switch(arg_10_0.contextData.type, {
		[var_0_0.UNLOCK_TYPE_SYSTEM] = function()
			EducateTipHelper.SaveSystemUnlockTip(arg_10_0.contextData.single)

			return
		end,
		[var_0_0.UNLOCK_TYPE_SITE] = function()
			for iter_12_0, iter_12_1 in ipairs(arg_10_0.contextData.list) do
				EducateTipHelper.SaveSiteUnlockTipId(iter_12_1)
			end

			return
		end,
		[var_0_0.UNLOCK_TYPE_PLAN] = function()
			for iter_13_0, iter_13_1 in ipairs(arg_10_0.contextData.list) do
				EducateTipHelper.SavePlanUnlockTipId(iter_13_1)
			end

			return
		end
	})

	return
end

function var_0_0.onBackPressed(arg_14_0)
	return
end

function var_0_0.willExit(arg_15_0)
	arg_15_0:saveTipRecord()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0._tf)

	if arg_15_0.contextData.onExit then
		arg_15_0.contextData.onExit()
	end

	return
end

return var_0_0
