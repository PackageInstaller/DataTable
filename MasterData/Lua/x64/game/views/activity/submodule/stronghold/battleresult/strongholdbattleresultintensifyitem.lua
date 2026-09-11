local StrongholdBattleResultIntensifyItem = class("StrongholdBattleResultIntensifyItem", ReduxView)

function StrongholdBattleResultIntensifyItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StrongholdBattleResultIntensifyItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdBattleResultIntensifyItem:InitUI()
	self:BindCfgUI()
end

function StrongholdBattleResultIntensifyItem:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.callback_ then
			self.callback_(self.id)
		end
	end)
end

function StrongholdBattleResultIntensifyItem:SetData(arg_6_1)
	self.id = arg_6_1
	self.m_icon.sprite = pureGetSpriteWithoutAtlas(ActivityStrongholdArtifactCfg[arg_6_1].icon)
	self.m_name.text = ActivityStrongholdArtifactCfg[arg_6_1].name
end

function StrongholdBattleResultIntensifyItem:RegistCallBack(arg_7_1)
	self.callback_ = arg_7_1
end

return StrongholdBattleResultIntensifyItem
