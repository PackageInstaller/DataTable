TwisteggLayer = class("TwisteggLayer", function()
	return cc.Layer:create()
end)

local network = require("network.network")

require("view.Layer.PopLayer")
require("view.Layer.TopcostLayer")
require("view.Layer.ListButtonLayer")
require("view.Layer.DropDetailsLayer")
require("view.Layer.DetailsofHelpGirlLayer")
require("controller.goto_system_manager")
require("view.Sprite.ConfirmDialogSprite")

local RichTextPro = require("view.Sprite.RichTextPro")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local horcrux_manager = require("controller.horcrux_manager")
local audio_manager = require("controller.audio_manager")
local component_manager = require("controller.component_manager")
local twist_manager = require("controller.twist_manager")
local weapon_manager = require("controller.weapon_manager")
local level_manager = require("controller.level_manager")
local autopop_manager = require("controller.autopop_manager")
local l2utils = require("controller.l2utils")
local time_check_manager = require("controller.time_check_manager")
local alert_manager = require("controller.alert_manager")
local activity_manager = require("controller.activity_manager")
local bond_manager = require("controller.bond_manager")
local hexie_manager = require("controller.hexie_manager")
local item_data = require("data.item_data")
local horcrux_data = require("data.horcrux_data")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local total_skill_data = require("data.total_skill_data")
local drop_data = require("data.drop_data")
local drop_manager = require("controller.drop_manager")
local var_0_25
local TwistList = require("view.Sprite.TwistList")
local var_0_27 = config._DEBUG and 0 or 1
local var_0_28 = 1
local var_0_29 = 2
local var_0_30 = 3
local var_0_31 = 1
local var_0_32 = 4
local var_0_35 = 150
local var_0_36 = {
	[TWISTEGGS_TYPE.normal] = L_TWISTEGG_FAIL_WORD.normal,
	[TWISTEGGS_TYPE.wind] = L_TWISTEGG_FAIL_WORD.wind,
	[TWISTEGGS_TYPE.fire] = L_TWISTEGG_FAIL_WORD.fire,
	[TWISTEGGS_TYPE.water] = L_TWISTEGG_FAIL_WORD.water,
	[TWISTEGGS_TYPE.light] = L_TWISTEGG_FAIL_WORD.light,
	[TWISTEGGS_TYPE.dark] = L_TWISTEGG_FAIL_WORD.dark,
	[TWISTEGGS_TYPE.recommend] = L_TWISTEGG_FAIL_WORD.recommend
}
local var_0_40 = 1
local var_0_43 = 0
local var_0_45 = 2

require("view.Layer.TwisteggLayerResult")
require("view.Layer.TwisteggLayerMove")

local function var_0_46(arg_2_0)
	local var_2_0 = arg_2_0 - time_check_manager:getCurTime()

	if var_2_0 < 0 then
		return
	end

	return var_2_0 > 86400 and string.format(L_TIME_FORMAT[1], math.floor(var_2_0 / 86400), math.floor(var_2_0 % 86400 / 3600)) or var_2_0 > 3600 and string.format(L_TIME_FORMAT[2], math.floor(var_2_0 / 3600), math.floor(var_2_0 % 3600 / 60)) or string.format(L_TIME_FORMAT[5], math.floor(var_2_0 / 60), math.floor(var_2_0 % 60))
end

function TwisteggLayer:getExitParam()
	return cloneconf(self.initconfig)
end

function TwisteggLayer.createRoot(arg_4_0)
	return (TwisteggLayer.new())
end

function TwisteggLayer.create(arg_5_0, arg_5_1)
	local var_5_0 = TwisteggLayer.new()

	var_5_0:setName("TwisteggLayer")
	var_5_0:init(arg_5_1)

	return var_5_0
end

function TwisteggLayer.getInstance()
	return var_0_25
end

function TwisteggLayer:init(arg_7_1)
	TextureManager:loadLayerTextures({
		"Array"
	})

	self._lockguide = false
	var_0_25 = self
	self.exitCallback = nil
	self.initConfig = arg_7_1

	if arg_7_1 then
		self.exitCallback = arg_7_1.exitCallback
	end

	if arg_7_1 then
		self.initTwisType = arg_7_1.initTwisType
	end

	self.returnLayer = arg_7_1 and (arg_7_1.returnLayer or "MainLayer") or "MainLayer"
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TwistEgg.json" or "TwistEgg.ExportJson")

	self:addChild(self.rootLayer)

	self.clipPanel = self.rootLayer:getChildByName("Panel_clip")
	self.oneBtn = self.rootLayer:getChildByName("Button_one")
	self.tenBtn = self.rootLayer:getChildByName("Button_ten")
	self.restImg = self.rootLayer:getChildByName("img_rest_times")
	self.selectPanel = self.rootLayer:getChildByName("Panel_select")
	self.showPanel = self.rootLayer:getChildByName("Panel_show")
	self.skipBnt = self.rootLayer:getChildByName("Button_skip")

	self.skipBnt:setScale(1.2)

	self.pointsPanel = ccui.Layout:create()

	self.rootLayer:addChild(self.pointsPanel)
	self:initShowResultPanel()

	self.returnBnt = self.rootLayer:getChildByName("Bottom_bg"):getChildByName("Button_return")

	self.rootLayer:getChildByName("Bottom_bg"):setTouchEnabled(true)
	self:registerReturnEvent()

	self.curTwistIndex = 1
	self.curShowType = 2
	self.totalShowPage = 4
	self.isAlowOtherTouch = true
	self.naiveTwistTime = 0

	self:initUI()
	self:registerTouchEvent()
	self:fullScreen()
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			var_0_25 = nil

			if self.showAniScheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.showAniScheduler)
			end

			alert_manager:unregister_alert(ALERT_TWIST_TEN)
			RoleDefault:getInstance():setBoolForKey("TWIST_IS_TEN", false)
			TextureManager:removeSpineTexturesWithOutCollect()
			TextureManager:removeLayerTextures({
				"Array"
			})

			if not twist_manager:checkIsAlertNew() then
				alert_manager:unregister_alert(ALERT_NEW_TWIST)
			end

			activity_manager:releaseEventListenerByName("TwisteggLayer")
		end
	end)
	self:initPurchaseEventListener()
end

function TwisteggLayer:initUI()
	self.curtwistData = {}
	self.twist_type_to_index = {}
	self.isCanChangeTwist = true
	self._canAnim = true
	self.twistLists = {}

	self.rootLayer:setVisible(false)
	twist_manager:get_twist_status(function()
		self.rootLayer:setVisible(true)

		self.twist_type_to_index = twist_manager:get_twist_type_to_index()
		self.twistConfig = twist_manager:get_twist_config_data()
		self.change_twist_tbl = twist_manager:get_change_twist_tbl()

		if self.initTwisType and self.twist_type_to_index[self.initTwisType] then
			self.curShowType = twist_manager:get_twist_showtype(self.initTwisType)
			self.curTwistIndex = self.twist_type_to_index[self.initTwisType]
		elseif self.twist_type_to_index[2] then
			self.curShowType = twist_manager:get_twist_showtype(2)
			self.curTwistIndex = self.twist_type_to_index[2]
		elseif self.twist_type_to_index[26] then
			self.curShowType = twist_manager:get_twist_showtype(26)
			self.curTwistIndex = self.twist_type_to_index[26]
		elseif self.twist_type_to_index[27] then
			self.curShowType = twist_manager:get_twist_showtype(27)
			self.curTwistIndex = self.twist_type_to_index[27]
		elseif self.twist_type_to_index[28] then
			self.curShowType = twist_manager:get_twist_showtype(28)
			self.curTwistIndex = self.twist_type_to_index[28]
		else
			self.curShowType = twist_manager:get_init_show_twist()
			self.curTwistIndex = 1
		end

		if self.initTwisType and not self.twist_type_to_index[self.initTwisType] and self.change_twist_tbl[self.initTwisType] then
			self.curShowType = self.change_twist_tbl[self.initTwisType].showtype
			self.curTwistIndex = self.change_twist_tbl[self.initTwisType].index

			if self.change_twist_tbl[self.initTwisType].sourcetype ~= self.change_twist_tbl[self.initTwisType].targettype then
				twist_manager:change_selectup_twist(self.initTwisType)
			end
		end

		self:initSelectShowButtonByTwistStatus()
		self:initCachePanelPosList()
		self:registBtnTimesEvent()
		self:updateSelectShowPanel(self.curShowType)
		self:setAnimController()
		self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			self:updateGuidesOnLayer()
		end)))
	end)
	self:initCachePanel()
	self:initSelectShowPanel()
	self:initSelectUpUI()

	local var_9_0 = ccui.ImageView:create("TwistEgg/num10.png", var_0_27)

	var_9_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_9_0:setPosition(cc.p(105, 38))
	var_9_0:setName("num_label")
	self.tenBtn:addChild(var_9_0)

	local var_9_1 = ccui.TextBMFont:create("1", "fonts/Enrollment.fnt")

	var_9_1:setAnchorPoint(1, 0.5)
	var_9_1:setPosition(cc.p(87, 40))
	var_9_1:setName("labelNum")
	self.oneBtn:addChild(var_9_1)
end

function TwisteggLayer:registerReturnEvent()
	self.returnBnt:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function TwisteggLayer:initSelectShowPanel()
	self.selectButtons = {}
	self.cachedIndex = {}

	table.insert(self.selectButtons, self.selectPanel:getChildByName("btn_normal"))
	table.insert(self.selectButtons, self.selectPanel:getChildByName("btn_special"))
	table.insert(self.selectButtons, self.selectPanel:getChildByName("btn_birthday"))
	table.insert(self.selectButtons, self.selectPanel:getChildByName("btn_selectup"))
	table.insert(self.selectButtons, self.selectPanel:getChildByName("btn_link"))

	for iter_14_0, iter_14_1 in ipairs(self.selectButtons) do
		iter_14_1:addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if iter_14_0 == self.curShowType then
				return
			end

			if not self:checkTouchEnabled() then
				return
			end

			if self.twistList then
				self.twistList:setVisible(false)
			end

			if self.curTwistIndex then
				self.cachedIndex[self.curShowType] = self.curTwistIndex
			end

			self.curShowType = iter_14_0
			self.curTwistIndex = self.cachedIndex[iter_14_0] or 1

			self:updateSelectShowPanel(iter_14_0)
		end)
	end
end

local var_0_47 = {
	{
		{
			"TwistEgg/btn_normal_select_2.png",
			"TwistEgg/btn_normal_unselect_2.png"
		},
		{
			"TwistEgg/btn_special_select_2.png",
			"TwistEgg/btn_special_unselect_2.png"
		},
		{
			"TwistEgg/btn_birthday_select_2.png",
			"TwistEgg/btn_birthday_unselect_2.png"
		},
		{
			"TwistEgg/btn_selectup_select_2.png",
			"TwistEgg/btn_selectup_unselect_2.png"
		},
		{
			"TwistEgg/btn_link_select_2.png",
			"TwistEgg/btn_link_unselect_2.png"
		},
		width = 320
	},
	{
		{
			"TwistEgg/btn_normal_select_2.png",
			"TwistEgg/btn_normal_unselect_2.png"
		},
		{
			"TwistEgg/btn_special_select_2.png",
			"TwistEgg/btn_special_unselect_2.png"
		},
		{
			"TwistEgg/btn_birthday_select_2.png",
			"TwistEgg/btn_birthday_unselect_2.png"
		},
		{
			"TwistEgg/btn_selectup_select_2.png",
			"TwistEgg/btn_selectup_unselect_2.png"
		},
		{
			"TwistEgg/btn_link_select_2.png",
			"TwistEgg/btn_link_unselect_2.png"
		},
		width = 320
	},
	{
		{
			"TwistEgg/btn_normal_select_3.png",
			"TwistEgg/btn_normal_unselect_3.png"
		},
		{
			"TwistEgg/btn_special_select_3.png",
			"TwistEgg/btn_special_unselect_3.png"
		},
		{
			"TwistEgg/btn_birthday_select_3.png",
			"TwistEgg/btn_birthday_unselect_3.png"
		},
		{
			"TwistEgg/btn_selectup_select_3.png",
			"TwistEgg/btn_selectup_unselect_3.png"
		},
		{
			"TwistEgg/btn_link_select_3.png",
			"TwistEgg/btn_link_unselect_3.png"
		},
		width = 214
	},
	{
		{
			"TwistEgg/btn_normal_select_4.png",
			"TwistEgg/btn_normal_unselect_4.png"
		},
		{
			"TwistEgg/btn_special_select_4.png",
			"TwistEgg/btn_special_unselect_4.png"
		},
		{
			"TwistEgg/btn_birthday_select_4.png",
			"TwistEgg/btn_birthday_unselect_4.png"
		},
		{
			"TwistEgg/btn_selectup_select_4.png",
			"TwistEgg/btn_selectup_unselect_4.png"
		},
		{
			"TwistEgg/btn_link_select_4.png",
			"TwistEgg/btn_link_unselect_4.png"
		},
		width = 160
	},
	{
		{
			"TwistEgg/btn_normal_select_5.png",
			"TwistEgg/btn_normal_unselect_5.png"
		},
		{
			"TwistEgg/btn_special_select_5.png",
			"TwistEgg/btn_special_unselect_5.png"
		},
		{
			"TwistEgg/btn_birthday_select_5.png",
			"TwistEgg/btn_birthday_unselect_5.png"
		},
		{
			"TwistEgg/btn_selectup_select_5.png",
			"TwistEgg/btn_selectup_unselect_5.png"
		},
		{
			"TwistEgg/btn_link_select_5.png",
			"TwistEgg/btn_link_unselect_5.png"
		},
		width = 128
	}
}

function TwisteggLayer:initSelectShowButtonByTwistStatus()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self.selectButtons) do
		if twist_manager:is_have_twist(iter_16_0) then
			iter_16_1:setVisible(true)
			table.insert(var_16_0, iter_16_1)
		else
			iter_16_1:setVisible(false)
		end
	end

	for iter_16_2, iter_16_3 in ipairs(var_16_0) do
		iter_16_3:setPositionX(640 - var_0_47[#var_16_0].width / 2 - (#var_16_0 - iter_16_2) * var_0_47[#var_16_0].width)
	end

	self.totalShowPage = #var_16_0
end

function TwisteggLayer:updateSelectShowPanel(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(self.selectButtons) do
		if iter_17_0 == arg_17_1 then
			iter_17_1:loadTextures(var_0_47[self.totalShowPage][iter_17_0][1], var_0_47[self.totalShowPage][iter_17_0][1], var_0_47[self.totalShowPage][iter_17_0][1], var_0_27)
		else
			iter_17_1:loadTextures(var_0_47[self.totalShowPage][iter_17_0][2], var_0_47[self.totalShowPage][iter_17_0][1], var_0_47[self.totalShowPage][iter_17_0][2], var_0_27)
		end
	end

	self.curtwistData = twist_manager:get_twist_list(self.curShowType)

	self:updateTwistMain()
	self:updateTwistCache()
	self:initTwistList()
end

function TwisteggLayer:initTwistList()
	self.twistList = self.twistLists[self.curShowType]

	if self.twistList then
		self.twistList:setVisible(true)

		self.nowListNode = self.twistList:getNodeObjBytwistIndex(self.curTwistIndex)

		return
	end

	self.twistList = TwistList:create(self.curShowType)

	self.twistList:setPosition(cc.p(0, 128 - GameDisplay.fix_y))
	self.rootLayer:addChild(self.twistList, 50)

	self.twistLists[self.curShowType] = self.twistList
	self._isTwistListInAnim = false
	self.curcity = nil
	self.index_to_city = {}
	self.city_to_index = {}
	self.cities = {}

	local function var_18_0(arg_19_0, arg_19_1)
		local var_19_0 = ccui.Button:create("default/small_default.png", "default/small_default.png", "default/small_default.png", 0, true)

		var_19_0:setAnchorPoint(cc.p(0, 0))
		var_19_0:setPosition(cc.p(32.5, 21.5))
		var_19_0:setName("class_image" .. arg_19_0)

		var_19_0.twistIndex = arg_19_0
		var_19_0.imgPath = "mainScenebg/twist_bg_new/small_" .. arg_19_1.img
		var_19_0.title = self.twistConfig[self.curtwistData[arg_19_0].twistType].title or L_TWISTLAYER[1]

		var_19_0:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_20_0:getTouchBeganPosition().x - arg_20_0:getTouchEndPosition().x) >= 25 then
				return
			end

			if arg_20_0.twistIndex == self.curTwistIndex then
				return
			end

			if not self.twistList:checkTouchEnabled() then
				return
			end

			self.curTwistIndex = arg_20_0.twistIndex

			self.twistList:scrollToIndexManual(arg_20_0.twistIndex)
		end)

		if self:checkIsHaveFreeTimes(self.curtwistData[arg_19_0].twistType) then
			AlertManager:add_alert_by_config(var_19_0, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(100, var_19_0:getContentSize().height - 15)
			})
		end

		print("Twist New Check: ", self.curtwistData[arg_19_0].twistType, twist_manager:isTwistNew(self.curtwistData[arg_19_0].twistType))

		if twist_manager:isTwistNew(self.curtwistData[arg_19_0].twistType) or twist_manager:isTwistUpNew(self.curtwistData[arg_19_0].upid) then
			AlertManager:add_alert_by_config(var_19_0, true, {
				ALERT_SHOW_NEW,
				"",
				cc.p(100, var_19_0:getContentSize().height - 17)
			})
		else
			AlertManager:add_alert_by_config(var_19_0, false, {
				ALERT_SHOW_NEW,
				"",
				cc.p(100, var_19_0:getContentSize().height - 30)
			})
		end

		if var_19_0:getChildByName("alert_reddot") then
			var_19_0.isAlertReddot = true
		end

		return var_19_0
	end

	self.twistList:initTwistListCircle(#self.curtwistData)
	self.twistList:registerSelectCityHandler(function(arg_21_0, arg_21_1)
		arg_21_1.data = self.curtwistData[arg_21_0]

		if self.curtwistData[self.curTwistIndex] and twist_manager:isTwistNew(self.curtwistData[self.curTwistIndex].twistType) then
			twist_manager:markTwistOld(self.curtwistData[self.curTwistIndex].twistType)
		end

		if self.curtwistData[arg_21_0] and twist_manager:isTwistUpNew(self.curtwistData[arg_21_0].upid) then
			twist_manager:markUpOld(self.curtwistData[arg_21_0].upid)
		end

		self.lastListNode = self.nowListNode
		self.nowListNode = arg_21_1

		self:updateListReddot(nil, self.lastListNode)

		self.curTwistIndex = arg_21_0

		if not self._isCachePanelInAnim then
			self:updateTwistMain()
			self:updateTwistCache()
		end
	end)

	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(self.curtwistData) do
		local var_18_2 = var_18_0(iter_18_0, iter_18_1)

		table.insert(var_18_1, var_18_2)

		if iter_18_0 == self.curTwistIndex then
			if twist_manager:isTwistNew(iter_18_1.twistType) then
				twist_manager:markTwistOld(iter_18_1.twistType)
			end

			if twist_manager:isTwistUpNew(iter_18_1.upid) then
				twist_manager:markUpOld(iter_18_1.upid)
			end

			self.nowListNode = var_18_2
		end
	end

	self.btnList = var_18_1

	self.twistList:pushInCells(var_18_1, self.curTwistIndex)
	self.twistList:registerCheckAnimHandler(function()
		return not self._isInAnim
	end)
	self.twistList:registerAnimControllerHandler(function(arg_23_0)
		self._isTwistListInAnim = arg_23_0
	end)
	self.twistList:updateChildrenZorder()
end

function TwisteggLayer:initCachePanel()
	local var_24_0 = self.clipPanel:getParent()
	local var_24_1 = self.clipPanel:clone()
	local var_24_2 = self.clipPanel:clone()

	var_24_0:addChild(var_24_1)
	var_24_0:addChild(var_24_2)

	self.mainImgPosX = {
		self.clipPanel:getPositionX() - self.clipPanel:getContentSize().width - var_0_35,
		self.clipPanel:getPositionX(),
		self.clipPanel:getPositionX() + self.clipPanel:getContentSize().width + var_0_35
	}

	var_24_1:setPositionX(self.mainImgPosX[1])
	var_24_2:setPositionX(self.mainImgPosX[3])

	self.cachePanelList = {}

	table.insert(self.cachePanelList, var_24_1)
	table.insert(self.cachePanelList, self.clipPanel)
	table.insert(self.cachePanelList, var_24_2)
	self:initDetailBtn()
	self:initMainTouchEvent()
end

function TwisteggLayer:initDetailBtn()
	for iter_25_0, iter_25_1 in ipairs(self.cachePanelList) do
		iter_25_1:getChildByName("btn_detail"):addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_26_0:isBright() then
				return
			end

			arg_26_0:setBright(true)
			self:showTwistEggDrops(self.curtwistData[self.curTwistIndex].twistType, arg_26_0)
		end)
	end
