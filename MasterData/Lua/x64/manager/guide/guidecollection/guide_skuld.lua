local Guide_skuld = class("Guide_skuld", BaseGuide)

function Guide_skuld:CheckGuide()
	if not GuideTool.SatisfyCondition(self.open_condition) then
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
		if var_1_0.chapterID_ then
			if ChapterCfg[var_1_0.chapterID_] then
				return ChapterCfg[var_1_0.chapterID_].sub_type == 13
			end
		end
	end
end

return Guide_skuld
