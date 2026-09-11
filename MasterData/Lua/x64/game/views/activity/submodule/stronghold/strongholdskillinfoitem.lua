local StrongholdSkillInfoItem = class("StrongholdSkillInfoItem", ReduxView)

function StrongholdSkillInfoItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StrongholdSkillInfoItem:Init()
	self:InitUI()
end

function StrongholdSkillInfoItem:InitUI()
	self:BindCfgUI()

	self.selectController = ControllerUtil.GetController(self.transform_, "select")
end

function StrongholdSkillInfoItem:SetData(arg_4_1, arg_4_2)
	self.selectController:SetSelectedIndex(arg_4_2)

	for iter_4_0 = 1, 3 do
		local var_4_0 = StrongholdData:GetSkillAffix(arg_4_1, iter_4_0)

		if iter_4_0 == 1 then
			self.m_name.text = getAffixName(var_4_0)
		end

		self["m_skillText" .. iter_4_0].text = getAffixDesc(var_4_0)
	end

	self.m_icon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. arg_4_1)
end

return StrongholdSkillInfoItem
