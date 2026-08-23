local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.FogNightmareConst
local var_0_2 = g.core.model.User.fogNightmareData
local var_0_3 = 3
local FogNightmareSeasonResultPop = class("FogNightmareSeasonResultPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareSeasonResultPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareSeasonResultPop",
		pkgName = "fogNightmare",
		isFullScreen = true
	}, ...)
end)

function FogNightmareSeasonResultPop:ctor()
	self._rankList = nil
	self._isInit = false

	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_0.FUNCTION_TYPE.FOG_NIGHTMARE)
	self:_initView()
end

function FogNightmareSeasonResultPop:_initView()
	self:addBg("bg/fogNightmare/bg_jszs_zz.jpg")

	local var_3_0 = "ui://text_new/txt_jszs_title_S" .. var_0_2:getActivitySubId()

	self.m_titleLoader:setURL((var_0_2:getActivitySubId() == 1 or nil) and "ui://text_new/txt_jszs_title")
	self.m_enterTransition:play()
	self.m_topBarComp:setResInfoById(var_0_0.HelpConst.HELP_TYPE.FOG_NIGHTMARE)
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRendererRankList))
end

function FogNightmareSeasonResultPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onS2CRanklist, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onS2CRanklist, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_GETINFO, handler(self, self._onGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_NOTICEACTIVITY, handler(self, self._onGetActivityInfo), self)
	g.core.network.GameNetProxy:send_C2S_Fog_GetInfo({})

	self._rankList = var_0_2:getFogSeasonRankList()

	if self._rankList and next(self._rankList) then
		self:updateView()
	else
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 100,
			id = g.core.network.proto.FOG_CROSS_AREA
		})
	end

	g.core.sound.SoundManager:playMusic(var_0_0.SoundConst.BGM.MUSIC_MENU_WUJINGMENGYAN_LAYER)
end

function FogNightmareSeasonResultPop:_onGetActivityInfo()
	if var_0_2:isOpen() and var_0_2:getFogStageType() == var_0_1.ACTIVITY_STATE.OPEN then
		var_0_2:resetRankList()
		g.core.module.ModuleManager:replaceModule(g.view.entrance.FOG_NIGHTMARE_MAIN)
	else
		g.core.module.ModuleManager:popComponent()
	end
end

function FogNightmareSeasonResultPop:_onGetInfo()
	self:updateMyRank()
end

function FogNightmareSeasonResultPop:_onS2CRanklist(arg_7_1, arg_7_2, arg_7_3)
	self._rankList = var_0_2:getFogSeasonRankList() or arg_7_3.rank_units or {}

	self:updateView()
end

function FogNightmareSeasonResultPop:updateView()
	if self._rankList then
		self.m_rankList:setNumItems(#self._rankList)

		if not self._isInit then
			self.m_rankList:transitionShowCells("enter_down", 0.03)

			self._isInit = true
		end

		for iter_8_0 = 1, var_0_3 do
			if self["m_rank" .. iter_8_0] then
				self["m_rank" .. iter_8_0]:updateComp(self._rankList[iter_8_0])
			end
		end
	end

	self:updateMyRank()
end

function FogNightmareSeasonResultPop:updateMyRank()
	local var_9_0 = var_0_2:getMySeasonRank()

	if var_9_0 > 0 then
		self.m_myRankText:setText(var_9_0)
	else
		if var_0_2:getTowerData():getHistoryMaxFloorNum() <= 0 then
			if var_0_2:getTowerData():getCurrentMaxFloorNum() > 0 then
				self.m_myRankText:setText(var_0_1.SHOW_RANK_COUNT .. "+")

				goto label_9_0
			end
		end

		self.m_myRankText:setText(g.core.lang:get(109556))
	end

	::label_9_0::
end

function FogNightmareSeasonResultPop:_onRendererRankList(arg_10_1, arg_10_2)
	arg_10_2:updateCell(self._rankList[arg_10_1 + 1])
end

return FogNightmareSeasonResultPop
