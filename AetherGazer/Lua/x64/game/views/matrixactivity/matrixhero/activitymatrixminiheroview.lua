local var_0_0 = class("ActivityMatrixMiniHeroView", MatrixMiniHeroView)

function var_0_0.OnCtor(arg_1_0)
	var_0_0.super.OnCtor(arg_1_0)

	arg_1_0.ClassList_ = {
		ActivityMatrixHeroAttributePage,
		ActivityMatrixHeroSkillPage,
		ActivityMartixHeroWeaponPage,
		ActivityMatrixHeroEquipPage,
		ActivityMatrixHeroAstrolabePage
	}
end

function var_0_0.AddUIListener(arg_2_0)
	for iter_2_0, iter_2_1 in pairs(arg_2_0.toggles_) do
		iter_2_1.onValueChanged:AddListener(function(arg_3_0)
			if arg_3_0 then
				arg_2_0:SwitchPage(iter_2_0)

				if arg_2_0.pages_[iter_2_0] then
					arg_2_0.pages_[iter_2_0]:SetMatirxHeroInfo(arg_2_0.matrix_activity_id, arg_2_0.curHeroId_)
				end
			end
		end)
	end
end

function var_0_0.OnTop(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, arg_4_0.matrix_activity_id)
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.matrix_activity_id = arg_5_0.params_.matrix_activity_id

	var_0_0.super.OnEnter(arg_5_0)
end

function var_0_0.UpdateHeroView(arg_6_0)
	arg_6_0:UpdateAvatarView()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.pages_) do
		iter_6_1:SetMatirxHeroInfo(arg_6_0.matrix_activity_id, arg_6_0.curHeroId_)
	end
end

function var_0_0.GetHeroData(arg_7_0, arg_7_1)
	return ActivityMatrixData:GetHeroData(arg_7_0.matrix_activity_id, arg_7_1)
end

function var_0_0.GetHeroSkin(arg_8_0, arg_8_1)
	return ActivityMatrixData:GetHeroSkin(arg_8_0.matrix_activity_id, arg_8_1)
end

return var_0_0
