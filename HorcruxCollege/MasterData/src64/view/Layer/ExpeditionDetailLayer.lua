ExpeditionDetailLayer = class("ExpeditionDetailLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

require("view.Sprite.BottomBtnList")
require("view.Sprite.TitleSprite")
require("view.Layer.BattleArrayLayerNew")
require("data.constants")

local level_manager = require("controller.level_manager")
local array_manager = require("controller.array_manager")
local audio_manager = require("controller.audio_manager")
local monster_manager = require("controller.monster_manager")
local aiattack_manager = require("controller.aiattack_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local battlefield_status_data = require("data.battlefield_status_data")
local infinite_fight_manager = require("controller.infinite_fight_manager")
local expedition_manager = require("controller.expedition_manager")
local role_false_level_manager = require("controller.role_false_level_manager")
local core_manager = require("controller.core_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local horcrux_data = require("data.horcrux_data")
local servant_data = require("data.servant_data")
local chapter_data = require("data.chapter_data")
local drop_data = require("data.drop_data")
local model_data = require("data.model_data")
local levelmode_data = require("data.levelmode_data")
local var_0_26 = {
	myself = cc.c3b(204, 222, 255),
	enemy = cc.c3b(189, 145, 254)
}
local var_0_27 = {
	"adventurenewlayer/tanchuang.png",
	"adventurenewlayer/tanchuang_awl.png",
	"adventurenewlayer/tanchuang_summer.png"
}
local var_0_28 = "adventurenewlayer/array_jiaose.png"
local var_0_29 = {
	cc.p(24, 11),
	(cc.p(24, -89))
}
local var_0_30 = {
	cc.size(270, 80),
	cc.size(270, 120),
	(cc.size(270, 234))
}
local var_0_31 = {
	cc.p(70, -55),
	cc.p(34, -106),
	(cc.p(68, -205))
}
local var_0_32 = {
	photofile_nightmare_xmasfile_data = "file_nightmare_xmasfile",
	photofile_ai3_data = "file_enemy4",
	photofile_ai1_data = "file_enemy2",
	photofile_data = "file_player",
	photofile_foundationai_data = "file_enemy9",
	photofile_foundation_data = "file_enemy8",
	photofile_ai2_data = "file_enemy3",
	photofile_activity_data = "file_enemy12",
	photofile_military_data = "file_enemy6",
	photofile_talk_level_data = "photofile_talk_level_data",
	photofile_militaryai_data = "file_enemy7",
	photofile_killer_data = "file_enemy10",
	photofile_ai4_data = "file_enemy5",
	photofile_ai5_data = "file_enemy_ai5",
	photofile_xmasfile_data = "file_enemy1",
	photofile_activityai_data = "file_enemy11"
}

local function var_0_33(arg_2_0)
	if arg_2_0 < 0 then
		return
	end

	return arg_2_0 > 86400 and string.format(L_TIME_FORMAT[1], math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600)) or arg_2_0 > 3600 and string.format(L_TIME_FORMAT[2], math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60)) or string.format(L_TIME_FORMAT[5], math.floor(arg_2_0 / 60), math.floor(arg_2_0 % 60))
end

function ExpeditionDetailLayer.create(arg_4_0, arg_4_1)
	local var_4_0 = ExpeditionDetailLayer.new()

	var_4_0:initBg(arg_4_1)

	return var_4_0
end

function ExpeditionDetailLayer:init(arg_5_1)
	self.msg = arg_5_1
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "AdventureNewDetailLayer.json" or "AdventureNewDetailLayer.ExportJson")

	self.rootLayer:setBackGroundColorOpacity(0)
	self:addChild(self.rootLayer)

	self.topitem = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_topitem")
	self.noitem = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_topitem_wei")
	self.buttonitem = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_13")
	self.ListView_buttom = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_di")
	self.ListView_top = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_top")
	self.kaohebtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_kaohe")
	self.buybtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_goumai")
	self.imagecishu = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_cishu")
	self.imagenoopen = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_noopen")
	self.zhanli = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_zhanli")

	self.zhanli:setPosition(cc.p(260, 420))

	self.zhupanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_1")
	self.bossimg = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_head")
	self.ticketPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_ticket")
	self.listview2 = ccui.Helper:seekWidgetByName(self.rootLayer, "ListView_29")
	self.items2 = ccui.Helper:seekWidgetByName(self.rootLayer, "items_citiao")
	self.citiaopanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_cizhui")
	self.listview3 = ccui.Helper:seekWidgetByName(self.citiaopanel, "ListView_37")
	self.listview4 = ccui.Helper:seekWidgetByName(self.citiaopanel, "ListView_37_0")
	self.arraypanel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_array")
	self.array_edit = ccui.Helper:seekWidgetByName(self.arraypanel, "array_edit")
	self.role1 = ccui.Helper:seekWidgetByName(self.arraypanel, "pos_1")
	self.role2 = ccui.Helper:seekWidgetByName(self.arraypanel, "pos_2")
	self.role3 = ccui.Helper:seekWidgetByName(self.arraypanel, "pos_3")
	self.role4 = ccui.Helper:seekWidgetByName(self.arraypanel, "pos_4")
	self.role5 = ccui.Helper:seekWidgetByName(self.arraypanel, "pos_5")
	self.power = ccui.Helper:seekWidgetByName(self.arraypanel, "power")
	self.scores = ccui.Helper:seekWidgetByName(self.arraypanel, "power_0")
	self.titlescore = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_52")
	self.myrule = ccui.Helper:seekWidgetByName(self.citiaopanel, "img_my")
	self.enemyrule = ccui.Helper:seekWidgetByName(self.citiaopanel, "img_diren")
	self.roles = {
		self.role1,
		self.role2,
		self.role3,
		self.role4,
		self.role5
	}
	self.noopenmore = ccui.ImageView:create("adventurenewlayer/tishi_imag.png", var_0_0)

	self.noopenmore:setPosition(cc.p(self.imagenoopen:getContentSize().width / 2, self.imagenoopen:getContentSize().height / 2 - 36))
	self.imagenoopen:addChild(self.noopenmore)

	self.mode = arg_5_1.mode
	arg_5_1.data = levelmode_data[self.mode]
	self.numchapter = arg_5_1.data.totalchapter
	self.advenName = arg_5_1.name
	self.ticke_tnum = arg_5_1.ticke_tnum
	self.ticket_item = arg_5_1.ticket_item
	self.isvisual = arg_5_1.isvisual
	self.score = arg_5_1.score
	self.isrepeat = arg_5_1.data.is_repeat_no_reward
	self.issummeradverture = arg_5_1.issummeradverture
	self.iscanrepeatchange = arg_5_1.data.is_once_fight
	self.isinfinite = arg_5_1.isinfinite
	self.surecallback = arg_5_1.surecallback

	self.zhupanel:loadTexture(var_0_27[1], var_0_0)
	self.zhanli:setVisible(true)
	self.titlescore:setVisible(false)

	self.curlevel = playermodel.levelmode[self.mode].status - 1
	self.btnindex = arg_5_1.chapter

	self:createTicketImage()

	local var_5_0 = require("data.leveldata.level_data_" .. self.mode)

	self.ticket = var_5_0[self.mode .. "-" .. arg_5_1.chapter .. "-1"].ticket
	self.ticketnum = var_5_0[self.mode .. "-" .. arg_5_1.chapter .. "-1"].ticketnum
	self.is_once_fight = var_5_0[self.mode .. "-" .. arg_5_1.chapter .. "-1"].is_once_fight

	self.kaohebtn:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.is_once_fight and self.is_once_fight == 1 and self.curlevel < playermodel.levelmode[self.mode].status - 1 then
			global_ShowBlockWords(L_ADVENTURE_IS_ONCE_FIGHT)

			return
		end

		if self.surecallback then
			self.surecallback()
		end

		LayerManager:removePopLayer()
	end)
	self.rootLayer:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(self.zhupanel, function()
			if self.week_callback then
				self.week_callback()
			end

			LayerManager:removePopLayer()
		end)
	end)
	self:initPanelList_H1(self.numchapter)
	self:initpanel(self.msg.level)
	self:fullScreen(self.rootLayer)
	self:initArrayPanel()
	self:createBossInfoBtn()
	self:initEnemyList()
	global_window_open_action(self.zhupanel)

	local var_5_1 = expedition_manager.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Monopoly and expedition_manager:getCurLevelStatus() ~= EXPEDITION.LEVELSTATUS.Free or expedition_manager.expeditionInfo.seasontype == EXPEDITION.SEASONTYPE.Expedition

	self.kaohebtn:setVisible(self.msg and self.msg.roomStatus == EXPEDITION.ROOMSTATUS.CanOperate and var_5_1)
	self.imagenoopen:setVisible(self.msg and (self.msg.roomStatus == EXPEDITION.ROOMSTATUS.HaveMiss or self.msg.roomStatus == EXPEDITION.ROOMSTATUS.NotOperate) and var_5_1)

	local var_5_2 = ccui.Text:create("1000/100", FONT_NAME, 20)

	var_5_2:setPosition(cc.p(340, 450))
	var_5_2:setColor(cc.c3b(178, 148, 255))
	var_5_2:setAnchorPoint(cc.p(0, 0.5))

	self.bloodNumNode = var_5_2

	self.zhupanel:addChild(var_5_2)

	local var_5_3 = ccui.ImageView:create("adventurenewlayer/blood_bg.png", var_0_0)

	var_5_3:setPosition(cc.p(440, 430))

	self.curBloodNode = ccui.ImageView:create("adventurenewlayer/blood.png", var_0_0)

	self.curBloodNode:setAnchorPoint(cc.p(0, 0.5))
	self.curBloodNode:setPosition(cc.p(345, 430))
	self.zhupanel:addChild(var_5_3)
	self.zhupanel:addChild(self.curBloodNode)
	var_5_3:setVisible(false)
	self.curBloodNode:setVisible(false)

	local var_5_4, var_5_5 = expedition_manager:getCurLevelBossBloodInfo(self.msg.level)

	self:setBossCurBloodPrecent(var_5_4, var_5_5)
