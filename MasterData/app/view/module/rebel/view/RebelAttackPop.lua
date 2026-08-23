local var_0_0 = g.core.const.ConstMgr.RebelConst.FEATURE_TYPE
local var_0_1 = {
	NORMAL = 1,
	DOUBLE = 2
}
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.model.User.rebelData
local var_0_4 = g.core.model.User.resourceData
local RebelAttackPop = class("RebelAttackPop", require("app.fairyGUI.rebel.UI_RebelAttackPop"), function()
	return fgui.GComponent:create({
		resName = "RebelAttackPop",
		pkgPath = "ui/rebel/rebel",
		isFullScreen = true,
		pkgName = "rebel"
	})
end)

function RebelAttackPop:ctor(arg_2_1)
	self._refRebelElem = arg_2_1
	self._tmpAwardArr = nil
	self._bossResID = nil

	self:initAttack()
	self.m_playTimesComp:initView({
		type = g.core.common.Goods.RESOURCE.TYPE_REBEL_ATTACK,
		getTimesFunc = function()
			return g.core.model.User.resourceData:getRebelAttack()
		end,
		onGetTimes = function()
			require("app.view.base.infoPop.BasePlayNumPop").createPlayNum(g.core.common.Goods.ITEM.TYPE_REBEL_TOKEN)
		end
	})
end

function RebelAttackPop:onLoad()
	self:_refreshView()
	self.m_enterTransition:play()
	self.m_playTimesComp:updateView()
end

function RebelAttackPop:initAttack()
	self:_initAttackData()
	self:_initAttackUI()
end

function RebelAttackPop:_initAttackData()
	self._tmpAwardArr = {}

	local var_7_0 = self._refRebelElem:getBaseInfo()

	if var_7_0.trigger_reward_type > 0 then
		table.insert(self._tmpAwardArr, {
			type = var_7_0.trigger_reward_type,
			value = var_7_0.trigger_reward_value,
			size = var_7_0.trigger_reward_size
		})
	end

	if var_7_0.kill_reward_type > 0 then
		table.insert(self._tmpAwardArr, {
			type = var_7_0.kill_reward_type,
			value = var_7_0.kill_reward_value,
			size = var_7_0.kill_reward_size
		})
	end

	local var_7_1 = g.core.model.User.themeData:getThemeDropByModule(g.core.const.ConstMgr.ActivityConst.HOLIDAY_MODULE_TYPE.REBEL)

	if var_7_1 then
		local var_7_2 = {}

		table.insertto(var_7_2, var_7_1)
		table.insertto(var_7_2, self._tmpAwardArr)

		self._tmpAwardArr = var_7_2
	end
end

function RebelAttackPop:_initAttackUI()
	self.m_topBarComp:setResInfoById(36)
	self.m_txtDeepTip:setText(g.core.lang:get(303518))
	self.m_hpProg:setTitleType(g.core.const.ConstMgr.UI_CONST.PROGRESSBAR.PERCENT)
	self.m_closeBtn:addClickListener(handler(self, self._onClickCloseBtn))
	self.m_comAtkBtn:addClickListener(handler(self, self._onNormalAttackClick))
	self.m_fullAtkBtn:addClickListener(handler(self, self._onFullAttackClick))
	self.m_lineupBtn:addClickListener(handler(self, self._onFormationClick))
	self.m_helpBtn:addClickListener(handler(self, self._onRebelHelpClick))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function RebelAttackPop:_onRenderAwardList(arg_9_1, arg_9_2)
	self._tmpAwardArr[arg_9_1 + 1].hideNum = false

	arg_9_2:updateIcon(self._tmpAwardArr[arg_9_1 + 1])
end