end

function TwisteggLayer:initMainTouchEvent()
	for iter_27_0, iter_27_1 in ipairs(self.cachePanelList) do
		local var_27_0 = iter_27_1:getChildByName("image_main")
		local var_27_1 = iter_27_1:getChildByName("image_title")

		var_27_0:setSwallowTouches(false)
		var_27_0:addTouchEventListener(function(arg_28_0, arg_28_1)
			local var_28_0

			if arg_28_1 ~= ccui.TouchEventType.ended then
				do return end

				var_28_0 = arg_28_0:getTouchEndPosition()
			end

			if math.abs(arg_28_0:getTouchBeganPosition().x - var_28_0.x) >= 50 then
				return
			end

			if hexie_manager:isChannelInShenheTime() then
				return
			end

			local var_28_1 = self.curtwistData[self.curTwistIndex].twistType

			if twist_manager:is_selectup_twist(self.curtwistData[self.curTwistIndex].twistType) then
				if twist_manager:get_twist_selectup_uitype(var_28_1) == 2 then
					self:changeSelectUpOnUIType2(var_28_1, var_28_0)
				else
					return
				end
			end

			local var_28_2 = twist_manager:get_single_servantup(var_28_1)

			if not var_28_2 then
				twist_manager:get_twist_drop_info(var_28_1, function(arg_29_0, arg_29_1)
					if arg_29_0 ~= 1 then
						return
					end

					LayerManager:pushInLayer("DropDetailsLayer", arg_29_1)
				end)
			else
				LayerManager:pushInLayer("SoulsLayer", {
					showtype = SHOW_TYPE_TWISTEGG_PREVIEW,
					cursoul = var_28_2
				})
			end
		end)
		var_27_1:addTouchEventListener(function(arg_30_0, arg_30_1)
			if arg_30_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_30_0:getTouchBeganPosition().x - arg_30_0:getTouchEndPosition().x) >= 50 then
				return
			end

			self:showTwistEggDrops(self.curtwistData[self.curTwistIndex].twistType)
		end)
	end
end

function TwisteggLayer:updateTwistlist()
	for iter_31_0, iter_31_1 in ipairs(self.btnList) do
		if self.curTwistIndex == iter_31_0 then
			iter_31_1.imgPath = "mainScenebg/twist_bg_new/small_" .. self.curtwistData[self.curTwistIndex].img
		end
	end

	self.twistList:updateChildrenZorder()
	self.twistList:updateTitle(1)
end

function TwisteggLayer:updateTwistMain()
	self.configData = twist_manager:get_data_by_type(self.curtwistData[self.curTwistIndex].twistType)

	hx_print("蛋池id:" .. self.curtwistData[self.curTwistIndex].twistType, CONSOLE_COLOR_GREEN)

	self.twistBlackCard = self.curtwistData[self.curTwistIndex].blackcard_type
	self.cachePanelList[2].curTwistIndex = self.curTwistIndex

	self:updateClipPanelUI(self.curtwistData[self.curTwistIndex].twistType, self.cachePanelList[2])
	self:updateCostInfo(self.curtwistData[self.curTwistIndex].twistType)
	self:updateTimePanel()
	self:updateByBlackCard(self.curtwistData[self.curTwistIndex].twistType)
	self:updateUpcount(self.curtwistData[self.curTwistIndex])
	self:updateUnlock(self.curtwistData[self.curTwistIndex].twistType)
	self:showTwistRemainCountLabel(self.curtwistData[self.curTwistIndex].twist_remain_count, self.curtwistData[self.curTwistIndex].twistType)
	self:checkBtnsAlert("oneBtn", self.cachePanelList[2])
	self:checkBtnsAlert("tenBtn", self.cachePanelList[2])
	self:updateNoUpdropReward(self.curtwistData[self.curTwistIndex], self.curtwistData[self.curTwistIndex].twistType)

	if self.curtwistData[self.curTwistIndex].twistType ~= 26 then
		self:testPrint(self.curtwistData[self.curTwistIndex].twistType)
	end

	AnalyticManager.browseTwist(self.curtwistData[self.curTwistIndex].twistType)

	if twist_manager:is_selectup_twist(self.curtwistData[self.curTwistIndex].twistType) and twist_manager:get_twist_selectup_uitype(self.curtwistData[self.curTwistIndex].twistType) == 3 then
		local var_32_0 = twist_manager:get_selected_up(self.curtwistData[self.curTwistIndex].twistType)

		self.oneBtn:getChildByName("mask"):setVisible(not var_32_0)
		self.tenBtn:getChildByName("mask"):setVisible(not var_32_0)
	else
		self.oneBtn:getChildByName("mask"):setVisible(false)
		self.tenBtn:getChildByName("mask"):setVisible(false)
	end
end

local function var_0_48(arg_33_0, arg_33_1)
	return arg_33_0 - 1 < 1 and arg_33_1 or arg_33_0 - 1, arg_33_1 < arg_33_0 + 1 and 1 or arg_33_0 + 1
end

