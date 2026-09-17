SchoolStudyLayer = class("SchoolStudyLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_study_servant_data = require("data.activity_study_servant_data")
local servant_data = require("data.servant_data")
local model_data = require("data.model_data")
local total_skill_data = require("data.total_skill_data")
local activity_manager = require("controller.activity_manager")
local test_fight_manager = require("controller.test_fight_manager")
local var_0_7 = 183
local var_0_8 = 1
local var_0_9 = 2
local var_0_10 = 3
local var_0_11 = 4
local var_0_12 = 5
local var_0_13 = 6
local var_0_14 = 7
local var_0_15 = 8
local var_0_16 = 80
local var_0_17 = 1800
local var_0_18 = 1.3
local var_0_19 = 330
local var_0_20 = 203020

function SchoolStudyLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SchoolStudyLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function SchoolStudyLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolStudyLayer.json" or "SchoolStudyLayer.ExportJson")

	self:addChild(self.rootLayer)

	arg_3_1 = arg_3_1 or {}
	self.chooseServant = arg_3_1.servantid or var_0_20

	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_study_info(var_0_7)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_20 = self.chooseServant

			activity_manager:releaseEventListenerByName("SchoolStudyLayer")
		end
	end)
end

function SchoolStudyLayer.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("SchoolStudyLayer", activity_manager.activityEventId.ACTIVITY_STUDY_LIST_UPDATE, function(arg_6_0)
		arg_5_0:updateServantView(arg_6_0.list)
	end)
	activity_manager:registerEventListener("SchoolStudyLayer", activity_manager.activityEventId.ACTIVITY_STUDY_SERVANT_UPDATE, function(arg_7_0)
		arg_5_0:updateServantPanel(arg_7_0)
	end)
	activity_manager:registerEventListener("SchoolStudyLayer", activity_manager.activityEventId.ACTIVITY_STUDY_PLAY_EFFECT, function(arg_8_0)
		arg_5_0:showStudyEffect(2)
	end)
	activity_manager:registerEventListener("SchoolStudyLayer", activity_manager.activityEventId.CHANGE_TEST_A_FIGHT_ARRAY_SUCCESS, function(arg_9_0)
		LayerManager:switchShowLayer("TestFightLayer")
	end)
end

function SchoolStudyLayer:initUI()
	self:initBottomList()
end

function SchoolStudyLayer:initBottomList()
	local var_11_0 = self.rootLayer:getChildByName("title")

	var_11_0:setPositionY(GameDisplay.height - GameDisplay.fix_y)
	var_11_0:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "SchoolStudyLayer"
		})
	end)

	self.bottomList = self.rootLayer:getChildByName("bottom")

	self.bottomList:setLocalZOrder(99)
	self.bottomList:setPositionY(40 - GameDisplay.fix_y)
	self.bottomList:getChildByName("btn_return"):addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.servantView = ccui.ScrollView:create()

	self.servantView:setContentSize(cc.size(640, 150))
	self.servantView:setName("servant_view")
	self.servantView:setAnchorPoint(0, 0)
	self.servantView:setPosition(0, 60 - GameDisplay.fix_y)
	self.rootLayer:addChild(self.servantView)

	self.soulPanel = self.rootLayer:getChildByName("soul_bg")

	local var_11_1 = self.soulPanel:getChildByName("name")

	var_11_1:setPositionY(var_11_1:getPositionY() + 30)

	local var_11_2 = self.soulPanel:getChildByName("btn_start")

	var_11_2:setPositionY(var_11_2:getPositionY() + 20)
end

