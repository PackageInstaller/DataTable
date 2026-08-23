local ThemeAnubisBioVoteSelectionLayer = class("ThemeAnubisBioVoteSelectionLayer", require("app.fairyGUI.themeBio.UI_ThemeAnubisBioVoteSelectionLayer"), function()
	return fgui.GComponent:create({
		resName = "ThemeAnubisBioVoteSelectionLayer",
		pkgPath = "ui/themeBio/themeBio",
		isFullScreen = true,
		pkgName = "themeBio"
	}, ...)
end)
local var_0_1 = g.core.config.theme_vote_info
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.lang
local var_0_5 = g.core.const.ConstMgr.ThemeConst
local var_0_6 = g.core.model.User.themeData
local var_0_7 = g.core.const.ConstMgr.ThemeBioConst.VOTE_STATE
local var_0_8 = {
	[g.core.const.ConstMgr.ThemeBioConst.VOTE_STATE.LOCK] = "lock",
	[g.core.const.ConstMgr.ThemeBioConst.VOTE_STATE.UNLOCK_NOT_VOTE] = "selected",
	[g.core.const.ConstMgr.ThemeBioConst.VOTE_STATE.VOTED_ONGOING] = "wait",
	[g.core.const.ConstMgr.ThemeBioConst.VOTE_STATE.FINISH_NO_RIGHT] = "finish",
	[g.core.const.ConstMgr.ThemeBioConst.VOTE_STATE.FINISH_RIGHT] = "correct",
	[g.core.const.ConstMgr.ThemeBioConst.VOTE_STATE.FINISH_WRONG] = "wrong"
}

function ThemeAnubisBioVoteSelectionLayer:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._themeValue = arg_2_1.themeValue
	self._chapterId = arg_2_1.chapterId
	self._selectionComp = nil

	if not self._themeValue then
		return
	end

	local var_2_0 = var_0_6:getThemeData(self._themeValue)

	self._themeBioData = var_2_0 and var_2_0:getThemeBioData()
	self._voteData = self._themeBioData:getVoteData()
	self._selectedIndex = arg_2_1.showResult and self:_getFirstNewResultVote() or self:_getDefaultSelectedVote()
	self._isNewResult = self._themeBioData:judgeBioChapterRecordByType((self._voteData[self._selectedIndex] and self._voteData[self._selectedIndex].voteInfo).id, "_NEW_RESULT")

	self.m_voteList:setVirtual(self)
	self.m_voteList:setItemRenderer(handler(self, self._onSelectionRender))
	self:addBg("bg/theme/bg_activity21_anubis_tuili2.jpg")
	self.m_topBar:setResInfoById(1007)

	self._displayInfo = g.core.config.activity_theme_display_info.get(self._themeValue)

	self.m_topBar:setTitle(self._displayInfo.biography_name)
	self.m_showController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowCtrlChanged))
	self.m_touchArea:addClickListener(handler(self, self._onClickTouchArea))
	self.m_blockArea:addClickListener(handler(self, self._onClickBlockArea))

	self._isVoteReturn = false
end

function ThemeAnubisBioVoteSelectionLayer:_getFirstNewResultVote()
	local var_3_0 = 1

	for iter_3_0, iter_3_1 in ipairs(self._voteData) do
		local var_3_1 = iter_3_1.voteInfo
		local var_3_2, var_3_3 = self:_getVoteState(iter_3_1.voteInfo, iter_3_1.chapterId)

		if (var_3_2 == var_0_8[var_0_7.FINISH_NO_RIGHT] or var_3_2 == var_0_8[var_0_7.FINISH_RIGHT] or var_3_2 == var_0_8[var_0_7.FINISH_WRONG]) and self._themeBioData:judgeBioChapterRecordByType(var_3_1.id, "_NEW_RESULT") then
			var_3_0 = iter_3_0

			break
		end

		if self._themeBioData:hasOnlyOneOption(var_3_1) and var_3_2 == var_0_8[var_0_7.UNLOCK_NOT_VOTE] then
			var_3_0 = iter_3_0

			break
		end
	end

	return var_3_0
