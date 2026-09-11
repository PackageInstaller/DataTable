local MedalItem = class("MedalItem", ReduxView)

function MedalItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function MedalItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MedalItem:InitUI()
	self:BindCfgUI()

	self.usedController_ = ControllerUtil.GetController(self.transform_, "used")
	self.lockController_ = ControllerUtil.GetController(self.transform_, "lock")
end

function MedalItem:AddUIListener()
	self:AddBtnListener(self.Btn_, nil, function()
		ShowPopItem(POP_SOURCE_DES_ITEM, {
			self.info_.id
		})
	end)
end

function MedalItem:OnEnter()
	return
end

function MedalItem:RefreshItem(arg_7_1)
	self.info_ = arg_7_1
	self.icon_.sprite = ItemTools.getItemSprite(self.info_.id)
	self.unlock_ = self.info_.unlock
	self.text_.text = ItemTools.getItemName(self.info_.id)

	self:RefreshState()
	manager.redPoint:unbindUIandKey(self.redPoint_)
end

function MedalItem:RegisterClickListener(arg_8_1)
	self.onClickFunc_ = arg_8_1
end

function MedalItem:RefreshState()
	self.lockController_:SetSelectedState(self.unlock_ == 0 and "lock" or "default")
end

function MedalItem:OnExit()
	return
end

function MedalItem:Dispose()
	self:RemoveAllListeners()
	manager.redPoint:unbindUIandKey(self.redPoint_)

	self.onClickFunc_ = nil

	MedalItem.super.Dispose(self)
end

return MedalItem
