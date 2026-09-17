local ui_layer_infos = require("controller.layerconfig.ui_layer_infos")

local function var_0_1(arg_1_0)
	if not arg_1_0 then
		return nil
	end

	return ui_layer_infos[arg_1_0]
end

SwitchManageLayer = class("SwitchManageLayer", function()
	return cc.Layer:create()
end)
LayerManager = require("controller.layer_manager")
PlotManager = require("controller.plot_manager")
KeyCodeManager = require("controller.key_code_manager")
ErrorCodeManager = require("controller.error_code_manager")

local autopop_manager = require("controller.autopop_manager")

require("view.Layer.SwitchManage.SwitchManagePopLayer")
require("view.Layer.SwitchManage.SwitchManageDownloadLayer")
require("view.Layer.Guide.GuideLayer")
require("view.Layer.PlotLayer")

local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4
local var_0_7 = 5
local var_0_8
local var_0_9 = {
	ScoreArenaLayer = true,
	AdventureNewTowerLayer = true,
	AdventureNewItemLayer = true,
	ArenaLayer = true,
	ThreeVsThreeLayer = true,
	ExploreMapLayer = true,
	ActivityLevelLayer = true
}
local var_0_10 = {
	RogueExploreLayer = true,
	ExploreMapLayer = true
}

local function var_0_11(arg_3_0, arg_3_1)
	if config.packagechannel ~= "palmpi" then
		return
	end

	hx_print("层名:" .. arg_3_0, CONSOLE_COLOR_LIGHT_GOLD)

	arg_3_1 = arg_3_1 or ({
		FightLayer = {
			"FightLayer"
		}
	})[arg_3_0]

	if LAYERSYSTEMID[arg_3_0] then
		hx_print("跳转id:" .. LAYERSYSTEMID[arg_3_0], CONSOLE_COLOR_LIGHT_GOLD)
	end

	if arg_3_1 then
		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			hx_print("UI文件夹:" .. "../CocosRes_source/" .. iter_3_1, CONSOLE_COLOR_LIGHT_GOLD)
		end
	end
end

function SwitchManageLayer.create(arg_4_0)
	local var_4_0 = SwitchManageLayer.new()

	var_4_0:setName("SwitchManageLayer")

	var_0_8 = var_4_0

	var_4_0:init()

	return var_4_0
end

function SwitchManageLayer.getInstance()
	return var_0_8
end

function SwitchManageLayer:init()
	self._initialcomplete = false

	self:setPosition(cc.p(GameDisplay.fix_x, GameDisplay.fix_y))
	LayerManager:init(self)
	self:initBGLayer()
	self:initPopLayer()
	self:initGuideLayer()
	self:initPlotLayer()
	self:initUILayer()
	self:initSwitchEvent()
	self:initDownload()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			self:cleanUILayer()
			GuideListener.stopCommonGuide()
			KeyCodeManager:cleanAllStack()
			KeyCodeManager:setLock(false)
			LayerManager:exit()

			var_0_8 = nil
		end
	end)
end

function SwitchManageLayer:initBGLayer()
	self._bglayer = cc.Layer:create()

	local var_8_0 = cc.Sprite:create(MAINBG)

	var_8_0:setPosition(cc.p(320, 568))
	var_8_0:setName("bg")
	self._bglayer:addChild(var_8_0)
	self:addChild(self._bglayer, var_0_3)

	self._bglayer.res = MAINBG
end