function TwisteggLayer:updateTwistCache()
	local var_34_2, var_34_3 = var_0_48(self.curTwistIndex, #self.curtwistData)

	self:updateTwistLeftCache(var_34_2)
	self:updateTwistRightCache(var_34_3)

	self.updateClipPanelTimes = 1
end

function TwisteggLayer:updateTwistLeftCache(arg_35_1)
	self.cachePanelList[1].curTwistIndex = arg_35_1

	self:updateClipPanelUI(self.curtwistData[arg_35_1].twistType, self.cachePanelList[1])
	self.cachePanelList[1]:getChildByName("rightBtnListPanel"):setOpacity(0)
	self.cachePanelList[1]:getChildByName("rightBtnListPanel"):setVisible(false)
end

function TwisteggLayer:updateTwistRightCache(arg_36_1)
	self.cachePanelList[3].curTwistIndex = arg_36_1

	self:updateClipPanelUI(self.curtwistData[arg_36_1].twistType, self.cachePanelList[3])
	self.cachePanelList[3]:getChildByName("rightBtnListPanel"):setOpacity(0)
	self.cachePanelList[3]:getChildByName("rightBtnListPanel"):setVisible(false)
end

function TwisteggLayer:updateClipPanelUI(arg_37_1, arg_37_2)
	if twist_manager:is_new_selectup_twist(arg_37_1) or twist_manager:is_selectup_twist(arg_37_1) then
		self:updateClipPanelUIOnSelectUps(arg_37_1, arg_37_2)
	else
		self:updateClipPanelUIOnNormal(arg_37_1, arg_37_2)
	end
end

function TwisteggLayer:updateClipPanelUIOnSelectUps(arg_38_1, arg_38_2)
	local var_38_0 = twist_manager:get_twist_selectup_uitype(arg_38_1)
	local var_38_1 = twist_manager:get_data_by_type(arg_38_1)

	if var_38_0 == 1 then
		self:updateClipPanelUIOnSelectUpsType1(arg_38_1, arg_38_2)
	elseif var_38_0 == 2 then
		self:updateClipPanelUIOnSelectUpsType2(arg_38_1, arg_38_2)
	elseif var_38_0 == 3 then
		self:updateClipPanelUIOnSelectUpsType3(arg_38_1, arg_38_2)
	elseif var_38_0 == 6 then
		self:updateClipPanelUIOnNormal(arg_38_1, arg_38_2)
	else
		self:updateClipPanelUIOnSelectUpsType4(arg_38_1, arg_38_2)
	end

	if self.rootLayer:getChildByName("now_count") then
		self.rootLayer:getChildByName("now_count"):setVisible(false)
	end
end

function TwisteggLayer:updateClipPanelUIOnSelectUpsType1(arg_39_1, arg_39_2)
	self:updateMainImg("public/panelbg/text_bg.png", (arg_39_2:getChildByName("image_main")))
	self:updateBgImg(("mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_39_1]].img) .. "/bg.png", (arg_39_2:getChildByName("image_bg")))
	self:updateTitleImg(self.curtwistData[self.twist_type_to_index[arg_39_1]], (arg_39_2:getChildByName("image_title")))
	self:updateRarityImg(("mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_39_1]].img) .. "/des.png", (arg_39_2:getChildByName("image_rarity")))
	self:updateRightBtnList(arg_39_1, arg_39_2)
	arg_39_2:getChildByName("rightBtnListPanel"):getChildByName("panel"):setVisible(true)
	arg_39_2:getChildByName("btn_detail"):setVisible(false)
	self:updateSelectupPanel(arg_39_1, arg_39_2)
	self:updateOverClockUI(arg_39_1, arg_39_2)
	self:hideSelectupPanelType3(arg_39_1, arg_39_2)
	self:hideSelectupPanelType4(arg_39_1, arg_39_2)
end

function TwisteggLayer:updateClipPanelUIOnSelectUpsType2(arg_40_1, arg_40_2)
	local var_40_0 = twist_manager:get_selected_up(arg_40_1)

	self:updateMainImg(("mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_40_1]].img) .. "/main_" .. var_40_0 .. ".png", (arg_40_2:getChildByName("image_main")))
	self:updateBgImg(("mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_40_1]].img) .. "/bg.png", (arg_40_2:getChildByName("image_bg")))
	self:updateTitleImg(self.curtwistData[self.twist_type_to_index[arg_40_1]], (arg_40_2:getChildByName("image_title")))
	self:updateRarityImg(("mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_40_1]].img) .. "/des_" .. var_40_0 .. ".png", (arg_40_2:getChildByName("image_rarity")))
	self:updateRightBtnList(arg_40_1, arg_40_2)
	arg_40_2:getChildByName("rightBtnListPanel"):getChildByName("panel"):setVisible(true)
	arg_40_2:getChildByName("btn_detail"):setVisible(false)
	self:hideSelectupPanel(arg_40_1, arg_40_2)
	self:updateOverClockUI(arg_40_1, arg_40_2)
	self:hideSelectupPanelType3(arg_40_1, arg_40_2)
	self:hideSelectupPanelType4(arg_40_1, arg_40_2)
end

function TwisteggLayer:changeSelectUpOnUIType2(arg_41_1, arg_41_2)
	local var_41_0 = require("data.twist_config.twist_select_up_" .. self.curtwistData[self.twist_type_to_index[arg_41_1]].img)
	local var_41_1 = math.floor(arg_41_2.x)
	local var_41_2 = var_41_0.height - math.floor(arg_41_2.y)
	local var_41_3
	local bit

	if var_41_1 < 0 or var_41_2 < 0 or var_41_0.width < var_41_1 or var_41_0.height < var_41_2 then
		do return end

		var_41_3 = math.floor(32 / var_41_0.bitPerNum)
		bit = require("bit")
	end

	local var_41_5 = bit.band(bit.rshift(var_41_0.data[math.ceil((var_41_2 * var_41_0.width + var_41_1) / var_41_3)], (var_41_2 * var_41_0.width + var_41_1 - 1) % var_41_3 * var_41_0.bitPerNum), 3)

	if var_41_5 == 0 then
		return
	end

	local var_41_6 = twist_manager:get_selectup_list(arg_41_1)

	if var_41_6[var_41_5] == twist_manager:get_selected_up(arg_41_1) then
		return
	end

	if twist_manager:is_setting_selectup(arg_41_1) then
		return
	end

	twist_manager:set_selectups(arg_41_1, var_41_6[var_41_5])
end

function TwisteggLayer:updateClipPanelUIOnSelectUpsType3(arg_42_1, arg_42_2)
	local var_42_0 = self.curtwistData[self.twist_type_to_index[arg_42_1]]
	local var_42_1 = arg_42_2:getChildByName("image_bg")
	local var_42_2 = arg_42_2:getChildByName("image_title")
	local var_42_3 = arg_42_2:getChildByName("image_rarity")
	local var_42_4 = twist_manager:get_selected_up(arg_42_1)
	local var_42_5 = "mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_42_1]].img

	self:updateMainImg(("mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_42_1]].img) .. "/main.png", (arg_42_2:getChildByName("image_main")))

	if var_42_4 then
		self:updateBgImg(var_42_5 .. "/bg_" .. var_42_4 .. ".png", var_42_1)
	else
		self:updateBgImg(var_42_5 .. "/bg.png", var_42_1)
	end

	self:updateTitleImg(var_42_0, var_42_2)
	self:updateRarityImg(var_42_5 .. "/des.png", var_42_3)
	self:updateRightBtnList(arg_42_1, arg_42_2)
	arg_42_2:getChildByName("rightBtnListPanel"):getChildByName("panel"):setVisible(true)
	arg_42_2:getChildByName("btn_detail"):setVisible(false)
	self:hideSelectupPanel(arg_42_1, arg_42_2)
	self:updateOverClockUI(arg_42_1, arg_42_2)
	self:updateSelectupPanelType3(arg_42_1, arg_42_2)
	self:hideSelectupPanelType4(arg_42_1, arg_42_2)
end

function TwisteggLayer:updateClipPanelUIOnSelectUpsType4(arg_43_1, arg_43_2)
	local var_43_0 = self.curtwistData[self.twist_type_to_index[arg_43_1]]
	local var_43_1 = arg_43_2:getChildByName("image_bg")
	local var_43_2 = arg_43_2:getChildByName("image_title")
	local var_43_3 = arg_43_2:getChildByName("image_rarity")
	local var_43_4 = twist_manager:get_selected_up(arg_43_1)
	local var_43_5 = "mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_43_1]].img

	self:updateMainImg(("mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_43_1]].img) .. "/main.png", (arg_43_2:getChildByName("image_main")))

	if var_43_4 then
		self:updateBgImg(var_43_5 .. "/bg_" .. var_43_4 .. ".png", var_43_1)
	else
		self:updateBgImg(var_43_5 .. "/bg.png", var_43_1)
	end

	self:updateTitleImg(var_43_0, var_43_2)
	self:updateRarityImg(var_43_5 .. "/des.png", var_43_3)
	self:updateRightBtnList(arg_43_1, arg_43_2)
	arg_43_2:getChildByName("rightBtnListPanel"):getChildByName("panel"):setVisible(true)
	arg_43_2:getChildByName("btn_detail"):setVisible(false)
	self:hideSelectupPanel(arg_43_1, arg_43_2)
	self:updateOverClockUI(arg_43_1, arg_43_2)
	self:hideSelectupPanelType3(arg_43_1, arg_43_2)
	self:updateSelectupPanelType4(arg_43_1, arg_43_2)
end

function TwisteggLayer:updateClipPanelUIOnNormal(arg_44_1, arg_44_2)
	local var_44_0 = self.curtwistData[self.curTwistIndex]
	local var_44_1 = ("mainScenebg/twist_bg_new/" .. self.curtwistData[self.curTwistIndex].img) .. "/main.png"
	local var_44_2 = ("mainScenebg/twist_bg_new/" .. self.curtwistData[self.curTwistIndex].img) .. "/bg.png"
	local var_44_3 = ("mainScenebg/twist_bg_new/" .. self.curtwistData[self.curTwistIndex].img) .. "/des.png"

	if twist_manager:can_show_overclock_twist(self.curtwistData[self.curTwistIndex].twistType) and twist_manager:is_showing_overclock_now(self.curtwistData[self.curTwistIndex].twistType) then
		var_44_1 = ("mainScenebg/twist_bg_new/" .. self.curtwistData[self.curTwistIndex].img) .. "/main_oc.png"
		var_44_2 = ("mainScenebg/twist_bg_new/" .. self.curtwistData[self.curTwistIndex].img) .. "/bg_oc.png"
		var_44_3 = ("mainScenebg/twist_bg_new/" .. self.curtwistData[self.curTwistIndex].img) .. "/des_oc.png"
	end

	self:updateMainImg(var_44_1, (arg_44_2:getChildByName("image_main")))
	self:updateBgImg(var_44_2, (arg_44_2:getChildByName("image_bg")))
	self:updateTitleImg(var_44_0, (arg_44_2:getChildByName("image_title")))
	self:updateRarityImg(var_44_3, (arg_44_2:getChildByName("image_rarity")))
	self:updateRightBtnList(self.curtwistData[self.curTwistIndex].twistType, arg_44_2)
	arg_44_2:getChildByName("rightBtnListPanel"):getChildByName("panel"):setVisible(true)
	arg_44_2:getChildByName("btn_detail"):setVisible(false)
	self:hideSelectupPanel(self.curtwistData[self.curTwistIndex].twistType, arg_44_2)
	self:updateOverClockUI(self.curtwistData[self.curTwistIndex].twistType, arg_44_2)
	self:hideSelectupPanelType3(self.curtwistData[self.curTwistIndex].twistType, arg_44_2)
	self:hideSelectupPanelType4(self.curtwistData[self.curTwistIndex].twistType, arg_44_2)

	if var_44_0.upitems and #var_44_0.upitems == 1 then
		if not item_data[var_44_0.upitems[1]].servant then
			return
		end

		local souls_manager = require("controller.souls_manager")
		local core_manager = require("controller.core_manager")
		local var_44_6 = item_data[var_44_0.upitems[1]].servant
		local var_44_7 = playermodel.soulContract[item_data[var_44_0.upitems[1]].servant]
		local var_44_8

		if playermodel.soulContract[item_data[var_44_0.upitems[1]].servant] == -1 then
			var_44_8 = L_TWIST_NO_COUNT_NOW or L_TWIST_COUNT_NOW[var_44_7]
		end

		local var_44_9 = var_44_7 == -1 and 60 or 10
		local var_44_10 = math.max(var_44_7, 0)
		local var_44_11 = var_44_10 == 5
		local var_44_12 = core_manager:getUpgradeCostRoleCardNum(var_44_6, var_44_10 + 1) or 0
		local var_44_13 = playermodel.servantNum[var_44_6]
		local var_44_14

		if servant_data[var_44_6].studentCard then
			var_44_14 = item_manager:getItemNumber(servant_data[var_44_6].studentCard) / servant_data[var_44_6].studentCardRate or 0
		end

		local var_44_15 = souls_manager:check_is_can_OC(var_44_6)
		local var_44_17 = string.format(var_44_8, var_44_13 + var_44_14 .. "/" .. ((var_44_15 or nil) and (core_manager:getOcCostCardNum(var_44_6, (playermodel.soulOverClock[var_44_6] or 0) + 1) or 0)))
		local var_44_18 = item_manager:getItemNumber(var_44_0.upitems[1])
		local var_44_19 = self.rootLayer:getChildByName("now_count")

		if not var_44_19 then
			var_44_19 = ccui.ImageView:create("TwistEgg/now_count.png", var_0_27)

			var_44_19:setName("now_count")
			var_44_19:setAnchorPoint(1, 0.5)
			var_44_19:setPosition(GameDisplay.width, 400 - GameDisplay.fix_y)
			self.rootLayer:addChild(var_44_19)

			local var_44_21 = RichTextPro:create()

			var_44_21:setFontName(FONT_BUTTON)
			var_44_21:setSize(19)
			var_44_21:setLineSpace(0)
			var_44_21:setName("richText")
			var_44_19:addChild(var_44_21)
		end

		var_44_19:getChildByName("richText"):clearText()
		var_44_19:getChildByName("richText"):setText(var_44_17)
		var_44_19:getChildByName("richText"):setPosition(var_44_9, 28)
		var_44_19:setVisible(not var_44_11 or var_44_15)
	elseif self.rootLayer:getChildByName("now_count") then
		self.rootLayer:getChildByName("now_count"):setVisible(false)
	end
end

function TwisteggLayer:updateOverClockUI(arg_45_1, arg_45_2)
	if twist_manager:is_selectup_twist(arg_45_1) then
		self:hideOverClockUI(arg_45_1, arg_45_2)

		return
	end

	if twist_manager:can_show_overclock_twist(arg_45_1) then
		self:showOverClockUI(arg_45_1, arg_45_2)
	else
		self:hideOverClockUI(arg_45_1, arg_45_2)
	end
end

function TwisteggLayer.hideOverClockUI(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_2:getChildByName("overclock") then
		arg_46_2:getChildByName("overclock"):getChildByName("btnSwitch"):setVisible(false)
	end
end

function TwisteggLayer.showOverClockUI(arg_47_0, arg_47_1, arg_47_2)
	if not arg_47_2:getChildByName("overclock") then
		local var_47_0 = cc.Node:create()

		var_47_0:setName("overclock")
		var_47_0:setPosition(0, -GameDisplay.fix_y)
		arg_47_2:addChild(var_47_0, 50)

		local var_47_1 = ccui.Button:create("TwistEgg/btn_switchnormal.png", "TwistEgg/btn_switchnormal.png", "TwistEgg/btn_switchnormal.png", var_0_27)

		var_47_1:setPosition(cc.p(120, 380))
		var_47_1:setName("btnSwitch")
		var_47_0:addChild(var_47_1)
	end

	local var_47_2 = arg_47_2:getChildByName("overclock"):getChildByName("btnSwitch")

	var_47_2:setVisible(true)

	if twist_manager:is_showing_overclock_now(arg_47_1) then
		var_47_2:loadTextures("TwistEgg/btn_switchnormal.png", "TwistEgg/btn_switchnormal.png", "TwistEgg/btn_switchnormal.png", var_0_27)
	else
		var_47_2:loadTextures("TwistEgg/btn_switchoc.png", "TwistEgg/btn_switchoc.png", "TwistEgg/btn_switchoc.png", var_0_27)
	end

	var_47_2:addTouchEventListener(function(arg_48_0, arg_48_1)
		if arg_48_1 ~= ccui.TouchEventType.ended then
			return
		end

		twist_manager:show_twist_overclock(arg_47_1, not twist_manager:is_showing_overclock_now(arg_47_1))
		arg_47_0:updateTwistMain()
	end)
end

local var_0_49 = {
	{
		320
	},
	{
		158,
		474
	},
	{
		106,
		320,
		534
	},
	{
		80,
		240,
		400,
		560
	}
}

function TwisteggLayer:initSelectUpUI()
	local var_49_0 = self:getEventDispatcher()

	var_49_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("ON_SET_TWIST_NEW_SELECTUP", function(arg_50_0)
		self.curTwistIndex = arg_50_0.index

		self:updateTwistMain()
	end), self)
	var_49_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("ON_SET_TWIST_SELECTUP", function(arg_51_0)
		if arg_51_0.twisttype ~= self.curtwistData[self.curTwistIndex].twistType then
			return
		end

		self:updateTwistMain()
		self:updateSelectSoftPanel(self.curtwistData[self.curTwistIndex].twistType)
	end), self)
end

function TwisteggLayer:updateSelectupPanel(arg_52_1, arg_52_2)
	if not arg_52_2:getChildByName("image_main"):getChildByName("selectuppanel") then
		self:createSelectupPanel(arg_52_2)
	end

	local var_52_0 = arg_52_2:getChildByName("image_main"):getChildByName("selectuppanel")

	var_52_0:setVisible(true)

	local var_52_1 = twist_manager:get_selectup_list(arg_52_1)
	local var_52_2 = #var_52_1

	var_52_0.selectedup = twist_manager:get_selected_up(arg_52_1)

	local function var_52_3()
		for iter_53_0 = 1, 4 do
			local var_53_0 = var_52_0:getChildByName("button" .. iter_53_0)

			if iter_53_0 <= var_52_2 then
				var_53_0:setVisible(true)
				var_53_0:setPosition(cc.p(var_0_49[var_52_2][iter_53_0], GameDisplay.cy + 165 - GameDisplay.fix_y))
				var_53_0:update(var_52_1[iter_53_0], var_52_2, var_52_0.selectedup == var_52_1[iter_53_0])
			else
				var_53_0:setVisible(false)
			end
		end
	end

	local function var_52_4(arg_54_0)
		var_52_0.selectedup = arg_54_0

		var_52_3()
		twist_manager:set_selectups(arg_52_1, arg_54_0)
	end

	for iter_52_0 = 1, 4 do
		var_52_0:getChildByName("button" .. iter_52_0):registerTouchEvent(var_52_4)
	end

	var_52_3()
end

function TwisteggLayer.hideSelectupPanel(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_2:getChildByName("image_main"):getChildByName("selectuppanel") then
		arg_55_2:getChildByName("image_main"):getChildByName("selectuppanel"):setVisible(false)
	end
end

function TwisteggLayer.createSelectupPanel(arg_56_0, arg_56_1)
	local var_56_0 = ccui.Layout:create()

	var_56_0:setPosition(cc.p(arg_56_1:getChildByName("image_main"):getContentSize().width / 2 - GameDisplay.cx, 0))
	var_56_0:setName("selectuppanel")
	arg_56_1:getChildByName("image_main"):addChild(var_56_0)

	local TwistSelectUpButton = require("view.Sprite.TwistSelectUpButton")

	for iter_56_0 = 1, 4 do
		local var_56_2 = TwistSelectUpButton:create()

		var_56_2:setName("button" .. iter_56_0)
		var_56_2:setPosition(cc.p(80 + 160 * (iter_56_0 - 1), GameDisplay.cy + 165 - GameDisplay.fix_y))
		var_56_0:addChild(var_56_2)
	end

	local var_56_3 = ccui.ImageView:create("TwistEgg/img_selectup_des.png", var_0_27)

	var_56_3:setAnchorPoint(cc.p(0, 0.5))
	var_56_3:setPosition(cc.p(150, 1060 + GameDisplay.fix_y))
	var_56_0:addChild(var_56_3)
end

function TwisteggLayer:updateSelectupPanelType3(arg_57_1, arg_57_2)
	if not arg_57_2:getChildByName("image_rarity"):getChildByName("selectuppaneltype3") then
		self:createSelectupPanelType3(arg_57_2)
	end

	local var_57_0 = arg_57_2:getChildByName("image_rarity"):getChildByName("selectuppaneltype3")

	var_57_0:setVisible(true)

	if not twist_manager:get_selected_up(arg_57_1) then
		var_57_0:getChildByName("btn_sure"):loadTextures("TwistEgg/btn_selectup.png", "TwistEgg/btn_selectup.png", "TwistEgg/btn_selectup.png", var_0_27)
	else
		var_57_0:getChildByName("btn_sure"):loadTextures("TwistEgg/btn_checkup.png", "TwistEgg/btn_checkup.png", "TwistEgg/btn_checkup.png", var_0_27)
	end

	var_57_0:getChildByName("btn_sure"):addTouchEventListener(function(arg_58_0, arg_58_1)
		if arg_58_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:createSelectupList(arg_57_1)
	end)
end

function TwisteggLayer:updateSelectupPanelType4(arg_59_1, arg_59_2)
	local var_59_0 = arg_59_2:getChildByName("image_rarity"):getChildByName("selectuppaneltype4")

	if not var_59_0 then
		self:createSelectupPanelType4(arg_59_2)
	else
		var_59_0:getChildByName("change"):setPosition(cc.p(74, GameDisplay.height - 230))
	end

	local var_59_1 = arg_59_2:getChildByName("image_rarity"):getChildByName("selectuppaneltype4")

	var_59_1:setVisible(true)
	var_59_1:getChildByName("change"):getChildByName("lbl_btn"):setString((arg_59_1 == 512 or nil) and L_TWISTEGG_CHANGE[2])
	var_59_1:getChildByName("change"):addTouchEventListener(function(arg_60_0, arg_60_1)
		if arg_60_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:createThemeList(arg_59_1)
	end)
end

function TwisteggLayer.hideSelectupPanelType3(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_2:getChildByName("image_rarity"):getChildByName("selectuppaneltype3") then
		arg_61_2:getChildByName("image_rarity"):getChildByName("selectuppaneltype3"):setVisible(false)
	end
end

function TwisteggLayer.createSelectupPanelType3(arg_62_0, arg_62_1)
	local var_62_0 = ccui.Layout:create()

	var_62_0:setPosition(cc.p(0, 0))
	var_62_0:setName("selectuppaneltype3")
	arg_62_1:getChildByName("image_rarity"):addChild(var_62_0)

	local var_62_1 = ccui.Button:create("TwistEgg/btn_selectup.png", "TwistEgg/btn_selectup.png", "TwistEgg/btn_selectup.png", var_0_27)

	var_62_1:setName("btn_sure")
	var_62_1:setPosition(cc.p(GameDisplay.cx, 1100 - GameDisplay.cy))
	var_62_0:addChild(var_62_1, 2)
end

function TwisteggLayer.hideSelectupPanelType4(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_2:getChildByName("image_rarity"):getChildByName("selectuppaneltype4") then
		arg_63_2:getChildByName("image_rarity"):getChildByName("selectuppaneltype4"):setVisible(false)
	end
end

function TwisteggLayer:createSelectupPanelType4(arg_64_1)
	local var_64_0 = ccui.Layout:create()

	var_64_0:setPosition(cc.p(0, 0))
	var_64_0:setName("selectuppaneltype4")
	arg_64_1:getChildByName("image_rarity"):addChild(var_64_0)

	local var_64_1 = ccui.Button:create("TwistEgg/twist_chang.png", "TwistEgg/twist_chang.png", "TwistEgg/twist_chang.png", var_0_27)

	var_64_1:setName("change")
	var_64_1:setPosition(cc.p(74, GameDisplay.height - 230))
	var_64_0:addChild(var_64_1, 2)

	local var_64_3 = cc.Label:createWithTTF((self.curtwistData[self.curTwistIndex].twistType == 512 or nil) and L_TWISTEGG_CHANGE[2], FONT_BUTTON, 21)

	var_64_3:setColor(cc.WHITE)
	var_64_3:setPosition(cc.p(var_64_1:getContentSize().width / 2 + 15, var_64_1:getContentSize().height / 2 + 6))
	var_64_3:setName("lbl_btn")
	var_64_1:addChild(var_64_3)
end

function TwisteggLayer:createSelectupList(arg_65_1)
	local var_65_0 = twist_manager:get_items_by_twisttype(arg_65_1) or twist_manager:get_selectup_list(arg_65_1)
	local var_65_1 = twist_manager:get_twist_upitem(arg_65_1) or twist_manager:get_selected_up(arg_65_1)
	local var_65_2 = ccui.Layout:create()

	var_65_2:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_65_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_65_2:setBackGroundColor(cc.c3b(10, 10, 10))
	var_65_2:setBackGroundColorOpacity(120)
	var_65_2:setTouchEnabled(true)
	var_65_2:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(var_65_2, 2)
	var_65_2:addTouchEventListener(function(arg_66_0, arg_66_1)
		if arg_66_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_65_2:runAction(cc.RemoveSelf:create())
	end)

	local var_65_3 = ccui.ImageView:create("mainScenebg/twist_bg_new/selectup_bg.png")

	var_65_3:setName("bg_select")
	var_65_3:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy + 80 + GameDisplay.fix_y))
	var_65_3:setTouchEnabled(true)
	var_65_2:addChild(var_65_3)

	local function var_65_4(arg_67_0)
		local var_67_0 = ccui.ImageView:create("mainScenebg/twist_bg_new/bg_selectup_role.png")

		var_67_0:setTouchEnabled(true)

		local var_67_1 = ccui.ImageView:create("role/shop_image/" .. model_data[servant_data[arg_67_0].modelid].role_image .. ".png")

		var_67_1:setName("role")
		var_67_1:setScale(0.5)
		var_67_1:setPosition(cc.p(var_67_0:getContentSize().width / 2, var_67_0:getContentSize().height / 2))
		var_67_0:addChild(var_67_1)

		local var_67_2 = ccui.ImageView:create("mainScenebg/twist_bg_new/frame_selectup_role.png")

		var_67_2:setPosition(cc.p(var_67_0:getContentSize().width / 2, var_67_0:getContentSize().height / 2))
		var_67_2:setName("frame")
		var_67_2:setVisible(false)
		var_67_0:addChild(var_67_2, 1)

		return var_67_0
	end

	local var_65_5 = {
		cc.p(70, 350),
		cc.p(70 + 115, 350),
		cc.p(70 + 115 * 2, 350),
		cc.p(70 + 115 * 3, 350),
		cc.p(70 + 115 * 4, 350),
		cc.p(70, 350 - 200),
		cc.p(70 + 115, 350 - 200),
		cc.p(70 + 115 * 2, 350 - 200),
		cc.p(70 + 115 * 3, 350 - 200),
		cc.p(70 + 115 * 4, 350 - 200)
	}
	local var_65_6 = 0

	for iter_65_0 = 1, #var_65_0 do
		local var_65_7 = var_65_0[iter_65_0]
		local var_65_8 = var_65_4(item_data[var_65_0[iter_65_0]].servant)

		var_65_8:setPosition(var_65_5[iter_65_0])
		var_65_8:setName("sp" .. iter_65_0)
		var_65_3:addChild(var_65_8)

		if var_65_0[iter_65_0] == var_65_1 then
			var_65_6 = iter_65_0

			var_65_8:getChildByName("frame"):setVisible(true)
		end

		var_65_8:addTouchEventListener(function(arg_68_0, arg_68_1)
			if arg_68_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_65_6 == iter_65_0 then
				return
			end

			if var_65_6 ~= 0 then
				var_65_3:getChildByName("sp" .. var_65_6):getChildByName("frame"):setVisible(false)
			end

			local var_68_0 = global_get_all_servant_attrs(item_data[var_65_7].servant)

			var_65_3:getChildByName("sp" .. iter_65_0):getChildByName("frame"):setVisible(true)

			var_65_6 = iter_65_0
		end)
	end

	local var_65_9 = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_27)

	var_65_9:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 180))
	var_65_2:addChild(var_65_9)

	local var_65_10 = cc.Label:createWithTTF(L_TWISTLAYER[2], FONT_BUTTON, 28)

	var_65_10:setColor(cc.c3b(0, 0, 0))
	var_65_10:setPosition(cc.p(var_65_9:getContentSize().width / 2, var_65_9:getContentSize().height / 2 - 5))
	var_65_9:addChild(var_65_10)
	var_65_9:addTouchEventListener(function(arg_69_0, arg_69_1)
		if arg_69_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_65_6 then
			return
		end

		self:addPopWindow(arg_65_1, var_65_0[var_65_6])
		var_65_2:runAction(cc.RemoveSelf:create())
	end)
end

function TwisteggLayer:createThemeList(arg_70_1)
	local var_70_0 = twist_manager:get_items_by_twisttype(arg_70_1)
	local var_70_1 = twist_manager:get_twist_upitem(arg_70_1)
	local var_70_2 = twist_manager:get_twist_selectup_uitype(arg_70_1)
	local var_70_3 = ccui.Layout:create()

	var_70_3:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_70_3:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_70_3:setBackGroundColor(cc.c3b(10, 10, 10))
	var_70_3:setBackGroundColorOpacity(120)
	var_70_3:setTouchEnabled(true)
	var_70_3:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(var_70_3, 2)
	var_70_3:addTouchEventListener(function(arg_71_0, arg_71_1)
		if arg_71_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_70_3:runAction(cc.RemoveSelf:create())
	end)

	local var_70_4 = ccui.ImageView:create("public/panelbg/selector_bg.png", var_0_27)

	var_70_4:setName("bg_select")
	var_70_4:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy + 80 + GameDisplay.fix_y))
	var_70_4:setTouchEnabled(true)

	local var_70_6 = twist_manager:get_twist_selectup_uitype(arg_70_1)
	local var_70_7 = ccui.ImageView:create(var_70_6 == 4 and "public/title/element_change.png" or "public/title/cloth_change.png", var_0_27)

	var_70_7:setPosition(var_70_7:getContentSize().width / 2, var_70_4:getContentSize().height + var_70_7:getContentSize().height / 2)
	var_70_4:addChild(var_70_7)
	var_70_3:addChild(var_70_4)

	local function var_70_8(arg_72_0)
		local var_72_0 = ccui.Button:create("TwistEgg/btn_on.png", nil, "TwistEgg/btn_off.png", var_0_27)

		var_72_0:setTouchEnabled(true)
		var_72_0:setTitleText(arg_72_0)
		var_72_0:setTitleColor(cc.c3b(255, 255, 255))
		var_72_0:setScale(1.5)
		var_72_0:setBright(false)

		return var_72_0
	end

	local var_70_9 = 380
	local var_70_10 = 100

	if var_70_6 == 5 then
		var_70_9 = 400
		var_70_10 = 110
	end

	local var_70_11 = {
		cc.p(150, var_70_9),
		cc.p(150 + 225, var_70_9),
		cc.p(150, var_70_9 - var_70_10),
		cc.p(150 + 225, var_70_9 - var_70_10),
		cc.p(150, var_70_9 - var_70_10 * 2),
		cc.p(150 + 225, var_70_9 - var_70_10 * 2),
		cc.p(150, var_70_9 - var_70_10 * 3),
		cc.p(150 + 225, var_70_9 - var_70_10 * 3)
	}
	local var_70_12 = 0

	for iter_70_0 = 1, #var_70_0 do
		local var_70_13 = var_70_0[iter_70_0]
		local var_70_15 = var_70_8(var_70_6 == 4 and L_QUICKFORMATIONLAYER.MAPTEXT[global_get_all_servant_attrs(item_data[var_70_0[iter_70_0]].servant).main] or item_data[var_70_13].logo_str)

		var_70_15:setPosition(var_70_11[iter_70_0])
		var_70_15:setName("btn" .. iter_70_0)
		var_70_4:addChild(var_70_15)

		if var_70_13 == var_70_1 then
			var_70_12 = iter_70_0

			var_70_15:setBright(true)
		end

		var_70_15:addTouchEventListener(function(arg_73_0, arg_73_1)
			if arg_73_1 ~= ccui.TouchEventType.ended then
				return
			end

			if var_70_12 == iter_70_0 then
				return
			end

			if var_70_12 ~= 0 then
				var_70_4:getChildByName("btn" .. var_70_12):setBright(false)
			end

			arg_73_0:setBright(true)

			self.selectName = arg_73_0:getTitleText()
			var_70_12 = iter_70_0
		end)
	end

	local var_70_16 = ccui.Button:create("public/button/public_button_orange_big.png", nil, "public/button/public_button_orange_big.png", var_0_27)

	var_70_16:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 180))
	var_70_3:addChild(var_70_16)

	local var_70_17 = cc.Label:createWithTTF(L_BUTTON_TEXT.Sure, FONT_BUTTON, 28)

	var_70_17:setColor(cc.c3b(0, 0, 0))
	var_70_17:setPosition(cc.p(var_70_16:getContentSize().width / 2, var_70_16:getContentSize().height / 2 - 5))
	var_70_16:addChild(var_70_17)
	var_70_16:addTouchEventListener(function(arg_74_0, arg_74_1)
		if arg_74_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_70_12 then
			return
		end

		local var_74_0 = var_70_0[var_70_12]

		if var_70_0[var_70_12] == var_70_1 then
			return
		end

		self:addPopWindow(arg_70_1, var_74_0)
		var_70_3:runAction(cc.RemoveSelf:create())
	end)
end

function TwisteggLayer.haveNumberInString(arg_75_0, arg_75_1, arg_75_2)
	for iter_75_0 in string.gmatch(arg_75_1, "[^,]+") do
		if tonumber(iter_75_0) == arg_75_2 then
			return true
		end
	end

	return false
end

function TwisteggLayer.addPopWindow(arg_76_0, arg_76_1, arg_76_2)
	local twist_up_group_data = require("data.twist_up_group_data")
	local var_76_1 = {}

	for iter_76_0 in string.gmatch(TWIST_CHANGE_DES[twist_manager:get_twist_selectup_uitype(arg_76_1)], "[^,]+") do
		local var_76_3 = {}

		table.insert(var_76_3, {
			str = iter_76_0
		})
		table.insert(var_76_1, var_76_3)
	end

	LayerManager:pushInLayer("PopDoLayer", {
		labels = {
			titleImage = "title_warorder.png"
		},
		desRichTexts = var_76_1,
		surecallback = function()
			twist_manager:set_select_from_twistgroup(arg_76_1, arg_76_2)
		end
	})
end

function TwisteggLayer.updateMainImg(arg_78_0, arg_78_1, arg_78_2)
	if arg_78_1:find("public/") then
		arg_78_2:loadTextures(arg_78_1, arg_78_1, arg_78_1, var_0_27)
	else
		arg_78_2:loadTextures(arg_78_1, arg_78_1, arg_78_1)
	end
end

function TwisteggLayer.updateBgImg(arg_79_0, arg_79_1, arg_79_2)
	arg_79_2:loadTexture(arg_79_1)
end

function TwisteggLayer:updateTitleImg(arg_80_1, arg_80_2)
	arg_80_2:loadTextures("mainScenebg/twist_bg_new/" .. arg_80_1.img .. "/title.png", "mainScenebg/twist_bg_new/" .. arg_80_1.img .. "/title.png", "mainScenebg/twist_bg_new/" .. arg_80_1.img .. "/title.png")
	self:updateTwistSupplusTime(arg_80_1, arg_80_2)
	self:updateTwistSelectUpTitle(arg_80_1, arg_80_2)
	self:updateBubble(arg_80_1, arg_80_2)
end

function TwisteggLayer.updateRarityImg(arg_81_0, arg_81_1, arg_81_2)
	if require("controller.filedownloader.file_check_manager"):checkFileNeedDownload(arg_81_1) then
		arg_81_2:loadTexture(arg_81_1)
	elseif not cc.FileUtils:getInstance():isFileExist(arg_81_1) then
		arg_81_2:setVisible(false)
	else
		arg_81_2:setVisible(true)
		arg_81_2:loadTexture(arg_81_1)
	end
end

function TwisteggLayer.updateBubble(arg_82_0, arg_82_1, arg_82_2)
	local var_82_0 = twist_manager:get_data_by_type(arg_82_1.twistType)

	if var_82_0 and var_82_0.popularity_title == 1 then
		if not arg_82_2:getChildByName("bubble") then
			local var_82_2 = ccui.ImageView:create("TwistEgg/bubble.png", var_0_27)

			if arg_82_2:getChildByName("timeLabel") then
				if arg_82_2:getChildByName("timeLabel"):isVisible() then
					var_82_2:setPosition(235, arg_82_2:getContentSize().height / 2 - 42)

					goto label_82_0
				end
			end

			var_82_2:setPosition(var_82_2:getContentSize().width / 2 + 20, arg_82_2:getContentSize().height / 2 - 50)

			::label_82_0::

			var_82_2:setName("bubble")
			arg_82_2:addChild(var_82_2)

			local var_82_3 = ccui.RichText:create()

			var_82_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_82_3:setPosition(85, 10)
			var_82_2:addChild(var_82_3)
			var_82_3:pushBackElement((ccui.RichElementText:create(1, cc.c3b(255, 255, 0), 255, var_82_0.popularity_value and var_82_0.popularity_value or 99, FONT_NAME, 20)))
			var_82_3:pushBackElement((ccui.RichElementText:create(1, cc.c3b(255, 255, 255), 255, L_TWISTBUBBLE, FONT_NAME, 17)))
		else
			local var_82_4 = arg_82_2:getChildByName("bubble")

			var_82_4:setVisible(true)

			if arg_82_2:getChildByName("timeLabel") then
				if arg_82_2:getChildByName("timeLabel"):isVisible() then
					var_82_4:setPosition(235, arg_82_2:getContentSize().height / 2 - 42)

					goto label_82_1
				end
			end

			var_82_4:setPosition(var_82_4:getContentSize().width / 2 + 20, arg_82_2:getContentSize().height / 2 - 50)
		end
	elseif arg_82_2:getChildByName("bubble") then
		arg_82_2:getChildByName("bubble"):setVisible(false)
	end

	::label_82_1::
end

function TwisteggLayer.updateTwistSupplusTime(arg_83_0, arg_83_1, arg_83_2)
	if arg_83_1.time then
		if not arg_83_2:getChildByName("timeLabel") then
			local var_83_0 = var_0_46(arg_83_1.time)

			if var_83_0 then
				local var_83_1 = cc.Label:createWithTTF(var_83_0, FONT_W5, 24)

				var_83_1:setAnchorPoint(cc.p(0.5, 0.5))
				var_83_1:setName("timeLabel")
				var_83_1:setPosition(cc.p(75, arg_83_2:getContentSize().height / 2 - 20))
				arg_83_2:addChild(var_83_1, 1)
			end
		else
			arg_83_2:getChildByName("timeLabel"):setString((var_0_46(arg_83_1.time)))
			arg_83_2:getChildByName("timeLabel"):setPosition(cc.p(75, arg_83_2:getContentSize().height / 2 - 20))
			arg_83_2:getChildByName("timeLabel"):setVisible(true)
		end
	elseif arg_83_2:getChildByName("timeLabel") then
		arg_83_2:getChildByName("timeLabel"):setVisible(false)
	end
end

function TwisteggLayer.updateTwistSelectUpTitle(arg_84_0, arg_84_1, arg_84_2)
	if twist_manager:is_selectup_twist(arg_84_1.twistType) and twist_manager:get_twist_selectup_uitype(arg_84_1.twistType) == 2 then
		if not arg_84_2:getChildByName("selectuptitle") then
			local var_84_0 = ccui.ImageView:create("mainScenebg/twist_bg_new/" .. arg_84_1.img .. "/tips.png")

			var_84_0:setName("selectuptitle")
			var_84_0:setPosition(cc.p(300, arg_84_2:getContentSize().height / 2 - 30))
			arg_84_2:addChild(var_84_0, 1)
		else
			arg_84_2:getChildByName("selectuptitle"):loadTexture("mainScenebg/twist_bg_new/" .. arg_84_1.img .. "/tips.png")
			arg_84_2:getChildByName("selectuptitle"):setVisible(true)
		end
	elseif arg_84_2:getChildByName("selectuptitle") then
		arg_84_2:getChildByName("selectuptitle"):setVisible(false)
	end
end

function TwisteggLayer:updateUpcount(arg_85_1)
	local var_85_0 = self.restImg:getChildByName("label_rest_times")

	if arg_85_1.upcount2 then
		local var_85_1
		local var_85_2

		if arg_85_1.uppos2 == 1 then
			var_85_2 = arg_85_1.upcount
			var_85_1 = arg_85_1.upcount2
		else
			var_85_2 = arg_85_1.upcount2
			var_85_1 = arg_85_1.upcount
		end

		if var_85_1 then
			self.restImg:setVisible(true)
			var_85_0:setString(var_85_1)
		end

		if var_85_2 then
			self.restImg:setVisible(true)
			var_85_0:setString(var_85_2)
		end

		self.restImg:loadTexture("TwistEgg/rest_bg.png", var_0_27)
		var_85_0:setPositionX(self.restImg:getContentSize().width - 120)
	elseif arg_85_1.upcount then
		self.restImg:setVisible(true)
		self.restImg:loadTexture("TwistEgg/rest_bg.png", var_0_27)
		var_85_0:setString(arg_85_1.upcount)
		var_85_0:setPositionX(self.restImg:getContentSize().width - 120)
	elseif arg_85_1.guaranteeprob then
		self.restImg:setVisible(true)

		if arg_85_1.guaranteeprob:find("count_") then
			self.restImg:loadTexture("TwistEgg/reset_up_bg.png", var_0_27)
			var_85_0:setString((arg_85_1.guaranteeprob:match("count_(%d+)")))
			var_85_0:setPositionX(self.restImg:getContentSize().width - 180)
		else
			self.restImg:loadTexture("TwistEgg/rest_prob.png", var_0_27)
			var_85_0:setString(math.floor(tonumber(arg_85_1.guaranteeprob) * 100) .. "%")
			var_85_0:setPositionX(self.restImg:getContentSize().width - 40)
		end
	else
		self.restImg:setVisible(false)
	end

	if twist_manager:is_selectup_twist(arg_85_1.twistType) and twist_manager:get_twist_selectup_uitype(arg_85_1.twistType) == 1 then
		self.restImg:setPositionY(GameDisplay.cy + 165 + 200 - GameDisplay.fix_y)
	else
		self.restImg:setPositionY(367 - GameDisplay.fix_y)
	end
end

function TwisteggLayer:updateUnlock(arg_86_1, arg_86_2)
	if self.twistConfig[arg_86_1].unlock_level and not level_manager:isPlayerPassLevel(self.twistConfig[arg_86_1].unlock_level) then
		if not self.oneBtn:getChildByName("lockBg") then
			local var_86_0 = ccui.ImageView:create("zhucheng3/lockbg.png", var_0_27)

			var_86_0:setScale9Enabled(true)
			var_86_0:setCapInsets(cc.rect(1, 1, 2, 2))
			var_86_0:setContentSize(cc.size(self.oneBtn:getContentSize().width - 20, var_86_0:getContentSize().height))
			var_86_0:setName("lockBg")
			var_86_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_86_0:setPosition(cc.p(self.oneBtn:getContentSize().width / 2, 22))
			self.oneBtn:addChild(var_86_0)

			local var_86_1 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(self.twistConfig[arg_86_1].unlock_level) .. L_UNLOCK, FONT_DES, 18)

			var_86_1:setAnchorPoint(cc.p(0.5, 0.5))
			var_86_1:setName("label")
			var_86_1:setColor(cc.c3b(255, 163, 2))
			var_86_1:setPosition(cc.p(var_86_0:getContentSize().width / 2, var_86_0:getContentSize().height / 2))
			var_86_0:addChild(var_86_1, 1)
		else
			self.oneBtn:getChildByName("lockBg"):setVisible(true)
			self.oneBtn:getChildByName("lockBg"):getChildByName("label"):setString(level_manager:formatModeChapterLevelByPlayerLevel(self.twistConfig[arg_86_1].unlock_level) .. L_UNLOCK)
		end

		if not self.tenBtn:getChildByName("lockBg") then
			local var_86_2 = ccui.ImageView:create("zhucheng3/lockbg.png", var_0_27)

			var_86_2:setScale9Enabled(true)
			var_86_2:setCapInsets(cc.rect(1, 1, 2, 2))
			var_86_2:setContentSize(cc.size(self.tenBtn:getContentSize().width - 20, var_86_2:getContentSize().height))
			var_86_2:setName("lockBg")
			var_86_2:setAnchorPoint(cc.p(0.5, 0.5))
			var_86_2:setPosition(cc.p(self.tenBtn:getContentSize().width / 2, 22))
			self.tenBtn:addChild(var_86_2)

			local var_86_3 = cc.Label:createWithTTF(level_manager:formatModeChapterLevelByPlayerLevel(self.twistConfig[arg_86_1].unlock_level) .. L_UNLOCK, FONT_DES, 18)

			var_86_3:setName("label")
			var_86_3:setAnchorPoint(cc.p(0.5, 0.5))
			var_86_3:setColor(cc.c3b(255, 163, 2))
			var_86_3:setPosition(cc.p(var_86_2:getContentSize().width / 2, var_86_2:getContentSize().height / 2))
			var_86_2:addChild(var_86_3, 1)
		else
			self.tenBtn:getChildByName("lockBg"):setVisible(true)
			self.tenBtn:getChildByName("lockBg"):getChildByName("label"):setString(level_manager:formatModeChapterLevelByPlayerLevel(self.twistConfig[arg_86_1].unlock_level) .. L_UNLOCK)
		end
	else
		if self.oneBtn:getChildByName("lockBg") then
			self.oneBtn:getChildByName("lockBg"):setVisible(false)
		end

		if self.tenBtn:getChildByName("lockBg") then
			self.tenBtn:getChildByName("lockBg"):setVisible(false)
		end
	end
end

function TwisteggLayer:updateRightBtnList(arg_87_1, arg_87_2)
	if not arg_87_2:getChildByName("rightBtnListPanel") then
		self:createRightBtnListPanel(arg_87_2)
	end

	local var_87_0 = arg_87_2:getChildByName("rightBtnListPanel"):getChildByName("panel")
	local var_87_1 = {}

	if not self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].is_skin_twist and arg_87_1 and self.twistConfig[arg_87_1] then
		if self.twistConfig[arg_87_1].into_black == "close" then
			var_87_0.btnList.blackCard:setVisible(false)
		else
			var_87_0.btnList.blackCard.into_black = self.twistConfig[arg_87_1].into_black

			table.insert(var_87_1, var_87_0.btnList.blackCard)
		end
	else
		var_87_0.btnList.blackCard:setVisible(false)
	end

	if arg_87_1 and self.twistConfig[arg_87_1] and self.twistConfig[arg_87_1].into_golden then
		var_87_0.btnList.into_golden.into_golden = self.twistConfig[arg_87_1].into_golden

		table.insert(var_87_1, var_87_0.btnList.into_golden)
	else
		var_87_0.btnList.into_golden:setVisible(false)
	end

	if arg_87_1 and self.twistConfig[arg_87_1] and self.twistConfig[arg_87_1].into_skin then
		var_87_0.btnList.into_skin.into_skin = self.twistConfig[arg_87_1].into_skin

		table.insert(var_87_1, var_87_0.btnList.into_skin)
	else
		var_87_0.btnList.into_skin:setVisible(false)
	end

	if arg_87_1 and self.twistConfig[arg_87_1] and self.twistConfig[arg_87_1].into_jump then
		var_87_0.btnList.into_jump.into_jump = self.twistConfig[arg_87_1].into_jump

		table.insert(var_87_1, var_87_0.btnList.into_jump)
	else
		var_87_0.btnList.into_jump:setVisible(false)
	end

	if arg_87_1 and self.twistConfig[arg_87_1] and self.twistConfig[arg_87_1].into_recharge then
		local var_87_2 = var_87_0.btnList.into_recharge

		var_87_0.btnList.into_recharge.into_recharge = self.twistConfig[arg_87_1].into_recharge

		table.insert(var_87_1, var_87_0.btnList.into_recharge)
		var_87_0.btnList.into_recharge:getChildByName("reddot"):setVisible(false)

		if activity_manager:getAlertStatusByJumpid(var_87_0.btnList.into_recharge.into_recharge) then
			var_87_0.btnList.into_recharge:getChildByName("reddot"):setVisible(true)
		end

		if not self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].is_skin_twist then
			twist_manager:getStatData(var_87_0.btnList.into_recharge.into_recharge % 1900000, arg_87_1, function(arg_88_0)
				if arg_88_0 then
					var_87_2:getChildByName("richTextPro"):clearText()
					var_87_2:getChildByName("richTextPro"):setText(string.format("<p>%s<span style=color: rgb(255,255,0);>%d</span>%s</p>", L_TWISTTIMES[1], arg_88_0, L_TWISTTIMES[2]))
					var_87_2:getChildByName("richTextPro"):setVisible(true)
					var_87_2:getChildByName("maxLabel"):setVisible(false)
				else
					var_87_2:getChildByName("maxLabel"):setVisible(true)
					var_87_2:getChildByName("richTextPro"):setVisible(false)
				end
			end)
		else
			var_87_0.btnList.into_recharge:getChildByName("richTextPro"):clearText()
			var_87_0.btnList.into_recharge:getChildByName("richTextPro"):setVisible(false)
			var_87_0.btnList.into_recharge:getChildByName("maxLabel"):setVisible(false)
		end
	else
		var_87_0.btnList.into_recharge:setVisible(false)
	end

	if arg_87_1 and self.twistConfig[arg_87_1] and self.twistConfig[arg_87_1].into_shop then
		var_87_0.btnList.into_shop.shoptype = self.twistConfig[arg_87_1].into_shop

		table.insert(var_87_1, var_87_0.btnList.into_shop)
	else
		var_87_0.btnList.into_shop:setVisible(false)
	end

	local var_87_3 = 0

	for iter_87_0, iter_87_1 in ipairs(var_87_1) do
		iter_87_1:setVisible(true)
		iter_87_1:setPositionY(var_87_3)

		var_87_3 = var_87_3 - iter_87_1:getContentSize().height + 7
	end

	var_87_0.showBtnList = var_87_1
end

function TwisteggLayer.createRightBtnListPanel(arg_89_0, arg_89_1)
	local var_89_0 = cc.Node:create()

	var_89_0:setPosition(cc.p(arg_89_1:getContentSize().width, 1040 + GameDisplay.fix_y))
	var_89_0:setName("rightBtnListPanel")
	arg_89_1:addChild(var_89_0, 50)

	local var_89_1 = ccui.Layout:create()

	var_89_1:setContentSize(cc.size(0, 0))
	var_89_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_89_1:setAnchorPoint(0, 0)
	var_89_1:setName("panel")
	var_89_0:addChild(var_89_1)

	local var_89_2 = {}
	local var_89_3 = ccui.Button:create("TwistEgg/jump_horcrux_shop_" .. "off.png", "TwistEgg/jump_horcrux_shop_" .. "on.png", "TwistEgg/jump_horcrux_shop_" .. "off.png", var_0_27)

	var_89_3:setAnchorPoint(cc.p(1, 1))
	var_89_3:setVisible(false)
	var_89_1:addChild(var_89_3, 10)

	var_89_2.blackCard = var_89_3

	var_89_3:addTouchEventListener(function(arg_90_0, arg_90_1)
		if arg_90_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_90_0 = {}

		if arg_90_0.into_black then
			if string.find(arg_90_0.into_black, ",") then
				for iter_90_0, iter_90_1 in pairs(split(arg_90_0.into_black, ",")) do
					table.insert(var_90_0, "1-" .. iter_90_1)
				end
			else
				var_90_0[1] = "1-" .. arg_90_0.into_black
			end
		else
			var_90_0 = {
				"1-3",
				"1-56",
				"1-51",
				"1-52",
				"1-53",
				"1-54",
				"1-55"
			}
		end

		LayerManager:pushInLayer("MarketLayer", {
			returnLayer = "TwisteggLayer",
			singleMarket = var_90_0,
			showType = var_90_0[1]
		})
	end)

	local var_89_4 = ccui.Button:create("TwistEgg/jump_golden_shop_" .. "off.png", "TwistEgg/jump_golden_shop_" .. "on.png", "TwistEgg/jump_golden_shop_" .. "off.png", var_0_27)

	var_89_4:setAnchorPoint(cc.p(1, 1))
	var_89_4:setVisible(false)
	var_89_1:addChild(var_89_4, 10 - 1)

	var_89_2.into_golden = var_89_4

	var_89_4:addTouchEventListener(function(arg_91_0, arg_91_1)
		if arg_91_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_91_0.into_golden then
			local var_91_0 = {}

			if string.find(arg_91_0.into_golden, ",") then
				for iter_91_0, iter_91_1 in pairs(split(arg_91_0.into_golden, ",")) do
					table.insert(var_91_0, "1-" .. iter_91_1)
				end
			else
				var_91_0[1] = "1-" .. arg_91_0.into_golden
			end

			LayerManager:pushInLayer("MarketLayer", {
				returnLayer = "TwisteggLayer",
				singleMarket = var_91_0,
				showType = var_91_0[1]
			})
		else
			print("兄弟你config表里没填into_golden")
		end
	end)

	local var_89_5 = ccui.Button:create("TwistEgg/jump_skin_" .. "off.png", "TwistEgg/jump_skin_" .. "on.png", "TwistEgg/jump_skin_" .. "off.png", var_0_27)

	var_89_5:setAnchorPoint(cc.p(1, 1))
	var_89_5:setVisible(false)
	var_89_1:addChild(var_89_5, 10 - 1 - 1)

	var_89_2.into_skin = var_89_5

	var_89_5:addTouchEventListener(function(arg_92_0, arg_92_1)
		if arg_92_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_92_0.into_skin then
			local var_92_0 = {}

			if string.find(arg_92_0.into_skin, ",") then
				for iter_92_0, iter_92_1 in pairs(split(arg_92_0.into_skin, ",")) do
					table.insert(var_92_0, "1-" .. iter_92_1)
				end
			else
				var_92_0[1] = "1-" .. arg_92_0.into_skin
			end

			LayerManager:pushInLayer("MarketLayer", {
				returnLayer = "TwisteggLayer",
				singleMarket = var_92_0,
				showType = var_92_0[1]
			})
		else
			print("兄弟你config表里没填into_skin")
		end
	end)

	local var_89_6 = ccui.Button:create("TwistEgg/jump_recharge_" .. "off.png", "TwistEgg/jump_recharge_" .. "on.png", "TwistEgg/jump_recharge_" .. "off.png", var_0_27)

	var_89_6:setAnchorPoint(cc.p(1, 1))
	var_89_6:setVisible(false)
	var_89_1:addChild(var_89_6, 10 - 1 - 1 - 1)

	var_89_2.into_jump = var_89_6

	var_89_6:addTouchEventListener(function(arg_93_0, arg_93_1)
		if arg_93_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_93_0.into_jump then
			goto_complete_system({
				jump_to_system = arg_93_0.into_jump
			})
		else
			print("兄弟你config表里没填into_jump")
		end
	end)

	local var_89_7 = ccui.Button:create("TwistEgg/jump_task_" .. "new.png", "TwistEgg/jump_task_" .. "new.png", "TwistEgg/jump_task_" .. "new.png", var_0_27)

	var_89_7:setAnchorPoint(cc.p(1, 1))
	var_89_7:setPositionX(var_89_7:getPositionX() + 5)
	var_89_7:setVisible(false)
	var_89_1:addChild(var_89_7, 10 - 1 - 1 - 1 - 1)

	var_89_2.into_recharge = var_89_7

	var_89_7:addTouchEventListener(function(arg_94_0, arg_94_1)
		if arg_94_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_94_0.into_recharge then
			goto_complete_system({
				jump_to_system = arg_94_0.into_recharge
			})
		else
			print("兄弟你config表里没填into_recharge")
		end
	end)

	local var_89_8 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_27)

	var_89_8:setName("reddot")
	var_89_8:setPositionX(var_89_7:getContentSize().width - var_89_8:getContentSize().width / 2)
	var_89_8:setPositionY(var_89_7:getContentSize().height - var_89_8:getContentSize().height / 2)
	var_89_7:addChild(var_89_8)

	local var_89_9 = RichTextPro:create()

	var_89_9:setSize(12)
	var_89_9:setColor(cc.c3b(255, 255, 255))
	var_89_9:setFontName(FONT_NAME)
	var_89_9:setLineSpace(0, nil, true)
	var_89_9:setName("richTextPro")
	var_89_9:setPosition(5, 20)
	var_89_9:setText(string.format("<p>%s<span style=color: rgb(255,255,0);>%d</span>%s</p>", L_TWISTTIMES[1], 30, L_TWISTTIMES[2]))
	var_89_7:addChild(var_89_9)

	local var_89_10 = RichTextPro:create()

	var_89_10:setSize(12)
	var_89_10:setColor(cc.c3b(255, 255, 255))
	var_89_10:setPosition(15, 20)
	var_89_10:setLineSpace(0, nil, true)
	var_89_10:setText(L_TWISTTIMES[3])
	var_89_10:setVisible(false)
	var_89_10:setName("maxLabel")
	var_89_7:addChild(var_89_10)

	local var_89_11 = ccui.Button:create("TwistEgg/jump_market_" .. "off.png", "TwistEgg/jump_market_" .. "on.png", "TwistEgg/jump_market_" .. "off.png", var_0_27)

	var_89_11:setAnchorPoint(cc.p(1, 1))
	var_89_11:setVisible(false)
	var_89_1:addChild(var_89_11, 10 - 1 - 1 - 1 - 1 - 1)

	var_89_2.into_shop = var_89_11

	var_89_11:addTouchEventListener(function(arg_95_0, arg_95_1)
		if arg_95_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_95_0.shoptype then
			local var_95_0 = {}

			if string.find(arg_95_0.shoptype, "_") then
				for iter_95_0, iter_95_1 in pairs(split(arg_95_0.shoptype, "_")) do
					table.insert(var_95_0, "1-" .. iter_95_1)
				end
			else
				var_95_0[1] = "1-" .. arg_95_0.shoptype
			end

			LayerManager:pushInLayer("MarketLayer", {
				returnLayer = "TwisteggLayer",
				singleMarket = var_95_0,
				showType = var_95_0[1]
			})
		else
			print("兄弟你config表里没填into_shop")
		end
	end)

	var_89_1.btnList = var_89_2

	return var_89_1
end

function TwisteggLayer:checkIsHaveFreeTimes(arg_96_1, arg_96_2)
	if not arg_96_1 then
		for iter_96_0, iter_96_1 in pairs(self.twist_type_to_index) do
			local var_96_0 = iter_96_1

			if self.curtwistData[iter_96_1] then
				if (self.curtwistData[var_96_0].dailyfreeforone or 0) <= 0 then
					local var_96_3

					if (self.curtwistData[var_96_0].totalfreeforone or 0) <= 0 then
						var_96_3 = false

						goto label_96_0
					end
				end

				var_96_3 = true

				do
					local var_96_5
				end

				::label_96_0::

				if (self.curtwistData[var_96_0].dailyfreeforten or 0) <= 0 then
					if (self.curtwistData[var_96_0].totalfreeforten or 0) <= 0 then
						var_96_5 = false

						goto label_96_1
					end
				end

				::label_96_1::

				if var_96_3 or true then
					return true
				end
			end
		end

		return false
	else
		local var_96_6 = self.twist_type_to_index[arg_96_1]

		if not self.curtwistData[self.twist_type_to_index[arg_96_1]] then
			return false
		end

		if (self.curtwistData[var_96_6].dailyfreeforone or 0) <= 0 then
			local var_96_8

			if (self.curtwistData[var_96_6].totalfreeforone or 0) <= 0 then
				var_96_8 = false

				goto label_96_2
			end
		end

		var_96_8 = true

		::label_96_2::

		if (self.curtwistData[var_96_6].dailyfreeforten or 0) <= 0 then
			local var_96_10

			if (self.curtwistData[var_96_6].totalfreeforten or 0) <= 0 then
				var_96_10 = false

				goto label_96_3
			end
		end

		var_96_10 = true

		::label_96_3::

		if arg_96_2 == "one" then
			return var_96_8
		elseif arg_96_2 == "ten" then
			return var_96_10
		elseif not arg_96_2 then
			return var_96_10 or var_96_8
		end
	end
end

function TwisteggLayer:checkBtnsAlert(arg_97_1, arg_97_2)
	local var_97_0 = self.curtwistData[self.curTwistIndex].twistType

	local function var_97_1()
		self:updateListReddot(not self:checkIsHaveFreeTimes(var_97_0))
	end

	local function var_97_2()
		if self:checkIsHaveFreeTimes(var_97_0, "one") then
			AlertManager:add_alert_by_config(self.oneBtn, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.oneBtn:getContentSize().width - 5, self.oneBtn:getContentSize().height - 5)
			})
		else
			AlertManager:add_alert_by_config(self.oneBtn, false, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.oneBtn:getContentSize().width - 5, self.oneBtn:getContentSize().height - 5)
			})
		end
	end

	local function var_97_3()
		if self:checkIsHaveFreeTimes(var_97_0, "ten") then
			AlertManager:add_alert_by_config(self.tenBtn, true, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.tenBtn:getContentSize().width - 5, self.oneBtn:getContentSize().height - 5)
			})
		else
			AlertManager:add_alert_by_config(self.tenBtn, false, {
				ALERT_SHOW_REDDOT,
				"",
				cc.p(self.tenBtn:getContentSize().width - 5, self.oneBtn:getContentSize().height - 5)
			})
		end
	end

	if arg_97_1 == "img" then
		var_97_1()
	elseif arg_97_1 == "oneBtn" then
		var_97_2()
	elseif arg_97_1 == "tenBtn" then
		var_97_3()
	else
		var_97_1()
		var_97_2()
		var_97_3()
	end