end

function ExpeditionDetailLayer:setBossCurBloodPrecent(arg_9_1, arg_9_2)
	self.curBloodNode:setScaleX((math.max(math.min(arg_9_1 / arg_9_2, 1), 0)))
	self.bloodNumNode:setVisible(false)
end

function ExpeditionDetailLayer:createArrayRole(arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = servant_data[arg_10_1].modelid

	if not servant_data[arg_10_1].modelid then
		return
	end

	local var_10_1 = model_data[var_10_0].portrait_image
	local var_10_2 = ccui.ImageView:create("GUI/image.png", var_0_0)

	var_10_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_10_2:setScale(60 / var_10_2:getContentSize().height)
	var_10_2:setName("girlHeadImg")
	var_10_2:loadTexture(ROLE_PORTRAIT_PATH .. var_10_1 .. ".png")

	local var_10_3 = {
		mode = self.mode
	}

	var_10_3.initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
	var_10_3.configtype = CONFIG_TYPE_MODE

	function var_10_3.configcallback(arg_11_0)
		GuideListener.showAllGuidesWithFullScreen(false)
		array_manager:resetHangupArray(arg_11_0)
		RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_11_0)
		self:updateArrayPanel()
	end

	function var_10_3.exitcallback()
		self:updateArrayPanel()
	end

	var_10_2:setTouchEnabled(true)
	var_10_2:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationModeLayer", var_10_3)
	end)

	return var_10_2
end