local var_0_12 = {
	insert = function(self, ...)
		local var_9_0 = {
			...
		}

		if #var_9_0 == 1 then
			table.insert(self, var_9_0[1])

			self[#self].__queueindex = #self
		elseif #var_9_0 == 2 then
			table.insert(self, var_9_0[1], var_9_0[2])

			for iter_9_0 = var_9_0[1], #self do
				self[iter_9_0].__queueindex = iter_9_0
			end
		end
	end,
	remove = function(self, arg_10_1)
		for iter_10_0 = arg_10_1, #self do
			self[iter_10_0].__queueindex = iter_10_0
		end

		return (table.remove(self, arg_10_1))
	end
}

function SwitchManageLayer:initPopLayer()
	self._poplayer = cc.Layer:create()

	self:addChild(self._poplayer, var_0_5, "popLayer")

	self._poplayer.queue = setmetatable({}, {
		__index = var_0_12
	})

	self:addTipsLayer()
end

function SwitchManageLayer:addTipsLayer()
	self._tipslayer = cc.Layer:create()

	self._poplayer:addChild(self._tipslayer)
end

function SwitchManageLayer:initGuideLayer()
	self._guidelayer = GuideLayer:create()

	self:addChild(self._guidelayer, var_0_7)
	GuideListener.startCommonGuide()
end

function SwitchManageLayer:initPlotLayer()
	self._plotlayer = PlotLayer:create()

	self:addChild(self._plotlayer, var_0_6)
end

function SwitchManageLayer:initUILayer()
	self._uilayer = cc.Layer:create()

	self:addChild(self._uilayer, var_0_4)
end

function SwitchManageLayer.cleanUILayer(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(ui_layer_infos) do
		iter_16_1.layerObject = nil
	end
end

function SwitchManageLayer:initSwitchEvent()
	self._isSwitching = false

	local var_17_0 = self:getEventDispatcher()

	var_17_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("switchShowLayer", function(arg_18_0)
		if not arg_18_0 or not arg_18_0.layerName then
			return
		end

		if arg_18_0.layerName == self._uilayer.activitylayer then
			return
		end

		if not LayerManager:layerUnlocked(arg_18_0.layerName, "switchShowLayer") then
			return
		end

		KeyCodeManager:registerSwitchShowLayerEvent(arg_18_0.layerName)
		self:switchLayer(arg_18_0.layerName, arg_18_0.initparam)
	end), self)
	var_17_0:addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("showTopBottomLayer", function(arg_19_0)
		if not arg_19_0 or not arg_19_0.showconfig then
			return
		end

		if arg_19_0.showconfig.ListButtonLayer ~= nil then
			self:switchListButtonLayer(arg_19_0.showconfig.ListButtonLayer)
		end

		if arg_19_0.showconfig.TopcostLayer ~= nil then
			self:switchTopcostLayer(arg_19_0.showconfig.TopcostLayer)
		end
	end), self)
end

function SwitchManageLayer:switchBg(arg_20_1)
	if arg_20_1 then
		self._bglayer:getChildByName("bg"):setVisible(true)

		if self._bglayer.res == arg_20_1 then
			return
		end

		self._bglayer:getChildByName("bg"):setTexture(arg_20_1)

		self._bglayer.res = arg_20_1
	else
		self._bglayer:getChildByName("bg"):setVisible(false)

		self._bglayer.res = arg_20_1
	end
end

function SwitchManageLayer.getLayerObjWithName(arg_21_0, arg_21_1)
	if not ui_layer_infos[arg_21_1] then
		return nil
	end

	if ui_layer_infos[arg_21_1].layerObject and ui_layer_infos[arg_21_1].uiLayerName then
		return ui_layer_infos[arg_21_1].layerObject:getChildByName(ui_layer_infos[arg_21_1].uiLayerName)
	else
		return nil
	end
end

function SwitchManageLayer:createLayer(arg_22_1, arg_22_2)
	local var_22_0 = var_0_1(arg_22_1)

	if var_22_0 == nil then
		return
	end

	if var_22_0.layerObject then
		return var_22_0.layerObject
	end

	if not var_22_0.loading then
		TextureManager:loadLayerTextures(var_22_0.textures)
	end

	local var_22_1 = var_22_0.createLayer(arg_22_2)

	if not var_22_1 then
		return nil
	end

	var_22_0.layerObject = var_22_1

	var_22_1:setName(arg_22_1)
	self._uilayer:addChild(var_22_1, var_22_0.zOrder)

	return var_22_1
end

