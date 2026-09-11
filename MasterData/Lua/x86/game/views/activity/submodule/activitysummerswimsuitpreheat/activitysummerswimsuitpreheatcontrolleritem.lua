local ActivitySummerSwimsuitPreheatControllerItem = class("ActivitySummerSwimsuitPreheatControllerItem", ReduxView)

function ActivitySummerSwimsuitPreheatControllerItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ActivitySummerSwimsuitPreheatControllerItem:Init()
	self:BindCfgUI()
	self:InitController()
end

function ActivitySummerSwimsuitPreheatControllerItem:InitController()
	self.tipsController_ = self.controllerEx_:GetController("tips")
end

function ActivitySummerSwimsuitPreheatControllerItem:InitData(arg_4_1, arg_4_2)
	self.stageId_ = arg_4_1
	self.controllerIndex_ = arg_4_2
	self.stageType_ = ActivitySummerSwimsuitPreheatCfg[self.stageId_].type

	for iter_4_0, iter_4_1 in ipairs(GameSetting.summer_preheat_foolproof_range.value) do
		if iter_4_1[1] == self.stageType_ then
			self.minValue_ = iter_4_1[2][self.controllerIndex_]
		end
	end

	self.curValue_ = 100
	self.curTipsStatus_ = nil
	self.lastTipsStatus_ = nil

	self:UpdateTipsStatus()
end

function ActivitySummerSwimsuitPreheatControllerItem:SetCanShowTips(arg_5_1)
	self.canShowTips_ = arg_5_1
end

function ActivitySummerSwimsuitPreheatControllerItem:UpdateGameData(arg_6_1)
	self.gameData_ = arg_6_1

	if self.controllerIndex_ == 1 then
		self.curValue_ = self.gameData_.xValue or self.gameData_.yValue
	end

	self:Refresh()
end

function ActivitySummerSwimsuitPreheatControllerItem:Refresh()
	self:UpdateTipsStatus()
end

function ActivitySummerSwimsuitPreheatControllerItem:UpdateTipsStatus()
	self.curTipsStatus_ = self.curValue_ <= self.minValue_

	if self.curTipsStatus_ ~= self.lastTipsStatus_ then
		self.tipsController_:SetSelectedState(self.curTipsStatus_ and "on" or "off")

		self.lastTipsStatus_ = self.curTipsStatus_
	end
end

return ActivitySummerSwimsuitPreheatControllerItem
