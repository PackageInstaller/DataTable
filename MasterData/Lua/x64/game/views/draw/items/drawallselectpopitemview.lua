local DrawAllSelectPopItemView = class("DrawAllSelectPopItemView", ReduxView)

function DrawAllSelectPopItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DrawAllSelectPopItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DrawAllSelectPopItemView:InitUI()
	self:BindCfgUI()
end

function DrawAllSelectPopItemView:AddUIListener()
	return
end

function DrawAllSelectPopItemView:AddEventListeners()
	return
end

function DrawAllSelectPopItemView:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.id_ = arg_6_2

	self:UpdateView()
end

function DrawAllSelectPopItemView:UpdateView()
	return
end

function DrawAllSelectPopItemView:OnEnter()
	self:AddEventListeners()
end

function DrawAllSelectPopItemView:OnExit()
	self:RemoveAllEventListener()
end

function DrawAllSelectPopItemView:OnMainHomeViewTop()
	return
end

function DrawAllSelectPopItemView:Dispose()
	self.data_ = nil

	DrawAllSelectPopItemView.super.Dispose(self)
end

return DrawAllSelectPopItemView
