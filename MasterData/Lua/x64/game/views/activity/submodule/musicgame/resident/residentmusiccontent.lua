local ResidentMusicContent = class("ResidentMusicContent", ReduxView)

function ResidentMusicContent:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ResidentMusicContent:Init()
	self:InitUI()
	self:AddUIListener()
end

function ResidentMusicContent:InitUI()
	self:BindCfgUI()
	self.trackDropdown_.options:Clear()

	self.gradeController_ = ControllerUtil.GetController(self.transform_, "grade")
	self.linkTagController_ = self.controller_:GetController("linkTag")
	self.intonationController_ = self.controller_:GetController("intonation")
	self.difficultController_ = self.controller_:GetController("difficult")
	self.stateController_ = self.controller_:GetController("state")
	self.evaluateController_ = self.controller_:GetController("evaluate")
	self.trackStateController_ = self.hardestController_:GetController("trackState")
	self.selectDifficult = 0
	self.difficultBtnShowStateControllerList = {}

	local var_3_0 = {
		MusicConst.MusicDiffcult.Normal,
		MusicConst.MusicDiffcult.Hard,
		MusicConst.MusicDiffcult.Challenge,
		MusicConst.MusicDiffcult.Hardest
	}

	for iter_3_0 = 1, self.btnTabTrs_.childCount do
		self.difficultBtnShowStateControllerList[var_3_0[iter_3_0]] = self.btnTabTrs_:GetChild(iter_3_0 - 1):GetComponent("ControllerExCollection"):GetController("state")
	end
end

function ResidentMusicContent:GetHardestTackDataList()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[self.music_id]) do
		if ActivityMusicCfg[iter_4_1].difficult == MusicConst.MusicDiffcult.Hardest then
			table.insert(var_4_0, ActivityMusicCfg[iter_4_1])
		end
	end

	return var_4_0
end

function ResidentMusicContent:UpdateDropDownUIContent()
	self.dropDownText_ = {}
	self.dropDownTrack = {}

	self.trackDropdown_.options:Clear()

	for iter_5_0, iter_5_1 in pairs((self:GetHardestTackDataList())) do
		local var_5_0 = string.format(GetTips("ACTIVITY_MUSIC_SETTING_KEY"), iter_5_1.track)

		self.trackDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_5_0))

		self.dropDownText_[#self.dropDownText_ + 1] = var_5_0
		self.dropDownTrack[#self.dropDownTrack + 1] = iter_5_1.track
	end

	self:RefreshDropDownOptions()

	self.trackDropdown_.value = MusicData:GetTrackCount(self.music_id) - 4
end

function ResidentMusicContent:RefreshDropDownOptions()
	if self.dropDownText_ then
		for iter_6_0 = 1, self.trackDropdown_.options.Count do
			self.trackDropdown_.options[iter_6_0 - 1].text = iter_6_0 - 1 == self.trackDropdown_.value and string.format("<color=#FFFFFF>%s</color>", self.dropDownText_[iter_6_0]) or string.format("<color=#000000>%s</color>", self.dropDownText_[iter_6_0])
		end
	end

	self.trackDropdown_.captionText.text = self.dropDownText_[self.trackDropdown_.value + 1]
end

function ResidentMusicContent:AddUIListener()
	self:AddBtnListener(self.m_easyBtn, nil, function()
		self:SetDifficulty(MusicConst.MusicDiffcult.Normal)
	end)
	self:AddBtnListener(self.m_difficult, nil, function()
		self:SetDifficulty(MusicConst.MusicDiffcult.Hard)
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		self:SetDifficulty(MusicConst.MusicDiffcult.Challenge)
	end)
	self:AddBtnListener(self.hardestBtn_, nil, function()
		self:SetDifficulty(MusicConst.MusicDiffcult.Hardest)
	end)
	self:AddToggleListener(self.trackDropdown_, function(arg_12_0)
		self:RefreshDropDownOptions()

		if self.isInitDrop then
			return
		end

		self:SetDifficulty(MusicConst.MusicDiffcult.Hardest, self:GetTrackByDropValue(arg_12_0))
		MusicData:SetTrackCount(self.music_id, self:GetTrackByDropValue(arg_12_0))
	end)
	self:AddBtnListener(self.trackDownBtn_, nil, function()
		self:SetDifficulty(MusicConst.MusicDiffcult.Hardest, self:GetTrackByDropValue(self.trackDropdown_.value))

		if #self:GetHardestTackDataList() <= 1 then
			return
		end

		self.trackDropdown_:Show()
	end)
end

function ResidentMusicContent:GetTrackByDropValue(arg_14_1)
	return self.dropDownTrack[arg_14_1 + 1] or 4
end

function ResidentMusicContent:SetDifficulty(arg_15_1, arg_15_2)
	local var_15_0 = arg_15_2 or -1
	local var_15_1 = -1

	for iter_15_0, iter_15_1 in pairs(ActivityMusicCfg.get_id_list_by_activity_id[self.music_id]) do
		if ActivityMusicCfg[iter_15_1].difficult == arg_15_1 then
			if var_15_0 > 0 then
				if var_15_0 == ActivityMusicCfg[iter_15_1].track then
					var_15_1 = iter_15_0

					break
				end
			else
				var_15_1 = iter_15_0

				break
			end
		end
	end

	if self.difficultIndex == var_15_1 then
		return
	end

	if var_15_1 < 0 then
		return
	end

	MusicData:SetDifficultIndex(self.music_id, var_15_1)
	self:RefreshUI()
end

function ResidentMusicContent:GetMusicID()
	return self.music_id
end

function ResidentMusicContent:SetData(arg_17_1)
	self.music_id = arg_17_1

	self.trackDropdown_:Hide()

	self.isInitDrop = true

	self:UpdateDropDownUIContent()

	self.isInitDrop = false

	self:RefreshUI()
end

function ResidentMusicContent:GetMusicCfg()
	return ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.difficultIndex] or ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][1]]
