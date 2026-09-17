ClassupdateLayer = class("ClassupdateLayer", function()
	return cc.Layer:create()
end)

require("data.constants")
require("view.Sprite.AvatarSprite")

local grade_exp_data = require("data.grade_exp_data")
local item_data = require("data.item_data")
local class_update_data = require("data.class_update_data")
local levelmode_data = require("data.levelmode_data")
local chapter_data = require("data.chapter_data")
local var_0_5 = require("data.item_data")
local city_data = require("data.city_data")
local weapon_data = require("data.weapon_data")
local playermodel = require("model.playermodel")
local audio_manager = require("controller.audio_manager")
local armature_manager = require("controller.armature_manager")
local level_manager = require("controller.level_manager")
local souls_manager = require("controller.souls_manager")

require("view.Layer.PopLayer")
require("view.Sprite.ItemsPanel")

local item_manager = require("controller.item_manager")
local account_manager = require("controller.account_manager")
local grade_manager = require("controller.grade_manager")
local var_0_16 = config._DEBUG and 0 or 1
local var_0_17 = false
local var_0_18 = {
	"Class/junior.png",
	"Class/middle.png",
	"Class/university.png",
	"Class/postgraduate.png",
	"Class/doctor.png"
}
local var_0_21 = {
	"equipment/medal1.png",
	"equipment/medal2.png",
	"equipment/medal3.png",
	"equipment/medal4.png",
	"equipment/medal5.png",
	"equipment/medal6.png"
}
local var_0_22 = {
	cc.c4b(240, 240, 240, 150),
	cc.c4b(54, 255, 82, 150),
	cc.c4b(56, 122, 255, 150),
	cc.c4b(255, 12, 246, 150),
	cc.c4b(255, 84, 0, 150),
	cc.c4b(255, 0, 0, 150)
}
local var_0_23

function ClassupdateLayer.getInstance()
	return var_0_23
end

function ClassupdateLayer.create(arg_3_0, arg_3_1)
	var_0_23 = ClassupdateLayer.new()

	var_0_23:init(arg_3_1)

	return var_0_23
end

function ClassupdateLayer:init(arg_4_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Class.json" or "Class.ExportJson")

	self:addChild(self.rootlayer)

	if ListButtonLayer.getInstance() then
		ListButtonLayer.getInstance():hideLayer()
	end

	self.lastlayer = arg_4_1 or "MainLayer"

	self:initBottom()
	self:initIconAndName()
	self:initUidAndSign()
	self:initClassAndMedal()
	self:initPlayerContractAttr()
	self:initTaskBtn()
	self:initExpAndList()
	self:initUserCenter()
	self:registerCustomEvent()
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			var_0_23 = nil
			global_classup_level_label = nil

			TextureManager:unregisterTexture("ClassupdateLayer")
		end
	end)
	self:fullScreen()
	self:update()
end

function ClassupdateLayer:initUserCenter()
	local var_6_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "user_center")
	local var_6_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "user_privacy")

	var_6_0:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if config.packagechannel ~= "feiyu" then
			return
		end

		AnalyticManager.enterUserCenter()
		account_manager:usercenterwithinfo()
	end)

	if account_manager:getChannel() == "270048" or account_manager:getChannel() == "270054" or account_manager:getChannel() == "270057" or account_manager:getChannel() == "270052" or account_manager:getChannel() == "270063" or account_manager:getChannel() == "270111" or account_manager:getChannel() == "270055" or account_manager:getChannel() == "999" then
		var_6_0:setVisible(false)
	end

	var_6_1:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if config.packagechannel ~= "feiyu" then
			return
		end

		self:checkPrivacy()
	end)
end

function ClassupdateLayer:checkPrivacy()
	self:addChild(require("view.Layer.CheckPrivacyLayer"):create(), 5)
end

function ClassupdateLayer:initBottom()
	ccui.Helper:seekWidgetByName(self.rootlayer, "button_return_0"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	ccui.Helper:seekWidgetByName(self.rootlayer, "login_out"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_12_0 = {
			labels = setmetatable({}, {
				__index = L_LOGOUT_PLAYER
			}),
			surecallback = function()
				global_logout("switchplayer")
				AnalyticManager.clickSwitchPlayerSuccess()
			end
		}

		var_12_0.labels.titleImage = "title_change_role.png"

		LayerManager:pushInLayer("PopDoLayer", var_12_0)
		AnalyticManager.clickSwitchPlayer()
	end)

	if playermodel.bindmobilestatus == 0 then
		ccui.Helper:seekWidgetByName(self.rootlayer, "btn_bindmobile"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootlayer, "btn_ChangeUser"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootlayer, "btn_bindmobile"):addTouchEventListener(function(arg_14_0, arg_14_1)
			if arg_14_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopBindMobileLayer")
		end)
	else
		ccui.Helper:seekWidgetByName(self.rootlayer, "btn_ChangeUser"):setVisible(true)
		ccui.Helper:seekWidgetByName(self.rootlayer, "btn_bindmobile"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootlayer, "btn_ChangeUser"):addTouchEventListener(function(arg_15_0, arg_15_1)
			if arg_15_1 ~= ccui.TouchEventType.ended then
				return
			end

			if config.packagechannel == "feiyu" then
				require("controller.account_manager"):switchaccount()
			else
				ConsoleExt.restart()
			end
		end)
	end

	if DeviceManager.getChannelID() == "270111" then
		ccui.Helper:seekWidgetByName(self.rootlayer, "btn_ChangeUser"):setVisible(false)
	end
end

function ClassupdateLayer:registerCustomEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("UPDATEBINDMOBILE", function()
		ccui.Helper:seekWidgetByName(self.rootlayer, "btn_bindmobile"):setVisible(playermodel.bindmobilestatus == 0)
	end), self)
