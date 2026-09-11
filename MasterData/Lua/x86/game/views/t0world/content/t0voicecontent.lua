local T0VoiceContent = class("T0VoiceContent", BaseView)

T0VoiceContent.showMultiple = false

function T0VoiceContent:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.subtitleList = {}
	self.queue = {}
end

function T0VoiceContent:OnShowTipsKey(arg_2_1)
	self:PushSubtitle(T0ShowTipsSubtitleData.New(arg_2_1))
end

function T0VoiceContent:OnStartTalk(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self:PushSubtitle((T0SubtitleData.New(arg_3_1, arg_3_2, Time.time + arg_3_4 / 1000, Time.time + arg_3_4 / 1000 + arg_3_3 / 1000 - arg_3_4 / 1000, arg_3_5)))
end

function T0VoiceContent:PushSubtitle(arg_4_1)
	table.insert(self.queue, arg_4_1)
end

function T0VoiceContent:Update(arg_5_1, arg_5_2)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(self.queue) do
		if iter_5_1:IsWaiting() then
			table.insert(var_5_0, iter_5_1)
		else
			table.insert(self.subtitleList, iter_5_1)
		end
	end

	self.queue = var_5_0
end

function T0VoiceContent:UpdateSubtitle(arg_6_1, arg_6_2)
	if not T0VoiceContent.showMultiple then
		self.subtitleList = {
			self.subtitleList[#self.subtitleList]
		}
	end

	local var_6_0 = #self.subtitleList

	if #self.subtitleList == 0 then
		self:Hide()
	else
		local var_6_1 = true
		local var_6_2
		local var_6_3

		if var_6_0 == 1 then
			var_6_2 = self.subtitleList[1]:GetKey()
			var_6_3 = self.subtitleList[1]:GetContent()

			if var_6_3 ~= nil and self.subtitleList[1]:IsShow() then
				var_6_1 = false
			end
		else
			local var_6_4 = 0
			local var_6_5 = {}
			local var_6_6 = {}

			for iter_6_0, iter_6_1 in ipairs(self.subtitleList) do
				local var_6_7 = iter_6_1:GetContent()

				if var_6_7 then
					table.insert(var_6_5, string.format("%s: %s", iter_6_1:GetKey(), var_6_7))

					if not var_6_6[iter_6_1.formID] then
						var_6_6[iter_6_1.formID] = true
						var_6_4 = var_6_4 + 1
					end

					if iter_6_1:IsShow() then
						var_6_1 = false
					end
				end
			end

			if #var_6_5 > 0 then
				var_6_2 = var_6_4 == 1 and self.subtitleList[1]:GetKey() or var_6_4 == 2 and GetTips("T0_WORLD_PEOPLE_NAME") or GetTips("T0_WORLD_PEOPLE_NAME")
				var_6_3 = table.concat(var_6_5, "\n")
			end
		end

		if var_6_1 then
			for iter_6_2, iter_6_3 in ipairs(self.subtitleList) do
				iter_6_3:OnEndDisplay()
			end

			self.subtitleList = {}

			self:Hide()
		else
			if not isNil(self.talkerName_) then
				self.talkerName_.text = var_6_2
			end

			self.talkLabel_.text = var_6_3

			self:Show()
		end
	end
end

function T0VoiceContent:Show()
	if not self.voiceContentGo_.activeSelf then
		SetActive(self.voiceContentGo_, true)

		if self.voiceAni_ then
			self.voiceAni_:Update(0)
		end
	end
end

function T0VoiceContent:Hide()
	if self.voiceContentGo_.activeSelf then
		SetActive(self.voiceContentGo_, false)
	end
end

function T0VoiceContent:CompelHide()
	for iter_9_0, iter_9_1 in ipairs(self.subtitleList) do
		iter_9_1:OnDispose()
	end

	self.subtitleList = {}

	for iter_9_2, iter_9_3 in ipairs(self.queue) do
		iter_9_3:OnDispose()
	end

	self.queue = {}

	if self.voiceContentGo_.activeSelf then
		SetActive(self.voiceContentGo_, false)
	end
end

function T0VoiceContent:StopScheduleUpdate()
	if self.updateScheduler then
		self.updateScheduler:Stop()

		self.updateScheduler = nil
	end
end

function T0VoiceContent:StartScheduleUpdate()
	local var_11_1 = Time.time

	;(nil):Start()

	self.updateScheduler = FrameTimer.New(function()
		self:Update(Time.time - var_11_1, Time.time)
		self:UpdateSubtitle(Time.time - var_11_1, Time.time)

		var_11_1 = Time.time
	end, 0.1, -1)
end

function T0VoiceContent:OnEnter()
	self:StartScheduleUpdate()
	self:UpdateSubtitle(0, Time.time)
end

function T0VoiceContent:OnExit()
	self:StopScheduleUpdate()
end

function T0VoiceContent:Dispose()
	T0VoiceContent.super.Dispose(self)
end

return T0VoiceContent
