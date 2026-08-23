local var_0_0 = g.core.event
local var_0_1 = g.core.const.ConstMgr
local ThemeBioUtils = import("..model.ThemeBioUtils")
local var_0_3 = g.core.model.User.resourceData
local var_0_4 = g.core.common.Drops
local var_0_5 = g.core.common.Goods
local var_0_6 = g.core.config.theme_biography_event_info
local var_0_7 = g.core.config.activity_theme_display_info
local var_0_8 = g.core.model.User.themeData
local ThemeBioTriggerBattlePop = class("ThemeBioTriggerBattlePop", require("app.fairyGUI.themeBio.UI_ThemeBioTriggerBattlePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/themeBio/themeBio",
		resName = "ThemeBioTriggerBattlePop",
		pkgName = "themeBio",
		isFullScreen = true
	})
end)

function ThemeBioTriggerBattlePop:ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._tmpMissionId = arg_2_1
	self._tmpIsStoryJump = arg_2_2
	self._tmpTalkTarget = arg_2_3
	self._isEnterBattle = false
	self._activeThemeValue = arg_2_4
	self._themeBioData = var_0_8:getThemeData(self._activeThemeValue):getThemeBioData()
	self._displayInfo = var_0_7.get(self._activeThemeValue)
	self._tmpAwardArr = nil
	self._isNeedRes = false
	self._isCanClick = true

	self:initBattleTask()
end

function ThemeBioTriggerBattlePop:initBattleTask()
	self:_initTaskUI()
end

function ThemeBioTriggerBattlePop:onLoad()
	self:_refreshTaskInfo()
	self.m_enterTransition:play()
	var_0_0.EventManager:dispatchEvent(var_0_0.enum.EVENT_BIO_SET_HUDUI_SHOW, false, false)
end

function ThemeBioTriggerBattlePop:_initTaskUI()
	self.m_topBar:setResInfoById(self._displayInfo.biography_top_bar)
	self.m_topBar:setTitle(self._displayInfo.biography_name)
	self.m_topBar:getController("helpHide"):setSelectedIndex(1)

	local var_5_0 = require("app.view.common.SpineBase").new({
		isLoop = true,
		resId = "",
		anim = "play",
		path = g.core.common.Path:getEffSpine("eff_ui_dungeon_audio")
	})

	var_5_0:getBaseSpine():setPosition(25, 25)
	self.m_effUiAudio:addNode(var_5_0)
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_closePanel:addClickListener(handler(self, self._hideAction))
	self.m_battleBtn:addClickListener(handler(self, self._onBioBattleClick))
	self.m_lineupBtn:addClickListener(handler(self, self._onBioBuzhenClick))
end

function ThemeBioTriggerBattlePop:_refreshTaskInfo()
	local var_6_0 = self._themeBioData:getMission(self._tmpMissionId)

	self.m_showLineController:setSelectedIndex(var_6_0.triggerable_talk ~= "" and 1 or 0)
	self.m_descTxt:setText(var_6_0.triggerable_talk)
	self.m_titleTxt:setText(var_6_0.name or "")
	self.m_costTxt:setText(var_6_0.cost)

	if var_0_3:getVit() < var_6_0.cost then
		self.m_costTxt:setColor(g.core.common.Color.top.RED)
	end

	self._isNeedRes = var_6_0.cost > 0

	self.m_needResController:setSelectedIndex(self._isNeedRes and 1 or 0)

	if self._isNeedRes then
		self.m_costLoader:setURL((g.core.common.Path:getIconByTypeValue(var_0_5.TYPE_RESOURCE, var_0_5.RESOURCE.TYPE_STAMINA, true)))
	end

	self:_showKnightDraw(var_6_0)

	if var_6_0.type == 1 then
		self._tmpAwardArr = {}

		if var_6_0.reward_first > 0 then
			self._tmpAwardArr = var_0_4:getGoodsArray(var_6_0.reward_first)
		end

		if var_6_0.repeatable == 1 and var_6_0.finish and var_6_0.reward_drop > 0 then
			self._tmpAwardArr = var_0_4:getGoodsArray(var_6_0.reward_drop)
		end

		self._tmpAwardArr = var_0_5:convertAwards(self._tmpAwardArr)
	elseif var_6_0.type == 2 and var_6_0.sub_id ~= 0 then
		local var_6_1 = var_0_6.get(var_6_0.sub_id)

		self:_refreshUIShow(var_6_1)

		if var_6_0.reward_first > 0 then
			self._tmpAwardArr = var_0_4:getGoodsArray(var_6_0.reward_first)
		elseif var_6_1.event_type == 3 then
			self._tmpAwardArr = var_0_4:getGoodsArray(var_6_1.event_value_1)

			if var_6_1.event_value_2 > 0 then
				for iter_6_0, iter_6_1 in ipairs((var_0_4:getGoodsArray(var_6_1.event_value_2))) do
					table.insert(self._tmpAwardArr, iter_6_1)
				end
			end
		end

		self._tmpAwardArr = var_0_5:convertAwards(self._tmpAwardArr)
	end

	self.m_awardList:setNumItems(#self._tmpAwardArr)
end

function ThemeBioTriggerBattlePop:_showKnightDraw(arg_7_1)
	if arg_7_1.res_type == 1 then
		self.m_knightPicComp:updateKnight({
			resId = tonumber(arg_7_1.res)
		})
		self.m_knightPicComp:setAlphaRect(var_0_1.SpineConst.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)
	end
end

function ThemeBioTriggerBattlePop:_refreshUIShow(arg_8_1)
	self.m_battleBtn:setText(arg_8_1.button_txt_2)
end

function ThemeBioTriggerBattlePop:_onRenderAwardList(arg_9_1, arg_9_2)
	arg_9_2:updateIcon(self._tmpAwardArr[arg_9_1 + 1])
end

function ThemeBioTriggerBattlePop:_onBioBattleClick()
	local var_10_0 = self._themeBioData:getMission(self._tmpMissionId)

	if not ThemeBioUtils.checkMission(var_10_0) then
		return
	end

	if var_0_3:getVit() < var_10_0.cost then
		g.core.module.ModuleManager:tip(g.core.lang:get(409100))

		return
	end

	self._isEnterBattle = true

	g.core.module.ModuleManager:popModule()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_BIOTRIGGER_POPTASK_FINISH, false, {
		mission = var_10_0,
		story = self._tmpIsStoryJump,
		touchItem = self._tmpTalkTarget
	})
end

function ThemeBioTriggerBattlePop:_onBioBuzhenClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function ThemeBioTriggerBattlePop:_hideAction()
	if self._isCanClick then
		self._isCanClick = false

		self.m_backTransition:play(function()
			g.core.module.ModuleManager:popModule()
		end)
	end
end

function ThemeBioTriggerBattlePop:onUnload()
	if not self._isEnterBattle then
		var_0_0.EventManager:dispatchEvent(var_0_0.enum.EVENT_BIO_SET_HUDUI_SHOW, false, true)
	end
end

return ThemeBioTriggerBattlePop