end

function ClassupdateLayer:initIconAndName()
	local var_18_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "icon")

	var_18_0:setVisible(false)

	self.icon = AvatarSprite:create(playermodel.head_sculpture)

	self.icon:setPosition(cc.p(0, 0))
	var_18_0:getParent():addChild(self.icon)

	self.icon_button = ccui.Helper:seekWidgetByName(self.rootlayer, "icon_change_button")
	self.signature_label = ccui.Helper:seekWidgetByName(self.rootlayer, "signature_label")
	self.name_bg = ccui.Helper:seekWidgetByName(self.rootlayer, "name_bg")
	self.name_label = ccui.Helper:seekWidgetByName(self.rootlayer, "name_label")

	self.name_label:setFontName("fonts/name.ttf")
	self.name_label:setColor(cc.c3b(239, 248, 255))
	self:updatePlayerSculture()
	self.icon:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:changeIcon()
	end)
	self.icon_button:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:changeIcon()
	end)
	self.name_bg:setTouchEnabled(true)
	self.name_bg:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if var_0_17 then
			return
		end

		self:changeName()
	end)

	self.btnPostCard = ccui.Button:create("Class/btn_postcard.png", nil, "Class/btn_postcard.png", var_0_16)

	self.btnPostCard:setPosition(var_18_0:getPositionX() + 150, var_18_0:getPositionY() - 110)
	var_18_0:getParent():addChild(self.btnPostCard)
	require("common.Utility"):addClickEventListener(self.btnPostCard, function()
		LayerManager:pushInLayer("PopPostCardLayer", {})
	end)
end

function ClassupdateLayer:initUidAndSign()
	self.uid_label = ccui.Helper:seekWidgetByName(self.rootlayer, "uid_label")

	self.uid_label:setFontName("fonts/name.ttf")
	self.uid_label:setString(playermodel.playerid)

	self.signature_label = ccui.Helper:seekWidgetByName(self.rootlayer, "signature_label")

	self.signature_label:setFontName("fonts/name.ttf")
	self.signature_label:setContentSize(cc.size(240, 80))
	self.signature_label:ignoreContentAdaptWithSize(false)

	self.signature_button = ccui.Helper:seekWidgetByName(self.rootlayer, "signature_button")

	if not playermodel.signment or playermodel.signment == 0 then
		self.signature_label:setString(L_SIGNATURE_WARNING.Sign_Box_Nil)
	else
		self.signature_label:setString(playermodel.signment)
	end

	self.signature_button.setSwallowTouches(false)
	self.signature_button:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:changeSaying(arg_24_0, arg_24_1)
	end)

	if DeviceManager.getChannelID() == "270052" or var_0_17 then
		ccui.Helper:seekWidgetByName(self.rootlayer, "signature_button"):setVisible(false)
		self.signature_label:setString(L_SIGNATURE_WARNING.Sign_Box_Nil)
	end
end

function ClassupdateLayer:initClassAndMedal()
	self.class = ccui.Helper:seekWidgetByName(self.rootlayer, "class")
	self.medal = {}

	for iter_25_0 = 1, 3 do
		self.medal[iter_25_0] = ccui.Helper:seekWidgetByName(self.rootlayer, "medal_" .. iter_25_0)
		self.medal[iter_25_0].index = iter_25_0

		self.medal[iter_25_0]:setTouchEnabled(true)
		self.medal[iter_25_0]:addTouchEventListener(function(arg_26_0, arg_26_1)
			if arg_26_1 ~= ccui.TouchEventType.ended then
				return
			end

			if next((item_manager:getAllHavedMedals())) == nil then
				global_ShowBlockWords(L_MEDAL_WARNING.Empty)

				return
			end

			self:changeMedal(arg_26_0.index)
		end)
	end

	self:updateMedalInfo()
end

function ClassupdateLayer:initPlayerContractAttr()
	self.star = ccui.Helper:seekWidgetByName(self.rootlayer, "star")

	self.star:setPositionX(self.star:getPositionX() + 18)

	lblStarNum = self.star:getChildByName("starnum")

	lblStarNum:setString(souls_manager:get_total_contract_attr())
	self.star:setTouchEnabled(true)
	self.star:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopContractAttrDetailLayer")
	end)
end

function ClassupdateLayer:initTaskBtn()
	local var_29_0 = ccui.Button:create("Class/btn_classup.png", nil, "Class/btn_classup.png", var_0_16)

	var_29_0:setPosition(100, 655 + GameDisplay.fix_y)
	var_29_0:addTouchEventListener(function(arg_30_0, arg_30_1)
		if arg_30_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("TopPlotListLayer", {
			taskType = TASK_TYPE_CAREER
		})
	end)
	self.rootlayer:addChild(var_29_0)
end

