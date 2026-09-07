local AnniversaryNineCoreActivityUI = class("AnniversaryNineCoreActivityUI", import("view.activity.CorePage.CoreAdaptActivityMainScene"))
local var_0_1 = "#a6beb7"
local var_0_2 = "#584E45"

function AnniversaryNineCoreActivityUI:getUIName()
	return "AnniversaryNineCoreActivityUI"
end

AnniversaryNineCoreActivityUI.optionsPath = {
	"adapt/TopPage/top/btn_home"
}

function AnniversaryNineCoreActivityUI:init(...)
	AnniversaryNineCoreActivityUI.super.init(self, ...)

	self.topPage = self._tf:Find("adapt/TopPage")

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
				setText(arg_3_2:Find("off/name"), self:GetButtonNameText(var_3_0))
				setText(arg_3_2:Find("on/name"), self:GetButtonNameText(var_3_0))

				if self.pageDic[var_3_0.id] ~= nil then
					local var_3_1 = self.pageDic[var_3_0.id]:IsShowReminder()

					setActive(arg_3_2:Find("tip"), var_3_0:readyToAchieve())
					onToggle(self, arg_3_2, function(arg_5_0)
						if arg_5_0 then
							self:selectActivity(var_3_0)

							if var_2_0 ~= var_3_0.id then
								self:OnClickBtn(arg_3_2, var_3_0.id)
							end

							var_2_0 = var_3_0.id

							local var_5_0 = self:GetActivityClassName(var_3_0)

							if var_5_0 == "AnniversaryNineHwahJahSkinPage" or var_5_0 == "AnniversaryNineEvertsenSkinPage" then
								self:SetColorTab(var_0_1)
							else
								self:SetColorTab(var_0_2)
							end
						end

						return
					end, SFX_PANEL)
				end
			end
		end

		return
	end)

	return
end

function AnniversaryNineCoreActivityUI:SetColorTab(arg_6_1)
	for iter_6_0 = 0, self.tabs.childCount - 1 do
		local var_6_0 = self.tabs:GetChild(iter_6_0):Find("off/name")

		if var_6_0 then
			setTextColor(var_6_0, Color.NewHex(arg_6_1))
		end
	end

	return
end

function AnniversaryNineCoreActivityUI:GetActivityClassName(arg_7_1)
	if not arg_7_1 then
		return nil
	end

	local var_7_0 = arg_7_1:getConfig("page_info")

	if type(var_7_0) == "table" then
		return var_7_0.class_name
	end

	return nil
end

function AnniversaryNineCoreActivityUI:GetButtonNameText(arg_8_1)
	return i18n(string.format(arg_8_1:getConfig("title_res_tag")))
end

return AnniversaryNineCoreActivityUI
