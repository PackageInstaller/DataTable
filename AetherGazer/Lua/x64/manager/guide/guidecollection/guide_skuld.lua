local var_0_0 = class("Guide_skuld", BaseGuide)

function var_0_0.CheckGuide(arg_1_0)
	if not GuideTool.SatisfyCondition(arg_1_0.open_condition) then
		return false
	end

	if not SkuldTravelData:GetSkuldTravelIsOpen() then
		return false
	end

	if gameContext:GetOpenPageHandler("skuldTravelView") then
		return true
	end

	local var_1_0 = gameContext:GetOpenPageHandler("chapterSection")

	if var_1_0 and not gameContext:IsOpenRoute("chapterSectionInfo") then
		local var_1_1 = var_1_0.chapterID_

		if var_1_1 then
			local var_1_2 = ChapterCfg[var_1_1]

			if var_1_2 then
				return var_1_2.sub_type == 13
			end
		end
	end
end

return var_0_0
