local StarsCityCoreActivityUI = class("StarsCityCoreActivityUI", import("view.activity.CorePage.CoreActivityMainScene"))

function StarsCityCoreActivityUI:getUIName()
	return "StarsCityCoreActivityUI"
end

StarsCityCoreActivityUI.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function StarsCityCoreActivityUI:init(...)
	StarsCityCoreActivityUI.super.init(self, ...)

	self.topPage = self._tf:Find("adapt/TopPage")
	self.btnBack = self.topPage:Find("top/btn_back")

	setText(self._tf:Find("adapt/TopPage/top/deco/Text"), i18n("HelenaCoreActivity_title"))
	setText(self._tf:Find("adapt/TopPage/top/deco/Text/Text_1"), i18n("HelenaCoreActivity_title2"))

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
				self:OnToggleName(arg_3_2, var_3_0)

				if self.pageDic[var_3_0.id] ~= nil then
					setActive(arg_3_2:Find("tip"), var_3_0:readyToAchieve())
					onToggle(self, arg_3_2, function(arg_5_0)
						if arg_5_0 then
							if var_2_0 ~= var_3_0.id then
								self:selectActivity(var_3_0)
							end

							var_2_0 = var_3_0.id
						end

						setActive(arg_3_2:Find("off"), not arg_5_0)
						setActive(arg_3_2:Find("on"), arg_5_0)

						return
					end, SFX_PANEL)
				end
			end
		end

		return
	end)

	return
end

function StarsCityCoreActivityUI:IsImageTgName()
	return true
end

function StarsCityCoreActivityUI:ActiveScenarioLayer(arg_7_1)
	self.contextData.activeScenario = arg_7_1

	return
end

return StarsCityCoreActivityUI
