local V210MusicMainItem = class("V210MusicMainItem", ReduxView)

function V210MusicMainItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function V210MusicMainItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function V210MusicMainItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.gradeController_ = ControllerUtil.GetController(self.transform_, "grade")
	self.difficultController_ = ControllerUtil.GetController(self.transform_, "difficult")
	self.linkTagController_ = self.controller_:GetController("linkTag")
	self.selectDifficult = 0
	self.isFistSetData = true
end

function V210MusicMainItem:AddUIListener()
	self:AddBtnListener(self.m_easyBtn, nil, function()
		self:SelectDiffectType(0)
	end)
	self:AddBtnListener(self.m_difficult, nil, function()
		if self:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Challenge) == false then
			self:EnterHardest()
		end

		self:SelectDiffectType(1)
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		self:EnterHardest()
		self:SelectDiffectType(2)
	end)
	self:AddBtnListener(self.hardestBtn_, nil, function()
		return
	end)
end

function V210MusicMainItem:SelectDiffectType(arg_9_1)
	if self.surpriseHard then
		local var_9_0 = self:GetHardestIndex()

		self.selectDifficult = var_9_0

		MusicData:SetDifficultIndex(self.music_id, var_9_0)
	else
		if not arg_9_1 then
			arg_9_1 = self:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Challenge) and MusicConst.MusicDiffcult.Challenge or MusicConst.MusicDiffcult.Hard
			arg_9_1 = arg_9_1 - 1
		end

		self.selectDifficult = arg_9_1

		MusicData:SetDifficultIndex(self.music_id, arg_9_1)
	end

	self:RefreshUI()
end

function V210MusicMainItem:GetHardestIndex()
	return (self:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Challenge) or nil) and 3
end

function V210MusicMainItem:EnterHardest()
	if self.surpriseId == 0 then
		return
	end

	if Time.realtimeSinceStartup - 5 > self.surpriseTime then
		self.surpriseTime = Time.realtimeSinceStartup
		self.surpriseCount = 1
	else
		self.surpriseCount = self.surpriseCount + 1

		if self.surpriseCount >= 5 and (self.surpriseHard or true) then
			self.surpriseHard = true
		end
	end
end

function V210MusicMainItem:CheckHaveDiffcultType(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[self.music_id]) do
		if arg_12_1 == ActivityMusicCfg[iter_12_1].difficult then
			return true
		end
	end

	return false
end

function V210MusicMainItem:SetBtnShowState()
	SetActive(self.m_easyBtn.gameObject, self:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Normal))
	SetActive(self.m_difficult.gameObject, self:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Hard))
	SetActive(self.challengeBtn_.gameObject, self:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Challenge))
end

function V210MusicMainItem:SetData(arg_14_1, arg_14_2, arg_14_3)
	self.index = arg_14_1
	self.music_id = arg_14_2
	self.isLookBack = arg_14_3

	self:SetBtnShowState()

	self.surpriseTime = 0
	self.surpriseCount = 0
	self.surpriseId = 0

	for iter_14_0, iter_14_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[self.music_id]) do
		if MusicConst.MusicDiffcult.Hardest == ActivityMusicCfg[iter_14_1].difficult then
			self.surpriseId = iter_14_1

			break
		end
	end

	self.surpriseHard = false
	self.selectDifficult = MusicData:GetDifficultyIndex(self.music_id)

	if self.selectDifficult == self:GetHardestIndex() and self.isFistSetData then
		self.isFistSetData = false
	else
		self.selectDifficult = self:CheckHaveDiffcultType(MusicConst.MusicDiffcult.Challenge) and math.min(self.selectDifficult, 2) or math.min(self.selectDifficult, 1)

		MusicData:SetDifficultIndex(self.music_id, self.selectDifficult)
	end

	self:RefreshUI()
end

