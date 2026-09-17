GuidePhoneJumpLayer = class("GuidePhoneJumpLayer", function()
	return cc.Layer:create()
end)

local level_manager = require("controller.level_manager")
local roleguide_jump_data = require("data.roleguide_jump_data")
local roleguide_type_data = require("data.roleguide_type_data")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")
local var_0_6 = config._DEBUG and 0 or 1
local var_0_7
local var_0_8 = {
	[1201] = function(...)
		return not activity_manager:is_module_stat_finished(2, "sign")
	end,
	[2041] = function(...)
		return playermodel.create_time + 1209600 > time_check_manager:getCurTime()
	end,
	[2114] = function(...)
		return not playermodel.haveSuit[203020]
	end,
	[130] = function(...)
		return not playermodel.haveSuit[29920]
	end,
	[105] = function(...)
		local var_6_0
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in pairs(playermodel.novice_pass_level_award) do
			var_6_1[iter_6_1] = true
		end

		for iter_6_2, iter_6_3 in pairs((require("data.novice_pass_level_data"))) do
			if not var_6_1[iter_6_3.id] then
				var_6_0 = true

				break
			end
		end

		return var_6_0
	end,
	[102] = function(...)
		return playermodel.create_time + 1209600 > time_check_manager:getCurTime()
	end,
	[2600002] = function(...)
		return not not activity_manager:is_module_stat_finished(2, "wake_fund")
	end
}
local var_0_9 = {
	[3007] = 7010,
	[8007] = 7010,
	[3001] = 6005,
	[8009] = 8010,
	[1003] = 8010,
	[8008] = 3010,
	[5002] = 4010,
	[3006] = 3010,
	[2011] = 8010,
	[2005] = UNLOCK_RECRUIT_ROLE,
	[7003] = UNLOCK_ACTIVITY_LIULI,
	[1002] = UNLOCK_ACTIVITY_LIULI
}

setmetatable(var_0_8, {
	__index = function(arg_9_0, arg_9_1)
		return function(...)
			return true
		end
	end
})

function GuidePhoneJumpLayer.create(arg_11_0, ...)
	local var_11_0 = GuidePhoneJumpLayer.new()

	var_11_0:init(...)

	return var_11_0
end

function GuidePhoneJumpLayer:init(arg_12_1)
	self.initparam = arg_12_1
	self.type = self.initparam.type
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.Director:getInstance():getVisibleSize())
	self.rootLayer:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer)
	self:initData()
	self:initUI()
	self:scrollToIndex()
	self:registerScriptHandler(function(arg_13_0)
		if arg_13_0 == "exit" then
			var_0_7 = self.switchToJumpLayer and self.tableViewLastPercent or nil
		end
	end)
end

function GuidePhoneJumpLayer:initData(...)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(roleguide_jump_data) do
		if iter_14_1.type == self.type and var_0_8[iter_14_1.jump]() then
			table.insert(var_14_0, {
				id = iter_14_1.id,
				sort = iter_14_1.sort
			})
		end
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		return arg_15_0.sort < arg_15_1.sort
	end)

	self.data = var_14_0
end

function GuidePhoneJumpLayer:initUI(...)
	self.title = ccui.ImageView:create("GuidePhoneLayer/title_bg.png", var_0_6)

	self.title:setPositionX(self.title:getContentSize().width / 2)
	self.title:setPositionY(1136 + GameDisplay.fix_y - self.title:getContentSize().height / 2 - 30)
	self.rootLayer:addChild(self.title)

	local var_16_0 = cc.Label:createWithTTF(roleguide_type_data[self.type].title or "", FONT_NAME, 46)

	var_16_0:setPositionX(26)
	var_16_0:setPositionY(32)
	var_16_0:setAnchorPoint(cc.p(0, 0))
	self.title:addChild(var_16_0)

	self.deslabel = cc.Label:createWithTTF(roleguide_type_data[self.type].content, FONT_NAME, 23)

	self.deslabel:setAnchorPoint(cc.p(0, 1))
	self.deslabel:setMaxLineWidth(580)
	self.deslabel:setPosition(cc.p(26, 20))
	self.deslabel:setColor(cc.c3b(205, 209, 252))
	self.title:addChild(self.deslabel)

	self.returnBtn = ccui.Button:create("public/button/bottom_return_btn_archives.png", nil, "public/button/bottom_return_btn_archives.png", var_0_6)

	self.returnBtn:setPosition(cc.p(50, -GameDisplay.fix_y + 42))
	self.returnBtn:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.rootLayer:addChild(self.returnBtn, 3)

	local var_16_1 = ccui.ImageView:create("GuidePhoneLayer/bottom.png", var_0_6)

	var_16_1:setAnchorPoint(cc.p(0, 0))
	var_16_1:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_16_1:setTouchEnabled(true)
	self.rootLayer:addChild(var_16_1, 2)

	self.selectTblAni = true

	self:initTableView()

	self.selectTblAni = false
