PhotoFileLayer = class("PhotoFileLayer", function()
	return cc.Layer:create()
end)

require("data.constants")

local photo_manager = require("controller.photo_manager")
local var_0_1 = "file_player"
local var_0_2 = "file_teacher"
local var_0_3 = "file_weapon"
local major_factor_data = require("data.major_factor_data")
local var_0_5 = cc.rect(0, 5, 190, 332)
local var_0_7 = {}
local var_0_8 = config._DEBUG and 0 or 1
local photofile_enemy_data = require("data.photofile_enemy_data")
local model_data = require("data.model_data")
local photofile_all_data = require("data.photofile_all_data")
local photofile_ai5_data = require("data.photofile_ai5_data")
local var_0_13 = {
	file_player = require("data.photofile_data"),
	file_teacher = require("data.photofile_npcfiles_data"),
	file_weapon = require("data.photofile_HelpGirl_data"),
	file_enemy1 = require("data.photofile_xmasfile_data"),
	file_enemy2 = require("data.photofile_ai1_data"),
	file_enemy3 = require("data.photofile_ai2_data"),
	file_enemy4 = require("data.photofile_ai3_data"),
	file_enemy5 = require("data.photofile_ai4_data"),
	file_enemy6 = require("data.photofile_military_data"),
	file_enemy7 = require("data.photofile_militaryai_data"),
	file_enemy8 = require("data.photofile_foundation_data"),
	file_enemy9 = require("data.photofile_foundationai_data"),
	file_enemy10 = require("data.photofile_killer_data"),
	file_enemy11 = photofile_ai5_data,
	file_nightmare_xmasfile = require("data.photofile_nightmare_xmasfile_data"),
	file_enemy_ai5 = photofile_ai5_data
}
local var_0_17 = "ALL"
local var_0_18 = "UNLOCK"
local var_0_19 = cc.p(0.5, 0)
local var_0_20 = cc.p(90, -55)
local var_0_21 = 0.6

function PhotoFileLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PhotoFileLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PhotoFileLayer.exit(arg_3_0)
	photo_manager:releaseAllData()
	LayerManager:removePopLayer()
end

