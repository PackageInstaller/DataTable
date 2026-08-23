local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.treasureData
local var_0_2 = g.core.config.treasure_info
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local var_0_4 = g.core.const.ConstMgr.QUALITY_TYPE
local BagNewTreasureRightComp = class("BagNewTreasureRightComp", require("app.fairyGUI.bagNew.UI_BagNewTreasureRightComp"))

function BagNewTreasureRightComp:ctor()
	self._compData = nil
	self._isFrag = false
	self._canCompose = false

	self.m_touchLayer:setWidth(display.width)
	self.m_lockBtn:addClickListener(handler(self, self._onTreasureLockBtnClick))
	self.m_tipsBtn:addClickListener(handler(self, self._onTipsBtnClick))
	self.m_touchLayer:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_developBtn:addClickListener(handler(self, self._onFunctionBtnClick))
end

function BagNewTreasureRightComp:_onTouchBegin()
	self.m_showFragDetailController:setSelectedIndex(0)
	self.m_fragDetailComp:playExitAnim()
end

function BagNewTreasureRightComp:playEnterAnim()
	self.m_enterTransition:play()
end

function BagNewTreasureRightComp:updateView(arg_4_1, arg_4_2)
	self._compData = arg_4_1
	self._isFrag = arg_4_2

	self.m_typeController:setSelectedIndex(arg_4_2 and 1 or 0)

	local var_4_0

	self.m_developBtn:setVisible(true)
	self.m_isHasSpecialAttrController:setSelectedIndex(0)
	self.m_isLockController:setSelectedIndex(0)
	self.m_refineScoreController:setSelectedIndex(0)

	if arg_4_2 then
		self.m_tipsBtn:setVisible(false)

		var_4_0 = var_0_2.fetch(arg_4_1.id)

		if var_4_0.type <= 2 then
			self.m_normalController:setSelectedIndex(0)

			if var_4_0.quality >= var_0_4.SR and #var_0_1:getShowTreasureSpecialAttrsPool(arg_4_1.id) > 0 then
				self.m_isHasSpecialAttrController:setSelectedIndex(1)
			end

			self.m_attrComp:updateView(arg_4_1, arg_4_2)
			self.m_attrComp:setVisible(true)
		else
			self.m_attrComp:setVisible(false)
			self.m_normalController:setSelectedIndex(1)
			self.m_scrollTxtComp:setTitle(var_4_0.description)
		end

		self.m_progNumText:setText(arg_4_1.haveNum .. "/" .. arg_4_1.needNum)

		if arg_4_1.canComposeNum and arg_4_1.canComposeNum > 0 then
			self._canCompose = true

			self.m_developBtn:setTitle(g.core.lang:get(200505))
		else
			self._canCompose = false

			self.m_developBtn:setTitle(g.core.lang:get(200506))
		end
	else
		self.m_developBtn:setTitle(g.core.lang:get(200507))

		if arg_4_1.position == 0 then
			self.m_developBtn:setVisible(false)
		end

		var_4_0 = var_0_2.fetch(arg_4_1.base_id)

		if var_4_0.type <= 2 then
			self.m_normalController:setSelectedIndex(0)
			self.m_tipsBtn:setVisible(true)

			if var_4_0.quality >= var_0_4.SR then
				self.m_isHasSpecialAttrController:setSelectedIndex(1)
			end

			self.m_isLockController:setSelectedIndex(arg_4_1.lock and 2 or 1)
			self:_setLockBtnBg(arg_4_1.lock)
			self.m_attrComp:updateView(arg_4_1, arg_4_2)
			self.m_attrComp:setVisible(true)
		else
			self.m_attrComp:setVisible(false)
			self.m_tipsBtn:setVisible(false)
			self.m_normalController:setSelectedIndex(1)
			self.m_scrollTxtComp:setTitle(var_4_0.description)
		end
	end

	self.m_infoBaseComp:setData({
		title = var_4_0.name,
		loaderUrl = var_0_0:getBagNewQualityBgPath(var_4_0.quality),
		icon = g.core.common.Path:getTreasurePicById(var_4_0.res_id)
	})
end

function BagNewTreasureRightComp:_onTipsBtnClick()
	if self._isFrag then
		self.m_showFragDetailController:setSelectedIndex(1)
		self.m_fragDetailComp:updateDetailInfo(self._compData)
		self.m_fragDetailComp:playEnterAnim()
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.module.bagNew.view.popup.BagNewCommonFullAttrPop").new(self._compData, true), {
			touchDisappear = true
		})
	end
end

function BagNewTreasureRightComp:_onFunctionBtnClick()
	if self._isFrag then
		if self._canCompose then
			self:_composeTreasure()
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.BIO_TEAM_CHOOSE_CAMPAIGN)
		end
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.TREASURE_DEVELOP, {
			isRefine = false,
			id = self._compData.base_id,
			sid = self._compData.id
		})
	end
end

function BagNewTreasureRightComp:_composeTreasure()
	local var_7_0, var_7_1, var_7_2 = self:_getComposeInfo()

	if not self._canCompose then
		g.core.module.ModuleManager:tip(g.core.lang:get(304006))

		return
	end

	if var_7_1 > 1 then
		local var_7_3 = fgui.UIPackage:createObject("bagNew", "BagOneKeyComposeComp")

		var_7_3:setItemView({
			id = var_7_2,
			fragmentId = var_7_0,
			num = var_7_1
		}, 2)
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			titleType = 1,
			title = g.core.lang:get(200504),
			childComp = var_7_3,
			onConfirm = function(self)
				g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
					id = self.fragmentId,
					num = self.num
				})
			end
		}), {
			touchDisappear = true
		})
	else
		g.core.model.User.robTreasureData:recordComposeFlag()
		g.core.network.GameNetProxy:send_C2S_Fragment_Compose({
			num = 1,
			id = var_7_0
		})
	end
end

function BagNewTreasureRightComp:_getComposeInfo()
	return self._compData.fragId, self._compData.canComposeNum, self._compData.id
end

function BagNewTreasureRightComp:_onTreasureLockBtnClick()
	if not self._isFrag then
		g.core.network.GameNetProxy:send_C2S_Treasure_Luck({
			ids = {
				self._compData.id
			}
		})
	end
end

function BagNewTreasureRightComp:onRcvTreasureLock()
	local var_11_0 = g.core.model.User.treasureData:getTreasureDataByOnlyId(self._compData.id)

	self.m_isLockController:setSelectedIndex(var_11_0.lock and 2 or 1)
	self:_setLockBtnBg(var_11_0.lock)
	g.core.module.ModuleManager:tip(g.core.lang:get((var_11_0.lock or nil) and 202056))
end

function BagNewTreasureRightComp:_onFragSpecialAttrTouch()
	if self._isFrag and self.m_isHasSpecialAttrController:getSelectedIndex() == 1 then
		g.core.sound.SoundManager:playSound("UI_Click_Middle")
		g.core.module.ModuleManager:pushPopup((require("app.view.base.infoPop.TreasureSpecialAttrPoolPop").new({
			baseId = self._compData.id
		})))
	end
end

function BagNewTreasureRightComp:_setLockBtnBg(arg_13_1)
	local var_13_0 = self.m_lockBtn:getChild("bgLoader")

	if var_13_0 then
		var_13_0:setAlpha(arg_13_1 and 1 or 0.5)
	end
end

return BagNewTreasureRightComp
