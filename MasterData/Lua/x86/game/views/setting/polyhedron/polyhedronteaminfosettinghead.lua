local PolyhedronTeamInfoSettingHead = class("PolyhedronTeamInfoSettingHead", ReduxView)

function PolyhedronTeamInfoSettingHead:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function PolyhedronTeamInfoSettingHead:Init()
	self:InitUI()
	self:AddUIListener()
end

function PolyhedronTeamInfoSettingHead:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.emptyController = ControllerUtil.GetController(self.transform_, "empty")
	self.heroHead = PolyhedronHeroShortHead.New(self.m_head)

	self.heroHead:SetRedPointEnable(false)
end

function PolyhedronTeamInfoSettingHead:AddUIListener()
	self:AddBtnListener(self.m_btn, nil, function()
		if self.clickFunc then
			self.clickFunc(self.id)
		end
	end)
end

function PolyhedronTeamInfoSettingHead:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.id = arg_6_2

	local var_6_0 = arg_6_1:GetHeroPolyData(arg_6_2)

	if var_6_0:IsDead() then
		self.stateController:SetSelectedIndex(1)

		self.m_coldNum.text = arg_6_1:GetTeamateRebornMaxColdDown() - var_6_0.reborn_cold_down
	else
		self.stateController:SetSelectedIndex(0)
	end

	self.heroHead:SetProxy(arg_6_3)
	self.heroHead:SetHeroId(arg_6_2, HeroConst.HERO_DATA_TYPE.POLYHEDRON)
	self.heroHead.lockedController_:SetSelectedState("false")
	SetActive(self.heroHead.noticePos_.gameObject, false)
end

function PolyhedronTeamInfoSettingHead:SetFightData(arg_7_1, arg_7_2, arg_7_3)
	self.id = arg_7_2

	local var_7_0 = arg_7_1:GetHeroPolyData(arg_7_2)

	if arg_7_2 == nil or arg_7_2 == 0 then
		self.emptyController:SetSelectedIndex(1)

		return
	else
		self.emptyController:SetSelectedIndex(0)
	end

	self.heroHead:SetProxy(arg_7_3)
	self.heroHead:SetHeroId(arg_7_2, HeroConst.HERO_DATA_TYPE.POLYHEDRON)
	self.heroHead.lockedController_:SetSelectedState("false")
	SetActive(self.heroHead.noticePos_.gameObject, false)

	if var_7_0:IsDead() then
		self.m_coldNum.text = arg_7_1:GetTeamateRebornMaxColdDown() - var_7_0.reborn_cold_down

		self.stateController:SetSelectedIndex(4)
	elseif arg_7_1:GetLeaderHeroId() == arg_7_2 then
		self.stateController:SetSelectedIndex(2)

		self.heroHead.headIcon_.sprite = HeroTools.GetHeadSprite(HeroData:GetHeroBattleUsingSkinInfo(arg_7_2).id)
	else
		self.stateController:SetSelectedIndex(3)
	end
end

function PolyhedronTeamInfoSettingHead:RegistCallBack(arg_8_1)
	self.clickFunc = arg_8_1
end

function PolyhedronTeamInfoSettingHead:Dispose()
	self.heroHead:Dispose()
	PolyhedronTeamInfoSettingHead.super.Dispose(self)
end

return PolyhedronTeamInfoSettingHead
