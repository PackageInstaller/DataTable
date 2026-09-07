local PSSCoreActivityUI = class("PSSCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function PSSCoreActivityUI:getUIName()
	return "PSSCoreActivityUI"
end

PSSCoreActivityUI.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function PSSCoreActivityUI:init(...)
	PSSCoreActivityUI.super.init(self, ...)
	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("yumia_main_tip_5"))
	setText(self._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("outpost_20250904_Title2"))

	local var_2_0

	self.tabsList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = underscore.detect(self.activities, function(arg_4_0)
				return tostring(arg_4_0:getConfig("is_show")) == arg_3_2.name
			end)

			if not var_3_0 or var_3_0:isEnd() then
				setActive(arg_3_2, false)
			elseif not self.pageDic[var_3_0.id] then
				warning(string.format("without page in act:", var_3_0.id))
			else
				self:OnToggleName(arg_3_2, var_3_0:getConfig("is_show"))

				if self.pageDic[var_3_0.id] ~= nil then
					setActive(arg_3_2:Find("tip"), var_3_0:readyToAchieve())
					onToggle(self, arg_3_2, function(arg_5_0)
						if arg_5_0 then
							if var_2_0 ~= var_3_0.id then
								self:selectActivity(var_3_0)
								self:OnAnimations(arg_3_2, var_3_0.id)
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

	self.camEventId = pg.CameraFixMgr.GetInstance():bind(pg.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		self:UpdateAdapt()

		return
	end)

	self:UpdateAdapt()
	onButton(self, self._tf:Find("adapt/TopPage/top/btn_back"), function()
		self:emit(PSSCoreActivityUI.ON_BACK)

		return
	end, SOUND_BACK)

	return
end

function PSSCoreActivityUI:UpdateAdapt()
	local var_8_0 = 2.3333333333333335
	local var_8_1 = pg.CameraFixMgr.GetInstance()

	self._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_8_1.currentWidth / var_8_1.currentHeight, 1.3333333333333333, 2.3333333333333335)

	setSizeDelta(self._tf:Find("adapt"), {
		x = 0,
		y = 0
	})
	SetComponentEnabled(self._tf:Find("adapt"), "NotchAdapt", NotchAdapt.CheckNotchRatio == math.clamp(NotchAdapt.CheckNotchRatio, 1.3333333333333333, var_8_0))

	return
end

function PSSCoreActivityUI:OnToggleName(arg_9_1, arg_9_2)
	setText(arg_9_1:Find("on/name"), i18n("general_activity_side_bar" .. arg_9_2))
	setText(arg_9_1:Find("name"), i18n("general_activity_side_bar" .. arg_9_2))

	return
end

function PSSCoreActivityUI:OnAnimations(arg_10_1, arg_10_2)
	SetActive(self._tf:Find("adapt/l"), arg_10_2 == 50234)
	SetActive(self._tf:Find("adapt/r"), arg_10_2 == 50234)
	SetActive(self._tf:Find("adapt/below"), arg_10_2 == 50234)

	return
end

function PSSCoreActivityUI:willExit()
	PSSCoreActivityUI.super.willExit(self)

	if self.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

		self.camEventId = nil
	end

	return
end

return PSSCoreActivityUI