function RebelAttackPop:_refreshView()
	local var_10_0 = self._refRebelElem:getBaseInfo()

	self.m_nameTxt:setText(var_10_0.name)
	self.m_levelTxt:setText(self._refRebelElem:getRebelPkg().level)

	local var_10_1

	if var_10_0.feature_type == var_0_0.UNITE_TOKEN then
		var_10_1 = 303521
	elseif var_10_0.feature_type == var_0_0.KNIGHT then
		var_10_1 = 303522
	end

	if var_10_1 then
		self.m_tipTxt:setText(g.core.lang:get(var_10_1, {
			num = var_10_0.feature_value
		}))
	end

	self:_buildBossView(var_10_0.res)

	local var_10_2, var_10_3 = self._refRebelElem:getHP()

	self.m_hpProg:setValue((math.ceil(100 * var_10_2 / var_10_3)))
	self.m_awardList:setNumItems(#self._tmpAwardArr)

	local var_10_4 = {
		size = 1,
		type = var_0_2.TYPE_RESOURCE,
		value = var_0_2.RESOURCE.TYPE_REBEL_ATTACK
	}

	self.m_comNumComp:updateByTVS(var_10_4)

	if var_0_3:isHotTime() then
		self.m_fullNumComp:setTitleColor(cc.c3b(36, 189, 129))
	else
		var_10_4.size = 2
	end

	self.m_fullNumComp:updateByTVS(var_10_4)
	self.m_isCrossServerController:setSelectedIndex(0)

	if self._refRebelElem:isDefaultBoss() then
		self.m_finderTxt:setText("")
		self.m_runController:setSelectedIndex(0)
	else
		self.m_finderTxt:setText((g.core.lang:get(303508, {
			name = self._refRebelElem:getFinderName()
		})))
		self.m_runController:setSelectedIndex(1)
		self.m_coolComp:resetCooldownTs((g.core.common.ServerTime:getLeftSeconds((self._refRebelElem:getEndTime()))))
		self.m_helpBtn:setSelectedIndex("unuse", self._refRebelElem:isShared() and 1 or 0)
		self.m_isCrossServerController:setSelectedIndex(1)
		self:_updateCrossServerChatView((self._refRebelElem:getServerName()))
	end
end

function RebelAttackPop:_updateCrossServerChatView(arg_11_1)
	if self.m_serverName then
		self.m_serverName:initRaceTextParams({
			scrollDirection = 1,
			moveType = 1,
			playMode = 2,
			pauseTime = 0.5,
			duration = 3,
			title = arg_11_1 or ""
		})

		local var_11_0 = self.m_serverName:getContainerSize()
		local var_11_1 = self.m_serverName:getTextSize()

		self.m_serverName:setTitleAlign("left")

		if var_11_1.width > var_11_0.width then
			self.m_serverName:setMoveDistance(var_11_1.width - var_11_0.width)
			self.m_serverName:setStartPos(cc.p(0, self.m_serverName:getTextPosition().y))
		end

		self.m_serverName:play()
	end
end

function RebelAttackPop:_buildBossView(arg_12_1)
	if self._bossResID == arg_12_1 then
		return
	end

	self._bossResID = arg_12_1

	self.m_knightPicComp:updateKnight({
		resId = self._bossResID,
		scale = self._refRebelElem:getRebelScale(false)
	})
end

function RebelAttackPop:_startAttackRebel(arg_13_1)
	var_0_3:setNeedBattle(true)

	local var_13_0 = self._refRebelElem:getRebelPkg()

	var_0_3:setAttackTargetId(var_13_0.base_id)
	g.core.network.GameNetProxy:send_C2S_Rebel_AttackBegin({
		uid = var_13_0.uid,
		id = var_13_0.id,
		attack_type = arg_13_1
	})
end

function RebelAttackPop:_onClickCloseBtn()
	self:_closeSelf(nil)
end

function RebelAttackPop:_closeSelf(arg_15_1)
	self:setTouchable(false)
	self:stopAllFGActions()
	self.m_backTransition:play(function()
		if arg_15_1 then
			self:_startAttackRebel(arg_15_1)
		end

		g.core.module.ModuleManager:popComponent()
	end)
end

function RebelAttackPop:_onNormalAttackClick()
	if var_0_4:getRebelAttack() >= 1 then
		self:_closeSelf(var_0_1.NORMAL)
	else
		require("app.view.base.infoPop.BasePlayNumPop").createPlayNum(g.core.common.Goods.ITEM.TYPE_REBEL_TOKEN)
	end
end

function RebelAttackPop:_onFullAttackClick()
	local var_18_0 = var_0_4:getRebelAttack()

	if var_18_0 >= 2 or var_0_3:isHotTime() and var_18_0 >= 1 then
		self:_closeSelf(var_0_1.DOUBLE)
	else
		require("app.view.base.infoPop.BasePlayNumPop").createPlayNum(g.core.common.Goods.ITEM.TYPE_REBEL_TOKEN)
	end
end

function RebelAttackPop:_onFormationClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function RebelAttackPop:_onRebelHelpClick()
	local var_20_0 = self._refRebelElem:getRebelPkg()

	if var_20_0.share then
		g.core.module.ModuleManager:tip(g.core.lang:get(303514))
	else
		g.core.network.GameNetProxy:send_C2S_Rebel_Share({
			id = var_20_0.id
		})
		self.m_helpBtn:setSelectedIndex("unuse", 1)
		self.m_helpBtn:setTouchable(false)
	end
end

return RebelAttackPop
