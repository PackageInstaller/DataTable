local ALYCoreActivityUI = class("ALYCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))
local var_0_1 = 7

function ALYCoreActivityUI:getUIName()
	return "ALYCoreActivityUI"
end

function ALYCoreActivityUI:init(...)
	ALYCoreActivityUI.super.init(self, ...)

	local var_2_0, var_2_1 = pg.TimeMgr.GetInstance():inTime(pg.activity_template[var_0_1].time)

	setText(self._tf:Find("adapt/top/btn_home/text_tip/Text (Legacy)"), i18n("yumia_main_tip_4", (var_2_1 or nil) and ALYCoreActivityUI:skinCommdityTimeStamps((pg.TimeMgr.GetInstance():Table2ServerTime(var_2_1)))))
	self:Reset()
	self.tabsList:make(function(arg_3_0, arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 + 1

		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = underscore.detect(self.activities, function(arg_4_0)
				return tostring(arg_4_0:getConfig("is_show")) == arg_3_2.name
			end)

			if not var_3_0 or var_3_0:isEnd() then
				setActive(arg_3_2, false)
			elseif not self.pageDic[var_3_0.id] then
				warning(string.format("without page in act:", var_3_0.id))
			else
				if var_3_0.id ~= 15 then
					if var_3_0.id == 10 then
						setActive(arg_3_2:Find("tip"), var_3_0:readyToAchieve())

						goto label_3_0
					end
				end

				setActive(arg_3_2:Find("tip"), false)

				::label_3_0::

				onToggle(self, arg_3_2, function(arg_5_0)
					warning(arg_3_1, arg_5_0)

					if arg_5_0 then
						if arg_3_1 == 3 then
							setActive(self._tf:Find("Image/VX"), false)
						else
							setActive(self._tf:Find("Image/VX"), true)
						end

						self:selectActivity(var_3_0)
						quickPlayAnimation(arg_3_2:Find("on"), "Anim_ALYCoreActivityUI_tabs_selected")
					end

					return
				end, SFX_PANEL)
			end
		end

		return
	end)

	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		self:UpdateAdapt()

		return
	end)

	self:UpdateAdapt()

	self.anim_1 = self._tf:Find("adapt/tabs/1/off"):GetComponent(typeof(Animation))
	self.anim_2 = self._tf:Find("adapt/tabs/2/off"):GetComponent(typeof(Animation))
	self.anim_3 = self._tf:Find("adapt/tabs/3/off"):GetComponent(typeof(Animation))
	self.anim_4 = self._tf:Find("adapt/tabs/4/off"):GetComponent(typeof(Animation))
	self.anim_5 = self._tf:Find("adapt/tabs/5/off"):GetComponent(typeof(Animation))
	self.anim_tf_Event = self._tf:GetComponent(typeof(DftAniEvent))

	self.anim_tf_Event:SetStartEvent(function()
		setCanvasGroupAlpha(self._tf:Find("adapt/tabs/1"), 1)

		for iter_7_0 = 4, 5 do
			onDelayTick(function()
				if iter_7_0 == 4 then
					setCanvasGroupAlpha(self._tf:Find("adapt/tabs/3"), 1)
					setCanvasGroupAlpha(self._tf:Find("adapt/tabs/4"), 1)
				elseif iter_7_0 == 5 then
					setCanvasGroupAlpha(self._tf:Find("adapt/tabs/2"), 1)
					setCanvasGroupAlpha(self._tf:Find("adapt/tabs/5"), 1)
				end

				return
			end, 0.08 * (iter_7_0 - 3))
		end

		return
	end)

	self.anim_1_Event = self._tf:Find("adapt/tabs/1/off"):GetComponent(typeof(DftAniEvent))

	self.anim_1_Event:SetStartEvent(function()
		setCanvasGroupAlpha(self._tf:Find("adapt/tabs/3"), 1)
		setCanvasGroupAlpha(self._tf:Find("adapt/tabs/4"), 1)

		return
	end)

	return
end

function ALYCoreActivityUI:didEnter()
	ALYCoreActivityUI.super.didEnter(self)

	return
end

function ALYCoreActivityUI:UpdateAdapt()
	local var_11_0 = pg.CameraFixMgr.GetInstance()

	self._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_11_0.currentWidth / var_11_0.currentHeight, 1.3333333333333333, 2.1666666666666665)

	return
end

function ALYCoreActivityUI:Reset()
	for iter_12_0 = 1, 5 do
		setText(self._tf:Find("adapt/tabs/" .. iter_12_0 .. "/off/Label/name_bg/name"), i18n("yumia_main_tip_" .. iter_12_0 + 4))
		setText(self._tf:Find("adapt/tabs/" .. iter_12_0 .. "/on/Label/name_bg/name"), i18n("yumia_main_tip_" .. iter_12_0 + 4))
	end

	return
end

function ALYCoreActivityUI:skinCommdityTimeStamps(arg_13_1)
	local var_13_0 = pg.TimeMgr.GetInstance()
	local var_13_1 = math.floor(math.max(arg_13_1 - var_13_0:GetServerTime(), 0) / 0)

	if var_13_0 > 0 then
		return var_13_1
	elseif var_13_1 <= 0 then
		return 0
	end

	return
end

function ALYCoreActivityUI:willExit()
	ALYCoreActivityUI.super.willExit(self)

	if self.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

		self.camEventId = nil
	end

	return
end

return ALYCoreActivityUI