function SchoolStudyLayer:updateServantView(arg_14_1)
	local var_14_0 = #arg_14_1 + 1

	self.servantView:removeAllChildren()
	self.servantView:setDirection(ccui.ScrollViewDir.horizontal)
	self.servantView:setInnerContainerSize(cc.size(120 * var_14_0, 150))

	for iter_14_0, iter_14_1 in pairs(arg_14_1) do
		local var_14_1 = self:createServantSp(iter_14_1)
		local var_14_2 = self.chooseServant == iter_14_1.servantid and var_14_0 or var_14_0 - iter_14_0

		var_14_1:setPosition(cc.p(-66 + iter_14_0 * 156, 60 - 8 * iter_14_0 + (self.chooseServant == iter_14_1.servantid and 20 or 0)))
		var_14_1:setLocalZOrder(var_14_2)
		self.servantView:getInnerContainer():addChild(var_14_1)

		if self.chooseServant == iter_14_1.servantid then
			self.curChooseSp = var_14_1
		end

		var_14_1:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not iter_14_1.servantid or self.chooseServant == iter_14_1.servantid then
				return
			end

			self.curChooseSp:setPositionY(self.curChooseSp:getPositionY() - 20)
			self.curChooseSp:setLocalZOrder(iter_14_0)
			self.curChooseSp:loadTexture("SchoolSturdyLayer/btn_" .. self.chooseServant .. ".png", var_0_0)
			arg_15_0:setPositionY(arg_15_0:getPositionY() + 20)
			arg_15_0:setLocalZOrder(var_14_0)
			arg_15_0:loadTexture("SchoolSturdyLayer/btn_on_" .. iter_14_1.servantid .. ".png", var_0_0)

			self.curChooseSp = arg_15_0
			self.chooseServant = iter_14_1.servantid

			activity_manager:get_activity_study_servant_info(var_0_7, iter_14_1.servantid)
		end)
	end

	activity_manager:get_activity_study_servant_info(var_0_7, self.chooseServant)
end

function SchoolStudyLayer:createServantSp(arg_16_1)
	local var_16_1 = ccui.ImageView:create(not arg_16_1.servantid and "SchoolSturdyLayer/btn_unkonw.png" or self.chooseServant == arg_16_1.servantid and "SchoolSturdyLayer/btn_on_" .. arg_16_1.servantid .. ".png" or "SchoolSturdyLayer/btn_" .. arg_16_1.servantid .. ".png", var_0_0)

	var_16_1:setTouchEnabled(true)
	var_16_1:setRotation(2)

	if arg_16_1.state then
		local var_16_2 = ccui.ImageView:create("SchoolSturdyLayer/tag_" .. arg_16_1.state .. ".png", var_0_0)

		var_16_2:setName("icon")
		var_16_2:setPosition(cc.p(var_16_1:getContentSize().width / 2, var_16_1:getContentSize().height / 2))
		var_16_1:addChild(var_16_2)
	end

	return var_16_1
end

local var_0_21 = {
	1,
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096,
	8192,
	16384,
	32768,
	65536,
	131072,
	262144,
	524288,
	1048576,
	2097152,
	4194304,
	8388608,
	16777216,
	33554432,
	67108864,
	134217728,
	268435456,
	536870912,
	1073741824,
	2147483648
}

