local ChallengeRogueTeamEventItem = class("ChallengeRogueTeamEventItem", ReduxView)

function ChallengeRogueTeamEventItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.richText_ = self.descText_.transform:GetComponent("RichText")

	self:AddListeners()

	self.stateControllerEx_ = self.controllerEx_:GetController("status")
	self.showIconControllerEx_ = self.controllerEx_:GetController("showIcon")
end

function ChallengeRogueTeamEventItem:Dispose()
	self.richText_:RemoveAllListeners()

	self.richText_ = nil

	ChallengeRogueTeamEventItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamEventItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.lock_ then
			return
		end

		ChallengeRogueTeamData:UISetEventIDAnimator(ChallengeRogueTeamData:EventGetCurrentID(), self.optionData_.id)
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_EVENT_OPTION_SELECT, self.optionData_)
	end)
end

function ChallengeRogueTeamEventItem:SetData(arg_5_1)
	self.optionData_ = arg_5_1

	local var_5_0 = RogueTeamEventOptionCfg[arg_5_1.id]

	self.titleText_.text = RogueTeamEventOptionCfg[arg_5_1.id].title

	self:RefreshText()

	self.lock_ = arg_5_1.isLock

	if self.lock_ and var_5_0.hide_flag ~= 0 then
		self:Show(false)
	else
		self:RefreshState()
		self:Show(true)
	end

	if var_5_0.option_icon ~= "" then
		self.showIconControllerEx_:SetSelectedState("true")

		self.icon_.sprite = getSprite("Atlas/Activity_RoulikeAtlas", var_5_0.option_icon)
	else
		self.showIconControllerEx_:SetSelectedState("false")
	end
end

function ChallengeRogueTeamEventItem:RefreshState(arg_6_1)
	if self.lock_ then
		self.stateControllerEx_:SetSelectedState("lock")

		self.descText_.text = RogueTeamEventOptionCfg[self.optionData_.id].lock_desc
	elseif arg_6_1 == self.optionData_.id then
		self.stateControllerEx_:SetSelectedState("select")
		self:RefreshText(true)
	else
		self.stateControllerEx_:SetSelectedState("normal")
		self:RefreshText(false)
	end
end

function ChallengeRogueTeamEventItem:RefreshText(arg_7_1)
	local var_7_0 = string.format("#%s", ColorToHex(self.descText_.color))

	if not self.optionData_.isLock then
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in ipairs(self.optionData_.itemList) do
			table.insert(var_7_1, GetI18NText(ChallengeRogueTeamTools.TextFormat(iter_7_1.id, iter_7_1.rare, var_7_0)))
		end

		local var_7_2 = 0

		for iter_7_2 in string.gmatch(RogueTeamEventOptionCfg[self.optionData_.id].desc, "%%s") do
			var_7_2 = var_7_2 + 1
		end

		for iter_7_3 = #var_7_1, var_7_2 do
			table.insert(var_7_1, "")
		end

		self.descText_.text = ChallengeRogueTeamTools.EventOptionReplaceText(string.format(GetI18NText(RogueTeamEventOptionCfg[self.optionData_.id].desc), unpack(var_7_1)), RogueTeamEventOptionCfg[self.optionData_.id].attribute_id_list)
	else
		self.descText_.text = RogueTeamEventOptionCfg[self.optionData_.id].lock_desc
	end
end

function ChallengeRogueTeamEventItem:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

return ChallengeRogueTeamEventItem
