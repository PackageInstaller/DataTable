PopNoviceRechargeLayer = class("PopNoviceRechargeLayer", function(arg_1_0)
	return PopBaseLayer:create(arg_1_0)
end)

local var_0_0 = config._DEBUG and 0 or 1
local time_check_manager = require("controller.time_check_manager")
local recharge_manager = require("controller.recharge_manager")
local playermodel = require("model.playermodel")
local network = require("network.network")

function PopNoviceRechargeLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopNoviceRechargeLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopNoviceRechargeLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopNoviceRechargeLayer.json" or "PopNoviceRechargeLayer.ExportJson")
	self.rootPanel = self.rootLayer:getChildByName("bg")

	self:addChild(self.rootLayer)

	self.rechargId = arg_3_1.rechargeid
	self.remain = arg_3_1.remain
	self.finishtime = arg_3_1.finishtime

	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and self.scheduler then
			time_check_manager:removeUpdatePool(self.scheduler)
		end
	end)
end

function PopNoviceRechargeLayer:initUI()
	self.rootPanel:loadTexture(string.format("PopNoviceRechargeLayer/bg_%d.png", self.rechargId), var_0_0)

	self.btnReturn = self.rootPanel:getChildByName("close")

	self.btnReturn:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.btn = self.rootPanel:getChildByName("btn")

	if not self.remain or self.remain < 0 then
		if RoleDefault:getInstance():getBoolForKey("recharege" .. self.rechargId, false) then
			local var_5_0 = string.format("PopNoviceRechargeLayer/btn_bought_%d.png", self.rechargId)

			self.btn:loadTextures(var_5_0, var_5_0, var_5_0, var_0_0)

			goto label_5_0
		end
	end

	do
		local var_5_1 = string.format("PopNoviceRechargeLayer/btn_buy_%d.png", self.rechargId)

		self.btn:loadTextures(var_5_1, var_5_1, var_5_1, var_0_0)
	end

	::label_5_0::

	self.btn:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		network:rpc("check_recharge", {
			id = self.rechargId,
			client = config.clientmode
		}, function(arg_8_0)
			if arg_8_0.result == 1 then
				self.recharging = false

				AnalyticManager.clickPurchaseItem({
					product = id,
					rolenum = playermodel:getOwnedServantNum(),
					grade = playermodel.grade,
					class = playermodel.class
				})
				recharge_manager:confirmPayment(self.rechargId)
			elseif arg_8_0.result == 2 then
				print("测试模式")
			elseif arg_8_0.result == 3 then
				global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
			elseif arg_8_0.result == 4 then
				global_ShowBlockWords(L_RECHARGE_OUT_TIME)
			elseif arg_8_0.result == 5 then
				global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
			elseif arg_8_0.result == 6 then
				global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
			end
		end)
	end)

	self.timeLabel = self.rootPanel:getChildByName("time")

	local var_5_3

	if self.rechargId == 8999 then
		self.timeLabel:setPositionY(self.timeLabel:getPositionY() + 20)
		self.btn:setPositionY(self.btn:getPositionY() - 20)

		local var_5_2 = time_check_manager:getCurTime()

		var_5_3 = self.finishtime and global_get_time_by_date(self.finishtime) - var_5_2 or playermodel.create_time - var_5_2 + 259200
	end

	self.scheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_5_3, function(arg_9_0)
		self.timeLabel:setString((Global_format_time_str(arg_9_0)))

		if arg_9_0 <= 0 and self.scheduler then
			self.timeLabel:setVisible(false)
			time_check_manager:removeUpdatePool(self.scheduler)

			self.scheduler = nil
		end
	end)))

	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_10_0)
		if self.remain then
			self.remain = self.remain - 1
		end

		local var_10_0 = string.format("PopNoviceRechargeLayer/btn_bought_%d.png", self.rechargId)

		self.btn:loadTextures(var_10_0, var_10_0, var_10_0, var_0_0)
		RoleDefault:getInstance():setBoolForKey("recharege" .. self.rechargId, true)
	end), self)
end

function PopNoviceRechargeLayer:initBg(arg_11_1)
	local var_11_0 = ccui.Layout:create()

	var_11_0:setTouchEnabled(true)
	var_11_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_11_0:setAnchorPoint(cc.p(0, 0))
	var_11_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_11_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_11_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_11_0:setOpacity(0)
	self:addChild(var_11_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_12_0)
		self:addChild(arg_12_0, -2)
		arg_12_0:setPositionY(arg_12_0:getPositionY() - GameDisplay.fix_y)

		local var_12_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_12_0:setAnchorPoint(cc.p(0, 0))
		var_12_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_12_0, -1)
		self:init(arg_11_1)
		var_11_0:setOpacity(102)
		var_11_0:setTouchEnabled(false)
	end)
end