function SchoolStudyLayer:updateServantPanel(arg_17_1)
	self.soulPanel = self.rootLayer:getChildByName("soul_bg")

	self.soulPanel:loadTexture("mainScenebg/school_study_bg/bg_" .. arg_17_1.servantid .. ".png")

	local var_17_0 = self.soulPanel:getChildByName("name")

	var_17_0:getChildByName("des_bg"):setLocalZOrder(-1)
	var_17_0:loadTexture("SchoolSturdyLayer/des_" .. arg_17_1.servantid .. ".png", var_0_0)

	local var_17_1 = servant_data[arg_17_1.servantid].modelid

	var_17_0:getChildByName("num_agg"):setString(model_data[servant_data[arg_17_1.servantid].modelid].damageFactor * 20)
	var_17_0:getChildByName("num_Blood"):setString(model_data[var_17_1].hpFactor * 20)
	var_17_0:getChildByName("num_speed"):setString(model_data[var_17_1].attackspeed)
	var_17_0:getChildByName("num_range"):setString(model_data[var_17_1].range)

	local var_17_2

	if var_17_0:getChildByName("pressbar_1") then
		var_17_2 = var_17_0:getChildByName("pressbar_1")
	else
		var_17_2 = ccui.Slider:create()

		var_17_0:addChild(var_17_2)
	end

	var_17_2:loadBarTexture("SchoolSturdyLayer/pre_bg.png", var_0_0)
	var_17_2:loadProgressBarTexture("SchoolSturdyLayer/pre_bar.png", var_0_0)
	var_17_2:setPosition(cc.p(110, 230))
	var_17_2:setName("pressbar_1")
	var_17_2:setPercent(model_data[var_17_1].damageFactor * 20 / var_0_16 * 100)

	local var_17_3

	if var_17_0:getChildByName("pressbar_2") then
		var_17_3 = var_17_0:getChildByName("pressbar_2")
	else
		var_17_3 = ccui.Slider:create()

		var_17_0:addChild(var_17_3)
	end

	var_17_3:loadBarTexture("SchoolSturdyLayer/pre_bg.png", var_0_0)
	var_17_3:loadProgressBarTexture("SchoolSturdyLayer/pre_bar.png", var_0_0)
	var_17_3:setPosition(cc.p(110, 200))
	var_17_3:setName("pressbar_2")
	var_17_3:setPercent(model_data[var_17_1].hpFactor * 20 / var_0_17 * 100)

	local var_17_4

	if var_17_0:getChildByName("pressbar_3") then
		var_17_4 = var_17_0:getChildByName("pressbar_3")
	else
		var_17_4 = ccui.Slider:create()

		var_17_0:addChild(var_17_4)
	end

	var_17_4:loadBarTexture("SchoolSturdyLayer/pre_bg.png", var_0_0)
	var_17_4:loadProgressBarTexture("SchoolSturdyLayer/pre_bar.png", var_0_0)
	var_17_4:setPosition(cc.p(110, 170))
	var_17_4:setName("pressbar_3")
	var_17_4:setPercent(model_data[var_17_1].attackspeed / var_0_18 * 100)

	if var_17_0:getChildByName("pressbar_4") then
		local var_17_6 = var_17_0:getChildByName("pressbar_4")
	else
		var_17_0:addChild((ccui.Slider:create()))
	end

	local var_17_7 = var_17_0:getChildByName("pressbar_4") or ccui.Slider:create()

	var_17_7:loadBarTexture("SchoolSturdyLayer/pre_bg.png", var_0_0)
	var_17_7:loadProgressBarTexture("SchoolSturdyLayer/pre_bar.png", var_0_0)
	var_17_7:setPosition(cc.p(110, 140))
	var_17_7:setName("pressbar_4")
	var_17_7:setPercent(model_data[var_17_1].range / var_0_19 * 100)

	local var_17_8 = {
		"skill1",
		"passive",
		"XP"
	}

	for iter_17_0 = 1, 3 do
		local var_17_9 = var_17_0:getChildByName("skill_" .. iter_17_0)
		local var_17_10 = ccui.ImageView:create("skill_new/skill/" .. total_skill_data[model_data[var_17_1][var_17_8[iter_17_0]]].icon .. ".png", var_0_0)
		local var_17_11 = var_17_9:getChildByName("icon")

		var_17_10:setPosition(cc.p(var_17_11:getContentSize().width / 2, var_17_11:getContentSize().height / 2))
		var_17_10:setScale(0.42)
		var_17_11:addChild(var_17_10)
	end

	var_17_0:getChildByName("detail"):loadTexture("SchoolSturdyLayer/detail_" .. arg_17_1.servantid .. ".png", var_0_0)
	var_17_0:getChildByName("btn_test"):addTouchEventListener(function(arg_18_0, arg_18_1)
		local var_18_1
		local var_18_0

		if arg_18_1 ~= ccui.TouchEventType.ended then
			do return end

			var_18_0 = {}
			var_18_1 = {}
		end

		var_18_1.servantid = arg_17_1.servantid
		var_18_1.modelid = servant_data[arg_17_1.servantid].modelid
		var_18_0[1] = var_18_1
		var_18_0[2] = {}
		var_18_0[3] = {}
		var_18_0[4] = {}
		var_18_0[5] = {}

		test_fight_manager:changeTestFightArray(nil, var_18_0)
	end)

	self.btnStart = self.soulPanel:getChildByName("btn_start")

	self.btnStart:loadTextures("SchoolSturdyLayer/btn_" .. arg_17_1.state .. ".png", nil, "SchoolSturdyLayer/btn_" .. arg_17_1.state .. ".png", var_0_0)

	local var_17_12 = self.btnStart:getChildByName("task_panel")
	local var_17_13 = self.btnStart:getChildByName("lbl_lock")

	var_17_13:setColor(cc.c3b(72, 80, 72))
	var_17_12:setTouchEnabled(false)
	self.btnStart:setVisible(true)

	if arg_17_1.state == var_0_8 then
		var_17_13:setVisible(true)
		var_17_13:setPosition(cc.p(173, 28))
		var_17_13:setString(L_ACTIVITY_STUDY_2 .. (activity_study_servant_data[arg_17_1.servantid].name or ""))
		var_17_13:setColor(cc.c3b(255, 255, 255))
		var_17_12:setVisible(false)
	elseif arg_17_1.state == var_0_9 then
		var_17_13:setVisible(false)
		var_17_13:setPosition(cc.p(160, 58))
		var_17_12:setVisible(false)
	elseif arg_17_1.state == var_0_10 or arg_17_1.state == var_0_13 then
		var_17_13:setVisible(false)
		var_17_12:setVisible(true)

		for iter_17_1 = 1, 11 do
			local var_17_14 = var_17_12:getChildByName("icon_" .. iter_17_1)
			local var_17_15 = var_17_12:getChildByName("dui_" .. iter_17_1)

			var_17_14:setTouchEnabled(false)
			var_17_15:setTouchEnabled(false)

			if arg_17_1.list[iter_17_1] then
				var_17_14:setVisible(true)
				var_17_15:setVisible(bit.band(arg_17_1.finish, var_0_21[iter_17_1]) ~= 0)
			else
				var_17_14:setVisible(false)
				var_17_15:setVisible(false)
			end
		end
	elseif arg_17_1.state == var_0_15 then
		self.btnStart:setVisible(false)
	else
		var_17_13:setVisible(false)
		var_17_12:setVisible(false)
	end

	self.btnStart:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_17_1.state == var_0_8 then
			LayerManager:pushInLayer("PopDoLayer", {
				labels = activity_manager:getServantUnlockDes(var_0_7, arg_17_1.servantid),
				surecallback = function()
					goto_complete_system({
						jump_to_system = activity_manager:getServantUnlockjump(var_0_7, arg_17_1.servantid)
					})
				end
			})
		elseif arg_17_1.state == var_0_9 then
			activity_manager:change_activity_study(var_0_7, arg_17_1.servantid)
		elseif arg_17_1.state == var_0_10 then
			LayerManager:pushInLayer("PopStudyTaskLayer", arg_17_1)
		elseif arg_17_1.state == var_0_11 then
			activity_manager:finish_activity_study(var_0_7)
		elseif arg_17_1.state == var_0_12 then
			activity_manager:change_activity_study(var_0_7, arg_17_1.servantid)
		elseif arg_17_1.state == var_0_13 then
			LayerManager:pushInLayer("PopStudyTaskLayer", arg_17_1)
		elseif arg_17_1.state == var_0_14 then
			activity_manager:finish_activity_study(var_0_7)
		elseif arg_17_1.state == var_0_15 then
			global_ShowBlockWords(L_CHANGE_ACTIVITY_STUDY[var_0_15])
		end
	end)

	local var_17_16 = self.soulPanel:getChildByName("btn_task")

	var_17_16:setVisible(false)

	if not arg_17_1.batchid or arg_17_1.batchid <= 1 then
		var_17_16:loadTextures("SchoolSturdyLayer/btn_task_1.png", nil, "SchoolSturdyLayer/btn_task_1.png", var_0_0)
	else
		var_17_16:loadTextures("SchoolSturdyLayer/btn_task_2.png", nil, "SchoolSturdyLayer/btn_task_2.png", var_0_0)
	end

	var_17_16:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopStudyTaskLayer", arg_17_1)
	end)
	var_17_0:setTouchEnabled(true)
	var_17_0:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("EquipLayer", {
			cursoul = arg_17_1.servantid
		})
	end)
end

function SchoolStudyLayer:showStudyEffect(arg_23_1)
	local var_23_0 = ccui.ImageView:create("SchoolSturdyLayer/effect_bg_" .. arg_23_1 .. ".png", var_0_0)
	local var_23_1 = ccui.ImageView:create("SchoolSturdyLayer/effect_" .. arg_23_1 .. ".png", var_0_0)

	var_23_0:setPosition(cc.p(320, GameDisplay.height / 2 - GameDisplay.fix_y))
	self.rootLayer:addChild(var_23_0)
	var_23_1:setAnchorPoint(cc.p(1, 0.5))
	var_23_1:setPosition(cc.p(0, GameDisplay.height / 2 - GameDisplay.fix_y))
	self.rootLayer:addChild(var_23_1)
	var_23_0:setOpacity(0)
	var_23_0:runAction(cc.Sequence:create(cc.FadeIn:create(0.1), cc.DelayTime:create(1), cc.FadeOut:create(0.6), cc.RemoveSelf:create()))
	var_23_1:runAction(cc.Sequence:create(cc.MoveBy:create(0.5, cc.p(640, 0)), cc.DelayTime:create(0.5), cc.MoveBy:create(0.6, cc.p(640, 0)), cc.RemoveSelf:create()))
end
