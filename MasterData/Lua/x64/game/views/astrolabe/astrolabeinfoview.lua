local AstrolabeInfoView = class("AstrolabeInfoView", ReduxView)

function AstrolabeInfoView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function AstrolabeInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AstrolabeInfoView:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.gameObject_.transform, "name")
	self.spBgController_ = self.messageControllerexcollection_:GetController("spShow")
end

function AstrolabeInfoView:AddUIListener()
	TerminologyTools.AddTerminologyHandler(self, self.text3Text_, nil, nil)
end

function AstrolabeInfoView:RefreshUI(arg_5_1)
	if arg_5_1 then
		local var_5_0 = HeroAstrolabeCfg[arg_5_1.id]

		self.text2Text_.text = string.format("%s·%s", GetI18NText(HeroAstrolabeCfg[arg_5_1.id].suit_name), GetI18NText(HeroAstrolabeCfg[arg_5_1.id].name))
		self.text3Text_.text = GetI18NText(self.heroViewProxy_:GetAstrolabeDesc(arg_5_1.id, arg_5_1.heroId))

		self.stateController_:SetSelectedState(AstrolabeConst.NodeColorCfg[AstrolabeTools.GetAstrolabeItemPos(arg_5_1.id, arg_5_1.heroId)] or AstrolabeConst.NodeColorCfg[1])

		if HeroTools.IsSpHero(arg_5_1.heroId) then
			SetActive(self.spDes_, false)
			self.spBgController_:SetSelectedState(var_5_0.astrolabe_type == 2 and "sp" or "notSp")
		else
			self.nodeDes_.text = GetI18NText(GetTips("ASTROLABE_NODE_DESC_" .. var_5_0.pos))

			SetActive(self.spDes_, true)
			self.spBgController_:SetSelectedState("notSp")
		end
	end
end

function AstrolabeInfoView:OnEnter()
	return
end

function AstrolabeInfoView:OnExit()
	return
end

function AstrolabeInfoView:SetProxy(arg_8_1)
	self.heroViewProxy_ = arg_8_1
end

function AstrolabeInfoView:Dispose()
	AstrolabeInfoView.super.Dispose(self)
end

return AstrolabeInfoView
