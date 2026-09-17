PopRecruitTasksLayer = class("PopRecruitTasksLayer", function()
	return cc.Layer:create()
end)

local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local Utility = require("common.Utility")
local item_data = require("data.item_data")
local var_0_4 = {
	CAN_TASK = 2,
	HAVE_TASK = 3,
	GO_TASK = 1
}

setmetatable({
	"PopRecruitTasksLayer/btn_go.png",
	"PopRecruitTasksLayer/btn_give.png",
	"PopRecruitTasksLayer/btn_get.png",
	"PopRecruitTasksLayer/btn_finished.png"
}, {
	__index = function()
		return "PopRecruitTasksLayer/btn_go.png"
	end
})

local var_0_5 = config._DEBUG and 0 or 1

function PopRecruitTasksLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = PopRecruitTasksLayer.new()

	var_3_0:onLoad(arg_3_1)

	return var_3_0
end

function PopRecruitTasksLayer:init(arg_4_1)
	self:initData(arg_4_1)
	self:initUI()
	self:registerEvents()
end

function PopRecruitTasksLayer.initData(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0.activityId = arg_5_1.activityId or 0
	end

	if arg_5_1 then
		arg_5_0.servantId = arg_5_1.servantId or 0
	end
end

function PopRecruitTasksLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopRecruitTasksLayer.json" or "PopRecruitTasksLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.panelItem = self.rootNode:getChildByName("item")

	self.panelItem:setVisible(true)
	self.panelItem:retain()
	self.panelItem:removeFromParent()

	self.listViewTasks = self.rootNode:getChildByName("listView")

	self:initPanel()
	self:fullscreen()
end

function PopRecruitTasksLayer:initPanel()
	self:updateListViewTasks()
end

function PopRecruitTasksLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.rootNode, handler(self, self.hide))
	activity_manager:registerEventListener(self.layerName, activity_manager.activityEventId.COMPLETE_RECURIT_TASK, handler(self, self.handleCompleteRecuritTask))
end

function PopRecruitTasksLayer:updateListViewTasks()
	if self.listViewTasks == nil then
		return
	end

	self.listViewTasks:removeAllChildren()

	for iter_9_0, iter_9_1 in ipairs((activity_manager:get_recurit_tasks(self.activityId, self.servantId))) do
		self.listViewTasks:pushBackCustomItem((self:createOnePanelTask(iter_9_1)))
	end

	self.listViewTasks:doLayout()
	self.listViewTasks:jumpToPercentVertical(0)
end

function PopRecruitTasksLayer:createOnePanelTask(arg_10_1)
	local var_10_0 = self.panelItem:clone()

	self:updateOnePanelTask(var_10_0, arg_10_1)

	return var_10_0
end

