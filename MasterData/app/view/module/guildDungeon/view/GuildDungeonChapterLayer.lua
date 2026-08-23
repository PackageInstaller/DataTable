local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.GuildDungeonConst
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.model.User.guildDungeonData
local var_0_5 = g.core.model.User.guildData
local var_0_6 = g.core.network.GameNetProxy
local GuildDungeonChapterLayer = class("GuildDungeonChapterLayer", require("app.fairyGUI.guildDungeon.UI_GuildDungeonChapterLayer"), function()
	return fgui.GComponent:create({
		resName = "GuildDungeonChapterLayer",
		pkgPath = "ui/guildDungeon/guildDungeon",
		isFullScreen = true,
		pkgName = "guildDungeon"
	})
end)

function GuildDungeonChapterLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._chapterId = arg_2_1.chapterId
	self._chapterData = nil
	self._stageList = nil

	self:_initView()
	self:_addListener()
	self:addEffSpine()
end

function GuildDungeonChapterLayer:onLoad()
	self:_addNetWorkListener()
	self:addMovie()
	self.m_playTimesComp:updateView()
	self:_updateWithChapterId(self._chapterId)
end

function GuildDungeonChapterLayer:_updateWithChapterId(arg_4_1)
	arg_4_1 = arg_4_1 or 1
	self._chapterId = arg_4_1
	self._chapterData = var_0_4:getChapterById(arg_4_1)
	self._stageList = self._chapterData:getStageList()

	local var_4_0 = var_0_4:isLastChapter(arg_4_1)

	self.m_isLastController:setSelectedIndex(var_4_0 and 1 or 0)
	self.m_rightArrowBtn:setVisible(not var_4_0)
	self.m_leftArrowBtn:setVisible(not var_0_4:isFirstChapter(arg_4_1))
	self:_updateChapterComp()
	self:_updateChapterInfo()
end

function GuildDungeonChapterLayer:addMovie()
	self.m_movieComp:removeAllCriSprite()
	self.m_movieComp:addCriSprite({
		fullScreenState = 2,
		movieName = "fengsuoqujiemian_1334x750_6000",
		isLoop = true,
		y = 0,
		moduleName = "fengsuoqujiemian",
		x = 0
	})
end

function GuildDungeonChapterLayer:addEffSpine()
	self.m_effComp:addEffectSpine({
		name = "dungeon_stage_01_eff_xiaxue88",
		scale = 1,
		isLoop = true
	})
end

function GuildDungeonChapterLayer:_initView()
	self:addBg("bg/guild/pic_tuweiguanqia_1.png")
	self.m_topBar:setResInfoById(25)
	self.m_playTimesComp:initView({
		type = g.core.common.Goods.RESOURCE.TYPE_GUILD_DUN_TIME,
		getTimesFunc = function()
			return g.core.model.User.resourceData:getGuildDungeonTimes()
		end,
		onGetTimes = function()
			require("app.view.base.infoPop.BasePlayNumPop").createBuy(var_0_0.ShopConst.SHOP_SCORE.GUILD_DUNGEON_NUM)
		end,
		refreshEvent = {
			var_0_2.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH
		}
	})
	self.m_boxDadComp:removeChildren()

	self._boxSpine = self.m_boxDadComp:addEffectSpine({
		name = "eff_ui_guilddungeon_baoxiang1",
		scale = 2.4,
		isLoop = true
	})
end

function GuildDungeonChapterLayer:onUnload()
	self.m_movieComp:removeAllCriSprite()
end

function GuildDungeonChapterLayer:_addListener()
	self.m_skillBtn:addClickListener(handler(self, self._onClickSkill))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRank))
	self.m_awardBtn:addClickListener(handler(self, self._onClickPassAward))
	self.m_boxTouchBg:addClickListener(handler(self, self._onClickStageAward))
	self.m_leftArrowBtn:addClickListener(handler(self, self._onClickArrowBtn))
	self.m_rightArrowBtn:addClickListener(handler(self, self._onClickArrowBtn))
end

function GuildDungeonChapterLayer:_addNetWorkListener()
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_GUILD_DUNGEON_GETCHAPTER, self._onS2CGetChapter, self)
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_GUILD_DUNGEON_BROADCASTDAMAGE, self._onRcvBroadcastDamage, self)
	var_0_3:addEventListener(var_0_2.EVENT_REFRESH_GUILD_DUNGEON_LAYER, self._refreshLayer, self)
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_GUILD_DUNGEON_ONEKEYGETFINISHAWARD, self._onRcvGetOneKeyBoxAward, self)
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_GUILD_DUNGEON_GETTREASUREBOX, self._onRcvGetTreasureBox, self)
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_GUILD_DUNGEON_GETINFO, self._refreshLayer, self)
	var_0_3:addEventListener(var_0_2.EVENT_NET_S2C_GUILD_DUNGEON_ATTACKFINISH, self._onS2CAttackFinish, self)
	var_0_6:send_C2S_GetModuleTaskInfo({
		module_id = var_0_0.TaskConst.MODULE_ID.GUILD_DUNGEON
	})
	var_0_3:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_skillBtn
	})
	var_0_3:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_awardBtn
	})
