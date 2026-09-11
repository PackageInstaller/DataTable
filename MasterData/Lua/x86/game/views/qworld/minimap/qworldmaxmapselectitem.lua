local QWorldMaxMapSelectItem = class("QWorldMaxMapSelectItem", ReduxView)

function QWorldMaxMapSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
	self:AddListeners()
end

function QWorldMaxMapSelectItem:Init()
	self:BindCfgUI()

	self.IconTypeController = self.iconState_:GetController("type")
end

function QWorldMaxMapSelectItem:AddListeners()
	self:AddBtnListener(self.choiceBtn_, nil, function()
		if self.callback_ then
			self.callback_(self.entityId)
		end
	end)
end

function QWorldMaxMapSelectItem:SetData(arg_5_1, arg_5_2)
	self.entityId = arg_5_1
	self.board = arg_5_2
	self.choiceTxt_.text = self.board:GetName()

	local var_5_0, var_5_1 = arg_5_2:GetIcon()

	self.IconTypeController:SetSelectedIndex(var_5_1)

	self.iconImg_.sprite = pureGetSpriteWithoutAtlas(var_5_0)

	print("ddddddd", arg_5_1)
	print_r(arg_5_2)
end

function QWorldMaxMapSelectItem:RegistCallBack(arg_6_1)
	self.callback_ = arg_6_1
end

return QWorldMaxMapSelectItem