function ExpeditionDetailLayer:updateArrayPanel()
	self:updateArrayData()

	if not next(self.team) then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(self.team) do
		((config._DEBUG or nil) and (cc.Scale9Sprite:create(var_0_28) or cc.Scale9Sprite:createWithSpriteFrameName(var_0_28))):setAnchorPoint(cc.p(0.5, 0.5))

		local var_14_0 = ccui.Helper:seekWidgetByName(self.roles[iter_14_0], "level")
		local var_14_1 = ccui.Helper:seekWidgetByName(self.roles[iter_14_0], "class")
		local var_14_2 = ccui.Helper:seekWidgetByName(self.roles[iter_14_0], "level_bg")
		local var_14_3 = ccui.Helper:seekWidgetByName(self.roles[iter_14_0], "add_btn")

		if self.roles[iter_14_0]:getChildByName("girlHeadImg") then
			self.roles[iter_14_0]:getChildByName("girlHeadImg"):removeFromParent()
		end

		if iter_14_1.fight_girl then
			var_14_2:setVisible(true)
			var_14_1:setVisible(true)
			var_14_3:setVisible(false)
			var_14_1:loadTexture("Array/icon_" .. global_get_model_attr(servant_data[iter_14_1.fight_girl].modelid) .. ".png", var_0_0)
			var_14_1:setScale(0.65)
			var_14_0:setString("LV" .. core_manager:getCoreLv(iter_14_1.fight_girl))

			local var_14_4 = self:createArrayRole(iter_14_1.fight_girl)

			var_14_4:setPosition(cc.p(self.roles[iter_14_0]:getContentSize().width / 2, self.roles[iter_14_0]:getContentSize().height / 2))
			self.roles[iter_14_0]:addChild(var_14_4)

			if role_false_level_manager:isRoleFalseLevelMember(iter_14_1.fight_girl, FIGHTTYPE_TOWER) then
				local var_14_5, var_14_6, var_14_7, var_14_8 = role_false_level_manager:getRoleFalseAttrInfoByAllRole(iter_14_1.fight_girl, FIGHTTYPE_TOWER)
				local var_14_9 = core_manager:getServantCoreRank(iter_14_1.fight_girl)

				var_14_0:setOpacity(255)
				var_14_0:stopAllActions()
				var_14_0:setColor(cc.c3b(255, 255, 255))

				if var_14_5 == var_14_9 and playermodel.cores[iter_14_1.fight_girl].extra == var_14_6 then
					-- block empty
				else
					local var_14_10 = var_14_6 + var_14_8

					if var_14_6 + var_14_8 > core_manager:getCoreMaxTotalLv() then
						var_14_10 = core_manager:getCoreMaxTotalLv()
					end

					var_14_0:setColor(cc.c3b(206, 255, 167))

					local var_14_11 = true

					var_14_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(2), cc.CallFunc:create(function(...)
						if var_14_11 then
							var_14_0:setString("Lv提升中")
						else
							var_14_0:setString("LV" .. var_14_10)
						end

						var_14_11 = not var_14_11
					end), cc.FadeIn:create(2))))
				end
			end
		else
			var_14_2:setVisible(false)
			var_14_1:setVisible(false)
			var_14_3:setVisible(true)
		end

		local function var_14_12(arg_16_0)
			GuideListener.showAllGuidesWithFullScreen(false)
			array_manager:resetHangupArray(arg_16_0)
			RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_16_0)
			self:updateArrayPanel()
		end

		local function var_14_13()
			self:updateArrayPanel()
		end

		local var_14_14 = {
			mode = self.mode
		}

		var_14_14.initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
		var_14_14.configtype = CONFIG_TYPE_ADVENTURE
		var_14_14.configcallback = var_14_12
		var_14_14.exitcallback = var_14_13

		var_14_3:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationModeLayer", var_14_14)
		end)
	end

	self.power:setString(string.format(L_AVAON_VISUAL.array_power, global_trans_number((fight_capacity_manager:getArrayFightCapacity(array_manager:getBattleArrayData((RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray))), nil, nil, nil, self.mode)))))
	self:updateArrayScore()
end

function ExpeditionDetailLayer:updateArrayScore()
	if not self.isvisual and not self.isinfinite then
		self.scores:setVisible(false)

		return
	else
		self.scores:setVisible(true)

		if self.score then
			self.scores:setString(string.format(L_AVAON_VISUAL.array_score, global_trans_number(self.score)))
		else
			self.scores:setString("")
		end
	end
end

function ExpeditionDetailLayer:initArrayPanel()
	self:updateArrayPanel()

	local var_20_0 = {
		mode = self.mode
	}

	var_20_0.initindex = RoleDefault:getInstance():getIntegerForKey("adventurearray", 1)
	var_20_0.configtype = CONFIG_TYPE_ADVENTURE

	function var_20_0.configcallback(arg_21_0)
		GuideListener.showAllGuidesWithFullScreen(false)
		array_manager:resetHangupArray(arg_21_0)
		RoleDefault:getInstance():setIntegerForKey("adventurearray", arg_21_0)
		self:updateArrayPanel()
	end

	function var_20_0.virtualcallbak()
		self:updateArrayPanel()
	end

	self.array_edit:addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		require("controller.formation.formation_manager"):getInstance():pushFormationLayer("FormationModeLayer", var_20_0)
	end)
end

function ExpeditionDetailLayer:updateArrayData()
	self.team = {}

	if playermodel.arrays[RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray)] and next(playermodel.arrays[RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray)]) then
		while playermodel.arrays[RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray)]["pos_" .. 1] do
			table.insert(self.team, playermodel.arrays[RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray)]["pos_" .. 1])
		end
	end
end

function ExpeditionDetailLayer:createTicketImage()
	self.ticketPanel:setVisible(false)
end

