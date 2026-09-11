local AbyssListItemView = class("AbyssListItemView", ReduxView)

function AbyssListItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AbyssListItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssListItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.status2Controller_ = ControllerUtil.GetController(self.gameObject_.transform, "status2")
end

function AbyssListItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.onClick_ ~= nil then
			self.onClick_(self.layer_)
		end
	end)
end

function AbyssListItemView:AddEventListeners()
	return
end

function AbyssListItemView:SetData(arg_7_1, arg_7_2, arg_7_3)
	self.index_ = arg_7_1
	self.onClick_ = arg_7_3
	self.cfg_ = AbyssCfg[arg_7_2]
	self.layer_ = self.cfg_.level

	self:UpdateView()
end

function AbyssListItemView:SetSelect(arg_8_1)
	self.statusController_:SetSelectedState(arg_8_1 and "Select" or "normal")
end

function AbyssListItemView:UpdateView()
	self.scoreLabel_.text = AbyssData:GetLayerScore(self.layer_)
	self.layerLabel_.text = string.format(GetTips("ABYSS_LAYER_LABEL"), self.layer_)

	local var_9_0 = AbyssData:GetLayerStatus(self.layer_)

	if var_9_0 == 0 then
		self.status2Controller_:SetSelectedState("lock")
	elseif var_9_0 == 1 then
		self.status2Controller_:SetSelectedState("normal")
	elseif var_9_0 == 2 then
		self.status2Controller_:SetSelectedState("Challenge")
	else
		self.status2Controller_:SetSelectedState("Select")
	end
end

function AbyssListItemView:OnEnter()
	self:AddEventListeners()
end

function AbyssListItemView:OnExit()
	self:RemoveAllEventListener()
end

function AbyssListItemView:OnMainHomeViewTop()
	return
end

function AbyssListItemView:Dispose()
	self.data_ = nil

	AbyssListItemView.super.Dispose(self)
end

return AbyssListItemView
