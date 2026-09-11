local CombineGameRoleItem = class("CombineGameRoleItem", ReduxView)

function CombineGameRoleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:Init()
end

function CombineGameRoleItem:Init()
	self:InitUI()
end

function CombineGameRoleItem:InitUI()
	self:BindCfgUI()
end

function CombineGameRoleItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.data = arg_4_1
	self.lv = arg_4_2
	self.type = arg_4_3

	self:UpdateView()
end

function CombineGameRoleItem:UpdateView()
	SetActive(self.maskGo_, self.lv < self.data.lv)

	self.LvTxt_.text = "等级" .. self.data.lv .. "解锁"

	if self.type == 1 then
		self.descTxt_.text = GetI18NText(ActivityCombineSkillCfg[ActivityCombineFactorCfg[self.data.id].effect[1]].description)
		self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. ActivityCombineSkillCfg[ActivityCombineFactorCfg[self.data.id].effect[1]].icon)
	else
		self.descTxt_.text = GetI18NText(ActivityCombineFactorCfg[self.data.id].description)
		self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. ActivityCombineFactorCfg[self.data.id].icon)
	end
end

function CombineGameRoleItem:OnEnter()
	self:UpdateView()
end

function CombineGameRoleItem:Dispose()
	CombineGameRoleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return CombineGameRoleItem