function PhotoFileLayer:changeData()
	if self.roleType == "college" then
		var_0_7 = {}
		var_0_7[#var_0_7 + 1] = "file_player"
		var_0_7[#var_0_7 + 1] = "file_teacher"
		var_0_7[#var_0_7 + 1] = "file_weapon"
	elseif self.roleType == "ai" then
		var_0_7 = {}
		var_0_7[#var_0_7 + 1] = "file_enemy1"
		var_0_7[#var_0_7 + 1] = "file_nightmare_xmasfile"
		var_0_7[#var_0_7 + 1] = "file_enemy2"
		var_0_7[#var_0_7 + 1] = "file_enemy3"
		var_0_7[#var_0_7 + 1] = "file_enemy4"
		var_0_7[#var_0_7 + 1] = "file_enemy5"
		var_0_7[#var_0_7 + 1] = "file_enemy_ai5"
		var_0_7[#var_0_7 + 1] = "file_enemy11"
	elseif self.roleType == "army" then
		var_0_7 = {}
		var_0_7[#var_0_7 + 1] = "file_enemy6"
		var_0_7[#var_0_7 + 1] = "file_enemy7"
	elseif self.roleType == "foundation" then
		var_0_7 = {}
		var_0_7[#var_0_7 + 1] = "file_enemy8"
		var_0_7[#var_0_7 + 1] = "file_enemy9"
	elseif self.roleType == "killer" then
		var_0_7 = {}
		var_0_7[#var_0_7 + 1] = "file_enemy10"
	end
end

function PhotoFileLayer:init(arg_5_1)
	local var_5_0 = cc.EventCustom:new("showTopBottomLayer")

	var_5_0.showconfig = {
		ListButtonLayer = false,
		TopcostLayer = false
	}

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_5_0)

	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PhotoFile.json" or "PhotoFile.ExportJson")

	self:addChild(self.rootlayer)

	self.roleType = arg_5_1.roleType
	self.dataTableId = arg_5_1.dataId
	self.imageType = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_type")

	self.imageType:loadTexture("PhotoFile/PhotoFile_frame/type_" .. self.roleType .. ".png", var_0_8)

	self.listViewBtn = ccui.Helper:seekWidgetByName(self.rootlayer, "ListView_btn")

	self.listViewBtn:setItemsMargin(10)

	self.roleBg = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_role")
	self.returnBtn = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_return")

	self.returnBtn:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:layerOutAni(function()
			LayerManager:removePopLayer()
		end)
	end)
	self.returnBtn:setLocalZOrder(999)

	self.select_buttonMode = var_0_17
	self.runLayer = nil
	self.size = cc.Director:getInstance():getVisibleSize()

	;(function()
		self.btnTable = {}

		while photofile_all_data[self.dataTableId]["data_name" .. 1] do
			local var_8_0 = ccui.Button:create("PhotoFile/PhotoFile_frame/" .. self.roleType .. "/role" .. 1 .. ".png", "PhotoFile/PhotoFile_frame/" .. self.roleType .. "/role" .. 1 .. "_choice.png", "PhotoFile/PhotoFile_frame/" .. self.roleType .. "/role" .. 1 .. "_choice.png", var_0_8)

			var_8_0.x = 1

			self.listViewBtn:pushBackCustomItem(var_8_0)

			self.btnTable[1] = var_8_0

			var_8_0:addTouchEventListener(function(arg_9_0, arg_9_1)
				if arg_9_1 ~= ccui.TouchEventType.ended then
					return
				end

				self.animTimes = true

				self:switchBtn(arg_9_0.x)
			end)
		end
	end)()
	self:changeData()
	self:registerScriptHandler(function(arg_10_0)
		if arg_10_0 == "exit" then
			self:exit()
		end
	end)

	self.unlockLabel = cc.Label:createWithTTF(L_UNLOCK, FONT_NAME, 28)

	self.unlockLabel:setPosition(cc.p(476, 1103 + GameDisplay.fix_y - GameDisplay.notch_height))
	self.unlockLabel:setName("unlockLabel1")
	self.unlockLabel:setColor(cc.c3b(198, 216, 233))
	self:addChild(self.unlockLabel, 1002)

	self.unlockNumLabel = cc.Label:createWithTTF("", FONT_DES, 22)

	self.unlockNumLabel:setAnchorPoint(cc.p(0, 0.5))
	self.unlockNumLabel:setPosition(cc.p(self.unlockLabel:getPositionX() + 35, self.unlockLabel:getPositionY()))
	self.unlockNumLabel:setName("unlockLabel2")
	self.unlockNumLabel:setColor(cc.c3b(255, 164, 16))
	self:addChild(self.unlockNumLabel, 1002)
	self:switchBtn(1)
	self:initBtnView()
	self:fullScreen()
end

function PhotoFileLayer:fullScreen()
	local var_11_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_bottom")

	var_11_0:setPositionY(var_11_0:getPositionY() - GameDisplay.fix_y)

	local var_11_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_title_bottom")

	var_11_1:setPositionY(GameDisplay.getUiScreenSize().height - var_11_1:getContentSize().height / 2 - GameDisplay.fix_y)
	self.listViewBtn:setPositionY(self.listViewBtn:getPositionY() - GameDisplay.fix_y)
	self.listViewBtn:setContentSize(self.listViewBtn:getContentSize().width, self.listViewBtn:getContentSize().height + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT)
end

function PhotoFileLayer:switchBtn(arg_12_1)
	if self.btnID == arg_12_1 then
		return
	end

	self.btnID = arg_12_1

	for iter_12_0, iter_12_1 in pairs(self.btnTable) do
		if iter_12_0 == self.btnID then
			iter_12_1:setBright(false)
			self:showRightViewList(var_0_7[iter_12_0])
		else
			iter_12_1:setBright(true)
		end
	end
end

function PhotoFileLayer:initBtnView()
	self.btnView = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_view_all")

	self.btnView:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.select_buttonMode == var_0_17 then
			self.select_buttonMode = var_0_18

			self.btnView:setBright(false)
		else
			self.select_buttonMode = var_0_17

			self.btnView:setBright(true)
		end

		self:showRightViewList(var_0_7[self.leftSelectIndex])
	end)
end

function PhotoFileLayer:updateFileCell(arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_2 then
		return
	end

	local var_15_1 = self.filesSelectType

	if not arg_15_1:getChildByName("Panel_roleImage"):getChildByName("photo") then
		local var_15_2 = arg_15_1:getChildByName("Panel_roleImage")
		local var_15_3 = arg_15_1:getChildByName("Label_name")
		local var_15_4 = ccui.ImageView:create()

		var_15_2:addChild(var_15_4, 999)

		if var_15_1 == var_0_3 or var_15_1 == "file_enemy2" or var_15_1 == "file_enemy3" or var_15_1 == "file_enemy4" or var_15_1 == "file_enemy5" or var_15_1 == "file_enemy7" or var_15_1 == "file_enemy9" or var_15_1 == "file_enemy11" or var_15_1 == "file_enemy_ai5" then
			var_15_4:loadTexture("roleimage/role1/" .. model_data[arg_15_3[self.filesInfo[arg_15_2].id].model_id].cute_role .. ".png")
			var_15_3:setString(arg_15_3[self.filesInfo[arg_15_2].id].name)

			local var_15_5 = arg_15_3[self.filesInfo[arg_15_2].id].offset_x or 0
			local var_15_6 = arg_15_3[self.filesInfo[arg_15_2].id].offset_y or 0

			var_15_4:setScale(arg_15_3[self.filesInfo[arg_15_2].id].size or var_0_21)
			var_15_4:setPosition(cc.p(var_15_2:getContentSize().width / 2 + var_15_5, var_15_2:getContentSize().height / 2 + var_15_6))
		elseif var_15_1 == var_0_2 or var_15_1 == "file_enemy1" or var_15_1 == "file_enemy6" or var_15_1 == "file_enemy8" or var_15_1 == "file_enemy10" or var_15_1 == "file_nightmare_xmasfile" then
			var_15_3:setString(arg_15_3[self.filesInfo[arg_15_2].id].name)
			var_15_4:loadTexture("roleimage/role/shop_image/" .. model_data[arg_15_3[self.filesInfo[arg_15_2].id].model_id].role_image .. ".png")
			var_15_4:setAnchorPoint(cc.p(0.48, 0.75))

			if not arg_15_3[self.filesInfo[arg_15_2].id].size then
				-- block empty
			end

			if not arg_15_3[self.filesInfo[arg_15_2].id].offset_x then
				-- block empty
			end

			if not arg_15_3[self.filesInfo[arg_15_2].id].offset_y then
				-- block empty
			end

			var_15_4:setPosition(cc.p(var_15_2:getContentSize().width / 2, var_15_2:getContentSize().height / 2 + 45))
		elseif var_15_1 == var_0_1 then
			var_15_4:loadTexture("roleimage/role/shop_image/" .. model_data[self.filesInfo[arg_15_2].modelId].role_image .. ".png")

			if not arg_15_3[self.filesInfo[arg_15_2].id].size then
				-- block empty
			end

			var_15_4:setAnchorPoint(cc.p(0.5, 0.8))

			if not arg_15_3[self.filesInfo[arg_15_2].id].offset_x then
				-- block empty
			end

			if not arg_15_3[self.filesInfo[arg_15_2].id].offset_y then
				-- block empty
			end

			var_15_4:setPosition(cc.p(var_15_2:getContentSize().width / 2, var_15_2:getContentSize().height / 2 + 45))
			var_15_3:setString(arg_15_3[self.filesInfo[arg_15_2].id].easy_name)
			arg_15_1:getChildByName("Label_title"):setString(arg_15_3[self.filesInfo[arg_15_2].id].title)
		end

		if var_15_1 ~= var_0_1 then
			arg_15_1:getChildByName("Image_nameBottom"):loadTexture("PhotoFile/PhotoFile_frame/cute_role_name_bottom.png", var_0_8)
			arg_15_1:getChildByName("Image_nameBottom"):setPositionY(25)
		end

		var_15_4:setName("photo")
		arg_15_1:setSwallowTouches(false)

		arg_15_1.id = arg_15_2

		arg_15_1:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_16_0:getTouchBeganPosition().y - arg_16_0:getTouchEndPosition().y) > 50 then
				return
			end

			self:showPhotoDetailLayer(self.filesInfo[arg_16_0.id].id, self.filesInfo[arg_16_0.id].modelId, {
				panelType = files,
				contentType = self.filesSelectType,
				leftSelectIndex = self.leftSelectIndex
			}, self.filesInfoAll, self.filesInfo[arg_16_0.id].servantid)
		end)
	else
		local var_15_13 = arg_15_1:getChildByName("Panel_roleImage"):getChildByName("photo")

		arg_15_1.id = arg_15_2
		nameLable = arg_15_1:getChildByName("Label_name")

		local var_15_14 = arg_15_1:getChildByName("Panel_roleImage")

		if var_15_1 == var_0_3 or var_15_1 == "file_enemy2" or var_15_1 == "file_enemy3" or var_15_1 == "file_enemy4" or var_15_1 == "file_enemy5" or var_15_1 == "file_enemy7" or var_15_1 == "file_enemy9" or var_15_1 == "file_enemy11" then
			nameLable:setString(arg_15_3[self.filesInfo[arg_15_2].id].name)
			var_15_13:loadTexture("roleimage/role1/" .. model_data[arg_15_3[self.filesInfo[arg_15_2].id].model_id].cute_role .. ".png")

			local var_15_15 = arg_15_3[self.filesInfo[arg_15_2].id].offset_x or 0
			local var_15_16 = arg_15_3[self.filesInfo[arg_15_2].id].offset_y or 0

			var_15_13:setScale(arg_15_3[self.filesInfo[arg_15_2].id].size or var_0_21)
			var_15_13:setPosition(cc.p(var_15_14:getContentSize().width / 2 + var_15_15, var_15_14:getContentSize().height / 2 + var_15_16))
		elseif var_15_1 == var_0_2 or var_15_1 == "file_enemy1" or var_15_1 == "file_enemy6" or var_15_1 == "file_enemy8" or var_15_1 == "file_enemy10" then
			nameLable:setString(arg_15_3[self.filesInfo[arg_15_2].id].name)
			var_15_13:loadTexture("roleimage/role/shop_image/" .. model_data[arg_15_3[self.filesInfo[arg_15_2].id].model_id].role_image .. ".png")

			if not arg_15_3[self.filesInfo[arg_15_2].id].offset_x then
				-- block empty
			end

			if not arg_15_3[self.filesInfo[arg_15_2].id].offset_y then
				-- block empty
			end

			if not arg_15_3[self.filesInfo[arg_15_2].id].size then
				-- block empty
			end

			var_15_13:setPosition(cc.p(var_15_14:getContentSize().width / 2, var_15_14:getContentSize().height / 2 + 45))
		elseif var_15_1 == var_0_1 then
			nameLable:setString(arg_15_3[self.filesInfo[arg_15_2].id].easy_name)
			arg_15_1:getChildByName("Label_title"):setString(arg_15_3[self.filesInfo[arg_15_2].id].title)
			var_15_13:loadTexture("roleimage/role/shop_image/" .. model_data[self.filesInfo[arg_15_2].modelId].role_image .. ".png")

			if not arg_15_3[self.filesInfo[arg_15_2].id].offset_x then
				-- block empty
			end

			if not arg_15_3[self.filesInfo[arg_15_2].id].offset_y then
				-- block empty
			end

			if not arg_15_3[self.filesInfo[arg_15_2].id].size then
				-- block empty
			end

			var_15_13:setPosition(cc.p(var_15_14:getContentSize().width / 2, var_15_14:getContentSize().height / 2 + 45))
		end
	end

	if self.filesInfo[arg_15_2].unlock ~= 1 then
		arg_15_1:getChildByName("maskPanel"):setBackGroundColorOpacity(150)
	else
		arg_15_1:getChildByName("maskPanel"):setBackGroundColorOpacity(0)
	end
end

function PhotoFileLayer:initEnemyData(arg_17_1)
	photo_manager:initEnemyData()

	self.filesInfoAll = photo_manager:getEnemyData(arg_17_1)

	if self.select_buttonMode == var_0_17 then
		self.totalNumber = photo_manager:getEnemyNumber(arg_17_1)
		self.filesInfo = photo_manager:getEnemyData(arg_17_1)
	else
		self.totalNumber = photo_manager:getUnlockEnemyNumber(arg_17_1)
		self.filesInfo = photo_manager:getUnlockEnemyData(arg_17_1)
	end

	self.allNum = photo_manager:getEnemyNumber(arg_17_1)
	self.unlockNum = photo_manager:getUnlockEnemyNumber(arg_17_1)
	self.cellSize.width = 178
	self.cellSize.height = 253
end

function PhotoFileLayer:updateData()
	self.colNum = 3

	if self.filesSelectType == "file_player" then
		photo_manager:initGirlData()

		self.filesInfoAll = photo_manager:getGirlData()

		if self.select_buttonMode == var_0_17 then
			self.totalNumber = photo_manager:getGirlNumber()
			self.filesInfo = photo_manager:getGirlData()
		else
			self.totalNumber = photo_manager:getUnlockGirlNumber()
			self.filesInfo = photo_manager:getUnlockGirlData()
		end

		self.allNum = photo_manager:getGirlNumber()
		self.unlockNum = photo_manager:getUnlockGirlNumber()
		self.cellSize.width = 178
		self.cellSize.height = 253

		AnalyticManager.enterPhotoStudent({
			studentNum = self.unlockNum
		})
	elseif self.filesSelectType == "file_weapon" then
		photo_manager:initHelpGirlData()

		self.filesInfoAll = photo_manager:getHelpGirlData()

		if self.select_buttonMode == var_0_17 then
			self.totalNumber = photo_manager:getHelpGirlNumber()
			self.filesInfo = photo_manager:getHelpGirlData()
		else
			self.totalNumber = photo_manager:getUnlockHelpGirlNumber()
			self.filesInfo = photo_manager:getUnlockHelpGirlData()
		end

		self.allNum = photo_manager:getHelpGirlNumber()
		self.unlockNum = photo_manager:getUnlockHelpGirlNumber()
		self.cellSize.width = 178
		self.cellSize.height = 253

		AnalyticManager.enterPhotoHorcrux({
			HorcruxNum = self.unlockNum
		})
	elseif self.filesSelectType == "file_teacher" then
		photo_manager:initTeacherData()

		self.filesInfoAll = photo_manager:getTeacherData()

		if self.select_buttonMode == var_0_17 then
			self.totalNumber = photo_manager:getTeacherNumber()
			self.filesInfo = photo_manager:getTeacherData()
		else
			self.totalNumber = photo_manager:getUnlockTeacherNumber()
			self.filesInfo = photo_manager:getUnlockTeacherData()
		end

		self.allNum = photo_manager:getTeacherNumber()
		self.unlockNum = photo_manager:getUnlockTeacherNumber()
		self.cellSize.width = 178
		self.cellSize.height = 253
	elseif self.filesSelectType == "file_enemy1" then
		self:initEnemyData(1)
	elseif self.filesSelectType == "file_enemy2" then
		self:initEnemyData(2)
	elseif self.filesSelectType == "file_enemy3" then
		self:initEnemyData(3)
	elseif self.filesSelectType == "file_enemy4" then
		self:initEnemyData(4)
	elseif self.filesSelectType == "file_enemy5" then
		self:initEnemyData(5)
	elseif self.filesSelectType == "file_enemy6" then
		self:initEnemyData(6)
	elseif self.filesSelectType == "file_enemy7" then
		self:initEnemyData(7)
	elseif self.filesSelectType == "file_enemy8" then
		self:initEnemyData(8)
	elseif self.filesSelectType == "file_enemy9" then
		self:initEnemyData(9)
	elseif self.filesSelectType == "file_enemy10" then
		self:initEnemyData(10)
	elseif self.filesSelectType == "file_nightmare_xmasfile" then
		self:initEnemyData(11)
	elseif self.filesSelectType == "file_enemy11" then
		self:initEnemyData(12)
	elseif self.filesSelectType == "file_enemy_ai5" then
		self:initEnemyData(13)
	elseif LeftLayerName ~= nil then
		return
	end
end

function PhotoFileLayer:showRightViewList(arg_19_1)
	if self.runLayer then
		self.runLayer:removeFromParent()

		self.runLayer = nil
	end

	self.cellSize = cc.p(0, 0)

	self.rootlayer:removeChild(self.runLayer)

	if arg_19_1 then
		self.filesSelectType = arg_19_1
	end

	self.allNum = 0
	self.unlockNum = 0

	self:updateData()
	self.unlockNumLabel:setString(tostring(self.unlockNum) .. "/" .. tostring(self.allNum))

	local var_19_0 = cc.Director:getInstance():getVisibleSize()

	var_19_0.width = var_19_0.width - 52
	var_19_0.height = var_19_0.height + 100

	local var_19_1 = cc.size(var_19_0.width, 1001 + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT)

	local function var_19_2(arg_20_0)
		local var_20_0 = self.roleBg:clone()

		var_20_0:setScale(0.95)
		var_20_0:setAnchorPoint(cc.p(0, 0))

		local var_20_1 = ccui.Layout:create()

		var_20_1:setBackGroundImageColor(cc.c3b(255, 255, 255))
		var_20_1:setPosition(cc.p(0, 0))
		var_20_1:setContentSize((cc.size(178, 253)))
		var_20_1:setAnchorPoint(cc.p(0, 0))
		var_20_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_20_1:setName("maskPanel")
		var_20_1:setBackGroundColor(cc.c3b(0, 0, 0))
		var_20_1:setBackGroundColorOpacity(100)
		var_20_0:addChild(var_20_1, 100)

		return var_20_0
	end

	local var_19_3 = {
		cc.p(0, 0),
		cc.p(189, 0),
		(cc.p(378, 0))
	}

	self.runLayer = cc.TableView:create(var_19_1)

	self.runLayer:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	self.runLayer:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.runLayer:setPosition(cc.p(71, 63 - GameDisplay.fix_y))
	self.runLayer:setDelegate()
	self.rootlayer:addChild(self.runLayer)
	self.runLayer:registerScriptHandler(function(arg_22_0)
		return math.ceil(self.totalNumber / self.colNum)
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	self.runLayer:registerScriptHandler(function(arg_23_0)
		return
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	self.runLayer:registerScriptHandler(function(arg_24_0, arg_24_1)
		return self.cellSize.width, self.cellSize.height
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	self.runLayer:registerScriptHandler(function(arg_21_0, arg_21_1)
		local var_21_0 = string.format("%d", arg_21_1)
		local var_21_1 = arg_21_0:dequeueCell()
		local var_21_2 = arg_21_1

		if not var_21_1 then
			local var_21_3 = math.ceil(var_19_1.height / self.cellSize.height)

			var_21_1 = cc.TableViewCell:create()

			for iter_21_0 = 1, self.colNum do
				local var_21_4 = var_19_2(self.filesSelectType)

				var_21_4:setPosition(var_19_3[iter_21_0])

				if var_21_2 < var_21_3 then
					var_21_4:setOpacity(0)
					var_21_4:runAction(cc.Sequence:create(cc.DelayTime:create((var_21_2 + 1) * (LAYER_INTO_TIME / var_21_3)), cc.FadeIn:create(0)))
				end

				var_21_4:setName("photo" .. iter_21_0)

				if self.filesInfo[var_21_2 * self.colNum + iter_21_0] then
					var_21_4:setVisible(true)
					self:updateFileCell(var_21_4, var_21_2 * self.colNum + iter_21_0, var_0_13[self.filesSelectType])
				else
					var_21_4:setVisible(false)
				end

				var_21_1:addChild(var_21_4)
			end
		else
			for iter_21_1 = 1, self.colNum do
				local var_21_5 = var_21_1:getChildByName("photo" .. iter_21_1)

				var_21_5:setPosition(var_19_3[iter_21_1])
				print("self.filesSelectType", self.filesSelectType)

				if self.filesInfo[var_21_2 * self.colNum + iter_21_1] then
					var_21_5:setVisible(true)
					self:updateFileCell(var_21_5, var_21_2 * self.colNum + iter_21_1, var_0_13[self.filesSelectType])
				else
					var_21_5:setVisible(false)
				end
			end
		end

		if self.startRunOutAni then
			self.startIndex = self.startIndex or var_21_2

			local var_21_6 = LAYER_OUT_TIME / math.ceil(var_19_1.height / self.cellSize.height)

			for iter_21_2 = 1, self.colNum do
				var_21_1:getChildByName("photo" .. iter_21_2):runAction(cc.Sequence:create(cc.DelayTime:create((var_21_2 - self.startIndex + 1) * var_21_6), cc.FadeOut:create(0)))
			end
		end

		return var_21_1
	end, cc.TABLECELL_SIZE_AT_INDEX)
	self.runLayer:reloadData()
end

function PhotoFileLayer:layerOutAni(arg_25_1)
	self.startRunOutAni = true

	self:updateShowingCells()
	self.rootlayer:runAction(cc.Sequence:create(cc.DelayTime:create(LAYER_OUT_TIME), cc.CallFunc:create(arg_25_1)))
end

function PhotoFileLayer:getListLen()
	return math.ceil(#self.filesInfo / self.colNum)
end

function PhotoFileLayer:updateShowingCells()
	local var_27_0, var_27_1 = GetTableViewShowCellIdx(self.runLayer, {
		cellsize = cc.size(self.cellSize.width, self.cellSize.height),
		maxcount = self:getListLen()
	})

	for iter_27_0 = var_27_0, var_27_1 do
		self.runLayer:updateCellAtIndex(iter_27_0)
	end
end

function PhotoFileLayer.showPhotoDetailLayer(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	local var_28_0 = {
		PhotoFileLayer = 1,
		id = arg_28_1,
		modelid = arg_28_2,
		contentType = arg_28_3,
		info = arg_28_4,
		servantid = arg_28_5
	}

	print("contentType==", arg_28_3.contentType)

	if arg_28_3.contentType == "file_player" or arg_28_3.contentType == "file_enemy1" or arg_28_3.contentType == "file_enemy6" or arg_28_3.contentType == "file_enemy8" or arg_28_3.contentType == "file_enemy10" or arg_28_3.contentType == "file_teacher" or arg_28_3.contentType == "file_nightmare_xmasfile" then
		LayerManager:pushInLayer("PhotoFileRoleFileLayer", var_28_0)
	else
		LayerManager:pushInLayer("PhotoFileHelpGirlLayer", var_28_0)
	end
end
