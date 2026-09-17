SkinShowPopLayer = class("SkinShowPopLayer", (require("view.Layer.BaseUILayer")))

local texture_manager = require("controller.texture_manager")
local shop_manager = require("controller.shop_manager")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local weapon_manager = require("controller.weapon_manager")
local alert_manager = require("controller.alert_manager")
local network = require("network.network")
local component_manager = require("controller.component_manager")
local audio_manager = require("controller.audio_manager")
local drop_manager = require("controller.drop_manager")
local share_manager = require("controller.share_manager")
local time_check_manager = require("controller.time_check_manager")
local level_manager = require("controller.level_manager")
local armature_manager = require("controller.armature_manager")
local diamond_update_data = require("data.diamond_update_data")
local model_data = require("data.model_data")
local favorfile_data = require("data.favorfile_data")
local component_effect_data = require("data.component_effect_data")
local discount_manager = require("controller.discount_manager")
local shop_data = require("data.shop_data")
local activity_manager = require("controller.activity_manager")
local community_system_manager = require("controller.community_system_manager")
local device_manager = require("controller.device_manager")
local major_factor_data = require("data.major_factor_data")
local furnituresuit_data = require("data.furnituresuit_data")
local servant_data = require("data.servant_data")
local hexie_manager = require("controller.hexie_manager")
local var_0_29 = require("data.major_factor_data")
local test_fight_manager = require("controller.test_fight_manager")
local Utility = require("common.Utility")
local RichTextPro = require("view.Sprite.RichTextPro")
local channe_url_data = require("data.channe_url_data")
local account_manager = require("controller.account_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local TempWidget = require("view.Sprite.TempWidget")

require("view.Layer.BackGroundLayer")

local SkinShowSoulList = require("view.Sprite.SkinShowSoulList")
local var_0_38 = config._DEBUG and 0 or 1
local var_0_39 = "SkinShowPopLayer/"
local var_0_40 = {}

function SkinShowPopLayer:ctor()
	SkinShowPopLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller/skin_show_manager"):getInstance()
end

function SkinShowPopLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SkinShowPopLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function SkinShowPopLayer:onEnter()
	SkinShowPopLayer.super.onEnter(self)
	activity_manager:registerEventListener("SkinShowPopLayer", activity_manager.activityEventId.CHANGE_TEST_A_FIGHT_ARRAY_SUCCESS, function(arg_4_0)
		LayerManager:pushInLayer("TestFightLayer")
	end)
	activity_manager:registerEventListener("SkinShowPopLayer", activity_manager.activityEventId.CHANGE_TEST_P_FIGHT_ARRAY_SUCCESS, function(arg_5_0)
		return
	end)
	activity_manager:registerEventListener("SkinShowPopLayer", activity_manager.activityEventId.ACTIVITY_DRESS_ONE_KEY, function(arg_6_0)
		self:changeSoulDressSuccess()
	end)
	activity_manager:registerEventListener("SkinShowPopLayer", activity_manager.activityEventId.SETTING_L2D, function(arg_7_0)
		self:onPreviewL2D(arg_7_0)
	end)
	self.manager:requestInfo()
end

function SkinShowPopLayer:onExit()
	SkinShowPopLayer.super.onExit(self)
	activity_manager:releaseEventListenerByName("SkinShowPopLayer")
	self.manager:cleanData()
end

function SkinShowPopLayer:init(arg_9_1)
	self:initData(arg_9_1)
	self:initLayer()
	self:initListener()

	return true
end

function SkinShowPopLayer:initData(arg_10_1)
	self._intoModelId = arg_10_1.modelId
	self._curSelectModelId = arg_10_1.modelId
	self._soulId = model_data[self._intoModelId].major
	self._servantId = major_factor_data[model_data[self._intoModelId].major].servant
	self._dressList = self.manager:getSoulDresses(self._soulId, self._servantId)
	self._curSelectIndex = nil
	self._previewType = arg_10_1.previewType
	self._havehideui = false

	if arg_10_1.buyInfo then
		self._defaultShopItem = arg_10_1.buyInfo._data
		self._defaultShopType = arg_10_1.buyInfo._selectedType
	end

	for iter_10_0 = 1, #self._dressList do
		if self._dressList[iter_10_0].modelId == self._curSelectModelId then
			self._curSelectIndex = iter_10_0

			break
		end
	end
end

function SkinShowPopLayer:initLayer()
	local var_11_0 = TempWidget:CreateTempLayout(self)

	var_11_0:setContentSize(GameDisplay.getUiScreenSize())
	var_11_0:_setBack()
	var_11_0:_addEvent(function()
		print("点击了背景")
	end)

	self._root = var_11_0

	local var_11_1 = TempWidget:CreateTempLayout(var_11_0)

	var_11_1:setContentSize(var_11_0:size())

	self._backGroundLayout = var_11_1

	self:initBackGroundLayout()

	local var_11_2 = TempWidget:CreateTempLayout(var_11_0)

	var_11_2:setContentSize(var_11_0:size())
	var_11_2:setLocalZOrder(1)

	self._uiLayout = var_11_2

	local var_11_3 = TempWidget:CreateTempLayout(var_11_0)

	var_11_3:setContentSize(var_11_0:size())

	self._showGirlLayout = var_11_3

	self:initShowGirlLayout()
	TempWidget:CreateTempImg(var_0_39 .. "bottom_bg.png", var_11_2):align(cc.p(0.5, 0), var_11_2:size().width * 0.5, 0)
	self:initGirlInfo()
	self:initTaoBao()

	local var_11_4 = SkinShowSoulList:create()

	var_11_4:setScale(0.8)
	var_11_4:setPosition(GameDisplay.width / 2 - 75, 90)
	var_11_2:addChild(var_11_4)

	self._skinShowSoulList = var_11_4

	local var_11_5 = TempWidget:CreateTempLayout(var_11_2)

	var_11_5:setContentSize(cc.size(var_11_2:getContentSize().width, var_11_4:getContentSize().height * var_11_4:getScale()))
	var_11_5:move(0, var_11_4:getPositionY())
	var_11_5:setLocalZOrder(var_11_4:getLocalZOrder() - 1)
	var_11_5:_addEvent(function()
		return
	end)

	self._headLayoutTable = {}

	for iter_11_0 = 1, #self._dressList do
		local var_11_6 = self:createGirlHeadLayout(iter_11_0)

		table.insert(self._headLayoutTable, var_11_6)
		var_11_4:pushInCity(var_11_6)
	end

	for iter_11_1 = 1, #self._dressList do
		if self._intoModelId == self._dressList[iter_11_1].modelId then
			self._skinShowSoulList:scrollToIndex(iter_11_1)

			break
		end
	end

	var_11_4:registerSelectCityHandler(function(arg_14_0)
		self._curSelectModelId = self._dressList[arg_14_0].modelId
		self._curSelectIndex = arg_14_0

		self:updateHeadLayout()
		self:updateSureBtn()
		self:updateApplyBtn()
		self:updateBackGroundLayout()
		self:updateShowGirlLayout()
		self:updateGirlInfo()
	end)
	var_11_4:updateCitiesProperties()

	local var_11_7 = TempWidget:CreateTempBtn(var_0_39 .. "sure_btn.png", var_11_2)

	var_11_7:align(cc.p(0.5, 0), var_11_2:size().w / 2, 5)

	self._sureBtn = var_11_7

	local var_11_8 = TempWidget:CreateTempLabel("", FONT_NAME, 27, var_11_7:getVirtualRenderer())

	var_11_8:center()

	self._sureBtnText = var_11_8

	self:updateSureBtn()

	local var_11_9 = TempWidget:CreateTempBtn(var_0_39 .. "apply_btn.png", var_11_2)

	var_11_9:align(cc.p(1, 0), var_11_2:size().width - 5, var_11_7:pos().y)

	self._applyBtn = var_11_9

	local var_11_10 = TempWidget:CreateTempBtn(var_0_39 .. "back_btn.png", var_11_2)

	var_11_10:align(cc.p(0, 0), 5, var_11_7:pos().y)

	self._backBtn = var_11_10

	self:initShareLayout()
end

function SkinShowPopLayer:onPreviewL2D(arg_15_1)
	if self._previewType ~= "market" then
		return
	end

	if arg_15_1 == EVENT_SETTING_SHOWGIRL.LIVE2D_START then
		self:hideUI()
	elseif arg_15_1 == EVENT_SETTING_SHOWGIRL.LIVE2D_FINISH then
		self:showUI()
	end
end

function SkinShowPopLayer:hideUI()
	if self._havehideui then
		return
	end

	self._uiLayout:setVisible(false)
	self._uiLayout:setOpacity(0)

	self._havehideui = true
end

function SkinShowPopLayer:showUI()
	if self._uiLayout:isVisible() then
		return
	end

	self._uiLayout:setVisible(true)
	self._uiLayout:runAction(cc.FadeIn:create(0.5))
end

function SkinShowPopLayer:initGirlInfo()
	local var_18_1 = TempWidget:CreateTempImg(var_0_39 .. "name_bg.png", self._uiLayout)

	var_18_1:align(cc.p(0, 1), 10, self._uiLayout:size().h)
	TempWidget:CreateTempLabel(self._dressList[self._curSelectIndex].roleName, FONT_NAME, 35, var_18_1):align(cc.p(0.5, 0.5), var_18_1:size().w / 2, var_18_1:size().h / 2 - 5)
	TempWidget:CreateTempLabel(self._dressList[self._curSelectIndex].englishName, FONT_ARCHIVES, 19, var_18_1):align(cc.p(0.5, 0.5), var_18_1:size().w / 2, var_18_1:size().h / 2 + 26.5)

	local var_18_2 = TempWidget:CreateTempListView(self._uiLayout)

	var_18_2:setContentSize(cc.size(130, 200))
	var_18_2:align(cc.p(0, 1), 10, var_18_1:pos().y - var_18_1:size().h - 10)

	self._typeList = var_18_2

	local var_18_3 = TempWidget:CreateTempBtn(var_0_39 .. "screenshot_btn.png", self._uiLayout)

	var_18_3:align(cc.p(1, 1), self._uiLayout:size().w - 5, self._uiLayout:size().h - 5)

	self._screenshotBtn = var_18_3

	self:updateGirlInfo()
end

function SkinShowPopLayer:initTaoBao()
	local var_19_0 = account_manager:getChannel()
	local var_19_1 = TempWidget:CreateTempBtn(var_0_39 .. "taobao.png", self._uiLayout)

	print(var_19_0)
	print(channe_url_data[var_19_0])
	var_19_1:align(cc.p(1, 1), self._uiLayout:size().w - 115, self._uiLayout:size().h - 5)
	var_19_1:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		DeviceManager.openURL(channe_url_data[var_19_0].is_show_taobao or "https://item.taobao.com/item.htm?ft=t&id=67597948623")
	end)

	if not channe_url_data[var_19_0] or channe_url_data[var_19_0].is_show_taobao then
		var_19_1:setVisible(true)
	else
		var_19_1:setVisible(false)
	end
