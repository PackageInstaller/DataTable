local SummerChessBoardExloreNoteToggle = class("SummerChessBoardExloreNoteToggle", ReduxView)

function SummerChessBoardExloreNoteToggle:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.index_ = arg_1_3
	self.text_.text = arg_1_3

	SetActive(self.gameObject_, true)

	self.taskUpdateHandler_ = handler(self, self.TaskUpdate)
end

function SummerChessBoardExloreNoteToggle:Dispose()
	self.taskUpdateHandler_ = nil

	SummerChessBoardExloreNoteToggle.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SummerChessBoardExloreNoteToggle:AddListeners()
	self:AddToggleListener(self.toggle_, function(arg_4_0)
		manager.notify:Invoke(SUMMER_CHESS_BOARD_EXPLORE_NOTE_SWITCH, self.index_)
		ActivitySummerChessBoardAction.ReadExploreNoteNewText(self.taskIDList_)
	end)
end

function SummerChessBoardExloreNoteToggle:IsOn(arg_5_1)
	self.toggle_.isOn = arg_5_1

	if arg_5_1 then
		ActivitySummerChessBoardAction.ReadExploreNoteNewText(self.taskIDList_)
		self:RefreshRedPoint()
	end
end

function SummerChessBoardExloreNoteToggle:OnEnter(arg_6_1)
	manager.notify:RegistListener(ON_TASK_SUBMIT_RESPONSE, self.taskUpdateHandler_)

	self.taskIDList_ = arg_6_1

	self:RefreshRedPoint()
end

function SummerChessBoardExloreNoteToggle:OnExit()
	manager.notify:RemoveListener(ON_TASK_SUBMIT_RESPONSE, self.taskUpdateHandler_)

	self.taskIDList_ = {}
end

function SummerChessBoardExloreNoteToggle:TaskUpdate()
	self:RefreshRedPoint()
end

function SummerChessBoardExloreNoteToggle:NeedRedPoint()
	if self.toggle_.isOn then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(self.taskIDList_) do
		if iter_9_1 == 1 then
			if manager.redPoint:getTipValue(RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO) > 0 then
				return true
			end
		elseif manager.redPoint:getTipValue((string.format("%s_%s", RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE, iter_9_1))) > 0 then
			return true
		end
	end

	return false
end

function SummerChessBoardExloreNoteToggle:RefreshRedPoint()
	if self:NeedRedPoint() then
		SetActive(self.noticeGo_, true)
	else
		SetActive(self.noticeGo_, false)
	end
end

return SummerChessBoardExloreNoteToggle
