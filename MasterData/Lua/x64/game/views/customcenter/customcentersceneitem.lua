local CusteomCenterSceneItem = class("CusteomCenterSceneItem", ReduxView)

function CusteomCenterSceneItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.useController_ = self.controllerEx_:GetController("use")
	self.selectController_ = self.controllerEx_:GetController("select")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.dlcController_ = self.controllerEx_:GetController("dlc")
end

function CusteomCenterSceneItem:Dispose()
	CusteomCenterSceneItem.super.Dispose(self)
end

function CusteomCenterSceneItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.sceneID_ == self.selectID_ then
			return
		end

		if HomeSceneSettingData:CanUseScene(self.sceneID_) == false then
			ShowTips("CUSTOM_CENTER_SCENE_LOCK")

			return
		end

		manager.notify:Invoke(CUSTOM_CENTER_SELECT_SCENE, self.sceneID_)
	end)
end

function CusteomCenterSceneItem:SetSceneData(arg_5_1, arg_5_2)
	self.sceneID_ = arg_5_1
	self.selectID_ = arg_5_2

	local var_5_0 = arg_5_1

	if HomeSceneSettingCfg[arg_5_1].limit_display ~= 1 then
		var_5_0 = SkinSceneActionCfg.get_id_list_by_special_scene_id[arg_5_1] and nullable(SkinSceneActionCfg, SkinSceneActionCfg.get_id_list_by_special_scene_id[arg_5_1][1], "skin_id") or var_5_0
	end

	self.icon_.spriteSync = "TextureConfig/SceneChangeUI/item/" .. var_5_0

	self.selectController_:SetSelectedState(arg_5_2 == arg_5_1 and "true" or "false")
	self:RefreshState()
	self:RefreshLock()
	self:RefreshDLC()
end

function CusteomCenterSceneItem:RefreshState()
	if CustomCenterTools.IsDLCScene(self.sceneID_) then
		self.useController_:SetSelectedState("false")

		return
	end

	if CustomCenterTools.IsRandomScene() then
		if table.keyof(HomeSceneSettingData:GetCacheRandomSceneList(), self.sceneID_) then
			self.useController_:SetSelectedState("true")

			return
		end
	elseif manager.loadScene:GetTimeSceneID(HomeSceneSettingData:GetRealScene()) == self.sceneID_ then
		self.useController_:SetSelectedState("true")

		return
	end

	self.useController_:SetSelectedState("false")
end

function CusteomCenterSceneItem:RefreshLock()
	self.lockController_:SetSelectedState(tostring(not HomeSceneSettingData:CanUseScene(self.sceneID_)))
end

function CusteomCenterSceneItem:RefreshDLC()
	if CustomCenterTools.IsDLCScene(self.sceneID_) then
		self.dlcController_:SetSelectedState("state1")
	else
		self.dlcController_:SetSelectedState("state0")
	end
end

return CusteomCenterSceneItem
