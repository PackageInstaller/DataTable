local AstrolabeSuitDesItem = class("AstrolabeSuitDesItem", ReduxView)

function AstrolabeSuitDesItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AstrolabeSuitDesItem:Init()
	self:InitUI()
end

function AstrolabeSuitDesItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.gameObject_.transform, "name")
	self.spBgController_ = self.messageControllerexcollection_:GetController("spShow")

	TerminologyTools.AddTerminologyHandler(self, self.text3Text_, nil, nil)
end

function AstrolabeSuitDesItem:SetData(arg_4_1, arg_4_2)
	local var_4_0 = HeroAstrolabeCfg[arg_4_1]

	self.text2Text_.text = string.format("%s·%s", GetI18NText(HeroAstrolabeCfg[arg_4_1].suit_name), GetI18NText(HeroAstrolabeCfg[arg_4_1].name))
	self.text3Text_.text = GetI18NText(self.heroViewProxy_:GetAstrolabeDesc(arg_4_1, arg_4_2.id))

	self.stateController_:SetSelectedState(AstrolabeConst.NodeColorCfg[AstrolabeTools.GetAstrolabeItemPos(arg_4_1, arg_4_2.id)] or AstrolabeConst.NodeColorCfg[1])

	if HeroTools.IsSpHero(arg_4_2.id) then
		SetActive(self.spDes_.gameObject, false)
		self.spBgController_:SetSelectedState(var_4_0.astrolabe_type == 2 and "sp" or "notSp")
	else
		self.nodeDes_.text = GetI18NText(GetTips("ASTROLABE_NODE_DESC_" .. var_4_0.pos))

		SetActive(self.spDes_.gameObject, true)
		self.spBgController_:SetSelectedState("notSp")
	end
end

function AstrolabeSuitDesItem:SetActive(arg_5_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_5_1)
	end
end

function AstrolabeSuitDesItem:SetProxy(arg_6_1)
	self.heroViewProxy_ = arg_6_1
end

function AstrolabeSuitDesItem:Dispose()
	self:RemoveAllListeners()
	AstrolabeSuitDesItem.super.Dispose(self)
end

return AstrolabeSuitDesItem