function SwitchManageLayer.deleteLayer(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = var_0_1(arg_23_1)

	if var_23_0 == nil then
		return
	end

	if arg_23_1 == "FightLayer" or var_0_10[arg_23_1] and arg_23_2 == "FightLayer" then
		var_23_0.layerObject:setVisible(false)
		var_23_0.layerObject:onBackground()
	else
		if arg_23_1 ~= "LoadingLayer" then
			var_23_0.layerObject:removeFromParent()

			local LocalEvent = require("common.LocalEvent")

			LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.LAYER_EXIT_SCENE, {
				name = arg_23_1
			})

			if var_23_0.loading then
				require("controller.loading_texture_manager"):removeCachedTextured(arg_23_1)
			else
				TextureManager:removeLayerTextures(var_23_0.textures)
			end
		end

		var_23_0.layerObject = nil
	end

	require("controller.armature_manager"):updateArmatureCached(arg_23_1)
end

function SwitchManageLayer:addLayer(arg_24_1, arg_24_2)
	local var_24_0 = var_0_1(arg_24_1)

	if var_24_0 == nil then
		return
	end

	if not var_24_0.layerObject and not self:createLayer(arg_24_1, arg_24_2) then
		return
	end

	if arg_24_1 == "FightLayer" or var_0_10[arg_24_1] then
		var_24_0.layerObject:setVisible(true)
		var_24_0.layerObject:onForeground(arg_24_2)
	end

	var_0_11(arg_24_1, var_24_0.textures)
	self:switchAniUIElemen(arg_24_1, true)
end

function SwitchManageLayer:addLayerForElements(arg_25_1)
	local var_25_0 = var_0_1(arg_25_1)

	if var_25_0 == nil then
		return
	end

	if not var_25_0.layerObject and not self:createLayer(arg_25_1) then
		return
	end
end

function SwitchManageLayer:addFirstLayer()
	self._guidelayer:swallowEvent(true)
	self:addLayerForElements("TopcostLayer")
	self:addLayerForElements("ListButton")
	self:createLayer("FightLayer")

	local var_26_0

	if config._DEVELOP_MODE == "FIGHTDEV" then
		var_26_0 = "FightLayer"
	elseif require("model.playermodel").gameInitGuides[2] and require("controller.level_manager"):isPlayerPassLevel(UNLOCK_LIST_SWITCH) then
		var_26_0 = "MainLayer"

		self:createLayer("MainLayer")
		self:getLayerObject("FightLayer"):setVisible(false)
		self:getLayerObject("FightLayer"):onBackground()
	else
		var_26_0 = "FightLayer"
	end

	local var_26_1 = ui_layer_infos[var_26_0]

	self:switchLayerBGM(ui_layer_infos[var_26_0].bgm)

	self._uilayer.activitylayer = var_26_0

	self:addSmallfight(var_26_1.showSmallFightLayer)
	self:getLayerObject("TopcostLayer"):onFirstCreate(var_26_0)
	self:getLayerObject("ListButton"):onFirstCreate(var_26_0)
	self:getLayerObject("SmallFightLayer"):onFirstCreate(var_26_0)
	self:getLayerObject("FightLayer"):onFirstCreate(var_26_0)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self:switchBg(var_26_1.bg)
		AlertManager:check_current_alert(var_26_0)
		AlertManager:check_listbutton_alert(var_26_0)
		AlertManager:updataChangeBtnAlert()
		RoleDefault:getInstance():setIntegerForKey("guide_level", GUIDE_LEVEL_NEW)
		self._guidelayer:swallowEvent(false)
		GuideListener.lockGuideTrigger(false)

		if GuideListener.updateGuides(ui_layer_infos[var_26_0].layerObject) then
			autopop_manager:pauseOtherPop()
		else
			autopop_manager:resumeOtherPop()
		end

		self._plotlayer:updatePlotShow(var_26_0)

		self._initialcomplete = true
	end)))
end