function ExpeditionDetailLayer:dealChangeBtn(arg_26_1)
	if self.ticket and item_manager:getItemNumber(self.ticket) < self.ticketnum then
		global_ShowBlockWords("门票不足")

		return
	end

	if self.advenName == "bianhua" and self.curlevel >= 7 and self.btnindex == 7 then
		global_ShowBlockWords(L_BIANHUA_ADVEN_OUT)

		return
	end

	local var_26_0 = self.mode
	local var_26_1 = self.btnindex
	local var_26_2, var_26_3 = level_manager:isModeValid(self.mode)

	if not var_26_2 then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(var_26_0, var_26_3))

		return
	end

	local function var_26_4(arg_27_0)
		if arg_27_0 == 1 then
			FightManager.refreshFightToType(FIGHTTYPE_ADVENTURE)
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})
			self:exit()

			if self.msg.data.modetype == 2 then
				AnalyticManager.adver_wuzi_enter({
					wuzi_level = var_26_1
				})
			end

			if self.msg.data.modetype == 3 then
				AnalyticManager.adver_yuansu_enter_kaohe({
					yuansu_catage = self.msg.data.mode,
					yuansu_level = var_26_1
				})
			end

			if self.msg.data.modetype == 4 then
				AnalyticManager.adver_zhiye_enter({
					zhiye_catage = self.msg.data.mode,
					zhiye_level = var_26_1
				})
			end
		else
			if arg_27_0 == 2 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_27_0 == 3 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_27_0 == 4 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			elseif arg_27_0 == 5 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[5])
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end

	local var_26_5 = RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray)

	GuideListener.showAllGuidesWithFullScreen(false)
	array_manager:resetHangupArray(var_26_5)
	RoleDefault:getInstance():setIntegerForKey("adventurearray", var_26_5)
	array_manager:executeHangupArrayChange()

	if self:checkTheTeamIsvalid() then
		level_manager:switchToAdventureMode(var_26_0, self.btnindex, var_26_4)
	end
end

function ExpeditionDetailLayer:checkTheTeamIsvalid()
	return array_manager:checkIsSameColorTeam(RoleDefault:getInstance():getIntegerForKey("adventurearray", playermodel.curArray), self.mode)
end

function ExpeditionDetailLayer:dealChangeBtn_ai()
	local var_29_0 = self.btnindex
	local var_29_1, var_29_2 = level_manager:isModeValid(self.mode)

	if not var_29_1 then
		audio_manager:playeffectMusicTest("sound/invalid")
		global_ShowBlockWords(level_manager:getModeUnlockMsg(self.mode, var_29_2))

		return
	end

	aiattack_manager:switchToAiAttack(self.mode, self.btnindex, function(arg_30_0)
		if arg_30_0 == 1 then
			FightManager.refreshFightToType(FIGHTTYPE_AIATTACK)
			LayerManager:switchShowLayer("FightLayer", {
				is_hide_topcost = true,
				is_hide_listbutton = true
			})

			if self.msg.data.modetype == 2 then
				AnalyticManager.adver_wuzi_enter({
					wuzi_level = var_29_0
				})
			end

			if self.msg.data.modetype == 3 then
				AnalyticManager.adver_yuansu_enter_kaohe({
					yuansu_catage = self.msg.data.mode,
					yuansu_level = var_29_0
				})
			end

			if self.msg.data.modetype == 4 then
				AnalyticManager.adver_zhiye_enter({
					zhiye_catage = self.msg.data.mode,
					zhiye_level = var_29_0
				})
			end
		else
			if arg_30_0 == 2 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[2])
			elseif arg_30_0 == 3 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[3])
			elseif arg_30_0 == 4 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[4])
			elseif arg_30_0 == 5 then
				audio_manager:playeffectMusicTest("sound/invalid")
				global_ShowBlockWords(L_ADVENTURE_WARNING[5])
			end

			GuideListener.showAllGuidesWithFullScreen(true)
		end
	end)
end

function ExpeditionDetailLayer:initpanel(arg_31_1)
	local var_31_0 = self.mode .. "-" .. arg_31_1

	if not chapter_data[self.mode .. "-" .. arg_31_1].combat_limit then
		-- block empty
	end

	self.zhanli:setVisible(false)

	if self.score then
		local var_31_2 = chapter_data[var_31_0].passscore or 0

		self.titlescore:setString("" .. global_trans_number(var_31_2))

		if arg_31_1 == self.numchapter and not self.issummeradverture then
			self.titlescore:setString("" .. global_trans_number(var_31_2) .. "(~)")
		end
	else
		self.titlescore:setString("")
	end

	local var_31_3 = expedition_manager:getCurLevelBossInfo(self.msg.level).boss.majorlist.modelid

	self.bossinfomode = var_31_3

	self.bossimg:loadTexture(CUTE_ROLE_IMAGE_PATH .. model_data[var_31_3].cute_role .. ".png")
	self.bossimg:setScale(0.55)
	self.bossimg:setPosition(cc.p(102, 398))
	self:initPanelList_H2((self:getDropData(chapter_data[var_31_0].bigbossdrop or chapter_data[var_31_0].equip_drop)))
	self.citiaopanel:setVisible(false)

	local var_31_4 = level_manager:getChapterBattleFieldInfo(var_31_0)

	for iter_31_0 = 1, 6 do
		local var_31_5 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_kao" .. iter_31_0)

		if var_31_4[iter_31_0] then
			if var_31_5 then
				var_31_5:setVisible(true)
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_text" .. iter_31_0):setString(var_31_4[iter_31_0])
				var_31_5:setPositionY(var_31_5:getPositionY())
			else
				local var_31_6 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_kao3")
				local var_31_7 = var_31_6:clone()

				var_31_7:setPositionX(var_31_6:getPositionX())
				var_31_7:setPositionY(var_31_6:getPositionY() - 50 * (iter_31_0 - 3))
				var_31_7:getChildByName("Label_text3"):setString(var_31_4[iter_31_0])
				var_31_6:getParent():addChild(var_31_7)
			end
		elseif var_31_5 then
			var_31_5:setVisible(false)
		end
	end

	if not self.issummeradverture then
		-- block empty
	end

	if self.mode == aiattack_manager:get_levelmode_id() then
		local var_31_8 = cc.Label:createWithTTF("通关后阵亡AI将不再返还", FONT_DES, 22)

		var_31_8:setPosition(420, 200)
		var_31_8:setColor(cc.c3b(253, 151, 32))
		self.zhupanel:addChild(var_31_8)

		if levelmode_data[self.mode].endtime then
			local var_31_9 = time_check_manager:getCurTime()
			local var_31_10 = os.time(parse_time(levelmode_data[self.mode].endtime))
			local var_31_11 = cc.Label:createWithTTF("据活动截止还剩:" .. (var_0_33((var_31_10 - var_31_9 > 0 or nil) and (var_31_10 - var_31_9 or 0)) or "00:00:00"), FONT_DES, 22)

			var_31_11:setColor(cc.c3b(253, 151, 32))
			var_31_11:setPosition(414, 240)
			self.zhupanel:addChild(var_31_11)
		end
	end
