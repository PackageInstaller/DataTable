local SPHeroChallengeTrainStageItem = class("SPHeroChallengeTrainStageItem", ReduxView)

function SPHeroChallengeTrainStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function SPHeroChallengeTrainStageItem:InitUI()
	self:BindCfgUI()

	self.stateController = self.controller:GetController("state")
	self.buffControler = self.controller:GetController("buff")

	self:AddUIListener()
end

function SPHeroChallengeTrainStageItem:RefreshUI(arg_3_1, arg_3_2, arg_3_3)
	self.uiIndex = arg_3_3

	local var_3_0 = table.indexof(BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[BattleVerthandiExclusiveCfg[arg_3_1].sub_type], arg_3_1)

	if BattleVerthandiExclusiveCfg[arg_3_1] and var_3_0 then
		self.stageID = arg_3_1

		local var_3_1, var_3_2 = SPHeroChallengeTools:CheckStageIsOpen(arg_3_1)

		self.trainnameText_.text = BattleVerthandiExclusiveCfg[arg_3_1].name

		if not var_3_1 then
			self.stateController:SetSelectedState("unlock")

			local var_3_3, var_3_4 = SPHeroChallengeTools:GetTrainPercentByStage(arg_3_1, var_3_0)

			self.addexptextText_.text = GetTips("TIP_CLEARTIMES") .. "+" .. var_3_3

			if var_3_4 and var_3_4 < 100 then
				self.buffControler:SetSelectedState("show")
			else
				self.buffControler:SetSelectedState("close")
			end

			self.buffText.text = "-" .. 100 - var_3_4 .. "%"

			if arg_3_2 == arg_3_1 then
				self.stateController:SetSelectedState("selected")
			end
		else
			self.buffControler:SetSelectedState("close")
			self.stateController:SetSelectedState("lock")

			self.conditiontextText_.text = var_3_2
		end
	end
end

function SPHeroChallengeTrainStageItem:AddUIListener()
	self:AddBtnListener(self.trainstageitemBtn_, nil, function()
		if self.stateController:GetSelectedState() == "lock" then
			return
		end

		if self.clickFunc then
			self.clickFunc(self.stageID, self.uiIndex)
		end
	end)
end

function SPHeroChallengeTrainStageItem:RegisterClickCallBack(arg_6_1)
	if arg_6_1 then
		self.clickFunc = arg_6_1
	end
end

function SPHeroChallengeTrainStageItem:Dispose()
	self:RemoveAllListeners()
	SPHeroChallengeTrainStageItem.super.Dispose(self)
end

return SPHeroChallengeTrainStageItem
