local GuildActivitySPRecordItemView = class("GuildActivitySPRecordItemView", ReduxView)

function GuildActivitySPRecordItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function GuildActivitySPRecordItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPRecordItemView:InitUI()
	self:BindCfgUI()

	self.rankController_ = ControllerUtil.GetController(self.gameObject_.transform, "rank")
end

function GuildActivitySPRecordItemView:AddUIListener()
	return
end

function GuildActivitySPRecordItemView:AddEventListeners()
	return
end

function GuildActivitySPRecordItemView:SetData(arg_6_1, arg_6_2)
	self.index_ = arg_6_1
	self.data_ = arg_6_2

	self:UpdateView()
end

function GuildActivitySPRecordItemView:UpdateView()
	if self.index_ < 4 then
		self.rankController_:SetSelectedState(tostring(self.index_ - 1))
	else
		self.rankController_:SetSelectedState("3")
	end

	self.m_rankText.text = self.index_
	self.m_icon.sprite = ItemTools.getItemSprite(self.data_.icon)
	self.m_name.text = self.data_.name
	self.m_scoreText.text = self.data_.damage
	self.m_frame.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. self.data_.icon_frame)
end

function GuildActivitySPRecordItemView:OnEnter()
	self:AddEventListeners()
end

function GuildActivitySPRecordItemView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivitySPRecordItemView:OnMainHomeViewTop()
	return
end

function GuildActivitySPRecordItemView:Dispose()
	self.data_ = nil

	GuildActivitySPRecordItemView.super.Dispose(self)
end

return GuildActivitySPRecordItemView
