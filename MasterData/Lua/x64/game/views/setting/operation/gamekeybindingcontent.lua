local GameKeyBindingContent = class("GameKeyBindingContent", ReduxView)

function GameKeyBindingContent:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function GameKeyBindingContent:Init()
	self:InitUI()

	self.items_ = {}
end

function GameKeyBindingContent:InitUI()
	self:BindCfgUI()
	SetActive(self.templateItem_, false)
end

function GameKeyBindingContent:IndexItem(arg_4_1, arg_4_2)
	arg_4_2:SetData(self.layoutName_, self.groupData_.items[arg_4_1], self.gamepadType_, self.controlType_)
	arg_4_2:RefreshUI()
	arg_4_2:SetKeyChangedCallback(function(arg_5_0, arg_5_1)
		arg_5_1.controlType = self.groupData_.controlType
		arg_5_1.conflictGroup = self.groupData_.conflictGroup

		if self.onKeyChanged_ then
			self:onKeyChanged_(arg_5_0, arg_5_1)
		end
	end)
end

function GameKeyBindingContent:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.layoutName_ = arg_6_1
	self.title_ = arg_6_2
	self.groupData_ = arg_6_3
	self.gamepadType_ = arg_6_4
	self.controlType_ = arg_6_3.controlType
end

function GameKeyBindingContent:SetKeyChangedCallback(arg_7_1)
	self.onKeyChanged_ = arg_7_1
end

function GameKeyBindingContent:OnExit()
	for iter_8_0, iter_8_1 in ipairs(self.items_) do
		iter_8_1:OnExit()
	end
end

function GameKeyBindingContent:Dispose()
	for iter_9_0, iter_9_1 in ipairs(self.items_) do
		iter_9_1:Dispose()
	end

	self.super.Dispose(self)
end

function GameKeyBindingContent:RefreshUI()
	local var_10_0 = #self.groupData_.items

	SetActive(self.gameObject_, #self.groupData_.items ~= 0)

	if var_10_0 == 0 then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(self.items_) do
		SetActive(iter_10_1.gameObject_, iter_10_0 <= var_10_0)
	end

	for iter_10_2 = 1, var_10_0 do
		local var_10_1 = self.items_[iter_10_2]

		if not self.items_[iter_10_2] then
			local var_10_2 = Object.Instantiate(self.templateItem_, self.contentTrans_)

			SetActive(var_10_2, true)

			var_10_1 = GameKeyBindingItem.New(var_10_2)
			self.items_[iter_10_2] = var_10_1
		end

		self:IndexItem(iter_10_2, var_10_1)
	end
end

return GameKeyBindingContent
