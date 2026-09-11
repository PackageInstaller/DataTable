local ActivityMatrixStoryReviewItem = class("ActivityMatrixStoryReviewItem", ReduxView)

function ActivityMatrixStoryReviewItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivityMatrixStoryReviewItem:Init()
	self:InitUI()
end

function ActivityMatrixStoryReviewItem:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, ActivityMatrixStoryReviewTalkItem)
end

function ActivityMatrixStoryReviewItem:GetHeight()
	return self.hight or 0
end

function ActivityMatrixStoryReviewItem:SetData(arg_5_1)
	local var_5_0 = _G["Story" .. arg_5_1]
	local var_5_1 = 0

	if _G["Story" .. arg_5_1] and var_5_0.narrativeData then
		self.talks = var_5_0.narrativeData
		var_5_1 = #self.talks
	end

	self.list:StartScroll(var_5_1)

	self.hight = var_5_1 == 0 and 369.18 or 169.18 + 100 * var_5_1
	self.transform_.sizeDelta = Vector2.New(self.transform_.rect.width, self.hight)
	self.m_title.text = StoryCfg[arg_5_1] and GetI18NText(StoryCfg[arg_5_1].name) or ""
	self.m_des.text = var_5_0 and var_5_0.narrativeTime and GetI18NText(StoryWordCfg[var_5_0.narrativeTime].content) or ""
end

function ActivityMatrixStoryReviewItem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)

	if not arg_6_1 then
		self.hight = 0
	end
end

function ActivityMatrixStoryReviewItem:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.talks[arg_7_1])
end

function ActivityMatrixStoryReviewItem:Dispose()
	self.list:Dispose()
	ActivityMatrixStoryReviewItem.super.Dispose(self)
end

return ActivityMatrixStoryReviewItem
