local DrawHeroSelectView = class("DrawHeroSelectView", ReduxView)

function DrawHeroSelectView:UIName()
	return "Widget/System/Pool/PoolSelectPopUI"
end

function DrawHeroSelectView:UIParent()
	return manager.ui.uiMain.transform
end

function DrawHeroSelectView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DrawHeroSelectView:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.m_controller, "select")
end

function DrawHeroSelectView:AddUIListener()
	self:AddBtnListener(self.m_leftBtn, nil, function()
		self:SetSelect(1)
	end)
	self:AddBtnListener(self.m_rightBtn, nil, function()
		self:SetSelect(2)
	end)
	self:AddBtnListener(self.m_sureBtn, nil, function()
		if self.optional_lists[self.select] then
			if DrawData:GetPollUpID(self.poolId) ~= self.optional_lists[self.select] then
				DrawAction.SetPollUpID(self.poolId, self.optional_lists[self.select])
			else
				self:Back()
			end
		else
			error("DrawHeroSelectView with empty pool up id")
		end
	end)
end

function DrawHeroSelectView:OnTop()
	manager.windowBar:SwitchBar({})
end

function DrawHeroSelectView:OnSetPollUpID(arg_10_1, arg_10_2)
	self:Back()
end

function DrawHeroSelectView:OnEnter()
	self:SetSelect(0)

	self.poolId = self.params_.poolId
	self.cfg = DrawPoolCfg[self.poolId]

	if self.optional_lists ~= self.cfg.optional_lists_poolId then
		self.optional_lists = self.cfg.optional_lists_poolId

		self:CreatOptionalHeroCom()
	elseif self.leftCom == nil or self.rightCom == nil then
		self:CreatOptionalHeroCom()
	end

	local var_11_0 = table.indexof(self.optional_lists, (DrawData:GetPollUpID(self.poolId)))

	var_11_0 = var_11_0 or 0

	self:SetSelect(var_11_0)
end

function DrawHeroSelectView:CreatOptionalHeroCom()
	if self.leftCom then
		Object.Destroy(self.leftCom)
	end

	if self.rightCom then
		Object.Destroy(self.rightCom)
	end

	local var_12_0 = self.cfg.optional_detail

	self.leftCom = Object.Instantiate(Asset.Load("UI/Draw/SelectUp/select_" .. self.cfg.optional_detail[1]), self.m_leftContent)
	self.rightCom = Object.Instantiate(Asset.Load("UI/Draw/SelectUp/select_" .. var_12_0[2]), self.m_rightContent)
end

function DrawHeroSelectView:SetSelect(arg_13_1)
	self.select = arg_13_1

	self.selectController:SetSelectedIndex(arg_13_1)

	self.m_sureBtn.interactable = arg_13_1 ~= 0
end

function DrawHeroSelectView:OnExit()
	manager.windowBar:HideBar()
end

function DrawHeroSelectView:Dispose()
	self.leftCom = nil
	self.rightCom = nil

	DrawHeroSelectView.super.Dispose(self)
end

return DrawHeroSelectView