end

function ExpeditionDetailLayer.DealDataForamte(arg_32_0, arg_32_1)
	if not arg_32_1 then
		return
	end

	local var_32_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		if iter_32_1.itemid == 1 and iter_32_1.count > 0 then
			var_32_0.gold = var_32_0.gold + iter_32_1.count
		elseif iter_32_1.itemid == 0 and iter_32_1.count > 0 then
			var_32_0.diamond = var_32_0.diamond + iter_32_1.count
		else
			table.insert(var_32_0.items, {
				itemid = iter_32_1.itemid,
				num = iter_32_1.count,
				rate = tonumber(iter_32_1.rate)
			})
		end
	end

	return var_32_0
end

function ExpeditionDetailLayer:updateButtomBtn(arg_33_1)
	if arg_33_1 <= self.curlevel + 1 then
		self.kaohebtn:setVisible(true)
		self.imagecishu:setVisible(false)
		self.imagenoopen:setVisible(false)
		self.buybtn:setVisible(false)
	else
		self.kaohebtn:setVisible(false)
		self.imagecishu:setVisible(false)
		self.imagenoopen:setVisible(true)
		self.buybtn:setVisible(false)
	end

	local var_33_0 = self.mode .. "-" .. self.msg.chapter .. "-" .. self.msg.level
	local var_33_1 = require("data.leveldata.level_data_" .. self.mode)

	self.ticket = var_33_1[self.mode .. "-" .. self.msg.chapter .. "-" .. self.msg.level].ticket
	self.ticketnum = var_33_1[var_33_0].ticketnum
	self.is_once_fight = var_33_1[var_33_0].is_once_fight

	if self.ticket then
		self.ticketPanel:getChildByName("Image_ticket"):loadTexture("equipment/" .. item_data[self.ticket].image_id .. ".png")
		self.ticketPanel:getChildByName("Label_ticketnum"):setString("X" .. self.ticketnum)

		if item_manager:getItemNumber(self.ticket) < self.ticketnum then
			self.ticketPanel:getChildByName("Label_ticketnum"):setColor(cc.c3b(255, 0, 0))
		else
			self.ticketPanel:getChildByName("Label_ticketnum"):setColor(cc.c3b(255, 255, 255))
		end

		self.imagecishu:setVisible(false)
		self.ticketPanel:setVisible(true)

		if self.curlevel == 0 then
			if arg_33_1 == 1 then
				self.kaohebtn:setVisible(true)
				self.imagenoopen:setVisible(false)
				self.buybtn:setVisible(false)
			else
				self.kaohebtn:setVisible(false)
				self.imagenoopen:setVisible(true)
				self.buybtn:setVisible(false)
				self.ticketPanel:setVisible(false)
			end
		else
			print("gggggggggggg", arg_33_1, self.curlevel)

			if arg_33_1 <= self.curlevel + 1 then
				self.kaohebtn:setVisible(true)
				self.imagecishu:setVisible(false)
				ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString(tostring(self.times))
				self.imagenoopen:setVisible(false)
				self.buybtn:setVisible(false)
			else
				self.kaohebtn:setVisible(false)
				self.imagecishu:setVisible(false)
				self.imagenoopen:setVisible(true)
				self.buybtn:setVisible(false)
				self.ticketPanel:setVisible(false)
			end
		end
	else
		self.ticketPanel:setVisible(false)
	end

	if self.isvisual then
		if self.curlevel == 0 then
			if arg_33_1 == 1 then
				self.kaohebtn:setVisible(true)
				self.imagecishu:setVisible(false)
				ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString("")
				self.imagenoopen:setVisible(false)
				self.buybtn:setVisible(false)
			else
				self.kaohebtn:setVisible(false)
				self.imagecishu:setVisible(false)
				self.imagenoopen:setVisible(true)
				self.buybtn:setVisible(false)
			end
		elseif arg_33_1 <= self.curlevel + 1 then
			if self.times > 0 then
				self.kaohebtn:setVisible(true)
				self.imagecishu:setVisible(false)
				ccui.Helper:seekWidgetByName(self.imagecishu, "Label_24"):setString("")
				self.imagenoopen:setVisible(false)
				self.buybtn:setVisible(false)
			end
		else
			self.kaohebtn:setVisible(false)
			self.imagecishu:setVisible(false)
			self.imagenoopen:setVisible(true)
			self.buybtn:setVisible(false)
		end

		self.imagecishu:setVisible(false)
	end

	if self.issummeradverture and self.iscanrepeatchange and arg_33_1 <= self.curlevel then
		self.kaohebtn:setVisible(false)
	end
