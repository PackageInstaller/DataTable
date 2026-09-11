local EnternalMusicMainItem = class("EnternalMusicMainItem", ReduxView)

function EnternalMusicMainItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function EnternalMusicMainItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function EnternalMusicMainItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.gradeController_ = ControllerUtil.GetController(self.transform_, "grade")
	self.difficultController_ = ControllerUtil.GetController(self.transform_, "difficult")
	self.selectDifficult = 0
end

function EnternalMusicMainItem:AddUIListener()
	self:AddBtnListener(self.m_easyBtn, nil, function()
		self.selectDifficult = 0

		MusicData:SetDifficultIndex(self.music_id, self.selectDifficult)
		self:RefreshUI()
	end)
	self:AddBtnListener(self.m_difficult, nil, function()
		if self.surpriseId ~= 0 then
			if Time.realtimeSinceStartup - 5 > self.surpriseTime then
				self.surpriseTime = Time.realtimeSinceStartup
				self.surpriseCount = 1
			else
				self.surpriseCount = self.surpriseCount + 1

				if self.surpriseCount >= 5 then
					if not self.surpriseHard then
						self.m_hardAnim:Play("ex_difficult", 0, 0)
					end

					self.surpriseHard = true
				end
			end
		end

		if self.surpriseHard then
			self.selectDifficult = 2

			MusicData:SetDifficultIndex(self.music_id, 2)
		else
			self.selectDifficult = 1

			MusicData:SetDifficultIndex(self.music_id, 1)
		end

		self:RefreshUI()
	end)
end

function EnternalMusicMainItem:SetData(arg_7_1)
	self.music_id = arg_7_1
	self.surpriseTime = 0
	self.surpriseCount = 0
	self.surpriseId = 0

	for iter_7_0, iter_7_1 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[self.music_id]) do
		if ActivityMusicCfg[iter_7_1].difficult > 2 then
			self.surpriseId = iter_7_1

			break
		end
	end

	self.surpriseHard = false
	self.selectDifficult = MusicData:GetDifficultyIndex(self.music_id)
	self.selectDifficult = math.min(self.selectDifficult, 1)

	MusicData:SetDifficultIndex(self.music_id, self.selectDifficult)
	self:RefreshUI()
end

function EnternalMusicMainItem:RefreshUI()
	self.selectDifficult = MusicData:GetDifficultyIndex(self.music_id)

	self.difficultController_:SetSelectedIndex(math.min(self.selectDifficult, 1))

	self.m_hardLab.text = self.surpriseHard and GetTips("ACTIVITY_MUSIC_LEVEL_3") or GetTips("ACTIVITY_MUSIC_LEVEL_2")

	local var_8_0 = ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]]

	self.m_title.text = GetI18NText(ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].name)
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng1stUI/" .. var_8_0.icon)

	self:RefreshActivity()
	self:RefrenTime()
end

function EnternalMusicMainItem:RefreshActivity()
	local var_9_0 = ActivityData:GetActivityData(self.music_id)

	if var_9_0 and var_9_0:IsActivitying() then
		local var_9_1 = MusicData:GetScore(self.music_id, self.selectDifficult + 1)

		if var_9_1 == 0 then
			self.stateController_:SetSelectedIndex(1)
			self.gradeController_:SetSelectedIndex(6)
		else
			self.stateController_:SetSelectedIndex(0)

			self.m_scoreLab.text = var_9_1
			self.m_accuracyLab.text = string.format("%.2f%%", (self:KeepDecimalPlace(var_9_1 / ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].total_score * 100, 2)))

			for iter_9_0, iter_9_1 in ipairs(GameSetting.attach_music_grade.value) do
				if iter_9_1 <= var_9_1 / ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].total_score * 100 then
					self.gradeController_:SetSelectedIndex(iter_9_0 - 1)

					break
				end
			end
		end
	end
end

function EnternalMusicMainItem:KeepDecimalPlace(arg_10_1, arg_10_2)
	return math.floor(arg_10_1 * 10^arg_10_2) / 10^arg_10_2
end

function EnternalMusicMainItem:RegistCallBack(arg_11_1)
	self.callback_ = arg_11_1
end

function EnternalMusicMainItem:RefrenTime()
	local var_12_1 = ActivityData:GetActivityData(self.music_id)

	if var_12_1 then
		if not var_12_1:IsActivitying() then
			self.m_lockLab.text = var_12_1 and manager.time:GetServerTime() <= var_12_1.startTime + 1 and string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_12_1.startTime)) or GetTips("TIME_OVER")

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

function EnternalMusicMainItem:UpdateScale(arg_13_1)
	local var_13_0 = 1 - math.abs(arg_13_1:InverseTransformPoint((self.transform_:TransformPoint(Vector3(0, 0, 0)))).x + self.transform_.rect.width / 2) / 8000

	self.m_content.localScale = Vector2.New(var_13_0, var_13_0)
end

function EnternalMusicMainItem:Dispose()
	EnternalMusicMainItem.super.Dispose(self)
end

return EnternalMusicMainItem
