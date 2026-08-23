local KnightWeddingLevelUpPop = require("app.view.module.knight.view.infoPop.KnightWeddingLevelUpPop")
local var_0_1 = g.core.const.ConstMgr.BaseShowTypeConst
local var_0_2 = g.core.config.wedding_vow_info
local var_0_3 = g.core.config.talent_skill_info
local var_0_4 = g.core.const.ConstMgr.WeddingConst
local var_0_5 = g.core.config.wedding_favor_info
local var_0_6 = g.core.module.ModuleManager
local var_0_7 = g.core.const.ConstMgr
local var_0_8 = g.core.model.User.weddingData
local KnightWeddingDevComp = class("KnightWeddingDevComp", require("app.fairyGUI.knight.UI_KnightWeddingDevComp"))

function KnightWeddingDevComp:ctor()
	self._lastShowCfgId = 0
	self._knightStruct = nil
	self._advId = 0
	self._curInfo = nil
	self._nextInfo = nil
	self._showSuccessData = nil
	self._canActive = true

	self:initView()
end

function KnightWeddingDevComp:initView()
	self.m_activeBtn:addClickListener(handler(self, self._onClickUpgradeBtn))
	self.m_selfAttrComp:addClickListener(handler(self, self._onClickSelfAttrPopBtn))
	self.m_allAttrComp:addClickListener(handler(self, self._onClickAllAttrPopBtn))
	self.m_passiveIcon:addClickListener(handler(self, self._onClickSkillIcon))
end

function KnightWeddingDevComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WEDDING_VOW_UPGRADE, handler(self, self._onRcvUpgrade), self)
	self:updateView()
end

function KnightWeddingDevComp:_onClickSkillIcon()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.KnightWeddingSkillTip").new({
		knightStruct = self._knightStruct
	}), {
		touchDisappear = true
	})
end

function KnightWeddingDevComp:_onRcvUpgrade(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._canActive = true

	local var_5_0 = arg_5_4.wedding_vow or {}
	local var_5_1 = var_0_5.get(var_5_0.vow_id)

	if var_5_0.knight_advance_id == self._advId then
		self:updateView()
	end

	self._showSuccessData = var_5_0

	local var_5_2 = self.m_progBar.m_effectNode

	if var_5_1.node_type == var_0_4.NODE_TYPE.BIG then
		var_5_2:addEffectSpine({
			anim = "play",
			remove = true,
			name = "eff_ui_wedding_advance",
			isLoop = false,
			eventHandler = handler(self, self.showSuccessUpgrade)
		})
	else
		var_5_2:addEffectSpine({
			anim = "play",
			remove = true,
			name = "eff_ui_wedding_add",
			isLoop = false,
			eventHandler = handler(self, self.showSuccessUpgrade)
		})
	end

	local var_5_3 = var_0_8:getLevelMaxNodeCount(var_5_1) - 1
	local var_5_4 = var_0_8:getCurLevelActiveCount(var_5_1)

	if var_5_4 > 0 then
		var_5_2:setRotation(72 + var_5_4 * 36)
	else
		var_5_2:setRotation(0)
	end
end

function KnightWeddingDevComp:showSuccessUpgrade()
	if self._showSuccessData then
		if var_0_5.get(self._showSuccessData.vow_id).node_type == var_0_4.NODE_TYPE.BIG then
			g.core.module.ModuleManager:pushPopup(KnightWeddingLevelUpPop.new({
				advance_id = self._showSuccessData.knight_advance_id
			}), {
				touchDisappear = true
			})
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
				baseShowPop = {
					type = var_0_1.WEDDING_UPGRADE
				}
			})
		end
	end

	self._showSuccessData = nil
end

function KnightWeddingDevComp:updateView(arg_7_1)
	if arg_7_1 and arg_7_1.data then
		self._knightStruct = arg_7_1.data.knight
	end

	if not self._knightStruct then
		return
	end

	self._advId = self._knightStruct:getAdvanceId()
	self._curInfo = var_0_8:getCurFavorInfo(self._advId)
	self._nextInfo = var_0_8:getNextFavorInfo(self._advId)

	if self._nextInfo == nil then
		self.m_isFullController:setSelectedIndex(1)
	else
		self.m_isFullController:setSelectedIndex(0)
		self:updateActiveBtn()
	end

	self:updateProgressComp()
	self:updateAttrComp()
end

function KnightWeddingDevComp:updateAttrComp()
	self.m_passiveIcon:updateIcon({
		isPassive = true,
		skillId = var_0_2.get(self._advId)["skill_" .. self._curInfo.level]
	})
	self.m_selfAttrComp:setTitle(g.core.lang:get(421217))

	local var_8_0 = var_0_8:getFirstInfoByLevel(self._curInfo.group, self._curInfo.level + 1)

	if var_8_0 then
		local var_8_1 = var_0_3.get(var_8_0.talent_all)

		if var_8_1 then
			self.m_allAttrComp:setVisible(true)
			self.m_allAttrComp:setTitle(g.core.lang:get(201303, {
				name = var_8_1.name
			}))
		else
			self.m_allAttrComp:setVisible(false)
		end
	else
		self.m_allAttrComp:setTitle(g.core.lang:get(201014))
	end
end

function KnightWeddingDevComp:updateProgressComp()
	self.m_progBar:updateProgressComp(self._curInfo)
end

function KnightWeddingDevComp:updateActiveBtn()
	self.m_resComp:updateByTVS({
		type = self._curInfo.active_type,
		value = self._curInfo.active_value,
		size = self._curInfo.active_size
	})

	if self._nextInfo.node_type == var_0_7.WeddingConst.NODE_TYPE.BIG then
		self.m_needBreakController:setSelectedIndex(1)
	else
		self.m_needBreakController:setSelectedIndex(0)
	end
end

function KnightWeddingDevComp:_onClickSelfAttrPopBtn()
	var_0_6:pushPopup(require("app.view.module.knight.view.KnightWeddingDevAttrPop").new({
		knightStruct = self._knightStruct,
		nextInfo = self._nextInfo
	}), {
		touchDisappear = true
	})
end

function KnightWeddingDevComp:_onClickAllAttrPopBtn()
	var_0_6:pushPopup(require("app.view.module.tip.view.KnightTalentTip").new({
		advId = self._advId,
		type = g.core.const.ConstMgr.TipConst.KnightTipType.WEDDING
	}), {
		touchDisappear = true
	})
end

function KnightWeddingDevComp:_onClickUpgradeBtn()
	if self._showSuccessData then
		return
	end

	if not self._canActive then
		return
	end

	if self._nextInfo then
		if g.core.model.User.bagData:getOwnNum(self._curInfo.active_type, self._curInfo.active_value) >= self._curInfo.active_size then
			self._canActive = false

			g.core.network.GameNetProxy:send_C2S_WeddingVow_Upgrade({
				knight_advance_id = self._advId,
				vow_id = self._nextInfo.id
			})
		else
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = self._curInfo.active_type,
				value = self._curInfo.active_value
			})
		end
	end
end

return KnightWeddingDevComp