end

function ExpeditionDetailLayer:updateTopBtn()
	for iter_34_0, iter_34_1 in pairs(self.topbtns) do
		if iter_34_1.index ~= self.btnindex then
			iter_34_1:getChildByName("Button_18"):setBright(true)
		else
			iter_34_1:getChildByName("Button_18"):setBright(false)
		end
	end
end

function ExpeditionDetailLayer:initPanelList_H1()
	self:updateButtomBtn(self.btnindex)
end

function ExpeditionDetailLayer:initPanelList_H2(arg_36_1, arg_36_2)
	self.ListView_buttom:removeAllChildren()
	self.ListView_buttom:setItemsMargin(0)

	self.awardalls = {}

	local var_36_0 = arg_36_1

	if arg_36_1.gold > 0 then
		local var_36_1 = self.buttonitem:clone()
		local var_36_2 = ItemSprite:createNewWithItemId("gold", arg_36_1.gold)

		var_36_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_36_2:setPosition(cc.p(var_36_1:getContentSize().width * 0.5, var_36_1:getContentSize().height * 0.5))
		var_36_2:setScale(0.6)
		var_36_1:addChild(var_36_2)
		self.ListView_buttom:pushBackCustomItem(var_36_1)
		table.insert(self.awardalls, var_36_1)
	end

	if arg_36_1.diamond > 0 then
		local var_36_3 = self.buttonitem:clone()
		local var_36_4 = ItemSprite:createNewWithItemId("diamond", arg_36_1.diamond)

		var_36_4:setAnchorPoint(cc.p(0.5, 0.5))
		var_36_4:setPosition(cc.p(var_36_3:getContentSize().width * 0.5, var_36_3:getContentSize().height * 0.5))
		var_36_4:setScale(0.6)
		var_36_3:addChild(var_36_4)
		self.ListView_buttom:pushBackCustomItem(var_36_3)
		table.insert(self.awardalls, var_36_3)
	end

	for iter_36_0 = 1, #arg_36_1.items do
		local var_36_5 = self.buttonitem:clone()
		local var_36_6 = ItemSprite:createNewWithItemId(arg_36_1.items[iter_36_0].itemid, arg_36_1.items[iter_36_0].num)

		var_36_6:setAnchorPoint(cc.p(0.5, 0.5))
		var_36_6:setScale(0.6)
		var_36_6:setPosition(cc.p(var_36_5:getContentSize().width * 0.5, var_36_5:getContentSize().height * 0.5))
		var_36_5:addChild(var_36_6)

		var_36_5.item_type = "item"

		if arg_36_1.items[iter_36_0].rate and arg_36_1.items[iter_36_0].rate ~= 1 then
			local var_36_7 = ccui.ImageView:create("public/box/wordBg.png", var_0_0)

			var_36_7:setPositionX(var_36_5:getContentSize().width - var_36_7:getContentSize().width / 2 - 7)
			var_36_7:setPositionY(var_36_5:getContentSize().height - var_36_7:getContentSize().height / 2 - 5)
			var_36_5:addChild(var_36_7)

			local var_36_8 = cc.Label:createWithTTF(arg_36_1.items[iter_36_0].rate * 100 .. "%", FONT_DES, 18)

			var_36_8:setPositionX(var_36_7:getContentSize().width / 2)
			var_36_8:setPositionY(var_36_7:getContentSize().height / 2)
			var_36_7:addChild(var_36_8)
		end

		var_36_5:addTouchEventListener(function(arg_37_0, arg_37_1)
			if arg_37_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:showDetailsofItems(var_36_0.items[iter_36_0].itemid, var_36_5.item_type)
		end)
		self.ListView_buttom:pushBackCustomItem(var_36_5)
		table.insert(self.awardalls, var_36_5)
	end

	if self.isrepeat and next(self.awardalls) and self.curlevel ~= 0 and arg_36_2 <= self.curlevel then
		for iter_36_1, iter_36_2 in ipairs(self.awardalls) do
			local var_36_9 = ccui.Layout:create()

			var_36_9:setContentSize(cc.size(iter_36_2:getContentSize().width - 16, iter_36_2:getContentSize().height - 16))
			var_36_9:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
			var_36_9:setCascadeOpacityEnabled(false)
			var_36_9:setBackGroundColorOpacity(190)
			var_36_9:setAnchorPoint(0.5, 0.5)
			var_36_9:setPosition(cc.p(iter_36_2:getContentSize().width / 2, iter_36_2:getContentSize().height / 2))
			var_36_9:setBackGroundColor(cc.c3b(0, 0, 0))
			var_36_9:setTouchEnabled(false)
			var_36_9:setName("sucess_award")
			iter_36_2:addChild(var_36_9, 1000)

			local var_36_10 = ccui.ImageView:create("public/panelbg/fragment_tic_new.png", var_0_0)

			var_36_10:setScale(0.6)
			var_36_10:setAnchorPoint(cc.p(0.5, 0.5))
			var_36_10:setName("sucess_img")
			var_36_10:setPosition(cc.p(var_36_9:getContentSize().width / 2 + 22, var_36_9:getContentSize().height - 114))
			var_36_9:addChild(var_36_10)
		end
	end
end

function ExpeditionDetailLayer:showDetailsofItems(arg_38_1, arg_38_2)
	local function var_38_1()
		self.rootLayer:setVisible(true)
	end

	if arg_38_2 == "item" then
		if item_data[arg_38_1].bag_item_type == kITEM_HORCRUX then
			local var_38_2 = -1
			local horcrux_data = require("data.horcrux_data")

			for iter_38_0, iter_38_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if iter_38_1.model_id == horcrux_data[arg_38_1].model then
					var_38_2 = iter_38_0

					break
				end
			end

			if var_38_2 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_38_2,
				itemid = arg_38_1,
				callback = var_38_1
			})
			self.rootLayer:setVisible(false)
		elseif item_data[arg_38_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_38_1].servant,
				exitCallback = var_38_1
			})
			self.rootLayer:setVisible(false)
		elseif not self:getChildByName("OTHER_LAYER") then
			local var_38_4 = PopLayer:Item({
				hideGainButton = true,
				itemid = arg_38_1
			})
		end
	elseif arg_38_2 == "gold" then
		-- block empty
	elseif arg_38_2 == "diamond" then
		-- block empty
	end
