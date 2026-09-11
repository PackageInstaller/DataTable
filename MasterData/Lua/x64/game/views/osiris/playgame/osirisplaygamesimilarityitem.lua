local OsirisPlayGameSimilarityItem = class("OsirisPlayGameSimilarityItem", ReduxView)

function OsirisPlayGameSimilarityItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function OsirisPlayGameSimilarityItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function OsirisPlayGameSimilarityItem:InitUI()
	self:BindCfgUI()

	self.stateCon_ = self.controllerEx_:GetController("state")
end

function OsirisPlayGameSimilarityItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self:ShowAffixInfo(self.generalitId)

		if self.clickFun then
			self.clickFun(self.index)
		end
	end)
end

function OsirisPlayGameSimilarityItem:ShowAffixInfo(arg_6_1)
	SetActive(self.affixinfoTrs_.gameObject, true)

	self.affixcontentText_.text = GetI18NText(ActivityGeneralityTagCfg[arg_6_1].desc)
	self.affixnameText_.text = GetI18NText(ActivityGeneralityTagCfg[arg_6_1].name)

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.affixcontentTrs_)

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	self.countdownTimer_ = Timer.New(function()
		SetActive(self.affixinfoTrs_.gameObject, false)
		self.countdownTimer_:Stop()
	end, 3, 1)

	self.countdownTimer_:Start()
end

function OsirisPlayGameSimilarityItem:HideAffixInfo()
	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	SetActive(self.affixinfoTrs_.gameObject, false)
end

function OsirisPlayGameSimilarityItem:SetData(arg_9_1, arg_9_2, arg_9_3)
	self:Show(true)

	self.generalitId = arg_9_1
	self.stageID = arg_9_2
	self.index = arg_9_3

	self:RefreshUI()
end

function OsirisPlayGameSimilarityItem:RefreshUI()
	self.skillIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. self.generalitId)

	self.stateCon_:SetSelectedIndex(ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.stageID][1]].generality == self.generalitId and 1 or 0)
end

function OsirisPlayGameSimilarityItem:RegisterClickFunc(arg_11_1)
	self.clickFun = arg_11_1
end

function OsirisPlayGameSimilarityItem:Show(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
end

function OsirisPlayGameSimilarityItem:OnExit()
	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	self:HideAffixInfo()
	self.super.OnExit(self)
end

return OsirisPlayGameSimilarityItem
