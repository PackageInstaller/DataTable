local ZumaMainStageInfoView = class("ZumaMainStageInfoView", ReduxView)

function ZumaMainStageInfoView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.difficultType = arg_1_2
	self.difficultCfgList = ZumaData:GetZumaCfgData()[arg_1_2]

	self:InitUI()
end

function ZumaMainStageInfoView:GetDifficultCfgList()
	return self.difficultCfgList
end

function ZumaMainStageInfoView:SetRedState(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self.stageList) do
		iter_3_1:SetRedState(arg_3_1)
	end
end

function ZumaMainStageInfoView:InitUI()
	self:BindCfgUI()

	if self.scrollviewGo_ then
		self.scrollMoveView_ = ScrollMoveView.New(self, self.scrollviewGo_)
	end

	self.stagePosList = {}
	self.stageList = {}

	for iter_4_0 = 1, #self.difficultCfgList do
		local var_4_0, var_4_1 = self:CreateStageItem(iter_4_0)

		self.stageList[iter_4_0] = ZumaMainStageItem.New(var_4_0, var_4_1, self.difficultCfgList[iter_4_0], iter_4_0)
	end
end

function ZumaMainStageInfoView:CreateStageItem(arg_5_1)
	local var_5_0 = self[string.format("stage%sTrs_", arg_5_1)]

	self.stagePosList[arg_5_1] = var_5_0.anchoredPosition.x

	return var_5_0:GetChild(0).gameObject, nil
end

function ZumaMainStageInfoView:DefalutSelect(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.stageList) do
		if arg_6_1 == iter_6_1.levelID then
			break
		end
	end
end

function ZumaMainStageInfoView:UpdateMoveView(arg_7_1)
	if arg_7_1 then
		self:BeginMoveTween(Vector2(-self.stagePosList[arg_7_1], 0))
	else
		self:BeginMoveTween()
	end

	if self.scrollviewSr_ then
		self.scrollviewSr_.enabled = not arg_7_1
	end
end

function ZumaMainStageInfoView:BeginMoveTween(arg_8_1)
	self:RemoveTween()

	local var_8_0 = self.contentTrs_
	local var_8_1 = false

	if self.scrollviewTrs_ then
		var_8_1 = true
		var_8_0 = self.scrollviewTrs_
	end

	if not arg_8_1 then
		arg_8_1 = Vector2.zero
	elseif var_8_1 then
		arg_8_1.x = self.scrollviewTrs_.rect.width / 2 + arg_8_1.x - self.contentTrs_.anchoredPosition.x
	end

	self.tween_ = LeanTween.value(var_8_0.gameObject, var_8_0.anchoredPosition, arg_8_1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
		var_8_0.anchoredPosition = Vector2(arg_9_0, 0)
	end)):setOnComplete(System.Action(function()
		self:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function ZumaMainStageInfoView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.tween_.id)

		self.tween_ = nil
	end
end

function ZumaMainStageInfoView:IsOpenSectionInfo()
	return true
end

function ZumaMainStageInfoView:RefreshStageUI(arg_13_1)
	if arg_13_1 then
		self.stageList[arg_13_1]:RefreshUI()
	else
		for iter_13_0, iter_13_1 in pairs(self.stageList) do
			iter_13_1:RefreshUi()
		end
	end
end

function ZumaMainStageInfoView:GetTragetItem(arg_14_1)
	return self.stageList[arg_14_1]
end

function ZumaMainStageInfoView:GetAllScore()
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(self.stageList) do
		var_15_0 = var_15_0 + (ZumaData:GetZumaStageScore(iter_15_1.levelID) or 0)
	end

	return var_15_0
end

function ZumaMainStageInfoView:Dispose()
	self:RemoveTween()

	for iter_16_0, iter_16_1 in pairs(self.stageList) do
		iter_16_1:Dispose()
	end

	if self.scrollMoveView_ then
		self.scrollMoveView_:Dispose()

		self.scrollMoveView_ = nil
	end

	ZumaMainStageInfoView.super.Dispose(self)
end

return ZumaMainStageInfoView
