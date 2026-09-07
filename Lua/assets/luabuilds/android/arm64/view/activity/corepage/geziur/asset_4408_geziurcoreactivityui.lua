local GeZiURCoreActivityUI = class("GeZiURCoreActivityUI", import("view.activity.CorePage.Helena.HelenaCoreActivityUI"))
local var_0_1 = "#473C2F"
local var_0_2 = "#29323B"
local var_0_3 = "#B39D83"

function GeZiURCoreActivityUI:getUIName()
	return "GeZiURCoreActivityUI"
end

function GeZiURCoreActivityUI:init(...)
	GeZiURCoreActivityUI.super.init(self, ...)

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
								self:OnAnimations(arg_3_2, var_3_0)
							end

							var_2_0 = var_3_0.id

							if self:GetActivityClassName(var_3_0) == "YidaliV5FramePage" then
								self:SetColorTab(var_0_1)
							elseif self:GetActivityClassName(var_3_0) == "OutPostOmenPage" then
								self:SetColorTab(var_0_2)
							else
								self:SetColorTab(var_0_3)
							end
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

function GeZiURCoreActivityUI:SetColorTab(arg_6_1)
	for iter_6_0 = 0, self.tabs.childCount - 1 do
		local var_6_0 = self.tabs:GetChild(iter_6_0):Find("off/name")

		if var_6_0 then
			setTextColor(var_6_0, Color.NewHex(arg_6_1))
		end
	end

	return
end

function GeZiURCoreActivityUI:OnToggleName(arg_7_1, arg_7_2)
	setText(arg_7_1:Find("off/name"), i18n(arg_7_2:getConfig("title_res_tag")))
	setText(arg_7_1:Find("on/name/name"), i18n(arg_7_2:getConfig("title_res_tag")))

	return
end

function GeZiURCoreActivityUI:GetActivityClassName(arg_8_1)
	if not arg_8_1 then
		return nil
	end

	local var_8_0 = arg_8_1:getConfig("page_info")

	if type(var_8_0) == "table" then
		return var_8_0.class_name
	end

	return nil
end

return GeZiURCoreActivityUI
