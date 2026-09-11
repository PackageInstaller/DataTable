local T0CapturePoseItem = class("T0CapturePoseItem", ReduxView)

function T0CapturePoseItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function T0CapturePoseItem:Init()
	self:InitUI()
end

function T0CapturePoseItem:InitUI()
	self:BindCfgUI()
	self:AddListener()

	self.controller = self.controllerEx_:GetController("state")
end

function T0CapturePoseItem:AddListener()
	self:AddBtnListener(self.button_, nil, function()
		self:OnPoseItemClick()
	end)
end

function T0CapturePoseItem:Render(arg_6_1)
	self.switchID = arg_6_1

	local var_6_0 = T0WorldCaptureSwitchCfg[arg_6_1]

	self.name_.text = GetI18NText(T0WorldCaptureSwitchCfg[arg_6_1].title)

	if T0WorldMgr:GetUseSettingByType(var_6_0.switchType) == self.switchID then
		self.controller:SetSelectedState("select")
	else
		self.controller:SetSelectedState("false")
	end

	if var_6_0.switchType == T0WorldMgr.SwitchTypeEnum.Filter then
		self.filterImg_.sprite = T0WorldTools.GetFilterImg(var_6_0.lensPicture)
	end
end

function T0CapturePoseItem:OnPoseItemClick()
	local var_7_0 = T0WorldCaptureSwitchCfg[self.switchID]

	if T0WorldMgr:GetUseSettingByType(T0WorldCaptureSwitchCfg[self.switchID].switchType) == self.switchID then
		return
	end

	if var_7_0.switchType == T0WorldMgr.SwitchTypeEnum.Face then
		T0WorldMgr:SetCaptureSwitch(self.switchID)
	else
		manager.transition:OnlyShowEffect(true, function()
			T0WorldMgr:SetCaptureSwitch(self.switchID)
			manager.transition:OnlyShowEffect(false)
		end)
	end

	if var_7_0.voice == "" then
		return
	end

	HeroTools.PlaySkinTalk(T0WorldMgr:GetHeroID(), var_7_0.voice, nil, T0WorldMgr:GetCaptureModel())
end

function T0CapturePoseItem:Dispose()
	T0CapturePoseItem.super.Dispose(self)
end

return T0CapturePoseItem
