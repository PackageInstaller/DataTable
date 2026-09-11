local PopFukubukuroSelectView = class("PopFukubukuroSelectView", ReduxView)

function PopFukubukuroSelectView:UIName()
	return "Widget/Common/Pop/UIInquirepopup14"
end

function PopFukubukuroSelectView:UIParent()
	return manager.ui.uiPop.transform
end

function PopFukubukuroSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PopFukubukuroSelectView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.uiList_, CommonItemView)
	self.okBtnController_ = self.controllerEx_:GetController("btn")
end

function PopFukubukuroSelectView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		if self.selectIndex_ == 0 then
			ShowTips("LUCKILYBAG_NOT_SELECT")
		else
			self:Back()
			FukubukuroAction.QuseryUseItem(self.instance_id, self.selectIndex_)
		end
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
end

function PopFukubukuroSelectView:OnEnter()
	self.instance_id = self.params_.instance_id

	self:SetSelectIndex(0)

	local var_9_0 = FukubukuroData:GetFukubukuroByInstanceId(self.instance_id)

	if var_9_0 then
		self.select_list = var_9_0.select_list

		self.scrollHelper_:StartScroll(#self.select_list)
	else
		self.scrollHelper_:StartScroll(0)
	end
end

function PopFukubukuroSelectView:SetSelectIndex(arg_10_1)
	self.selectIndex_ = arg_10_1

	if self.selectIndex_ ~= 0 then
		self.tipText_.text = string.format(GetTips("TIP_SELECT"), ItemTools.getItemName(self.select_list[arg_10_1].id))

		self.okBtnController_:SetSelectedState("state1")
	else
		self.tipText_.text = GetTips("SELECT_CURRENT")

		self.okBtnController_:SetSelectedState("state0")
	end
end

function PopFukubukuroSelectView:Dispose()
	self.scrollHelper_:Dispose()
	PopFukubukuroSelectView.super.Dispose(self)
end

function PopFukubukuroSelectView:indexItem(arg_12_1, arg_12_2)
	local var_12_0 = clone(ItemTemplateData)

	var_12_0.id = self.select_list[arg_12_1].id
	var_12_0.number = self.select_list[arg_12_1].number
	var_12_0.selectStyle = arg_12_1 == self.selectIndex_

	function var_12_0.clickFun()
		self:ItemClick(arg_12_1)
	end

	arg_12_2:SetData(var_12_0)
end

function PopFukubukuroSelectView:ItemClick(arg_14_1)
	self:SetSelectIndex(arg_14_1)
	self.scrollHelper_:Refresh()
end

return PopFukubukuroSelectView
