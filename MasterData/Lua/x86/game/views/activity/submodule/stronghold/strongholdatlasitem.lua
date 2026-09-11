local StrongholdAtlasItem = class("StrongholdAtlasItem", ReduxView)

function StrongholdAtlasItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function StrongholdAtlasItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function StrongholdAtlasItem:InitUI()
	self:BindCfgUI()

	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.rareController = ControllerUtil.GetController(self.transform_, "rare")
	self.typeController = ControllerUtil.GetController(self.transform_, "type")
end

function StrongholdAtlasItem:AddUIListener()
	return
end

function StrongholdAtlasItem:SetData(arg_5_1, arg_5_2)
	local var_5_0 = ActivityStrongholdArtifactCfg[arg_5_1]
	local var_5_1 = StrongholdData:GetAtlasUseCount(arg_5_2, arg_5_1)

	if var_5_1 == 0 then
		self.stateController:SetSelectedIndex(1)
	else
		self.stateController:SetSelectedIndex(0)

		self.m_name.text = var_5_0.name
		self.m_des.text = var_5_0.desc
		self.m_icon.sprite = pureGetSpriteWithoutAtlas(var_5_0.icon)

		self.rareController:SetSelectedIndex(var_5_0.rare - 1)

		self.m_useCount.text = string.format(GetTips("ACTIVITY_STRONGHOLD_ATLAS_USE_COUNT"), var_5_1)
	end

	self.typeController:SetSelectedIndex(var_5_0.type)
end

function StrongholdAtlasItem:Dispose()
	StrongholdAtlasItem.super.Dispose(self)
end

return StrongholdAtlasItem
