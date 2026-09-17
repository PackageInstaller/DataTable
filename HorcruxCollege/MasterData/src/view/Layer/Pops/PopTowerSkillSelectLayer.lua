PopTowerSkillSelectLayer = class("PopTowerSkillSelectLayer", function()
	return PopBaseLayer:create()
end)

local Utility = require("common.Utility")
local EventManager = require("common.EventManager")
local levelmode_data = require("data.levelmode_data")
local var_0_3 = require("controller.weekly_tower_manager").getInstance()
local var_0_4 = config._DEBUG and 0 or 1
local var_0_5 = {
	SKILL = 2,
	SELECT = 1
}

function PopTowerSkillSelectLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopTowerSkillSelectLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopTowerSkillSelectLayer:init(arg_3_1)
	self:initData(arg_3_1)
	self:initUI()
	self:registerEvents()
	self:checkWeeklyAutoFight()
end

function PopTowerSkillSelectLayer.initData(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0.panelType = arg_4_1.panelType or var_0_5.SELECT
	end

	if arg_4_1 then
		arg_4_0.skills = arg_4_1.skills or {}
	end

	if arg_4_1 then
		arg_4_0.cancelCallBack = arg_4_1.cancelCallBack or nil
	end

	arg_4_0.mode = arg_4_1 and arg_4_1.mode
	arg_4_0.chapter = arg_4_1 and arg_4_1.chapter
	arg_4_0.curSkillData = nil
end

function PopTowerSkillSelectLayer:initUI()
	self.rootNode = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopTowerSkillSelectLayer.json" or "PopTowerSkillSelectLayer.ExportJson")

	self.rootNode:setContentSize(GameDisplay.size)
	self.rootNode:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootNode)

	self.rootpanel = self.rootNode:getChildByName("panelRoot")

	self.rootpanel:setAnchorPoint(0.5, 0.5)
	self.rootpanel:setPositionX(GameDisplay.size.width / 2)
	self.rootpanel:setPositionY(GameDisplay.size.height / 2)
	self.rootpanel:setTouchEnabled(false)

	self.panelMain = self.rootpanel:getChildByName("panelMain")

	Utility:alignPanelByParent(self.panelMain, self.rootpanel)

	local var_5_0 = ccui.ImageView:create("mainScenebg/expedition_mask.png")

	var_5_0:setPositionType(1)
	var_5_0:setAnchorPoint(0.5, 1)
	var_5_0:setPositionPercent(cc.p(0.5, 1))
	self.panelMain:addChild(var_5_0, -1)

	self.imgTitleSelect = self.panelMain:getChildByName("imgTitleSelect")
	self.imgTitleSkill = self.panelMain:getChildByName("imgTitleSkill")
	self.listViewSkills = self.panelMain:getChildByName("listViewSkills")

	self.listViewSkills:setContentSize(cc.size(config._DESIGN_WIDTH, self.listViewSkills:getContentSize().height + GameDisplay.height - config._DESIGN_HEIGHT - 20))

	self.listViewSelectSkills = self.panelMain:getChildByName("listViewSelectSkills")
	self.btnConfirm = self.panelMain:getChildByName("btnConfirm")
	self.panelItem = self.panelMain:getChildByName("panelItem")

	self.panelItem:retain()
	self.panelItem:removeFromParent()
	self:initBottomBtn()
	self:updateLayout()
end

function PopTowerSkillSelectLayer:initBottomBtn()
	require("view.Sprite.BottomBtnList")

	self.bottomBtnList = BottomBtnList:create(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.returnLayer then
			LayerManager:switchReturnLayer(self.returnLayer)
		else
			KeyCodeManager:onKeyReleasedCallFunc()
		end
	end)

	self.bottomBtnList:setPositionY(GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, 0, TRANSFORM_UNIT.PX))
	self:addChild(self.bottomBtnList, 10)
end

function PopTowerSkillSelectLayer:registerEvents()
	Utility:registerNodeEvent(self)
	Utility:addClickEventListener(self.btnConfirm, handler(self, self.onBtnConfirm))
	EventManager:subscribe(self, EventManager.EVENT_IDS.SET_WEEKLY_TOWER_SKILL, handler(self, self.handleSetTowerSkill))
end

function PopTowerSkillSelectLayer:updateLayout()
	self.imgTitleSelect:setVisible(self.panelType == var_0_5.SELECT)
	self.imgTitleSkill:setVisible(self.panelType == var_0_5.SKILL)
	self.listViewSkills:setVisible(self.panelType == var_0_5.SKILL)
	self.bottomBtnList:setVisible(self.panelType == var_0_5.SKILL)
	self.btnConfirm:setVisible(self.panelType == var_0_5.SELECT)

	if self.panelType == var_0_5.SELECT then
		self:updateSelectUI()
	else
		self:updateSkillUI()
	end
