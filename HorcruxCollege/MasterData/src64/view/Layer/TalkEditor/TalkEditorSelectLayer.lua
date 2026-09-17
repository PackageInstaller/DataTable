TalkEditorSelectLayer = class("TalkEditorSelectLayer", function()
	return cc.NodeGrid:create()
end)

local model_data = require("data.model_data")
local Utility = require("common.Utility")
local talkeditor_manager = require("controller.talkeditor_manager")
local utf8 = require("controller.utf8")
local var_0_4 = config._DEBUG and 0 or 1
local var_0_5 = TALKEDITOR.PropertyTypeList

function TalkEditorSelectLayer.create(arg_2_0, arg_2_1)
	return (TalkEditorSelectLayer.new(arg_2_1))
end

function TalkEditorSelectLayer:ctor(arg_3_1)
	self.params = arg_3_1
	self.scheduler = cc.Director:getInstance():getScheduler()

	self:onLoad()
	self:init()
end

function TalkEditorSelectLayer:onLoad()
	if self.selectViewNode then
		self.selectViewNode:setVisible(false)
	end

	if self.root then
		return
	end

	TextureManager:loadLayerTextures({
		"TalkEditorLayer"
	})

	self.root = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "TalkEditorSelectLayer.json" or "TalkEditorSelectLayer.ExportJson")

	self:addChild(self.root)
	self.root:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:closePropertySelectPanel()
	end)

	self.bgNode = self.root:getChildByName("bg")
	self.playTglNode = self.root:getChildByName("playTgl")
	self.toggleContaninerNode = self.playTglNode:getChildByName("tgl")
	self.filterNode = self.root:getChildByName("filter")

	local var_4_0 = self.filterNode:getChildByName("input")

	var_4_0:setVisible(false)

	self.filterInputNode = Utility:getEditBox("TalkEditorLayer/input_bg.png", cc.size(280, 67), function(arg_6_0)
		if arg_6_0 == "ended" then
			self.filterInputText = self.filterInputNode:getText()

			self:initTableViewPanel()
		end
	end)

	local var_4_1, var_4_2 = var_4_0:getPosition()

	self.filterInputNode:setPosition(cc.p(var_4_1, var_4_2 + 10))
	self.filterInputNode:setAnchorPoint(cc.p(0, 0.5))
	self.filterInputNode:setFontSize(16)
	self.filterInputNode:setPlaceholderFont(FONT_TITLE, 32)
	self.filterInputNode:setPlaceHolder("请输入关键字")
	self.filterInputNode:setMaxLength(8)
	self.filterNode:addChild(self.filterInputNode)

	self.btn_clear = self.root:getChildByName("btn_clear")

	self.btn_clear:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:closePropertySelectPanel()

		if self.params.selectCallback then
			local var_7_0 = {}

			var_7_0.actionType = self.toggleContaninerNode.index or 1

			self.params.selectCallback(nil, var_7_0)
		end
	end)

	self.scrollbarNode = self.root:getChildByName("scrollbar")

	self.scrollbarNode:setLocalZOrder(99)

	self.barNode = self.scrollbarNode:getChildByName("bar")

	self.barNode:setTouchEnabled(true)
	self.scrollbarNode:setTouchEnabled(true)

	self.barRangeMax = self.scrollbarNode:getContentSize().height
	self.barRangeMin = self.barNode:getContentSize().height

	self.barNode:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.moved then
			return
		end

		local var_8_0 = arg_8_0:getParent()
		local var_8_1 = math.min(math.max(var_8_0:convertToNodeSpace((arg_8_0:getTouchMovePosition())).y + arg_8_0:getContentSize().height / 2, arg_8_0:getContentSize().height), var_8_0:getContentSize().height)

		arg_8_0:setPositionY(var_8_1)

		if self.selectViewNode then
			local var_8_2 = arg_8_0:getContentSize().height

			self.selectViewNode:scrollToPercent(100 - (var_8_1 - var_8_2) / (var_8_0:getContentSize().height - var_8_2) * 100, nil, false)
		end
	end)
	self.scrollbarNode:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.began then
			return
		end

		local var_9_0 = arg_9_0:getParent()
		local var_9_1 = arg_9_0:getChildByName("bar")
		local var_9_2 = math.min(math.max(var_9_0:convertToNodeSpace((arg_9_0:getTouchBeganPosition())).y - var_9_1:getContentSize().height / 2, var_9_1:getContentSize().height), arg_9_0:getContentSize().height)

		var_9_1:setPositionY(var_9_2)

		if self.selectViewNode then
			local var_9_3 = var_9_1:getContentSize().height

			self.selectViewNode:scrollToPercent(100 - (var_9_2 - var_9_3) / (arg_9_0:getContentSize().height - var_9_3) * 100, nil, false)
		end
	end)
