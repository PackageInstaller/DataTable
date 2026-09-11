NewBattleFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedWithButtonView")

local MultHeartDemonFailView = class("MultHeartDemonFailView", NewBattleFailedWithButtonView)

function MultHeartDemonFailView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_BattleResultLoseUI"
end

function MultHeartDemonFailView:AddUIListener()
	self:AddBtnListener(self.btnBattleCount_, nil, function()
		self:GoToBattleStatistics()
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("MULTI_HEART_DEMON_NOT_SAVE_CONFIRM_TIPS"),
			OkCallback = function()
				self:OnClickBack()
			end
		})
	end)
	self:AddBtnListener(self.restartBtn_, nil, function()
		self:OnClickRestart()
	end)
	self:AddBtnListener(self.btnMask_, nil, function()
		self:Back(false, handler(self, self.OnClickBack))
	end)
	SetActive(self.btnMask_.gameObject, true)
	self.btnMask_.onClick:RemoveAllListeners()
	self:AddBtnListener(self.btnMask_, nil, function()
		self:Back(false, function()
			return
		end)
	end)

	local function var_2_0()
		MultHeartDemonAction.SaveBattle({
			activity_id = self.stageData_:GetActivityID(),
			stage_id = self.stageID_
		})
		self:OnClickBack()
	end

	self:AddBtnListener(self.saveBtn_, nil, function()
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

function MultHeartDemonFailView:OnEnter()
	MultHeartDemonFailView.super.OnEnter(self)

	self.scoreTxt_.text = MultHeartDemonData:GetDataByPara("battleScore")
end

return MultHeartDemonFailView
