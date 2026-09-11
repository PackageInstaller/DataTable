local CultureGravureServantItem = class("CultureGravureServantItem", ReduxView)

function CultureGravureServantItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureServantItem:Init()
	self:InitUI()
	self:AddListeners()

	self.btnController_ = ControllerUtil.GetController(self.gameObject_.transform, "statebtn")
	self.stateController_ = ControllerUtil.GetController(self.gameObject_.transform, "statestar")
	self.nameController_ = ControllerUtil.GetController(self.gameObject_.transform, "name")
	self.recommendController_ = ControllerUtil.GetController(self.gameObject_.transform, "state")
end

function CultureGravureServantItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.index_ = arg_3_1
	self.id_ = arg_3_2
	self.heroID_ = arg_3_3
	self.cfg_ = WeaponServantCfg[self.id_]

	self:RefreshUI()
end

function CultureGravureServantItem:InitUI()
	self:BindCfgUI()

	self.roleImg_.immediate = true
end

function CultureGravureServantItem:AddListeners()
	self:AddBtnListener(self.getBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.id_,
			"servant"
		})
	end)
	self:AddBtnListener(self.roleBtn_, nil, function()
		self:Go("/showServantView", {
			state = "onlydetail",
			id = self.id_
		})
	end)
	self:AddBtnListener(self.equipBtn_, nil, function()
		CultureGravureAction.EquipByServantID(self.heroID_, self.id_)
	end)
end

function CultureGravureServantItem:SetRecommendController(arg_9_1)
	self.recommendController_:SetSelectedState(arg_9_1)
end

function CultureGravureServantItem:SetCallBack(arg_10_1)
	self.callback = arg_10_1
end

function CultureGravureServantItem:RefreshUI()
	self.roleImg_.spriteSync = "TextureConfig/WeaponServant/Icon438x238/" .. self.id_
	self.nameText_.text = ItemTools.getItemName(self.id_)

	self.stateController_:SetSelectedState(self.cfg_.starlevel)
	self.nameController_:SetSelectedState((self.cfg_.starlevel - 2 >= 1 or nil) and (self.cfg_.starlevel - 2 or 1))

	self.raceImg_.sprite = getSprite("Atlas/SystemGroupAtlas", RaceEffectCfg[self.cfg_.race].icon2)
	self.raceText_.text = string.format(GetTips("CULTUREGRAVURE_RACE_DESC"), GetI18NText(RaceEffectCfg[self.cfg_.race].name))

	self:RefreshState()
end

function CultureGravureServantItem:RefreshState()
	if CultureGravureData:GetServantIsEquipped(self.heroID_, self.id_) then
		self.btnController_:SetSelectedState("equip")
	elseif CultureGravureData:GetHasServant(self.id_) then
		self.btnController_:SetSelectedState("had")
	else
		self.btnController_:SetSelectedState("get")
	end
end

function CultureGravureServantItem:Dispose()
	CultureGravureServantItem.super.Dispose(self)
end

return CultureGravureServantItem
