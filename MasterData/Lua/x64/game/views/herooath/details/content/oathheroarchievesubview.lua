local OathHeroArchieveSubView = class("OathHeroArchieveSubView", BaseView)

function OathHeroArchieveSubView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.parent = nullable(arg_1_2, "parentView")

	self:BindCfgUI()

	self.items = {}
	self.unlockController = self.controllers_:GetController("unlock")
	self.playStateController = self.controllers_:GetController("isPlaying")

	function self:onClickTabItemHandler()
		self:SwitchTab(self.itemIndex, true)
	end

	self:AddBtnListener(self.playBtn_, nil, function()
		if self.items[self.curSelect].lockState or self.items[self.curSelect].voiceID == nil or self:GetCurPlayingVoice() == self.items[self.curSelect].voiceID then
			self:StopVoice()
		else
			self:PlayVoice(self.items[self.curSelect].voiceID)
		end
	end)
end

function OathHeroArchieveSubView:OnEnter()
	SetActive(self.gameObject_, true)
end

function OathHeroArchieveSubView:OnExit()
	self.curSelect = nil

	self:StopVoice()
	SetActive(self.gameObject_, false)
end

function OathHeroArchieveSubView:Dispose()
	self:RemoveAllListeners()

	if self.items then
		for iter_6_0, iter_6_1 in pairs(self.items) do
			Object.Destroy(iter_6_1.gameObject_)
			iter_6_1:Dispose()
		end
	end

	self.items = nil
end

local OathArchieveTabItem = class("OathArchieveTabItem", BaseView)

OathHeroArchieveSubView.Item = OathArchieveTabItem

function OathArchieveTabItem:Ctor(arg_7_1)
	self.gameObject_ = arg_7_1
	self.transform_ = arg_7_1.transform

	self:Init()
end

function OathArchieveTabItem:Init()
	self:BindCfgUI()

	self.lockController = self.linktabitemControllerEx_:GetController("lock")
	self.selectController = self.linktabitemControllerEx_:GetController("select")
	self.bgController = self.linktabitemControllerEx_:GetController("bg")

	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.onClick then
			self:onClick()
		end
	end)
	self:SetLockState(false)
	self:SetSelectState(false)
end

function OathArchieveTabItem:Dispose()
	self:RemoveAllListeners()
	OathArchieveTabItem.super.Dispose(self)
end

function OathArchieveTabItem:SetData(arg_11_1, arg_11_2, arg_11_3)
	self.itemIndex = arg_11_2
	self.onClick = arg_11_3
	self.titleText_.text = GetTips(string.format("WEDDING_CONTENT_RECORD%d_TITLE", arg_11_2))
	self.voiceID = nullable(WeddingCfg, arg_11_1, "wedding_record_voice" .. arg_11_2)
end

function OathArchieveTabItem:SetLockState(arg_12_1)
	self.lockState = arg_12_1

	self.lockController:SetSelectedState(arg_12_1 and "lock" or "unlock")
end

function OathArchieveTabItem:SetSelectState(arg_13_1)
	self.selectController:SetSelectedState(arg_13_1 and "select" or "cancel")
end

function OathArchieveTabItem:SetBgState(arg_14_1)
	self.bgController:SetSelectedState(arg_14_1)
end

function OathArchieveTabItem:SetIsShow(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
end

function OathHeroArchieveSubView:GetHeroID()
	return self.curHeroID
end

local function var_0_2(arg_17_0, arg_17_1)
	for iter_17_0 = arg_17_0.list_.childCount + 1, arg_17_1 do
		local var_17_0 = Object.Instantiate(arg_17_0.itemPrefab_, arg_17_0.list_)
	end

	for iter_17_1 = 1, arg_17_0.list_.childCount do
		arg_17_0.items[iter_17_1] = arg_17_0.items[iter_17_1] or OathHeroArchieveSubView.Item.New(arg_17_0.list_:GetChild(iter_17_1 - 1).gameObject)

		arg_17_0.items[iter_17_1]:SetIsShow(iter_17_1 <= arg_17_1)
	end
end

function OathHeroArchieveSubView:RefreshUI(arg_18_1)
	self.curHeroID = arg_18_1

	var_0_2(self, HeroConst.HERO_OATH_STORY_MAX_COUNT)

	for iter_18_0 = 1, HeroConst.HERO_OATH_STORY_MAX_COUNT do
		self.items[iter_18_0]:SetData(arg_18_1, iter_18_0, self.onClickTabItemHandler)
		self.items[iter_18_0]:SetBgState("oath")
		self.items[iter_18_0]:SetLockState(not IsConditionAchieved(nullable(WeddingCfg, arg_18_1, string.format("record%d_condition", iter_18_0)) or 0))
	end

	self:SwitchTab(self.curSelect or 1)
	self:UpdateVoicePlayStatus()
end

function OathHeroArchieveSubView:RefreshTabStyle()
	if self.items == nil then
		return
	end

	for iter_19_0, iter_19_1 in ipairs(self.items) do
		iter_19_1:SetSelectState(iter_19_1.itemIndex == self.curSelect)
	end
end

function OathHeroArchieveSubView:SwitchTab(arg_20_1)
	self:StopVoice()

	self.curSelect = arg_20_1
	self.title_.text = self.items[arg_20_1].titleText_.text
	self.voiceTitle_.text = GetTipsF("WEDDING_RECORD_TIPS1", arg_20_1)

	if self.items[arg_20_1].lockState then
		self.unlockController:SetSelectedState("false")

		self.lockTipsText_.text = nullable(ConditionCfg, nullable(WeddingCfg, self:GetHeroID(), string.format("record%d_condition", arg_20_1)) or 0, "desc") or ""
	else
		self.unlockController:SetSelectedState("true")

		self.detailText_.text = nullable(WeddingCfg, self:GetHeroID(), "wedding_record" .. arg_20_1)
	end

	self:RefreshTabStyle()
end

function OathHeroArchieveSubView:GetCurPlayingVoice()
	if self.parent then
		return self.parent:IsPlaying()
	end

	return nil
end

function OathHeroArchieveSubView:PlayVoice(arg_22_1)
	if self.parent then
		self.parent:PlayVoice(arg_22_1, function()
			self:UpdateVoicePlayStatus()
		end)
	end

	self:UpdateVoicePlayStatus()
end

function OathHeroArchieveSubView:StopVoice()
	if self.parent then
		self.parent:StopVoice()
	end

	self:UpdateVoicePlayStatus()
end

function OathHeroArchieveSubView:UpdateVoicePlayStatus()
	if self:GetCurPlayingVoice() then
		self.playStateController:SetSelectedState("true")
	else
		self.playStateController:SetSelectedState("false")
	end
end

return OathHeroArchieveSubView