end

function TwisteggLayer:updateByBlackCard(arg_101_1)
	self:updateTimePanel()
end

function TwisteggLayer:updateListReddot(arg_102_1, arg_102_2)
	if not self.nowListNode and not arg_102_2 then
		return
	end

	local var_102_0 = arg_102_2 or self.nowListNode

	if (arg_102_2 or self.nowListNode):getChildByName("alert_reddot") then
		local var_102_1 = var_102_0:getChildByName("alert_reddot")

		if arg_102_1 then
			AlertManager:add_alert_by_config(var_102_0, false, {
				ALERT_SHOW_REDDOT,
				""
			})

			var_102_0.isAlertReddot = nil
		end
	end

	if var_102_0:getChildByName("alert_new") then
		local var_102_2 = var_102_0:getChildByName("alert_new")

		AlertManager:add_alert_by_config(var_102_0, false, {
			ALERT_SHOW_NEW,
			""
		})
	end
end

function TwisteggLayer:fullScreen()
	local var_103_0 = self.rootLayer:getChildByName("Bottom_bg")

	var_103_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_103_0:getPositionY(), TRANSFORM_UNIT.PX)

	var_103_0:setPositionY(var_103_0.full_posY)

	for iter_103_0, iter_103_1 in ipairs(self.cachePanelList) do
		local var_103_1 = iter_103_1:getChildByName("image_main")
		local var_103_2 = iter_103_1:getChildByName("image_bg")
		local var_103_3 = iter_103_1:getChildByName("image_title")
		local var_103_4 = iter_103_1:getChildByName("btn_detail")

		var_103_3:setPositionY(976 + GameDisplay.fix_y)
		var_103_4:setPositionY(976 + GameDisplay.fix_y)
	end

	self.oneBtn:setPositionY(self.oneBtn:getPositionY() - GameDisplay.fix_y + 40)
	self.tenBtn:setPositionY(self.oneBtn:getPositionY())
	self.restImg:setPositionY(self.oneBtn:getPositionY() + 63)
	self.selectPanel:setPositionY(self.selectPanel:getPositionY() - GameDisplay.fix_y)

	self.showPanel.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX)

	self.showPanel:setPositionY(self.showPanel.full_posY)
	self.showPanel:setContentSize(cc.size(self.showPanel:getContentSize().width, GameDisplay.height))
