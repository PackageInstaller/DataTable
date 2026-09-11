local SectionAdditionalView = class("SectionAdditionalView", ReduxView)

function SectionAdditionalView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SectionAdditionalView:Init()
	self:InitUI()
	self:AddListener()
end

function SectionAdditionalView:InitUI()
	self:BindCfgUI()
	self:InitSubViewCfg()
	self:InitController()
	self:InitCallback()
end

function SectionAdditionalView:InitSubViewCfg()
	self.subViewDic_ = {
		comboSkillView = {
			go = self.comboSkillGo_,
			getClassFunc = handler(self, self.GetComboSkillViewClass)
		},
		mimirInfoView = {
			go = self.mimirInfoGo_,
			getClassFunc = handler(self, self.GetMimirInfoViewClass)
		},
		stageInfoView = {
			go = self.stageInfoGo_,
			getClassFunc = handler(self, self.GetStageInfoClass)
		},
		heroVoiceInfoView = {
			go = self.heroVoiceInfoGo_,
			getClassFunc = handler(self, self.GetHeroVoiceInfoViewClass)
		}
	}
end

function SectionAdditionalView:InitController()
	self.stageInfoActiveController_ = self.controllerExCollection_:GetController("stageInfoActive")
	self.raceEffectController_ = self.controllerExCollection_:GetController("raceEffect")
	self.raceActiveController_ = self.controllerExCollection_:GetController("raceActive")
	self.reserveBtnController_ = self.controllerExCollection_:GetController("reserveActive")
	self.totalEnergyController_ = self.controllerExCollection_:GetController("totalEnergy")
end

function SectionAdditionalView:InitCallback()
	return
end

function SectionAdditionalView:SetProxy(arg_7_1)
	self.sectionProxy_ = arg_7_1
	self.reserveParams_ = arg_7_1:GetReserveParams()

	self:ProcessSubView()
end

function SectionAdditionalView:ProcessSubView()
	self:InitSubView()
	self:TryReloadSubView()
	self:ProcessSubViewParams()
end

function SectionAdditionalView:ProcessSubViewParams()
	self:SubViewCallFunc("SetProxy", self.sectionProxy_)
end

function SectionAdditionalView:OnEnter()
	self:AddEventListener()
	self:SubViewOnEnter()
end

function SectionAdditionalView:AddEventListener()
	return
end

function SectionAdditionalView:SubViewOnEnter()
	self:SubViewCallFunc("OnEnter")
end

function SectionAdditionalView:OnExit()
	self:RemoveAllEventListener()
	self:SubViewOnExit()
end

function SectionAdditionalView:SubViewOnExit()
	self:SubViewCallFunc("OnExit")
end

function SectionAdditionalView:Dispose()
	self:SubViewCallFunc("Dispose")

	for iter_15_0, iter_15_1 in pairs(self.subViewDic_) do
		iter_15_1.go = nil
		iter_15_1.instance = nil
	end

	SectionAdditionalView.super.Dispose(self)
end

function SectionAdditionalView:AddListener()
	self:AddBtnListener(self.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = self.maxRaceID_,
			sameCamp = self.sameCamp_
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		manager.notify:Invoke(SECTION_CLICK_START_BATTLE)
	end)
	self:AddBtnListener(self.reservesBtn_, nil, function()
		if not self.sectionProxy_.canChangeReserveProposal then
			return
		end

		self:GotoReservesProposalUI()
	end)
end

function SectionAdditionalView:Refresh()
	self:RefreshSubView()
	self:RefreshUI()
end

function SectionAdditionalView:RefreshSubView()
	self:SubViewCallFunc("Refresh")
end

function SectionAdditionalView:RefreshUI()
	self:RefresgStageInfoActive()
	self:RefreshReservesBtn()
	self:RefreshRace()
end

function SectionAdditionalView:RefresgStageInfoActive()
	local var_23_0 = BattleStageTools.GetStageName(self.sectionProxy_.stageType, self.sectionProxy_.stageID)

	if not var_23_0 or var_23_0 == "" then
		self.stageInfoActiveController_:SetSelectedState("false")
	else
		self.stageInfoActiveController_:SetSelectedState("true")
	end