end

function GuildDungeonChapterLayer:_updateChapterComp()
	for iter_13_0 = 1, var_0_1.STAGE_NUM do
		self["m_monsterComp" .. iter_13_0]:updateComp({
			index = iter_13_0,
			chapterId = self._chapterId,
			stageData = self._stageList[iter_13_0]
		})
	end
end

function GuildDungeonChapterLayer:_updateChapterInfo()
	local var_14_0 = self._chapterData:getCfg().name
	local var_14_1 = string.match(var_14_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*")

	self.m_name1:setText(var_14_1)
	self.m_name2:setText((string.sub(var_14_0, string.len(var_14_1) + 1, -1)))
	self:_updateChapterProg()
	self:_updateBox()
end

function GuildDungeonChapterLayer:_updateBox()
	if var_0_4:isLastChapter(self._chapterId) then
		return
	end

	self._boxAnim = "in"

	for iter_15_0, iter_15_1 in pairs(self._stageList) do
		if iter_15_1:isStageFinish() and not iter_15_1:isRecTreasure() then
			self._boxAnim = "idle"

			break
		end
	end

	self._boxSpine:setAnimation(0, self._boxAnim, true)
end

function GuildDungeonChapterLayer:_updateChapterProg()
	local var_16_0 = self._chapterData:getChapterTotalHp()
	local var_16_1 = string.format("%d", math.uint64_mul(math.uint64_div(math.uint64_sub(var_16_0, (self._chapterData:getCurrentHp())), var_16_0), 100))

	self.m_progText:setText(g.core.lang:get(1078, {
		value = var_16_1
	}))

	if not var_0_4:isLastChapter(self._chapterId) and var_16_1 == "100" and var_0_4:getCurChapterId() == self._chapterId then
		var_0_6:send_C2S_GuildDungeon_GetInfo({})
	end
end

function GuildDungeonChapterLayer:_onClickSkill()
	self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonSkillPop").new())
end

function GuildDungeonChapterLayer:_onClickRank()
	self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonRankPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function GuildDungeonChapterLayer:_onClickPassAward()
	self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonClearAwardPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function GuildDungeonChapterLayer:_onClickStageAward()
	self:addPopup(require("app.view.module.guildDungeon.view.GuildDungeonBoxPop").new({
		stageList = self._stageList
	}), {
		touchDisappear = true
	})
end

function GuildDungeonChapterLayer:_onS2CGetChapter(arg_21_1, arg_21_2, arg_21_3)
	self:_updateWithChapterId(arg_21_3.chapter_id)
end

function GuildDungeonChapterLayer:_onRcvGetTreasureBox()
	self:_updateBox()
end

function GuildDungeonChapterLayer:_onRcvBroadcastDamage(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = var_0_4:getChapterIdByStageId(arg_23_3.stage_id)

	if not var_23_0 or var_23_0 ~= self._chapterId then
		return
	end

	self["m_monsterComp" .. ((arg_23_3.stage_id % var_0_1.STAGE_NUM == 0 or nil) and var_0_1.STAGE_NUM)]:showDamage(arg_23_3)
	self:_updateChapterProg()
end

function GuildDungeonChapterLayer:_refreshLayer()
	self:_updateChapterComp()
	self:_updateChapterInfo()
end

function GuildDungeonChapterLayer:_onS2CAttackFinish(arg_25_1, arg_25_2, arg_25_3)
	if arg_25_3.current_chapter_id > self._chapterId then
		var_0_6:send_C2S_GuildDungeon_GetInfo({})
	end
end

function GuildDungeonChapterLayer:_onRcvGetOneKeyBoxAward(arg_26_1, arg_26_2, arg_26_3)
	require("app.view.module.show.ShowFactory"):awardSummary((var_0_4:getOneKeyAwardList(arg_26_3)))
end

function GuildDungeonChapterLayer:_onClickArrowBtn(arg_27_1)
	if arg_27_1:getSender() == self.m_leftArrowBtn then
		var_0_6:send_C2S_GuildDungeon_GetChapter({
			chapter_id = self._chapterId - 1
		})
	elseif var_0_4:getCurChapterId() < self._chapterId + 1 then
		g.core.module.ModuleManager:tip((g.core.lang:get(306009, {
			chapter = self._chapterId
		})))
	else
		local var_27_0 = var_0_4:getChapterById(self._chapterId + 1):getCfg()

		if var_0_5:getGuildLevel() >= var_27_0.level then
			var_0_6:send_C2S_GuildDungeon_GetChapter({
				chapter_id = self._chapterId + 1
			})
		else
			g.core.module.ModuleManager:tip((g.core.lang:get(306008, {
				level = var_27_0.level
			})))
		end
	end
end

return GuildDungeonChapterLayer