end

function TalkEditorSelectLayer:init()
	self:initInfo()
	self:lateUpdate(function()
		self:initPanel()
	end)
end

function TalkEditorSelectLayer:initInfo()
	self.selectConfigInfo = {
		[var_0_5.Bubble] = {
			havefilter = 0,
			havecontent = 1,
			haveplaytype = 1,
			haveicon = 0,
			havetitle = 1,
			cellSize = cc.size(1300, 150)
		},
		[var_0_5.TalkType] = {
			havefilter = 0,
			havecontent = 1,
			haveplaytype = 0,
			haveicon = 0,
			havetitle = 1,
			cellSize = cc.size(1300, 150)
		},
		[var_0_5.Expression] = {
			havefilter = 0,
			havecontent = 1,
			haveplaytype = 0,
			haveicon = 0,
			havetitle = 1,
			cellSize = cc.size(1300, 150)
		},
		[var_0_5.Player] = {
			havefilter = 1,
			havecontent = 1,
			haveplaytype = 0,
			haveicon = 1,
			havetitle = 1,
			cellSize = cc.size(1300, 380)
		},
		[var_0_5.Background] = {
			havefilter = 0,
			havecontent = 1,
			haveplaytype = 0,
			haveicon = 1,
			havetitle = 1,
			modelScaleX = 0.3,
			modelScaleY = 0.25,
			cellSize = cc.size(1600, 380)
		},
		[var_0_5.BGM] = {
			havefilter = 1,
			havecontent = 1,
			haveplaytype = 0,
			haveicon = 0,
			havetitle = 1,
			cellSize = cc.size(1300, 150)
		},
		[var_0_5.Sound] = {
			havefilter = 1,
			havecontent = 1,
			haveplaytype = 0,
			haveicon = 0,
			havetitle = 1,
			cellSize = cc.size(1300, 150)
		}
	}
	self.propertytype = self.params.target.propertytype
	self.curConfigInfo = self.selectConfigInfo[self.propertytype]
	self.toggleContaninerNode.index = tonumber(self.params.curItemInfo.Bubble_ActionType) or 1
end

function TalkEditorSelectLayer:initPanel()
	self.filterNode:setVisible(self.curConfigInfo.havefilter == 1)
	self.playTglNode:setVisible(self.curConfigInfo.haveplaytype == 1)
	Utility:setTglContainerCallback(self.toggleContaninerNode, function(arg_14_0)
		self.toggleContaninerNode.index = arg_14_0
	end, self.toggleContaninerNode.index)
	self:initTableViewPanel()
end

function TalkEditorSelectLayer:getTableViewInfo()
	local var_15_0 = {}
	local var_15_1 = talkeditor_manager:getSelectPropertyInfo(self.propertytype)

	if self.filterInputText then
		if self.propertytype == var_0_5.Player then
			for iter_15_0, iter_15_1 in pairs(var_15_1) do
				local var_15_2 = model_data[iter_15_1.value]
				local var_15_3

				if model_data[iter_15_1.value] then
					var_15_3 = var_15_2.English_name or ""

					local var_15_4

					if var_15_2 then
						var_15_4 = var_15_2.name or ""
					end
				end

				local var_15_5 = false

				for iter_15_2 in string.gmatch(var_15_3, self.filterInputText) do
					var_15_5 = true

					break
				end

				for iter_15_3 in string.gmatch(var_15_4, self.filterInputText) do
					var_15_5 = true

					break
				end

				if var_15_5 == true then
					table.insert(var_15_0, iter_15_1)
				end
			end
		elseif self.propertytype == var_0_5.BGM or self.propertytype == var_0_5.Sound then
			for iter_15_4, iter_15_5 in pairs(var_15_1) do
				local var_15_6 = false

				for iter_15_6 in string.gmatch(iter_15_5.value, self.filterInputText) do
					var_15_6 = true

					break
				end

				if var_15_6 == true then
					table.insert(var_15_0, iter_15_5)
				end
			end
		else
			var_15_0 = var_15_1
		end
	else
		var_15_0 = var_15_1
	end

	talkeditor_manager:setSelectPropertyInfoByFilter(self.propertytype, var_15_0)

	return var_15_0
