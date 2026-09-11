local WaterPipeStageMapView = class("WaterPipeStageMapView", ReduxView)

function WaterPipeStageMapView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:InitUI()
end

function WaterPipeStageMapView:InitUI()
	self:BindCfgUI()

	self.stageIDList = ActivityWaterPipeStageCfg.all
	self.stageItemList = {}

	for iter_2_0, iter_2_1 in pairs(self.stageIDList) do
		self.stageItemList[iter_2_0] = WaterPipeStageItem.New(self[string.format("pipestageitemGo_%o", iter_2_0)], iter_2_1)
	end
end

function WaterPipeStageMapView:RefreshUI()
	for iter_3_0, iter_3_1 in pairs(self.stageItemList) do
		iter_3_1:RefreshUI()
	end
end

function WaterPipeStageMapView:BindRedPoint()
	for iter_4_0, iter_4_1 in pairs(self.stageItemList) do
		iter_4_1:BindRedPoint()
	end
end

function WaterPipeStageMapView:UnBindRedPoint()
	for iter_5_0, iter_5_1 in pairs(self.stageItemList) do
		iter_5_1:UnBindRedPoint()
	end
end

function WaterPipeStageMapView:MoveToOptimal()
	local var_6_0 = #self.stageIDList

	for iter_6_0, iter_6_1 in ipairs(self.stageIDList) do
		local var_6_1 = WaterPipeData:GetStageInfoByStageID(iter_6_1)

		if WaterPipeData:CheckStageIsUnLock(iter_6_1) then
			if var_6_1 and (var_6_1.letter_reward == false or var_6_1.letter_reward == nil) then
				var_6_0 = iter_6_0

				break
			elseif not var_6_1 then
				var_6_0 = iter_6_0

				break
			else
				var_6_0 = iter_6_0
			end
		end
	end

	self:ScrollList(var_6_0)
end

function WaterPipeStageMapView:ScrollList(arg_7_1)
	self.contentTrs_.anchoredPosition = Vector2(Mathf.Max(Mathf.Min(self.scrollviewTrs_.rect.width - self.stageItemList[arg_7_1].transform_.parent.anchoredPosition.x - self.stageItemList[arg_7_1].transform_.rect.width - 400, 0), self.scrollviewTrs_.rect.width - self.contentTrs_.rect.width), self.contentTrs_.anchoredPosition.y)
end

function WaterPipeStageMapView:PlaySettleAni(arg_8_1)
	local var_8_0 = table.indexof(self.stageIDList, arg_8_1)
	local var_8_1 = var_8_0 + 1

	for iter_8_0, iter_8_1 in pairs(self.stageItemList) do
		iter_8_1:ShowStageAni(false)
	end

	self.stageItemList[var_8_0]:ShowStageAni(true)
	self:StopNextStageTimer()

	self.nextStageTimer = Timer.New(function()
		if self.stageItemList[var_8_1] then
			self.stageItemList[var_8_1]:ShowStageAni(true)
		end

		self:StopNextStageTimer()
	end, 1)

	self.nextStageTimer:Start()
end

function WaterPipeStageMapView:StopNextStageTimer()
	if self.nextStageTimer then
		self.nextStageTimer:Stop()

		self.nextStageTimer = nil
	end
end

function WaterPipeStageMapView:Dispose()
	self:StopNextStageTimer()

	for iter_11_0, iter_11_1 in pairs(self.stageItemList) do
		if iter_11_1 then
			iter_11_1:Dispose()

			iter_11_1 = nil
		end
	end

	WaterPipeStageMapView.super.Dispose(self)
end

return WaterPipeStageMapView
