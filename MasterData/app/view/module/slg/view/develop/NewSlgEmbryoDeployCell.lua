local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.newSlgDevelopData
local NewSlgEmbryoDeployCell = class("NewSlgEmbryoDeployCell", require("app.fairyGUI.newSlg.UI_NewSlgEmbryoDeployCell"))

function NewSlgEmbryoDeployCell:ctor()
	self._embryoStruct = nil
	self._init = false
	self._pos = 0
	self._status = var_0_0.SLG_EMBRYO_LINEUP_STATUS.LOCK
	self._unlockLv = 0

	self.m_mainCityName:setText(var_0_2:getBuildNameByType(var_0_0.SLG_BUILD_TYPE.COMMAND))
	self:addClickListener(handler(self, self._onClickSelf))
end

local var_0_4 = {
	[g.core.common.Goods.TYPE_KNIGHT] = 0,
	[g.core.common.Goods.TYPE_ARTIFACT] = 1,
	[g.core.common.Goods.TYPE_UNITETOKEN] = 2,
	[g.core.common.Goods.TYPE_PET] = 3,
	[g.core.common.Goods.TYPE_SUCCUBA] = 4
}

function NewSlgEmbryoDeployCell:updateEmbryoIcon(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._pos = arg_2_2

	if not var_0_2:checkPosUnlockByTypeAndPos(arg_2_3, arg_2_2) then
		self._status = var_0_0.SLG_EMBRYO_LINEUP_STATUS.LOCK

		self.m_statusController:setSelectedIndex(var_0_0.SLG_EMBRYO_LINEUP_STATUS.LOCK)

		self._unlockLv = arg_2_4

		self.m_tipTxt:enableRich()
		self.m_tipTxt:setText(g.core.lang:get(429534, {
			level = arg_2_4
		}))

		return
	end

	if not arg_2_1 then
		self.m_statusController:setSelectedIndex(var_0_0.SLG_EMBRYO_LINEUP_STATUS.CAN_LINEUP)

		self._status = var_0_0.SLG_EMBRYO_LINEUP_STATUS.CAN_LINEUP

		return
	end

	self.m_embryoTypeController:setSelectedIndex(var_0_4[arg_2_1:getType()])
	self.m_statusController:setSelectedIndex(var_0_0.SLG_EMBRYO_LINEUP_STATUS.HAS_LINEUP)

	self._status = var_0_0.SLG_EMBRYO_LINEUP_STATUS.HAS_LINEUP
	self._embryoStruct = arg_2_1

	local var_2_0 = arg_2_1:getQuality()

	self.m_embryoQualityBg:setURL(var_0_1:getNewSlgEmbryoQualityBg(var_2_0))
	self.m_starQualityBg:setURL(var_0_1:getKnightNameQualityBg2(var_2_0))
	self.m_embryoName:setText(arg_2_1:getName())
	self.m_authorityNum:setText(g.core.lang:get(429531, {
		num = arg_2_1:getAuthorityNum()
	}))
	self.m_embryoIcon:setIcon(arg_2_1:getPicRes())

	if not self._init then
		self.m_starComp:initStar({
			gap = -2,
			style = 2,
			index = 3,
			num = arg_2_1:getStar(),
			max = arg_2_1:getMaxStarLevel()
		})

		self._init = true
	else
		self.m_starComp:setStarNum(arg_2_1:getStar())
	end
end

function NewSlgEmbryoDeployCell:playLineUpEffect()
	self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_newSlg_card",
		remove = true,
		isLoop = false
	})
end

function NewSlgEmbryoDeployCell:_onClickSelf()
	if self._status == var_0_0.SLG_EMBRYO_LINEUP_STATUS.LOCK then
		g.core.module.ModuleManager:tip(g.core.lang:get(429539, {
			level = self._unlockLv
		}))

		return
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_xuanze)
	self:dispatchCompEvent("SHOW_CAN_LINEUP_LIST", {
		pos = self._pos
	})
end

return NewSlgEmbryoDeployCell
