local BossSwitchItem = class("BossSwitchItem", ReduxView)

function BossSwitchItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.info_ = arg_1_2

	self:InitUI()
	self:Init()
end

function BossSwitchItem:RefreshData(arg_2_1)
	self.info_ = arg_2_1
	self.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, BossChallengeUICfg[DamageTestCfg[self.info_.id].boss_id].icon))
	self.nameText_.text = GetI18NText(BossChallengeUICfg[DamageTestCfg[self.info_.id].boss_id].main_name)
	self.numText_.text = string.format("NO.%02d", self.info_.index)
end

function BossSwitchItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(nil, nil, "OnClick")
end

function BossSwitchItem:Init()
	return
end

function BossSwitchItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		return
	end)
end

function BossSwitchItem:OnClick()
	if self.clickFunc_ then
		self.clickFunc_(self.info_)
	end
end

function BossSwitchItem:RegistCallBack(arg_8_1)
	self.clickFunc_ = arg_8_1
end

function BossSwitchItem:GetItemInfo()
	return self.info_
end

function BossSwitchItem:Dispose()
	self.clickFunc_ = nil

	self:RemoveAllListeners()
	BossSwitchItem.super.Dispose(self)
end

return BossSwitchItem
