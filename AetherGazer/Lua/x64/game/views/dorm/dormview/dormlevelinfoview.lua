local var_0_0 = class("DormLevelInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormPoplevelUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.levelScroll = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, DormLevelAwardItem)
	arg_4_0.maxController = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "level")
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.roomID = DormData:GetCurrectSceneID()

	if BackHomeCfg[arg_6_0.roomID].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		arg_6_0.archiveID = arg_6_0.params_.archiveID
	end

	arg_6_0:RefreshList()
	arg_6_0:RefreshExp()
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.indexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:RefreshUI(arg_10_0.itemList[arg_10_1], arg_10_1, arg_10_0.curLevel)
end

function var_0_0.RefreshList(arg_11_0)
	local var_11_0 = DormData:GetHeroInfo(arg_11_0.archiveID):GetCanUseHeroList()[1]

	arg_11_0.itemList = BackHomeHeroCfg[var_11_0].level_reward
	arg_11_0.curLevel = DormitoryData:GetDormLevel(arg_11_0.roomID)

	arg_11_0.levelScroll:StartScroll(#arg_11_0.itemList)
	arg_11_0.levelScroll:ScrollToIndex(arg_11_0.curLevel, false, false)
end

function var_0_0.RefreshExp(arg_12_0)
	local var_12_0 = DormitoryData:GetDormLevel(arg_12_0.roomID)

	arg_12_0.level.text = tostring(var_12_0)

	if var_12_0 == #BackHomeDormLevel.all then
		arg_12_0.maxController:SetSelectedState("full_rank")

		arg_12_0.curExp.text = ""
		arg_12_0.maxExp.text = ""
		arg_12_0.progress.value = 1

		return
	end

	local var_12_1 = DormitoryData:GetDormExp(arg_12_0.roomID)
	local var_12_2 = 0

	if var_12_0 >= 1 then
		for iter_12_0 = 1, var_12_0 do
			var_12_2 = var_12_2 + BackHomeDormLevel[iter_12_0].exp
		end
	end

	arg_12_0.curExp.text = var_12_1
	arg_12_0.maxExp.text = "/" .. var_12_2
	arg_12_0.progress.value = var_12_1 / var_12_2
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.levelScroll then
		arg_13_0.levelScroll:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
