local InidaNianStageItem = class("InidaNianStageItem", ReduxView)

function InidaNianStageItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "state")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function InidaNianStageItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		IndiaNianData:SetSelectedStage(self.cfg_.stage_id)
		IndiaNianData:SetSelectedStageCost(self.cfg_.cost)

		if self.cfg_.round < IndiaNianData:GetRound() or self.cfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(self.cfg_.id) == 0 then
			for iter_3_0, iter_3_1 in ipairs(IndiaNianCfg.get_id_list_by_group_id[self.cfg_.group_id]) do
				if IndiaNianCfg[iter_3_1].activity_id == self.cfg_.activity_id and IndiaNianCfg[iter_3_1].stage_type == 1 then
					IndiaNianData:SetSelectedDestID(iter_3_1)
				end
			end
		else
			IndiaNianData:SetSelectedDestID(self.cfg_.id)
		end

		if self.callback then
			self.callback(self.index_)
		end
	end)
	self:AddBtnListener(self.clearBtn_, nil, function()
		ShowTips("ACTIVITY_INDIA_NIAN_DESC_CLEAR")
	end)
end

function InidaNianStageItem:SetCallBack(arg_5_1)
	self.callback = arg_5_1
end

function InidaNianStageItem:RefreshUI()
	self.nameText_.text = self.cfg_.name
	self.iconImg_.sprite = getSprite("Atlas/IndiaUI_2_8", self.cfg_.icon)

	self:RefreshState()
end

function InidaNianStageItem:RefreshState()
	local var_7_0 = self.cfg_.round > IndiaNianData:GetRound()
	local var_7_1 = self.cfg_.round == IndiaNianData:GetRound()
	local var_7_2 = self.cfg_.round < IndiaNianData:GetRound() or self.cfg_.round == IndiaNianData:GetRound() and IndiaNianData:GetCurrentHpByID(self.cfg_.id) == 0
	local var_7_3 = IndiaNianData:GetStageHasClearedByID(self.cfg_.id)
	local var_7_4 = self.index_ == IndiaNianData:GetMainSelectedIndex()

	if var_7_0 then
		self.controller_:SetSelectedState("lock")
	elseif var_7_3 then
		self.controller_:SetSelectedState("finished")
	elseif var_7_2 then
		self.controller_:SetSelectedState("final")
	elseif var_7_1 then
		self.controller_:SetSelectedState("open")
	end

	local var_7_5 = IndiaNianData:GetCurrentHpByID(self.cfg_.id) / self.cfg_.boss_hp

	self.selectController_:SetSelectedState(tostring(var_7_4 and not var_7_3 and not var_7_0))

	self.silderImg_.fillAmount = var_7_5
	self.percentText_.text = math.ceil(var_7_5 * 100) .. "%"
end

function InidaNianStageItem:SetData(arg_8_1, arg_8_2)
	self.index_ = arg_8_1
	self.cfg_ = arg_8_2

	self:RefreshUI()
end

return InidaNianStageItem