end

function SkinShowPopLayer:updateGirlInfo()
	local var_21_1 = self._typeList

	self._typeList:removeAllItems()

	local function var_21_2(arg_22_0)
		local var_22_0 = TempWidget:CreateTempLayout()

		var_22_0:setContentSize(cc.size(var_21_1:size().w, 67))
		TempWidget:CreateTempImg(var_0_39 .. arg_22_0, var_22_0):align(cc.p(0, 0.5), 0, var_22_0:size().h / 2)

		return var_22_0
	end

	if self._dressList[self._curSelectIndex].live2d then
		self._typeList:pushBackCustomItem(var_21_2("interact.png"))
	end

	if self._dressList[self._curSelectIndex].roleSpine then
		self._typeList:pushBackCustomItem(var_21_2("dynamic.png"))
	end
end

function SkinShowPopLayer:initBackGroundLayout()
	local var_23_1 = BackGroundLayer:create(model_data[self._intoModelId].backgroundid, (model_data[self._intoModelId].is_own_full_screen_background == 1 or nil) and 2)

	var_23_1:setPositionY(GameDisplay.fix_y)
	self._backGroundLayout:addChild(var_23_1)

	self._backGroundLayer = var_23_1
end

function SkinShowPopLayer:updateBackGroundLayout()
	if model_data[self._curSelectModelId].backgroundid then
		self._backGroundLayer:update(model_data[self._curSelectModelId].backgroundid, (model_data[self._curSelectModelId].is_own_full_screen_background == 1 or nil) and 2)
	end
