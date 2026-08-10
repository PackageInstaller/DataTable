local var_0_0 = class("ChapterDemoItem", ReduxView)

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
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		arg_4_0:ClickItemListener()
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.chapterClientID_ = arg_6_1

	local var_6_0 = ChapterClientCfg[arg_6_0.chapterClientID_]

	if not var_6_0 then
		return
	end

	arg_6_0.chapterName_.text = GetI18NText(var_6_0.name)

	SetSpriteWithoutAtlasAsync(arg_6_0.chapterPaint_, SpritePathCfg.ChapterPaint.path .. var_6_0.chapter_paint)

	if arg_6_0.chapterClientID_ == 601 then
		manager.redPoint:bindUIandKey(arg_6_0.transform_, RedPointConst.COOPERATION_DEMO)
	end

	if arg_6_0:IsLock() then
		SetActive(arg_6_0.lockGo_, true)
	else
		SetActive(arg_6_0.lockGo_, false)
	end

	if arg_6_0:GetLostTimeStr() == nil then
		SetActive(arg_6_0.openGo_, false)
	else
		arg_6_0:RefrenTime()
		SetActive(arg_6_0.openGo_, true)
	end
end

function var_0_0.UnBindRedPoint(arg_7_0)
	manager.redPoint:unbindUIandKey(arg_7_0.transform_)
end

function var_0_0.ClickItemListener(arg_8_0)
	if arg_8_0:IsLock(true) then
		return
	end

	if arg_8_0.chapterClientID_ == 601 and ActivityTools.GetActivityIsOpenWithTip(ActivityConst.COOPERATION_DEMO, true) then
		JumpTools.GoToSystem("/cooperationBlank/demoCooperationEntry")
	end
end

function var_0_0.RefrenTime(arg_9_0)
	local var_9_0 = arg_9_0:GetLostTimeStr()

	if var_9_0 then
		arg_9_0.openText_.text = var_9_0
	else
		arg_9_0.openText_.text = ""
	end
end

function var_0_0.GetLostTimeStr(arg_10_0)
	if arg_10_0.chapterClientID_ == 601 then
		local var_10_0 = ActivityData:GetActivityData(ActivityConst.COOPERATION_DEMO)

		if var_10_0 and var_10_0:IsActivitying() then
			return manager.time:GetLostTimeStr(var_10_0.stopTime)
		else
			return GetTips("TIME_OVER")
		end
	end

	return nil
end

function var_0_0.IsLock(arg_11_0, arg_11_1)
	local var_11_0 = ChapterClientCfg[arg_11_0.chapterClientID_]
	local var_11_1 = PlayerData:GetPlayerInfo().userLevel < var_11_0.level

	if var_11_1 and arg_11_1 then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_11_0.level))
	end

	return var_11_1
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