function PopRecruitTasksLayer:updateOnePanelTask(arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:getChildByName("btn_operate")

	arg_11_1:getChildByName("progress"):setLocalZOrder(var_11_0:getLocalZOrder() + 1)
	Utility:addClickEventListener(var_11_0, handler(self, self.onBtnStatus), arg_11_2)

	local var_11_1 = arg_11_1:getChildByName("name")

	arg_11_1:getChildByName("title"):setString(arg_11_2.name)
	arg_11_1:getChildByName("progress"):getChildByName("bar"):setScaleX(arg_11_2.percent / 100)
	arg_11_1:getChildByName("progress"):getChildByName("progress_num"):setString(arg_11_2.finished .. "/" .. arg_11_2.need)

	local var_11_2 = Utility:getDropData(arg_11_2.drop)

	self:updateAlert(var_11_0, arg_11_2)
	var_11_0:loadTextures(arg_11_2.status == var_0_4.GO_TASK and arg_11_2.jump == 3070 and "PopRecruitTasksLayer/btn_give.png" or arg_11_2.status == var_0_4.GO_TASK and arg_11_2.jump ~= 3070 and "PopRecruitTasksLayer/btn_go.png" or arg_11_2.status == var_0_4.CAN_TASK and arg_11_2.jump == 3070 and "PopRecruitTasksLayer/btn_give.png" or arg_11_2.status == var_0_4.CAN_TASK and arg_11_2.jump ~= 3070 and "PopRecruitTasksLayer/btn_get.png" or "PopRecruitTasksLayer/btn_finished.png", arg_11_2.status == var_0_4.GO_TASK and arg_11_2.jump == 3070 and "PopRecruitTasksLayer/btn_give.png" or arg_11_2.status == var_0_4.GO_TASK and arg_11_2.jump ~= 3070 and "PopRecruitTasksLayer/btn_go.png" or arg_11_2.status == var_0_4.CAN_TASK and arg_11_2.jump == 3070 and "PopRecruitTasksLayer/btn_give.png" or arg_11_2.status == var_0_4.CAN_TASK and arg_11_2.jump ~= 3070 and "PopRecruitTasksLayer/btn_get.png" or "PopRecruitTasksLayer/btn_finished.png", arg_11_2.status == var_0_4.GO_TASK and arg_11_2.jump == 3070 and "PopRecruitTasksLayer/btn_give.png" or arg_11_2.status == var_0_4.GO_TASK and arg_11_2.jump ~= 3070 and "PopRecruitTasksLayer/btn_go.png" or arg_11_2.status == var_0_4.CAN_TASK and arg_11_2.jump == 3070 and "PopRecruitTasksLayer/btn_give.png" or arg_11_2.status == var_0_4.CAN_TASK and arg_11_2.jump ~= 3070 and "PopRecruitTasksLayer/btn_get.png" or "PopRecruitTasksLayer/btn_finished.png", var_0_5)

	local var_11_4 = var_11_2[1]
	local var_11_5 = ItemNoBgSprite:create(var_11_2[1].itemid, true)

	var_11_5:setName("item")
	var_11_5:setAnchorPoint(cc.p(0, 0))
	var_11_5:setPosition(cc.p(80, 80))
	var_11_5:setScale(0.8)
	arg_11_1:addChild(var_11_5)
	var_11_1:setString((var_11_4.itemid == "diamond" and L_DIAMOND or var_11_4.itemid == "gold" and L_GOLD or item_data[var_11_4.itemid].name) .. " x" .. var_11_4.num)
end

function PopRecruitTasksLayer.updateAlert(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = false

	var_12_0 = arg_12_2.status == var_0_4.CAN_TASK and true or arg_12_2 and false or var_12_0

	if var_12_0 then
		global_add_alert_tag(arg_12_1)
	else
		global_remove_alert_tag(arg_12_1)
	end
end

function PopRecruitTasksLayer:onBtnStatus(arg_13_1, arg_13_2)
	if arg_13_2.status == var_0_4.CAN_TASK and arg_13_2.jump ~= 3070 then
		activity_manager:complete_recurit_task(self.activityId, self.servantId, arg_13_2.index)
	elseif arg_13_2.status == var_0_4.GO_TASK or arg_13_2.status == var_0_4.CAN_TASK and arg_13_2.jump == 3070 then
		Utility:executeLayerJump({
			systemid = arg_13_2.jump,
			initparam = {
				taskid = arg_13_2.taskid,
				servantId = self.servantId,
				activityId = self.activityId
			}
		})
	end
end

function PopRecruitTasksLayer.onEnter(arg_14_0)
	return
end

function PopRecruitTasksLayer:onExit()
	self.panelItem:release()
	activity_manager:releaseEventListener(self.layerName, activity_manager.activityEventId.COMPLETE_RECURIT_TASK)
end

function PopRecruitTasksLayer.hide(arg_16_0)
	LayerManager:removePopLayer()
end

function PopRecruitTasksLayer:handleCompleteRecuritTask(arg_17_1)
	if not arg_17_1 then
		return
	end

	if arg_17_1.result == 1 then
		self:initPanel()
	end
end

function PopRecruitTasksLayer:onLoad(arg_18_1)
	local var_18_0 = ccui.Layout:create()

	var_18_0:setTouchEnabled(true)
	var_18_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_18_0:setAnchorPoint(cc.p(0, 0))
	var_18_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_18_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_18_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_18_0:setOpacity(0)
	var_18_0:setCascadeOpacityEnabled(false)
	self:addChild(var_18_0, -1)

	local var_18_1 = ccui.ImageView:create("mainScenebg/black1.jpg")

	var_18_1:setAnchorPoint(cc.p(0, 0))
	var_18_1:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_18_1:setOpacity(120)
	var_18_1:isScale9Enabled(true)
	var_18_1:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_19_0)
		self:addChild(arg_19_0, -2)
		arg_19_0:setPositionY(arg_19_0:getPositionY() - GameDisplay.fix_y)
		var_18_0:addChild(var_18_1)
		self:init(arg_18_1)
		var_18_0:setOpacity(102)
		var_18_0:setTouchEnabled(false)
	end)
end

function PopRecruitTasksLayer:fullscreen()
	self.rootNode:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootNode:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))

	for iter_20_0, iter_20_1 in pairs({}) do
		local var_20_0 = self.rootNode:getChildByName(iter_20_1)

		var_20_0:setLocalZOrder(1)

		var_20_0.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, var_20_0:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_20_0:setPositionY(var_20_0.full_posY)
	end

	for iter_20_2, iter_20_3 in pairs({
		"bg",
		"listView"
	}) do
		local var_20_1 = self.rootNode:getChildByName(iter_20_3)

		var_20_1:setLocalZOrder(1)

		var_20_1.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - var_20_1:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

		var_20_1:setPositionY(var_20_1.full_posY)
	end
end