function SwitchManageLayer:AskForGuideLevel(arg_28_1)
	local var_28_0 = RoleDefault:getInstance():getIntegerForKey("guide_level", 0)

	if var_28_0 == 0 and (function(arg_29_0)
		local var_29_0 = require("data.guide_data")[arg_29_0].triggerlayer or "scene"

		if not GuideListener.triggeredGuides[var_29_0] then
			return false
		end

		if not GuideListener.triggeredGuides[var_29_0][arg_29_0] then
			return false
		end

		return true
	end)(202) then
		RoleDefault:getInstance():setIntegerForKey("guide_level", GUIDE_LEVEL_OLD)

		if arg_28_1 then
			arg_28_1()
		end
	elseif config.open_guide and var_28_0 == 0 then
		local var_28_1 = ccui.ImageView:create("mainScenebg/other/guide_bg.png")

		var_28_1:setPosition(cc.p(320, 500))
		self:addChild(var_28_1, 9999)

		local var_28_2 = ccui.Button:create("mainScenebg/other/btn1.png")

		var_28_2:setPosition(cc.p(200, 470))
		var_28_1:addChild(var_28_2)

		local var_28_3 = cc.Label:createWithTTF(L_GUIDE_LEVEL_ASK_OLD, FONT_NAME, 18)

		var_28_3:setColor(cc.c3b(1, 1, 1))
		var_28_3:setPosition(cc.p(var_28_2:getContentSize().width / 2, var_28_2:getContentSize().height / 2))
		var_28_2:addChild(var_28_3)
		var_28_2:addTouchEventListener(function(arg_30_0, arg_30_1)
			if arg_30_1 ~= ccui.TouchEventType.ended then
				return
			end

			RoleDefault:getInstance():setIntegerForKey("guide_level", GUIDE_LEVEL_OLD)

			GUIDE_FIGHT_UI_CLASS = 9100
			GUIDE_FIGHT_USEXP_CLASS = 9101

			self._guidelayer:swallowEvent(false)
			GuideListener.lockGuideTrigger(false)
			require("model.playermodel"):reloadPlayerGuide(function()
				if arg_28_1 then
					arg_28_1()
				end

				var_28_1:runAction(cc.RemoveSelf:create())
				AnalyticManager.guide_type_selection({
					ctype = "GUIDE_LEVEL_OLD"
				})
			end)
		end)

		local var_28_4 = ccui.Button:create("mainScenebg/other/btn2.png")

		var_28_4:setPosition(cc.p(200, 570))
		var_28_1:addChild(var_28_4)

		local var_28_5 = cc.Label:createWithTTF(L_GUIDE_LEVEL_ASK_NEW, FONT_NAME, 18)

		var_28_5:setPosition(cc.p(var_28_2:getContentSize().width / 2, var_28_2:getContentSize().height / 2))
		var_28_4:addChild(var_28_5)
		var_28_4:addTouchEventListener(function(arg_32_0, arg_32_1)
			if arg_32_1 ~= ccui.TouchEventType.ended then
				return
			end

			RoleDefault:getInstance():setIntegerForKey("guide_level", GUIDE_LEVEL_NEW)

			GUIDE_FIGHT_UI_CLASS = 100
			GUIDE_FIGHT_USEXP_CLASS = 101

			self._guidelayer:swallowEvent(false)
			GuideListener.lockGuideTrigger(false)
			require("model.playermodel"):reloadPlayerGuide(function()
				if arg_28_1 then
					arg_28_1()
				end

				var_28_1:runAction(cc.RemoveSelf:create())
				AnalyticManager.guide_type_selection({
					ctype = "GUIDE_LEVEL_NEW"
				})
			end)
		end)
	elseif arg_28_1 then
		arg_28_1()
	end
end

function SwitchManageLayer:addSmallfight(arg_34_1)
	local var_34_0 = var_0_1("SmallFightLayer")

	if var_34_0 == nil then
		return
	end

	if not var_34_0.layerObject and not self:createLayer("SmallFightLayer") then
		return
	end

	if arg_34_1 == nil then
		arg_34_1 = true
	end

	var_34_0.layerObject:setVisible(arg_34_1)
end

function SwitchManageLayer:switchLayer(arg_35_1, arg_35_2)
	if not arg_35_1 then
		return
	end

	if not ui_layer_infos[arg_35_1] then
		return
	end

	if arg_35_1 == self._uilayer.activitylayer and (not arg_35_2 or arg_35_2 and not arg_35_2.ignoreSameLayer) then
		return
	end

	if self._isSwitching then
		return
	end

	local var_35_0 = var_0_1(arg_35_1)

	if var_35_0.loading then
		self:doSwitchLayer(arg_35_1, arg_35_2)
	else
		self:checkResource(arg_35_1, var_35_0.checktextures or var_35_0.textures, "UILAYER", arg_35_2)
	end
