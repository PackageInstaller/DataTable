local GameOperationSettingView = class("GameOperationSettingView", ReduxView)

function GameOperationSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end
end

function GameOperationSettingView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.info_ = arg_2_3

	self:Init()
end

function GameOperationSettingView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GameOperationSettingView:InitUI()
	self:BindCfgUI()

	self.pageController_ = ControllerUtil.GetController(self.gameObject_.transform, "page")
	self.classes_ = {
		GameMobileOperationView,
		GameGamepadOperationView,
		GameKeyboardOperationView
	}
	self.gameObjects_ = {
		self.mobileGo_,
		self.gamepadGo_,
		self.keyboardGo_
	}
	self.pages_ = {}

	for iter_4_0 = 1, 3 do
		table.insert(self.pages_, (self.classes_[iter_4_0].New(self.gameObjects_[iter_4_0])))
	end

	self.toggles_ = {
		self.toggle1_,
		self.toggle2_,
		self.toggle3_
	}

	self:OnEnter()
end

function GameOperationSettingView:AddUIListener()
	for iter_5_0, iter_5_1 in ipairs(self.toggles_) do
		self:AddToggleListener(iter_5_1, function(arg_6_0)
			if arg_6_0 then
				self:SwitchToPage(iter_5_0)
			end
		end)
	end
end

function GameOperationSettingView:SwitchToPage(arg_7_1)
	self.pageController_:SetSelectedIndex(arg_7_1 - 1)

	for iter_7_0, iter_7_1 in pairs(self.pages_) do
		iter_7_1:UpdatePageData()
	end
end

function GameOperationSettingView:AddEventListeners()
	return
end

function GameOperationSettingView:OnTop()
	self:UpdateBar()
end

function GameOperationSettingView:UpdateBar()
	return
end

function GameOperationSettingView:OnEnter()
	self:AddEventListeners()

	for iter_11_0, iter_11_1 in pairs(self.pages_) do
		iter_11_1:OnEnter()
	end
end

function GameOperationSettingView:OnExit()
	self:RemoveAllEventListener()

	for iter_12_0, iter_12_1 in pairs(self.pages_) do
		iter_12_1:OnExit()
	end
end

function GameOperationSettingView:SaveData()
	if self.pages_ then
		for iter_13_0, iter_13_1 in pairs(self.pages_) do
			iter_13_1:SaveData()
		end
	end
end

function GameOperationSettingView:CheckDataChange()
	if self.pages_ then
		for iter_14_0, iter_14_1 in pairs(self.pages_) do
			if iter_14_1:CheckDataChange() then
				return true
			end
		end
	end

	return false
end

function GameOperationSettingView:RecoverTmpData()
	if self.pages_ then
		for iter_15_0, iter_15_1 in pairs(self.pages_) do
			iter_15_1:RecoverTmpData()
		end
	end
end

function GameOperationSettingView:OnMainHomeViewTop()
	return
end

function GameOperationSettingView:Dispose()
	if self.pages_ then
		for iter_17_0, iter_17_1 in pairs(self.pages_) do
			iter_17_1:Dispose()
		end

		self.pages_ = nil
	end

	GameOperationSettingView.super.Dispose(self)
end

return GameOperationSettingView