function ClassupdateLayer:initExpAndList()
	global_classup_level_label = ccui.Helper:seekWidgetByName(self.rootlayer, "level_label")

	global_classup_level_label:setFontName("fonts/name.ttf")

	self.exp_label_bg = ccui.Helper:seekWidgetByName(self.rootlayer, "exp_label_bg")

	self.exp_label_bg:setLocalZOrder(1)

	self.exp_label = ccui.Helper:seekWidgetByName(self.rootlayer, "exp_label")

	self.exp_label:setFontName("fonts/newkj.ttf")
	self.exp_label:setFontSize(16)
	self.exp_label:setColor(cc.c3b(121, 154, 239))

	self.level_label_bg = ccui.Helper:seekWidgetByName(self.rootlayer, "level_bg")
	self.EXP_progress = ccui.Helper:seekWidgetByName(self.rootlayer, "EXP_progress")

	ccui.Helper:seekWidgetByName(self.rootlayer, "EXP_bg"):addTouchEventListener(function(arg_32_0, arg_32_1)
		if arg_32_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("TopPlotListLayer", {
			taskType = TASK_TYPE_CAREER
		})

		return true
	end)
	ccui.Helper:seekWidgetByName(self.rootlayer, "EXP_bg"):setTouchEnabled(true)

	self.tasklist = ccui.Helper:seekWidgetByName(self.rootlayer, "tasklist")
end

function ClassupdateLayer.initBg(arg_33_0, arg_33_1)
	local var_33_0 = ccui.Layout:create()

	var_33_0:setTouchEnabled(true)
	var_33_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_33_0:setAnchorPoint(cc.p(0, 0))
	var_33_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_33_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_33_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_33_0:setOpacity(0)
	arg_33_1:addChild(var_33_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_34_0)
		arg_33_1:addChild(arg_34_0, -2)
		arg_34_0:setPositionY(arg_34_0:getPositionY() - GameDisplay.fix_y)

		local var_34_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_34_0:setAnchorPoint(cc.p(0, 0))
		var_34_0:setPositionY(-GameDisplay.fix_y)
		arg_33_1:addChild(var_34_0, -1)
		var_33_0:setOpacity(102)
		var_33_0:setTouchEnabled(false)
	end)
end

function ClassupdateLayer:updatePlayerSculture()
	self.icon:switchShowAvatar(playermodel.head_sculpture)
	GlobalUpdateHeadimg()
end

function ClassupdateLayer.changeIcon(arg_36_0)
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in pairs((item_manager:filterItem({
		kITEM_SCULTURE
	}))) do
		if playermodel.items[iter_36_1].itemid == playermodel.head_sculpture then
			table.insert(var_36_0, {
				selected = true,
				itemid = playermodel.items[iter_36_1].itemid
			})
		else
			table.insert(var_36_0, {
				selected = false,
				itemid = playermodel.items[iter_36_1].itemid
			})
		end
	end

	table.sort(var_36_0, function(arg_37_0, arg_37_1)
		return item_data[arg_37_0.itemid].order > item_data[arg_37_1.itemid].order
	end)
	AnalyticManager.clickHead()

	local var_36_1 = playermodel.head_sculpture

	LayerManager:pushInLayer("PopScultureLayer", {
		callback = function(arg_38_0)
			arg_36_0:updatePlayerSculture()

			if playermodel.head_sculpture ~= var_36_1 then
				AnalyticManager.changeHeadImage()
			end
		end,
		scultures = var_36_0
	})
end

