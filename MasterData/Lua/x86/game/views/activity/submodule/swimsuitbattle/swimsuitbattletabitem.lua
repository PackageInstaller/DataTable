local SwimsuitBattleTabItem = class("SwimsuitBattleTabItem", ReduxView)

function SwimsuitBattleTabItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SwimsuitBattleTabItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SwimsuitBattleTabItem:InitUI()
	self:BindCfgUI()

	self.activityID_ = 0
	self.selectController_ = self.mainControllerEx_:GetController("select")
	self.lockController_ = self.mainControllerEx_:GetController("lock")
end

function SwimsuitBattleTabItem:AddUIListener()
	self:AddBtnListener(self.mainBtn_, nil, function()
		if self.click_ then
			self.click_()
		end
	end)
end

function SwimsuitBattleTabItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	self.click_ = arg_6_5
	self.activityID_ = arg_6_3
	self.heroIconImg_.spriteAsync = SpritePathCfg.HeroLittleIcon.path .. arg_6_2
	self.type1Img_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_6_1, false)
	self.type2Img_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_6_1, true)
	self.name1Text_.text = SkinCfg[arg_6_2] and SkinCfg[arg_6_2].name or ""
	self.name2Text_.text = HeroCfg[arg_6_1].suffix

	self:RefreshLock()
	self.selectController_:SetSelectedState(arg_6_4 and "true" or "false")
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, arg_6_3))
end

function SwimsuitBattleTabItem:Select(arg_7_1)
	self.selectController_:SetSelectedState(arg_7_1 and "true" or "false")
end

function SwimsuitBattleTabItem:RefreshLock()
	local var_8_0 = ActivityData:GetActivityData(self.activityID_).startTime
	local var_8_1 = manager.time:GetServerTime()

	if var_8_1 < var_8_0 then
		self.lockController_:SetSelectedState("true")

		self.lockText_.text = string.format(GetTips("ACTIVITY_HERO_ENHANCE_HERO_UNLOCK_CONDITION"), manager.time:DiffDay(var_8_1, var_8_0))
	else
		self.lockController_:SetSelectedState("false")
	end
end

function SwimsuitBattleTabItem:Dispose()
	SwimsuitBattleTabItem.super.Dispose(self)
	self:RemoveAllListeners()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, self.activityID_))
end

return SwimsuitBattleTabItem