end

function ThemeAnubisBioVoteSelectionLayer:_getDefaultSelectedVote()
	local var_4_0 = 1

	for iter_4_0, iter_4_1 in ipairs(self._voteData) do
		local var_4_1, var_4_2 = self:_getVoteState(iter_4_1.voteInfo, iter_4_1.chapterId)

		if self._chapterId then
			if var_4_1 == var_0_8[var_0_7.LOCK] then
				break
			else
				var_4_0 = iter_4_0
			end
		else
			if var_4_1 == var_0_8[var_0_7.UNLOCK_NOT_VOTE] then
				var_4_0 = iter_4_0

				break
			end

			if var_4_1 ~= var_0_8[var_0_7.LOCK] then
				var_4_0 = iter_4_0
			end

			if var_4_1 == var_0_8[var_0_7.LOCK] then
				break
			end
		end
	end

	return var_4_0
end

function ThemeAnubisBioVoteSelectionLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_BIOGRAPHY_VOTE, handler(self, self._onVote), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	self:_updateView(self._isNewResult)

	self._isNewResult = false

	self.m_enterTransition:play()
end

function ThemeAnubisBioVoteSelectionLayer:_onCrossDayUpdate()
	local var_6_1 = g.core.model.User.activityDataManager:getShowActivityDataByCfg(var_0_5.THEME_TYPE, self._themeValue)

	if not ((var_6_1 and var_6_1:isOpen() or nil) and true) then
		g.core.module.ModuleManager:popToRoot()

		return
	end

	self:_updateView()
end

function ThemeAnubisBioVoteSelectionLayer:_checkNewResultVote(arg_7_1)
	if self._themeBioData:judgeBioChapterRecordByType(arg_7_1.id, "_NEW_RESULT") then
		local var_7_0 = {}
		local var_7_1 = self._themeBioData:getChapterIdByVoteId(arg_7_1.id)
		local var_7_2 = self._themeBioData:getAvgIdByVoteInfo(arg_7_1)

		var_7_0[#var_7_0 + 1] = {
			func = handler(self, self._checkVoteResultPop)
		}

		if var_7_2 ~= 0 then
			var_7_0[#var_7_0 + 1] = {
				func = handler(self, function()
					if self._checkUploadStats then
						self:_checkUploadStats(var_7_1, var_7_2)
					end

					return var_0_2:pushModule(g.view.entrance.STORY_DIALOG, {
						id = var_7_2
					})
				end)
			}
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			afterShow = var_7_0
		})
	end
end

function ThemeAnubisBioVoteSelectionLayer:_onModuleExit(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_3 and arg_9_3.params

	if not (arg_9_3 and arg_9_3.params) then
		return
	end

	if var_9_0 then
		local var_9_1 = var_9_0.tag or ""

		if var_9_1 == "ThemeBio_VoteComplete" then
			self:_updateView(true)
		elseif var_9_1 == "ThemeBio_VoteResult" then
			self:_updateView(true)
		elseif arg_9_3 == g.view.entrance.STORY_DIALOG then
			self:_updateView()
		end
	end
end

function ThemeAnubisBioVoteSelectionLayer:_onVote(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = var_0_1.get(arg_10_4.vote_id)
	local var_10_1 = self._themeBioData:isVoteResultRevealed(arg_10_4.vote_id)
	local var_10_2 = {}
	local var_10_3 = false
	local var_10_4 = self._themeBioData:getAvgIdByVoteInfo(var_10_0)

	self._isVoteReturn = true
	self._voteInfo = var_10_0

	local var_10_5 = self._themeBioData:getChapterIdByVoteId(arg_10_4.vote_id)

	if not var_10_1 then
		var_10_2 = {
			{
				func = handler(self, self._checkVoteCompletePop)
			}
		}
	elseif var_10_1 and self._themeBioData:hasOnlyOneOption(var_10_0) then
		var_10_2[#var_10_2 + 1] = {
			func = handler(self, self._checkVoteResultPop)
		}

		if var_10_4 ~= 0 then
			var_10_2[#var_10_2 + 1] = {
				func = handler(self, function()
					if self._checkUploadStats then
						self:_checkUploadStats(var_10_5, var_10_4)
					end

					return var_0_2:pushModule(g.view.entrance.STORY_DIALOG, {
						id = var_10_4
					})
				end)
			}
		end

		var_10_3 = true
	else
		var_10_2[#var_10_2 + 1] = {
			func = handler(self, self._checkVoteCompletePop)
		}
		var_10_2[#var_10_2 + 1] = {
			func = handler(self, self._checkVoteResultPop)
		}

		if var_10_4 ~= 0 then
			var_10_2[#var_10_2 + 1] = {
				func = handler(self, function()
					if self._checkUploadStats then
						self:_checkUploadStats(var_10_5, var_10_4)
					end

					return var_0_2:pushModule(g.view.entrance.STORY_DIALOG, {
						id = var_10_4
					})
				end)
			}
		end

		var_10_3 = true
	end

	if arg_10_4.awards then
		local var_10_6 = {
			showNow = true
		}
		local var_10_7 = {}

		var_10_7.awards = arg_10_4.awards or {}
		var_10_6.award = var_10_7
		var_10_6.afterShow = var_10_2

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, var_10_6)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			afterShow = var_10_2
		})
	end

	self:_updateView(var_10_3)
