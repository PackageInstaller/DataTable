local ZumaTalentItem = class("ZumaTalentItem", ReduxView)
local var_0_1 = {
	selectState = {
		onSelect = "state1",
		name = "sel",
		unSelect = "state0"
	},
	stateState = {
		name = "state",
		lock = "state0",
		normal = "state2"
	},
	lineState = {
		normalColor = Color(0.611764705882353, 0.7372549019607844, 0.788235294117647, 1),
		lockColor = Color(0.7137254901960784, 0.7764705882352941, 0.8, 0.4)
	}
}

function ZumaTalentItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.talentID = arg_1_3
	self.talentCfg = ActivityZumaTalentCfg[self.talentID]
	self.lineImage = arg_1_2:GetComponent(typeof(Image))

	self:InitUI()
end

function ZumaTalentItem:InitUI()
	self:BindCfgUI()

	self.selectController = self.controllerexcollection_:GetController(var_0_1.selectState.name)
	self.stateController = self.controllerexcollection_:GetController(var_0_1.stateState.name)

	self:AddBtnListener(self.stageBtn_, nil, function()
		manager.notify:CallUpdateFunc(ZUMA_TALENT_INFO, self.talentID)
	end)

	self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/" .. self.talentCfg.icon)
end

function ZumaTalentItem:GetTalentID()
	return self.talentID
end

function ZumaTalentItem:RefreshTalentState()
	local var_5_0 = ZumaData:GetZumaTalentIsOpen(self.talentID)

	self.stateController:SetSelectedState((var_5_0 or nil) and (var_0_1.stateState.normal or var_0_1.stateState.lock))
	self:RefreshLineState(var_5_0)
end

function ZumaTalentItem:RefreshSelectState(arg_6_1)
	self.selectController:SetSelectedState((arg_6_1 or nil) and (var_0_1.selectState.onSelect or var_0_1.selectState.unSelect))
end

function ZumaTalentItem:RefreshLineState(arg_7_1)
	if arg_7_1 then
		self.lineImage.color = var_0_1.lineState.normalColor or var_0_1.lineState.lockColor
	end
end

function ZumaTalentItem:Dispose()
	ZumaTalentItem.super.Dispose(self)
end

return ZumaTalentItem
