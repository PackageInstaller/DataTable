local OsirisPlayGameSimilarityView = class("OsirisPlayGameSimilarityView", ReduxView)

function OsirisPlayGameSimilarityView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Show(true)
	self:Init()
end

function OsirisPlayGameSimilarityView:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.heroItemList_) do
		iter_2_1:Dispose()
	end

	self.heroItemList_ = nil

	OsirisPlayGameSimilarityView.super.Dispose(self)
end

function OsirisPlayGameSimilarityView:Init()
	self:InitUI()
	self:AddListener()
end

function OsirisPlayGameSimilarityView:InitUI()
	self:BindCfgUI()
	self:InitController()
	self:InitCallback()

	self.heroItemList_ = {}
end

function OsirisPlayGameSimilarityView:InitController()
	return
end

function OsirisPlayGameSimilarityView:InitCallback()
	return
end

function OsirisPlayGameSimilarityView:AddListener()
	return
end

function OsirisPlayGameSimilarityView:SetProxy(arg_8_1)
	self.sectionProxy_ = arg_8_1
end

function OsirisPlayGameSimilarityView:OnEnter()
	self:AddEventListener()
end

function OsirisPlayGameSimilarityView:AddEventListener()
	return
end

function OsirisPlayGameSimilarityView:OnExit()
	self:RemoveAllEventListener()
end

function OsirisPlayGameSimilarityView:Refresh()
	self.skillIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Activity_Osiris/" .. ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.sectionProxy_.stageID][1]].generality)
	self.descText_.text = GetI18NText(ActivityGeneralityTagCfg[ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.sectionProxy_.stageID][1]].generality].desc)

	for iter_12_0, iter_12_1 in ipairs(self.sectionProxy_.heroInfoList) do
		local var_12_0 = 0

		if iter_12_1.heroID and iter_12_1.heroID > 0 then
			local var_12_1 = HeroData:GetHeroData(iter_12_1.heroID)

			var_12_0 = var_12_1.using_skin > 0 and var_12_1.using_skin or iter_12_1.heroID
		end

		self.heroItemList_[iter_12_0] = self.heroItemList_[iter_12_0] or SectionSmallHeroItem.New((Object.Instantiate(self.itemgGo_, self.contentTrs_)))

		self.heroItemList_[iter_12_0]:SetData(var_12_0)

		if iter_12_1.heroID and iter_12_1.heroID ~= 0 then
			self.heroItemList_[iter_12_0]:RefreshValid((self:GetValid(iter_12_1.heroID, ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[self.sectionProxy_.stageID][1]].generality)))
		else
			self.heroItemList_[iter_12_0]:RefreshValid(true)
		end
	end

	for iter_12_2 = #self.sectionProxy_.heroInfoList + 1, 3 do
		if self.heroItemList_[iter_12_2] then
			self.heroItemList_[iter_12_2]:Show(false)
		end
	end
end

function OsirisPlayGameSimilarityView:GetValid(arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in ipairs(ActivityGeneralityCharactorCfg[arg_13_1].generality) do
		if arg_13_2 == iter_13_1 then
			return true
		end
	end

	return false
end

function OsirisPlayGameSimilarityView:Show(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

return OsirisPlayGameSimilarityView