end

function PopTowerSkillSelectLayer:updateSelectUI()
	self.firstItem = {}

	self.listViewSelectSkills:removeAllChildren()
	self.listViewSelectSkills:setClippingEnabled(false)

	for iter_10_0, iter_10_1 in ipairs(self.skills) do
		local var_10_0 = self.panelItem:clone()

		self:updatePanelItem(var_10_0, iter_10_1)
		var_10_0:setScale(0.9)
		self.listViewSelectSkills:pushBackCustomItem(var_10_0)

		if iter_10_0 == 1 then
			self.firstItem.panelItem = var_10_0
			self.firstItem.data = iter_10_1
		end
	end
end

function PopTowerSkillSelectLayer:updateSkillUI()
	self.listViewSkills:removeAllChildren()

	for iter_11_0 = 1, math.ceil(#self.skills / 3) do
		local var_11_0 = self.listViewSelectSkills:clone()

		for iter_11_1 = 1, Utility:clamp(#self.skills - 3 * (iter_11_0 - 1), 0, 3) do
			local var_11_1 = self.panelItem:clone()

			self:updatePanelItem(var_11_1, self.skills[3 * (iter_11_0 - 1) + iter_11_1])
			var_11_0:pushBackCustomItem(var_11_1)
		end

		self.listViewSkills:pushBackCustomItem(var_11_0)
	end
end

function PopTowerSkillSelectLayer:updatePanelItem(arg_12_1, arg_12_2)
	arg_12_1:setAnchorPoint(0.5, 0.5)
	arg_12_1:getChildByName("imgSelect"):setVisible(false)
	arg_12_1:getChildByName("imgBorder"):loadTexture(string.format("ExpeditionLayer/skill_bg%d.png", arg_12_2.rarity), var_0_4)
	arg_12_1:getChildByName("imgSkill"):loadTexture(string.format("skill_new/skill/%s.png", arg_12_2.icon), var_0_4)
	arg_12_1:getChildByName("labelName"):setString(arg_12_2.name)
	arg_12_1:getChildByName("labelInfo"):setString(arg_12_2.des)
	Utility:addClickEventListener(arg_12_1, handler(self, self.onPanelItem), arg_12_2)
end

function PopTowerSkillSelectLayer:onPanelItem(arg_13_1, arg_13_2)
	if self.panelType ~= var_0_5.SELECT then
		return
	end

	if arg_13_1 == self.curPanelItem then
		return
	end

	if self.curPanelItem then
		self.curPanelItem:setScale(0.9)
		self.curPanelItem:getChildByName("imgSelect"):setVisible(false)
	end

	self.curPanelItem = arg_13_1

	self.curPanelItem:setScale(1)
	self.curPanelItem:getChildByName("imgSelect"):setVisible(true)

	self.curSkillData = arg_13_2
end

function PopTowerSkillSelectLayer:onBtnConfirm(arg_14_1)
	if not self.curPanelItem then
		global_ShowBlockWords("请选择一个技能增益")

		return
	end

	var_0_3:requestSetWeeklyTowerSkill(self.mode, self.chapter, self.curSkillData.skillId)
end

function PopTowerSkillSelectLayer.OnBtnExit(arg_15_0)
	return
end

function PopTowerSkillSelectLayer.onEnter(arg_16_0)
	return
end

function PopTowerSkillSelectLayer:onExit()
	self.panelItem:release()
	EventManager:unsubscribe(self)
end

function PopTowerSkillSelectLayer:show()
	self.showActions.extendVertical(self)
end

function PopTowerSkillSelectLayer:hide()
	self.hideActions.shrinkVertical(self, function()
		if self.cancelCallBack then
			self.cancelCallBack()
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end

function PopTowerSkillSelectLayer:handleSetTowerSkill(arg_21_1)
	if not arg_21_1 then
		return
	end

	if arg_21_1.result == 1 then
		self:hide()
	end
end

function PopTowerSkillSelectLayer:checkWeeklyAutoFight()
	if not self.mode then
		return
	end

	if not levelmode_data[self.mode] then
		return
	end

	local var_22_0 = levelmode_data[self.mode].modetype

	if not levelmode_data[self.mode].modetype then
		return
	end

	if require("controller.weekly_tower_manager").getInstance():isWeeklyTowerModetpye(var_22_0) == false then
		return
	end

	if RoleDefault:getInstance():getBoolForKey("WeeklyAutoFight", false) then
		global_count_down_layer(4, function()
			self:onPanelItem(self.firstItem.panelItem, self.firstItem.data)
			self:onBtnConfirm()
		end, function()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("set_weekly_autofight_false")))
			RoleDefault:getInstance():setBoolForKey("WeeklyAutoFight", false)
		end)
	end
end
