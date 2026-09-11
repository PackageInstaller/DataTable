basePoseItem = import("game.views.t0World.Capture.Item.T0CapturePoseItem")

local OathCapturePoseItem = class("OathCapturePoseItem", basePoseItem)

function OathCapturePoseItem:Render(arg_1_1)
	self.switchID = arg_1_1

	local var_1_0 = WeddingCaptureSwitchCfg[arg_1_1]

	self.name_.text = GetI18NText(WeddingCaptureSwitchCfg[arg_1_1].title)

	if OathToLuaBridge:GetCaptureSwitch(var_1_0.switchType) == self.switchID then
		self.controller:SetSelectedState("select")
	else
		self.controller:SetSelectedState("false")
	end

	if var_1_0.switchType == OathConst.OATH_CAPTURE_FILTER_TYPE.Filter then
		self.filterImg_.sprite = OathTools.GetFilterImg(var_1_0.character, var_1_0.lensPicture)
	end
end

function OathCapturePoseItem:OnPoseItemClick()
	local var_2_0 = WeddingCaptureSwitchCfg[self.switchID]

	if OathToLuaBridge:GetCaptureSwitch(WeddingCaptureSwitchCfg[self.switchID].switchType) == self.switchID then
		return
	end

	if var_2_0.switchType == OathConst.OATH_CAPTURE_FILTER_TYPE.Face then
		OathToLuaBridge:SetCaptureSwitch(self.switchID)
	else
		manager.transition:OnlyShowEffect(true, function()
			OathToLuaBridge:SetCaptureSwitch(self.switchID)
			manager.transition:OnlyShowEffect(false)
		end)
	end

	if var_2_0.voice == "" then
		return
	end

	HeroTools.PlaySkinTalk(OathToLuaBridge:GetUseOathCharacterID(), var_2_0.voice, nil, OathToLuaBridge.GetOathModel().transform)
end

return OathCapturePoseItem
