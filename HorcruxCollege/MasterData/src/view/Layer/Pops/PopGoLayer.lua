PopGoLayer = class("PopGoLayer", function()
	return PopBaseLayer:create()
end)

local level_manager = require("controller.level_manager")
local sign_manager = require("controller.sign_manager")

function PopGoLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopGoLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopGoLayer:init(arg_3_1)
	self.rootpanel = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Cost_confirm.json" or "Cost_confirm.ExportJson")

	self:addChild(self.rootpanel)
	self.rootpanel:setLocalZOrder(999)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			LayerManager:removePopLayer(self.__queueindex)
		end)
	end)
	ccui.Helper:seekWidgetByName(self.rootpanel, "Panel_45"):setAnchorPoint(cc.p(0.5, 0.5))

	local var_3_0 = ccui.Helper:seekWidgetByName(self.rootpanel, "panel_bottom")
	local var_3_1 = ccui.Helper:seekWidgetByName(self.rootpanel, "label_left_time")

	ccui.Helper:seekWidgetByName(self.rootpanel, "image_catoon"):loadTexture("roleimage/role1/100.png")
	var_3_0:setPosition(0, 568)
	var_3_0:setBackGroundColorOpacity(180)
	var_3_0:setBackGroundColor(cc.c3b(26, 29, 33))
	var_3_0:setAnchorPoint(cc.p(0, 0.5))
	ccui.Helper:seekWidgetByName(self.rootpanel, "image_line"):setScale(1, 2)
	ccui.Helper:seekWidgetByName(self.rootpanel, "label_lack"):setString(arg_3_1.labels.des)
	ccui.Helper:seekWidgetByName(self.rootpanel, "label_name"):setString(arg_3_1.labels.title)
	ccui.Helper:seekWidgetByName(self.rootpanel, "label_go"):setString(arg_3_1.labels.button)

	local function var_3_2(arg_6_0)
		if arg_6_0.targetlayer ~= nil then
			LayerManager:removePopLayer(self.__queueindex)

			if arg_6_0.targetlayer == "TopPlotListLayer" then
				LayerManager:pushInLayer("TopPlotListLayer")
			end

			local var_6_0 = cc.EventCustom:new("switchShowLayer")

			if arg_6_0.targetlayer == "CommandLayer" or arg_6_0.targetlayer == "SmeltLayer" or arg_6_0.targetlayer == "CompoundLabLayer" then
				var_6_0.layerName = "LabLayer"

				require("view.Layer.LabLayer")
				LabLayer:setSwitchLabType(arg_6_0.targetlayer)
			else
				var_6_0.layerName = arg_6_0.targetlayer
			end

			if arg_6_0.targetlayer == "HandOfMidasLayer" and not level_manager:isPlayerPassLevel(UNLOCK_MIDAS) then
				local var_6_1 = math.ceil(UNLOCK_MIDAS / 10)

				global_riseWord(string.format(L_MIDAS_UNLOCK, var_6_1 .. "-" .. UNLOCK_MIDAS - 10 * (var_6_1 - 1)))
			elseif arg_6_0.targetlayer == "HandOfMidasLayer" then
				sign_manager:createMidasLayer(arg_6_0.callback)
			else
				var_6_0.initparam = LayerManager:getActiveLayerName()
				var_6_0.returnLayer = TopcostLayer.runninglayer

				cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_6_0)
			end
		end

		if arg_6_0.releaselayer then
			arg_6_0.releaselayer:removeFromParent()
		end

		if arg_6_0.releaseCallback then
			arg_6_0.releaseCallback()
		end
	end

	local var_3_3 = 9
	local var_3_4 = cc.Repeat:create(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function()
		var_3_3 = var_3_3 - 1

		var_3_1:setString("(" .. tostring(var_3_3) .. ")")

		if var_3_3 == 0 then
			var_3_1:stopAction(seqre)
			LayerManager:removePopLayer(self.__queueindex)
		end
	end)), 9)

	var_3_1:runAction(var_3_4)
	var_3_0:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_8_0:setTouchEnabled(false)
		var_3_1:stopAction(var_3_4)
		var_3_2(arg_3_1)
	end)
	ccui.Helper:seekWidgetByName(self.rootpanel, "button_sure"):addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_9_0:setTouchEnabled(false)
		var_3_1:stopAction(var_3_4)
		var_3_2(arg_3_1)
	end)
end

function PopGoLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		LayerManager:removePopLayer(self.__queueindex)
	end)
end
