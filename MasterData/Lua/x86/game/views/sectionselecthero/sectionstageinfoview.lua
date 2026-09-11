local SectionStageInfoView = class("SectionStageInfoView", ReduxView)

function SectionStageInfoView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Show(true)
	self:Init()
end

function SectionStageInfoView:Init()
	self:BindCfgUI()

	self.attributeItemList_ = {}
end

function SectionStageInfoView:SetProxy(arg_3_1)
	self.sectionProxy_ = arg_3_1
	self.stageType_ = self.sectionProxy_.stageType
	self.stageID_ = self.sectionProxy_.stageID
end

function SectionStageInfoView:Refresh()
	self:RefreshTitle()
	self:RefreshRecommend()
	self:RefreshRecommendAttribute()
end

function SectionStageInfoView:RefreshTitle()
	self.stageID_ = self.sectionProxy_.stageID
	self.titleText_.text = BattleStageTools.GetStageName(self.stageType_, self.stageID_)
end

function SectionStageInfoView:RefreshRecommend()
	local var_6_0 = self:GetRecommendLevel()

	if var_6_0 == 0 then
		SetActive(self.recommendLevelGo_, false)
	else
		SetActive(self.recommendLevelGo_, true)

		self.recommendLevel_.text = var_6_0
	end
end

function SectionStageInfoView:GetRecommendLevel()
	return BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).recommend_level or 0
end

function SectionStageInfoView:RefreshRecommendAttribute()
	local var_8_0 = BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).recommend_attribute_list or {}

	if #var_8_0 > 0 then
		SetActive(self.attributePanelGo_, true)

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			self.attributeItemList_[iter_8_0] = self.attributeItemList_[iter_8_0] or SectionAttributeItem.New(self.attributeGo_, self.attributeContentTrans_)

			self.attributeItemList_[iter_8_0]:SetData(iter_8_1)
		end

		for iter_8_2 = #var_8_0 + 1, #self.attributeItemList_ do
			self.attributeItemList_[iter_8_2]:Show(false)
		end
	else
		SetActive(self.attributePanelGo_, false)
	end
end

function SectionStageInfoView:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function SectionStageInfoView:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.attributeItemList_) do
		iter_10_1:Dispose()
	end

	self.attributeItemList_ = nil

	SectionStageInfoView.super.Dispose(self)
end

return SectionStageInfoView
