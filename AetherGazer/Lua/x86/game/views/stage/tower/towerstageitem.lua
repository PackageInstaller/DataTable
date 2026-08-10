local var_0_0 = class("TowerStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddClickListen()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.romanController = ControllerUtil.GetController(arg_2_0.transform_, "roman")
	arg_2_0.rewardList = LuaList.New(handler(arg_2_0, arg_2_0.indexItem), arg_2_0.m_rewardList, CommonItemView)
end

function var_0_0.AddClickListen(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_btn, nil, function()
		if PlayerData:GetPlayerInfo().userLevel < arg_3_0.limitLv then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), arg_3_0.limitLv))

			return
		end

		SetActive(arg_3_0.m_redGo, false)
		manager.redPoint:setTip(RedPointConst.TOWER_NEW_LEVEL + arg_3_0.chapterId, 0, RedPointStyle.SHOW_NEW_TAG)
		RedPointAction.HandleRedPoint(RedPointConst.TOWER_NEW_LEVEL + arg_3_0.chapterId)
		JumpTools.GoToSystem("/tower", {
			chapterId = arg_3_0.chapterId
		}, ViewConst.SYSTEM_ID.TOWER)

		if arg_3_0.clickFunc then
			arg_3_0.clickFunc()
		end
	end)
end

function var_0_0.RegistCallBack(arg_5_0, arg_5_1)
	arg_5_0.clickFunc = arg_5_1
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.chapterId = arg_6_1

	arg_6_0.romanController:SetSelectedIndex(arg_6_2)

	local var_6_0 = ChapterCfg[arg_6_1]
	local var_6_1 = var_6_0.section_id_list
	local var_6_2 = TowerData:GetOverId(arg_6_1)
	local var_6_3 = #var_6_1
	local var_6_4 = table.indexof(var_6_1, var_6_2) or 0

	arg_6_0.m_processText.text = var_6_4 .. "/" .. var_6_3
	arg_6_0.m_process.value = var_6_3 == 0 and 0 or var_6_4 / var_6_3

	local var_6_5 = var_6_1[var_6_3] or 0

	if var_6_5 == 0 then
		arg_6_0.rewardList:StartScroll(0)
	else
		local var_6_6 = (BattleTowerStageCfg[var_6_5] or {}).drop_lib_id

		if var_6_6 ~= 0 then
			arg_6_0.rewardData = getRewardFromDropCfg(var_6_6, true)

			arg_6_0.rewardList:StartScroll(#arg_6_0.rewardData)
		else
			arg_6_0.rewardList:StartScroll(0)
		end
	end

	arg_6_0.limitLv = var_6_0.level or 0

	if PlayerData:GetPlayerInfo().userLevel < arg_6_0.limitLv then
		arg_6_0.stateController:SetSelectedIndex(0)
	elseif var_6_5 == var_6_2 then
		arg_6_0.stateController:SetSelectedIndex(2)
	else
		arg_6_0.stateController:SetSelectedIndex(1)
	end

	local var_6_7 = ChapterClientCfg[arg_6_1]
	local var_6_8 = var_6_7 and var_6_7.chapter_paint or ""

	arg_6_0.m_role.sprite = pureGetSpriteWithoutAtlas("TextureConfig/TowerUI/Boss/" .. var_6_8)

	local var_6_9 = manager.redPoint:getTipValue(RedPointConst.TOWER_NEW_LEVEL + arg_6_0.chapterId)

	SetActive(arg_6_0.m_redGo, var_6_9 > 0)
end

function var_0_0.indexItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.rewardData[arg_7_1]
	local var_7_1 = rewardToItemTemplate(var_7_0)

	var_7_1.number, var_7_1.equipLevel = nil

	arg_7_2:SetData(var_7_1)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.rewardList:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
