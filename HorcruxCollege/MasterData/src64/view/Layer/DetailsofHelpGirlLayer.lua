DetailsofHelpGirlLayer = class("DetailsofHelpGirlLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local model_data = require("data.model_data")
local photofile_HelpGirl_data = require("data.photofile_HelpGirl_data")
local horcrux_data = require("data.horcrux_data")
local total_skill_data = require("data.total_skill_data")
local item_data = require("data.item_data")
local horcrux_manager = require("controller.horcrux_manager")
local layer_manager = require("controller.layer_manager")

function DetailsofHelpGirlLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = DetailsofHelpGirlLayer.new()

	var_2_0:init(arg_2_1.id, arg_2_1.itemid, arg_2_1.callback)

	return var_2_0
end

function DetailsofHelpGirlLayer:fullScreen()
	self.imageTalk:setPositionY(self.imageTalk:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	self.imageHeadBottom:setPositionY(self.imageHeadBottom:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	self.imageInfo:setPositionY(self.imageInfo:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_3_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_23")

	var_3_0:setPositionY(var_3_0:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_3_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_21")

	var_3_1:setPositionY(var_3_1:getPositionY() - GameDisplay.fix_y)

	local var_3_2 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_skillPanelFrame")

	var_3_2:setPositionY(var_3_2:getPositionY() - GameDisplay.notch_height / 2)
	var_3_2:setContentSize(cc.size(var_3_2:getContentSize().width, var_3_2:getContentSize().height + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT))

	local var_3_3 = ccui.Helper:seekWidgetByName(self.rootlayer, "ListView_skill")

	var_3_3:setContentSize(cc.size(var_3_3:getContentSize().width, var_3_3:getContentSize().height + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT))
	var_3_3:setPositionY(var_3_3:getPositionY())

	local var_3_4 = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_50_0")

	var_3_4:setPositionY(var_3_4:getPositionY() + GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT)

	local var_3_5 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_22")

	var_3_5:setPositionY(var_3_5:getPositionY() - GameDisplay.fix_y)
	self.talking_text:setPositionY(self.talking_text:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
end

function DetailsofHelpGirlLayer:init(arg_4_1, arg_4_2, arg_4_3)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PhotoFile_helpGirl.json" or "PhotoFile_helpGirl.ExportJson")

	self:addChild(self.rootlayer)

	self.id = arg_4_1
	self.returnbtn = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_return")

	self.returnbtn:setVisible(false)

	self.getWay = ccui.Helper:seekWidgetByName(self.rootlayer, "Button_getWay")

	self.getWay:setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_21"):setVisible(false)

	local var_4_0 = ccui.Layout:create()

	var_4_0:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_4_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	var_4_0:setAnchorPoint(0, 0)
	var_4_0:setTouchEnabled(true)
	var_4_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	self:addChild(var_4_0, -1)

	self.imageBack = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_back")

	self.imageBack:loadTexture("mainScenebg/roledatabg.jpg")

	self.help_name = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_name")
	self.imageRarity = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_rarity")
	self.imageHead = ccui.ImageView:create()
	self.imageHeadBottom = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_head")

	self.imageHead:setScale(0.8)
	self.imageHead:setPosition(cc.p(self.imageHeadBottom:getContentSize().width / 2, self.imageHeadBottom:getContentSize().height / 2 + 110))
	self.imageHeadBottom:addChild(self.imageHead, 999)

	self.panelSkill = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_skill")
	self.imageSkill = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_skill")
	self.imageInfo = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_info")
	self.panelStartOne = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_startOne")
	self.imageTalk = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_talk")
	self.talking_text = ccui.Helper:seekWidgetByName(self.rootlayer, "Label_quotations")
	self.panelInfo = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_info")
	self.panelSkillContianer = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_skillContianer")

	ccui.Helper:seekWidgetByName(self.rootlayer, "Image_line_role_frame"):setVisible(false)

	self.imageAttr = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_attr")
	self.Panel_back = ccui.Helper:seekWidgetByName(self.rootlayer, "Panel_back")

	self:showHelpGirlInfo(arg_4_1, arg_4_2)

	self.bottomList = BottomBtnList:create(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		TextureManager:unregisterTexture("PhotoFileHelpGirlLayer")
		self:exit()

		if arg_4_3 then
			arg_4_3()
		end
	end)

	self.bottomList:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.bottomList, 1000)
	self:enterAnim()
	self:fullScreen()

	return true
end

function DetailsofHelpGirlLayer:enterAnim()
	local var_6_0 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_23")
	local var_6_1 = ccui.Helper:seekWidgetByName(self.rootlayer, "Image_skillPanelFrame")

	var_6_0:setOpacity(0)
	var_6_1:setOpacity(0)
	self.bottomList:setOpacity(0)
	self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
		var_6_0:runAction(cc.FadeIn:create(0.5))
	end), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		var_6_1:runAction(cc.FadeIn:create(0.5))
	end), cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		self.bottomList:runAction(cc.FadeIn:create(0.5))
	end)))
