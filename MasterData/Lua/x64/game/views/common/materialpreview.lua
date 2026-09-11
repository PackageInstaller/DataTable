local MaterialPreview = class("MaterialPreview", ReduxView)

function MaterialPreview:UIName()
	return "Widget/Common/Pop/ReturnmaterialpopUI"
end

function MaterialPreview:UIParent()
	return manager.ui.uiPop.transform
end

function MaterialPreview:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.itemListGo_, CommonItemView)
end

function MaterialPreview:Init()
	self:InitUI()
	self:AddUIListener()
end

function MaterialPreview:indexItem(arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = self.itemList_[arg_5_1].id
	var_5_0.number = self.itemList_[arg_5_1].number

	function var_5_0:clickFun()
		ShowPopItem(POP_ITEM, {
			self.id
		})
	end

	arg_5_2:SetData(var_5_0)
end

function MaterialPreview:OnEnter()
	self.textText_.text = GetI18NText(self.params_.content)

	self:UpdateData()
	self.scrollHelper_:StartScroll(#self.itemList_)
end

function MaterialPreview:OnExit()
	return
end

function MaterialPreview:UpdateData()
	self.itemList_ = {}

	for iter_9_0, iter_9_1 in ipairs(self.params_.itemList) do
		table.insert(self.itemList_, {
			id = iter_9_1[1],
			number = iter_9_1[2]
		})
	end
end

function MaterialPreview:AddUIListener()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.cancelbtnBtn_, nil, function()
		JumpTools.Back()
	end)
	self:AddBtnListener(self.okbtnBtn_, nil, function()
		self.params_.OkCallback()
		self:Back()
	end)
end

function MaterialPreview:Dispose()
	self.scrollHelper_:Dispose()
	self:RemoveAllListeners()
	MaterialPreview.super.Dispose(self)
end

return MaterialPreview