end

function ThemeAnubisBioVoteSelectionLayer:receiveCompEvent(arg_13_1, arg_13_2)
	arg_13_2 = arg_13_2 or {}

	if arg_13_1 == "ThemeBioVote_clickKnight" then
		if arg_13_2.isUnlockedEnding then
			var_0_2:tip(var_0_4:get(409154))
		else
			self.m_showController:setSelectedIndex(arg_13_2.compIndex)

			local var_13_0 = 0
			local var_13_1 = self._themeBioData:needShowVotePercent(arg_13_2.voteInfo.id)

			if var_13_1 then
				var_13_0 = self._themeBioData:getVotePercent(arg_13_2.voteInfo.id, arg_13_2.optionVote)
			end

			local var_13_2 = self._themeBioData:getOptionInfo(arg_13_2.voteInfo)[arg_13_2.optionVote]

			self.m_detailComp:updateDetailComp({
				voteInfo = arg_13_2.voteInfo,
				optionInfo = var_13_2,
				optionVote = arg_13_2.optionVote,
				optionTxt = arg_13_2.optionTxt,
				chapterId = arg_13_2.chapterId,
				votePercent = var_13_0,
				showVotePercent = var_13_1,
				iconPath = self:_getThemeVoteRes(var_13_2.optionNo),
				iconSelectedPath = self:_getThemeVoteSelectedRes(var_13_2.optionNo),
				hasVoted = self._themeBioData:hasVoted(arg_13_2.voteInfo.id)
			})
		end
	elseif arg_13_1 == "ThemeAnubisBioVoteItemComp_onClickItem" then
		self._chapterId = arg_13_2.chapterId

		if arg_13_2.info.pre_vote > 0 then
			local var_13_3 = self._themeBioData:getChapterIdByVoteId(arg_13_2.info.pre_vote)

			if var_13_3 > 0 then
				local var_13_4, var_13_5 = self:_getVoteState(self._themeBioData:getVoteInfoById(arg_13_2.info.pre_vote), var_13_3)

				if var_13_4 == var_0_8[var_0_7.UNLOCK_NOT_VOTE] then
					var_0_2:tip(var_0_4:get(409149))

					return
				end
			end
		end

		local var_13_6 = self._selectedIndex ~= arg_13_2.compIndex

		self._selectedIndex = arg_13_2.compIndex

		for iter_13_0 = 1, self.m_voteList:numChildren() do
			local var_13_7 = self.m_voteList:getChildAt(iter_13_0 - 1)

			if iter_13_0 == arg_13_2.compIndex then
				var_13_7:setSelected(true)
				var_13_7:setCtrlState("selected", {
					index = 1
				})
			else
				var_13_7:setSelected(false)
				var_13_7:setCtrlState("selected", {
					index = 0
				})
			end
		end

		self._isNewResult = self._themeBioData:judgeBioChapterRecordByType(arg_13_2.info.id, "_NEW_RESULT")

		if var_13_6 then
			self:_updateKnights(arg_13_2.info, arg_13_2.chapterId, self._isNewResult)
		end

		self:_checkLastVoteAutoVote(arg_13_2.info, arg_13_2.chapterId)
	elseif arg_13_1 == "ThemeBioVoteKnight_onClickConfirmBtn" then
		self._selectionComp = self["m_selection" .. arg_13_2.optionVote]

		g.core.network.GameNetProxy:send_C2S_ThemeBiography_Vote({
			act_id = self._themeBioData:getActivityValue(),
			vote_id = arg_13_2.voteId,
			vote_option = arg_13_2.optionVote,
			chapter = arg_13_2.chapterId
		})
		self.m_showController:setSelectedIndex(0)
	elseif arg_13_1 == "ThemeBioVoteResult_clickReviewBtn" then
		if arg_13_2.optionInfo.optionAvg ~= 0 then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
				id = arg_13_2.optionInfo.optionAvg
			})
			self:_checkUploadStats(self._themeBioData:getChapterIdByVoteId(arg_13_2.voteInfo.id), arg_13_2.optionInfo.optionAvg)
		end
	end
