local polyhedronBattleHeadItem = class("polyhedronBattleHeadItem", ReduxView)

function polyhedronBattleHeadItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function polyhedronBattleHeadItem:Init()
	self:InitUI()
end

function polyhedronBattleHeadItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function polyhedronBattleHeadItem:SetData(arg_4_1, arg_4_2)
	if arg_4_2 == 0 then
		self.stateController:SetSelectedIndex(4)
	else
		local var_4_0 = arg_4_1:GetLeaderHeroId()

		if arg_4_1:GetHeroPolyData(arg_4_2):IsDead() then
			self.stateController:SetSelectedIndex(2)
		elseif var_4_0 == arg_4_2 then
			self.stateController:SetSelectedIndex(1)
		else
			self.stateController:SetSelectedIndex(0)
		end

		self.m_icon.sprite = getSpriteViaConfig("HeroLittleIcon", HeroData:GetHeroBattleUsingSkinInfo(arg_4_2).id)
	end
end

return polyhedronBattleHeadItem
