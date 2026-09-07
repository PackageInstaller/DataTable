local TianYuTianYuanCoreActivityUI = class("TianYuTianYuanCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function TianYuTianYuanCoreActivityUI:getUIName()
	return "TianYuTianYuanCoreActivityUI"
end

TianYuTianYuanCoreActivityUI.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function TianYuTianYuanCoreActivityUI:init(...)
	TianYuTianYuanCoreActivityUI.super.init(self, ...)
	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("outpost_20250904_Title1"))
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
				setText(arg_3_2:Find("on/name"), i18n("outpost_20250904_Sidebar" .. var_3_0:getConfig("is_show")))
				setText(arg_3_2:Find("name"), i18n("outpost_20250904_Sidebar" .. var_3_0:getConfig("is_show")))

				if self.pageDic[var_3_0.id] ~= nil then
					setActive(arg_3_2:Find("tip"), var_3_0:readyToAchieve())
					onToggle(self, arg_3_2, function(arg_5_0)
						if arg_5_0 then
							self:selectActivity(var_3_0)

							if var_2_0 ~= var_3_0.id then
								quickPlayAnimation(arg_3_2, "Anim_TianYuTianYuanCoreActivityUI_select")
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
		self:emit(TianYuTianYuanCoreActivityUI.ON_BACK)

		return
	end, SOUND_BACK)

	return
end

function TianYuTianYuanCoreActivityUI:UpdateAdapt()
	local var_8_0 = pg.CameraFixMgr.GetInstance()

	self._tf:GetComponent(typeof(AspectRatioFitter)).aspectRatio = math.clamp(var_8_0.currentWidth / var_8_0.currentHeight, 1.3333333333333333, 2.1666666666666665)

	return
end

function TianYuTianYuanCoreActivityUI:willExit()
	TianYuTianYuanCoreActivityUI.super.willExit(self)

	if self.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(self.camEventId)

		self.camEventId = nil
	end

	return
end

return TianYuTianYuanCoreActivityUI