function ClassupdateLayer:changeName()
	AnalyticManager.clickName()

	local var_39_0 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "change_figure.json" or "change_figure.ExportJson")

	ccui.Helper:seekWidgetByName(var_39_0, "Panel_revise_saying"):setVisible(false)
	self:initBg(ccui.Helper:seekWidgetByName(var_39_0, "Panel_9"))

	local var_39_1 = ccui.Helper:seekWidgetByName(var_39_0, "Panel_revise_name")

	var_39_1:setVisible(true)
	self.rootlayer:addChild(var_39_0, 999)

	local var_39_2 = 0
	local var_39_3 = 7

	global_window_open_action(var_39_1:getChildByName("box"))
	ccui.Helper:seekWidgetByName(var_39_0, "input_field"):setVisible(false)

	local var_39_4 = ccui.Helper:seekWidgetByName(var_39_1, "box")
	local var_39_5 = ccui.Layout:create()

	var_39_5:setName("cutPanel")
	var_39_5:setContentSize(cc.size(260, 60))
	var_39_5:setAnchorPoint(cc.p(0, 0.5))
	var_39_5:setPosition(cc.p(132, 131))
	var_39_5:setClippingEnabled(true)
	var_39_4:addChild(var_39_5, 5)

	local var_39_6 = var_39_4:getChildByName("nicknameinput")

	if not var_39_6 then
		var_39_6 = config._DEBUG and cc.EditBox:create(cc.size(280, 60), cc.Scale9Sprite:create("public/panelbg/editBoxBG.png")) or cc.EditBox:create(cc.size(280, 60), cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png"))

		var_39_6:setName("nicknameinput")
		var_39_6:setPosition(cc.p(0, 0))
		var_39_6:setAnchorPoint(cc.p(0, 0))
		var_39_6:setFontName(FONT_NAME)
		var_39_6:setPlaceholderFont(FONT_NAME, 28)
		var_39_6:setFontSize(28)
		var_39_6:setFontColor(cc.c3b(255, 255, 255))
		var_39_6:setPlaceHolder(L_NICKNAME_WARNING.Nickname_Nil)
		var_39_6:setPlaceholderFontColor(cc.c3b(100, 100, 100))
		var_39_6:setMaxLength(18)
		var_39_6:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
		var_39_6:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
		var_39_6:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD)
		var_39_5:addChild(var_39_6, 5)
	end

	var_39_6:setText(playermodel.nickname)

	local function var_39_7(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		ccui.Helper:seekWidgetByName(self.rootlayer, "name_label"):setString(tostring(playermodel.nickname))
		GlobalUpdateName()
		global_window_close_action(var_39_1:getChildByName("box"), function()
			var_39_0:runAction(cc.RemoveSelf:create())
		end)
	end

	ccui.Helper:seekWidgetByName(var_39_0, "button_confirm"):addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_42_0:setTouchEnabled(false)

		local var_42_0 = var_39_6:getText()
		local var_42_1 = subStringGetTotalIndex(var_42_0)

		for iter_42_0 = 1, var_42_1 do
			if (string.byte(var_42_0, iter_42_0) > 57 or string.byte(var_42_0, iter_42_0) < 48) and (string.byte(var_42_0, iter_42_0) > 122 or string.byte(var_42_0, iter_42_0) < 97) and (string.byte(var_42_0, iter_42_0) > 90 or string.byte(var_42_0, iter_42_0) < 65) and string.byte(var_42_0, iter_42_0) < 127 then
				local var_42_2 = ccui.Helper:seekWidgetByName(var_39_0, "nicheng")

				var_39_6:setText("")
				var_42_2:setColor(cc.c3b(255, 0, 0))
				var_42_2:setString(L_NICKNAME_WARNING.Nickname_illegal)
				global_ShowBlockWords(L_NICKNAME_WARNING.Nickname_illegal)
				arg_42_0:setTouchEnabled(true)

				return
			end
		end

		if string.find(var_42_0, "#") then
			var_42_0 = string.gsub(var_42_0, "#", "")
		end

		if var_42_0 and var_42_1 > var_39_2 and var_42_1 <= var_39_3 and self:checkmsg(var_42_0) then
			require("network.network"):rpc("set_nickname", {
				nickname = var_42_0
			}, function(arg_43_0)
				if arg_43_0.result == 1 then
					playermodel.nickname = var_42_0

					AnalyticManager.changeNickname()
					var_39_7(arg_42_0, arg_42_1)
				elseif arg_43_0.result == 2 then
					global_ShowBlockWords(L_NICKNAME_WARNING.Nickname_illegal)
					var_39_7(arg_42_0, arg_42_1)
				else
					print("server: set nickname failed!")
					var_39_7(arg_42_0, arg_42_1)
				end

				arg_42_0:setTouchEnabled(true)
			end)
		else
			local var_42_3 = ccui.Helper:seekWidgetByName(var_39_0, "nicheng")

			if var_42_1 <= var_39_2 then
				print("invalid name! name must be longer than 4")
				var_42_3:setColor(cc.c3b(255, 0, 0))
				var_42_3:setString(L_NICKNAME_WARNING.Nickname_Short)
				global_ShowBlockWords(L_NICKNAME_WARNING.Nickname_Short, nil, nil, nil, nil, nil, nil, 20)
			elseif var_42_1 > var_39_3 then
				var_42_3:setColor(cc.c3b(255, 0, 0))
				var_42_3:setString(L_NICKNAME_WARNING.Nickname_Long)
				global_ShowBlockWords(L_NICKNAME_WARNING.Nickname_Long, nil, nil, nil, nil, nil, nil, 20)
			else
				var_42_3:setColor(cc.c3b(255, 0, 0))
				var_42_3:setString(L_NICKNAME_WARNING.Nickname_Sensitive)
				global_ShowBlockWords(L_NICKNAME_WARNING.Nickname_Sensitive, nil, nil, nil, nil, nil, nil, 20)
			end

			arg_42_0:setTouchEnabled(true)
		end
	end)
	ccui.Helper:seekWidgetByName(var_39_0, "Button_random"):addTouchEventListener(function(arg_44_0, arg_44_1)
		if arg_44_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_39_6:setText((require("view.Layer.NameGen.namegen"):GenerateName(true)))
	end)
	ccui.Helper:seekWidgetByName(var_39_0, "box"):addTouchEventListener(function(arg_45_0, arg_45_1)
		return
	end)
	LayerManager:createFullScreenMask(var_39_0, 0, var_39_7)
end