end

function SwitchManageLayer:doSwitchLayer(arg_36_1, arg_36_2)
	if not arg_36_1 then
		return
	end

	if not ui_layer_infos[arg_36_1] then
		return
	end

	if arg_36_1 == self._uilayer.activitylayer then
		return
	end

	if self._isSwitching then
		return
	end

	local var_36_0 = self._uilayer.activitylayer and 0.3 or 0
	local var_36_1 = self._uilayer.activitylayer

	KeyCodeManager:setLock(true)
	self._guidelayer:swallowEvent(true)

	self._isSwitching = true

	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		if not self._uilayer.activitylayer then
			return
		end

		GuideListener.lockGuideTrigger(true)
		GuideListener.cleanCurGuides()
		autopop_manager:pauseOtherPop()
		self._plotlayer:clean_all()

		if not self._plotlayer:isVisible() then
			self._plotlayer:setVisible(true)
		end

		self:switchAniUIElemen(self._uilayer.activitylayer, false)
	end), cc.DelayTime:create(var_36_0), cc.CallFunc:create(function()
		if self._uilayer.activitylayer then
			self:deleteLayer(self._uilayer.activitylayer, arg_36_1)
			self:cleanPopLayer()

			if not self._uilayer:isVisible() then
				self._uilayer:setVisible(true)
			end
		end
	end), cc.CallFunc:create(function()
		self:switchBg(ui_layer_infos[arg_36_1].bg)

		local var_39_0

		if ui_layer_infos[arg_36_1].loading and self._uilayer.activitylayer ~= "LoadingLayer" then
			var_39_0 = {
				layerName = arg_36_1,
				initparam = arg_36_2
			}
			arg_36_1 = "LoadingLayer"
		end

		if arg_36_1 == "FightLayer" and arg_36_2 and arg_36_2.is_hide_listbutton then
			self:switchListButtonLayer(false)
		else
			self:switchListButtonLayer(ui_layer_infos[arg_36_1].enterVisibleListButton, {
				action = ui_layer_infos[arg_36_1].enterVisibleListButtonAction
			})
		end

		if arg_36_1 == "FightLayer" and arg_36_2 and arg_36_2.is_hide_topcost then
			self:switchTopcostLayer(false, arg_36_1)
		else
			self:switchTopcostLayer(ui_layer_infos[arg_36_1].showTopcostLayer, arg_36_1, {
				action = ui_layer_infos[arg_36_1].showTopcostLayerAction
			})
		end

		if var_0_10[arg_36_1] then
			-- block empty
		elseif arg_36_1 == "FightLayer" and var_0_9[var_36_1] then
			-- block empty
		else
			self:switchLayerBGM(ui_layer_infos[arg_36_1].bgm)
		end

		self:addLayer(arg_36_1, var_39_0 or arg_36_2)
		self:addSmallfight(ui_layer_infos[arg_36_1].showSmallFightLayer)

		self._uilayer.activitylayer = arg_36_1

		ui_layer_infos.ListButton.layerObject:setButtonImg(arg_36_1, var_36_1)
		AlertManager:check_current_alert(arg_36_1)
		AlertManager:check_listbutton_alert(arg_36_1)
		AlertManager:updataChangeBtnAlert()
		AlertManager:updataCommnityBtnAlert()
		require("controller.goto_system_manager")
		gotoSystem_updateStack(arg_36_1)

		self._isSwitching = false
	end), cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		TextureManager:collectTextures()
	end), cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		self._plotlayer:updatePlotShow(arg_36_1)
		self._guidelayer:swallowEvent(false)
		KeyCodeManager:setLock(false)

		if arg_36_1 ~= "LoadingLayer" and not LayerManager:getCurrentLayerObj().updateGuidesOnLayer then
			LayerManager:updateGuidesOnSwitchLayer()
		end
	end)))
end

