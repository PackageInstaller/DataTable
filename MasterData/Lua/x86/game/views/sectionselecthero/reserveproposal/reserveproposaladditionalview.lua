local ReserveProposalAdditionalView = class("ReserveProposalAdditionalView", (import("game.views.sectionSelectHero.SectionAdditionalView")))

function ReserveProposalAdditionalView:InitSubViewCfg()
	self.subViewDic_ = {
		comboSkillView = {
			go = self.comboSkillGo_,
			getClassFunc = handler(self, self.GetComboSkillViewClass)
		},
		mimirInfoView = {
			go = self.mimirInfoGo_,
			getClassFunc = handler(self, self.GetMimirInfoViewClass)
		}
	}
	self.schemeSwitchList_ = LuaList.New(handler(self, self.IndexItem), self.switchListGo_, ReserveProposalSwitchItem)
end

function ReserveProposalAdditionalView:InitController()
	self.raceEffectController_ = self.controllerExCollection_:GetController("raceEffect")
	self.raceActiveController_ = self.controllerExCollection_:GetController("raceActive")
	self.btnStateController_ = self.controllerExCollection_:GetController("btnState")
end

function ReserveProposalAdditionalView:Dispose()
	self.schemeSwitchList_:Dispose()

	self.schemeSwitchList_ = nil

	ReserveProposalAdditionalView.super.Dispose(self)
end

function ReserveProposalAdditionalView:AddListener()
	self:AddBtnListener(self.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = self.maxRaceID_,
			sameCamp = self.sameCamp_
		})
	end)
	self:AddBtnListener(self.saveBtn_, nil, function()
		manager.notify:CallUpdateFunc(RESERVE_PROPOSAL_CLICK_SAVE)
	end)
	self:AddBtnListener(self.selectBtn_, nil, function()
		manager.notify:CallUpdateFunc(RESERVE_PROPOSAL_CLICK_APPLY)
	end)
	self:AddBtnListener(self.deleteBtn_, nil, function()
		manager.notify:CallUpdateFunc(RESERVE_PROPOSAL_CLICK_DELETE)
	end)
end

function ReserveProposalAdditionalView:RefreshUI()
	self:RefreshRace()
end

function ReserveProposalAdditionalView:RefreshSwitchList(arg_10_1, arg_10_2, arg_10_3)
	self.contIDList_ = arg_10_1
	self.curSelectContID_ = arg_10_2

	self.schemeSwitchList_:StartScroll(#self.contIDList_, table.indexof(self.contIDList_, self.curSelectContID_) or 1)

	self.progressText_.text = string.format(GetTips("RESERVE_PROPOSAL_NUM"), arg_10_3, GameSetting.default_formation_num_max.value[1])
end

function ReserveProposalAdditionalView:RefreshSelect(arg_11_1)
	self.curSelectContID_ = arg_11_1

	for iter_11_0, iter_11_1 in pairs(self.schemeSwitchList_:GetItemList()) do
		iter_11_1:SetSelect(arg_11_1)
	end
end

function ReserveProposalAdditionalView:RefreshBtnPanel(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	if ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.PROPOSAL):GetContDataTemplateById(arg_12_1):GetIsDirty() == true then
		self.btnStateController_:SetSelectedState("save")
	elseif SectionSelectHeroTools.IsReserveProposalEqual(arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, nil, arg_12_6) then
		self.btnStateController_:SetSelectedState("cur")
	else
		self.btnStateController_:SetSelectedState("normal")
	end
end

function ReserveProposalAdditionalView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetProxy(self.sectionProxy_)
	arg_13_2:SetData(self.contIDList_[arg_13_1])
	arg_13_2:SetSelect(self.curSelectContID_)
end

return ReserveProposalAdditionalView
