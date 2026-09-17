local CostumeRoomCumulativeRewardLayer = class("CostumeRoomCumulativeRewardLayer", (require("view.Layer.BaseCumulativeRewardLayer")))
local TempWidget = require("view.Sprite.TempWidget")

function CostumeRoomCumulativeRewardLayer:ctor()
	CostumeRoomCumulativeRewardLayer.super.ctor(self)

	self.manager = require("controller.costume_room_cumulative_reward_manager"):getInstance()
	self.data = self.manager:getDisplayInfo()
	self.designSize = cc.size(580, 840)
	self.viewSize = cc.size(self.designSize.width, self.designSize.height)
	self.cellSize = cc.size(self.designSize.width, 160)
	self.targetNumParam = {
		size = 30,
		pos = cc.p(self.cellSize.width - 10, self.cellSize.height - 3),
		font = FONT_W5,
		des = L_PIECE,
		anchorPoint = cc.p(1, 1)
	}
	self.progressImg = {
		dark = "CostumeRoomRewardLayer/dark_pro.png",
		light = "CostumeRoomRewardLayer/light_pro.png"
	}
	self.completeImg = {
		complete = "CostumeRoomRewardLayer/icon_complete.png",
		unfinished = "CostumeRoomRewardLayer/icon_unfinished.png"
	}
	self.accumulateDisplayParam = {
		imgDark = "CostumeRoomRewardLayer/accumulate_dark.png",
		size = 30,
		imgLight = "CostumeRoomRewardLayer/accumulate_light.png",
		type = self.AccumulateDisplayType.ImageView,
		des = ACTIVITY_LEVEL_MAP.STAR_NUM_TOTAL,
		font = FONT_W5,
		anchorPoint = cc.p(0, 1),
		pos = cc.p(20, self.cellSize.height - 5)
	}
	self.bgParam = {
		[self.CellRewardState.Incomplete] = "CostumeRoomRewardLayer/bg_unfinished.png",
		[self.CellRewardState.Completed_Unclaimed] = "CostumeRoomRewardLayer/bg_complete.png",
		[self.CellRewardState.Received] = "CostumeRoomRewardLayer/bg_complete.png",
		anchorPoint = cc.p(1, 0.5),
		pos = cc.p(self.cellSize.width, self.cellSize.height / 2 - 15)
	}
	self.rewardsViewParam = {
		size = cc.size(self.cellSize.width - 180, self.cellSize.height - 50),
		pos = cc.p(self.cellSize.width - 140, self.bgParam.pos.y),
		anchorPoint = cc.p(1, 0.5)
	}
	self.bgMaskParam = {
		path = "CostumeRoomRewardLayer/complete_mask.png",
		isShow = true
	}
	self.rewardBtnParam = {
		[self.CellRewardState.Incomplete] = "CostumeRoomRewardLayer/incomplete_btn.png",
		[self.CellRewardState.Completed_Unclaimed] = "CostumeRoomRewardLayer/completed_unclaimed_btn.png",
		[self.CellRewardState.Received] = "CostumeRoomRewardLayer/received_btn.png",
		anchorPoint = cc.p(1, 0.5),
		pos = cc.p(self.cellSize.width, self.cellSize.height / 2 - 15)
	}
	self.rewardItemParam = {
		itemScale = 0.5,
		itemLayoutsize = cc.size(100, 100)
	}
end

function CostumeRoomCumulativeRewardLayer:create()
	local var_2_0 = CostumeRoomCumulativeRewardLayer.new()

	if var_2_0 and var_2_0:init() then
		return var_2_0
	end

	return nil
end

function CostumeRoomCumulativeRewardLayer:getCurCumulativeNumber()
	return self.manager:getHaveSkinNum()
end

function CostumeRoomCumulativeRewardLayer:getState(arg_4_1)
	if self.manager.RewardState.NoGet == self.manager:getRewardStateByIndex(arg_4_1) then
		if self.manager:getHaveSkinNum() >= self.manager:getDisplayInfo()[arg_4_1].needCumulativeNumber then
			return self.CellRewardState.Completed_Unclaimed
		else
			return self.CellRewardState.Incomplete
		end
	elseif self.manager.RewardState.Get then
		return self.CellRewardState.Received
	end
end

function CostumeRoomCumulativeRewardLayer:rewardBtnHandler(arg_5_1)
	local var_5_0 = self:getState(arg_5_1)

	if var_5_0 == self.CellRewardState.Completed_Unclaimed then
		self.manager:requestGetReward(arg_5_1)
	elseif var_5_0 == self.CellRewardState.Incomplete then
		global_basic_scene:removeChildByName("CostumeRoomCumulativeRewardLayerTips")

		local var_5_1 = ConfirmDialogSprite:create(L_BOND_TIPS.NO_MATCH, L_COSTUME_ROOM_TASK, {
			surecallback = function()
				LayerManager:removePopLayer()
				LayerManager:switchShowLayer("MarketLayer")
			end
		})

		var_5_1:setName("CostumeRoomCumulativeRewardLayerTips")
		global_basic_scene:addChild(var_5_1, 10)
	elseif var_5_0 == self.CellRewardState.Received then
		print(456)
	end
end

function CostumeRoomCumulativeRewardLayer:getRewardSuccess(arg_7_1)
	self:updateCell(arg_7_1)
end

return CostumeRoomCumulativeRewardLayer