end

function TwisteggLayer:updateGuidesOnLayer()
	if self._lockguide then
		return
	end

	LayerManager:updateGuidesOnSwitchLayer()
end

function TwisteggLayer.setGuideLock(arg_105_0, arg_105_1)
	arg_105_0._lockguide = arg_105_1
end

function TwisteggLayer.calculateTwistFavorNum(arg_106_0)
	local var_106_0 = item_manager:getItemNumber(6800401)

	if var_106_0 < 10 then
		return 0
	elseif var_106_0 < 20 then
		return 1
	elseif var_106_0 < 1000 then
		return math.floor(var_106_0 / 10)
	else
		return 100
	end
end

function TwisteggLayer:registBtnTimesEvent()
	ccui.Helper:seekWidgetByName(self.oneBtn, "one_des"):setTouchEnabled(false)
	ccui.Helper:seekWidgetByName(self.tenBtn, "ten_des"):setTouchEnabled(false)
	self.oneBtn:addTouchEventListener(function(arg_108_0, arg_108_1)
		self:onTouchOneBtn(arg_108_0, arg_108_1)
	end)
	self.tenBtn:addTouchEventListener(function(arg_109_0, arg_109_1)
		self:onTouchTenBtn(arg_109_0, arg_109_1)
	end)
end

function TwisteggLayer:onTouchOneBtn(arg_110_1, arg_110_2)
	if arg_110_2 ~= ccui.TouchEventType.ended then
		return
	end

	if not arg_110_1:isBright() then
		return
	end

	if not self:checkTouchEnabled() then
		return
	end

	if twist_manager:is_setting_selectup(self.curtwistData[self.curTwistIndex].twistType) then
		return
	end

	if self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].unlock_level and config.limit_open_system and not level_manager:isPlayerPassLevel(self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].unlock_level) then
		global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, level_manager:formatModeChapterLevelByPlayerLevel(self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].unlock_level)))

		return
	end

	if self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].stat == 3 and self:get_naive_stat(self.curtwistData[self.curTwistIndex].naivemark, "one") then
		global_ShowBlockWords(L_TWISTEGG_FIRST_SINGLE_USED)

		return
	end

	if self.curtwistData[self.curTwistIndex].twist_remain_count and self.curtwistData[self.curTwistIndex].twist_remain_count <= 0 then
		global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[5])

		return
	end

	;(function(...)
		if not arg_110_1:isBright() then
			return
		end

		arg_110_1:setBright(false)

		self.isCanChangeTwist = false
		self.pay_type = "one"

		local function var_111_0()
			arg_110_1:setBright(true)

			self.isCanChangeTwist = true
		end

		local var_111_1 = self.curtwistData[self.curTwistIndex].twistType

		GuideListener.swallowEvent(false)
		GuideListener.lockGuideTrigger(true)
		GuideListener.cleanCurGuides()
		self:setGuideLock(true)

		if var_111_1 == var_0_32 then
			self:twist_any_result(var_111_1, self:calculateTwistFavorNum(), var_111_0, self:calculateTwistFavorNum() > 10)
		else
			self:twist_one_result(var_111_1, var_111_0)
		end
	end)()
end

function TwisteggLayer:onTouchTenBtn(arg_113_1, arg_113_2)
	if arg_113_2 ~= ccui.TouchEventType.ended then
		return
	end

	if not arg_113_1:isBright() then
		return
	end

	if self.tenBtnOtherLock then
		return
	end

	if not self:checkTouchEnabled() then
		return
	end

	if twist_manager:is_setting_selectup(self.curtwistData[self.curTwistIndex].twistType) then
		return
	end

	if self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].unlock_level and config.limit_open_system and not level_manager:isPlayerPassLevel(self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].unlock_level) then
		global_ShowBlockWords(string.format(L_LAYER_UNLOCKED, level_manager:formatModeChapterLevelByPlayerLevel(self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].unlock_level)))

		return
	end

	if self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].stat == 3 and self:get_naive_stat(self.curtwistData[self.curTwistIndex].naivemark, "ten") then
		global_ShowBlockWords(L_TWISTEGG_FIRST_SINGLE_USED)

		return
	end

	if self.curtwistData[self.curTwistIndex].twist_remain_count and self.curtwistData[self.curTwistIndex].twist_remain_count <= 0 then
		global_ShowBlockWords(L_TWISTEGG_ITEMS_MSG[5])

		return
	end

	local function var_113_0(...)
		arg_113_1:setBright(false)

		self.isCanChangeTwist = false
		self.tenBtnOtherLock = true
		self.pay_type = "ten"

		local function var_114_0()
			self:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
				arg_113_1:setBright(true)

				self.isCanChangeTwist = true
			end)))
		end

		local var_114_1 = self.curtwistData[self.curTwistIndex].twistType

		GuideListener.swallowEvent(false)
		GuideListener.lockGuideTrigger(true)
		GuideListener.cleanCurGuides()
		self:setGuideLock(true)

		local function var_114_2()
			if self.twistConfig[var_114_1].stat == 3 then
				self:twist_ten_result_for_naive(var_114_1, var_114_0)
			else
				self:twist_ten_result(var_114_1, var_114_0)
			end
		end

		if playermodel.twistTenPop and type(self.curtwistData[self.curTwistIndex].costtype) == "number" and self.curtwistData[self.curTwistIndex].costtype ~= 6800110 and item_manager:isHaveEnoughItem(self.curtwistData[self.curTwistIndex].costtype, self.curtwistData[self.curTwistIndex].costten) then
			local var_114_3 = {}
			local var_114_5, var_114_6, var_114_7 = self:isBlendTwistTicket((self.curtwistData[self.curTwistIndex].twist_remain_count ~= nil or nil) and math.min(10, self.curtwistData[self.curTwistIndex].twist_remain_count))

			var_114_3.labels = global_deepCopy(L_TWIST_TEN_POP[self.curtwistData[self.curTwistIndex].costtype] or L_TWIST_TEN_POP.other)

			if var_114_6 and next(var_114_6) and #var_114_6 == 1 then
				var_114_3.labels.des = string.format(L_TWIST_TEN_POP.other.des, item_data[var_114_6[1].itemid].name)
			end

			if self.curtwistData[self.curTwistIndex].twist_remain_count then
				var_114_3.labels.button = string.format(L_TWISTLAYER[7], L_TWISTLAYER_WORDS[math.min(10, self.curtwistData[self.curTwistIndex].twist_remain_count)])
			end

			function var_114_3.surecallback()
				var_114_2()
			end

			function var_114_3.cancelcallback()
				var_114_0()

				self.tenBtnOtherLock = false
			end

			LayerManager:pushInLayer("PopDoLayer", var_114_3)
		else
			var_114_2()
		end
	end

	if (self.curtwistData[self.curTwistIndex].dailyfreeforten or 0) > 0 then
		var_113_0()

		return
	end

	if (self.curtwistData[self.curTwistIndex].totalfreeforten or 0) > 0 then
		var_113_0()

		return
	end

	local var_113_2, var_113_3, var_113_4 = self:isBlendTwistTicket((self.curtwistData[self.curTwistIndex].twist_remain_count ~= nil or nil) and math.min(10, self.curtwistData[self.curTwistIndex].twist_remain_count))

	if var_113_2 and var_113_3 and next(var_113_3) and #var_113_3 > 1 then
		local function var_113_5(arg_120_0, arg_120_1)
			network:rpc("supply_twist_cost", {
				twisttype = arg_120_0,
				num = arg_120_1
			}, function(arg_121_0)
				if arg_121_0.result == 1 then
					if self.twistConfig[arg_120_0].supply_currency then
						item_manager:deleteItem(self.twistConfig[arg_120_0].supply_currency, arg_120_1 * self.twistConfig[arg_120_0].supply_cost)
					elseif self.twistConfig[arg_120_0].supply_cost then
						playermodel.diamond = playermodel.diamond - arg_120_1 * self.twistConfig[arg_120_0].supply_cost
					else
						playermodel.gold = playermodel.gold - arg_120_1 * self.twistConfig[arg_120_0].gold_cost
					end

					global_update_gold_stone_diamond(playermodel.gold, nil, playermodel.diamond)
					item_manager:setItemByServerItem(arg_121_0.item)
					self:updateTimePanel()
					self.oneBtn:setBright(false)
					self.tenBtn:setBright(false)

					local function var_121_0()
						self.oneBtn:setBright(true)
						self.tenBtn:setBright(true)
					end

					if twist_time == var_0_28 then
						self:twist_one_result(arg_120_0, var_121_0)
					else
						self:twist_ten_result(arg_120_0, var_121_0)
					end

					global_ShowBlockWords(L_TWISTEGG_LACK_OF_COST.Buy_Success, RISE_WORDS_SUCCESS)

					if self.twistConfig[arg_120_0].supply_cost then
						AnalyticManager.buyTwistTicketSuccess(arg_120_1 * self.twistConfig[arg_120_0].supply_cost, arg_120_1)
					end
				elseif arg_121_0.result == 2 then
					LayerManager:pushInLayer("PopGoBuyDiamond", {
						is_need_pop_layer = 0
					})
				elseif arg_121_0.result == 3 then
					LayerManager:pushInLayer("PopGoGainLayer", {
						goto_back_system_id = 180,
						item = costtype
					})
				else
					l2Log("buy_twist_ticket fail")
				end
			end)
		end

		local var_113_6

		if self.curtwistData[self.curTwistIndex].once_twist_ticket then
			var_113_6 = self.curtwistData[self.curTwistIndex].once_twist_ticket

			if not self.curtwistData[self.curTwistIndex].once_twist_ticket then
				if self.curtwistData[self.curTwistIndex].once_twist_ticket_1 then
					var_113_6 = self.curtwistData[self.curTwistIndex].once_twist_ticket_1 or self.curtwistData[self.curTwistIndex].costtype
				end
			end
		end

		local var_113_7 = var_113_4 > 0 and function(...)
			var_113_5(self.curtwistData[self.curTwistIndex].twistType, var_113_4)
		end or var_113_0

		LayerManager:pushInLayer("PopTwistEggCostTicketLayer", {
			sureCallback = var_113_7,
			cost_ticket = var_113_3,
			orgin_ticket = var_113_6
		})
	else
		var_113_0()
	end
