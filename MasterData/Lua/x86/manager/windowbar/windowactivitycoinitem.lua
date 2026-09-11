local WindowActivityCoinItem = class("WindowActivityCoinItem", import("game.extend.ReduxView"))

function WindowActivityCoinItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.currencyType_ = arg_1_2

	self:Init()
end

function WindowActivityCoinItem:Init()
	self:InitUI()
	self:AddListeners()
	self:RefreshUI()

	self.isCanAdd_ = true
	self.isCanClick_ = false
	self.type_ = "black"
end

function WindowActivityCoinItem:InitUI()
	self:BindCfgUI()

	self.typeSet_ = {
		"black",
		"hyaline"
	}
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
end

function WindowActivityCoinItem:AddListeners()
	self:AddBtnListener(nil, nil, "OnClick")
	self:AddBtnListener(self.buttonIcon_, nil, function()
		manager.notify:Invoke(WINDOW_BAR_INFO, self.currencyType_, self.gameObject_)
		self:OnClick()
	end)
end

function WindowActivityCoinItem:OnClick()
	if self.materialType_ then
		ShowPopItem(POP_SOURCE_ITEM, {
			self.materialType_
		})
	end
end

function WindowActivityCoinItem:SetCanAdd(arg_7_1)
	if self.isCanAdd_ == arg_7_1 then
		return
	end

	self.isCanAdd_ = arg_7_1

	SetActive(self.add_, arg_7_1)
end

function WindowActivityCoinItem:SetCanClick(arg_8_1)
	self.isCanClick_ = arg_8_1
end

function WindowActivityCoinItem:SetType(arg_9_1)
	if table.indexof(self.typeSet_, arg_9_1) then
		self.type_ = arg_9_1

		self.typeCon_:SetSelectedState(self.type_)
	end
end

function WindowActivityCoinItem:RefreshUI()
	self.materialType_ = nil

	if self.activity_id and ActivityCfg[self.activity_id] and ActivityTools.GetActivityType(self.activity_id) == ActivityTemplateConst.ACTIVITY_PUSH_BOX then
		local var_10_0 = PushBoxTool:GetFatigueID(self.activity_id)

		self.icon_.sprite = ItemTools.getItemLittleSprite(var_10_0)
		self.text_.text = ActivityPushBoxData:GetFatigue(self.activity_id) .. "/" .. PushBoxTool:GetFatigueMax(self.activity_id)
		self.materialType_ = var_10_0

		return
	end

	self.icon_.sprite = nil
	self.text_.text = ""
end

function WindowActivityCoinItem:SetActivityId(arg_11_1)
	self.activity_id = arg_11_1

	self:RefreshUI()
end

function WindowActivityCoinItem:SetActive(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)

	if arg_12_1 then
		self:RegistEventListener(ACTIVITY_ICON_CHANGE, handler(self, self.RefreshUI))
		self:RefreshUI()
		self.transform_:SetAsLastSibling()
	else
		self:RemoveAllEventListener()
	end
end

function WindowActivityCoinItem:UnBindListener()
	self:RemoveAllEventListener()
end

function WindowActivityCoinItem:Dispose()
	WindowActivityCoinItem.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return WindowActivityCoinItem
