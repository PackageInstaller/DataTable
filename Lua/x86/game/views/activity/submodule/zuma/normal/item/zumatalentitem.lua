local var_0_0 = class("ZumaTalentItem", ReduxView)
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

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.talentID = arg_1_3
	arg_1_0.talentCfg = ActivityZumaTalentCfg[arg_1_0.talentID]
	arg_1_0.lineImage = arg_1_2:GetComponent(typeof(Image))

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController = arg_2_0.controllerexcollection_:GetController(var_0_1.selectState.name)
	arg_2_0.stateController = arg_2_0.controllerexcollection_:GetController(var_0_1.stateState.name)

	arg_2_0:AddBtnListener(arg_2_0.stageBtn_, nil, function()
		manager.notify:CallUpdateFunc(ZUMA_TALENT_INFO, arg_2_0.talentID)
	end)

	arg_2_0.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/" .. arg_2_0.talentCfg.icon)
end

function var_0_0.GetTalentID(arg_4_0)
	return arg_4_0.talentID
end

function var_0_0.RefreshTalentState(arg_5_0)
	local var_5_0 = ZumaData:GetZumaTalentIsOpen(arg_5_0.talentID)

	arg_5_0.stateController:SetSelectedState(var_5_0 and var_0_1.stateState.normal or var_0_1.stateState.lock)
	arg_5_0:RefreshLineState(var_5_0)
end

function var_0_0.RefreshSelectState(arg_6_0, arg_6_1)
	arg_6_0.selectController:SetSelectedState(arg_6_1 and var_0_1.selectState.onSelect or var_0_1.selectState.unSelect)
end

function var_0_0.RefreshLineState(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 and var_0_1.lineState.normalColor or var_0_1.lineState.lockColor

	arg_7_0.lineImage.color = var_7_0
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
