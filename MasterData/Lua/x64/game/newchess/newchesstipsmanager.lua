local NewChessTipsManager = class("NewChessTipsManager")

function NewChessTipsManager:Ctor()
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/NewWarChess/NewWarChessTipsManager"), manager.ui.canvas.transform)

	ComponentBinder.GetInstance():BindCfgUI(self, self.gameObject_)

	self.tipsItems_ = {}
	self.tipsDispose_ = handler(self, self.OnTipsDispose)
end

function NewChessTipsManager:CreateTips(arg_2_1)
	for iter_2_0, iter_2_1 in pairs(self.tipsItems_) do
		if not iter_2_1:GetIsShow() then
			iter_2_1:SetData(arg_2_1)
			iter_2_1:SetIsShow(true)
			LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)

			return
		end
	end

	local var_2_0 = NewChessTipsItem.New((GameObject.Instantiate(self.tipsGo_, self.contentTrans_)))

	var_2_0:SetDisposeHandler(self.tipsDispose_)
	var_2_0:SetData(arg_2_1)
	var_2_0:SetIsShow(true)
	table.insert(self.tipsItems_, var_2_0)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)
end

function NewChessTipsManager:OnTipsDispose(arg_3_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)
end

function NewChessTipsManager:Dispose()
	for iter_4_0, iter_4_1 in pairs(self.tipsItems_) do
		iter_4_1:Dispose()
	end

	self.tipsItems_ = {}
	self.tipsDispose_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
end

return NewChessTipsManager
