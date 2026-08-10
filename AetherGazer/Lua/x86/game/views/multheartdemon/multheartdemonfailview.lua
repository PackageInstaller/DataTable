NewBattleFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedWithButtonView")

local var_0_0 = class("MultHeartDemonFailView", NewBattleFailedWithButtonView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_BattleResultLoseUI"
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btnBattleCount_, nil, function()
		arg_2_0:GoToBattleStatistics()
	end)
	arg_2_0:AddBtnListener(arg_2_0.exitBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("MULTI_HEART_DEMON_NOT_SAVE_CONFIRM_TIPS"),
			OkCallback = function()
				arg_2_0:OnClickBack()
			end
		})
	end)
	arg_2_0:AddBtnListener(arg_2_0.restartBtn_, nil, function()
		arg_2_0:OnClickRestart()
	end)
	arg_2_0:AddBtnListener(arg_2_0.btnMask_, nil, function()
		arg_2_0:Back(false, handler(arg_2_0, arg_2_0.OnClickBack))
	end)
	SetActive(arg_2_0.btnMask_.gameObject, true)
	arg_2_0.btnMask_.onClick:RemoveAllListeners()
	arg_2_0:AddBtnListener(arg_2_0.btnMask_, nil, function()
		arg_2_0:Back(false, function()
			return
		end)
	end)

	local function var_2_0()
		MultHeartDemonAction.SaveBattle({
			activity_id = arg_2_0.stageData_:GetActivityID(),
			stage_id = arg_2_0.stageID_
		})
		arg_2_0:OnClickBack()
	end

	arg_2_0:AddBtnListener(arg_2_0.saveBtn_, nil, function()
		if _G.SkipTip.SkipActivityMultiDemonContinueConfirm then
			var_2_0()
		else
			ShowMessageBox({
				isTop = true,
				content = GetTips("MULTI_HEART_DEMON_SAVE_CONFIRM_TIPS"),
				OkCallback = var_2_0,
				ToggleCallback = function(arg_12_0)
					_G.SkipTip.SkipActivityMultiDemonContinueConfirm = arg_12_0
				end
			})
		end
	end)
end

function var_0_0.OnEnter(arg_13_0)
	var_0_0.super.OnEnter(arg_13_0)

	arg_13_0.scoreTxt_.text = MultHeartDemonData:GetDataByPara("battleScore")
end

return var_0_0
