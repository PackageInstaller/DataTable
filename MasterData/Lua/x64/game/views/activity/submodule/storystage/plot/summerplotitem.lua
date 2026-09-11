local SummerPlotItem = class("SummerPlotItem", ReduxView)

function SummerPlotItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "Item")
end

function SummerPlotItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if not self.isLock_ then
			WarChessAction.SetActivityChessPlotRedPoint(ActivityConst.THEME.SUMMER, self.storyID_)
			manager.story:StartStoryById(self.storyID_, function()
				return
			end)
		end
	end)
end

function SummerPlotItem:Dispose()
	SummerPlotItem.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER, self.storyID_))
end

function SummerPlotItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_3 < arg_6_2

	if arg_6_3 < arg_6_2 then
		self.controller_:SetSelectedState("lock")

		self.nameText_.text = string.format(GetTips("EXPLORE_UNLOCK"), arg_6_2)
	else
		self.controller_:SetSelectedState("false")

		self.nameText_.text = GetI18NText(StoryCfg[arg_6_1].name)
	end

	self.storyID_ = arg_6_1
	self.isLock_ = var_6_0

	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER, self.storyID_))
end

return SummerPlotItem
