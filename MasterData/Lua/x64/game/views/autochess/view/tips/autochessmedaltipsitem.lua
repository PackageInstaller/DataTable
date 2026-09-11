local AutoChessMedalTipsItem = class("AutoChessMedalTipsItem", ReduxView)

function AutoChessMedalTipsItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessMedalTipsItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function AutoChessMedalTipsItem:AddUIListeners()
	return
end

function AutoChessMedalTipsItem:InitUI()
	self:BindCfgUI()

	self.iconController1001_ = self.controller1001_:GetController("state")
	self.iconController1002_ = self.controller1002_:GetController("state")
	self.iconController1003_ = self.controller1003_:GetController("state")
	self.iconController1004_ = self.controller1004_:GetController("state")
end

function AutoChessMedalTipsItem:SetData(arg_5_1, arg_5_2)
	self.id = arg_5_1
	self.text_.text = AutoChessMedalCfg[arg_5_1].name

	self:SetMedalIcon()

	if arg_5_2 then
		self.iconController_:SetSelectedIndex(2)
	else
		self.iconController_:SetSelectedIndex(0)
	end

	self:SetActive(true)

	self.timer_ = Timer.New(function()
		self:SetActive(false)

		if self.closeFunc then
			self.closeFunc(arg_5_1, true)
		end
	end, 1.5, 1)

	self.timer_:Start()
end

function AutoChessMedalTipsItem:SetMedalIcon()
	self.iconController_ = nil

	for iter_7_0, iter_7_1 in ipairs(AutoChessMedalCfg.all) do
		if iter_7_1 == self.id then
			self.iconController_ = self["iconController" .. iter_7_1 .. "_"]

			SetActive(self["controller" .. iter_7_1 .. "_"].gameObject, true)
		else
			SetActive(self["controller" .. iter_7_1 .. "_"].gameObject, false)
		end
	end
end

function AutoChessMedalTipsItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function AutoChessMedalTipsItem:SetCloseFunc(arg_9_1)
	self.closeFunc = arg_9_1
end

function AutoChessMedalTipsItem:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	AutoChessMedalTipsItem.super.Dispose(self)
end

return AutoChessMedalTipsItem
