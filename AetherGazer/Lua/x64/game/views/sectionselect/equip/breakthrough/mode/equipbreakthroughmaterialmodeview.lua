local var_0_0 = class("EquipBreakThroughMaterialModeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/EquipBreakThroughMaterial/EquipChapterMapSelectDifficultyUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.selectController_ = ControllerUtil.GetController(arg_3_0.btnTransform_, "conName")
	arg_3_0.chooseHandler_ = handler(arg_3_0, arg_3_0.ChooseMode)
	arg_3_0.modeUIList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshItem), arg_3_0.uiList_, EquipBreakThroughMaterialModeItem)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RegistListener(CHALLENGE_CHOOSE_MODE, arg_4_0.chooseHandler_)
	arg_4_0.modeUIList_:StartScroll(#EquipBreakThroughMaterialDifficultyCfg.all, 1)
	arg_4_0:RefreshUI()
	arg_4_0:CheckMail()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.chooseIndex_ = nil

	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CHALLENGE_CHOOSE_MODE, arg_5_0.chooseHandler_)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.chooseHandler_ = nil

	if arg_6_0.modeUIList_ then
		arg_6_0.modeUIList_:Dispose()

		arg_6_0.modeUIList_ = nil
	end
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.chooseBtn_, nil, function()
		if arg_7_0.chooseIndex_ == nil then
			return
		end

		if arg_7_0.chooseIndex_ == EquipBreakThroughMaterialData:GetSelectModeID() then
			arg_7_0:Go("/equipBreakThroughMaterialMap", nil, true)

			return
		end

		if EquipBreakThroughMaterialData:GetSelectModeID() ~= 0 or EquipBreakThroughMaterialData:GetSelectModeID() == arg_7_0.chooseIndex_ then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_BREAK_THROUGH_RESET_DIFFICULTY"),
				OkCallback = function()
					arg_7_0:ClickBtn()
				end
			})

			return
		else
			arg_7_0:ClickBtn()
		end
	end)
end

function var_0_0.CheckMail(arg_10_0)
	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_BREAK_THROUGH_MATERIAL) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.EQUIP_BREAK_THROUGH_MATERIAL)
			end
		})
	end
end

function var_0_0.ClickBtn(arg_12_0)
	EquipBreakThroughMaterialAction.RequireEquipBTMaterialData(arg_12_0.chooseIndex_, function()
		manager.notify:Invoke(EQUIP_BREAK_THROUGH_MATERIAL_CHANGE)
		arg_12_0:Go("/equipBreakThroughMaterialMap", nil, true)
	end)
end

function var_0_0.RefreshUI(arg_14_0)
	arg_14_0:ChooseMode(arg_14_0.chooseIndex_)
end

function var_0_0.RefreshItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_1, arg_15_0.chooseIndex_)
end

function var_0_0.ChooseMode(arg_16_0, arg_16_1)
	arg_16_0.chooseIndex_ = arg_16_1

	if arg_16_1 then
		arg_16_0.selectController_:SetSelectedState("true")
	else
		arg_16_0.selectController_:SetSelectedState("false")
	end
end

return var_0_0