end

function TwisteggLayer:isBlendTwistTicket(arg_124_1)
	local var_124_0
	local var_124_1 = {}
	local var_124_2 = arg_124_1 or 10
	local var_124_3 = 0

	if (arg_124_1 or 10) > 0 and self.curtwistData[self.curTwistIndex].once_twist_ticket then
		local var_124_4 = item_manager:getItemNumber(self.curtwistData[self.curTwistIndex].once_twist_ticket)

		if var_124_4 > 0 then
			if var_124_4 < var_124_2 then
				var_124_0 = var_124_0 or true

				table.insert(var_124_1, {
					itemid = self.curtwistData[self.curTwistIndex].once_twist_ticket,
					num = var_124_4
				})

				var_124_2 = var_124_2 - var_124_4
			else
				table.insert(var_124_1, {
					itemid = self.curtwistData[self.curTwistIndex].once_twist_ticket,
					num = var_124_2
				})

				var_124_2 = 0
				var_124_0 = var_124_0 or false
			end
		end
	end

	if var_124_2 > 0 and self.curtwistData[self.curTwistIndex].once_twist_ticket_1 then
		local var_124_5 = item_manager:getItemNumber(self.curtwistData[self.curTwistIndex].once_twist_ticket_1)

		if var_124_5 > 0 then
			if var_124_5 < var_124_2 then
				var_124_0 = var_124_0 or true

				table.insert(var_124_1, {
					itemid = self.curtwistData[self.curTwistIndex].once_twist_ticket_1,
					num = var_124_5
				})

				var_124_2 = var_124_2 - var_124_5
			else
				table.insert(var_124_1, {
					itemid = self.curtwistData[self.curTwistIndex].once_twist_ticket_1,
					num = var_124_2
				})

				var_124_2 = 0
				var_124_0 = var_124_0 or false
			end
		end
	end

	if var_124_2 > 0 and self.curtwistData[self.curTwistIndex].costtype then
		local var_124_6 = item_manager:getItemNumber(self.curtwistData[self.curTwistIndex].costtype)

		if var_124_6 > 0 then
			if var_124_6 < var_124_2 then
				var_124_0 = var_124_0 or true

				table.insert(var_124_1, {
					itemid = self.curtwistData[self.curTwistIndex].costtype,
					num = var_124_6
				})

				var_124_2 = var_124_2 - var_124_6
			else
				table.insert(var_124_1, {
					itemid = self.curtwistData[self.curTwistIndex].costtype,
					num = var_124_2
				})

				var_124_2 = 0
				var_124_0 = var_124_0 or false
			end
		end
	end

	if self.curtwistData[self.curTwistIndex].costtype > 4 and var_124_2 > 0 and var_124_2 ~= 10 then
		if self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].supply_currency then
			var_124_3 = var_124_2

			table.insert(var_124_1, {
				itemid = self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].supply_currency,
				num = self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].supply_cost * var_124_2
			})

			var_124_0 = true
		elseif self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].supply_cost then
			var_124_3 = var_124_2

			table.insert(var_124_1, {
				itemid = "diamond",
				num = self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].supply_cost * var_124_2
			})

			var_124_0 = true
		end
	end

	return var_124_0, var_124_1, var_124_3
end

function TwisteggLayer.registSlideEvent(arg_125_0)
	return
end

function TwisteggLayer:switchTwistType(arg_126_1)
	local var_126_2

	if type(arg_126_1) == "string" then
		local var_126_3

		if arg_126_1 == "left" then
			var_126_3 = 1
			var_126_2 = -1
		elseif arg_126_1 == "right" then
			var_126_3 = -1
			var_126_2 = 1
		end

		self.curTwistIndex = self.curTwistIndex + nil
	elseif type(arg_126_1) == "number" then
		self.curTwistIndex = self.curTwistIndex - arg_126_1
		var_126_2 = math.abs(arg_126_1) / arg_126_1
	end

	if #self.curtwistData < self.curTwistIndex then
		self.curTwistIndex = 1
	elseif self.curTwistIndex < 1 then
		self.curTwistIndex = #self.curtwistData
	end

	self:switchShowAction(var_126_2)
end

function TwisteggLayer:switchShowAction(arg_127_1)
	if 2 - arg_127_1 == 1 then
		table.insert(self.cachePanelList, 1, (table.remove(self.cachePanelList)))

		local var_127_0, var_127_1 = var_0_48(self.curTwistIndex, #self.curtwistData)

		print("self.curTwistIndex ===== ", self.curTwistIndex)
		self:updateTwistMain()
		self:updateTwistCache()
	elseif 2 - arg_127_1 == 3 then
		table.insert(self.cachePanelList, (table.remove(self.cachePanelList, 1)))

		local var_127_2, var_127_3 = var_0_48(self.curTwistIndex, #self.curtwistData)

		print("self.curTwistIndex ===== ", self.curTwistIndex)
		self:updateTwistMain()
		self:updateTwistCache()
	end
end

function TwisteggLayer.showTwistRemainCountLabel(arg_128_0, arg_128_1, arg_128_2)
	if not arg_128_1 then
		return
	end

	;(function()
		arg_128_0.restImg:setVisible(true)

		local var_129_0 = arg_128_0.restImg:getChildByName("label_rest_times")

		arg_128_0.restImg:loadTexture("TwistEgg/rest_bg.png", var_0_27)
		var_129_0:setString(arg_128_1)
		var_129_0:setPositionX(arg_128_0.restImg:getContentSize().width - 120)
	end)()
end

function TwisteggLayer:hideTwistRemainCountLabel()
	if self.clipPanel:getChildByName("remaincountlabel") then
		self.clipPanel:getChildByName("remaincountlabel"):setVisible(false)
	end

	if self.clipPanel:getChildByName("remaincounttext") then
		self.clipPanel:getChildByName("remaincounttext"):setVisible(false)
	end
end

local var_0_52 = {
	[0] = "equipment/1000000.png",
	"equipment/1000001.png"
}

setmetatable(var_0_52, {
	__index = function(arg_132_0, arg_132_1)
		return "equipment/" .. item_data[arg_132_1].image_id .. ".png"
	end
})

local var_0_53 = {}

setmetatable(var_0_53, {
	__index = function(arg_133_0, arg_133_1)
		if arg_133_1 == 0 then
			return playermodel.diamond
		elseif arg_133_1 == 1 then
			return playermodel.gold
		else
			return item_manager:getItemNumber(arg_133_1)
		end
	end
})

function TwisteggLayer:updateTimePanel()
	local var_134_0 = {}
	local var_134_1 = {}
	local var_134_2 = false

	table.insert(var_134_0, self.curtwistData[self.curTwistIndex].costtype)

	if self.curtwistData[self.curTwistIndex].once_twist_ticket then
		local var_134_3 = false

		for iter_134_0, iter_134_1 in pairs(var_134_0) do
			if iter_134_1 == self.curtwistData[self.curTwistIndex].once_twist_ticket then
				var_134_3 = true
			end
		end

		if not var_134_3 then
			table.insert(var_134_0, self.curtwistData[self.curTwistIndex].once_twist_ticket)
		end
	end

	if self.curtwistData[self.curTwistIndex].once_twist_ticket_1 then
		table.insert(var_134_0, self.curtwistData[self.curTwistIndex].once_twist_ticket_1)
	end

	if self.twistBlackCard then
		table.insert(var_134_0, self.twistBlackCard)
	end

	if self.twistConfig[self.curtwistData[self.curTwistIndex].twistType].is_skin_twist then
		for iter_134_2, iter_134_3 in pairs(var_134_0) do
			if iter_134_3 ~= 1500001 then
				table.insert(var_134_1, iter_134_3)
			end

			if iter_134_3 == 6800601 then
				var_134_2 = true
			end
		end

		if not var_134_2 then
			table.insert(var_134_1, 1, 6800601)
		end

		var_134_0 = var_134_1
	end

	for iter_134_4 = 1, 3 do
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_currency_" .. iter_134_4):setVisible(false)
	end

	local var_134_4 = 1

	while var_134_4 <= 3 and var_134_0[var_134_4] do
		local var_134_5 = var_134_0[var_134_4]

		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_currency_" .. var_134_4):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_currency_img_" .. var_134_4):loadTexture(var_0_52[var_134_0[var_134_4]])

		local var_134_6 = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_currency_num_" .. var_134_4)

		var_134_6:setString(global_trans_number(var_0_53[var_134_0[var_134_4]]))
		var_134_6:setFontSize(28)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_currency_" .. var_134_4):addTouchEventListener(function(arg_135_0, arg_135_1)
			if arg_135_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not var_134_5 then
				return
			end

			if var_134_5 == 0 then
				return
			end

			if var_134_5 == 1 then
				return
			end

			if not item_data[var_134_5] then
				return
			end

			LayerManager:pushInLayer("PopItemLayer", {
				itemid = var_134_5
			})
		end)

		var_134_4 = var_134_4 + 1
	end
end

function TwisteggLayer:updateCostInfo(arg_136_1)
	local var_136_0 = self.curtwistData[self.twist_type_to_index[arg_136_1]]

	ccui.Helper:seekWidgetByName(self.oneBtn, "one_des"):setVisible(true)
	ccui.Helper:seekWidgetByName(self.tenBtn, "ten_des"):setVisible(true)
	ccui.Helper:seekWidgetByName(self.oneBtn, "Image_ticket"):setVisible(false)
	ccui.Helper:seekWidgetByName(self.tenBtn, "Image_ticket"):setVisible(false)

	local var_136_2 = ccui.Helper:seekWidgetByName(self.oneBtn, "one_des")
	local var_136_3 = ccui.Helper:seekWidgetByName(self.tenBtn, "ten_des")

	if not var_136_2:getChildByName("Label") then
		local var_136_4 = cc.Label:createWithTTF("", FONT_W5, 18)

		var_136_4:setAnchorPoint(cc.p(0.5, 0))
		var_136_4:setPosition(cc.p(var_136_2:getContentSize().width / 2, 0))
		var_136_4:setMaxLineWidth(60)
		var_136_4:setName("Label")
		var_136_2:addChild(var_136_4)
	end

	if not var_136_3:getChildByName("Label") then
		local var_136_5 = cc.Label:createWithTTF("", FONT_W5, 18)

		var_136_5:setAnchorPoint(cc.p(0.5, 0))
		var_136_5:setPosition(cc.p(var_136_3:getContentSize().width / 2, 0))
		var_136_5:setMaxLineWidth(60)
		var_136_5:setName("Label")
		var_136_3:addChild(var_136_5)
	end

	if arg_136_1 == var_0_31 then
		self.oneBtn:getChildByName("one_des"):getChildByName("Label"):setString(L_TWISTEGG_FREE.Single)
		self.oneBtn:getChildByName("ten_des"):getChildByName("Label"):setString(L_TWISTEGG_FREE.Ten)
	else
		local function var_136_6(arg_138_0, arg_138_1, arg_138_2)
			if arg_138_1 == "one" then
				arg_138_0:setString(string.format(L_TWISTEGG_DAILY_FREE, arg_138_2))
				arg_138_0:setPositionX(arg_138_0:getContentSize().width / 2)
				arg_138_0:setPositionY(arg_138_0:getParent():getContentSize().height / 2 - arg_138_0:getContentSize().height / 2)
			else
				local var_138_0 = arg_138_0:getParent()

				arg_138_0:setString(string.format(L_TWISTEGG_DAILY_FREE, arg_138_2))
				arg_138_0:setPositionX(arg_138_0:getContentSize().width / 2)
				arg_138_0:setPositionY(var_138_0:getContentSize().height / 2 - arg_138_0:getContentSize().height / 2)
			end
		end

		local function var_136_7(arg_139_0, arg_139_1, arg_139_2)
			if arg_139_1 == "one" then
				arg_139_0:setString(string.format(L_TWISTEGG_TOTAL_FREE.Single, arg_139_2))
				arg_139_0:setPositionX(arg_139_0:getContentSize().width / 2)
				arg_139_0:setPositionY(arg_139_0:getParent():getContentSize().height / 2 - arg_139_0:getContentSize().height / 2)
			else
				local var_139_0 = arg_139_0:getParent()

				arg_139_0:setString(string.format(L_TWISTEGG_TOTAL_FREE.Ten, arg_139_2))
				arg_139_0:setPositionX(arg_139_0:getContentSize().width / 2)
				arg_139_0:setPositionY(var_139_0:getContentSize().height / 2 - arg_139_0:getContentSize().height / 2)
			end
		end

		local function var_136_8(arg_140_0, arg_140_1)
			local var_140_0 = L_NUMBER_TEXT
			local var_140_1 = setmetatable({}, {
				__index = function(arg_141_0, arg_141_1)
					local var_141_0 = var_136_0.costtype == 6800401 and L_MEI or var_136_0.costtype == 6800402 and L_GE or L_ZHANG

					if arg_141_1 <= 10 then
						return var_140_0[arg_141_1] .. var_141_0
					else
						return arg_141_1 .. var_141_0
					end
				end
			})
			local var_140_2 = setmetatable({}, {
				__index = function(arg_142_0, arg_142_1)
					return 0.25
				end
			})
			local var_140_3 = arg_140_0:getChildByName("Label")
			local var_140_4 = arg_140_0:getChildByName("Image_ticket")
			local var_140_5
			local var_140_6
			local var_140_7

			if arg_140_1 == "one" then
				if not var_136_0.costone then
					arg_140_0:setVisible(false)

					return
				end

				var_140_5 = arg_136_1 == var_0_32 and math.max(self:calculateTwistFavorNum() * var_136_0.costone, var_136_0.costone) or var_136_0.costone

				if var_136_0.twist_remain_count and var_136_0.twist_remain_count <= 0 then
					var_140_3:setString(L_TWISTLAYER[8])

					return
				end

				var_140_4:setVisible(true)

				if var_136_0.once_twist_ticket and item_manager:getItemNumber(var_136_0.once_twist_ticket) >= (var_140_5 or 1) then
					var_140_6 = string.format("equipment/%s.png", item_data[var_136_0.once_twist_ticket].image_id)
					var_140_7 = var_136_0.once_twist_ticket
				elseif var_136_0.once_twist_ticket_1 and item_manager:getItemNumber(var_136_0.once_twist_ticket_1) >= (var_140_5 or 1) then
					var_140_6 = string.format("equipment/%s.png", item_data[var_136_0.once_twist_ticket_1].image_id)
					var_140_7 = var_136_0.once_twist_ticket_1
				elseif var_136_0.costtype > 2 then
					var_140_6 = string.format("equipment/%s.png", item_data[var_136_0.costtype].image_id)
					var_140_7 = var_136_0.costtype
				elseif var_136_0.costtype == 1 then
					var_140_6 = string.format("equipment/%s.png", 1000001)
					var_140_7 = var_136_0.costtype
				elseif var_136_0.costtype == 0 then
					var_140_6 = string.format("equipment/%s.png", 1000000)
					var_140_7 = var_136_0.costtype
				end
			else
				if not var_136_0.costten then
					arg_140_0:setVisible(false)

					return
				end

				var_140_5 = var_136_0.costten

				if var_136_0.twist_remain_count then
					if var_136_0.twist_remain_count <= 0 then
						var_140_3:setString(L_TWISTLAYER[8])

						return
					else
						var_140_5 = var_136_0.twist_remain_count >= 10 and var_136_0.costten or var_136_0.costone * math.min(10, var_136_0.twist_remain_count)
					end
				end

				var_140_4:setVisible(true)

				if var_136_0.once_twist_ticket and item_manager:getItemNumber(var_136_0.once_twist_ticket) >= 1 then
					var_140_6 = string.format("equipment/%s.png", item_data[var_136_0.once_twist_ticket].image_id)
					var_140_7 = var_136_0.once_twist_ticket
				elseif var_136_0.once_twist_ticket_1 and item_manager:getItemNumber(var_136_0.once_twist_ticket_1) >= 1 then
					var_140_6 = string.format("equipment/%s.png", item_data[var_136_0.once_twist_ticket_1].image_id)
					var_140_7 = var_136_0.once_twist_ticket_1
				elseif var_136_0.costtype > 2 then
					var_140_6 = string.format("equipment/%s.png", item_data[var_136_0.costtype].image_id)
					var_140_7 = var_136_0.costtype
				elseif var_136_0.costtype == 1 then
					var_140_6 = string.format("equipment/%s.png", 1000001)
					var_140_7 = var_136_0.costtype
				elseif var_136_0.costtype == 0 then
					var_140_6 = string.format("equipment/%s.png", 1000000)
					var_140_7 = var_136_0.costtype
				end
			end

			var_140_4:loadTexture(var_140_6)
			var_140_4:setScale(var_140_2[var_140_7])
			var_140_3:setString("x" .. var_140_5)

			local var_140_8 = var_140_3:getContentSize().width
			local var_140_9 = var_140_4:getContentSize().width * var_140_2[var_140_7]
			local var_140_10 = arg_140_0:getContentSize().width / 2

			var_140_4:setPositionX(var_140_10)
			var_140_3:setPositionX(var_140_10)
			var_140_3:setPositionY(2)

			arg_140_0.itemid = var_140_7
		end

		local var_136_9 = self.oneBtn:getChildByName("one_des"):getChildByName("Label")
		local var_136_10 = self.tenBtn:getChildByName("ten_des"):getChildByName("Label")

		ccui.Helper:seekWidgetByName(self.oneBtn, "one_des").itemid = nil

		if var_136_0.dailyfreeforone and var_136_0.dailyfreeforone > 0 then
			var_136_6(var_136_9, "one", var_136_0.dailyfreeforone)
		elseif var_136_0.totalfreeforone and var_136_0.totalfreeforone > 0 then
			var_136_7(var_136_9, "one", var_136_0.totalfreeforone)
		else
			var_136_8(ccui.Helper:seekWidgetByName(self.oneBtn, "one_des"), "one")
		end

		ccui.Helper:seekWidgetByName(self.tenBtn, "ten_des").itemid = nil

		if var_136_0.dailyfreeforten and var_136_0.dailyfreeforten > 0 then
			var_136_6(var_136_10, "ten", var_136_0.dailyfreeforten)
		elseif var_136_0.totalfreeforten and var_136_0.totalfreeforten > 0 then
			var_136_7(var_136_10, "ten", var_136_0.totalfreeforten)
		else
			var_136_8(ccui.Helper:seekWidgetByName(self.tenBtn, "ten_des"), "ten")
		end
	end

	if var_136_0.naivemark or arg_136_1 == 125 or arg_136_1 == 2 or arg_136_1 == 26 or arg_136_1 == 27 or arg_136_1 == 28 then
		self.oneBtn:setVisible(false)
		self.tenBtn:setVisible(true)
		self.tenBtn:setPositionX(320)
	elseif arg_136_1 == 24 then
		self.tenBtn:setVisible(false)
		self.oneBtn:setVisible(true)
		self.oneBtn:setPositionX(320)
	else
		self.oneBtn:setVisible(true)
		self.oneBtn:setPositionX(162)
		self.tenBtn:setVisible(true)
		self.tenBtn:setPositionX(472)
	end

	if var_136_0.twist_remain_count then
		self.tenBtn:getChildByName("num_label"):loadTexture("TwistEgg/num" .. ((var_136_0.twist_remain_count < 10 or nil) and (var_136_0.twist_remain_count or 10)) .. ".png", var_0_27)
	else
		self.tenBtn:getChildByName("num_label"):loadTexture("TwistEgg/num10.png", var_0_27)
	end

	if arg_136_1 == var_0_32 then
		local var_136_11 = var_136_0.twist_remain_count and math.min(self:calculateTwistFavorNum(), var_136_0.twist_remain_count) or self:calculateTwistFavorNum()

		if var_136_11 > 0 then
			self.oneBtn:loadTextures("TwistEgg/one_draw2.png", "TwistEgg/one_draw2.png", "TwistEgg/one_draw2.png", var_0_27)
		else
			self.oneBtn:loadTextures("TwistEgg/one_draw1.png", "TwistEgg/one_draw1.png", "TwistEgg/one_draw1.png", var_0_27)
		end

		self.oneBtn:getChildByName("labelNum"):setString("" .. var_136_11)
		self.oneBtn:getChildByName("labelNum"):setVisible(var_136_11 > 0)
	else
		self.oneBtn:loadTextures("TwistEgg/one_draw1.png", "TwistEgg/one_draw1.png", "TwistEgg/one_draw1.png", var_0_27)
		self.oneBtn:getChildByName("labelNum"):setVisible(false)
	end
