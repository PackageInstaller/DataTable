local SummerStoryMainItem = class("SummerStoryMainItem", ReduxView)

function SummerStoryMainItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function SummerStoryMainItem:OnEnter()
	self:RefreshUI()
end

function SummerStoryMainItem:OnExit()
	return
end

function SummerStoryMainItem:Dispose()
	SummerStoryMainItem.super.Dispose(self)
end

function SummerStoryMainItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		self:Go("/summerStageMain", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = self.chapterID_
		})
	end)
end

function SummerStoryMainItem:RefreshUI()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(StoryStageActivityData:GetStageData(self.chapterID_)) do
		if iter_7_1.clear_times > 0 then
			var_7_0 = var_7_0 + 1
		end
	end

	self.progressText_.text = string.format("%d%%", var_7_0 / #ActivityStoryChapterCfg[self.chapterID_].stage_list * 100)
	self.slider_.fillAmount = var_7_0 / #ActivityStoryChapterCfg[self.chapterID_].stage_list

	if var_7_0 / #ActivityStoryChapterCfg[self.chapterID_].stage_list < 1 then
		self.controller_:SetSelectedState("enter")
	else
		self.controller_:SetSelectedState("false")
	end
end

return SummerStoryMainItem
