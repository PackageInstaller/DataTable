local LetterBoxListItem = class("LetterBoxListItem", ReduxView)

function LetterBoxListItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function LetterBoxListItem:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListener()
end

function LetterBoxListItem:InitUI()
	self:BindCfgUI()

	self.posController_ = ControllerUtil.GetController(self.transform_, "pos")
	self.readController_ = ControllerUtil.GetController(self.transform_, "read")
end

function LetterBoxListItem:AddUIListener()
	self:AddBtnListener(self.normalBtn_, nil, function()
		if self.handler_ ~= nil then
			self:handler_()
		end
	end)
end

function LetterBoxListItem:AddEventListener()
	self:RegistEventListener(LETTER_READ_UPDATE, handler(self, self.OnLetterReadUpdate))
end

function LetterBoxListItem:OnLetterReadUpdate(arg_7_1)
	if arg_7_1 == self.data_.id then
		self:UpdateView()
	end
end

function LetterBoxListItem:UpdateView()
	local var_8_0 = string.split(self.data_.send_time, ",")

	self.yearText_.text = var_8_0[1]
	self.monthText_.text = string.format("%02d", var_8_0[2])
	self.dayText_.text = var_8_0[3]

	self.readController_:SetSelectedState(self.data_.isViewed and "read" or "unread")

	self.titleText_.text = GetI18NText(self.data_.title)
end

function LetterBoxListItem:SetData(arg_9_1, arg_9_2)
	self.data_ = arg_9_2

	self.posController_:SetSelectedState(arg_9_1 % 2 == 1 and "down" or "up")
	self:UpdateView()
	self:BindRedPoint()
end

function LetterBoxListItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.noticePos_, RedPointConst.LETTER_ID .. self.data_.id)
end

function LetterBoxListItem:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.noticePos_)
end

function LetterBoxListItem:GetData()
	return self.data_
end

function LetterBoxListItem:OnEnter()
	return
end

function LetterBoxListItem:OnExit()
	return
end

function LetterBoxListItem:Dispose()
	self:UnBindRedPoint()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	LetterBoxListItem.super.Dispose(self)
end

return LetterBoxListItem
