local var_0_0 = class("ValentineGameV3SelectHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockController_ = arg_3_0.controllerEx_:GetController("lock")
	arg_3_0.canReceiveController_ = arg_3_0.controllerEx_:GetController("CanReceive")
	arg_3_0.completionController_ = arg_3_0.controllerEx_:GetController("Completion")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if ActivityData:GetActivityIsOpen(arg_4_0.subActivityID_) then
			local var_5_0 = getModule("ActivityValentineV3StageData")

			if var_5_0 == nil then
				var_5_0 = {}
			end

			table.insert(var_5_0, arg_4_0.subActivityID_)
			saveModule("ActivityValentineV3StageData", var_5_0)
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. arg_4_0.subActivityID_, 0)
			JumpTools.OpenPageByJump("/valentineGameV3SelectStageView", {
				mainActivityID = arg_4_0.mainActivityID_,
				subActivityID = arg_4_0.subActivityID_
			})
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(arg_4_0.subActivityID_).startTime then
			local var_5_1 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_4_0.subActivityID_).startTime)

			ShowTips(string.format(GetTips("OPEN_TIME"), var_5_1))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.mainActivityID_ = arg_6_1
	arg_6_0.subActivityID_ = arg_6_2
	arg_6_0.cfg_ = ActivityValentineV3StageCfg[arg_6_0.subActivityID_]

	if HeroCfg[arg_6_0.cfg_.hero_id] then
		arg_6_0.nameText_.text = HeroCfg[arg_6_0.cfg_.hero_id].suffix
	else
		arg_6_0.nameText_.text = GetTips("ERROR_NO_TEMPLATE")
	end

	arg_6_0.heroImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_6_0.cfg_.hero_id)
	arg_6_0.heroImage_.transform.localPosition = Vector3(arg_6_0.cfg_.offset[1], arg_6_0.cfg_.offset[2], 0)
	arg_6_0.heroBgImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. arg_6_0.cfg_.hero_id)
	arg_6_0.heroBgImage_.transform.localPosition = Vector3(arg_6_0.cfg_.offset[1], arg_6_0.cfg_.offset[2], 0)

	arg_6_0:RefreshStatus()
	manager.redPoint:bindUIandKey(arg_6_0.transform_, RedPointConst.VALENTINE_GAME .. "_" .. arg_6_0.subActivityID_)
	arg_6_0:RegistEventListener(ACTIVITY_UPDATE, handler(arg_6_0, arg_6_0.OnActivityUpdate))
end

function var_0_0.RefreshStatus(arg_7_0)
	if ActivityData:GetActivityIsOpen(arg_7_0.subActivityID_) then
		arg_7_0.lockController_:SetSelectedState("false")

		local var_7_0 = 0
		local var_7_1 = PlayerData:GetStoryList()
		local var_7_2 = false

		for iter_7_0 = 1, 3 do
			local var_7_3 = arg_7_0.cfg_["stage_storyid_and_dorpid_" .. iter_7_0][1]

			if var_7_1[var_7_3] == true then
				var_7_0 = var_7_0 + 1

				if not ValentineGameData:GetStoryIDIsGetReward(var_7_3) then
					var_7_2 = true
				end
			end
		end

		arg_7_0.completionController_:SetSelectedState(var_7_0)

		if var_7_2 then
			arg_7_0.canReceiveController_:SetSelectedState("true")
		else
			arg_7_0.canReceiveController_:SetSelectedState("false")
		end
	else
		arg_7_0.lockController_:SetSelectedState("true")

		if manager.time:GetServerTime() < ActivityData:GetActivityData(arg_7_0.subActivityID_).startTime then
			local var_7_4 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_7_0.subActivityID_).startTime)

			arg_7_0.lockText_.text = string.format(GetTips("OPEN_TIME"), var_7_4)
		else
			arg_7_0.lockText_.text = GetTips("TIME_OVER")
		end

		arg_7_0.canReceiveController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshTimeText(arg_8_0)
	if not ActivityData:GetActivityIsOpen(arg_8_0.subActivityID_) and manager.time:GetServerTime() < ActivityData:GetActivityData(arg_8_0.subActivityID_).startTime then
		local var_8_0 = manager.time:GetLostTimeStr(ActivityData:GetActivityData(arg_8_0.subActivityID_).startTime)

		arg_8_0.lockText_.text = string.format(GetTips("OPEN_TIME"), var_8_0)
	end
end

function var_0_0.OnActivityUpdate(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0.subActivityID_ then
		arg_9_0:RefreshStatus()
	end
end

function var_0_0.OnExit(arg_10_0)
	manager.redPoint:unbindUIandKey(arg_10_0.redTrans_, RedPointConst.VALENTINE_GAME .. "_" .. arg_10_0.subActivityID_)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
