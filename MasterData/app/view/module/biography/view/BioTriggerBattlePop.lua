local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.event
local var_0_2 = g.core.const.ConstMgr.FUNCTION_TYPE
local BioUtils = import("..model.BioUtils")
local var_0_4 = g.core.model.User.bioData
local var_0_5 = g.core.model.User.resourceData
local var_0_6 = g.core.common.Drops
local var_0_7 = g.core.common.Goods
local BioTriggerBattlePop = class("BioTriggerBattlePop", require("app.fairyGUI.biography.UI_BioTriggerBattlePop"), function()
	return fgui.GComponent:create({
		resName = "BioTriggerBattlePop",
		pkgPath = "ui/biography/biography",
		isFullScreen = true,
		pkgName = "biography"
	})
end)

function BioTriggerBattlePop:ctor(arg_2_1, arg_2_2, arg_2_3)
	self._tmpMissionId = arg_2_1
	self._tmpIsStoryJump = arg_2_2
	self._tmpTalkTarget = arg_2_3
	self._isEnterBattle = false
	self._tmpAwardArr = nil
	self._isNeedRes = false
	self._isCanClick = true
	self._isCanAuto = false

	self:initBattleTask()
	self.m_playTimesComp:initView({
		type = g.core.common.Goods.RESOURCE.TYPE_BIOGRAPHIE,
		getTimesFunc = function()
			return g.core.model.User.resourceData:getBioGraphie()
		end
	})
end

function BioTriggerBattlePop:onLoad()
	self:_initRegister()
	self:_refreshTaskInfo()

	if self.m_enterTransition then
		self.m_enterTransition:play(handler(self, self._onEnterAnimFinish))
	end

	var_0_1.EventManager:dispatchEvent(var_0_1.enum.EVENT_BIO_SET_HUDUI_SHOW, false, false)
	self.m_playTimesComp:updateView()
end

function BioTriggerBattlePop:onUnload()
	if not self._isEnterBattle then
		var_0_1.EventManager:dispatchEvent(var_0_1.enum.EVENT_BIO_SET_HUDUI_SHOW, false, true)
	end
end

function BioTriggerBattlePop:_onEnterAnimFinish()
	self._isCanAuto = true
end

function BioTriggerBattlePop:initBattleTask()
	self:_initTaskData()
	self:_initTaskUI()
end

function BioTriggerBattlePop:_initTaskData()
	return
end

function BioTriggerBattlePop:_initTaskUI()
	self.m_topBar:setResInfoById(46)

	local var_9_0 = require("app.view.common.SpineBase").new({
		anim = "play",
		resId = "",
		isLoop = true,
		path = g.core.common.Path:getEffSpine("eff_ui_dungeon_audio")
	})

	var_9_0:getBaseSpine():setPosition(25, 25)
	self.m_effUiAudio:addNode(var_9_0)
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_closePanel:addClickListener(handler(self, self._hideAction))
	self.m_battleBtn:addClickListener(handler(self, self._onBioBattleClick))
	self.m_resetBtn:addClickListener(handler(self, self._onBioResetClick))
	self.m_lineupBtn:addClickListener(handler(self, self._onBioBuzhenClick))
	self.m_fastBtn:addClickListener(handler(self, self._onBioFastClick))
end

function BioTriggerBattlePop:_initRegister()
	var_0_1.EventManager:addEventListener(var_0_1.enum.EVENT_NET_S2C_BIOGRAPHY_RESETMISSIONCOUNT, self._onNetResetCount, self)
end