end

function TwisteggLayer:updateTwistCount(arg_143_1, arg_143_2, arg_143_3, arg_143_4)
	local var_143_0 = self.twist_type_to_index[arg_143_1]

	if self.curtwistData[self.twist_type_to_index[arg_143_1]].upcount2 then
		self.curtwistData[var_143_0].upcount2 = self.curtwistData[var_143_0].upcount2 - arg_143_2

		if self.curtwistData[var_143_0].upcount then
			self.curtwistData[var_143_0].upcount = self.curtwistData[var_143_0].upcount - arg_143_2
		end

		if self.curtwistData[var_143_0].upcount2 <= 0 then
			self.curtwistData[var_143_0].upcount2 = nil
		end

		if self.curtwistData[var_143_0].upcount and self.curtwistData[var_143_0].upcount <= 0 then
			self.curtwistData[var_143_0].upcount = nil
		end

		if self.curtwistData[var_143_0].uppos2 == 1 then
			-- block empty
		else
			-- block empty
		end
	elseif self.curtwistData[var_143_0].upcount then
		self.curtwistData[var_143_0].upcount = arg_143_3 and arg_143_3 or self.curtwistData[var_143_0].upcount - arg_143_2

		if self.curtwistData[var_143_0].upcount <= 0 then
			self.curtwistData[var_143_0].upcount = nil
		end
	end

	self.curtwistData[var_143_0].guaranteeprob = arg_143_4
end

function TwisteggLayer:lackofcost(arg_144_1, arg_144_2)
	local var_144_0 = self.curtwistData[self.twist_type_to_index[arg_144_2]].costtype

	if arg_144_2 == var_0_31 then
		global_ShowBlockWords(var_0_36[arg_144_2])
	elseif var_144_0 > 4 then
		local var_144_1

		if arg_144_1 == var_0_28 or arg_144_1 == var_0_30 then
			var_144_1 = self.curtwistData[self.twist_type_to_index[arg_144_2]].costone - item_manager:getItemNumber(var_144_0)
		elseif arg_144_1 == var_0_29 then
			var_144_1 = self.curtwistData[self.twist_type_to_index[arg_144_2]].twist_remain_count and self.curtwistData[self.twist_type_to_index[arg_144_2]].costone * math.min(self.curtwistData[self.twist_type_to_index[arg_144_2]].twist_remain_count, 10) - item_manager:getItemNumber(var_144_0) or self.curtwistData[self.twist_type_to_index[arg_144_2]].costten - item_manager:getItemNumber(var_144_0)
		end

		if not self.twistConfig[arg_144_2].supply_cost then
			if self.twistConfig[arg_144_2].gold_cost then
				local var_144_2 = {
					is_need_pop_layer = 1
				}

				function var_144_2.surecallback()
					network:rpc("supply_twist_cost", {
						twisttype = arg_144_2,
						num = var_144_1
					}, function(arg_146_0)
						if arg_146_0.result == 1 then
							if self.twistConfig[arg_144_2].supply_currency then
								item_manager:deleteItem(self.twistConfig[arg_144_2].supply_currency, var_144_1 * self.twistConfig[arg_144_2].supply_cost)
							elseif self.twistConfig[arg_144_2].supply_cost then
								playermodel.diamond = playermodel.diamond - var_144_1 * self.twistConfig[arg_144_2].supply_cost
							else
								playermodel.gold = playermodel.gold - var_144_1 * self.twistConfig[arg_144_2].gold_cost
							end

							global_update_gold_stone_diamond(playermodel.gold, nil, playermodel.diamond)
							item_manager:setItemByServerItem(arg_146_0.item)
							self:updateTimePanel()
							self.oneBtn:setBright(false)
							self.tenBtn:setBright(false)

							local function var_146_0()
								self.oneBtn:setBright(true)
								self.tenBtn:setBright(true)
							end

							if arg_144_1 == var_0_28 then
								self:twist_one_result(arg_144_2, var_146_0)
							else
								self:twist_ten_result(arg_144_2, var_146_0)
							end

							global_ShowBlockWords(L_TWISTEGG_LACK_OF_COST.Buy_Success, RISE_WORDS_SUCCESS)

							if self.twistConfig[arg_144_2].supply_cost then
								AnalyticManager.buyTwistTicketSuccess(var_144_1 * self.twistConfig[arg_144_2].supply_cost, var_144_1)
							end
						elseif arg_146_0.result == 2 then
							LayerManager:pushInLayer("PopGoBuyDiamond", {
								is_need_pop_layer = 0
							})
						elseif arg_146_0.result == 3 then
							LayerManager:pushInLayer("PopGoGainLayer", {
								goto_back_system_id = 180,
								item = var_144_0
							})
						else
							l2Log("buy_twist_ticket fail")
						end
					end)
				end

				if self.twistConfig[arg_144_2].supply_currency then
					var_144_2.costtype = self.twistConfig[arg_144_2].supply_currency
					var_144_2.own = item_manager:getItemNumber(self.twistConfig[arg_144_2].supply_currency)
					var_144_2.cost = self.twistConfig[arg_144_2].supply_cost * var_144_1
					var_144_2.hideown = true
					var_144_2.des = string.format(L_BUY_SCRIP_OTHER, self.twistConfig[arg_144_2].supply_cost * var_144_1, item_data[self.twistConfig[arg_144_2].supply_currency].name, var_144_1, item_data[var_144_0].name)
				elseif self.twistConfig[arg_144_2].supply_cost then
					var_144_2.costtype = "diamond"
					var_144_2.own = playermodel.diamond
					var_144_2.cost = self.twistConfig[arg_144_2].supply_cost * var_144_1
					var_144_2.des = string.format(L_BUY_SCRIP, self.twistConfig[arg_144_2].supply_cost * var_144_1, var_144_1, item_data[var_144_0].name)
				else
					var_144_2.costtype = "gold"
					var_144_2.own = playermodel.gold
					var_144_2.cost = self.twistConfig[arg_144_2].gold_cost * var_144_1
					var_144_2.des = string.format(L_TWISTEGG_LACK_OF_COST.Cost_Gold, self.twistConfig[arg_144_2].gold_cost * var_144_1, var_144_1, item_data[var_144_0].name)
				end

				var_144_2.labels = global_deepCopy(L_COMPONENT_TWIST)
				var_144_2.labels.des = var_144_2.des or L_TWISTEGG_LACK_OF_COST.Cost_Diamond_Des

				print(self.twistConfig[arg_144_2].supply_cost, arg_144_2, var_144_0, "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")

				if var_144_0 == 108001001 then
					LayerManager:pushInLayer("PopFoolTwistJumpLayter", {
						[3] = {
							popmsg = var_144_2
						}
					})
				else
					LayerManager:pushInLayer("PopDoLayer", var_144_2)
				end
			elseif var_144_0 == 6800601 then
				LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
					targetlayer = "PopSupermarketLayer",
					callback = function()
						if TwisteggLayer.getInstance() then
							TwisteggLayer.getInstance():updateTimePanel()
						end
					end
				})
			end
		end

		LayerManager:pushInLayer("PopGoGainLayer", {
			goto_back_system_id = 180,
			item = var_144_0
		})
	elseif var_144_0 == var_0_40 then
		LayerManager:pushInLayer("PopGoLayer", {
			targetlayer = "HandOfMidasLayer",
			labels = L_GO_BUY_GOLD
		})
	elseif var_144_0 == 0 then
		LayerManager:pushInLayer("PopGoBuyDiamond", {
			is_need_pop_layer = 1,
			callback = updateCoinLabel
		})
	end
end

function TwisteggLayer.showTwistEggDrops(arg_149_0, arg_149_1)
	twist_manager:get_twist_drop_info(arg_149_1, function(arg_150_0, arg_150_1)
		if arg_150_0 ~= 1 then
			return
		end

		LayerManager:pushInLayer("DropDetailsLayer", arg_150_1)
	end)
end

function TwisteggLayer:updateGoldPanel()
	if self.curtwistData[self.curTwistIndex] and self.curtwistData[self.curTwistIndex].costtype == 1 then
		self:updateTimePanel()
	end
end

function TwisteggLayer.get_naive_stat(arg_152_0, arg_152_1, arg_152_2)
	local bit = require("bit")
	local var_152_1 = bit.band(arg_152_1, 1) > 0 and true
	local var_152_2 = bit.band(arg_152_1, 2) > 0 and true

	if arg_152_2 == "one" then
		return var_152_1
	elseif arg_152_2 == "ten" then
		return var_152_2
	else
		return var_152_2
	end
end

function TwisteggLayer:updateNaiveTwist(arg_153_1, arg_153_2)
	local bit = require("bit")
	local var_153_1 = self.twist_type_to_index[arg_153_1]
	local var_153_2 = self.curtwistData[self.twist_type_to_index[arg_153_1]]

	if arg_153_2 == "one" then
		var_153_2.naivemark = bit.bor(self.curtwistData[self.twist_type_to_index[arg_153_1]].naivemark, 1)
	elseif arg_153_2 == "ten" then
		var_153_2.naivemark = bit.bor(self.curtwistData[self.twist_type_to_index[arg_153_1]].naivemark, 2)
	end

	if self:get_naive_stat(var_153_2.naivemark) then
		table.remove(self.curtwistData, var_153_1)

		for iter_153_0, iter_153_1 in pairs(self.curtwistData) do
			self.twist_type_to_index[iter_153_1.twistType] = iter_153_0
		end

		self.twistList:deleteNode(var_153_1)

		self.curTwistIndex = 1
		self.nowListNode = self.twistList:getNodeObjBytwistIndex(self.curTwistIndex)

		self:updateTwistMain()
		self:updateTwistCache()
		self.oneBtn:setOpacity(255)
		self.tenBtn:setOpacity(255)
	elseif self:get_naive_stat(var_153_2.naivemark, "one") then
		self.oneBtn:setOpacity(100)
	elseif self:get_naive_stat(var_153_2.naivemark, "ten") then
		self.tenBtn:setOpacity(100)
	end
end

function TwisteggLayer:updateFiniteTwist(arg_154_1, arg_154_2)
	if self.curtwistData[self.twist_type_to_index[arg_154_1]].twist_remain_count <= 0 then
		self.twist_type_to_index[table.remove(self.curtwistData, self.twist_type_to_index[arg_154_1]).twistType] = nil

		for iter_154_0, iter_154_1 in pairs(self.curtwistData) do
			self.twist_type_to_index[iter_154_1.twistType] = iter_154_0
		end

		self.twistList:deleteNode(self.twist_type_to_index[arg_154_1])

		self.curTwistIndex = 1
		self.nowListNode = self.twistList:getNodeObjBytwistIndex(self.curTwistIndex)

		self:updateTwistMain()
		self:updateTwistCache()
		self.oneBtn:setOpacity(255)
		self.tenBtn:setOpacity(255)
	end
end

function TwisteggLayer:updateLimitTwist(arg_155_1, arg_155_2, arg_155_3)
	local var_155_0 = self.twist_type_to_index[arg_155_1]
	local var_155_1 = self.curtwistData[self.twist_type_to_index[arg_155_1]].twist_remain_count <= 0
	local var_155_2 = arg_155_3 ~= nil
	local var_155_3 = self.curtwistData[self.twist_type_to_index[arg_155_1]].twist_remain_count <= 0 and var_155_2

	if self.curtwistData[self.twist_type_to_index[arg_155_1]].twist_remain_count > 0 and not var_155_2 then
		return
	end

	if var_155_3 then
		twist_manager:insert_new_twist(arg_155_3, var_155_0)

		self.nowListNode = self.twistList:getNodeObjBytwistIndex(self.curTwistIndex)

		self.nowListNode:loadTextures(("mainScenebg/twist_bg_new/small_" .. arg_155_3.config.img) .. "_on.png", ("mainScenebg/twist_bg_new/small_" .. arg_155_3.config.img) .. "_off.png", ("mainScenebg/twist_bg_new/small_" .. arg_155_3.config.img) .. "_off.png")
	elseif var_155_2 then
		twist_manager:insert_new_twist(arg_155_3)
	elseif var_155_1 then
		twist_manager:delete_deperecate_twist(arg_155_1)
		self.twistList:deleteNode(var_155_0)

		self.curTwistIndex = 1
		self.nowListNode = self.twistList:getNodeObjBytwistIndex(self.curTwistIndex)
	end

	self:updateTwistMain()
	self:updateTwistCache()
	self.oneBtn:setOpacity(255)
	self.tenBtn:setOpacity(255)
end

function TwisteggLayer:initPurchaseEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("on_gain_item", function(arg_157_0)
		self:updateTimePanel()
	end), self)
	activity_manager:registerEventListener("TwisteggLayer", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function(arg_158_0)
		self:updateTwistMain()
	end)
end

function TwisteggLayer:updateNoUpdropReward(arg_159_1, arg_159_2)
	local var_159_0 = self.oneBtn:getChildByName("no_dropup_btn")

	if not var_159_0 then
		var_159_0 = ccui.Button:create("public/twist/no_updrop_reward_bg.png", nil, "public/twist/no_updrop_reward_bg.png", var_0_27)

		var_159_0:setPositionX(60)
		var_159_0:setPositionY(260)
		self.oneBtn:addChild(var_159_0)
		var_159_0:setName("no_dropup_btn")
		var_159_0:addTouchEventListener(function(arg_160_0, arg_160_1)
			if arg_160_1 ~= ccui.TouchEventType.ended then
				return
			end

			network:rpc("get_no_updrop_reward", {
				twisttype = self.curtwistData[self.curTwistIndex].twistType
			}, function(arg_161_0)
				if arg_161_0.result == 1 then
					global_gain(arg_161_0)
					self.updateNoUpdropReward({
						no_dropup_stat = var_0_45
					})
					var_159_0:setVisible(false)
				elseif arg_161_0.result == 2 then
					global_ShowBlockWords("未完成")
				elseif arg_161_0.result == 3 then
					global_ShowBlockWords("已领取")
				else
					global_ShowBlockWords("no_updrop_reward字段没配")
				end
			end)
		end)

		local var_159_1 = ccui.ImageView:create("public/twist/no_updrop_reward_off.png", var_0_27)

		var_159_1:setPosition(50, 55)
		var_159_0:addChild(var_159_1)
		var_159_1:setName("icon")

		local var_159_2 = ccui.ImageView:create("public/twist/no_updrop_count_bg.png", var_0_27)

		var_159_2:setPosition(45, -10)
		var_159_0:addChild(var_159_2)
		var_159_2:setName("count_bg")

		local var_159_3 = cc.Label:createWithTTF("", FONT_BUTTON, 18)

		var_159_3:setPosition(45, -10)
		var_159_0:addChild(var_159_3)
		var_159_3:setName("count")
	end

	if not arg_159_1.no_dropup_stat or arg_159_1.no_dropup_stat == var_0_45 then
		var_159_0:setVisible(false)

		return
	end

	var_159_0:getChildByName("count"):setString(arg_159_1.totalCount .. "/" .. arg_159_1.no_updrop_count)
	var_159_0:getChildByName("icon"):loadTexture(arg_159_1.no_dropup_stat == var_0_43 and "public/twist/no_updrop_reward_off.png" or "public/twist/no_updrop_reward_on.png", var_0_27)
	var_159_0:setVisible(true)
end

function TwisteggLayer:updateNoUpdropData(arg_162_1, arg_162_2, arg_162_3)
	if not arg_162_1 then
		return
	end

	self.configData = twist_manager:get_data_by_type(self.curtwistData[self.curTwistIndex].twistType)
	self.curtwistData[self.curTwistIndex].no_dropup_stat = arg_162_1
	self.curtwistData[self.curTwistIndex].totalCount = arg_162_2
	self.curtwistData[self.curTwistIndex].no_updrop_count = arg_162_3
end

