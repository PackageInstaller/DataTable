local MonsterCosplaySkillShowItem = class("MonsterCosplaySkillShowItem", ReduxView)

function MonsterCosplaySkillShowItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function MonsterCosplaySkillShowItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function MonsterCosplaySkillShowItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.cfg = ActivityMonsterCosplaySkillCfg[arg_3_1]
	self.index = arg_3_2
	self.callBack = arg_3_3

	self:UpdateView()
end

function MonsterCosplaySkillShowItem:InitUI()
	self:BindCfgUI()
end

function MonsterCosplaySkillShowItem:AddUIListener()
	self:AddBtnListener(self.normalBtn_, nil, function()
		self.callBack(self.normalBtn_, self.cfg, 1)
	end)
	self:AddBtnListener(self.upBtn_, nil, function()
		self.callBack(self.upBtn_, self.cfg, 2)
	end)
end

function MonsterCosplaySkillShowItem:UpdateView()
	self.nameTxt_.text = GetI18NText(self.cfg.skill_name)
	self.normalIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. self.cfg.skill_start_icon)
	self.upIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Summer2024/Summer2024_MonsterPlayUI/" .. self.cfg.skill_new_icon)
end

function MonsterCosplaySkillShowItem:OnExit()
	return
end

function MonsterCosplaySkillShowItem:Dispose()
	MonsterCosplaySkillShowItem.super.Dispose(self)
end

return MonsterCosplaySkillShowItem