end

function ThemeAnubisBioVoteSelectionLayer:_playSelectAnim()
	if self._selectionComp then
		self.m_highLight:setVisible(true)
		self.m_highLight:playSelectAnim(self._selectionComp:getPosition(), function()
			self.m_highLight:setVisible(false)
		end)
	end
end

function ThemeAnubisBioVoteSelectionLayer:_onShowCtrlChanged(arg_16_1)
	if self.m_showController:getSelectedIndex() > 0 then
		for iter_16_0 = 1, 3 do
			if self["m_selection" .. iter_16_0] then
				self["m_selection" .. iter_16_0]:setTouchable(false)
			end
		end

		self.m_voteList:setTouchable(false)
	else
		for iter_16_1 = 1, 3 do
			if self["m_selection" .. iter_16_1] then
				self["m_selection" .. iter_16_1]:setSelected(false)
				self["m_selection" .. iter_16_1]:setTouchable(true)
			end
		end

		self.m_voteList:setTouchable(true)
	end
end

function ThemeAnubisBioVoteSelectionLayer:_onClickTouchArea(arg_17_1)
	local var_17_0 = self.m_showController:getSelectedIndex()

	if var_17_0 > 0 and arg_17_1 then
		local var_17_1 = arg_17_1:getInput():getTouch():getLocation()

		if self["m_selection" .. var_17_0] and not self["m_selection" .. var_17_0]:containPoint(var_17_1) and not self.m_detailComp:containPoint(var_17_1) then
			self.m_showController:setSelectedIndex(0)
		end
	end
end

function ThemeAnubisBioVoteSelectionLayer:_onClickBlockArea(arg_18_1)
	local var_18_0 = arg_18_1:getInput():getTouch():getLocation()

	for iter_18_0 = 1, 3 do
		if self["m_selection" .. iter_18_0]:getChild("touch"):containPoint(var_18_0) then
			var_0_2:tip(var_0_4:get(409153))

			return
		end
	end
end

