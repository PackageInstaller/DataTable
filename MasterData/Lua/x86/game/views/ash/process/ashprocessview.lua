local AshProcessView = class("AshProcessView", ReduxView)

function AshProcessView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/Activity_EkChuah_illustratedUI"
end

local var_0_1 = {
	PLOT = 1,
	ILL = 2
}

function AshProcessView:UIParent()
	return manager.ui.uiMain.transform
end

function AshProcessView:GetCustomScene()
	return HeroRaiseTrackConst.CustomScene.Cowboy
end

function AshProcessView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AshProcessView:OnAshAvgEnd()
	local var_5_0 = self:GetCustomSceneController()

	if var_5_0 then
		var_5_0:OnInit()
	end

	self:OnEnter()
	self:OnTop()
end

function AshProcessView:InitUI()
	self:BindCfgUI()

	self.context = {
		page = {
			[var_0_1.ILL] = nil,
			[var_0_1.PLOT] = nil
		},
		pageScript = {
			[var_0_1.ILL] = AshIllustratedPanel,
			[var_0_1.PLOT] = AshPlotPanel
		},
		pageContainer = {
			[var_0_1.ILL] = self.illTrans_,
			[var_0_1.PLOT] = self.plotTrans_
		},
		pageState = {
			[var_0_1.ILL] = "IllustratedPanel",
			[var_0_1.PLOT] = "plotPanel"
		}
	}
	self.controller = self.controllerEx_:GetController("panelSwitch")
end

function AshProcessView:AddUIListeners()
	self:AddBtnListener(self.plotBtn_, nil, function()
		self:SwitchPage(var_0_1.PLOT)
	end)
	self:AddBtnListener(self.illBtn_, nil, function()
		self:SwitchPage(var_0_1.ILL)
	end)
end

function AshProcessView:SwitchPage(arg_10_1, arg_10_2)
	local var_10_0 = self.context.curPage
	local var_10_1

	if self.context.curPage == nil then
		var_10_1 = arg_10_1
	else
		if self.context.curPage ~= arg_10_1 then
			var_10_1 = arg_10_1
		end

		if arg_10_2 then
			var_10_1 = arg_10_1
		end
	end

	if var_10_0 and var_10_1 and var_10_0 ~= var_10_1 then
		self.context.page[var_10_0]:ExitPanel(self)
	end

	if var_10_1 then
		self.context.page[var_10_1] = self.context.page[var_10_1] or self.context.pageScript[var_10_1].New(self.context.pageContainer[var_10_1])
		self.context.curPage = var_10_1

		self.context.page[var_10_1]:EnterPanel(self)
		self.controller:SetSelectedState(self.context.pageState[var_10_1])
	end
end

function AshProcessView:OnEnter()
	if AshSystemData:GetStoryState() then
		return
	end

	manager.ui.mainCamera:GetComponent("CameraExtension").shadowRotationImmediately = true

	local var_11_0 = self:GetCustomSceneController()

	var_11_0:CloseCutScene()

	if var_11_0.SwitchBgState then
		var_11_0:SwitchBgState(1)
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:GetCustomSceneController():ShowCutScene(function()
			self:Back()
		end)
	end)
	self:SwitchPage(var_0_1.PLOT, true)
end

function AshProcessView:OnTop()
	if AshSystemData:GetStoryState() then
		return
	end

	self:SwitchPage(self.context.curPage, true)

	local var_14_0 = self:GetCustomSceneController()

	if var_14_0.SwitchBgState then
		var_14_0:SwitchBgState(1)
	end
end

function AshProcessView:OnExit()
	manager.windowBar:HideBar()
end

function AshProcessView:Dispose()
	for iter_16_0, iter_16_1 in pairs(var_0_1) do
		if self.context.page[iter_16_1] then
			self.context.page[iter_16_1]:Dispose()

			self.context.page[iter_16_1] = nil
		end
	end

	self.super.Dispose(self)
end

return AshProcessView
