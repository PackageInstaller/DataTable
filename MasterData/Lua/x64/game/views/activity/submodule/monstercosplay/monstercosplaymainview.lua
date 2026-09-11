local MonsterCosplayMainView = class("MonsterCosplayMainView", ReduxView)

function MonsterCosplayMainView:UIName()
	return "Widget/System/ExploreUI/ExploreHome"
end

function MonsterCosplayMainView:UIParent()
	return manager.ui.uiMain.transform
end

function MonsterCosplayMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MonsterCosplayMainView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.indexItem), self.uiListGo_, MonsterCosplaySkillUpItem)
end

function MonsterCosplayMainView:AddUIListener()
	self:AddBtnListenerScale(self.sureBtn_, nil, function()
		return
	end)
end

function MonsterCosplayMainView:UpdateBar()
	return
end

function MonsterCosplayMainView:UpdateView()
	return
end

function MonsterCosplayMainView:UpdateData()
	return
end

function MonsterCosplayMainView:OnEnter()
	self.monsterID = self.params_.monsterID
	self.exitView_ = false

	manager.ui:SetMainCamera("soloHeartDemon")
	manager.windowBar:SetWhereTag("soloHeartDemon")
	self:LoadModel()
	self:UpdateData()
	self:UpdateView()
end

function MonsterCosplayMainView:OnExit()
	self.exitView_ = true

	manager.ui:ResetMainCamera()
	self:UnloadModel()
end

function MonsterCosplayMainView:LoadModel()
	if self.currentBossTemplateID == self.modelID then
		return
	end

	self:UnloadModel()

	self.currentBossTemplateID = self.modelID

	local var_12_0 = SoloHeartDemonUICfg[self.modelID]

	self.loadIndex = manager.resourcePool:AsyncLoad("Char/" .. SoloHeartDemonUICfg[self.modelID].model, ASSET_TYPE.TPOSE, function(arg_13_0)
		if self.exitView_ or self.currentBossTemplateID ~= self.modelID then
			manager.resourcePool:DestroyOrReturn(arg_13_0, ASSET_TYPE.TPOSE)

			return
		end

		local var_13_0 = var_12_0.model_pos

		self.bossModel = arg_13_0
		arg_13_0.transform.localPosition = Vector3(var_13_0[1], var_13_0[2], var_13_0[3])
		arg_13_0.transform.localEulerAngles = Vector3(var_12_0.model_rot[1], var_12_0.model_rot[2], var_12_0.model_rot[3])
		arg_13_0.transform.localScale = Vector3(var_12_0.model_scale[1], var_12_0.model_scale[2], var_12_0.model_scale[3])
	end)
end

function MonsterCosplayMainView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(GameDisplayCfg.solo_heart_demon_bg_pos.value[1], GameDisplayCfg.solo_heart_demon_bg_pos.value[2], GameDisplayCfg.solo_heart_demon_bg_pos.value[3])
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(GameDisplayCfg.solo_heart_demon_bg_pos.scale[1], GameDisplayCfg.solo_heart_demon_bg_pos.scale[2], GameDisplayCfg.solo_heart_demon_bg_pos.scale[3])
end

function MonsterCosplayMainView:DestroyBackScene()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)

		self.backGround_ = nil
	end
end

function MonsterCosplayMainView:Dispose()
	return
end

return MonsterCosplayMainView
