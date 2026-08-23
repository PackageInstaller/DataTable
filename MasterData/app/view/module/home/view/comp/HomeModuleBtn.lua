local HomeConst = require("app.view.module.home.const.HomeConst")
local var_0_1 = g.core.model.User.functionUnlockData
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local HomeModuleBtn = class("HomeModuleBtn")

function HomeModuleBtn:ctor()
	self._btnCfg = nil
	self._functionId = nil
	self.m_isLockController = self:getController("isLock")
	self.m_discountTickController = self:getController("discountTick")
	self.m_effectPlaceHolder = self:getChild("effectPlaceHolder")
	self.m_isShowMergeAreaController = self:getController("isShowMergeArea")
	self.m_mergeTxt = self:getChild("mergeTxt")
	self.m_mergeBg = self:getChild("mergeBg")
	self.m_specialRedLoader = self:getChild("redpointLoader")
	self.m_specialRedTxt = self:getChild("tagTxt")

	self:addClickListener(handler(self, self._onClick))
end

function HomeModuleBtn:_onClick()
	if self._btnCfg and self._btnCfg.clickFunc then
		g.core.model.User.homeData:setPopPos((self:displayObject():convertToWorldSpace(cc.p(self:getSize().width / 2, self:getSize().height))))
		self._btnCfg.clickFunc(self)
	else
		g.core.module.ModuleManager:tip("按钮配置数据为nil")
	end
end

function HomeModuleBtn:updateFunctionId(arg_3_1)
	self._functionId = arg_3_1
end

function HomeModuleBtn:updateBtnCfg(arg_4_1)
	self._btnCfg = arg_4_1 or self._btnCfg

	if not self._btnCfg then
		return
	end

	if self._btnCfg.getBtnName then
		self:setTitle(self._btnCfg.getBtnName() or "")
	end

	if self._btnCfg.getIconName then
		self:setIcon(self._btnCfg.getIconName() or "")
	end

	if self.m_specialRedLoader then
		self.m_specialRedLoader:setVisible(false)

		if self.m_specialRedTxt then
			self.m_specialRedTxt:setVisible(false)
		end

		if self._btnCfg.checkSpecialRedRes then
			local var_4_0, var_4_1, var_4_2 = self._btnCfg.checkSpecialRedRes()

			if var_4_0 then
				if var_4_1 then
					self.m_specialRedLoader:setVisible(true)
					self.m_specialRedLoader:setURL(var_4_1)
				end

				if var_4_2 and self.m_specialRedTxt then
					self.m_specialRedTxt:setVisible(true)
					self.m_specialRedTxt:setText(var_4_2)
				end
			end
		end
	end

	if self.m_isLockController then
		local var_4_3 = not self._btnCfg.lockFunc or self._btnCfg.lockFunc()

		if self._functionId and self.m_effectPlaceHolder and var_0_1:isNewFuncUnlocked(self._functionId) then
			self.m_effectPlaceHolder:addEffectSpine({
				name = "eff_ui_home_unlock",
				isLoop = false,
				eventHandler = handler(self, self._onFuncUnLock)
			})
		else
			self.m_isLockController:setSelectedIndex((var_4_3 or nil) and (HomeConst.CTRL_BTN_UNLOCK or HomeConst.CTRL_BTN_LOCK))
		end
	end

	if self.m_isShowMergeAreaController then
		self:_updateAllianceMergeAreaTip()
	end
end

function HomeModuleBtn:_onFuncUnLock()
	local var_5_0 = not self._btnCfg.lockFunc or self._btnCfg.lockFunc()

	var_0_1:saveUnlockedFunc(self._functionId)
	self.m_isLockController:setSelectedIndex((var_5_0 or nil) and (HomeConst.CTRL_BTN_UNLOCK or HomeConst.CTRL_BTN_LOCK))
end

function HomeModuleBtn:setDiscountTick(arg_6_1)
	self.m_discountTickController:setSelectedIndex(arg_6_1)
end

function HomeModuleBtn:_updateAllianceMergeAreaTip()
	if self._functionId == var_0_2.GUILD and g.core.common.ModuleUnlock:isModuleUnlock(var_0_2.ALLIANCE) then
		if g.core.model.User.areaMergeData:isShowMergeTips() then
			self.m_isShowMergeAreaController:setSelectedIndex(1)

			if g.core.model.User.areaMergeData:getMergeAreaStage() == g.core.const.ConstMgr.AreaMergeConst.STAGE.PREVIEW then
				self.m_mergeTxt:setText(g.core.lang:get(430101))
			elseif g.core.model.User.areaMergeData:getMergeAreaStage() == g.core.const.ConstMgr.AreaMergeConst.STAGE.MERGE then
				self.m_mergeTxt:setText(g.core.lang:get(430102))
			end

			if not g.core.model.User.dayNotifyTool:isTodayHasRecord(require("app.view.common.const.DayNotifyToolConst").TYPE_MERGE_AREA_TIP) then
				self.m_mergeTxt:setVisible(true)
				self.m_mergeBg:setVisible(true)
			else
				self.m_mergeTxt:setVisible(false)
				self.m_mergeBg:setVisible(false)
			end
		else
			self.m_isShowMergeAreaController:setSelectedIndex(0)
		end
	else
		self.m_isShowMergeAreaController:setSelectedIndex(0)
	end
end

return HomeModuleBtn