end

function SectionAdditionalView:RefreshReservesBtn()
	local var_24_0 = true
	local var_24_1 = self.sectionProxy_:GetLockStateList() or {}

	for iter_24_0 = 1, 3 do
		if var_24_1[iter_24_0] then
			var_24_0 = false
		end
	end

	if self.sectionProxy_.canChangeTeam == false then
		var_24_0 = false
	end

	if self.sectionProxy_.needReserveProposalPanel == true then
		self.sectionProxy_.needReserveProposalPanel = var_24_0
		self.sectionProxy_.canChangeReserveProposal = var_24_0
	end

	self.reserveBtnController_:SetSelectedState(tostring(self.sectionProxy_.needReserveProposalPanel))
end

function SectionAdditionalView:GotoReservesProposalUI()
	self.sectionProxy_:GotoReservesProposalUI()
end

function SectionAdditionalView:RefreshRace()
	self.raceActiveController_:SetSelectedState(tostring(self.sectionProxy_.needRacePanel))

	if self.sectionProxy_.needRacePanel then
		self:RefreshRaceUI()
	end
end

function SectionAdditionalView:RefreshRaceUI()
	local var_27_0
	local var_27_1
	local var_27_2

	if self.sectionProxy_.forceRace == -1 then
		var_27_0, var_27_1, var_27_2 = self:GetRaceEffect()
		self.maxRaceID_ = var_27_0
		self.sameCamp_ = var_27_2
	else
		var_27_0 = self.sectionProxy_.forceRace
		var_27_1 = 0

		for iter_27_0, iter_27_1 in ipairs(self.cacheHeroTeam_) do
			if iter_27_1 ~= 0 then
				var_27_1 = var_27_1 + 1
			end
		end
	end

	self.maxRaceID_ = var_27_0
	self.sameCamp_ = var_27_2

	if var_27_0 == 0 then
		self.raceEffectController_:SetSelectedState("none")
	else
		self.raceIcon_.sprite = HeroTools.GetRaceIcon(var_27_0)

		if var_27_1 > 1 then
			var_27_1 = var_27_1 <= 3 and var_27_1 or 3

			self.raceEffectController_:SetSelectedState(tostring(var_27_1))
		end
	end
end

function SectionAdditionalView:GetRaceEffect()
	return self.sectionProxy_:GetRaceEffect()
end

function SectionAdditionalView:GetStageInfoClass()
	return self.sectionProxy_:GetStageInfoClass()
end

function SectionAdditionalView:GetMimirInfoViewClass()
	return self.sectionProxy_:GetMimirInfoViewClass()
end

function SectionAdditionalView:GetComboSkillViewClass()
	return self.sectionProxy_:GetComboSkillViewClass()
end

function SectionAdditionalView:GetHeroVoiceInfoViewClass()
	return self.sectionProxy_:GetHeroVoiceInfoViewClass()
end

function SectionAdditionalView:InitSubView()
	if not self.createdSubview_ then
		self.createdSubview_ = true

		for iter_33_0, iter_33_1 in pairs(self.subViewDic_) do
			iter_33_1.instance = iter_33_1.getClassFunc().New(iter_33_1.go)

			if iter_33_1.initFunc then
				iter_33_1.initFunc()
			end
		end
	end
end

function SectionAdditionalView:TryReloadSubView()
	for iter_34_0, iter_34_1 in pairs(self.subViewDic_) do
		if SectionSelectHeroTools.IsDiffViewClass(iter_34_1.instance, iter_34_1.getClassFunc()) then
			iter_34_1.instance = SectionSelectHeroTools.ReloadView(iter_34_1.instance, iter_34_1.getClassFunc())

			if iter_34_1.initFunc then
				iter_34_1.initFunc()
			end
		end
	end
end

function SectionAdditionalView:SubViewCallFunc(arg_35_1, ...)
	for iter_35_0, iter_35_1 in pairs(self.subViewDic_) do
		if iter_35_1.instance and iter_35_1.instance[arg_35_1] then
			iter_35_1.instance[arg_35_1](iter_35_1.instance, ...)
		end
	end
end

return SectionAdditionalView
