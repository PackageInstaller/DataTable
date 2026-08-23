local HLTrainUpPop = class("HLTrainUpPop", require("app.fairyGUI.homeLandTrain.UI_HLTrainUpPop"), function()
	return fgui.GComponent:create({
		resName = "HLTrainUpPop",
		pkgPath = "ui/homeLandTrain/homeLandTrain",
		pkgName = "homeLandTrain"
	})
end)

function HLTrainUpPop:ctor(arg_2_1)
	self._roomStruct = arg_2_1
	self._curAdvanceId = nil

	self:getView():setSize(display.width, display.height)
	self:showAtCenter()
	self:_initView()
end

function HLTrainUpPop:_initView()
	self.m_nameTxt:setText(self._roomStruct.refCfgBaseInfo.name)
	self.m_iconImg:setURL("bg/homeland/" .. self._roomStruct.refCfgBaseInfo.up_pic)
	self.m_closePanel:addClickListener(handler(self, self._onCloseClick))
	self.m_lvUpBtn:addClickListener(handler(self, self._onLevelUpClick))
end

function HLTrainUpPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_HOME_LAND_TRAIN_UPLEVEL, self._onS2CHLTrainLevelUp, self)
	self:_updateView()

	local var_4_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_upGroup)

	if var_4_0 then
		var_4_0:play()
	end
end

function HLTrainUpPop:_onS2CHLTrainLevelUp()
	if self._roomStruct.refCfgInfo.next_level > 0 then
		self.m_levelAttrComp:playNormalUpLevelAni(handler(self, function()
			self:_updateView()
		end))
	else
		self.m_levelAttrComp:playMaxLevelAni(handler(self, function()
			self:_updateView()
			self.m_enterTransition:play()
		end))
		self.m_lvUpBtn:setTouchable(false)
	end
end

function HLTrainUpPop:_onLevelUpClick()
	if self._roomStruct:isEnoughItemLevelUpNeed() then
		if self._roomStruct:isCanLevelUp() then
			g.core.network.GameNetProxy:send_C2S_HomeLandTrain_UpLevel({
				adv_id = self._roomStruct.advanceId
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(111022))
		end
	else
		local var_8_0 = {
			type = self._roomStruct.refCfgInfo.cost_type
		}

		var_8_0.value = self._roomStruct.refCfgInfo.cost_value

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource(var_8_0)
	end
end

function HLTrainUpPop:_onCloseClick()
	self.m_closePanel:setTouchable(false)

	local var_9_0 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_upGroup)

	if var_9_0 then
		var_9_0:play(function()
			g.core.module.ModuleManager:popModule()
		end)
	end
end

function HLTrainUpPop:_updateView()
	if self._roomStruct.refCfgInfo.next_level > 0 then
		self.m_levelAttrComp:updateView(self._roomStruct)
		self.m_costResComp:updateByTVS({
			type = self._roomStruct.refCfgInfo.cost_type,
			value = self._roomStruct.refCfgInfo.cost_value,
			size = self._roomStruct.refCfgInfo.cost_size
		})

		local var_11_0 = self._roomStruct:getLevelUpCondInfoArr()[1]

		self.m_nextLvDispatchMaxNumTxt:setText(g.core.lang:get(112218, {
			num = self._roomStruct:getDispatchPlaceLimit(self._roomStruct.refCfgInfo.next_level)
		}))
		self.m_condText:setText(var_11_0.desc)
		self.m_stateText:setText(g.core.lang:get(111035, {
			num = var_11_0.curProgress,
			max = var_11_0.maxProgress
		}))
		self.m_fullLevelController:setSelectedIndex(0)
	else
		self.m_fullLevelController:setSelectedIndex(1)
		self.m_maxLevelTxt:setText(self._roomStruct.curLevel)
	end
end

return HLTrainUpPop