function ClassupdateLayer:changeSaying(arg_46_1, arg_46_2)
	if arg_46_2 ~= ccui.TouchEventType.ended then
		return
	end

	l2Log("changing saying")

	local var_46_0 = self.signature_label:getString()
	local var_46_1 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "change_figure.json" or "change_figure.ExportJson")

	ccui.Helper:seekWidgetByName(var_46_1, "title_0"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_46_1, "Panel_revise_name"):setVisible(false)
	ccui.Helper:seekWidgetByName(var_46_1, "warning"):setString(L_SIGNATURE_WARNING.Sign_Bottom)

	local var_46_2 = ccui.Helper:seekWidgetByName(var_46_1, "Panel_revise_saying")
	local var_46_3 = ccui.Helper:seekWidgetByName(var_46_1, "sayingLabel")

	global_window_open_action(var_46_2:getChildByName("box"))
	var_46_2:setVisible(true)
	self.rootlayer:addChild(var_46_1, 999)
	ccui.Helper:seekWidgetByName(var_46_1, "input_field"):setVisible(false)

	local var_46_4 = ccui.Helper:seekWidgetByName(var_46_2, "box")
	local var_46_5 = var_46_4:getChildByName("input_field")

	if not var_46_5 then
		var_46_5 = config._DEBUG and cc.EditBox:create(cc.size(500, 50), cc.Scale9Sprite:create("public/panelbg/editBoxBG.png")) or cc.EditBox:create(cc.size(500, 50), cc.Scale9Sprite:createWithSpriteFrameName("public/panelbg/editBoxBG.png"))

		var_46_5:setName("input_field")
		var_46_5:setPosition(cc.p(30, 160))
		var_46_5:setAnchorPoint(cc.p(0, 0.5))
		var_46_5:setFontName("fonts/new.ttf")
		var_46_5:setPlaceholderFont("fonts/new.ttf", 28)
		var_46_5:setFontSize(28)
		var_46_5:setFontColor(cc.c3b(255, 255, 255))
		var_46_5:setPlaceHolder("")
		var_46_5:setPlaceholderFontColor(cc.c3b(100, 100, 100))
		var_46_5:setMaxLength(30)
		var_46_5:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
		var_46_5:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
		var_46_5:setInputFlag(cc.EDITBOX_INPUT_FLAG_INITIAL_CAPS_WORD)
		var_46_4:addChild(var_46_5, 5)
	end

	var_46_5:setText(playermodel.signment)
	ccui.Helper:seekWidgetByName(var_46_2, "button_confirm"):addTouchEventListener(function(arg_49_0, arg_49_1)
		if arg_49_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_49_0 = var_46_5:getText()

		if utfstrlen(var_49_0) > 20 then
			global_ShowBlockWords(L_SIGNATURE_WARNING.Sign_Out_Length)

			return
		else
			if var_49_0 == "" then
				self.signature_label:setString(L_SIGNATURE_WARNING.Sign_Box_Nil)
			elseif self:checkmsg(var_49_0) then
				require("network.network"):rpc("set_signment", {
					msg = var_49_0
				}, function(arg_50_0)
					if arg_50_0.result == 1 then
						self.signature_label:setString(var_49_0)
						self.signature_label:setColor(cc.c3b(245, 244, 244))

						playermodel.signment = var_49_0
					else
						print("set signment failed !!!!!!!")
					end
				end)
			else
				global_ShowBlockWords(L_SIGNATURE_WARNING.Sign_Sensitive)

				return
			end

			if var_46_0 ~= self.signature_label:getString() then
				AnalyticManager.changeSign()
			end
		end

		global_window_close_action(var_46_2:getChildByName("box"), function()
			var_46_1:runAction(cc.RemoveSelf:create())
		end)
	end)
	ccui.Helper:seekWidgetByName(var_46_2, "box"):addTouchEventListener(function(arg_52_0, arg_52_1)
		return
	end)
	LayerManager:createFullScreenMask(var_46_1, 180, function(arg_47_0, arg_47_1)
		if arg_47_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_window_close_action(var_46_2:getChildByName("box"), function()
			var_46_1:runAction(cc.RemoveSelf:create())
		end)
	end)
end

function ClassupdateLayer.changeMedal(arg_53_0, arg_53_1)
	local var_53_0
	local var_53_1

	if playermodel.cur_medal[arg_53_1] and playermodel.cur_medal[arg_53_1] ~= 0 then
		var_53_0 = {
			playermodel.cur_medal[arg_53_1]
		}
		var_53_1 = {
			goto_back_system_id = 120,
			itemtype = kITEM_MEDAL
		}
	end

	var_53_1.itemConditions = {}
	var_53_1.usedItem = var_53_0
	var_53_1.callbacklist = {
		used = function(arg_54_0)
			if arg_54_0 == 1 then
				AnalyticManager.changeMedal()
				arg_53_0:updateMedalInfo()
			else
				global_ShowBlockWords(L_MEDAL_WARNING.Set_Failed)
			end

			LayerManager:removePopLayer()
		end,
		unused = function(arg_55_0)
			if arg_55_0 == 1 then
				AnalyticManager.changeMedal()
				arg_53_0:updateMedalInfo()
			else
				global_ShowBlockWords(L_MEDAL_WARNING.Set_Failed)
			end

			LayerManager:removePopLayer()
		end,
		cancelcallback = function()
			TopcostLayer.getInstance():hideTopcostLayer()
		end
	}
	var_53_1.paneltype = ITEMPANEL_TYPE_MEDAL
	var_53_1.pos = arg_53_1

	LayerManager:pushInLayer("PopMedalSelectLayer", var_53_1)
end

function ClassupdateLayer:updateMedalInfo()
	for iter_57_0 = 1, 3 do
		if playermodel.cur_medal[iter_57_0] and playermodel.cur_medal[iter_57_0] ~= 0 then
			if not self.medal[iter_57_0]:getChildByName("medalname") then
				local var_57_0 = cc.Label:createWithTTF("", FONT_DES, 54)

				var_57_0:setAnchorPoint(cc.p(0.5, 0.5))
				var_57_0:setName("medalname")
				self.medal[iter_57_0]:addChild(var_57_0)
			end

			local var_57_1 = item_data[playermodel.cur_medal[iter_57_0]]

			self.medal[iter_57_0]:loadTexture((item_data[playermodel.cur_medal[iter_57_0]].bg or nil) and ("equipment/" .. var_57_1.bg .. ".png" or var_0_21[var_57_1.equip_quality]))
			self.medal[iter_57_0]:getChildByName("medalname"):setPosition(cc.p(49, 39))
			self.medal[iter_57_0]:getChildByName("medalname"):setString(var_57_1.name)
			self.medal[iter_57_0]:getChildByName("medalname"):enableOutline(var_0_22[var_57_1.equip_quality], 1)
			self.medal[iter_57_0]:getChildByName("medalname"):enableShadow(var_0_22[var_57_1.equip_quality], cc.size(0, 0))
			self.medal[iter_57_0]:getChildByName("medalname"):setVisible(var_57_1.only_bg ~= 1)
		else
			if self.medal[iter_57_0]:getChildByName("medalname") then
				self.medal[iter_57_0]:removeChildByName("medalname")
			end

			self.medal[iter_57_0]:loadTexture("equipment/medal_add.png")
		end
	end
