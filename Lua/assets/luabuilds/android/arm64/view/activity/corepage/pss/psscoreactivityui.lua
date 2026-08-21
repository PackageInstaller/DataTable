local var_0_0 = class("PSSCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function var_0_0.getUIName(arg_1_0)
	return "PSSCoreActivityUI"
end

var_0_0.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function var_0_0.init(arg_2_0, ...)
	var_0_0.super.init(arg_2_0, ...)
	setText(arg_2_0._tf:Find("adapt/TopPage/top/deco/Text"), i18n("yumia_main_tip_5"))
	setText(arg_2_0._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("outpost_20250904_Title2"))

	local var_2_0

	arg_2_0.tabsList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = underscore.detect(arg_2_0.activities, function(arg_4_0)
				return tostring(arg_4_0:getConfig("is_show")) == arg_3_2.name
			end)

			if not var_3_0 or var_3_0:isEnd() then
				setActive(arg_3_2, false)
			elseif not arg_2_0.pageDic[var_3_0.id] then
				warning(string.format("without page in act:", var_3_0.id))
			else
				arg_2_0:OnToggleName(arg_3_2, var_3_0:getConfig("is_show"))

				if arg_2_0.pageDic[var_3_0.id] ~= nil then
					setActive(arg_3_2:Find("tip"), var_3_0:readyToAchieve())
					onToggle(arg_2_0, arg_3_2, function(arg_5_0)
						if arg_5_0 then
							if var_2_0 ~= var_3_0.id then
								arg_2_0:selectActivity(var_3_0)
								arg_2_0:OnAnimations(arg_3_2, var_3_0.id)
							end

							var_2_0 = var_3_0.id
						end

						return
					end, SFX_PANEL)
				end
			end
		end

		return
	end)

	arg_2_0.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		arg_2_0:UpdateAdapt()

		return
	end)

	arg_2_0:UpdateAdapt()
	onButton(arg_2_0, arg_2_0._tf:Find("adapt/TopPage/top/btn_back"), function()
		arg_2_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)

	return
end

function var_0_0.UpdateAdapt(arg_8_0)
	local var_8_0 = 2.3333333333333335
	local var_8_1 = pg.CameraFixMgr.GetInstance()

	arg_8_0._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_8_1.currentWidth / var_8_1.currentHeight, 1.3333333333333333, 2.3333333333333335)

	setSizeDelta(arg_8_0._tf:Find("adapt"), {
		x = 0,
		y = 0
	})
	SetComponentEnabled(arg_8_0._tf:Find("adapt"), "NotchAdapt", NotchAdapt.CheckNotchRatio == math.clamp(NotchAdapt.CheckNotchRatio, 1.3333333333333333, var_8_0))

	return
end

function var_0_0.OnToggleName(arg_9_0, arg_9_1, arg_9_2)
	setText(arg_9_1:Find("on/name"), i18n("general_activity_side_bar" .. arg_9_2))
	setText(arg_9_1:Find("name"), i18n("general_activity_side_bar" .. arg_9_2))

	return
end

function var_0_0.OnAnimations(arg_10_0, arg_10_1, arg_10_2)
	SetActive(arg_10_0._tf:Find("adapt/l"), arg_10_2 == 50234)
	SetActive(arg_10_0._tf:Find("adapt/r"), arg_10_2 == 50234)
	SetActive(arg_10_0._tf:Find("adapt/below"), arg_10_2 == 50234)

	return
end

function var_0_0.willExit(arg_11_0)
	var_0_0.super.willExit(arg_11_0)

	if arg_11_0.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(arg_11_0.camEventId)

		arg_11_0.camEventId = nil
	end

	return
end

return var_0_0