function BioTriggerBattlePop:_refreshTaskInfo()
	local var_11_0 = var_0_4:getMission(self._tmpMissionId)

	self.m_showLineController:setSelectedIndex(var_11_0.triggerable_talk ~= "" and 1 or 0)
	self.m_descTxt:setText(var_11_0.triggerable_talk)
	self.m_titleTxt:setText(self._tmpTalkTarget:getRoleName() or "")
	self.m_costTxt:setText(var_11_0.cost)

	if var_0_5:getVit() < var_11_0.cost then
		self.m_costTxt:setColor(g.core.common.Color.top.RED)
	end

	self._isNeedRes = var_11_0.cost > 0

	self.m_needResController:setSelectedIndex(self._isNeedRes and 1 or 0)

	if self._isNeedRes then
		self.m_costLoader:setURL((g.core.common.Path:getIconByTypeValue(var_0_7.TYPE_RESOURCE, var_0_7.RESOURCE.TYPE_STAMINA, true)))
	end

	self:_showKnightDraw(var_11_0)

	if var_11_0.type == 1 then
		self._tmpAwardArr = {}

		if var_11_0.reward_first > 0 then
			self._tmpAwardArr = var_0_6:getGoodsArray(var_11_0.reward_first)
		end

		if var_11_0.repeatable == 1 and var_11_0.finish and var_11_0.reward_drop > 0 then
			self._tmpAwardArr = var_0_6:getGoodsArray(var_11_0.reward_drop)
		end

		self._tmpAwardArr = var_0_7:convertAwards(self._tmpAwardArr)

		if var_11_0.finish then
			if var_11_0.attack_count >= var_11_0.attempts then
				self.m_stateController:setSelectedIndex(0)
			else
				self.m_stateController:setSelectedIndex(2)
			end
		else
			self.m_stateController:setSelectedIndex(1)
		end
	elseif var_11_0.type == 2 and var_11_0.sub_id ~= 0 then
		local var_11_1 = g.core.config.biography_event_info.get(var_11_0.sub_id)

		self:_refreshUIShow(var_11_1)

		if var_11_0.reward_first > 0 then
			self._tmpAwardArr = var_0_6:getGoodsArray(var_11_0.reward_first)
		elseif var_11_1.event_type == 3 then
			self._tmpAwardArr = var_0_6:getGoodsArray(var_11_1.event_value_1)

			if var_11_1.event_value_2 > 0 then
				for iter_11_0, iter_11_1 in ipairs((var_0_6:getGoodsArray(var_11_1.event_value_2))) do
					table.insert(self._tmpAwardArr, iter_11_1)
				end
			end
		end

		self._tmpAwardArr = var_0_7:convertAwards(self._tmpAwardArr)

		self.m_stateController:setSelectedIndex(1)
	end

	local var_11_2 = g.core.model.User.themeData:getThemeDropByModule(var_0_0.ActivityConst.HOLIDAY_MODULE_TYPE.BIO)

	if var_11_2 then
		local var_11_3 = {}

		table.insertto(var_11_3, var_11_2)
		table.insertto(var_11_3, self._tmpAwardArr)

		self._tmpAwardArr = var_11_3
	end

	self.m_awardList:setNumItems(#self._tmpAwardArr)
end

function BioTriggerBattlePop:_showKnightDraw(arg_12_1)
	if arg_12_1.res_type == 1 then
		self.m_knightPicComp:updateKnight({
			resId = tonumber(arg_12_1.res)
		})
		self.m_knightPicComp:setAlphaRect(var_0_0.SpineConst.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)
	end
end

function BioTriggerBattlePop:_refreshUIShow(arg_13_1)
	self.m_battleBtn:setText(arg_13_1.button_txt_2)
end

function BioTriggerBattlePop:_onRenderAwardList(arg_14_1, arg_14_2)
	self._tmpAwardArr[arg_14_1 + 1].hideNum = false

	arg_14_2:updateIcon(self._tmpAwardArr[arg_14_1 + 1])
end

function BioTriggerBattlePop:_onBioAddNumClick()
	require("app.view.base.infoPop.BasePlayNumPop").createBuy(var_0_0.ShopConst.SHOP_ITEM_ID.BIOGRAPHIE)
end

function BioTriggerBattlePop:_onBioResetClick()
	BioUtils.checkMission((var_0_4:getMission(self._tmpMissionId)))
end

function BioTriggerBattlePop:_onBioBattleClick()
	if not BioUtils.checkBioLeftCountIsEnough() then
		return
	end

	local var_17_0 = var_0_4:getMission(self._tmpMissionId)

	if not BioUtils.checkMission(var_17_0) then
		return
	end

	if var_0_5:getVit() < var_17_0.cost then
		g.core.module.ModuleManager:tip(g.core.lang:get(302093))

		return
	end

	self._isEnterBattle = true

	g.core.module.ModuleManager:popModule()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_BIOTRIGGER_POPTASK_FINISH, false, {
		mission = var_17_0,
		story = self._tmpIsStoryJump,
		touchItem = self._tmpTalkTarget
	})
end

function BioTriggerBattlePop:_onBioFastClick()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_2.BIO_SWEEPING_1) then
		return
	end

	if not BioUtils.checkBioLeftCountIsEnough() then
		return
	end

	if BioUtils.checkMission((var_0_4:getMission(self._tmpMissionId))) then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BlitzResultPop").new({
			num = 1,
			stageId = self._tmpMissionId,
			type = var_0_0.InfoConst.BlitzType.BIOGRAPHY
		}))
	end
end

function BioTriggerBattlePop:_onBioBuzhenClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function BioTriggerBattlePop:_onNetResetCount(arg_20_1, arg_20_2, arg_20_3)
	self.m_stateController:setSelectedIndex(2)
end

function BioTriggerBattlePop:_hideAction()
	if self._isCanClick then
		self._isCanClick = false

		self.m_backTransition:play(function()
			g.core.module.ModuleManager:popModule()
		end)
	end
end

function BioTriggerBattlePop:doAutoAction()
	if not self._isCanAuto then
		return
	end

	if not BioUtils.checkBioLeftCountIsEnough() then
		return true
	end

	local var_23_0 = var_0_4:getMission(self._tmpMissionId)

	if not BioUtils.checkMission(var_23_0) then
		return true
	end

	if var_0_5:getVit() < var_23_0.cost then
		g.core.module.ModuleManager:tip(g.core.lang:get(302093))

		return true
	end

	self:_onBioBattleClick()

	self._isCanAuto = false
end

return BioTriggerBattlePop
