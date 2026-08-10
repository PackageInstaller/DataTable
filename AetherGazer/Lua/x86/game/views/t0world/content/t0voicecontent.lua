local var_0_0 = class("T0VoiceContent", BaseView)

var_0_0.showMultiple = false

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.subtitleList = {}
	arg_1_0.queue = {}
end

function var_0_0.OnShowTipsKey(arg_2_0, arg_2_1)
	arg_2_0:PushSubtitle(T0ShowTipsSubtitleData.New(arg_2_1))
end

function var_0_0.OnStartTalk(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = Time.time + arg_3_4 / 1000
	local var_3_1 = var_3_0 + arg_3_3 / 1000 - arg_3_4 / 1000
	local var_3_2 = T0SubtitleData.New(arg_3_1, arg_3_2, var_3_0, var_3_1, arg_3_5)

	arg_3_0:PushSubtitle(var_3_2)
end

function var_0_0.PushSubtitle(arg_4_0, arg_4_1)
	table.insert(arg_4_0.queue, arg_4_1)
end

function var_0_0.Update(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.queue) do
		if iter_5_1:IsWaiting() then
			table.insert(var_5_0, iter_5_1)
		else
			table.insert(arg_5_0.subtitleList, iter_5_1)
		end
	end

	arg_5_0.queue = var_5_0
end

function var_0_0.UpdateSubtitle(arg_6_0, arg_6_1, arg_6_2)
	if not var_0_0.showMultiple then
		arg_6_0.subtitleList = {
			arg_6_0.subtitleList[#arg_6_0.subtitleList]
		}
	end

	local var_6_0 = #arg_6_0.subtitleList

	if var_6_0 == 0 then
		arg_6_0:Hide()
	else
		local var_6_1 = true
		local var_6_2
		local var_6_3

		if var_6_0 == 1 then
			var_6_2 = arg_6_0.subtitleList[1]:GetKey()
			var_6_3 = arg_6_0.subtitleList[1]:GetContent()

			if var_6_3 ~= nil and arg_6_0.subtitleList[1]:IsShow() then
				var_6_1 = false
			end
		else
			local var_6_4 = 0
			local var_6_5 = {}
			local var_6_6 = {}

			for iter_6_0, iter_6_1 in ipairs(arg_6_0.subtitleList) do
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
				if var_6_4 == 1 then
					var_6_2 = arg_6_0.subtitleList[1]:GetKey()
				elseif var_6_4 == 2 then
					var_6_2 = GetTips("T0_WORLD_PEOPLE_NAME")
				else
					var_6_2 = GetTips("T0_WORLD_PEOPLE_NAME")
				end

				var_6_3 = table.concat(var_6_5, "\n")
			end
		end

		if var_6_1 then
			for iter_6_2, iter_6_3 in ipairs(arg_6_0.subtitleList) do
				iter_6_3:OnEndDisplay()
			end

			arg_6_0.subtitleList = {}

			arg_6_0:Hide()
		else
			if not isNil(arg_6_0.talkerName_) then
				arg_6_0.talkerName_.text = var_6_2
			end

			arg_6_0.talkLabel_.text = var_6_3

			arg_6_0:Show()
		end
	end
end

function var_0_0.Show(arg_7_0)
	if not arg_7_0.voiceContentGo_.activeSelf then
		SetActive(arg_7_0.voiceContentGo_, true)

		if arg_7_0.voiceAni_ then
			arg_7_0.voiceAni_:Update(0)
		end
	end
end

function var_0_0.Hide(arg_8_0)
	if arg_8_0.voiceContentGo_.activeSelf then
		SetActive(arg_8_0.voiceContentGo_, false)
	end
end

function var_0_0.CompelHide(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.subtitleList) do
		iter_9_1:OnDispose()
	end

	arg_9_0.subtitleList = {}

	for iter_9_2, iter_9_3 in ipairs(arg_9_0.queue) do
		iter_9_3:OnDispose()
	end

	arg_9_0.queue = {}

	if arg_9_0.voiceContentGo_.activeSelf then
		SetActive(arg_9_0.voiceContentGo_, false)
	end
end

function var_0_0.StopScheduleUpdate(arg_10_0)
	if arg_10_0.updateScheduler then
		arg_10_0.updateScheduler:Stop()

		arg_10_0.updateScheduler = nil
	end
end

function var_0_0.StartScheduleUpdate(arg_11_0)
	local var_11_0
	local var_11_1 = Time.time
	local var_11_2 = FrameTimer.New(function()
		local var_12_0 = Time.time
		local var_12_1 = var_12_0 - var_11_1

		arg_11_0:Update(var_12_1, var_12_0)
		arg_11_0:UpdateSubtitle(var_12_1, var_12_0)

		var_11_1 = var_12_0
	end, 0.1, -1)

	var_11_2:Start()

	arg_11_0.updateScheduler = var_11_2
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0:StartScheduleUpdate()
	arg_13_0:UpdateSubtitle(0, Time.time)
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:StopScheduleUpdate()
end

function var_0_0.Dispose(arg_15_0)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