function ThemeAnubisBioVoteSelectionLayer:_updateKnights(arg_19_1, arg_19_2, arg_19_3)
	self.m_showController:setSelectedIndex(0)

	local var_19_0 = self._themeBioData:getOptionInfo(arg_19_1)

	if #var_19_0 == 1 then
		self.m_numTypeController:setSelectedIndex(1)

		if self.m_selection0 then
			self.m_selection0:updateKnightSelection({
				compIndex = 1,
				isSelected = true,
				voteInfo = arg_19_1,
				optionInfo = var_19_0[1],
				chapterId = arg_19_2,
				iconPath = self:_getThemeVoteRes(var_19_0[1].optionNo),
				iconSelectedPath = self:_getThemeVoteSelectedRes(var_19_0[1].optionNo),
				hasVoted = self._themeBioData:hasVoted(arg_19_1.id)
			})
		end
	else
		self.m_numTypeController:setSelectedIndex(0)

		for iter_19_0 = 1, math.min(#var_19_0, 3) do
			if self["m_selection" .. iter_19_0] then
				self["m_selection" .. iter_19_0]:updateKnightSelection({
					voteInfo = arg_19_1,
					optionInfo = var_19_0[iter_19_0],
					chapterId = arg_19_2,
					compIndex = iter_19_0,
					isSelected = self._themeBioData:isVotedByVoteIdAndOption(arg_19_1.id, var_19_0[iter_19_0].optionVote),
					iconPath = self:_getThemeVoteRes(var_19_0[iter_19_0].optionNo),
					isUnlockedEnding = self._themeBioData:isUnlockedEnding(arg_19_1.id, var_19_0[iter_19_0].optionVote),
					iconSelectedPath = self:_getThemeVoteSelectedRes(var_19_0[iter_19_0].optionNo),
					hasVoted = self._themeBioData:hasVoted(arg_19_1.id)
				})
			end
		end
	end

	local var_19_1, var_19_2 = self:_getVoteState(arg_19_1, arg_19_2)

	if var_19_1 == var_0_8[var_0_7.LOCK] then
		self.m_stageController:setSelectedPage("not_voted")
	elseif var_19_1 == var_0_8[var_0_7.UNLOCK_NOT_VOTE] then
		self.m_stageController:setSelectedPage("not_voted")
	elseif var_19_1 == var_0_8[var_0_7.VOTED_ONGOING] then
		self.m_stageController:setSelectedPage("voted")
	elseif var_19_1 == var_0_8[var_0_7.FINISH_NO_RIGHT] or var_19_1 == var_0_8[var_0_7.FINISH_RIGHT] or var_19_1 == var_0_8[var_0_7.FINISH_WRONG] then
		if self._isVoteReturn then
			self._isVoteReturn = false
		else
			self:_checkNewResultVote(arg_19_1)
		end

		if arg_19_3 then
			self.m_stageController:setSelectedPage("voted")
		else
			local var_19_3 = self.m_stageController:getSelectedPage() == "finish"

			self.m_stageController:setSelectedPage("finish")
			self:_updateResultComp(arg_19_1)

			if var_19_3 then
				self.m_resultComp:playSwitchEffect()
			else
				self.m_resultComp:playEnterEffect()
			end
		end

		self._themeBioData:setBioChapterRecordByType(arg_19_1.id, "_NEW_RESULT")
	end

	self:_updateTipComp(arg_19_1, arg_19_2, arg_19_3)
end

function ThemeAnubisBioVoteSelectionLayer:_checkUploadStats(arg_20_1, arg_20_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_SUPERSDK_STATS, false, {
		event_id = g.core.const.ConstMgr.SuperSdkConst.THEME_BIO_VOTE_END_STORY,
		extra = arg_20_1,
		errMsg = arg_20_2
	})
end

function ThemeAnubisBioVoteSelectionLayer:_updateResultComp(arg_21_1)
	local var_21_0, var_21_1 = self._themeBioData:getRightOption(arg_21_1)

	if not var_21_0 or not var_21_0.optionNo or var_21_0.optionNo == 0 then
		var_21_0 = self._themeBioData:getMyVotedInfo(arg_21_1)
		var_21_1 = true
	end

	if var_21_0 and var_21_0.optionNo then
		self.m_resultComp:updateResultComp({
			voteInfo = arg_21_1,
			showOptionInfo = var_21_0,
			iconPath = self:_getThemeVoteRes(var_21_0.optionNo),
			isMyVote = var_21_1,
			optionNo = var_21_0.optionNo
		})
	end
end

function ThemeAnubisBioVoteSelectionLayer:_updateTipComp(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0, var_22_1 = self:_getVoteState(arg_22_1, arg_22_2)
	local var_22_2
	local var_22_3
	local var_22_4

	if var_22_0 == var_0_8[var_0_7.UNLOCK_NOT_VOTE] then
		var_22_2 = self._themeBioData:getVoteGroupInfo(arg_22_2).goal
		var_22_4 = 0
	elseif var_22_0 == var_0_8[var_0_7.VOTED_ONGOING] then
		local var_22_5 = self._themeBioData:getVoteResultLastTime(arg_22_1)

		var_22_3 = var_22_5 - g.core.common.ServerTime:getTime() > 86400 and var_0_4:get(409145, {
			str = g.core.common.ServerTime:getLeftDHFormat(var_22_5)
		}) or var_0_4:get(409163)
		var_22_4 = 1
	else
		local var_22_6 = self._themeBioData:getMyVotedInfo(arg_22_1)
		local var_22_7

		if var_22_6 then
			var_22_7 = var_22_6.optionNo or 0
		end

		local var_22_8

		if var_22_7 > 0 then
			if g.core.config.knight_base_info.hasData(var_22_7) then
				var_22_8 = g.core.config.knight_base_info.get(var_22_7).name
			end
		end

		var_22_2 = var_22_8

		if var_22_0 == var_0_8[var_0_7.FINISH_NO_RIGHT] then
			var_22_4 = 4
		elseif var_22_0 == var_0_8[var_0_7.FINISH_RIGHT] then
			var_22_4 = 2
		elseif var_22_0 == var_0_8[var_0_7.FINISH_WRONG] then
			var_22_4 = 3
		end

		if arg_22_3 then
			var_22_4 = 4
		end
	end

	self.m_tipComp:updateTipComp({
		goalText = var_22_2,
		waitText = var_22_3,
		state = var_22_4
	})
end

function ThemeAnubisBioVoteSelectionLayer:onUnload()
	return
end

function ThemeAnubisBioVoteSelectionLayer:_updateView(arg_24_1)
	self._voteData = self._themeBioData:getVoteData()

	self.m_voteList:setNumItems(#self._voteData)
	self.m_voteList:getChildAt(self._selectedIndex - 1):setSelected(true)
	self.m_voteList:getChildAt(self._selectedIndex - 1):setCtrlState("selected", {
		index = 1
	})

	local var_24_0 = self._voteData[self._selectedIndex] and self._voteData[self._selectedIndex].voteInfo
	local var_24_1 = self._voteData[self._selectedIndex] and self._voteData[self._selectedIndex].chapterId

	self:_updateKnights(var_24_0, var_24_1, arg_24_1)
	self:_checkLastVoteAutoVote(var_24_0, var_24_1)
end

function ThemeAnubisBioVoteSelectionLayer:_onSelectionRender(arg_25_1, arg_25_2)
	if self._voteData[arg_25_1 + 1].voteInfo then
		local var_25_0, var_25_1 = self:_getVoteState(self._voteData[arg_25_1 + 1].voteInfo, self._voteData[arg_25_1 + 1].chapterId)

		arg_25_2:updateVoteItem({
			info = self._voteData[arg_25_1 + 1].voteInfo,
			chapterId = self._voteData[arg_25_1 + 1].chapterId,
			state = var_25_0,
			unlockStr = var_25_1,
			compIndex = arg_25_1 + 1,
			hasOnlyOneOption = self._themeBioData:hasOnlyOneOption(self._voteData[arg_25_1 + 1].voteInfo)
		})
	end
end

function ThemeAnubisBioVoteSelectionLayer:_getVoteState(arg_26_1, arg_26_2)
	if not self._themeBioData:isVoteOpen(arg_26_1.id) then
		return var_0_8[var_0_7.LOCK], self:_getTimeUnlockStr(arg_26_1.id)
	elseif not self._themeBioData:hasFinishChapter(arg_26_2) then
		return var_0_8[var_0_7.LOCK], var_0_4:get(409143)
	elseif arg_26_1.pre_vote > 0 and not self._themeBioData:hasVoted(arg_26_1.pre_vote) then
		return var_0_8[var_0_7.LOCK], var_0_4:get(409144)
	elseif not self._themeBioData:hasVoted(arg_26_1.id) then
		return var_0_8[var_0_7.UNLOCK_NOT_VOTE]
	elseif self._themeBioData:isVoteOnging(arg_26_1.id) then
		return var_0_8[var_0_7.VOTED_ONGOING]
	elseif self._themeBioData:hasOnlyOneOption(arg_26_1) or self._themeBioData:hasNoRightOption(arg_26_1) then
		return var_0_8[var_0_7.FINISH_NO_RIGHT]
	elseif self._themeBioData:isVoteRight(arg_26_1.id) then
		return var_0_8[var_0_7.FINISH_RIGHT]
	else
		return var_0_8[var_0_7.FINISH_WRONG]
	end
end

function ThemeAnubisBioVoteSelectionLayer:_getTimeUnlockStr(arg_27_1)
	local var_27_0 = self._themeBioData:getThemeBioVoteStartTime(arg_27_1)
	local var_27_1 = g.core.common.ServerTime:getTime()
	local var_27_2 = ""

	if var_27_0 > 0 and var_27_1 < var_27_0 then
		local var_27_3 = g.core.common.ServerTime:getDeltaDays(var_27_1, var_27_0)

		var_27_2 = var_27_3 > 1 and g.core.lang:get(409142, {
			day = var_27_3
		}) or g.core.lang:get(409137)
	end

	return var_27_2
end

function ThemeAnubisBioVoteSelectionLayer:_getThemeVoteRes(arg_28_1)
	return var_0_3:getThemeBioVoteRes(arg_28_1)
end

function ThemeAnubisBioVoteSelectionLayer:_getThemeVoteSelectedRes(arg_29_1)
	return var_0_3:getThemeBioVoteRes(arg_29_1 .. "_1")
end

function ThemeAnubisBioVoteSelectionLayer:_checkLastVoteAutoVote(arg_30_1, arg_30_2)
	if self._themeBioData:hasOnlyOneOption(arg_30_1) then
		local var_30_0, var_30_1 = self:_getVoteState(arg_30_1, arg_30_2)

		if var_30_0 == var_0_8[var_0_7.UNLOCK_NOT_VOTE] then
			self._noRightOptionVote = true

			local var_30_2 = 0

			for iter_30_0, iter_30_1 in ipairs((self._themeBioData:getOptionInfo(arg_30_1))) do
				if iter_30_1.optionNo > 0 then
					var_30_2 = iter_30_1.optionVote

					break
				end
			end

			if var_30_2 > 0 then
				g.core.network.GameNetProxy:send_C2S_ThemeBiography_Vote({
					act_id = self._themeBioData:getActivityValue(),
					vote_id = arg_30_1.id,
					vote_option = var_30_2,
					chapter = arg_30_2
				})
			end
		end
	end
end

function ThemeAnubisBioVoteSelectionLayer:_checkVoteCompletePop()
	if not self._voteInfo then
		return
	end

	local var_31_0
	local var_31_1 = self._themeBioData:getVoteResultLastTime(self._voteInfo)
	local var_31_2 = g.core.common.ServerTime:getTime()

	if var_31_1 - var_31_2 > 86400 then
		var_31_0 = var_0_4:get(409145, {
			str = g.core.common.ServerTime:getLeftDHFormat(var_31_1)
		})
	elseif var_31_1 - var_31_2 > 0 then
		var_31_0 = var_0_4:get(409163)
	end

	self._voteInfo = nil

	return var_0_2:pushPopup(require("app.view.module.themeBio.view.vote.pop.anubis.ThemeAnubisBioVoteCompletePop").new({
		tipTxt = var_31_0,
		callback = handler(self, self._playSelectAnim)
	}), {
		tag = "ThemeBio_VoteComplete",
		hideContinue = true,
		touchDisappear = true,
		withoutAni = false
	})
end

function ThemeAnubisBioVoteSelectionLayer:_checkVoteResultPop()
	return var_0_2:pushPopup(require("app.view.module.themeBio.view.vote.pop.anubis.ThemeAnubisBioVoteResultPop").new(), {
		tag = "ThemeBio_VoteResult",
		hideContinue = true,
		touchDisappear = true,
		withoutAni = false
	})
end

return ThemeAnubisBioVoteSelectionLayer
