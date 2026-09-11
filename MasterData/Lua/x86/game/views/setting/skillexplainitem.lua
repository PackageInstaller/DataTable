local SkillExplainItem = class("SkillExplainItem", ReduxView)

function SkillExplainItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SkillExplainItem:Init()
	self:InitUI()
end

function SkillExplainItem:InitUI()
	self:BindCfgUI()
end

function SkillExplainItem:Show(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

function SkillExplainItem:RefreshData(arg_5_1)
	self.icon_.sprite = arg_5_1.sprite
	self.skillTypeText_.text = GetI18NText(arg_5_1.type)
	self.nameText_.text = GetI18NText(arg_5_1.name)
	self.descText_.text = GetI18NText(arg_5_1.desc)

	if arg_5_1.ele == "" or arg_5_1.ele == nil then
		-- block empty
	else
		for iter_5_0, iter_5_1 in pairs(arg_5_1.ele) do
			if self["elementTrs_" .. iter_5_0] then
				local var_5_0 = self["elementTrs_" .. iter_5_0]:GetComponent("Image")

				if var_5_0 then
					if SkillElementCfg[iter_5_1].icon and SkillElementCfg[iter_5_1].icon ~= "" then
						SetActive(self["elementTrs_" .. iter_5_0].gameObject, true)

						var_5_0.sprite = getSprite("Atlas/Hero_arrtAtlas", SkillElementCfg[iter_5_1].icon)
					end
				end
			end
		end
	end
end

function SkillExplainItem:Dispose()
	SkillExplainItem.super.Dispose(self)
end

return SkillExplainItem