end

function SkinShowPopLayer:initShowGirlLayout()
	local var_25_1 = ShowGirlLayer:create(self._intoModelId, 3, nil, function(arg_26_0)
		self:onPreviewL2D(arg_26_0)
	end, self._previewType == "market")

	var_25_1:setPosition(cc.p(0, GameDisplay.fix_y))

	self._showGirlLayer = var_25_1

	self._showGirlLayout:addChild(var_25_1)
	self:updateShowGirlTalkEnable()

	local var_25_2 = TempWidget:CreateTempLayout(self._showGirlLayout)

	var_25_2:setContentSize(self._showGirlLayout:size())
	var_25_2:setLocalZOrder(var_25_1:getLocalZOrder() + 1)

	local var_25_3 = cc.EventListenerTouchOneByOne:create()

	var_25_3:setSwallowTouches(false)
	var_25_3:registerScriptHandler(function(arg_27_0, arg_27_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_25_3:registerScriptHandler(function(arg_28_0, arg_28_1)
		self:showUI()

		if self._dressList[self._curSelectIndex].bHave then
			return true
		end

		var_0_40[playermodel.playerid] = var_0_40[playermodel.playerid] or setmetatable({}, {
			__index = function(arg_29_0, arg_29_1)
				return 0
			end
		})

		if var_0_40[playermodel.playerid][self._curSelectModelId] > PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT + 1 then
			if self._curSelectModelId == self._intoModelId then
				self._dressList[self._curSelectIndex].sureCallBack(self._defaultShopItem, self._defaultShopType)
			else
				self._dressList[self._curSelectIndex].sureCallBack()
			end

			return true
		elseif var_0_40[playermodel.playerid][self._curSelectModelId] >= PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT then
			var_0_40[playermodel.playerid][self._curSelectModelId] = var_0_40[playermodel.playerid][self._curSelectModelId] + 1

			global_ShowBlockWords(L_DORMROOM_SEND_GIFT.Interaciton_Used_Up)

			return false
		else
			return true
		end
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_25_2:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_25_3, var_25_2)
end

function SkinShowPopLayer:initShareLayout()
	local var_30_0 = TempWidget:CreateTempLayout(self._root)

	var_30_0:setContentSize(self._root:size())
	var_30_0:_setBack()
	var_30_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_30_0:setBackGroundColorOpacity(150)
	var_30_0:setLocalZOrder(self._uiLayout:getLocalZOrder() + 1)
	var_30_0:_addEvent(function(arg_31_0)
		arg_31_0:hide()
	end)
	var_30_0:hide()

	self._shareLayout = var_30_0

	local var_30_1 = TempWidget:CreateTempLayout(var_30_0)

	var_30_1:setContentSize(var_30_0:size())
	var_30_1:_setBack()
	var_30_1:setBackGroundColor(cc.c3b(255, 255, 255))
	var_30_1:align(cc.p(0.5, 0.5), var_30_0:size().w / 2, var_30_0:size().h / 2)
	var_30_1:setName("whiteLayout")

	local var_30_2 = TempWidget:CreateTempLayout(var_30_1)

	var_30_2:setBackGroundColorOpacity(50)
	var_30_2:setContentSize(cc.size(var_30_1:size().w, var_30_1:size().h * (1 - 0.92) - 30))

	local costume_room_show_manager = require("controller.costume_room_show_manager")
	local var_30_4 = costume_room_show_manager:getInstance():getShareRewardInfo()

	if next(costume_room_show_manager) then
		local var_30_5 = TempWidget:CreateTempLayout(var_30_2)

		var_30_5:setContentSize(cc.size(180, var_30_2:size().h))

		local var_30_6 = TempWidget:CreateTempImg(var_30_4.iconPath, var_30_5)

		var_30_6:move(var_30_5:size().w / 2 - 25, var_30_5:size().h / 2 + 15)

		local var_30_7 = TempWidget:CreateTempLabel(var_30_4.num or 0, FONT_NAME, 23, var_30_5)

		var_30_7:align(cc.p(0, 0.5), var_30_6:getPositionX() + var_30_6:size().w / 2, var_30_6:getPositionY())
		var_30_7:_setColor("#1c073b")

		local var_30_8 = TempWidget:CreateTempLabel("每周首次分享", FONT_NAME, 23, var_30_5)

		var_30_8:move(var_30_5:size().w / 2, var_30_5:size().h / 2 - 18)
		var_30_8:_setColor("#1c073b")
	end

	local var_30_9 = TempWidget:CreateTempLayout(var_30_2)

	var_30_9:setContentSize(cc.size(var_30_2:size().w - 150, var_30_2:size().h))
	var_30_9:align(cc.p(1, 0), var_30_2:size().w, 0)

	local var_30_11
	local var_30_10

	if not share_manager:can_share() then
		do return end

		var_30_10 = {
			{
				shareType = 3,
				path = var_0_39 .. "weibo.png"
			},
			{
				shareType = 2,
				path = var_0_39 .. "qq.png"
			},
			{
				shareType = 1,
				path = var_0_39 .. "wx_circle.png"
			},
			{
				shareType = 0,
				path = var_0_39 .. "wx_friend.png"
			}
		}
		var_30_11 = {}
	end

	for iter_30_0, iter_30_1 in pairs((share_manager:getShareChannelArr())) do
		if iter_30_0 == "weixinfriend" and iter_30_1 or iter_30_1 == "weixinfriend" then
			table.insert(var_30_11, var_30_10[4])
		elseif iter_30_0 == "weixingroup" and iter_30_1 or iter_30_1 == "weixingroup" then
			table.insert(var_30_11, var_30_10[3])
		elseif iter_30_0 == "qqfriend" and iter_30_1 or iter_30_1 == "qqfriend" then
			table.insert(var_30_11, var_30_10[2])
		elseif iter_30_0 == "weibo" and iter_30_1 or iter_30_1 == "weibo" then
			table.insert(var_30_11, var_30_10[1])
		end
	end

	for iter_30_2 = 1, #var_30_11 do
		local var_30_12 = TempWidget:CreateTempBtn(var_30_11[iter_30_2].path, var_30_9)

		var_30_12:_addEvent(function()
			var_30_12:setTouchEnabled(false)
			performWithDelay(var_30_12, function()
				var_30_12:setTouchEnabled(true)
			end, 2)

			if not share_manager:can_share() then
				return
			end

			share_manager:registerShareHandler(function(arg_34_0)
				if arg_34_0 == 0 then
					global_ShowBlockWords("分享成功")
					self.manager:shareSuccess()
				end
			end)
			share_manager:doChannelShare(var_30_11[iter_30_2].shareType, "养肝护肾，为AI发电！", self.outputFile, "快加入魂器学院吧")
		end)
		var_30_12:setScale(0.9)
		var_30_12:align(cc.p(1, 0.5), var_30_9:size().w - 50 - (4 - iter_30_2) * (var_30_12:size().w + 10), var_30_9:size().h / 2)
	end
end

function SkinShowPopLayer:updateShowGirlLayout()
	self._showGirlLayer:update(self._curSelectModelId)
	self:updateShowGirlTalkEnable()
end

function SkinShowPopLayer:updateShowGirlTalkEnable()
	local var_36_0 = playermodel.playerid
	local var_36_1 = self._dressList[self._curSelectIndex]
	local var_36_2 = self._showGirlLayer

	self._showGirlLayer._talksp = nil

	self._showGirlLayer:resetCurTalkConfig()

	var_0_40[playermodel.playerid] = var_0_40[playermodel.playerid] or setmetatable({}, {
		__index = function(arg_37_0, arg_37_1)
			return 0
		end
	})

	self._showGirlLayer:setTalkEnabled(self._dressList[self._curSelectIndex].bHave or var_0_40[playermodel.playerid][self._curSelectModelId] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	self._showGirlLayer:setTouchTalkCallback(function()
		var_0_40[var_36_0][self._curSelectModelId] = var_0_40[var_36_0][self._curSelectModelId] + 1

		var_36_2:setTalkEnabled(var_36_1.bHave or var_0_40[var_36_0][self._curSelectModelId] < PREVIEW_SHOWGIRL_MAX_TOUCH_COUNT)
	end)
end

function SkinShowPopLayer:initListener()
	self._sureBtn:_addEvent(function()
		if self._intoModelId == self._dressList[self._curSelectIndex].modelId then
			self._dressList[self._curSelectIndex].sureCallBack(self._defaultShopItem, self._defaultShopType)
		else
			self._dressList[self._curSelectIndex].sureCallBack()
		end
	end)
	self._applyBtn:_addEvent(function()
		local var_41_1 = {
			{
				servantid = 203020
			},
			{},
			{},
			{},
			{}
		}

		var_41_1[1].modelid = servant_data[var_41_1[1].servantid].modelid

		test_fight_manager:changeTestFightArray(var_41_1, {
			{
				servantid = major_factor_data[model_data[self._curSelectModelId].major].servant,
				modelid = self._curSelectModelId
			},
			{},
			{},
			{},
			{}
		})
	end)
	self._applyBtn:setVisible(false)
	self._backBtn:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self._screenshotBtn:_addEvent(function()
		self:showShareLayout()
	end)
end

function SkinShowPopLayer:createGirlHeadLayout(arg_44_1)
	local var_44_0 = TempWidget:CreateTempLayout()

	var_44_0:setContentSize(cc.size(190, 370))

	local var_44_1 = TempWidget:CreateTempImg(var_0_39 .. "head_bg.png", var_44_0)

	var_44_1:setScale9Enabled(true)
	var_44_1:setCapInsets(cc.rect(10, 10, var_44_1:size().w - 20, var_44_1:size().h - 20))
	var_44_1:setContentSize(cc.size(var_44_0:size().w, var_44_0:size().h))
	var_44_1:center()

	local var_44_2 = TempWidget:CreateTempImg("roleimage/role/shop_image/" .. model_data[tostring(self._dressList[arg_44_1].modelId)].role_image .. ".png", var_44_0, 0)

	var_44_2:setScale9Enabled(true)
	var_44_2:setCapInsets(cc.rect(10, 10, var_44_2:size().w - 20, var_44_2:size().h - 20))
	var_44_2:setContentSize(cc.size(var_44_0:size().w - 20, var_44_0:size().h - 20))
	var_44_2:move(var_44_0:size().w / 2, var_44_0:size().h / 2 + 3)

	local var_44_3 = TempWidget:CreateTempImg(var_0_39 .. "unclose_Img.png", var_44_0)

	var_44_3:setVisible(self._dressList[arg_44_1].uncolorClothes)
	var_44_3:align(cc.p(1, 1), var_44_0:size().w, var_44_0:size().h + 10)

	local var_44_5 = TempWidget:CreateTempImg((self._dressList[arg_44_1].bDress or nil) and var_0_39 .. "head_bottom_in.png", var_44_0)

	var_44_5:align(cc.p(0.5, 0), var_44_0:size().w / 2, 12)
	var_44_5:setScale(1.2)
	var_44_5:setName("headBottomStateImg")

	local var_44_6 = TempWidget:CreateTempLabel(self._dressList[arg_44_1].mainName, FONT_NAME, 20, var_44_5)

	var_44_6:setName("nameText")
	var_44_6:align(cc.p(0.5, 0), var_44_5:size().w / 2, 10)

	local var_44_7 = TempWidget:CreateTempImg(var_0_39 .. "head_type.png", var_44_2)

	var_44_7:align(cc.p(0, 1), -5, var_44_2:size().h - 5)
	var_44_7:hide()

	local var_44_8 = TempWidget:CreateTempLabel("", FONT_NAME, 25, var_44_7)

	var_44_8:center()

	if self._dressList[arg_44_1].groupName then
		var_44_7:show()
		var_44_8:setString(self._dressList[arg_44_1].groupName)
	end

	local var_44_9 = TempWidget:CreateTempBtn(nil, var_44_0)

	var_44_9:ignoreContentAdaptWithSize(false)
	var_44_9:setSwallowTouches(false)
	var_44_9:setContentSize(var_44_0:size())
	var_44_9:center()
	var_44_9:_addEvent(function()
		self._skinShowSoulList:scrollToIndex(arg_44_1)
	end)

	local var_44_10 = TempWidget:CreateTempLayout(var_44_0)

	var_44_10:setName("maskLayout")
	var_44_10:_setBack()
	var_44_10:setContentSize(cc.size(var_44_0:size().w - 15, var_44_0:size().h - 12))
	var_44_10:setBackGroundColor(cc.c3b(0, 0, 0))
	var_44_10:setBackGroundColorOpacity(100)
	var_44_10:setVisible(self._curSelectModelId ~= self._dressList[arg_44_1].modelId)
	var_44_10:align(cc.p(0.5, 0.5), var_44_0:size().w / 2, var_44_0:size().h / 2 + 2)

	return var_44_0
end

function SkinShowPopLayer.updateLayer(arg_46_0)
	return
end

function SkinShowPopLayer.updateRed(arg_47_0)
	return
end

function SkinShowPopLayer:updateHeadLayout()
	for iter_48_0 = 1, #self._headLayoutTable do
		local var_48_0 = ui_delegate(self._headLayoutTable[iter_48_0])

		var_48_0.maskLayout:setVisible(self._curSelectModelId ~= self._dressList[iter_48_0].modelId)
		var_48_0.headBottomStateImg:loadTextureEx((self._dressList[iter_48_0].bDress or nil) and var_0_39 .. "head_bottom_in.png")
	end
end

function SkinShowPopLayer:updateSureBtn()
	for iter_49_0 = 1, #self._dressList do
		if self._curSelectModelId == self._dressList[iter_49_0].modelId then
			self._sureBtn:loadTextureNormal(self._dressList[iter_49_0].btnPath, var_0_38)
			self._sureBtnText:setString(self._dressList[iter_49_0].btnStr)
			self._sureBtnText:_setColor(self._dressList[iter_49_0].btnStrColor)

			break
		end
	end
end

function SkinShowPopLayer:updateApplyBtn()
	self._applyBtn:setVisible(false)
end

function SkinShowPopLayer:exitMarryPopLayer()
	self._dressList = self.manager:getSoulDresses(self._soulId, self._servantId)

	self:updateSureBtn()
end

function SkinShowPopLayer:buySuccess()
	self._dressList = self.manager:getSoulDresses(self._soulId, self._servantId)

	self:updateSureBtn()
end

function SkinShowPopLayer:changeSoulDressSuccess()
	self._dressList = self.manager:getSoulDresses(self._soulId, self._servantId)

	self:updateSureBtn()
	self:updateHeadLayout()
end

function SkinShowPopLayer:showShareLayout()
	local var_54_0 = self._shareLayout
	local var_54_1 = self._shareLayout:getChildByName("whiteLayout")
	local var_54_2 = self._uiLayout

	local function var_54_3(arg_55_0, arg_55_1)
		var_54_2:show()

		if arg_55_0 then
			if cc.Native.imageWriteToPhotosAlbum then
				if device_manager.platform == "android" then
					cc.Native:imageWriteToPhotosAlbum(arg_55_1, "CostumeSkin" .. os.date("%Y%m%d%H%M%S") .. ".png")
				else
					device_manager.imageWriteToPhotosAlbum(arg_55_1)
				end

				global_ShowBlockWords("保存成功")
			else
				print("没有" .. "cc.Native.imageWriteToPhotosAlbum")
			end

			if var_54_1:getChildByName("girlImg") then
				var_54_1:removeChildByName("girlImg")
			end

			cc.Director:getInstance():getTextureCache():removeTextureForKey(arg_55_1)

			self.outputFile = arg_55_1

			local var_55_0 = TempWidget:CreateTempImg(arg_55_1, nil, 0)

			var_55_0:setName("girlImg")
			var_55_0:align(cc.p(0.5, 1), var_54_1:size().w / 2, var_54_1:size().h - 30)
			var_55_0:setScale9Enabled(true)
			var_55_0:setCapInsets(cc.rect(0, 0, var_55_0:getContentSize().width, var_55_0:getContentSize().height))
			var_55_0:setContentSize(var_54_1:size())
			var_55_0:setScale(0.92)
			var_54_1:addChild(var_55_0)

			local var_55_1 = TempWidget:CreateTempImg(var_0_39 .. "name_bg.png", var_55_0)

			var_55_1:align(cc.p(0, 1), 10, var_55_0:size().h)
			TempWidget:CreateTempLabel(self._dressList[self._curSelectIndex].roleName, FONT_NAME, 35, var_55_1):align(cc.p(0.5, 0.5), var_55_1:size().w / 2, var_55_1:size().h / 2 - 5)
			TempWidget:CreateTempLabel("F i t t i n g  R o o m", FONT_ARCHIVES, 19, var_55_1):align(cc.p(0.5, 0.5), var_55_1:size().w / 2, var_55_1:size().h / 2 + 26.5)
			var_54_0:show()
			var_54_1:setScale(1)
			var_54_1:runAction(cc.ScaleTo:create(0.2, 0.88))
		else
			print("Capture screen failed.")
		end
	end

	;(function(arg_56_0, arg_56_1)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("cleanTouchEffect"))
		var_54_2:hide()

		local var_56_0 = time_check_manager:getCurTime()

		cc.utils:captureScreen(var_54_3, cc.FileUtils:getInstance():getWritablePath() .. "Horcrux_Skin_CaptureScreen.png")
	end)()
end

function SkinShowPopLayer:screen()
	local var_57_0 = self._uiLayout

	local function var_57_1(arg_58_0, arg_58_1)
		var_57_0:show()

		if arg_58_0 then
			if cc.Native.imageWriteToPhotosAlbum then
				device_manager.imageWriteToPhotosAlbum(arg_58_1)
				global_ShowBlockWords("保存成功")
			else
				print("没有 cc.Native.imageWriteToPhotosAlbum")
			end

			cc.Director:getInstance():getTextureCache():removeTextureForKey(arg_58_1)

			local var_58_0 = TempWidget:CreateTempImg(arg_58_1, nil, 0)

			var_58_0:setName("capSp")
			var_58_0:setScale9Enabled(true)
			var_58_0:setCapInsets(cc.rect(0, 0, var_58_0:getContentSize().width, var_58_0:getContentSize().height))
			var_58_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
			var_57_0:addChild(var_58_0, 99)
			var_58_0:setPosition(GameDisplay.cx, GameDisplay.cy)

			local var_58_1 = {}

			table.insert(var_58_1, (cc.Spawn:create(cc.ScaleTo:create(0.2, 0.2), cc.MoveTo:create(0.2, cc.p(GameDisplay.width - var_58_0:getContentSize().width * 0.2 / 2 - 10, GameDisplay.height - var_58_0:getContentSize().height * 0.2 / 2 - 17)))))
			table.insert(var_58_1, (cc.DelayTime:create(0.2)))

			local var_58_2 = cc.MoveBy:create(2, cc.p(0, 10))

			table.insert(var_58_1, (cc.Spawn:create(cc.Repeat:create(cc.Sequence:create(var_58_2, (var_58_2:reverse())), 4), (cc.Sequence:create(cc.DelayTime:create(4 * 2 - 1), cc.FadeOut:create(1), (cc.CallFunc:create(function()
				var_57_0:removeChildByName("capSp")
			end)))))))
			var_58_0:runAction((cc.Sequence:create(var_58_1)))
			var_58_0:_addEvent(function()
				var_58_0:stopAllActions()
				var_58_0:setOpacity(255)
				var_58_0:runAction(cc.Spawn:create(cc.ScaleTo:create(0.2, 1), cc.MoveTo:create(0.2, cc.p(GameDisplay.cx, GameDisplay.cy))))
				var_58_0:_addEvent(function()
					var_58_0:hide()
				end)
			end)
		else
			print("Capture screen failed.")
		end
	end

	;(function(arg_62_0, arg_62_1)
		cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("cleanTouchEffect"))
		var_57_0:removeChildByName("capSp")
		var_57_0:hide()

		local var_62_0 = time_check_manager:getCurTime()

		cc.utils:captureScreen(var_57_1, cc.FileUtils:getInstance():getWritablePath() .. "Horcrux_Skin_CaptureScreen.png")
	end)()
end

return SkinShowPopLayer
