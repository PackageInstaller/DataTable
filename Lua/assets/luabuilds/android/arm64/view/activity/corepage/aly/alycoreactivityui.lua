local var_0_0 = class("ALYCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))
local var_0_1 = 7

function var_0_0.getUIName(arg_1_0)
	return "ALYCoreActivityUI"
end

function var_0_0.init(arg_2_0, ...)
	var_0_0.super.init(arg_2_0, ...)

	local var_2_0, var_2_1 = pg.TimeMgr.GetInstance():inTime(pg.activity_template[var_0_1].time)
	local var_2_2

	if var_2_1 then
		var_2_2 = var_0_0:skinCommdityTimeStamps((pg.TimeMgr.GetInstance():Table2ServerTime(var_2_1)))
	end

	setText(arg_2_0._tf:Find("adapt/top/btn_home/text_tip/Text (Legacy)"), i18n("yumia_main_tip_4", var_2_2))
	arg_2_0:Reset()
	arg_2_0.tabsList:make(function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1

		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = underscore.detect(arg_2_0.activities, function(arg_4_0)
				return tostring(arg_4_0:getConfig("is_show")) == arg_3_2.name
			end)

			if not var_3_0 or var_3_0:isEnd() then
				setActive(arg_3_2, false)

				goto label_3_0
			end

			if not arg_2_0.pageDic[var_3_0.id] then
				warning(string.format("without page in act:", var_3_0.id))

				goto label_3_0
			end

			::label_3_0::

			if var_3_0.id ~= 15 then
				if var_3_0.id == 10 then
					setActive(arg_3_2:Find("tip"), var_3_0:readyToAchieve())
				else
					setActive(arg_3_2:Find("tip"), false)
				end

				onToggle(arg_2_0, arg_3_2, function(arg_5_0)
					warning(arg_3_1, arg_5_0)

					if arg_5_0 then
						if arg_3_1 == 3 then
							setActive(arg_2_0._tf:Find("Image/VX"), false)
						else
							setActive(arg_2_0._tf:Find("Image/VX"), true)
						end

						arg_2_0:selectActivity(var_3_0)
						quickPlayAnimation(arg_3_2:Find("on"), "Anim_ALYCoreActivityUI_tabs_selected")
					end

					return
				end, SFX_PANEL)

				return
			end
		end
	end)

	arg_2_0.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		arg_2_0:UpdateAdapt()

		return
	end)

	arg_2_0:UpdateAdapt()

	arg_2_0.anim_1 = arg_2_0._tf:Find("adapt/tabs/1/off"):GetComponent(typeof(Animation))
	arg_2_0.anim_2 = arg_2_0._tf:Find("adapt/tabs/2/off"):GetComponent(typeof(Animation))
	arg_2_0.anim_3 = arg_2_0._tf:Find("adapt/tabs/3/off"):GetComponent(typeof(Animation))
	arg_2_0.anim_4 = arg_2_0._tf:Find("adapt/tabs/4/off"):GetComponent(typeof(Animation))
	arg_2_0.anim_5 = arg_2_0._tf:Find("adapt/tabs/5/off"):GetComponent(typeof(Animation))
	arg_2_0.anim_tf_Event = arg_2_0._tf:GetComponent(typeof(DftAniEvent))

	arg_2_0.anim_tf_Event:SetStartEvent(function()
		setCanvasGroupAlpha(arg_2_0._tf:Find("adapt/tabs/1"), 1)

		for iter_7_0 = 4, 5 do
			onDelayTick(function()
				if iter_7_0 == 4 then
					setCanvasGroupAlpha(arg_2_0._tf:Find("adapt/tabs/3"), 1)
					setCanvasGroupAlpha(arg_2_0._tf:Find("adapt/tabs/4"), 1)
				elseif iter_7_0 == 5 then
					setCanvasGroupAlpha(arg_2_0._tf:Find("adapt/tabs/2"), 1)
					setCanvasGroupAlpha(arg_2_0._tf:Find("adapt/tabs/5"), 1)
				end

				return
			end, 0.08 * (iter_7_0 - 3))
		end

		return
	end)

	arg_2_0.anim_1_Event = arg_2_0._tf:Find("adapt/tabs/1/off"):GetComponent(typeof(DftAniEvent))

	arg_2_0.anim_1_Event:SetStartEvent(function()
		setCanvasGroupAlpha(arg_2_0._tf:Find("adapt/tabs/3"), 1)
		setCanvasGroupAlpha(arg_2_0._tf:Find("adapt/tabs/4"), 1)

		return
	end)

	return
end

function var_0_0.didEnter(arg_10_0)
	var_0_0.super.didEnter(arg_10_0)

	return
end

function var_0_0.UpdateAdapt(arg_11_0)
	local var_11_0 = pg.CameraFixMgr.GetInstance()

	arg_11_0._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_11_0.currentWidth / var_11_0.currentHeight, 1.3333333333333333, 2.1666666666666665)

	return
end

function var_0_0.Reset(arg_12_0)
	for iter_12_0 = 1, 5 do
		setText(arg_12_0._tf:Find("adapt/tabs/" .. iter_12_0 .. "/off/Label/name_bg/name"), i18n("yumia_main_tip_" .. iter_12_0 + 4))
		setText(arg_12_0._tf:Find("adapt/tabs/" .. iter_12_0 .. "/on/Label/name_bg/name"), i18n("yumia_main_tip_" .. iter_12_0 + 4))
	end

	return
end

function var_0_0.skinCommdityTimeStamps(arg_13_0, arg_13_1)
	local var_13_9000
	local var_13_0 = pg.TimeMgr.GetInstance()
	local var_13_1 = math.floor(math.max(arg_13_1 - var_13_0.GetServerTime(var_13_9000), 0) / 0)

	if var_13_0 > 0 then
		return var_13_1
	elseif var_13_1 <= 0 then
		return 0
	end

	return
end

function var_0_0.willExit(arg_14_0)
	var_0_0.super.willExit(arg_14_0)

	if arg_14_0.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(arg_14_0.camEventId)

		arg_14_0.camEventId = nil
	end

	return
end

return var_0_0