end

function ClassupdateLayer:update()
	self.name_label:setString(playermodel.nickname)
	global_classup_level_label:setString("等级." .. playermodel.grade - (playermodel.class - 1) * 100)

	local var_58_0 = playermodel.exp / (playermodel.totalexp or grade_exp_data[playermodel.grade].exp)

	if var_58_0 > 1 then
		var_58_0 = 1
	end

	self.EXP_progress:setPercent(var_58_0 * 100)
	self:updateExpLabel()
	self.class:setPositionX(self.class:getPositionX() + 22)
	self.class:loadTexture(var_0_18[playermodel.class], config._DEBUG and 0 or 1)

	local var_58_1 = 0

	require("controller.scorearena_manager"):get_player_scorearena_data(function(arg_59_0)
		if tolua.isnull(self) then
			return
		end

		var_58_1 = var_58_1 + 1
		self.arenaScore = arg_59_0.score

		if var_58_1 >= 2 then
			self:updatePlayerBasicInfo()
		end
	end)
	require("network.network"):rpc("get_player_arenatft_info", nil, function(arg_60_0)
		var_58_1 = var_58_1 + 1
		self.succscore = arg_60_0.succscore

		if var_58_1 >= 2 then
			self:updatePlayerBasicInfo()
		end
	end)
end

function ClassupdateLayer:updateExpLabel()
	self.exp_label:setString(playermodel.exp .. "/" .. (playermodel.totalexp or grade_exp_data[playermodel.grade].exp))
end

function ClassupdateLayer.upPlayerClassAni(arg_62_0)
	local var_62_0 = ccui.Layout:create()

	var_62_0:setTouchEnabled(true)
	var_62_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_62_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_62_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2))
	var_62_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_62_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_62_0:setBackGroundColorOpacity(180)
	cc.Director:getInstance():getRunningScene():addChild(var_62_0, 10000)
	var_62_0:addChild((armature_manager:createAndPlayArmature("playerUpClass", {
		grade1 = var_0_18[playermodel.class - 1],
		grade2 = var_0_18[playermodel.class]
	}, {})))
	var_62_0:runAction(cc.Sequence:create(cc.DelayTime:create(10), cc.RemoveSelf:create()))
	var_62_0:addTouchEventListener(function(arg_63_0, arg_63_1)
		if arg_63_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_62_0:runAction(cc.RemoveSelf:create())
	end)
end

function ClassupdateLayer.checkmsg(arg_64_0, arg_64_1)
	if arg_64_1 == "刁大大" or arg_64_1 == "招嫖" then
		return false
	end

	if SensitiveChecker then
		return SensitiveChecker.censorStr(arg_64_1) ~= nil
	else
		return global_is_words_pass_against(arg_64_1)
	end
end

function ClassupdateLayer:bindAccount2Phone()
	if account_manager:isPlayerBindPhone() then
		global_ShowBlockWords(L_LOGIN_REGIST_WARNING.PhoneNum_Warning[1] .. "~~~")

		return
	end

	require("view.Layer.BindphoneLayer")
	self:addChild(BindphoneLayer:create(function()
		if account_manager:isPlayerBindPhone() then
			self.phone_label:setString(cryptphonenum(account_manager:getBindedPhone()))
			self.bindPhone:setVisible(false)
		else
			self.phone_label:setString(L_LOGIN_REGIST_WARNING.PhoneNum_Warning[4])
			self.bindPhone:setVisible(true)
		end
	end), 10)
end

function ClassupdateLayer.cdkCharge(arg_67_0)
	global_ShowBlockWords(L_CDK_WARNING.Use_Failed)
end

