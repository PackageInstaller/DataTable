local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.guildDungeonData
local var_0_3 = g.core.const.ConstMgr.GuildDungeonConst.LAYER_CHAP_NUM
local var_0_4 = g.core.const.ConstMgr.GuildDungeonConst.LAST_LAYER_CHAP_NUM
local GuildDungeonMainLayer = class("GuildDungeonMainLayer", require("app.fairyGUI.guildDungeon.UI_GuildDungeonMainLayer"), function()
	return fgui.GComponent:create({
		resName = "GuildDungeonMainLayer",
		pkgPath = "ui/guildDungeon/guildDungeon",
		isFullScreen = true,
		pkgName = "guildDungeon"
	})
end)

function GuildDungeonMainLayer:ctor(arg_2_1)
	self._showChapId = 0
	self._page = -1
	self._maxPage = 0
	self._chapterIdArr = {}
	self._chapterId = -1
	self._bgScale = display.height / 499 < display.width / 1198 and display.width / 1198 or display.height / 499
	self._bgMoveSteep = (self._bgScale * 1198 - display.width) / 4

	self:_initComp()
	self:_addListener()
	self.m_playTimesComp:initView({
		type = g.core.common.Goods.RESOURCE.TYPE_GUILD_DUN_TIME,
		getTimesFunc = function()
			return g.core.model.User.resourceData:getGuildDungeonTimes()
		end,
		onGetTimes = function()
			require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_SCORE.GUILD_DUNGEON_NUM)
		end,
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH
		}
	})
end

function GuildDungeonMainLayer:onLoad()
	self:_addNetWorkListener()
	g.core.network.GameNetProxy:send_C2S_GuildDungeon_GetInfo({})
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_DUNGEON)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_GUILD_DUNGEON)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	self.m_playTimesComp:updateView()
	self:addMovie()
end

function GuildDungeonMainLayer:addMovie()
	self.m_movieComp:addCriSprite({
		fullScreenState = 2,
		movieName = "uiSnow_1334x750_6000",
		isLoop = true,
		y = 0,
		moduleName = "common",
		x = 0
	})
end

function GuildDungeonMainLayer:_initComp()
	self:_initUI()
end

function GuildDungeonMainLayer:getChapterAwardOneKey()
	if var_0_2:canReceiveTreasure() then
		g.core.network.GameNetProxy:send_C2S_GuildDungeon_OneKeyGetFinishAward({})
	end
end

function GuildDungeonMainLayer:getClearAwardOneKey()
	if var_0_2:canGetClearAward() then
		g.core.network.GameNetProxy:send_C2S_GuildDungeon_GetFinishAward_OneKey({
			chapter_id = var_0_2:getClearAwardChapterList()
		})
	end
end

function GuildDungeonMainLayer:_initUI()
	self.m_topBar:setResInfoById(24)

	self._bg = self:addBg("bg/guild/bg_juntuantuwei.jpg")

	self._bg:setSize(1198 * self._bgScale, 499 * self._bgScale)
end

function GuildDungeonMainLayer:_addListener()
	self.m_leftBtn:addClickListener(handler(self, self._onLeftArrowBtnClick))
	self.m_rightBtn:addClickListener(handler(self, self._onRightArrowBtnClick))
	self.m_skillBtn:addClickListener(handler(self, self._onClickSkill))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRank))
	self.m_awardBtn:addClickListener(handler(self, self._onClickPassAward))
end

function GuildDungeonMainLayer:_addNetWorkListener()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_DUNGEON_GETCHAPTER, self._onGoToChap, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_DUNGEON_GETINFO, self._onRcvGetInfo, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_DUNGEON_ONEKEYGETFINISHAWARD, self._onRcvGetOneKeyBoxAward, self)
	g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
		module_id = g.core.const.ConstMgr.TaskConst.MODULE_ID.GUILD_DUNGEON
	})
	g.core.network.GameNetProxy:send_C2S_GuildDungeon_GetSkillInfo({})
end