end

function DetailsofHelpGirlLayer.getAttrIconPath(arg_10_0, arg_10_1)
	return global_get_model_attr(horcrux_data[arg_10_1].model)
end

function DetailsofHelpGirlLayer:showHelpGirlInfo(arg_11_1, arg_11_2)
	if not self.init then
		self.init = true

		self:initHelpGirlDetailElementNew()
	end

	ccui.Helper:seekWidgetByName(self.rootlayer, "Label_50_0"):setVisible(false)
	self.imageHead:loadTexture("roleimage/role1/" .. model_data[photofile_HelpGirl_data[self.id].model_id].cute_role .. ".png")

	local var_11_0 = split(photofile_HelpGirl_data[self.id].declaration, "—")[1]
	local var_11_1 = cc.Label:createWithTTF(var_11_0, FONT_NAME, 19)

	var_11_1:setMaxLineWidth(260)
	var_11_1:setAnchorPoint(cc.p(0, 1))
	self.Panel_back:addChild(var_11_1, 999)
	self.talking_text:setString(var_11_0)
	self.talking_text:setVisible(false)

	local var_11_2 = var_11_1:getContentSize()

	self.imageTalk:setPositionY(self.imageTalk:getPositionY() + 20)
	self.imageTalk:setScaleX(var_11_2.width / self.imageTalk:getContentSize().width + 0.1)
	self.imageTalk:setScaleY(var_11_2.height / self.imageTalk:getContentSize().height + 0.5)
	var_11_1:setPositionX(self.imageTalk:getPositionX() - var_11_1:getContentSize().width / 2)
	var_11_1:setPositionY(self.imageTalk:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)

	local var_11_3 = photofile_HelpGirl_data[self.id].item_id or 3050926
	local var_11_5 = L_SHOW_HORCRUX_INFO.skill1Name
	local var_11_6 = L_SHOW_HORCRUX_INFO.skill2Name
	local var_11_7 = L_SHOW_HORCRUX_INFO.skill1Des
	local var_11_8 = L_SHOW_HORCRUX_INFO.skill2Des
	local var_11_9
	local var_11_10

	if horcrux_data[var_11_3].skill1 then
		var_11_5 = total_skill_data[horcrux_data[var_11_3].skill1].name
		var_11_9 = total_skill_data[horcrux_data[var_11_3].skill1].icon
		var_11_7 = total_skill_data[horcrux_data[var_11_3].skill1].description
	end

	if horcrux_data[var_11_3].skill2 then
		var_11_6 = total_skill_data[horcrux_data[var_11_3].skill2].name
		var_11_10 = total_skill_data[horcrux_data[var_11_3].skill2].icon
		var_11_8 = total_skill_data[horcrux_data[var_11_3].skill2].description
	end

	self.imageAttr:loadTexture(CAREER_ICON[horcrux_data[var_11_3].career .. "_" .. self:getAttrIconPath(var_11_3)], var_0_0)
	self.help_name:setString(horcrux_data[var_11_3].name)
	self.getWay:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		layer_manager:pushInLayer("PopGoGainLayer", {
			goto_back_system_id = 171,
			item = var_11_3,
			goto_back_system_config = {
				initPage = glob_parms.contentType.leftSelectIndex
			},
			surecallback = function(arg_13_0)
				if require("controller.layerconfig.pop_layer_infos")[arg_13_0] then
					-- block empty
				else
					self:exit()
				end
			end
		})
	end)

	while horcrux_data[var_11_3]["fac_range_damage_" .. 1] do
		if horcrux_data[var_11_3]["star_weight_" .. 1] and horcrux_data[var_11_3]["star_weight_" .. 1] > 0 then
			local var_11_11 = self.panelStartOne:clone()
			local var_11_12 = math.floor(tonumber(string.split(horcrux_data[var_11_3]["fac_range_hp_" .. 1], ",")[1]) / 100)
			local var_11_13 = math.floor(tonumber(string.split(horcrux_data[var_11_3]["fac_range_hp_" .. 1], ",")[2]) / 100)
			local var_11_14 = tonumber(string.split(horcrux_data[var_11_3]["fac_range_damage_" .. 1], ",")[1]) / 100
			local var_11_15 = tonumber(string.split(horcrux_data[var_11_3]["fac_range_damage_" .. 1], ",")[2]) / 100

			var_11_11:getChildByName("Label_start"):setString(1 .. L_QUALITY_STAR)
			var_11_11:getChildByName("Label_30"):setString(var_11_14 .. "~" .. var_11_15)
			var_11_11:getChildByName("Label_31"):setString(var_11_12 .. "~" .. var_11_13)
			var_11_11:setPosition(cc.p(14, 225))
			self.imageInfo:addChild(var_11_11, 999)
		end
	end

	self.imageRarity:loadTexture(FONT_RARITY_ICON[horcrux_data[photofile_HelpGirl_data[self.id].item_id].rarity], var_0_0)
	self.imageRarity:setPosition(cc.p(self.help_name:getPositionX() + self.help_name:getContentSize().width + 20, self.help_name:getPositionY()))
	self.imageSkill:getChildByName("Label_skillDesc"):setContentSize(cc.size(318, 90))
	self.imageSkill:getChildByName("Label_skillDesc"):setVisible(false)

	local var_11_18 = ccui.ScrollView:create()

	var_11_18:setContentSize(cc.size(330, 90))
	var_11_18:setDirection(ccui.ScrollViewDir.vertical)
	var_11_18:setBounceEnabled(true)
	var_11_18:setName("scrollView")
	var_11_18:setInnerContainerSize(cc.size(325, 90))
	var_11_18:setAnchorPoint(cc.p(0, 1))
	var_11_18:setPosition(113, 60)
	self.imageSkill:addChild(var_11_18)

	local var_11_19 = cc.Label:createWithTTF("", FONT_NAME, 20)

	var_11_19:setAnchorPoint(cc.p(0, 1))
	var_11_19:setMaxLineWidth(318)
	var_11_19:setPosition(cc.p(0, 90))
	var_11_19:setName("skillDes")
	var_11_18:addChild(var_11_19)

	local var_11_20 = cc.Label:createWithTTF("", FONT_NAME, 20)

	var_11_20:setMaxLineWidth(318)

	local var_11_22 = self.imageSkill:clone()
	local var_11_23

	if var_11_9 then
		var_11_23 = ccui.ImageView:create("skill_new/skill/" .. var_11_9 .. ".png", var_0_0) or ccui.ImageView:create("roleimage/role1/" .. model_data[photofile_HelpGirl_data[self.id].model_id].cute_role .. ".png")
	end

	var_11_23:setScale(0.85)

	if not var_11_9 then
		var_11_23:setAnchorPoint(cc.p(0.5, 0.5))
		var_11_23:setScale(0.35)
	end

	self.imageSkill:getChildByName("Panel_head"):addChild(var_11_23, 999)
	self.imageSkill:getChildByName("Label_skillName"):setString(var_11_5)
	self.imageSkill:getChildByName("scrollView"):getChildByName("skillDes"):setString(var_11_7)
	var_11_20:setString(var_11_7)
	var_11_18:setContentSize(cc.size(330, var_11_20:getContentSize().height > 90 and 90 or var_11_20:getContentSize().height + 10))
	var_11_18:setInnerContainerSize(cc.size(330, var_11_20:getContentSize().height + 10))
	var_11_19:setPositionY(var_11_20:getContentSize().height + 10)
	self.imageSkill:getChildByName("Label_skillDesc"):getVirtualRenderer():setMaxLineWidth(308)
	var_11_23:setPosition(cc.p(self.imageSkill:getChildByName("Panel_head"):getContentSize().width / 2, self.imageSkill:getChildByName("Panel_head"):getContentSize().height / 2))
	self.imageSkill:setPosition(cc.p(650, 65 + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT) / 2))

	local var_11_24

	if var_11_10 then
		var_11_24 = ccui.ImageView:create("skill_new/skill/" .. var_11_10 .. ".png", var_0_0) or ccui.ImageView:create("roleimage/role1/" .. model_data[photofile_HelpGirl_data[self.id].model_id].cute_role .. ".png")
	end

	var_11_24:setScale(0.85)

	if not var_11_10 then
		var_11_24:setAnchorPoint(cc.p(0.5, 0.5))
		var_11_24:setScale(0.35)
	end

	var_11_22:getChildByName("Panel_head"):addChild(var_11_24, 99)
	var_11_22:getChildByName("Label_skillName"):setString(var_11_6)

	local var_11_25 = cc.Label:createWithTTF("", FONT_NAME, 20)

	var_11_25:setAnchorPoint(cc.p(0, 1))
	var_11_25:setMaxLineWidth(318)
	var_11_25:setPosition(cc.p(0, 90))
	var_11_25:setName("skillDes")
	var_11_22:getChildByName("scrollView"):addChild(var_11_25)
	var_11_22:getChildByName("scrollView"):getChildByName("skillDes"):setString(var_11_8)
	var_11_20:setString(var_11_8)
	var_11_22:getChildByName("scrollView"):setContentSize(cc.size(330, var_11_20:getContentSize().height > 90 and 90 or var_11_20:getContentSize().height + 10))
	var_11_22:getChildByName("scrollView"):setInnerContainerSize(cc.size(330, var_11_20:getContentSize().height + 10))
	var_11_22:getChildByName("scrollView"):getChildByName("skillDes"):setPositionY(var_11_20:getContentSize().height + 10)
	var_11_22:getChildByName("Label_skillDesc"):getVirtualRenderer():setMaxLineWidth(308)
	var_11_24:setPosition(cc.p(var_11_22:getChildByName("Panel_head"):getContentSize().width / 2, var_11_22:getChildByName("Panel_head"):getContentSize().height / 2))
	var_11_22:setPosition(cc.p(650, -115 + (GameDisplay.getUiScreenSize().height - config._DESIGN_HEIGHT) / 2))
	self.panelSkillContianer:addChild(var_11_22, 999)

	if not var_11_10 then
		local var_11_27 = item_data[var_11_3].image_offset_y or 0

		var_11_24:setPositionX(var_11_24:getPositionX() + (item_data[var_11_3].image_offse_x or 0))
		var_11_24:setPositionY(var_11_24:getPositionY() + var_11_27)
	end

	local var_11_28 = cc.ParticleSystemQuad:create("effect/particle/pop.plist")

	var_11_28:setAutoRemoveOnFinish(true)
	var_11_28:setPosition(cc.p(self.imageHeadBottom:getContentSize().width / 2, self.imageHeadBottom:getContentSize().height / 2 + 20))
	self.imageHeadBottom:addChild(var_11_28, 999)
end

function DetailsofHelpGirlLayer:exit()
	if self:getParent():getName() ~= "SignLayer" then
		if self:getParent():getName() == "ActivitySignLayer" then
			if self.info and next(self.info) ~= nil then
				PhotoDetailLayerInstance = nil
			end

			self:runAction(cc.RemoveSelf:create())
		elseif self.info and next(self.info) ~= nil then
			layer_manager:removePopLayer()

			PhotoDetailLayerInstance = nil
		end
	end

	layer_manager:removePopLayer()
end

function DetailsofHelpGirlLayer.getAttrIconPath(arg_15_0, arg_15_1)
	return global_get_model_attr(horcrux_data[arg_15_1].model)
end