function ClassupdateLayer:updatePlayerBasicInfo()
	local var_68_0 = {
		{
			icon = cc.p(88, 50),
			finish_icon = cc.p(465, 50),
			data = cc.p(292, 50)
		},
		{
			sign_icon = cc.p(16, 50),
			content_bg = cc.p(315, 50)
		}
	}
	local var_68_1 = {
		function()
			local var_69_0 = {}

			table.insert(var_69_0, {
				icon = "Class/girls.png",
				str = L_PLAYER_DATA_TYPE.Girls,
				data = playermodel:getHavedServantNum() .. "/" .. playermodel:getTotalServantNum()
			})

			return var_69_0
		end,
		function()
			local var_70_0 = {}
			local photofile_HelpGirl_data = require("data.photofile_HelpGirl_data")

			table.insert(var_70_0, {
				icon = "Class/horcrux.png",
				str = L_PLAYER_DATA_TYPE.Horcrux,
				data = (function()
					local var_71_0 = 0
					local var_71_1 = {}

					for iter_71_0, iter_71_1 in pairs(playermodel.items) do
						if iter_71_1.itemtype == kITEM_HORCRUX and not var_71_1[var_0_5[iter_71_1.itemid].horcruxtype] then
							var_71_1[var_0_5[iter_71_1.itemid].horcruxtype] = true
							var_71_0 = var_71_0 + 1
						end
					end

					return var_71_0
				end)() .. "/" .. (function()
					local var_72_0 = 0

					for iter_72_0, iter_72_1 in pairs(photofile_HelpGirl_data) do
						if not var_70_0[var_0_5[iter_72_1.item_id].horcruxtype] then
							var_70_0[var_0_5[iter_72_1.item_id].horcruxtype] = true
							var_72_0 = var_72_0 + 1
						end
					end

					return var_72_0
				end)()
			})

			return var_70_0
		end,
		function()
			local var_73_0 = {}

			table.insert(var_73_0, {
				icon = "Class/weapons.png",
				str = L_PLAYER_DATA_TYPE.Weapons,
				data = (function()
					local var_74_0 = 0
					local var_74_1 = {}

					for iter_74_0, iter_74_1 in pairs(playermodel.items) do
						if iter_74_1.itemtype == kITEM_WEAPON and not var_74_1[iter_74_1.itemid] and not weapon_data[iter_74_1.itemid].linkage then
							var_74_1[iter_74_1.itemid] = true
							var_74_0 = var_74_0 + 1
						end
					end

					return var_74_0
				end)() .. "/" .. playermodel:getTotalServantNum()
			})

			return var_73_0
		end,
		function()
			local var_75_0 = {}

			table.insert(var_75_0, {
				icon = "Class/diamond.png",
				str = L_PLAYER_DATA_TYPE.Accumulate_Diamond,
				data = global_trans_number(playermodel.diamond)
			})

			return var_75_0
		end,
		function()
			local var_76_0 = {}

			table.insert(var_76_0, {
				icon = "Class/spcial.png",
				str = L_PLAYER_DATA_TYPE.SpecailJumpTower,
				data = playermodel.levelmode[501].status - 1 .. L_LEVEL
			})

			return var_76_0
		end,
		function()
			local var_77_0 = {}

			table.insert(var_77_0, {
				icon = "Class/arena.png",
				str = L_PLAYER_DATA_TYPE.ArenaScore,
				data = self.arenaScore
			})

			return var_77_0
		end,
		function()
			local var_78_0 = {}

			table.insert(var_78_0, {
				icon = "Class/succ.png",
				str = L_PLAYER_DATA_TYPE.TVTScore,
				data = self.succscore
			})

			return var_78_0
		end
	}

	local function var_68_2(arg_82_0, arg_82_1)
		local var_82_0 = arg_82_1 <= #var_68_1
		local var_82_1 = ccui.Layout:create()

		;(nil):setContentSize(cc.size(593, 100))

		if var_82_0 then
			local var_82_3 = ccui.ImageView:create("Class/progress_msg_bg.png", var_0_16)

			var_82_3:setPosition(var_68_0[2].content_bg)
			var_82_1:addChild(var_82_3)

			for iter_82_0, iter_82_1 in ipairs(arg_82_0) do
				local var_82_4 = ccui.ImageView:create("Class/dot_light.png", var_0_16)
				local var_82_5 = cc.Label:createWithTTF(iter_82_1.str, FONT_NAME, 22)
				local var_82_6 = ccui.ImageView:create(iter_82_1.icon, var_0_16)
				local var_82_7 = cc.Label:createWithTTF(iter_82_1.data, FONT_NAME, 22)

				if iter_82_1.str == L_PLAYER_DATA_TYPE.Accumulate_Diamond then
					self.diamod_gain_label = var_82_7
				end

				var_82_5:setColor(cc.c3b(163, 177, 212))
				var_82_7:setColor(cc.c3b(32, 205, 255))
				var_82_4:setPosition(var_68_0[2].sign_icon)
				var_82_6:setPosition(var_68_0[1].icon)
				var_82_5:setPosition(var_68_0[1].data)
				var_82_7:setPosition(var_68_0[1].finish_icon)
				var_82_1:addChild(var_82_4)
				var_82_3:addChild(var_82_6)
				var_82_3:addChild(var_82_5)
				var_82_3:addChild(var_82_7)
			end
		else
			local var_82_9
			local var_82_10 = ccui.ImageView:create("Class/progress_msg_bg.png", var_0_16)

			;(nil):setPosition(var_68_0[2].content_bg)
			var_82_1:addChild(var_82_10)

			var_82_9 = string.sub(arg_82_0.str, -6) == L_MODE_DIFFICULTY[4] and ccui.ImageView:create("Class/Level_nightmare.png", var_0_16) or string.sub(arg_82_0.str, -6) == L_MODE_DIFFICULTY[3] and ccui.ImageView:create("Class/Level_hell.png", var_0_16) or string.sub(arg_82_0.str, -6) == L_MODE_DIFFICULTY[2] and ccui.ImageView:create("Class/Level_difficult.png", var_0_16) or ccui.ImageView:create("Class/Level_simple.png", var_0_16)

			var_82_9:setAnchorPoint(cc.p(0, 1))
			var_82_9:setPosition(cc.p(4, var_82_10:getContentSize().height))
			var_82_9:setLocalZOrder(5)
			var_82_10:addChild(var_82_9)

			local var_82_11 = ccui.ImageView:create(arg_82_0.img, var_0_16)
			local var_82_12 = ccui.ImageView:create(arg_82_0.sign_icon, var_0_16)
			local var_82_13 = ccui.ImageView:create(arg_82_0.icon)
			local var_82_14 = cc.Label:createWithTTF(arg_82_0.str, FONT_NAME, 22)
			local var_82_15

			if arg_82_0.img then
				var_82_15 = ccui.ImageView:create(arg_82_0.img, var_0_16) or cc.Label:createWithTTF(arg_82_0.data, FONT_NAME, 22)
			end

			var_82_14:setColor(cc.c3b(163, 177, 212))
			var_82_15:setColor(cc.c3b(32, 205, 255))
			var_82_13:setPosition(var_68_0[1].icon)
			var_82_14:setPosition(var_68_0[1].data)
			var_82_11:setPosition(var_68_0[1].finish_icon)
			var_82_15:setPosition(var_68_0[1].finish_icon)
			var_82_12:setPosition(var_68_0[2].sign_icon)
			var_82_1:addChild(var_82_12)
			var_82_10:addChild(var_82_13)
			var_82_10:addChild(var_82_14)
			var_82_10:addChild(var_82_11)
			var_82_10:addChild(var_82_15)
		end

		self.tasklist:pushBackCustomItem(var_82_1)
	end

	self.tasklist:setItemsMargin(16)

	for iter_68_0, iter_68_1 in ipairs(var_68_1) do
		local var_68_3 = var_68_2(iter_68_1(), iter_68_0)
	end

	for iter_68_2, iter_68_3 in ipairs(((function()
		local function var_79_0(arg_80_0)
			local var_80_0 = {
				L_MODE_DIFFICULTY[1],
				"·" .. L_MODE_DIFFICULTY[2],
				"·" .. L_MODE_DIFFICULTY[3],
				"·" .. L_MODE_DIFFICULTY[4]
			}

			for iter_80_0 = 1, #var_80_0 do
				if arg_80_0 == city_data[levelmode_data[arg_80_0].city]["difficulty" .. iter_80_0] then
					return var_80_0[iter_80_0]
				end
			end

			return ""
		end

		local function var_79_1(arg_81_0)
			while city_data[levelmode_data[arg_81_0].city]["difficulty" .. 1] do
				if city_data[levelmode_data[arg_81_0].city]["difficulty" .. 1] == arg_81_0 then
					return true
				end
			end

			return false
		end

		local var_79_2 = {}

		for iter_79_0, iter_79_1 in pairs(levelmode_data) do
			local var_79_3 = iter_79_0

			if iter_79_1.modetype == 1 and level_manager:isMainLevel(var_79_3) and not level_manager:isModeManualLocked(var_79_3) and var_79_1(var_79_3) then
				local var_79_4
				local var_79_5
				local var_79_6

				if not level_manager:isModeValid(var_79_3) then
					var_79_4 = "Class/unfinish.png"
					var_79_6 = "Class/dot_dark.png"
				elseif level_manager:isLevelModePass(var_79_3) then
					var_79_4 = "Class/finish.png"
					var_79_6 = "Class/dot_light.png"
				else
					var_79_5 = chapter_data[var_79_3 .. "-" .. playermodel.levelmode[var_79_3].status].name, level_manager:isChapterModeValid(var_79_3, playermodel.levelmode[var_79_3].status)
					var_79_6 = "Class/dot_light.png"
				end

				if var_79_3 ~= 24 then
					table.insert(var_79_2, {
						img = var_79_4,
						sign_icon = var_79_6,
						str = levelmode_data[var_79_3].name .. var_79_0(var_79_3),
						icon = "mainScenebg/task_img/old_" .. levelmode_data[var_79_3].city .. ".png",
						data = var_79_5
					})
				end
			end
		end

		return var_79_2
	end)())) do
		-- block empty
	end

	;(nil):setContentSize(cc.size(593, 70))
	self.tasklist:pushBackCustomItem((ccui.Layout:create()))
	playermodel:getGainGoldDiamond(function(arg_83_0)
		if ClassupdateLayer.getInstance() then
			self.diamod_gain_label:setString(global_trans_number(arg_83_0.gain_diamond))
		end
	end)