end

function ExpeditionDetailLayer.getDropData(arg_40_0, arg_40_1)
	local var_40_0 = {
		gold = 0,
		diamond = 0,
		items = {}
	}
	local var_40_1 = drop_data[arg_40_1] or {}

	if var_40_1.gold then
		var_40_0.gold = var_40_0.gold + var_40_1.gold
	end

	if var_40_1.diamond then
		var_40_0.diamond = var_40_0.diamond + var_40_1.diamond
	end

	local var_40_2 = 1

	if var_40_1["drop_id" .. 1] then
		local var_40_3 = 1

		while var_40_1["drop_id" .. var_40_3] do
			var_40_0.items[var_40_2] = {
				itemid = var_40_1["drop_id" .. var_40_3],
				num = var_40_1["drop_num" .. var_40_3],
				rate = var_40_1["drop_rate" .. var_40_3]
			}
			var_40_3 = var_40_3 + 1
			var_40_2 = var_40_2 + 1
		end
	end

	if var_40_1["dropmodel_id" .. 1] then
		local var_40_4 = 1

		while var_40_1["dropmodel_id" .. var_40_4] do
			if drop_data[var_40_1["dropmodel_id" .. var_40_4]].gold then
				var_40_0.gold = var_40_0.gold + drop_data[var_40_1["dropmodel_id" .. var_40_4]].gold
			end

			if drop_data[var_40_1["dropmodel_id" .. var_40_4]].diamond then
				var_40_0.diamond = var_40_0.diamond + drop_data[var_40_1["dropmodel_id" .. var_40_4]].diamond
			end

			if drop_data[var_40_1["dropmodel_id" .. var_40_4]]["drop_id" .. 1] then
				local var_40_5 = 1

				while drop_data[var_40_1["dropmodel_id" .. var_40_4]]["drop_id" .. var_40_5] do
					var_40_0.items[var_40_2] = {
						itemid = drop_data[var_40_1["dropmodel_id" .. var_40_4]]["drop_id" .. var_40_5],
						num = drop_data[var_40_1["dropmodel_id" .. var_40_4]]["drop_num" .. var_40_5]
					}
					var_40_5 = var_40_5 + 1
					var_40_2 = var_40_2 + 1
				end
			end

			if drop_data[var_40_1["dropmodel_id" .. var_40_4]]["rd_drop_id" .. 1] then
				local var_40_6 = 1

				while drop_data[var_40_1["dropmodel_id" .. var_40_4]]["rd_drop_id" .. var_40_6] do
					var_40_0.items[var_40_2] = {
						itemid = drop_data[var_40_1["dropmodel_id" .. var_40_4]]["rd_drop_id" .. var_40_6],
						num = drop_data[var_40_1["dropmodel_id" .. var_40_4]]["rd_drop_num" .. var_40_6]
					}
					var_40_6 = var_40_6 + 1
					var_40_2 = var_40_2 + 1
				end
			end

			var_40_4 = var_40_4 + 1
		end
	end

	if var_40_1["rd_drop_id" .. 1] then
		local var_40_7 = 1

		while var_40_1["rd_drop_id" .. var_40_7] do
			var_40_0.items[var_40_2] = {
				itemid = var_40_1["rd_drop_id" .. var_40_7],
				num = var_40_1["rd_drop_num" .. var_40_7]
			}
			var_40_7 = var_40_7 + 1
			var_40_2 = var_40_2 + 1
		end
	end

	if var_40_1["rd_dropmodel_id" .. 1] then
		local var_40_8 = 1

		while var_40_1["rd_dropmodel_id" .. var_40_8] do
			if drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]].gold then
				var_40_0.gold = var_40_0.gold + drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]].gold
			end

			if drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]].diamond then
				var_40_0.diamond = var_40_0.diamond + drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]].diamond
			end

			if drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]]["drop_id" .. 1] then
				local var_40_9 = 1

				while drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]]["drop_id" .. var_40_9] do
					var_40_0.items[var_40_2] = {
						itemid = drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]]["drop_id" .. var_40_9],
						num = drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]]["drop_num" .. var_40_9]
					}
					var_40_9 = var_40_9 + 1
					var_40_2 = var_40_2 + 1
				end
			end

			if drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]]["rd_drop_id" .. 1] then
				local var_40_10 = 1

				while drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]]["rd_drop_id" .. var_40_10] do
					var_40_0.items[var_40_2] = {
						itemid = drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]]["rd_drop_id" .. var_40_10],
						num = drop_data[var_40_1["rd_dropmodel_id" .. var_40_8]]["rd_drop_num" .. var_40_10]
					}
					var_40_10 = var_40_10 + 1
					var_40_2 = var_40_2 + 1
				end
			end

			var_40_8 = var_40_8 + 1
		end
	end

	return var_40_0
end

