local StrongholdOperateSkillPage = class("StrongholdOperateSkillPage", StrongholdOperateBasePage)

function StrongholdOperateSkillPage:OnCtor(arg_1_1, arg_1_2)
	self.hander_ = arg_1_1
	self.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdSkillUI"), arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function StrongholdOperateSkillPage:Init()
	self:InitUI()
	self:Refresh()
end

function StrongholdOperateSkillPage:Init()
	self:InitUI()
	self:AddUIListener()

	self.items = {}

	for iter_3_0 = 1, 3 do
		table.insert(self.items, (StrongholdOperateSkillItem.New(self["m_skill" .. iter_3_0], iter_3_0)))
	end
end

function StrongholdOperateSkillPage:InitUI()
	self:BindCfgUI()
end

function StrongholdOperateSkillPage:AddUIListener()
	return
end

function StrongholdOperateSkillPage:Refresh(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self.items) do
		iter_6_1:RefreshUI()
	end
end

function StrongholdOperateSkillPage:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.items) do
		iter_7_1:Dispose()
	end

	StrongholdOperateSkillPage.super.Dispose(self)
end

return StrongholdOperateSkillPage
