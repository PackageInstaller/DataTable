local var_0_0 = {
	INVITE = 1,
	BEINVITED = 2
}
local var_0_1 = {
	GO = 2,
	GET = 1,
	FINISHED = 3
}
local var_0_2 = config._DEBUG and 0 or 1

InviteLayer = class("InviteLayer", function()
	return cc.Layer:create()
end)

local invite_manager = require("controller.invite_manager")
local activity_manager = require("controller.activity_manager")
local RichTextPro = require("view.Sprite.RichTextPro")

function InviteLayer.create(arg_2_0)
	local var_2_0 = InviteLayer.new()

	var_2_0:init()

	return var_2_0
end

function InviteLayer:adapt()
	local var_3_0 = self.bgNode:getChildByName("tittle")

	var_3_0:setPositionY(var_3_0:getPositionY() + 20)

	self.timeLabelNode = ccui.Text:create("", FONT_NAME, 18)

	self.timeLabelNode:setColor(cc.c3b(255, 198, 0))
	self.timeLabelNode:setName("time")
	self.bgNode:addChild(self.timeLabelNode)
	self.timeLabelNode:setPosition(cc.p(var_3_0:getPositionX(), var_3_0:getPositionY() - 55))
	self:updateTimeCountDown()
end

function InviteLayer:updateTimeCountDown()
	local var_4_0 = self.InviteManager:getLeftTimeStr()

	if var_4_0 ~= nil then
		self.timeLabelNode:setString("距离活动结束剩余" .. var_4_0)

		if self.scheduler ~= nil then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

			self.scheduler = nil
		end

		self.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
			self:updateTimeCountDown()
		end, 1, false)
	end
end

function InviteLayer:releaseScheduler()
	if self.scheduler ~= nil then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)

		self.scheduler = nil
	end
end

function InviteLayer:initPanelRedDotStatus()
	self:updatePanelReddotStatus(var_0_0.INVITE, self.InviteManager:getCurTaskInfo(var_0_0.INVITE).isShowReddot)
	self:updatePanelReddotStatus(var_0_0.BEINVITED, self.InviteManager:getCurTaskInfo(var_0_0.BEINVITED).isShowReddot)
end

function InviteLayer:fullScreen()
	self.bgMaskNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.bgMaskNode:setPosition(cc.p(0, 0 - GameDisplay.fix_y))
end

function InviteLayer:init()
	self.rootLayout = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "InviteLayer.json" or "InviteLayer.ExportJson")
	self.bgMaskNode = self.rootLayout:getChildByName("Panel_Mask")

	self:fullScreen()
	self:addChild(self.rootLayout)

	self.active = true

	self:registerEventsCallback()
	self:initInfo()
	self:initUINode()

	self.InviteManager = invite_manager:create()

	self:initShareNode()
	self.InviteManager:initInfo(function()
		self:initPanelRedDotStatus()
		self:initPanel()
	end)
	self:registerScriptHandler(function(arg_11_0)
		if arg_11_0 == "exit" then
			self:releaseEventsCallback()
			self:releaseScheduler()

			self.active = false

			self.InviteManager:updateBtnInviteRedDotStatus()
		end
	end)
	self:adapt()

	return true
end

function InviteLayer:initShareNode()
	self.btn_share:setVisible(self.InviteManager:isCanShowShare() or false)
end

function InviteLayer.initInfo(arg_13_0)
	arg_13_0.curPanelType = invite_manager:getCurPanelType()
	arg_13_0.curInputBindUid = invite_manager:getCurInputBindUid()
end

function InviteLayer.registerEventsCallback(arg_14_0)
	activity_manager:registerEventListener("InviteLayer", activity_manager.activityEventId.INVITE_IS_INVITE_REDDOT, function(arg_15_0)
		local var_15_0 = arg_14_0.btn_invite:getChildByName("reddot")

		if arg_15_0 == true then
			var_15_0:setVisible(true)
		else
			var_15_0:setVisible(false)
		end

		arg_14_0.btn_invite.isShowReddot = arg_15_0
	end)
	activity_manager:registerEventListener("InviteLayer", activity_manager.activityEventId.INVITE_IS_BEINVITED_REDDOT, function(arg_16_0)
		local var_16_0 = arg_14_0.btn_beinvited:getChildByName("reddot")

		if arg_16_0 == true then
			var_16_0:setVisible(true)
		else
			var_16_0:setVisible(false)
		end

		arg_14_0.btn_beinvited.isShowReddot = arg_16_0
	end)
