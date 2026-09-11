local LetterBoxRoleItem = class("LetterBoxRoleItem", ReduxView)

function LetterBoxRoleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function LetterBoxRoleItem:Init()
	self:InitUI()
	self:AddUIListener()
	self:AddEventListener()
end

function LetterBoxRoleItem:InitUI()
	self:BindCfgUI()

	self.isSelectedController_ = ControllerUtil.GetController(self.transform_, "isSelected")
end

function LetterBoxRoleItem:AddUIListener()
	self:AddBtnListener(self.normalBtn_, nil, function()
		if self.handler_ ~= nil then
			self:handler_()
		end
	end)
end

function LetterBoxRoleItem:AddEventListener()
	return
end

function LetterBoxRoleItem:UpdateView()
	self.nameText_.text = GetI18NText(self.data_.sender)
	self.headIcon_.sprite = ItemTools.getItemSprite(self.data_.sender_face)

	self.headIcon_:SetNativeSize()
end

function LetterBoxRoleItem:SetSelected(arg_8_1)
	self.isSelectedController_:SetSelectedState(arg_8_1 and "true" or "false")
end

function LetterBoxRoleItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.noticePos_, RedPointConst.LETTER_SENDER_ID .. self.data_.id, {
		x = 0,
		y = 0
	})
end

function LetterBoxRoleItem:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.noticePos_)
end

function LetterBoxRoleItem:SetData(arg_11_1)
	self.data_ = arg_11_1

	self:UpdateView()
	self:BindRedPoint()
end

function LetterBoxRoleItem:GetData()
	return self.data_
end

function LetterBoxRoleItem:OnEnter()
	return
end

function LetterBoxRoleItem:OnExit()
	return
end

function LetterBoxRoleItem:Dispose()
	self:UnBindRedPoint()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	LetterBoxRoleItem.super.Dispose(self)
end

return LetterBoxRoleItem
