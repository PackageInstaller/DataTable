local RogueTeamSetSkillItem = class("RogueTeamSetSkillItem", ReduxView)

function RogueTeamSetSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function RogueTeamSetSkillItem:Init()
	self:InitUI()
end

function RogueTeamSetSkillItem:InitUI()
	self:BindCfgUI()
end

function RogueTeamSetSkillItem:SetData(arg_4_1, arg_4_2)
	if arg_4_2 then
		self.heroViewDataProxy_ = arg_4_1

		local var_4_0 = arg_4_1:GetRealSkillId(arg_4_2.heroId, arg_4_2.id)

		self.iconImg_.sprite = getSprite("Atlas/" .. arg_4_2.heroId, var_4_0)
		self.nameText_.text = HeroSkillCfg[var_4_0].name

		self:RefreshLv(arg_4_2)

		self.subnameText_.text = HeroCfg[arg_4_2.heroId].skill_subhead[table.indexof(HeroCfg[arg_4_2.heroId].skills, arg_4_2.id)]

		local var_4_1 = HeroSkillCfg[var_4_0].element_type

		if type(HeroSkillCfg[var_4_0].element_type) ~= "table" then
			var_4_1 = {}
		end

		for iter_4_0, iter_4_1 in pairs(var_4_1) do
			if self["typeIcon_" .. iter_4_0] then
				if SkillElementCfg[iter_4_1].icon and SkillElementCfg[iter_4_1].icon ~= "" then
					SetActive(self["typeIcon_" .. iter_4_0].transform.gameObject, true)

					self["typeIcon_" .. iter_4_0].sprite = getSprite("Atlas/Hero_arrtAtlas", SkillElementCfg[iter_4_1].icon)
				end
			end
		end

		for iter_4_2 = 5, #var_4_1 + 1, -1 do
			if self["typeIcon_" .. iter_4_2] then
				SetActive(self["typeIcon_" .. iter_4_2].transform.gameObject, false)
			end
		end

		self.contentText_.text = HeroSkillCfg[var_4_0].simpleDesc

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentText_.transform)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.transform_)
	end
end

function RogueTeamSetSkillItem:RefreshLv(arg_5_1)
	local var_5_1 = self.heroViewDataProxy_:GetSkillLv(arg_5_1.heroId, arg_5_1.id) + (arg_5_1.tempAddLevel or 0)
	local var_5_2 = arg_5_1.addEquipSkillLv or 0

	self.lvText_.text = (var_5_2 > 0 or arg_5_1.addSkillLv > 0) and string.format("<color=#F3DC5A>%d</color>", var_5_1 + arg_5_1.addSkillLv + var_5_2) or string.format("%d", var_5_1)
end

function RogueTeamSetSkillItem:SetActive(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function RogueTeamSetSkillItem:Dispose()
	RogueTeamSetSkillItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return RogueTeamSetSkillItem