end

function TalkEditorSelectLayer:initTableViewPanel()
	local var_16_1 = self:getTableViewInfo()

	if var_16_1 == nil or next(var_16_1) == nil then
		return
	end

	if self.propertytype == var_0_5.Player then
		for iter_16_0, iter_16_1 in pairs(var_16_1) do
			if model_data[iter_16_1.value] then
				local var_16_2 = model_data[iter_16_1.value]

				iter_16_1.sortIndex = model_data[iter_16_1.value].English_name or "Z"

				if var_16_2.role_image then
					iter_16_1.iconPath = "roleimage/role/shop_image/" .. var_16_2.role_image .. ".png" or nil
				end

				iter_16_1.title = var_16_2.English_name or ""
				iter_16_1.content = var_16_2.name_Q
			end
		end

		table.sort(var_16_1, function(arg_17_0, arg_17_1)
			if arg_17_0.sortIndex == nil then
				arg_17_0.sortIndex = "Z"
			end

			if arg_17_1.sortIndex == nil then
				arg_17_1.sortIndex = "Z"
			end

			return arg_17_0.sortIndex < arg_17_1.sortIndex
		end)
	elseif self.propertytype == var_0_5.Background then
		for iter_16_2, iter_16_3 in pairs(var_16_1) do
			iter_16_3.sortIndex = iter_16_3.value

			if Utility:haveFileExist("./res/" .. "mainScenebg/" .. iter_16_3.value .. ".jpg") then
				iter_16_3.iconPath = "mainScenebg/" .. iter_16_3.value .. ".jpg"
			end

			iter_16_3.title = iter_16_3.id
			iter_16_3.content = iter_16_3.name
		end

		table.sort(var_16_1, function(arg_18_0, arg_18_1)
			if arg_18_0.sortIndex == nil then
				arg_18_0.sortIndex = "Z"
			end

			if arg_18_1.sortIndex == nil then
				arg_18_1.sortIndex = "Z"
			end

			return arg_18_0.sortIndex < arg_18_1.sortIndex
		end)
	end

	local var_16_4 = math.ceil(#var_16_1 / 3)
	local var_16_5 = self.curConfigInfo.cellSize.width
	local var_16_6 = self.curConfigInfo.cellSize.height

	if self.selectViewNode ~= nil then
		self.selectViewNode:removeFromParent()

		self.selectViewNode = nil
	end

	self.selectViewNode = Utility:getTableView(var_16_4, function(arg_19_0)
		return var_16_5, var_16_6 + 50
	end, cc.size(self.curConfigInfo.cellSize.width, 900), function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_0:dequeueCell()

		if var_20_0 == nil then
			var_20_0 = cc.TableViewCell:new()
		end

		local var_20_1 = var_20_0:getChildByName("item")

		if var_20_1 == nil then
			var_20_1 = self:getSelectItemNode()

			var_20_0:addChild(var_20_1)
			var_20_1:setName("item")
		end

		for iter_20_0 = 1, 3 do
			local var_20_2 = var_16_1[arg_20_1 * 3 + iter_20_0]
			local var_20_3 = var_20_1:getChildByName("bg" .. iter_20_0)

			if var_16_1[arg_20_1 * 3 + iter_20_0] then
				var_20_3:setVisible(true)

				var_20_3.index = arg_20_1 * 3 + iter_20_0

				var_20_3:addTouchEventListener(function(arg_21_0, arg_21_1)
					if arg_21_1 ~= ccui.TouchEventType.ended then
						return
					end

					if math.abs(arg_21_0:getTouchBeganPosition().y - arg_21_0:getTouchEndPosition().y) > 50 then
						return
					end

					self:closePropertySelectPanel()

					if self.params.selectCallback then
						local var_21_0 = {}

						var_21_0.actionType = self.toggleContaninerNode.index or 1

						self.params.selectCallback(arg_21_0.index, var_21_0)
					end
				end)

				local var_20_4 = var_20_3:getChildByName("title")

				var_20_4:setString(var_20_2.title or var_20_2.id)
				var_20_4:setVisible(self.curConfigInfo.havetitle == 1)

				local var_20_5 = var_20_3:getChildByName("content")

				var_20_5:setString(var_20_2.content or var_20_2.name)
				var_20_5:setVisible(self.curConfigInfo.havecontent == 1)

				local var_20_6 = var_20_3:getChildByName("icon")

				if self.curConfigInfo.haveicon ~= 1 then
					var_20_6:setVisible(false)
				elseif var_20_2.iconPath then
					var_20_6:setVisible(true)
					var_20_6:loadTexture(var_20_2.iconPath)
				end
			else
				var_20_3:setVisible(false)
			end
		end

		return var_20_0
	end, function()
		return
	end, function(arg_23_0)
		return
	end)

	self.selectViewNode:setVisible(true)
	self.selectViewNode:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	self.bgNode:addChild(self.selectViewNode)
	self.bgNode:setContentSize(cc.size(self.curConfigInfo.cellSize.width, 900))
end

function TalkEditorSelectLayer:closePropertySelectPanel()
	self:setVisible(false)

	self.params.target.isOpen = false

	if self.params.closeCallback then
		self.params.closeCallback()
	end
end

function TalkEditorSelectLayer:getSelectItemNode()
	local var_25_0 = ccui.Layout:create()
	local var_25_2 = self.curConfigInfo.modelScaleX or 1
	local var_25_3 = self.curConfigInfo.modelScaleY or 1
	local var_25_4 = self.curConfigInfo.singleNum or 3
	local var_25_5 = (self.curConfigInfo.cellSize.width - 340) / var_25_4

	var_25_0:setContentSize(cc.size(self.curConfigInfo.cellSize.width, self.curConfigInfo.cellSize.height))
	var_25_0:setAnchorPoint(cc.p(0, 0))

	for iter_25_0 = 1, var_25_4 do
		local var_25_6 = ccui.Button:create("TalkEditorLayer/rightkey_bg.png", "TalkEditorLayer/rightkey_bg.png", "TalkEditorLayer/rightkey_bg.png", var_0_4)

		var_25_6:setAnchorPoint(cc.p(0, 0))
		var_25_6:setSwallowTouches(false)
		var_25_6:setScale9Enabled(true)
		var_25_6:setContentSize(cc.size(var_25_5, self.curConfigInfo.cellSize.height))
		var_25_6:setName("bg" .. iter_25_0)
		var_25_6:setTouchEnabled(true)

		local var_25_7 = ccui.Text:create("", FONT_DES, 30)

		var_25_7:setName("title")
		var_25_7:setColor(cc.c3b(0, 0, 205))
		var_25_7:setAnchorPoint(cc.p(0, 1))
		var_25_7:setPosition(cc.p(10, 120))
		var_25_6:addChild(var_25_7)

		local var_25_8 = ccui.Text:create("", FONT_DES, 30)

		var_25_8:setName("content")
		var_25_8:setColor(cc.c3b(0, 0, 205))
		var_25_8:setAnchorPoint(cc.p(0, 1))
		var_25_8:setPosition(cc.p(10, 90))
		var_25_6:addChild(var_25_8)
		var_25_6:setPositionX(50 + (iter_25_0 - 1) * (var_25_5 + 50))

		local var_25_9 = ccui.ImageView:create()

		var_25_9:setName("icon")
		var_25_9:setScaleX(var_25_2)
		var_25_9:setScaleY(var_25_3)
		var_25_9:setPosition(cc.p(var_25_5 - 100, 190))
		var_25_6:addChild(var_25_9)
		var_25_0:addChild(var_25_6)
	end

	return var_25_0
end

function TalkEditorSelectLayer:lateUpdate(arg_26_1)
	if self.cinemaScheduler ~= nil then
		self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

		self.cinemaScheduler = nil
	end

	self.cinemaScheduler = self.scheduler:scheduleScriptFunc(function()
		if self.cinemaScheduler ~= nil then
			self.scheduler:unscheduleScriptEntry(self.cinemaScheduler)

			self.cinemaScheduler = nil
		end

		if type(arg_26_1) == "function" then
			arg_26_1()
		end
	end, 0, false)
end
