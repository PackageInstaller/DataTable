local PolyhedronSetSkillItem = class("PolyhedronSetSkillItem", ReduxView)

function PolyhedronSetSkillItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronSetSkillItem:Init()
	self:InitUI()

	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.POLYHEDRON)
end

function PolyhedronSetSkillItem:InitUI()
	self:BindCfgUI()
end

function PolyhedronSetSkillItem:SetData(arg_4_1)
	if arg_4_1 then
		local var_4_0 = self:GetRealSkillId(arg_4_1)

		self.iconImg_.sprite = getSprite("Atlas/" .. arg_4_1.heroId, var_4_0)
		self.nameText_.text = HeroSkillCfg[var_4_0].name

		self:RefreshLv(arg_4_1)

		self.subnameText_.text = HeroCfg[arg_4_1.heroId].skill_subhead[table.indexof(HeroCfg[arg_4_1.heroId].skills, arg_4_1.id)]

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

function PolyhedronSetSkillItem:RefreshLv(arg_5_1)
	self.lvText_.text = 0 <= 0 and string.format("%d", arg_5_1.lv + arg_5_1.addSkillLv) or string.format("<color=#F3DC5A>%d</color>", arg_5_1.lv + arg_5_1.addSkillLv + 0)
end

function PolyhedronSetSkillItem:GetRealSkillId(arg_6_1)
	return self.heroViewProxy_:GetRealSkillId(arg_6_1.heroId, arg_6_1.id)
end

function PolyhedronSetSkillItem:SetActive(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function PolyhedronSetSkillItem:Dispose()
	PolyhedronSetSkillItem.super.Dispose(self)
end

return PolyhedronSetSkillItem
