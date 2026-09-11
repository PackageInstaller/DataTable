local GuildHeadIconItem = class("GuildHeadIconItem", ReduxView)

function GuildHeadIconItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)
	self:BindCfgUI()
	self:AddListeners()

	self.id_ = arg_1_3
	self.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[arg_1_3].iconName)
	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function GuildHeadIconItem:Dispose()
	GuildHeadIconItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function GuildHeadIconItem:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		manager.notify:Invoke(GUILD_SELECT_HEAD_ICON, self.id_)
	end)
end

function GuildHeadIconItem:SetSelect(arg_5_1)
	if arg_5_1 then
		self.controller_:SetSelectedState("true")
	else
		self.controller_:SetSelectedState("false")
	end
end

return GuildHeadIconItem
