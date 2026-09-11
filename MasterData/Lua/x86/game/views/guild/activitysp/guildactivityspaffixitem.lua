local GuildActivitySpAffixItem = class("GuildActivitySpAffixItem", ReduxView)

function GuildActivitySpAffixItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function GuildActivitySpAffixItem:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "bp")

	self:AddUIListener()
end

function GuildActivitySpAffixItem:AddUIListener()
	self:AddBtnListener(self.showButton, nil, function()
		if self.clickCallBack then
			self.clickCallBack()
		end
	end)
end

function GuildActivitySpAffixItem:RefreshUI(arg_5_1, arg_5_2)
	self.affixInfo = arg_5_1
	self.iconImg_.sprite = getAffixSprite(arg_5_1)

	if arg_5_2 then
		self.statusController_:SetSelectedState("true")
	else
		self.statusController_:SetSelectedState("false")
	end
end

function GuildActivitySpAffixItem:SetClickCallBack(arg_6_1)
	if arg_6_1 then
		self.clickCallBack = arg_6_1
	end
end

function GuildActivitySpAffixItem:Dispose()
	GuildActivitySpAffixItem.super.Dispose(self)
end

return GuildActivitySpAffixItem
