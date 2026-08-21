local var_0_0 = class("NewWarChessLevelItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.isOpen_ = false
	arg_1_0.activityIsOpen_ = false

	arg_1_0:BindCfgUI()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "isopen")

	arg_1_0:AddListeners()
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if not arg_2_0.activityIsOpen_ then
			if manager.time:GetServerTime() < ActivityData:GetActivityData(arg_2_0.cfg_.activity).startTime then
				local var_3_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_2_0.cfg_.activity).startTime)

				ShowTips(string.format(GetTips("OPEN_TIME"), var_3_0))
			else
				ShowTips(GetTips("TIME_OVER"))
			end

			return
		end

		if not arg_2_0.isOpen_ then
			ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK"), NewWarChessLevelCfg[arg_2_0.cfg_.front_level_id].name_level))

			return
		end

		if arg_2_0.isOpen_ and arg_2_0.activityIsOpen_ then
			if NewWarChessData:GetExploreValue(arg_2_0.chapterID_) >= 100 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("ACTIVITY_NEW_WARCHESS_LEVEL_EXPLORE_MAX"),
					OkCallback = function()
						NewChessTools.EnterChessMap(arg_2_0.chapterID_)
					end
				})
			else
				NewChessTools.EnterChessMap(arg_2_0.chapterID_)
			end
		end
	end)
end

function var_0_0.SetEventListener(arg_5_0)
	arg_5_0:RegistEventListener(ACTIVITY_UPDATE, handler(arg_5_0, arg_5_0.OnActivityUpdate))
end

function var_0_0.RemoveEventListener(arg_6_0)
	arg_6_0:RemoveAllEventListener()
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.chapterID_ = arg_7_1
	arg_7_0.cfg_ = NewWarChessLevelCfg[arg_7_1]

	arg_7_0:RefreshUI()
	arg_7_0:RefreshStatus()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.nametext_.text = arg_8_0.cfg_.name_level
	arg_8_0.bgImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/NewWarChess/" .. arg_8_0.cfg_.background_level)
	arg_8_0.movePointText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetMovePoint(arg_8_0.chapterID_))

	local var_8_0 = NewWarChessData:GetExploreValue(arg_8_0.chapterID_) .. "<size=16>%</size>"

	arg_8_0.progressText_.text = var_8_0
	arg_8_0.progressImage_.fillAmount = NewWarChessData:GetExploreValue(arg_8_0.chapterID_) / 100
end

function var_0_0.RefreshStatus(arg_9_0)
	if arg_9_0.cfg_.activity ~= 0 then
		if ActivityData:GetActivityIsOpen(arg_9_0.cfg_.activity) then
			arg_9_0.activityIsOpen_ = true

			local var_9_0 = arg_9_0.cfg_.front_level_id

			if var_9_0 ~= 0 then
				if NewWarChessData:GetLevelIsFinish(var_9_0) == 1 then
					arg_9_0.controller_:SetSelectedState("true")

					arg_9_0.isOpen_ = true
				else
					arg_9_0.controller_:SetSelectedState("false")

					arg_9_0.lockText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK"), NewWarChessLevelCfg[var_9_0].name_level)
					arg_9_0.isOpen_ = false
				end
			else
				arg_9_0.controller_:SetSelectedState("true")

				arg_9_0.isOpen_ = true
			end
		else
			arg_9_0.activityIsOpen_ = false

			arg_9_0.controller_:SetSelectedState("false")

			if manager.time:GetServerTime() < ActivityData:GetActivityData(arg_9_0.cfg_.activity).startTime then
				local var_9_1 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_9_0.cfg_.activity).startTime)

				arg_9_0.lockText_.text = string.format(GetTips("OPEN_TIME"), var_9_1)

				if manager.time:GetServerTime() < ActivityData:GetActivityData(arg_9_0.cfg_.activity).startTime then
					local var_9_2 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_9_0.cfg_.activity).startTime)

					arg_9_0.lockText_.text = string.format(GetTips("OPEN_TIME"), var_9_2)
				else
					arg_9_0.lockText_.text = GetTips("TIME_OVER")
				end
			else
				arg_9_0.lockText_.text = GetTips("TIME_OVER")
			end
		end
	else
		arg_9_0.activityIsOpen_ = true

		local var_9_3 = arg_9_0.cfg_.front_level_id

		if var_9_3 ~= 0 then
			if NewWarChessData:GetLevelIsFinish(var_9_3) == 1 then
				arg_9_0.controller_:SetSelectedState("true")

				arg_9_0.isOpen_ = true
			else
				arg_9_0.controller_:SetSelectedState("false")

				arg_9_0.lockText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK"), NewWarChessLevelCfg[var_9_3].name_level)
				arg_9_0.isOpen_ = false
			end
		else
			arg_9_0.controller_:SetSelectedState("true")

			arg_9_0.isOpen_ = true
		end
	end
end

function var_0_0.OnActivityUpdate(arg_10_0, arg_10_1)
	if arg_10_1 == arg_10_0.cfg_.activity then
		arg_10_0:RefreshStatus()
	end
end

function var_0_0.CreatTimer(arg_11_0)
	if arg_11_0.timer_ == nil then
		arg_11_0.timer_ = Timer.New(function()
			arg_11_0:RefreshStatus()
		end, 1, -1)

		arg_11_0.timer_:Start()
	end
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.timer_ then
		arg_13_0.timer_:Stop()

		arg_13_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:StopTimer()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