function ExpeditionDetailLayer:createBossInfoBtn()
	local var_41_0 = ccui.Button:create("adventurenewlayer/btn_more.png", nil, "adventurenewlayer/btn_more.png", var_0_0)

	var_41_0:setPosition(cc.p(self.zhupanel:getContentSize().width / 2 - 170, self.zhupanel:getContentSize().height / 2 - 40))
	self.zhupanel:addChild(var_41_0, 100)

	local var_41_3 = {
		id = model_data[self.bossinfomode].photofile_model,
		modelid = self.bossinfomode,
		contentType = {
			contentType = var_0_32[model_data[self.bossinfomode].photofile_type]
		}
	}

	var_41_0:addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_41_3.modelid = self.bossinfomode
		var_41_3.contentType = {
			contentType = var_0_32[model_data[self.bossinfomode].photofile_type]
		}
		var_41_3.id = model_data[self.bossinfomode].photofile_model

		if var_0_32[model_data[self.bossinfomode].photofile_type] == "file_player" or var_0_32[model_data[self.bossinfomode].photofile_type] == "file_enemy1" or var_0_32[model_data[self.bossinfomode].photofile_type] == "file_enemy6" or var_0_32[model_data[self.bossinfomode].photofile_type] == "file_enemy8" or var_0_32[model_data[self.bossinfomode].photofile_type] == "file_enemy10" or var_0_32[model_data[self.bossinfomode].photofile_type] == "file_enemy12" or var_0_32[model_data[self.bossinfomode].photofile_type] == "file_teacher" or var_0_32[model_data[self.bossinfomode].photofile_type] == "file_nightmare_xmasfile" then
			LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_41_3)
		else
			LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_41_3)
		end
	end)
end

function ExpeditionDetailLayer:initEnemyList()
	local var_43_0 = self.arraypanel:getChildByName("Image_41")

	for iter_43_0, iter_43_1 in pairs(var_43_0:getChildren()) do
		iter_43_1:setVisible(false)
	end

	self.enemylistData = expedition_manager:getAllLevelEnemys(self.mode, self.msg.level)
	self.enemyList = ccui.ScrollView:create()

	self.enemyList:setContentSize(cc.size(var_43_0:getContentSize().width - 20, var_43_0:getContentSize().height))
	self.enemyList:setInnerContainerSize(cc.size(111 * #self.enemylistData < var_43_0:getContentSize().width and var_43_0:getContentSize().width or 111 * #self.enemylistData, 161))
	self.enemyList:setBounceEnabled(true)
	self.enemyList:setDirection(ccui.ScrollViewDir.horizontal)
	self.enemyList:setPosition(10, 0)
	var_43_0:addChild(self.enemyList)

	for iter_43_2, iter_43_3 in ipairs(self.enemylistData) do
		local var_43_1 = ccui.ImageView:create("adventurenewlayer/array_jiaose.png", var_0_0)

		var_43_1:setTouchEnabled(true)
		var_43_1:setAnchorPoint(cc.p(0, 0.5))
		var_43_1:setPosition((iter_43_2 - 1) * var_43_1:getBoundingBox().width, self.enemyList:getContentSize().height / 2)
		self.enemyList:addChild(var_43_1)

		local var_43_2 = ccui.ImageView:create("roleimage/role/wuji/" .. model_data[iter_43_3].head_image .. ".png")

		var_43_2:setPosition(var_43_1:getContentSize().width / 2, var_43_1:getContentSize().height / 2)
		var_43_2:setScale(0.4)
		var_43_1:addChild(var_43_2)
		var_43_1:addTouchEventListener(function(arg_44_0, arg_44_1)
			if arg_44_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_44_2 = {
				id = model_data[iter_43_3].photofile_model,
				modelid = iter_43_3,
				contentType = {
					contentType = var_0_32[model_data[iter_43_3].photofile_type]
				},
				modelid = iter_43_3
			}

			var_44_2.contentType = {
				contentType = var_0_32[model_data[iter_43_3].photofile_type]
			}
			var_44_2.id = model_data[iter_43_3].photofile_model

			if var_0_32[model_data[iter_43_3].photofile_type] == "file_player" or var_0_32[model_data[iter_43_3].photofile_type] == "file_enemy1" or var_0_32[model_data[iter_43_3].photofile_type] == "file_enemy6" or var_0_32[model_data[iter_43_3].photofile_type] == "file_enemy8" or var_0_32[model_data[iter_43_3].photofile_type] == "file_enemy10" or var_0_32[model_data[iter_43_3].photofile_type] == "file_enemy12" or var_0_32[model_data[iter_43_3].photofile_type] == "file_teacher" or var_0_32[model_data[iter_43_3].photofile_type] == "file_nightmare_xmasfile" then
				LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_44_2)
			else
				LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_44_2)
			end
		end)
	end
end

function ExpeditionDetailLayer:fullScreen(arg_45_1)
	arg_45_1:setContentSize((GameDisplay.getScreenSize()))
	arg_45_1:setPositionY(arg_45_1:getPositionY() - GameDisplay.fix_y)
	self.zhupanel:setPositionY(self.zhupanel:getPositionY() + GameDisplay.fix_y)
end

function ExpeditionDetailLayer:initBg(arg_46_1)
	local var_46_0 = ccui.Layout:create()

	var_46_0:setTouchEnabled(true)
	var_46_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_46_0:setAnchorPoint(cc.p(0, 0))
	var_46_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_46_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_46_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_46_0:setOpacity(0)
	var_46_0:setCascadeOpacityEnabled(false)
	self:addChild(var_46_0, -1)

	local var_46_1 = ccui.ImageView:create("mainScenebg/blur_mask.png")

	var_46_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_46_1:setPositionX(var_46_0:getContentSize().width / 2)
	var_46_1:setPositionY(var_46_0:getContentSize().height / 2)
	var_46_0:addChild(var_46_1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_47_0)
		self:addChild(arg_47_0, -2)
		arg_47_0:setPositionY(arg_47_0:getPositionY() - GameDisplay.fix_y)
		self:init(arg_46_1)
		var_46_0:setOpacity(102)
		var_46_0:setTouchEnabled(false)
	end)
end

function ExpeditionDetailLayer:exit()
	global_window_close_action(self.zhupanel, function()
		LayerManager:removePopLayer()
	end)
end
