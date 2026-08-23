local ThemeBioUtils = import("..model.ThemeBioUtils")
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.model.User.themeData
local var_0_4 = g.core.common.Drops
local var_0_5 = g.core.common.Goods
local var_0_6 = g.core.const.ConstMgr.ThemeBioConst
local ThemeBioTriggerPublishPop = class("ThemeBioTriggerPublishPop", require("app.fairyGUI.themeBio.UI_ThemeBioTriggerPublishPop"), function()
	return fgui.GComponent:create({
		resName = "ThemeBioTriggerPublishPop",
		pkgPath = "ui/themeBio/themeBio",
		isFullScreen = true,
		pkgName = "themeBio"
	})
end)

function ThemeBioTriggerPublishPop:ctor(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	self._publishType = arg_2_1
	self._tmpMissionId = arg_2_2
	self._tmpIsStoryJump = arg_2_3
	self._tmpTalkTarget = arg_2_4
	self._activeThemeValue = arg_2_5
	self._themeBioData = var_0_3:getThemeData(self._activeThemeValue):getThemeBioData()
	self._isCanClick = true
	self._tmpAwardArr = nil
	self._tmpSubMissionArr = nil

	self:initPublishTask()
end

function ThemeBioTriggerPublishPop:initPublishTask()
	self:_initTaskUI()
end

function ThemeBioTriggerPublishPop:_initTaskUI()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_infoList:setVirtual()
	self.m_infoList:setItemRenderer(handler(self, self._onRenderSubMissionList))
	self:addClickListener(handler(self, self._hideAction))
	self.m_acceptBtn:addClickListener(handler(self, self._onBioAcceptClick))
	self.m_getBtn:addClickListener(handler(self, self._onBioAcceptClick))
end

function ThemeBioTriggerPublishPop:onLoad()
	self:_refreshTaskInfo()
	self.m_enterTransition:play()
	var_0_2:dispatchEvent(var_0_1.EVENT_BIO_SET_HUDUI_SHOW, false, false)
end

function ThemeBioTriggerPublishPop:_refreshTaskInfo()
	self.m_stateController:setSelectedIndex(math.max(0, self._publishType - 1))

	local var_6_0 = self._themeBioData:getMission(self._tmpMissionId)
	local var_6_1 = self._themeBioData:getChain(var_6_0.chain)

	self:_showChainMission(var_6_1.missions, var_6_0)
	self:_showKnightDraw(var_6_0)
	self:_showAwardList(self:_getLastMissionInfo(var_6_1.missions).reward_first)
end

function ThemeBioTriggerPublishPop:_showChainMission(arg_7_1, arg_7_2)
	self._tmpSubMissionArr = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = self._themeBioData:getMission(iter_7_1)

		if not var_7_0.isFirst and not var_7_0.isLast then
			table.insert(self._tmpSubMissionArr, var_7_0)
		end
	end

	self.m_infoList:setNumItems(#self._tmpSubMissionArr)
end

function ThemeBioTriggerPublishPop:_showKnightDraw(arg_8_1)
	if arg_8_1.res_type == 1 then
		self.m_knightPicComp:updateKnight({
			resId = tonumber(arg_8_1.res)
		})
		self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)
	end
end

function ThemeBioTriggerPublishPop:_getLastMissionInfo(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = self._themeBioData:getMission(iter_9_1)

		if var_9_0.isLast then
			return var_9_0
		end
	end
end

function ThemeBioTriggerPublishPop:_showAwardList(arg_10_1)
	self._tmpAwardArr = {}

	if arg_10_1 > 0 then
		self._tmpAwardArr = var_0_4:getGoodsArray(arg_10_1)
	end

	self._tmpAwardArr = var_0_5:convertAwards(self._tmpAwardArr)

	self.m_awardList:setNumItems(#self._tmpAwardArr)
end

function ThemeBioTriggerPublishPop:_onRenderAwardList(arg_11_1, arg_11_2)
	if self._tmpAwardArr[arg_11_1 + 1] then
		arg_11_2:updateIcon(self._tmpAwardArr[arg_11_1 + 1])
	end
end

function ThemeBioTriggerPublishPop:_onRenderSubMissionList(arg_12_1, arg_12_2)
	arg_12_2:updateData(self._tmpSubMissionArr[arg_12_1 + 1])
end

function ThemeBioTriggerPublishPop:_onBioAcceptClick()
	local var_13_0 = self._themeBioData:getMission(self._tmpMissionId)

	if not ThemeBioUtils.checkMission(var_13_0, nil, self._activeThemeValue) then
		return
	end

	if not self._isCanClick then
		return
	end

	self._isCanClick = false

	self.m_backTransition:play(handler(self, function()
		g.core.module.ModuleManager:popComponent()

		if self._publishType == var_0_6.EN_BIO_PUBLISH_TYPE_PUBLISH then
			var_0_2:dispatchEvent(var_0_1.EVENT_THEME_BIOTRIGGER_POPTASK_FINISH, false, {
				mission = var_13_0,
				story = self._tmpIsStoryJump,
				touchItem = self._tmpTalkTarget
			})
		elseif self._publishType == var_0_6.EN_BIO_PUBLISH_TYPE_COMPLETE then
			var_0_2:dispatchEvent(var_0_1.EVENT_THEME_BIOTRIGGER_PUBLISHPOP_LAST_FINISH, false, {
				mission = var_13_0,
				storyId = var_13_0.trigger_story,
				touchItem = self._tmpTalkTarget
			})
		elseif self._publishType == var_0_6.EN_BIO_PUBLISH_TYPE_SEE then
			-- block empty
		end
	end))
end

function ThemeBioTriggerPublishPop:_hideAction()
	if self._isCanClick then
		self._isCanClick = false

		self.m_backTransition:play(function()
			g.core.module.ModuleManager:popModule()
		end)
	end
end

function ThemeBioTriggerPublishPop:onUnload()
	var_0_2:dispatchEvent(var_0_1.EVENT_BIO_SET_HUDUI_SHOW, false, true)
end

return ThemeBioTriggerPublishPop
