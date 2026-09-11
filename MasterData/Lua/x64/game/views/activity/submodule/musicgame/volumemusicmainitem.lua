local VolumeMusicMainItem = class("VolumeMusicMainItem", ReduxView)

function VolumeMusicMainItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function VolumeMusicMainItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function VolumeMusicMainItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.gradeController_ = ControllerUtil.GetController(self.transform_, "grade")
	self.difficultController_ = ControllerUtil.GetController(self.transform_, "difficult")
	self.selectDifficult = 0
end

function VolumeMusicMainItem:AddUIListener()
	self:AddBtnListener(self.m_easyBtn, nil, function()
		self.selectDifficult = 0

		self.difficultController_:SetSelectedIndex(self.selectDifficult)
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
					MusicAction.Play(self.surpriseId)
				end
			end
		end

		self.selectDifficult = 1

		self.difficultController_:SetSelectedIndex(self.selectDifficult)
		MusicData:SetDifficultIndex(self.music_id, self.selectDifficult)
		self:RefreshUI()
	end)
end

function VolumeMusicMainItem:SetData(arg_7_1)
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

	self:RefreshUI()
end

function VolumeMusicMainItem:RefreshUI()
	self.selectDifficult = MusicData:GetDifficultyIndex(self.music_id)

	self.difficultController_:SetSelectedIndex(self.selectDifficult)
	self:RefrenTime()

	self.m_title.text = GetI18NText(ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].name)
	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VolumeIIIDownUI/" .. ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].icon)
end

function VolumeMusicMainItem:RegistCallBack(arg_9_1)
	self.callback_ = arg_9_1
end

function VolumeMusicMainItem:RefrenTime()
	local var_10_0 = ActivityData:GetActivityData(self.music_id)

	if var_10_0 then
		if var_10_0:IsActivitying() then
			local var_10_1 = MusicData:GetScore(self.music_id, self.selectDifficult + 1)

			if var_10_1 == 0 then
				self.stateController_:SetSelectedIndex(1)
				self.gradeController_:SetSelectedIndex(5)
			else
				self.stateController_:SetSelectedIndex(0)

				self.m_scoreLab.text = var_10_1
				self.m_accuracyLab.text = string.format("%.2f%%", var_10_1 / ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].total_score * 100)

				for iter_10_0, iter_10_1 in ipairs(GameSetting.attach_music_grade.value) do
					if iter_10_1 <= var_10_1 / ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[self.music_id][self.selectDifficult + 1]].total_score * 100 then
						self.gradeController_:SetSelectedIndex(iter_10_0 - 1)

						break
					end
				end
			end
		else
			self.m_lockLab.text = var_10_0 and manager.time:GetServerTime() < var_10_0.startTime and string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_10_0.startTime)) or GetTips("TIME_OVER")

			self.stateController_:SetSelectedIndex(2)
			self.gradeController_:SetSelectedIndex(5)
		end
	else
		self.m_lockLab.text = GetTips("TIME_OVER")

		self.stateController_:SetSelectedIndex(2)
	end
end

function VolumeMusicMainItem:UpdateScale(arg_11_1)
	local var_11_0 = 1 - math.abs(arg_11_1:InverseTransformPoint((self.transform_:TransformPoint(Vector3(0, 0, 0)))).x + self.transform_.rect.width / 2) / 8000

	self.m_content.localScale = Vector2.New(var_11_0, var_11_0)
end

function VolumeMusicMainItem:Dispose()
	VolumeMusicMainItem.super.Dispose(self)
end

return VolumeMusicMainItem