function GuildDungeonMainLayer:_updateView(arg_13_1)
	self.m_rebirthTxt:setText(var_0_2:getRebirth())
	self.m_chapterComp:updateComp(self._page, self._page == self._maxPage)

	if arg_13_1 == true then
		self._bg:runFGAction((fgui.FMoveTo:create(0.5, {
			x = display.width / 2 - self._bgMoveSteep * (self._page - 2),
			y = display.height / 2
		})))
	else
		self._bg:setPosition(display.width / 2 - self._bgMoveSteep * (self._page - 2), display.height / 2)
	end

	var_0_0:dispatchEvent(var_0_1.EVENT_REFRESH_RED_POINT, true, {
		redPointComp = self.m_skillRedPointComp
	})
	var_0_0:dispatchEvent(var_0_1.EVENT_REFRESH_RED_POINT, true, {
		redPointComp = self.m_awardRedPointComp
	})
end

function GuildDungeonMainLayer:receiveCompEvent(arg_14_1, arg_14_2)
	if arg_14_1 == "GuildDungeonChapComp_goToChap" and arg_14_2 and arg_14_2.chapterId then
		self._chapterId = arg_14_2.chapterId

		g.core.network.GameNetProxy:send_C2S_GuildDungeon_GetChapter({
			chapter_id = self._chapterId
		})
	end
end

function GuildDungeonMainLayer:_onLeftArrowBtnClick()
	if self._page > 0 then
		self._page = self._page - 1

		self:_updateView()
		self:_updateLeftRightArrowBtn()
	end
end

function GuildDungeonMainLayer:_onRightArrowBtnClick()
	if self._page < self._maxPage then
		self._page = self._page + 1

		self:_updateView()
		self:_updateLeftRightArrowBtn()
	end
end

function GuildDungeonMainLayer:_updateLeftRightArrowBtn()
	self.m_leftBtn:setVisible(self._page > 0)
	self.m_rightBtn:setVisible(self._page < self._maxPage)
	self.m_leftBtn:setRedPointVisible((self:_isThereAwardReceive(0, self._page - 1)))
	self.m_rightBtn:setRedPointVisible((self:_isThereAwardReceive(self._page + 1, self._maxPage)))
end

function GuildDungeonMainLayer:_isThereAwardReceive(arg_18_1, arg_18_2)
	if arg_18_2 < arg_18_1 then
		return false
	elseif not g.core.model.User:isJoinGuild() then
		return false
	else
		local var_18_0 = var_0_3 * arg_18_1

		var_18_0 = arg_18_2 == self._maxPage and var_18_0 + var_0_4 or var_18_0 + var_0_3

		for iter_18_0 = var_0_3 * arg_18_1 + 1, var_18_0 do
			if var_0_2:canRecTreasureById(self._chapterIdArr[iter_18_0]) then
				return true
			end
		end

		return false
	end
end

function GuildDungeonMainLayer:_onClickSkill()
	self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonSkillPop").new())
end

function GuildDungeonMainLayer:_onClickRank()
	self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonRankPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function GuildDungeonMainLayer:_onClickPassAward()
	self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonClearAwardPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function GuildDungeonMainLayer:_onRcvGetInfo()
	self._showChapId = var_0_2:getCurChapterId()

	if self._page == -1 then
		local var_22_0 = 0
		local var_22_1 = 0

		for iter_22_0, iter_22_1 in pairs((var_0_2:getChapterMap())) do
			table.insert(self._chapterIdArr, iter_22_0)

			if iter_22_0 == self._showChapId then
				var_22_1 = math.floor(var_22_0 / var_0_3)
			end

			var_22_0 = var_22_0 + 1
		end

		self._maxPage = math.floor(var_22_0 / var_0_3) - 1
		self._page = math.min(var_22_1, self._maxPage)
	end

	self:_updateLeftRightArrowBtn()
	self.m_chapterComp:initComp(self._chapterIdArr)
	self:_updateView(true)
	self.m_enterTransition:play()
	self.m_chapterComp:setVisible(true)
end

function GuildDungeonMainLayer:_onGoToChap()
	if self._chapterId > 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_CHAPTER, {
			chapterId = self._chapterId
		})

		self._chapterId = -1
	end
end

function GuildDungeonMainLayer:_onRcvGetOneKeyBoxAward()
	return
end

function GuildDungeonMainLayer:onUnload()
	self.m_movieComp:removeAllCriSprite()
end

return GuildDungeonMainLayer