function V210MusicMainItem:UpdateDifficultController()
	if self.surpriseHard or self.selectDifficult == self:GetHardestIndex() then
		self.difficultController_:SetSelectedIndex(3)
	else
		self.difficultController_:SetSelectedIndex(self.selectDifficult)
	end
end

function V210MusicMainItem:RefreshUI()
	self.selectDifficult = MusicData:GetDifficultyIndex(self.music_id)

	self:UpdateDifficultController()
	self.linkTagController_:SetSelectedIndex(ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].tagType)

	self.m_title.text = GetI18NText(ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].name)
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music_icon/" .. ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].icon)
	self.m_bgIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Music/Music1_icon/" .. ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].icon)
	self.m_author.text = GetI18NText(ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].creator_name)

	self:RefreshActivity()
	self:RefrenTime()
end

function V210MusicMainItem:RefreshActivity()
	local var_17_0 = ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]]
	local var_17_1 = ActivityData:GetActivityData(self.music_id)

	if var_17_1 and var_17_1:IsActivitying() or self.isLookBack then
		local var_17_2 = MusicData:GetScore(self.music_id, var_17_0.difficult)

		if MusicConst.MusicFinishState.Unfinished == MusicData:GetIsComplete(self.music_id, var_17_0.difficult) then
			self.stateController_:SetSelectedIndex(1)
			self.gradeController_:SetSelectedIndex(6)
		else
			self.stateController_:SetSelectedIndex(0)

			self.m_scoreLab.text = var_17_2
			self.m_accuracyLab.text = string.format("%.2f%%", (self:KeepDecimalPlace(var_17_2 / var_17_0.total_score * 100, 2)))

			for iter_17_0, iter_17_1 in ipairs(GameSetting.attach_music_grade.value) do
				if iter_17_1 <= var_17_2 / var_17_0.total_score * 100 then
					self.gradeController_:SetSelectedIndex(iter_17_0 - 1)

					break
				end
			end
		end
	end
end

function V210MusicMainItem:KeepDecimalPlace(arg_18_1, arg_18_2)
	return math.floor(arg_18_1 * 10^arg_18_2) / 10^arg_18_2
end

function V210MusicMainItem:RegistCallBack(arg_19_1)
	self.callback_ = arg_19_1
end

function V210MusicMainItem:RefrenTime()
	local var_20_1 = ActivityData:GetActivityData(self.music_id)

	if self.isLookBack then
		self:RefreshActivity()

		return
	end

	if var_20_1 then
		if not var_20_1:IsActivitying() then
			self.m_lockLab.text = var_20_1 and manager.time:GetServerTime() <= var_20_1.startTime + 1 and string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_20_1.startTime)) or GetTips("TIME_OVER")

			self.stateController_:SetSelectedIndex(2)
			self.gradeController_:SetSelectedIndex(6)
		elseif self.stateController_:GetSelectedState() == "2" then
			self:RefreshActivity()
		end
	else
		self.m_lockLab.text = GetTips("TIME_OVER")

		self.stateController_:SetSelectedIndex(2)
	end
end

function V210MusicMainItem:UpdateScale(arg_21_1)
	local var_21_0 = 1 - math.abs(arg_21_1:InverseTransformPoint((self.transform_:TransformPoint(Vector3(0, 0, 0)))).x + self.transform_.rect.width / 2) / 8000

	self.m_content.localScale = Vector2.New(var_21_0, var_21_0)
end

function V210MusicMainItem:Dispose()
	V210MusicMainItem.super.Dispose(self)
end

function V210MusicMainItem:MoveAniEffect(arg_23_1)
	local var_23_0 = math.abs(arg_23_1 - self.index)

	if var_23_0 < 0.1 then
		var_23_0 = 0
	end

	self.m_content.localScale = Vector3.Lerp(Vector3.one, Vector3.one * 0.8, var_23_0)
	self.alphaCanvasgroup_.alpha = Mathf.Lerp(1, 0.8, var_23_0)
	self.alphaCanvasgroup_.blocksRaycasts = var_23_0 < 0.2
end

return V210MusicMainItem