end

function InviteLayer.releaseEventsCallback(arg_17_0)
	activity_manager:releaseEventListener("InviteLayer", activity_manager.activityEventId.INVITE_IS_INVITE_REDDOT)
	activity_manager:releaseEventListener("InviteLayer", activity_manager.activityEventId.INVITE_IS_BEINVITED_REDDOT)
end

function InviteLayer:initUINode()
	self.bgNode = self.rootLayout:getChildByName("bg")
	self.tipsNode = self.bgNode:getChildByName("tips")
	self.btn_share = self.rootLayout:getChildByName("btn_share")
	self.shareTextNode = self.btn_share:getChildByName("text")
	self.btn_invite = self.rootLayout:getChildByName("btn_invite")
	self.btn_beinvited = self.rootLayout:getChildByName("btn_beinvited")
	self.bindPanelNode = self.rootLayout:getChildByName("bindPanel")
	self.bindLabel = self.bindPanelNode:getChildByName("bindLabel")
	self.btn_copy = self.bindPanelNode:getChildByName("btn_copy")
	self.btn_bind = self.bindPanelNode:getChildByName("btn_bind")

	self.btn_bind:setPosition(cc.p(502, 22))

	local var_18_0 = cc.size(420, 48)
	local var_18_1

	if config._DEBUG then
		var_18_1 = cc.Scale9Sprite:create("InviteLayer/bind_bg.png") or cc.Scale9Sprite:createWithSpriteFrameName("InviteLayer/bind_bg.png")
	end

	local function var_18_2(arg_19_0, arg_19_1)
		if arg_19_0 == "ended" then
			self.curInputBindUid = tonumber((self.bindInputNode:getText()))
		end
	end

	self.bindInputNode = cc.EditBox:create(var_18_0, var_18_1)

	self.bindInputNode:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
	self.bindInputNode:registerScriptEditBoxHandler(function(arg_20_0)
		var_18_2(arg_20_0, editBox)
	end)
	self.bindInputNode:setPosition(cc.p(3, 21))
	self.bindInputNode:setFontName("fonts/name.ttf")
	self.bindInputNode:setFontSize(20)
	self.bindInputNode:setAnchorPoint(cc.p(0, 0.5))
	self.bindInputNode:setFontColor(cc.c3b(255, 255, 255))
	self.bindInputNode:setPlaceholderFontSize(24)
	self.bindInputNode:setPlaceholderFontName("fonts/name.ttf")
	self.bindInputNode:setPlaceHolder("输入其他班长的UID就可以领取奖励啦~")
	self.bindInputNode:setPlaceholderFontColor(cc.c3b(112, 73, 196))
	self.bindInputNode:setMaxLength(8)
	self.bindPanelNode:addChild(self.bindInputNode)

	self.taskItem1Node = self.rootLayout:getChildByName("taskItem1")

	self.taskItem1Node:setVisible(false)
	self.bgMaskNode:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("back main layer")
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.btn_share:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		print("open share panel")
		self.InviteManager:share()
	end)

	function self.onBtnInviteEventCallback(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curPanelType == var_0_0.INVITE then
			return
		end

		self.curPanelType = var_0_0.INVITE

		self.InviteManager:setCurPanelType(var_0_0.INVITE)
		self.btn_invite:loadTextureNormal("InviteLayer/btn_invite_on.png", var_0_2)
		self.btn_beinvited:loadTextureNormal("InviteLayer/btn_beinvited.png", var_0_2)
		self:switchPanelByType()
	end

	function self.onBtnBeinvitedEventCallback(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curPanelType == var_0_0.BEINVITED then
			return
		end

		self.curPanelType = var_0_0.BEINVITED

		self.InviteManager:setCurPanelType(var_0_0.BEINVITED)
		self.btn_invite:loadTextureNormal("InviteLayer/btn_invite.png", var_0_2)
		self.btn_beinvited:loadTextureNormal("InviteLayer/btn_beinvited_on.png", var_0_2)
		self:switchPanelByType()
	end

	self.btn_invite:addTouchEventListener(function(arg_25_0, arg_25_1)
		self.onBtnInviteEventCallback(arg_25_0, arg_25_1)
	end)
	self.btn_beinvited:addTouchEventListener(function(arg_26_0, arg_26_1)
		self.onBtnBeinvitedEventCallback(arg_26_0, arg_26_1)
	end)
	self.btn_copy:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)
	self.btn_bind:addTouchEventListener(function(arg_28_0, arg_28_1)
		if arg_28_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.curInputBindUid == nil then
			global_ShowBlockWords("需输入UID")
		else
			local var_28_0 = {
				layerType = "InviteLayer",
				btnLabel = "确定",
				surecallback = function()
					self.InviteManager:bindUid(self.curInputBindUid, function()
						self:initPanelRedDotStatus()
						self:initPanel()
					end)
				end
			}

			require("view.Sprite.ConfirmDialogSprite")

			local var_28_1 = ConfirmDialogSprite:create("绑定确认", "确认绑定该UID吗？绑定后将不可修改哦~", var_28_0)

			var_28_1:setPositionY(var_28_1:getPositionY() - GameDisplay.fix_y)
			self:addChild(var_28_1, 1000)
		end
	end)
	self.btn_invite:setLocalZOrder(1)
	self.btn_beinvited:setLocalZOrder(1)
	self.bindPanelNode:setLocalZOrder(1)
	self.btn_share:setLocalZOrder(1)
end

function InviteLayer:initPanel()
	if self.InviteManager:isOldPlayer() then
		self.btn_beinvited:setVisible(false)
	else
		self.btn_beinvited:setVisible(true)
	end

	self.tipsNode:setVisible(true)
	self.tipsNode:setString(self.InviteManager:getTipsString())

	if self.curPanelType == nil or self.curPanelType == var_0_0.INVITE or self.InviteManager:isOldPlayer() then
		self.curPanelType = nil

		self.InviteManager:setCurPanelType(nil)
		self.onBtnInviteEventCallback(self.btn_invite, ccui.TouchEventType.ended)
	else
		self.curPanelType = nil

		self.InviteManager:setCurPanelType(nil)
		self.onBtnBeinvitedEventCallback(self.btn_beinvited, ccui.TouchEventType.ended)
	end

	self.shareTextNode:setString("已成功邀请" .. self.InviteManager:getInviteNums() .. "人")
	self.shareTextNode:setVisible(true)
end

function InviteLayer:switchPanelByType()
	self.bindPanelNode:setVisible(true)

	if self.curPanelType == var_0_0.INVITE then
		self.btn_copy:setVisible(false)
		self.btn_bind:setVisible(false)
		self.bindLabel:setString("我的UID：" .. self.InviteManager:getMySelfUid())
		self.bindLabel:setVisible(true)
		self.bindInputNode:setVisible(false)
	elseif self.InviteManager:isHaveBindUid() then
		self.btn_copy:setVisible(false)
		self.btn_bind:setVisible(false)
		self.bindLabel:setString("已绑定UID：" .. self.InviteManager:getCurBindUid())
		self.bindLabel:setVisible(true)
		self.bindInputNode:setVisible(false)
	elseif self.InviteManager:isOldPlayer() then
		self.btn_copy:setVisible(false)
		self.btn_bind:setVisible(false)
		self.bindLabel:setString("班长已经不是新玩家啦~去邀请可以获得奖励哦~")
		self.bindLabel:setVisible(true)
		self.bindInputNode:setVisible(false)
	else
		self.btn_copy:setVisible(false)
		self.btn_bind:setVisible(true)
		self.bindLabel:setVisible(false)
		self.bindInputNode:setVisible(true)
	end

	self:updateTaskPanel()
end

function InviteLayer.copyNodeWitchChildren(arg_33_0, arg_33_1)
	local var_33_0 = cc.Node:create()

	if arg_33_1 ~= nil then
		local var_33_1 = arg_33_1:getChildren()

		for iter_33_0 = 1, arg_33_1:getChildrenCount() do
			var_33_1[iter_33_0]:removeFromParent()
			var_33_0:addChild(var_33_1[iter_33_0])
		end
	end

	return var_33_0
end

function InviteLayer:updateTaskPanel()
	local var_34_0 = self.InviteManager:getCurTaskInfo(self.curPanelType)

	if var_34_0 == nil then
		return
	end

	local var_34_1 = var_34_0

	if self.taskPanelNode ~= nil then
		self.taskPanelNode:removeFromParent()
	end

	self.taskPanelNode = self:getTableView(var_34_1, #var_34_0, cc.size(585, 154), cc.size(580, 380), function(arg_35_0, arg_35_1, arg_35_2)
		local var_35_0 = arg_35_2[arg_35_1 + 1].list[arg_35_2[arg_35_1 + 1].curTaskIndex]
		local var_35_1 = arg_35_0:dequeueCell()

		if var_35_1 == nil then
			var_35_1 = cc.TableViewCell:new()
		end

		local var_35_3 = var_35_1:getChildByName("taskItem")

		if not var_35_3 then
			var_35_3 = self:copyNodeWitchChildren(self.taskItem1Node:clone())

			var_35_1:addChild(var_35_3)
			var_35_3:setVisible(true)
			var_35_3:setName("taskItem")
			var_35_3:setPosition(cc.p(0, 0))
		end

		local var_35_4 = var_35_3:getChildByName("name")
		local var_35_5 = var_35_3:getChildByName("rewardList")
		local var_35_6 = var_35_3:getChildByName("btn_get")
		local var_35_7 = var_35_3:getChildByName("btn_go")
		local var_35_8 = var_35_3:getChildByName("btn_finished")
		local var_35_9 = var_35_4:getChildByName("richText")

		if var_35_9 ~= nil then
			var_35_9:removeFromParent()
		end

		local var_35_10 = RichTextPro:create()

		var_35_10:setSize(22)
		var_35_10:setLineSpace(0)
		var_35_10:setText("<p><span style=color: rgb(255, 255, 255);>" .. var_35_0.name .. "(</span><span style=color: rgb(255, 222, 0);>" .. var_35_0.curProcess .. "/</span><span style=color: rgb(255, 255, 255);>" .. var_35_0.totalProcess .. ")</span></p>", nil, true)
		var_35_10:setName("richText")
		var_35_4:addChild(var_35_10)
		var_35_10:setPosition(cc.p(0, 30))
		var_35_4:setString("")

		if var_35_0.taskStatus == var_0_1.GET then
			var_35_6:setVisible(true)
			var_35_7:setVisible(false)
			var_35_8:setVisible(false)

			var_35_3.isShowReddot = true
		elseif var_35_0.taskStatus == var_0_1.GO then
			var_35_6:setVisible(false)
			var_35_7:setVisible(true)
			var_35_8:setVisible(false)

			var_35_3.isShowReddot = false
		else
			var_35_6:setVisible(false)
			var_35_7:setVisible(false)
			var_35_8:setVisible(true)

			var_35_3.isShowReddot = false
		end

		for iter_35_0 = 1, 3 do
			local var_35_11 = var_35_5:getChildByName("sp" .. iter_35_0)

			if var_35_11 == nil then
				var_35_11 = ItemSpriteActivityRecharge:createSignItem()

				var_35_5:addChild(var_35_11)
				var_35_11:setName("sp" .. iter_35_0)
				var_35_11:setInfoTouchEvent(true)
				var_35_11:setSwallowTouches(false)
			end

			if iter_35_0 <= #var_35_0.reward then
				var_35_11:setVisible(true)
				var_35_11:updateSignItemByItemid(var_35_0.reward[iter_35_0].itemid, var_35_0.reward[iter_35_0].num)
			else
				var_35_11:setVisible(false)
			end
		end

		var_35_5:setInnerContainerSize(cc.size(100 * #var_35_0.reward, 120))
		var_35_6:addTouchEventListener(function(arg_36_0, arg_36_1)
			if arg_36_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.curPanelType == var_0_0.BEINVITED and not self.InviteManager:isHaveBindUid() then
				global_ShowBlockWords("请先绑定UID才可以领取奖励哦~")

				return
			end

			self.InviteManager:getReward({
				type = self.curPanelType,
				index = arg_35_1 + 1
			}, function()
				self:initPanelRedDotStatus()
				self:updateTaskPanel()
			end)
		end)
		var_35_7:addTouchEventListener(function(arg_38_0, arg_38_1)
			if arg_38_1 ~= ccui.TouchEventType.ended then
				return
			end

			self.InviteManager:jumpToGo({
				type = self.curPanelType,
				index = arg_35_1 + 1
			}, function()
				return
			end)
		end)
		var_35_8:addTouchEventListener(function(arg_40_0, arg_40_1)
			if arg_40_1 ~= ccui.TouchEventType.ended then
				return
			end

			global_ShowBlockWords("奖励已领取")
		end)

		return var_35_1
	end, function(arg_41_0, arg_41_1)
		print("click ")
	end)

	self.taskPanelNode:setPosition(31, 250)
	self.rootLayout:addChild(self.taskPanelNode)

	local var_34_3 = cc.Node:create()

	var_34_3:setContentSize(cc.size(585, 154))
	var_34_3:setPosition(cc.p(30, 630))
	self.rootLayout:addChild(var_34_3)

	local var_34_4 = cc.Node:create()

	var_34_4:setContentSize(cc.size(585, 154))
	var_34_4:setPosition(cc.p(30, 96))
	self.rootLayout:addChild(var_34_4)
end

function InviteLayer.getTableView(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
	local var_42_0 = arg_42_3.width
	local var_42_1 = arg_42_3.height
	local var_42_2 = cc.TableView:create(arg_42_4)

	var_42_2:setVisible(true)
	var_42_2:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	var_42_2:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	var_42_2:setDelegate()
	var_42_2:registerScriptHandler(function(arg_43_0)
		return arg_42_2
	end, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	var_42_2:registerScriptHandler(function(arg_44_0)
		arg_42_0:scrollViewDidScroll(arg_44_0)
	end, cc.SCROLLVIEW_SCRIPT_SCROLL)
	var_42_2:registerScriptHandler(function(arg_45_0, arg_45_1)
		arg_42_6(arg_45_0, arg_45_1)
	end, cc.TABLECELL_TOUCHED)
	var_42_2:registerScriptHandler(function(arg_46_0, arg_46_1)
		return var_42_0, var_42_1
	end, cc.TABLECELL_SIZE_FOR_INDEX)
	var_42_2:registerScriptHandler(function(arg_47_0, arg_47_1)
		return arg_42_5(arg_47_0, arg_47_1, arg_42_1)
	end, cc.TABLECELL_SIZE_AT_INDEX)
	var_42_2:reloadData()
	var_42_2:setAnchorPoint(cc.p(0, 1))

	return var_42_2
end

function InviteLayer.scrollViewDidScroll(arg_48_0, arg_48_1)
	print("scrollViewDidScroll")
end

function InviteLayer:updatePanelReddotStatus(arg_49_1, arg_49_2)
	if arg_49_1 == nil then
		arg_49_1 = self.curPanelType
	end

	if arg_49_2 == nil then
		arg_49_2 = false

		if arg_49_1 == var_0_0.INVITE then
			for iter_49_0 = 1, self.taskPanelNode:getChildrenCount() do
				if self.taskPanelNode:getChildByName("taskItem" .. iter_49_0).isShowReddot == true then
					arg_49_2 = true

					break
				end
			end

			activity_manager:fireEvent(activity_manager.activityEventId.INVITE_IS_INVITE_REDDOT, arg_49_2)
		else
			for iter_49_1 = 1, self.taskPanelNode:getChildrenCount() do
				if self.taskPanelNode:getChildByName("taskItem" .. iter_49_1).isShowReddot == true then
					arg_49_2 = true

					break
				end
			end

			if arg_49_2 == false and not self.InviteManager:isHaveBindUid() then
				arg_49_2 = true
			end

			activity_manager:fireEvent(activity_manager.activityEventId.INVITE_IS_BEINVITED_REDDOT, arg_49_2)
		end
	elseif arg_49_1 == var_0_0.INVITE then
		activity_manager:fireEvent(activity_manager.activityEventId.INVITE_IS_INVITE_REDDOT, arg_49_2)
	else
		activity_manager:fireEvent(activity_manager.activityEventId.INVITE_IS_BEINVITED_REDDOT, arg_49_2)
	end
end