end

function ResidentMusicContent:UpdateDifficultyBtnShowState()
	local var_19_0 = {}
	local var_19_1 = 0

	for iter_19_0, iter_19_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[self.music_id]) do
		var_19_0[ActivityMusicCfg[iter_19_1].difficult] = true

		if ActivityMusicCfg[iter_19_1].difficult == MusicConst.MusicDiffcult.Hardest then
			var_19_1 = var_19_1 + 1
		end
	end

	for iter_19_2, iter_19_3 in pairs(self.difficultBtnShowStateControllerList) do
		if var_19_0[iter_19_2] then
			iter_19_3:SetSelectedState("normal")
		else
			iter_19_3:SetSelectedState("hide")
		end
	end

	if var_19_1 > 1 then
		self.trackStateController_:SetSelectedState("normal")
	else
		self.trackStateController_:SetSelectedState("onlyOne")
	end
end

function ResidentMusicContent:RefreshUI()
	self:UpdateDifficultyBtnShowState()

	self.difficultIndex = MusicData:GetDifficultyIndex(self.music_id)
	self.selectDifficult = self:GetMusicCfg().difficult

	self:UpdateMusicInfo()
	self:UpdateDifficulty()
	self:UpdateGradeInfo()
end

function ResidentMusicContent:CheckHaveDiffcultType(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[self.music_id]) do
		if arg_21_1 == ActivityMusicCfg[iter_21_1].difficult then
			return true
		end
	end

	return false
end

function ResidentMusicContent:UpdateDifficulty()
	if self.selectDifficult == MusicConst.MusicDiffcult.Normal then
		self.difficultController_:SetSelectedState("normal")
	elseif self.selectDifficult == MusicConst.MusicDiffcult.Hard then
		self.difficultController_:SetSelectedState("hard")
	elseif self.selectDifficult == MusicConst.MusicDiffcult.Challenge then
		self.difficultController_:SetSelectedState("challenge")
	elseif self.selectDifficult == MusicConst.MusicDiffcult.Hardest then
		self.difficultController_:SetSelectedState("hardest")
	end
end

function ResidentMusicContent:UpdateMusicInfo()
	local var_23_0 = self:GetMusicCfg()

	self.m_author.text = GetI18NText(var_23_0.creator_name)
	self.m_title.text = GetI18NText(var_23_0.name)
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music_icon/" .. var_23_0.icon)
	self.m_bgIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music1_icon/" .. var_23_0.icon)

	local var_23_1 = MusicData:GetTagImagePath(var_23_0.id)

	if var_23_1 then
		self.linkTagController_:SetSelectedState("show")

		self.linkImage_.sprite = getSpriteWithoutAtlas(var_23_1)
	else
		self.linkTagController_:SetSelectedState("hide")
	end
end

function ResidentMusicContent:UpdateGradeInfo()
	local var_24_0 = MusicData:GetScore(self:GetMusicCfg().id)
	local var_24_1 = MusicData:GetIsComplete(self:GetMusicCfg().id)

	if MusicConst.MusicFinishState.Unfinished == var_24_1 then
		self.stateController_:SetSelectedState("unfinish")
		self.gradeController_:SetSelectedIndex(6)
	else
		self.stateController_:SetSelectedState("normal")

		self.m_scoreLab.text = var_24_0
		self.m_accuracyLab.text = string.format("%.2f%%", (self:KeepDecimalPlace(var_24_0 / self:GetMusicCfg().total_score * 100, 2)))

		for iter_24_0, iter_24_1 in ipairs(GameSetting.attach_music_grade.value) do
			if iter_24_1 <= var_24_0 / self:GetMusicCfg().total_score * 100 then
				self.gradeController_:SetSelectedIndex(iter_24_0 - 1)

				break
			end
		end
	end

	if var_24_1 == MusicConst.MusicFinishState.Perfect then
		self.evaluateController_:SetSelectedIndex(2)
	elseif var_24_1 == MusicConst.MusicFinishState.NoMistake then
		self.evaluateController_:SetSelectedIndex(1)
	else
		self.evaluateController_:SetSelectedIndex(0)
	end
end

function ResidentMusicContent:KeepDecimalPlace(arg_25_1, arg_25_2)
	return math.floor(arg_25_1 * 10^arg_25_2) / 10^arg_25_2
end

function ResidentMusicContent:Dispose()
	ResidentMusicContent.super.Dispose(self)
end

return ResidentMusicContent
