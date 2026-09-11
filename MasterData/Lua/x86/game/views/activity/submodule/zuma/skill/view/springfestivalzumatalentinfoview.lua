local SpringFestivalZumaTalentInfoView = class("SpringFestivalZumaTalentInfoView", ReduxView)

function SpringFestivalZumaTalentInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:InitUI()
end

function SpringFestivalZumaTalentInfoView:InitUI()
	self:BindCfgUI()

	self.lockController = self.controller_:GetController("lockState")

	self:AddBtnListener(self.unlockBtn_, nil, function()
		ShowTips("ACTIVITY_ZUMA_TALENT_LOCK")
	end)
	self:AddBtnListener(self.openBtn_, nil, function()
		self:OnClickLockBtn()
	end)

	self.descTextList = {}

	table.insert(self.descTextList, SpringFestivalZumaTalentDescItem.New(self.describeGo_))

	for iter_2_0 = 1, 4 do
		table.insert(self.descTextList, SpringFestivalZumaTalentDescItem.New(self[string.format("enhance%sGo_", iter_2_0)]))
	end
end

function SpringFestivalZumaTalentInfoView:OnClickLockBtn()
	if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_3_11_ZUMA) then
		ShowTips("TIME_OVER")

		return
	end

	local var_5_0 = ActivityZumaTalentCfg[self.useTalentID]

	if not ActivityZumaTalentCfg[self.useTalentID] then
		return
	end

	if var_5_0.need > ZumaData:GetZumaCoin() then
		ShowTips("ACTIVITY_ZUMA_TALENT_COST")

		return
	end

	ZumaAction.OpenZumaTalent(self.useTalentID)
end

function SpringFestivalZumaTalentInfoView:CheckIsShow()
	return self.isShow
end

function SpringFestivalZumaTalentInfoView:Show(arg_7_1)
	self.isShow = arg_7_1

	SetActive(self.gameObject_, arg_7_1)
end

function SpringFestivalZumaTalentInfoView:RefreshTalentInfoUI(arg_8_1, arg_8_2)
	self:Show(true)

	local var_8_0 = ActivityZumaTalentCfg[arg_8_1]

	self.costValueText_.text = ZumaData:GetZumaCoin() < ActivityZumaTalentCfg[arg_8_1].need and string.format("<color=#FF000B>%s</color>", var_8_0.need) or var_8_0.need
	self.useTalentID = arg_8_1

	if arg_8_1 == ZumaConst.ZUMA_FINALLY_ID then
		self.conditionText_.text = GetTips("ACTIVITY_SPRING_FESTIVAL_ZUMA_NEED_TO_UNLOCK_OTHER_TALENT")
	else
		local var_8_1 = ""
		local var_8_3 = 0

		for iter_8_0, iter_8_1 in pairs(var_8_0.pre_id_list) do
			if iter_8_1 ~= 0 then
				var_8_1 = var_8_3 == 0 and string.format("%s%s", var_8_1, ActivityZumaTalentCfg[iter_8_1].name) or string.format("%s,%s", var_8_1, ActivityZumaTalentCfg[iter_8_1].name)
				var_8_3 = var_8_3 + 1
			end
		end

		self.conditionText_.text = string.format(GetTips("ACTIVITY_ZUMA_TALENT_UNLOCK_CONDITION"), var_8_1)
	end

	if ZumaData:GetZumaTalentIsOpen(arg_8_1) then
		self.lockController:SetSelectedState("isUse")
	elseif ZumaData:GetZumaTalentIsCanOpen(arg_8_1) then
		self.lockController:SetSelectedState("canOpen")
	else
		self.lockController:SetSelectedState("lock")
	end

	local var_8_5 = arg_8_1

	if #var_8_0.pre_id_list == 1 and var_8_0.pre_id_list[1] ~= 0 then
		var_8_5 = var_8_0.pre_id_list[1]
	end

	self.nameText_.text = ActivityZumaTalentCfg[var_8_5].name

	for iter_8_2, iter_8_3 in pairs(self.descTextList) do
		iter_8_3:Show(false)
	end

	for iter_8_4, iter_8_5 in pairs((ZumaData:GetSkillGroupList(arg_8_1))) do
		if self.descTextList[iter_8_4 + ((var_8_5 ~= arg_8_1 or nil) and 1)] and (ZumaData:GetZumaTalentIsOpen(iter_8_5) or iter_8_5 == arg_8_1) then
			self.descTextList[iter_8_4 + ((var_8_5 ~= arg_8_1 or nil) and 1)]:Show(true)
			self.descTextList[iter_8_4 + ((var_8_5 ~= arg_8_1 or nil) and 1)]:RefreshUI(iter_8_5)
		end
	end
end

function SpringFestivalZumaTalentInfoView:Dispose()
	for iter_9_0, iter_9_1 in pairs(self.descTextList) do
		if iter_9_1 then
			iter_9_1:Dispose()

			iter_9_1 = nil
		end
	end

	SpringFestivalZumaTalentInfoView.super.Dispose(self)
end

return SpringFestivalZumaTalentInfoView