end

function ClassupdateLayer:fullScreen()
	local var_84_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Bottom_bg_0")

	var_84_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_84_0:getPositionY(), TRANSFORM_UNIT.PX)

	var_84_0:setPositionY(var_84_0.full_posY)

	local var_84_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_32")

	var_84_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - var_84_1:getPositionY(), TRANSFORM_UNIT.PX)

	var_84_1:setPositionY(var_84_1.full_posY)

	local var_84_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_33")

	var_84_2.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - var_84_2:getPositionY(), TRANSFORM_UNIT.PX)

	var_84_2:setPositionY(var_84_2.full_posY)

	local var_84_3 = ccui.Helper:seekWidgetByName(var_84_2, "sideline")

	var_84_3:setScale9Enabled(true)
	var_84_3:setContentSize(cc.size(var_84_3:getContentSize().width, var_84_3:getContentSize().height + GameDisplay.height - 1136))
	var_84_3:setPosition(cc.p(var_84_3:getPositionX(), var_84_3:getPositionY() - (GameDisplay.height - 1136) / 2))

	local var_84_4 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_36")

	var_84_4.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - var_84_4:getPositionY(), TRANSFORM_UNIT.PX)

	var_84_4:setPositionY(var_84_4.full_posY)

	local var_84_5 = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_52")

	var_84_5.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, 1136 - var_84_5:getPositionY(), TRANSFORM_UNIT.PX)

	var_84_5:setPositionY(var_84_5.full_posY)

	local var_84_6 = ccui.Helper:seekWidgetByName(var_84_5, "list_bg")

	var_84_6:setScale9Enabled(true)
	var_84_6:setContentSize(cc.size(var_84_6:getContentSize().width, var_84_6:getContentSize().height + GameDisplay.height - 1136))
	var_84_6:setPosition(cc.p(var_84_6:getPositionX(), var_84_6:getPositionY() - (GameDisplay.height - 1136) / 2))
	self.tasklist:setContentSize(cc.size(self.tasklist:getContentSize().width, self.tasklist:getContentSize().height + GameDisplay.height - 1136))
	self.tasklist:setPosition(cc.p(self.tasklist:getPositionX(), self.tasklist:getPositionY() - (GameDisplay.height - 1136)))
end
