local var_0_0 = class("DormUnLockRoomConfirmView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormUnlockPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()

	arg_4_0.roomScroll = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, DormRoomUnLockItem)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:AddUIListener()
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.roomID = arg_6_0.params_.roomID

	arg_6_0:RefreshHeroList()
	arg_6_0:RegisterEvents()
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		JumpTools.OpenPageByJump("/dormChooseRoomView")
	end)
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.RegisterEvents(arg_10_0)
	arg_10_0:RegistEventListener(DORM_HERO_OCCUPY, function(arg_11_0)
		JumpTools.Back()

		local var_11_0 = arg_11_0[1]

		JumpTools.OpenPageByJump("dormPrivateOccupySuccessView", {
			archiveID = var_11_0
		})
	end)
end

function var_0_0.RefreshHeroList(arg_12_0)
	arg_12_0.archiveList = {}

	local var_12_0 = DormHeroTools:GetCanUseHeroInDorm()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if not DormRoomTools:GetDormIDViaArchive(iter_12_1) and DormData:GetHeroInfo(iter_12_1):GetHeroFavorability() >= GameSetting.dorm_hero_set_level.value[1] then
			table.insert(arg_12_0.archiveList, iter_12_1)
		end
	end

	arg_12_0.roomScroll:StartScroll(#arg_12_0.archiveList)

	if #arg_12_0.archiveList == 0 then
		arg_12_0.textText_.text = GetTips("DORM_HERO_SET_NULL")
	end
end

function var_0_0.indexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(arg_13_0.archiveList[arg_13_1])
	arg_13_2:PlaceHeroCallBack(function(arg_14_0)
		local var_14_0 = GetI18NText(HeroRecordCfg[arg_14_0].name)

		ShowMessageBox({
			content = string.format(GetTips("DORM_HERO_SET_CHECK"), var_14_0),
			OkCallback = function()
				local var_15_0 = DormData:GetHeroInfo(arg_14_0):GetCanUseHeroList()[1]

				if var_15_0 then
					DormAction:DeployHeroInRoom(arg_13_0.roomID, {
						var_15_0
					}, DormEnum.DormDeployType.Occupy)
				else
					Debug.LogError("未找到可以使用的角色id")
				end
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.roomScroll then
		arg_17_0.roomScroll:Dispose()
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
