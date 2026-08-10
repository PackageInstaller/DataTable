basePoseItem = import("game.views.t0World.Capture.Item.T0CapturePoseItem")

local var_0_0 = class("OathCapturePoseItem", basePoseItem)

function var_0_0.Render(arg_1_0, arg_1_1)
	arg_1_0.switchID = arg_1_1

	local var_1_0 = WeddingCaptureSwitchCfg[arg_1_1]

	arg_1_0.name_.text = GetI18NText(var_1_0.title)

	if OathToLuaBridge:GetCaptureSwitch(var_1_0.switchType) == arg_1_0.switchID then
		arg_1_0.controller:SetSelectedState("select")
	else
		arg_1_0.controller:SetSelectedState("false")
	end

	if var_1_0.switchType == OathConst.OATH_CAPTURE_FILTER_TYPE.Filter then
		arg_1_0.filterImg_.sprite = OathTools.GetFilterImg(var_1_0.character, var_1_0.lensPicture)
	end
end

function var_0_0.OnPoseItemClick(arg_2_0)
	local var_2_0 = WeddingCaptureSwitchCfg[arg_2_0.switchID]

	if OathToLuaBridge:GetCaptureSwitch(var_2_0.switchType) == arg_2_0.switchID then
		return
	end

	if var_2_0.switchType == OathConst.OATH_CAPTURE_FILTER_TYPE.Face then
		OathToLuaBridge:SetCaptureSwitch(arg_2_0.switchID)
	else
		manager.transition:OnlyShowEffect(true, function()
			OathToLuaBridge:SetCaptureSwitch(arg_2_0.switchID)
			manager.transition:OnlyShowEffect(false)
		end)
	end

	if var_2_0.voice == "" then
		return
	end

	local var_2_1 = OathToLuaBridge:GetUseOathCharacterID()

	HeroTools.PlaySkinTalk(var_2_1, var_2_0.voice, nil, OathToLuaBridge.GetOathModel().transform)
end

return var_0_0
