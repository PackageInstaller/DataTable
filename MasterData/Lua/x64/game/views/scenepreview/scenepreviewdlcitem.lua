local ScenePreviewDlcItem = class("ScenePreviewDlcItem", ReduxView)

function ScenePreviewDlcItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ScenePreviewDlcItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ScenePreviewDlcItem:InitUI()
	self:BindCfgUI()

	self.icon_.immediate = true
	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.selectCon_ = ControllerUtil.GetController(self.transform_, "select")
end

function ScenePreviewDlcItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.clickFunc_ then
			self.clickFunc_()
		end
	end)
end

function ScenePreviewDlcItem:RefreshData(arg_6_1, arg_6_2, arg_6_3)
	self.id_ = arg_6_1
	self.cfg_ = HomeSceneSettingCfg[self.id_]
	self.title_.text = self.cfg_.title
	self.source_.text = self.cfg_.obtain_word
	self.icon_.spriteSync = "TextureConfig/SceneChangeUI/item/" .. CustomCenterTools.GetMatchSkinByScene(self.id_)

	self:RefreshType(arg_6_2, arg_6_3)
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.SCENE .. "_" .. self.id_)
end

function ScenePreviewDlcItem:RefreshType(arg_7_1, arg_7_2)
	self.selectCon_:SetSelectedState(arg_7_2 and "true" or "false")

	if arg_7_1 == 0 then
		self.typeCon_:SetSelectedState("ban")
	elseif HomeSceneSettingData:GetCurScene() == self.id_ and not HomeSceneSettingData:IsRandomScene() then
		if arg_7_1 == 1 then
			self.typeCon_:SetSelectedState("trial")
		elseif arg_7_1 == 2 then
			self.typeCon_:SetSelectedState("using")
		end
	else
		self.typeCon_:SetSelectedState("normal")
	end

	if arg_7_1 == 1 then
		SetActive(self.timeGo_, true)
		self:RefreshTime()
	else
		SetActive(self.timeGo_, false)
		self:StopTimer()
	end
end

function ScenePreviewDlcItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ScenePreviewDlcItem:RefreshTime()
	self:StopTimer()

	local var_9_0 = manager.time:GetServerTime()
	local var_9_1 = HomeSceneSettingData:GetSceneTimeStamp(self.id_)

	self.time_.text = manager.time:GetLostTimeStr2(var_9_1, nil, false)
	self.timer_ = Timer.New(function()
		if var_9_1 and var_9_0 <= var_9_1 then
			self.time_.text = manager.time:GetLostTimeStr2(var_9_1, nil, false)
		else
			self:RefreshUI()
		end
	end, 1, -1)

	self.timer_:Start()
end

function ScenePreviewDlcItem:RegistClickFunc(arg_11_1)
	self.clickFunc_ = arg_11_1
end

function ScenePreviewDlcItem:OnExit()
	self:StopTimer()
	manager.redPoint:unbindUIandKey(self.transform_)
end

function ScenePreviewDlcItem:Dispose()
	self:StopTimer()
	self:RemoveAllListeners()
	ScenePreviewDlcItem.super.Dispose(self)
end

return ScenePreviewDlcItem
