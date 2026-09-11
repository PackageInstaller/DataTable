local var_0_0 = singletonClass("T0WorldMgr")

var_0_0.SwitchTypeEnum = {
	Filter = 3,
	Face = 2,
	Action = 1
}
var_0_0.CaptureModeStateEnum = {
	filter = 2,
	mainUIHide = 4,
	photo = 0,
	empty = 1,
	normal = 3
}
var_0_0.GeneralSceneType = 0

function var_0_0:Ctor()
	self:Init()
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.GetCaptureSwitchList(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(T0WorldCaptureSwitchCfg.all) do
		if T0WorldCaptureSwitchCfg[iter_3_1].switchType == arg_3_2 and T0WorldCaptureSwitchCfg[iter_3_1].character == arg_3_3 then
			if T0WorldCaptureSwitchCfg[iter_3_1].scene == 0 then
				table.insert(var_3_0, iter_3_1)
			elseif T0WorldCaptureSwitchCfg[iter_3_1].scene == arg_3_1 then
				table.insert(var_3_0, iter_3_1)
			end
		end
	end

	return var_3_0
end

function var_0_0.GetCaptureSceneName(arg_4_0, arg_4_1)
	return T0WorldTools.GetCaptureSceneList()[arg_4_1]
end

function var_0_0:ClearContext()
	if self.context then
		self.context.captureModel = nil
	end

	self.context = nil
end

function var_0_0.InitContext(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.context = {
		isUseLookAt = false,
		isTaking = false,
		useSceneType = 1,
		captureCount = 0,
		useSetting = {},
		character = arg_6_1 or 108502,
		scene = arg_6_2,
		dlcID = T0WorldTools.GetSkinDLC(arg_6_1)
	}
end

function var_0_0:GetUseSettingByType(arg_7_1)
	return self.context.useSetting[arg_7_1] or -1
end

function var_0_0:GetDefalutSettingByScene(arg_8_1, arg_8_2, arg_8_3)
	return self:GetCaptureSwitchList(arg_8_1, arg_8_2, arg_8_3)[1]
end

function var_0_0:SetCaptureSwitch(arg_9_1)
	self.context.useSetting = self.context.useSetting or {}

	local var_9_0 = T0WorldCaptureSwitchCfg[arg_9_1]

	self.context.useSetting[T0WorldCaptureSwitchCfg[arg_9_1].switchType] = arg_9_1

	T0WorldLuaBridge.ChangeCapturePose(var_9_0.switchType, var_9_0.switchName)

	if var_9_0.switchType == self.SwitchTypeEnum.Action then
		self:SetCaptureSwitch((self:GetDefalutSettingByScene(self.context.useSceneType, self.SwitchTypeEnum.Face, self.context.character)))
	end

	manager.notify:Invoke(T0_WORLD_CAPTURE_SWITCH_CHANGE, arg_9_1)
end

function var_0_0:GetTakingState()
	return self.context.isTaking
end

function var_0_0:GetHeroID()
	return self.context.character
end

function var_0_0:GetSceneID()
	return self.context.scene
end

function var_0_0:GetUseSceneType()
	return self.context.useSceneType
end

function var_0_0:GetDLCID()
	return self.context.dlcID
end

function var_0_0:SetCaptureScene(arg_15_1)
	if self.context.useSceneType == arg_15_1 then
		return
	end

	self.context.useSceneType = arg_15_1

	T0WorldLuaBridge.ChangeCaptureScene(arg_15_1)
end

function var_0_0:DefalutSettingByScene(arg_16_1)
	local var_16_0 = self:GetDefalutSettingByScene(arg_16_1, self.SwitchTypeEnum.Action, self.context.character)

	if var_16_0 then
		self:SetCaptureSwitch(var_16_0)
	end

	if self:GetUseSettingByType(self.SwitchTypeEnum.Face) < 0 then
		local var_16_1 = self:GetDefalutSettingByScene(self.GeneralSceneType, self.SwitchTypeEnum.Face, self.context.character)

		if var_16_1 then
			self:SetCaptureSwitch(var_16_1)
		end
	end

	if self:GetUseSettingByType(self.SwitchTypeEnum.Filter) < 0 then
		local var_16_2 = self:GetDefalutSettingByScene(self.GeneralSceneType, self.SwitchTypeEnum.Filter, self.context.character)

		if var_16_2 then
			self:SetCaptureSwitch(var_16_2)
		end
	end
end

function var_0_0:GetCaptureModel()
	if self.context.captureModel == nil then
		self.context.captureModel = GameObject.Find(T0WorldTools.GetCaptureModelPath()).transform
	end

	return self.context.captureModel
end

return var_0_0
