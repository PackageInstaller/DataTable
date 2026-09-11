local HodurChallengeAffixModule = class("HodurChallengeAffixModule", ReduxView)

function HodurChallengeAffixModule:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
	self:AddUIListener()
end

function HodurChallengeAffixModule:InitUI()
	self:BindCfgUI()

	self.selectedAffixList_ = {}
	self.itemList_ = {}
end

function HodurChallengeAffixModule:AddUIListener()
	return
end

function HodurChallengeAffixModule:SetData(arg_4_1)
	self.chapterID_ = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(ActivityHodurChapterCfg[arg_4_1].affix) do
		local var_4_0 = self.itemList_[iter_4_0]

		if not self.itemList_[iter_4_0] then
			var_4_0 = HodurChallengeSelectAffixItem.New(Object.Instantiate(self.affixGo_, self.affixContentTrs_))
			self.itemList_[iter_4_0] = var_4_0
		end

		var_4_0:SetData(iter_4_1)
		var_4_0:SetActive(true)
		var_4_0:SetClickHandler(function(arg_5_0)
			self:OnClickAffixItem(arg_5_0, var_4_0)
		end)
	end

	for iter_4_2 = #ActivityHodurChapterCfg[arg_4_1].affix + 1, #self.itemList_ do
		self.itemList_[iter_4_2]:SetActive(false)
	end

	for iter_4_3, iter_4_4 in ipairs(self.itemList_) do
		local var_4_1 = false

		for iter_4_5, iter_4_6 in ipairs(self.selectedAffixList_) do
			if iter_4_6 == iter_4_4.affixID_ then
				var_4_1 = true

				break
			end
		end

		iter_4_4:SetSelected(var_4_1)
	end
end

function HodurChallengeAffixModule:SetSelectedAffix(arg_6_1)
	self.selectedAffixList_ = {}

	for iter_6_0, iter_6_1 in ipairs(self.itemList_) do
		local var_6_0 = false

		for iter_6_2, iter_6_3 in ipairs(arg_6_1) do
			if iter_6_3 == iter_6_1.affixID_ then
				table.insert(self.selectedAffixList_, iter_6_3)

				var_6_0 = true

				break
			end
		end

		iter_6_1:SetSelected(var_6_0)
	end
end

function HodurChallengeAffixModule:OnClickAffixItem(arg_7_1, arg_7_2)
	if arg_7_2.selected_ then
		self:ShowTips(false)

		for iter_7_0, iter_7_1 in ipairs(self.selectedAffixList_) do
			if iter_7_1 == arg_7_1 then
				table.remove(self.selectedAffixList_, iter_7_0)

				break
			end
		end

		arg_7_2:SetSelected(false)
	else
		table.insert(self.selectedAffixList_, arg_7_1)
		arg_7_2:SetSelected(true)
		self:ShowTips(true, arg_7_1)
	end
end

function HodurChallengeAffixModule:GetSelectedAffix()
	return self.selectedAffixList_
end

function HodurChallengeAffixModule:ShowTips(arg_9_1, arg_9_2)
	self.showTips_ = arg_9_1

	SetActive(self.tipsGo_, arg_9_1)

	if arg_9_1 then
		self.tipsNameText_.text = AffixTypeCfg[arg_9_2].name
		self.tipsDescText_.text = DescriptionCfg[AffixTypeCfg[arg_9_2].description[1]].description

		if PublicBuffCfg[arg_9_2] then
			self.tipsNumText_.text = ActivityAffixPoolCfg[PublicBuffCfg[arg_9_2].buff_class_id].point .. "%"
		end
	end
end

function HodurChallengeAffixModule:Clear()
	return
end

function HodurChallengeAffixModule:Dispose()
	for iter_11_0, iter_11_1 in ipairs(self.itemList_) do
		iter_11_1:Dispose()
	end

	HodurChallengeAffixModule.super.Dispose(self)
	self:RemoveAllListeners()
end

return HodurChallengeAffixModule