function TwisteggLayer:updateClipPanelUIOnSelectUpsType10(arg_163_1, arg_163_2)
	self:updateMainImg("public/panelbg/text_bg.png", (arg_163_2:getChildByName("image_main")))
	self:updateBgImg(("mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_163_1]].img) .. "/bg.png", (arg_163_2:getChildByName("image_bg")))
	self:updateTitleImg(self.curtwistData[self.twist_type_to_index[arg_163_1]], (arg_163_2:getChildByName("image_title")))
	self:updateRarityImg(("mainScenebg/twist_bg_new/" .. self.curtwistData[self.twist_type_to_index[arg_163_1]].img) .. "/des.png", (arg_163_2:getChildByName("image_rarity")))
	self:updateRightBtnList(arg_163_1, arg_163_2)
	arg_163_2:getChildByName("rightBtnListPanel"):getChildByName("panel"):setVisible(true)
	arg_163_2:getChildByName("btn_detail"):setVisible(false)
	self:updateSelectupPanel(arg_163_1, arg_163_2)
	self:updateOverClockUI(arg_163_1, arg_163_2)
	self:hideSelectupPanelType3(arg_163_1, arg_163_2)
	self:hideSelectupPanelType4(arg_163_1, arg_163_2)
end

function TwisteggLayer:updateSelectSoftUI(arg_164_1)
	local var_164_0 = self.oneBtn:getChildByName("selectup_soft_btn")

	if not var_164_0 then
		var_164_0 = ccui.Button:create("public/twist/selectup_soft_btn_off.png", nil, "public/twist/selectup_soft_btn_off.png", var_0_27)

		var_164_0:setPositionX(50)
		var_164_0:setPositionY(120)
		self.oneBtn:addChild(var_164_0)
		var_164_0:setName("selectup_soft_btn")

		local var_164_1 = ccui.ImageView:create("public/twist/selectup_soft_icon.png", var_0_27)

		var_164_1:setPosition(40, 39)
		var_164_0:addChild(var_164_1)
		var_164_1:setScale(0.36)
		var_164_1:setName("img")
		var_164_1:setVisible(false)

		local var_164_2 = ccui.ImageView:create("public/twist/selectup_soft_icon.png", var_0_27)

		var_164_2:setPosition(10, 70)
		var_164_0:addChild(var_164_2)
		var_164_2:setName("icon")

		local var_164_3 = ccui.ImageView:create("public/twist/selectup_soft_up.png", var_0_27)

		var_164_3:setPosition(70, 20)
		var_164_0:addChild(var_164_3)
		var_164_3:setName("up_icon")
	end

	if twist_manager:get_twist_selectup_uitype(arg_164_1) ~= 6 then
		var_164_0:setVisible(false)

		return
	end

	var_164_0:setVisible(true)
	var_164_0:addTouchEventListener(function(arg_165_0, arg_165_1)
		if arg_165_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:updateSelectSoftPanel(arg_164_1)
	end)

	local var_164_4 = twist_manager:get_selected_up(arg_164_1)

	if var_164_4 and var_164_4 ~= 0 then
		var_164_0:loadTextures("public/twist/selectup_soft_btn_on.png", nil, "public/twist/selectup_soft_btn_on.png", var_0_27)
		var_164_0:getChildByName("img"):loadTexture("equipment/" .. item_data[var_164_4].image_id .. ".png")
		var_164_0:getChildByName("img"):setVisible(true)
	else
		var_164_0:loadTextures("public/twist/selectup_soft_btn_off.png", nil, "public/twist/selectup_soft_btn_off.png", var_0_27)
		var_164_0:getChildByName("img"):setVisible(false)
	end
end

function TwisteggLayer:testPrint(arg_166_1)
	if twist_manager:is_new_selectup_twist(arg_166_1) or twist_manager:is_selectup_twist(arg_166_1) then
		self:updateSelectSoftUI(arg_166_1)
	elseif self.oneBtn:getChildByName("selectup_soft_btn") then
		self.oneBtn:getChildByName("selectup_soft_btn"):setVisible(false)
	end
end

function TwisteggLayer:updateSelectSoftPanel(arg_167_1)
	if not self.selectSoftLayer then
		local var_167_0 = ccui.Layout:create()

		var_167_0:setContentSize(cc.size(640, 1600))
		var_167_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_167_0:setCascadeOpacityEnabled(false)
		var_167_0:setBackGroundColorOpacity(178)
		var_167_0:setAnchorPoint(0.5, 0.5)
		var_167_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_167_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_167_0:setTouchEnabled(true)
		var_167_0:setLocalZOrder(999)
		var_167_0:setVisible(true)

		self.selectSoftLayer = var_167_0

		self.rootLayer:addChild(var_167_0)

		local var_167_1 = ccui.ImageView:create("public/twist/selectup_soft_bg.png", var_0_27)

		var_167_1:setPosition(320, 800 - GameDisplay.fix_y)
		var_167_0:addChild(var_167_1)
		var_167_1:setName("bg")

		local var_167_2 = ccui.ImageView:create("public/twist/selectup_soft_title.png", var_0_27)

		var_167_2:setAnchorPoint(0, 0)
		var_167_2:setPosition(0, 500)
		var_167_1:addChild(var_167_2)

		local var_167_3 = require("view.Sprite.RichTextPro"):create()

		var_167_3:setMaxWidth(420)
		var_167_3:setSize(25)
		var_167_3:setLineSpace(0)
		var_167_3:setText("在获得<span style=color: rgb(0, 255, 252);>稀有掉落</span>时，有<span style=color: rgb(0, 255, 252);>%d</span>%概率获得选中掉落;并且在连续<span style=color: rgb(0, 255, 252);>%d</span>次未获得选中掉落时，下一次获得<span style=color: rgb(0, 255, 252);>稀有掉落</span>必定为<span style=color: rgb(0, 255, 252);>选中掉落</span>！</p>", nil, true)
		var_167_3:setPosition(50, 480)
		var_167_1:addChild(var_167_3)
		var_167_3:setName("richText")

		local var_167_4 = ccui.ListView:create()

		var_167_4:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		var_167_4:setBounceEnabled(true)
		var_167_4:setContentSize(440, 280)
		var_167_4:setPosition(270, 200)
		var_167_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_167_4:setItemsMargin(0.1)
		var_167_1:addChild(var_167_4)

		self.selectupList = var_167_4
		self.selectup_Layout = ccui.Layout:create()

		self.selectup_Layout:setContentSize(420, 200)
		var_167_4:pushBackCustomItem(self.selectup_Layout)
		var_167_0:addTouchEventListener(function(arg_168_0, arg_168_1)
			if arg_168_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_167_0:setVisible(false)
		end)
	end

	local var_167_5 = twist_manager:get_selectup_list(arg_167_1)
	local var_167_6 = twist_manager:get_selected_up(arg_167_1)

	if not var_167_5 or #var_167_5 < 1 then
		self.selectSoftLayer:setVisible(false)

		return
	end

	self.selectSoftLayer:setVisible(true)

	local var_167_7

	for iter_167_0, iter_167_1 in ipairs(var_167_5) do
		if iter_167_1 == var_167_6 then
			var_167_7 = iter_167_0
		end
	end

	local var_167_8 = self.curtwistData[self.curTwistIndex].selectup_force_weightUp
	local var_167_9 = "在获得<span style=color: rgb(255,72,72);>稀有掉落</span>时，有<span style=color: rgb(103,203,255);>%s</span>概率获得选中掉落;并且在连续<span style=color: rgb(103,203,255);> %d </span>次未获得选中掉落时，下一次获得<span style=color: rgb(255,72,72);>稀有掉落</span>必定为<span style=color: rgb(103,203,255);>选中掉落</span>！</p>"

	self.selectSoftLayer:getChildByName("bg"):getChildByName("richText"):clearText()
	self.selectSoftLayer:getChildByName("bg"):getChildByName("richText"):setText(string.format("在获得<span style=color: rgb(255,72,72);>稀有掉落</span>时，有<span style=color: rgb(103,203,255);>%s</span>概率获得选中掉落;并且在连续<span style=color: rgb(103,203,255);> %d </span>次未获得选中掉落时，下一次获得<span style=color: rgb(255,72,72);>稀有掉落</span>必定为<span style=color: rgb(103,203,255);>选中掉落</span>！</p>", self.curtwistData[self.curTwistIndex].selectup_force_weightUp .. "%", self.curtwistData[self.curTwistIndex].selectup_force_count), nil, true)
	twist_manager:get_twist_drop_info(arg_167_1, function(arg_172_0, arg_172_1)
		if arg_172_0 ~= 1 then
			return
		end

		for iter_172_0, iter_172_1 in ipairs(var_167_5) do
			local var_172_0 = self.selectup_Layout:getChildByName("bg_" .. iter_172_0)
			local var_172_1

			for iter_172_2, iter_172_3 in pairs(arg_172_1.category.data) do
				if var_172_0.item_id == iter_172_3.itemid then
					var_172_1 = iter_172_3.prob
				end
			end

			var_167_9 = string.format("%.2f", var_172_1 * 100)

			var_172_0:getChildByName("labelbg"):getChildByName("label"):setString(var_167_9 .. "%")
		end
	end)
	;(function(arg_169_0, arg_169_1)
		self.selectup_Layout:removeFromParent()

		local var_169_0 = (math.ceil(#arg_169_0 / 3) + 1) * 140

		self.selectup_Layout = ccui.Layout:create()

		self.selectup_Layout:setContentSize(420, var_169_0)
		self.selectupList:pushBackCustomItem(self.selectup_Layout)

		for iter_169_0, iter_169_1 in ipairs(arg_169_0) do
			local var_169_1 = ccui.ImageView:create("public/twist/selectup_item_bg.png", var_0_27)

			var_169_1:setTouchEnabled(true)
			var_169_1:setPosition((iter_169_0 - 1) % 3 * 140 + 65, var_169_0 - math.ceil(iter_169_0 / 3) * 140 + 60)
			self.selectup_Layout:addChild(var_169_1)
			var_169_1:setName("bg_" .. iter_169_0)

			local var_169_2 = ccui.ImageView:create("equipment/" .. item_data[iter_169_1].image_id .. ".png")

			var_169_2:setPosition(51, 52)
			var_169_2:setScale(0.59)
			var_169_1:addChild(var_169_2)

			var_169_1.item_id = iter_169_1

			local var_169_3 = ccui.ImageView:create("public/twist/selectup_item_mask.png", var_0_27)

			var_169_1:addChild(var_169_3)
			var_169_3:setAnchorPoint(0, 0)
			var_169_3:setPosition(-13, -13)
			var_169_3:setName("mask")

			local var_169_4 = ccui.ImageView:create("public/twist/selectup_item_mask1.png", var_0_27)

			var_169_4:setAnchorPoint(0, 0)
			var_169_4:setPosition(14, 5)
			var_169_3:addChild(var_169_4)
			var_169_3:setVisible(arg_169_1 and iter_169_0 == arg_169_1 or false)

			local var_169_5 = ccui.ImageView:create("public/twist/selectup_soft_label.png", var_0_27)

			var_169_5:setAnchorPoint(0, 0)
			var_169_5:setName("labelbg")
			var_169_1:addChild(var_169_5)

			local var_169_6 = cc.Label:createWithTTF("", FONT_BUTTON, 15)

			var_169_5:addChild(var_169_6)
			var_169_6:setPosition(75, 10)
			var_169_6:setString(math.floor(arg_169_1 and arg_169_1 == iter_169_0 and var_167_8 or arg_169_1 and (100 - var_167_8) / #arg_169_0 or 100 / #arg_169_0) .. "%")
			var_169_6:setName("label")
			var_169_1:addTouchEventListener(function(arg_170_0, arg_170_1)
				if arg_170_1 ~= ccui.TouchEventType.ended then
					return
				end

				self:popSelectSureLayout({
					callback = function()
						if arg_169_1 and arg_169_1 == iter_169_0 then
							twist_manager:set_selectups(arg_167_1, 0)
						else
							twist_manager:set_selectups(arg_167_1, iter_169_1)
						end
					end,
					type = arg_169_1 and arg_169_1 == iter_169_0 and 1 or 2,
					itemid = iter_169_1
				})
			end)
		end
	end)(var_167_5, var_167_7)
end

function TwisteggLayer:popSelectSureLayout(arg_173_1)
	if not self.popSelectSurePanel then
		local var_173_0 = ccui.Layout:create()

		var_173_0:setContentSize(cc.size(640, 1600))
		var_173_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_173_0:setCascadeOpacityEnabled(false)
		var_173_0:setBackGroundColorOpacity(178)
		var_173_0:setAnchorPoint(0.5, 0.5)
		var_173_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_173_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_173_0:setTouchEnabled(true)
		var_173_0:setLocalZOrder(1000)
		var_173_0:setVisible(true)

		self.popSelectSurePanel = var_173_0

		self.rootLayer:addChild(var_173_0)

		local var_173_1 = ccui.ImageView:create("public/twist/select_sure_bg.png", var_0_27)

		var_173_1:setPosition(320, 800 - GameDisplay.fix_y)
		var_173_0:addChild(var_173_1)
		var_173_1:setName("bg")

		local var_173_2 = require("view.Sprite.RichTextPro"):create()

		var_173_2:setMaxWidth(360)
		var_173_2:setSize(25)
		var_173_2:setLineSpace(0)
		var_173_2:setText("选择<span style=color: rgb(255,72,72);>111111</span>作为概率提升掉落</p>", nil, true)
		var_173_2:setPosition(50, 150)
		var_173_1:addChild(var_173_2)
		var_173_2:setName("richText")

		local var_173_3 = ccui.Button:create("public/twist/select_sure_btn.png", nil, "public/twist/select_sure_btn.png", var_0_27)

		var_173_3:setPositionY(var_173_1:getPositionY() - var_173_1:getContentSize().height / 2 - 50)
		var_173_3:setPositionX(320)
		var_173_0:addChild(var_173_3)
		var_173_3:setName("sure_btn")
		var_173_0:addTouchEventListener(function(arg_174_0, arg_174_1)
			if arg_174_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.popSelectSurePanel:setVisible(false)
		end)
	end

	self.popSelectSurePanel:setVisible(true)
	self.popSelectSurePanel:getChildByName("sure_btn"):addTouchEventListener(function(arg_175_0, arg_175_1)
		if arg_175_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_173_1.callback then
			arg_173_1.callback()
		end

		self.popSelectSurePanel:setVisible(false)
	end)

	local var_173_6 = string.format(arg_173_1.type == 1 and "取消<span style=color: rgb(255,72,72);>%s</span>作为概率提升掉落</p>" or "选择<span style=color: rgb(255,72,72);>%s</span>作为概率提升掉落</p>", (item_data[arg_173_1.itemid].bag_item_type == 13 or nil) and model_data[tostring(item_data[arg_173_1.itemid].servant)].name)

	self.popSelectSurePanel:getChildByName("bg"):getChildByName("richText"):clearText()
	self.popSelectSurePanel:getChildByName("bg"):getChildByName("richText"):setText(var_173_6, nil, true)
end

function TwisteggLayer:updateLevelUpPanel(arg_176_1, arg_176_2)
	if not self.levelUpLayer then
		local var_176_0 = ccui.Layout:create()

		var_176_0:setContentSize(cc.size(640, 1600))
		var_176_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_176_0:setCascadeOpacityEnabled(false)
		var_176_0:setBackGroundColorOpacity(178)
		var_176_0:setAnchorPoint(0.5, 0.5)
		var_176_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_176_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_176_0:setTouchEnabled(true)
		var_176_0:setLocalZOrder(999)
		var_176_0:setVisible(true)

		self.levelUpLayer = var_176_0

		self.rootLayer:addChild(var_176_0)

		local var_176_1 = ccui.ImageView:create("public/twist/level_up_bg.png", var_0_27)

		var_176_1:setPosition(320, 800 - GameDisplay.fix_y)
		var_176_0:addChild(var_176_1)

		local var_176_2 = ccui.ImageView:create("public/twist/level_up_title.png", var_0_27)

		var_176_2:setAnchorPoint(0, 0)
		var_176_2:setPosition(0, 580)
		var_176_1:addChild(var_176_2)

		local var_176_3 = cc.Label:createWithTTF("", FONT_BUTTON, 25)

		var_176_3:setAnchorPoint(0, 1)
		var_176_3:setPosition(0, 260)
		var_176_1:addChild(var_176_3)

		local var_176_4 = ccui.ListView:create()

		var_176_4:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
		var_176_4:setBounceEnabled(true)
		var_176_4:setContentSize(440, 400)
		var_176_4:setPosition(260, 260)
		var_176_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_176_1:addChild(var_176_4)

		self.levelupList = var_176_4

		local var_176_5 = require("view.Sprite.RichTextPro"):create()

		var_176_5:setMaxWidth(420)
		var_176_5:setSize(25)
		var_176_5:setLineSpace(0)
		var_176_5:setText(string.format("累计抽取本扩招<span style=color: rgb(255,72,72);>%d</span>次后，可以选择升级扩招，获得更加多样的奖励</p>", 90), nil, true)
		var_176_5:setPosition(60, 560)
		var_176_1:addChild(var_176_5)
		var_176_0:addTouchEventListener(function(arg_177_0, arg_177_1)
			if arg_177_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_176_0:setVisible(false)
		end)

		local var_176_6 = ccui.Button:create("public/twist/level_up_btn.png", nil, "public/twist/level_up_btn.png")

		var_176_6:setPositionY(var_176_1:getPositionY() - var_176_1:getContentSize().height / 2 - 50)
		var_176_6:setPositionX(320)
		var_176_0:addChild(var_176_6)

		self.levelup_btn = var_176_6
	end

	self.levelup_btn:addTouchEventListener(function(arg_178_0, arg_178_1)
		if arg_178_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)
	self.levelUpLayer:setVisible(true)

	local function var_176_8(arg_179_0, arg_179_1, arg_179_2, arg_179_3)
		arg_179_0:removeAllChildren()

		local var_179_0 = {}

		for iter_179_0, iter_179_1 in pairs((drop_manager:getAllDrops(arg_179_1))) do
			table.insert(var_179_0, iter_179_1.dropid)
		end

		local var_179_1 = math.ceil(#var_179_0 / 4) * 110 + 60

		arg_179_0:setContentSize(550, var_179_1)
		arg_179_0:setBackGroundImage("public/twist/items_bg.png")
		arg_179_0:setBackGroundImageScale9Enabled(true)

		for iter_179_2, iter_179_3 in ipairs(var_179_0) do
			local var_179_2 = ccui.ImageView:create("public/twist/levelup_item_bg.png", var_0_27)

			var_179_2:setTouchEnabled(true)
			var_179_2:setPosition((iter_179_2 - 1) % 4 * 100 + 65, var_179_1 + 10 - math.ceil(iter_179_2 / 4) * 110)
			arg_179_0:addChild(var_179_2)

			local var_179_3 = ccui.ImageView:create("equipment/" .. item_data[iter_179_3].image_id .. ".png")

			var_179_3:setPosition(40, 40)
			var_179_3:setScale(0.4)
			var_179_2:addChild(var_179_3)
		end

		local var_179_4 = ccui.ImageView:create("public/twist/level_label_bg.png", var_0_27)

		var_179_4:setAnchorPoint(0, 1)
		var_179_4:setPosition(0, var_179_1)
		arg_179_0:addChild(var_179_4)

		local var_179_5 = cc.Label:createWithTTF("", FONT_BUTTON, 20)

		var_179_4:addChild(var_179_5)
		var_179_5:setPosition(40, 15)
		var_179_5:setString("升级" .. arg_179_2)

		local var_179_6 = cc.Label:createWithTTF("", FONT_BUTTON, 20)

		var_179_4:addChild(var_179_6)
		var_179_6:setPosition(140, 15)
		var_179_6:setString("升级" .. arg_179_2)

		local var_179_7 = ccui.ImageView:create("public/twist/process_bg.png", var_0_27)

		var_179_7:setAnchorPoint(1, 1)
		var_179_7:setPosition(440, var_179_1)
		arg_179_0:addChild(var_179_7)

		local var_179_8 = require("view.Sprite.RichTextPro"):create()

		var_179_8:setMaxWidth(420)
		var_179_8:setSize(18)
		var_179_8:setLineSpace(0)
		var_179_8:setText(string.format("<span style=color: rgb(103,203,255);>%d</span>/%d</p>", 100, 100), nil, true)
		var_179_8:setAnchorPoint(0, 0)
		var_179_8:setPosition(0, 0)
		var_179_7:addChild(var_179_8)

		local var_179_9 = ccui.Slider:create()

		var_179_9:loadBarTexture("public/twist/level_process_off.png", var_0_27)
		var_179_9:loadProgressBarTexture("public/twist/level_process_on.png", var_0_27)
		var_179_9:setAnchorPoint(0, 1)
		var_179_9:setPosition(cc.p(0, 0))
		var_179_9:setPercent(80)
		var_179_9:setName("progressBar")
		var_179_7:addChild(var_179_9)
	end

	self.levelupList:removeAllChildren()

	local var_176_9 = ccui.Layout:create()

	var_176_8(var_176_9, "PFDC79904", 1)
	self.levelupList:pushBackCustomItem(var_176_9)

	local var_176_10 = ccui.Layout:create()

	var_176_8(var_176_10, "OHT13013820", 2)
	self.levelupList:pushBackCustomItem(var_176_10)
	self.levelupList:setItemsMargin(30)
end

function TwisteggLayer:updateLevelUpUI(arg_180_1, arg_180_2)
	local var_180_0 = self.oneBtn:getChildByName("levelup_btn")

	if not var_180_0 then
		var_180_0 = ccui.Button:create("public/twist/levelup_btn_off.png", nil, "public/twist/levelup_btn_off.png", var_0_27)

		var_180_0:setPositionX(60)
		var_180_0:setPositionY(640)
		self.oneBtn:addChild(var_180_0)
		var_180_0:setName("levelup_btn")

		local var_180_1 = ccui.ImageView:create("public/twist/levelup_btn_icon.png", var_0_27)

		var_180_1:setPosition(50, 50)
		var_180_0:addChild(var_180_1)
		var_180_1:setName("icon")
	end

	var_180_0:setVisible(true)
	var_180_0:addTouchEventListener(function(arg_181_0, arg_181_1)
		if arg_181_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:updateLevelUpPanel(arg_180_1, arg_180_2)
	end)

	if not arg_180_1.curLevel then
		return
	end
end

function TwisteggLayer:updateLevelUpData(arg_182_1, arg_182_2)
	if not arg_182_2 or not arg_182_1 then
		return
	end

	self.configData = twist_manager:get_data_by_type(arg_182_1)
	self.curtwistData[self.curTwistIndex].curLevel = arg_182_2
end