end

local var_0_10 = 640
local var_0_11 = 940
local var_0_12 = 0
local var_0_13 = 100
local var_0_14 = 640
local var_0_15 = 186
local var_0_16 = cc.p(640 / 2, 186 / 2)

function GuidePhoneJumpLayer:initTableView()
	local var_18_0 = var_0_11 + GameDisplay.fix_y * 2 - self.deslabel:getContentSize().height

	self.tableView = cc.TableView:create(cc.size(var_0_10, var_18_0))
	self.tableView.displayheight = var_18_0

	self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.tableView:setPosition(cc.p(var_0_12, var_0_13 - GameDisplay.fix_y))
	self.tableView:setDelegate()

	self.tableView.anchorPoint = cc.p(0, 0)

	self.tableView:setName("listPanel")
	self.rootLayer:addChild(self.tableView)
	self.tableView:registerScriptHandler(function(arg_19_0, arg_19_1)
		return var_0_14, var_0_15
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.tableView:registerScriptHandler(function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:dequeueCell() or cc.TableViewCell:create()
		local var_20_1 = var_20_0:getChildByName("sp")

		if not var_20_1 then
			var_20_1 = self:createCellNode()

			var_20_1:setName("sp")
			var_20_1:setOpacity(0)
			var_20_1:setPosition(var_0_16)
			var_20_0:addChild(var_20_1)
		end

		var_20_1:update(arg_20_1 + 1)

		if self.selectTblAni then
			local var_20_2 = LAYER_OUT_TIME / math.ceil(var_18_0 / var_0_15) * 1.5

			if var_20_0:getChildByName("sp") then
				var_20_0:getChildByName("sp"):setOpacity(0)
				var_20_0:getChildByName("sp"):runAction(cc.Sequence:create(cc.DelayTime:create(arg_20_1 * var_20_2), cc.FadeIn:create(var_20_2)))
			end
		elseif var_20_0:getChildByName("sp") then
			var_20_0:getChildByName("sp"):setOpacity(255)
		end

		return var_20_0
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.tableView:registerScriptHandler(function(arg_21_0, arg_21_1)
		return #self.data
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.tableView:registerScriptHandler(function(arg_22_0)
		self.tableViewLastPercent = 100 - math.abs((arg_22_0:getContainer():getPositionY())) / arg_22_0:getContainer():getContentSize().height * 100
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.tableView:reloadData()
end

function GuidePhoneJumpLayer:createCellNode(...)
	local var_23_0 = ccui.Button:create("GuidePhoneLayer/jump_" .. self.type .. ".png", nil, "GuidePhoneLayer/jump_" .. self.type .. ".png", var_0_6)
	local var_23_1 = ccui.Text:create("", FONT_NAME, 24)

	var_23_1:setTextAreaSize(cc.size(300, 200))
	var_23_1:setPosition(cc.p(284, 112))
	var_23_1:setName("text")
	var_23_1:setAnchorPoint(cc.p(0, 1))
	var_23_0:addChild(var_23_1)

	local var_23_2 = ccui.Text:create("", FONT_W5, 44)

	var_23_2:setPosition(cc.p(120, 96))
	var_23_2:setName("titleText")
	var_23_0:addChild(var_23_2)

	local var_23_3 = ccui.ImageView:create("GuidePhoneLayer/goto_btn.png", var_0_6)

	var_23_3:setPosition(cc.p(490, 20))
	var_23_0:addChild(var_23_3)

	local var_23_4 = ccui.ImageView:create("GuidePhoneLayer/time_bg.png", var_0_6)

	var_23_4:setPositionX(var_23_0:getContentSize().width - var_23_4:getContentSize().width / 2)
	var_23_4:setPositionY(var_23_0:getContentSize().height - var_23_4:getContentSize().height / 2)
	var_23_4:setName("timeBg")
	var_23_0:addChild(var_23_4)

	local var_23_5 = ccui.Text:create("", FONT_W5, 14)

	var_23_5:setColor(cc.c3b(244, 230, 255))
	var_23_5:setPositionY(var_23_4:getContentSize().height / 2)
	var_23_5:setPositionX(100)
	var_23_5:setName("timeText")
	var_23_4:addChild(var_23_5)

	if self.type == 9 then
		var_23_3:setVisible(false)
		var_23_1:setPosition(cc.p(270, 134))
	end

	var_23_0:setSwallowTouches(false)
	var_23_0:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if math.abs(arg_24_0:getTouchBeganPosition().y - arg_24_0:getTouchEndPosition().y) > 50 then
			return
		end

		if var_0_9[arg_24_0.id] and not level_manager:isPlayerPassLevel(var_0_9[arg_24_0.id]) then
			global_ShowBlockWords(string.format(L_AREAN_UNLOCK, level_manager:formatSystemUnlockLevel(var_0_9[arg_24_0.id])))

			return
		end

		self.switchToJumpLayer = true

		goto_complete_system({
			jump_to_system = roleguide_jump_data[arg_24_0.id].jump
		})
	end)

	function var_23_0:update(arg_25_1)
		self.id = roleguide_jump_data[self.data[arg_25_1].id].id

		self:getChildByName("text"):setString(roleguide_jump_data[self.id].content)
		self:getChildByName("titleText"):setString(roleguide_jump_data[self.id].title or "")

		local var_25_0 = self:getFinishTime(self.id)

		if var_25_0 then
			var_23_0:getChildByName("timeBg"):setVisible(true)
			var_23_0:getChildByName("timeBg"):getChildByName("timeText"):setString(L_LEFT_TIME_SPACE .. var_25_0)
		else
			var_23_0:getChildByName("timeBg"):setVisible(false)
		end

		if var_0_9[self.id] then
			var_23_0:getChildByName("lock_icon"):setVisible(not level_manager:isPlayerPassLevel(var_0_9[self.id]))
		else
			var_23_0:getChildByName("lock_icon"):setVisible(false)
		end
	end

	local var_23_6 = ccui.ImageView:create("GuidePhoneLayer/jump_lock.png", var_0_6)

	var_23_6:setName("lock_icon")
	var_23_6:setVisible(false)
	var_23_6:setPosition(cc.p(var_23_0:getContentSize().width / 2, var_23_0:getContentSize().height / 2))
	var_23_0:addChild(var_23_6)

	return var_23_0
end

local function var_0_17(arg_26_0)
	if not arg_26_0 then
		return
	end

	local var_26_0 = global_get_time_by_date(arg_26_0) - time_check_manager:getCurTime()

	if var_26_0 < 0 then
		return
	end

	local var_26_6 = math.floor(var_26_0 / 24 / 3600)
	local var_26_7 = math.floor((var_26_0 - var_26_6 * 24 * 3600) / 3600)
	local var_26_8 = math.floor((var_26_0 - var_26_6 * 24 * 3600 - var_26_7 * 3600) / 60)

	return 0 ~= 0 and string.format(L_TIME_TEXT[1], var_26_6, var_26_7) or var_26_7 ~= 0 and string.format(L_TIME_TEXT[2], var_26_7, var_26_8) or string.format(L_TIME_TEXT[3], var_26_8)
end

function GuidePhoneJumpLayer.getFinishTime(arg_27_0, arg_27_1)
	if roleguide_jump_data[arg_27_1].jump == 102 then
		local var_27_0 = os.date("*t", playermodel.create_time + 1209600)

		return var_0_17((string.format("%d-%d-%d %d:%d:%d", var_27_0.year, var_27_0.month, var_27_0.day, var_27_0.hour, var_27_0.min, var_27_0.sec)))
	elseif roleguide_jump_data[arg_27_1].jump == 2041 then
		local var_27_1 = os.date("*t", playermodel.create_time + 1209600)

		return var_0_17((string.format("%d-%d-%d %d:%d:%d", var_27_1.year, var_27_1.month, var_27_1.day, var_27_1.hour, var_27_1.min, var_27_1.sec)))
	end
end

function GuidePhoneJumpLayer:scrollToIndex(...)
	if var_0_7 then
		self.selectTblAni = false

		self.tableView:scrollToPercent(var_0_7, nil, false)

		var_0_7 = nil
	end
end