function SwitchManageLayer.switchAniUIElemen(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = var_0_1(arg_42_1)

	if var_42_0 == nil then
		return
	end

	if not var_42_0.layerObject then
		return
	end

	if not var_42_0.aniUIElement then
		return
	end

	local var_42_1 = var_42_0.layerObject
	local var_42_2 = var_42_0.layerObject

	if var_42_0.uiLayerName then
		var_42_2 = var_42_1:getChildByName(var_42_0.uiLayerName)

		if not var_42_2 then
			return
		end

		if var_42_0.uiPanelName then
			var_42_2 = var_42_1:getChildByName(var_42_0.uiLayerName):getChildByName(var_42_0.uiPanelName)

			if not var_42_2 then
				return
			end
		end
	end

	for iter_42_0, iter_42_1 in pairs(var_42_0.aniUIElement) do
		local var_42_3 = var_42_2

		if iter_42_0 ~= "aniSelf" then
			var_42_3 = var_42_2:getChildByName(iter_42_0)
		end

		if var_42_3 then
			var_42_3:stopAllActions()

			if arg_42_2 then
				var_42_3:setPosition(iter_42_1.initPos.x, iter_42_1.initPos.y)
				var_42_3:runAction(cc.MoveTo:create(0.2, cc.p(iter_42_1.finalPos.x, iter_42_1.finalPos.y)))
			else
				var_42_3:runAction(cc.MoveTo:create(0.2, cc.p(iter_42_1.initPos.x, iter_42_1.initPos.y)))
			end
		end
	end
end

function SwitchManageLayer.switchListButtonLayer(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = var_0_1("ListButton")

	if not var_43_0 then
		return
	end

	if not var_43_0.layerObject then
		return
	end

	if arg_43_1 == nil then
		arg_43_1 = true
	end

	if arg_43_1 then
		var_43_0.layerObject:showLayer()
	else
		var_43_0.layerObject:hideLayer(arg_43_2)
	end
end

function SwitchManageLayer:switchTopcostLayer(arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = var_0_1("TopcostLayer")

	if not var_44_0 then
		return
	end

	if not var_44_0.layerObject then
		return
	end

	arg_44_2 = arg_44_2 or self._uilayer.activitylayer

	if arg_44_1 then
		var_44_0.layerObject:showTopcostLayer()

		if arg_44_2 == "FightLayer" then
			var_44_0.layerObject:shopTopDropinfo()
			var_44_0.layerObject:choseTodeal(2)
		elseif arg_44_2 == "SchoolAreaLayer" then
			var_44_0.layerObject:hideTopDropinfo()
			var_44_0.layerObject:choseTodeal(1)
		else
			var_44_0.layerObject:hideTopDropinfo()
			var_44_0.layerObject:choseTodeal(3)
		end
	else
		var_44_0.layerObject:hideTopcostLayer(arg_44_3)
	end
end

function SwitchManageLayer.switchTopcostBg(arg_45_0, arg_45_1)
	local var_45_0 = var_0_1("TopcostLayer")

	if not var_45_0 then
		return
	end

	if not var_45_0.layerObject then
		return
	end

	var_45_0.layerObject:showTopBg(arg_45_1 and 2 or 1)
end

function SwitchManageLayer.switchLayerBGM(arg_46_0, arg_46_1)
	if not arg_46_1 then
		return
	end

	local audio_manager = require("controller.audio_manager")

	if type(arg_46_1) == "string" then
		audio_manager:switchLayerBGM(arg_46_1, true)
	elseif type(arg_46_1) == "table" then
		audio_manager:switchLayerBGM(arg_46_1[1], true, arg_46_1[2])
	end
end

function SwitchManageLayer:getActiveLayerName()
	return self._uilayer.activitylayer
end

function SwitchManageLayer:getUILayerBgm()
	return ui_layer_infos[self._uilayer.activitylayer].bgm or MAIN_BGM
end

function SwitchManageLayer:getActiveLayerBg()
	return ui_layer_infos[self._uilayer.activitylayer].bg
end

function SwitchManageLayer.getLayerObject(arg_50_0, arg_50_1)
	return ui_layer_infos[arg_50_1].layerObject
end
