local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_3 = g.core.common.Goods
local ActionPopComp = class("ActionPopComp", require("app.fairyGUI.recruit.UI_ActionPopComp"))

function ActionPopComp:ctor()
	self._rewardEntrance = g.view.entrance.RECRUIT_REWARD

	self:_reset()
	self.m_jumpBtn:addClickListener(handler(self, self._onJumpBtnClicked))
end

function ActionPopComp:setRewardEntrance(arg_2_1)
	self._rewardEntrance = arg_2_1
end

function ActionPopComp:_reset()
	for iter_3_0, iter_3_1 in ipairs((self:getChildren())) do
		iter_3_1:setVisible(false)
	end

	self.m_effectNode:setVisible(true)

	local var_3_0 = self.m_knightComp3:getPosition()

	var_3_0.x = display.width

	self.m_knightComp3:setPosition(var_3_0)

	for iter_3_2 = 1, 2 do
		local var_3_1 = self["m_knightComp" .. iter_3_2]:getPosition()

		var_3_1.x = var_3_1.x + (display.width - var_3_0.x)

		self["m_knightComp" .. iter_3_2]:setPosition(var_3_1)
	end

	self.m_jumpBtn:setVisible(true)
end

function ActionPopComp:updateComp(arg_4_1, arg_4_2, arg_4_3)
	self._matchQuality = arg_4_3
	self._params = arg_4_1
	self._isPrimary = arg_4_2

	local var_4_0 = {}
	local var_4_1 = g.core.config.parameter_info.get(g.core.const.ConstMgr.RecruitConst.KNIGHT_NEW_SHOW_LIMIT_QUALITY_ID).parameter

	for iter_4_0, iter_4_1 in ipairs(self._params.awards) do
		local var_4_2 = var_0_3:convert(iter_4_1)
		local var_4_3 = iter_4_1.isNew and var_4_1 <= var_4_2.quality

		if iter_4_1.type == var_0_3.TYPE_KNIGHT and (var_4_3 or var_4_2.quality >= self._matchQuality) then
			table.insert(var_4_0, {
				knightId = iter_4_1.value,
				quality = var_4_2.quality,
				isNew = var_4_3,
				hideFrag = iter_4_1.hideFrag
			})
		end
	end

	self._showInfos = var_4_0
	self._playIdx = 1

	self:_createKnightPop()
	self:_updateOneAction()
	self.m_actionMask:setVisible(true)
end

function ActionPopComp:_getPopShowInfos()
	local var_5_0 = {}
	local var_5_1 = self._showInfos[self._playIdx]

	if self._showInfos[self._playIdx] then
		local var_5_2 = var_5_1.quality > self._matchQuality

		var_5_0[1] = var_5_1

		for iter_5_0 = self._playIdx + 1, #self._showInfos do
			if var_5_2 and self._showInfos[iter_5_0].quality > self._matchQuality then
				var_5_0[#var_5_0 + 1] = self._showInfos[iter_5_0]
				self._playIdx = iter_5_0
			elseif not var_5_2 and self._showInfos[iter_5_0].quality <= 2 then
				var_5_0[#var_5_0 + 1] = self._showInfos[iter_5_0]
				self._playIdx = iter_5_0
			else
				break
			end
		end
	else
		return var_5_0
	end

	return var_5_0
end

function ActionPopComp:_updateOneAction()
	self:_reset()
	self._knightPop:resetUI()

	if self._playIdx <= #self._showInfos then
		self._knightPop:updatePop({
			isPrimary = self._isPrimary,
			callBack = handler(self, self._playNextAction)
		}, (self:_getPopShowInfos()))

		if self._showInfos[self._playIdx].quality > self._matchQuality then
			self._knightPop:setVisible(false)
			self.m_effectNode:setVisible(true)

			local var_6_0

			for iter_6_0, iter_6_1 in ipairs((self._knightPop:getShowDatas())) do
				if iter_6_1.info.advance_id == self._showInfos[self._playIdx].knightId then
					var_6_0 = iter_6_1

					break
				end
			end

			self._eventNames = {
				"AVG1",
				"ssr1",
				"enter",
				"ssr2",
				"end"
			}
			self._spine = self.m_effectNode:addEffectSpine({
				isLoop = false,
				remove = true,
				name = "eff_ui_recruit_ssr",
				anim = "ssr_play",
				eventHandler = handler(self, self._onSpineEventCallback)
			})

			self:_initTextSlot(var_6_0)
			self:_initGroupSlot(var_6_0)
			self:_initKnightComps(var_6_0)
		else
			self:_onSpinePlayEnd()
		end
	else
		self:_allActionPlayEnd()
	end
end

function ActionPopComp:_showLeftKnightPop()
	self.m_groupBgLoader:setVisible(false)

	if self._playIdx <= #self._showInfos then
		self._knightPop:resetUI()

		local var_7_0 = {}

		for iter_7_0 = self._playIdx, #self._showInfos do
			self._playIdx = iter_7_0

			table.merge(var_7_0, (self:_getPopShowInfos()))
		end

		self._knightPop:updatePop({
			isPrimary = self._isPrimary,
			callBack = handler(self, self._playNextAction)
		}, var_7_0)
		self._knightPop:setVisible(true)
		self._knightPop:playNextKnight()
	else
		self:_allActionPlayEnd()
	end
end

function ActionPopComp:_onSpineEventCallback(arg_8_1, arg_8_2)
	if arg_8_1.type == "event" then
		local var_8_0 = table.remove(self._eventNames, 1)

		if var_8_0 == "AVG1" then
			self.m_bgTransition:play()
			self.m_groupBgLoader:setVisible(true)
			self.m_groupBgLoaderEff:setVisible(true)
		elseif var_8_0 == "ssr1" then
			local var_8_1

			for iter_8_0, iter_8_1 in ipairs((self._knightPop:getShowDatas())) do
				if iter_8_1.info.advance_id == self._showInfos[self._playIdx].knightId then
					var_8_1 = iter_8_1

					break
				end
			end

			if var_8_1.info and var_8_1.info.quality >= self._matchQuality then
				self.m_groupBgLoader:setVisible(false)
				self._knightPop:resetUI()
				self._knightPop:setVisible(true)
				self._knightPop:playNextKnight()
				self.m_effectNode:removeAllEffect()
			else
				self.m_ssr1Transition:play()
				self:_showKnightComps(1)
			end
		elseif var_8_0 == "enter" then
			self.m_teamIconTransition:play()
			self.m_groupLoader:setVisible(true)
		elseif var_8_0 == "ssr2" then
			self.m_ssr1Transition:stop()
			self.m_ssr2Transition:play()
			self:_showKnightComps(2)
		elseif var_8_0 == "end" then
			self:_onSpinePlayEnd()
		end
	elseif arg_8_1.type == "complete" then
		self._spine = nil
	end
end

function ActionPopComp:_onSpinePlayEnd()
	self.m_groupBgLoader:setVisible(false)
	self._knightPop:resetUI()
	self._knightPop:setVisible(true)
	self._knightPop:playNextKnight()
end

function ActionPopComp:_initTextSlot(arg_10_1)
	local var_10_0 = string.split(g.core.lang:get(108400 + arg_10_1.info.group), " ")

	for iter_10_0 = 1, 2 do
		local var_10_1 = ccui.Text:create(var_10_0[iter_10_0], FONT_NUMBER_PATH, 70)

		var_10_1:setTextColor(g.core.common.Color.A1)
		var_10_1:setAnchorPoint(0.5, 0.5)
		var_10_1:setPosition(cc.p(0, 0))
		self._spine:getNodeForSlot("Art_word_" .. iter_10_0):addChild(var_10_1)
	end

	for iter_10_1 = 1, 2 do
		local var_10_2 = ccui.Text:create("", FONT_NUMBER_PATH, 40)

		var_10_2:setTextColor(g.core.common.Color.A1)
		var_10_2:setString(var_10_0[iter_10_1])
		var_10_2:setAnchorPoint(0.5, 0.5)
		var_10_2:setPosition(cc.p(0, 0))
		self._spine:getNodeForSlot("teamname_slot" .. 3):addChild(var_10_2)
	end

	local var_10_4 = ccui.Text:create(arg_10_1.info.name, FONT_PATH, 30)

	var_10_4:setTextColor(g.core.common.Color.A1)
	var_10_4:setAnchorPoint(0.5, 0.5)
	var_10_4:setPosition(cc.p(-35, 0))
	self._spine:getNodeForSlot("name_slot2"):addChild(var_10_4)
end

function ActionPopComp:_initKnightComps(arg_11_1)
	for iter_11_0 = 1, 5 do
		self["m_knightComp" .. iter_11_0]:updateComp(arg_11_1)
	end
end

function ActionPopComp:getGroupBg(arg_12_1, arg_12_2)
	return (arg_12_1 == var_0_1.GROUP_TYPE.JIAO_GUO and "bg/recruit/bg_ssr_jiaoguo" or arg_12_1 == var_0_1.GROUP_TYPE.LIN_DONG and "bg/recruit/bg_ssr_lindong" or arg_12_1 == var_0_1.GROUP_TYPE.DONG_XI and "bg/recruit/bg_ssr_dongxi" or "bg/recruit/bg_ssr_lijin") .. arg_12_2 .. ".jpg"
end

function ActionPopComp:_initGroupSlot(arg_13_1)
	local var_13_0 = self:getGroupBg(arg_13_1.info.group, 1)

	self.m_groupBgLoader:setURL(var_13_0)

	local var_13_1 = self.m_groupBgLoader:getContentSize()
	local var_13_2 = math.max(1, (math.max(display.width / var_13_1.width, display.height / var_13_1.height)))

	self.m_groupBgLoader:setScale(var_13_2)

	local var_13_3 = display.newSprite(var_13_0)

	var_13_3:setAnchorPoint(cc.p(0.5, 0.5))
	self._spine:getNodeForSlot("slot_avg"):addChild(var_13_3)
	self.m_groupBgLoaderEff:setURL((self:getGroupBg(arg_13_1.info.group, 2)))
	self.m_groupBgLoaderEff:setScale(var_13_2)
	self.m_groupLoader:setURL((var_0_0:getCampURL(arg_13_1.info.group, 8)))
	self.m_groupLoader:setVisible(false)
end

function ActionPopComp:_showKnightComps(arg_14_1)
	local var_14_0 = 3
	local var_14_1 = 0

	if arg_14_1 == 2 then
		var_14_0 = 5
		var_14_1 = 3
	end

	for iter_14_0 = 1, var_14_0 do
		self["m_knightComp" .. iter_14_0]:fixPosAndScale(iter_14_0 + var_14_1)
		self["m_knightComp" .. iter_14_0]:setVisible(true)
	end

	self:_fixKnightPos(var_14_0)
end

function ActionPopComp:_fixKnightPos(arg_15_1)
	if arg_15_1 == 3 then
		for iter_15_0 = 1, 3 do
			local var_15_0 = self["m_knightComp" .. 4 - iter_15_0]:getPosition()

			var_15_0.x = display.width - iter_15_0 * self["m_knightComp" .. 4 - iter_15_0]:getSize().width - (iter_15_0 - 1) * 14

			self["m_knightComp" .. 4 - iter_15_0]:setPosition(var_15_0)
		end
	else
		for iter_15_1, iter_15_2 in ipairs({
			2,
			1,
			3,
			4,
			5
		}) do
			local var_15_1 = self["m_knightComp" .. iter_15_2]
			local var_15_2 = self["m_knightComp" .. iter_15_2]:getPosition()
			local var_15_3 = self["m_knightComp" .. iter_15_2]:getSize()

			var_15_2.x = iter_15_1 == 1 and display.width / 2 - var_15_3.width / 2 or display.width / 2 + math.ceil((iter_15_1 - 1) / 2) * var_15_3.width * math.pow(-1, iter_15_1 - 1) - var_15_3.width / 2

			var_15_1:setPosition(var_15_2)
		end
	end
end

function ActionPopComp:_createKnightPop()
	if self._knightPop then
		return
	end

	self._knightPop = require("app.view.base.infoPop.KnightShowTimePop").new(nil, nil, true)

	self:addChild(self._knightPop)
	self._knightPop:setVisible(false)
end

function ActionPopComp:_removeKnightPop()
	if not self._knightPop then
		return
	end

	self._knightPop:removeFromParent()

	self._knightPop = nil
end

function ActionPopComp:_playNextAction()
	self._playIdx = self._playIdx + 1

	self:_updateOneAction()
end

function ActionPopComp:_allActionPlayEnd()
	self:_reset()
	self:_removeKnightPop()

	if self._params.justShowResult == nil then
		self._params.justShowResult = true
	end

	self._params.hidePop = true
	self._params.matchQuality = self._matchQuality

	self:setVisible(false)
	self.m_jumpBtn:setVisible(false)

	self._rewardComp = g.core.module.ModuleManager:pushModule(self._rewardEntrance, self._params)
end

function ActionPopComp:playNewRwd(arg_20_1)
	if self._rewardComp then
		self._rewardComp:playNewRwd(arg_20_1)
	end
end

function ActionPopComp:pause()
	if self._spine and not tolua.isnull(self._spine) then
		self._spine:pause()
	end

	self:setVisible(false)
end

function ActionPopComp:resume()
	if self._spine and not tolua.isnull(self._spine) then
		self._spine:resume()
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_SSR)
	self:setVisible(true)
end

function ActionPopComp:JumpSpine()
	self.m_jumpBtn:setVisible(false)

	if self._spine and not tolua.isnull(self._spine) then
		self._spine:pause()
		self._spine:setVisible(false)
		self._spine:dispose()

		self._spine = nil
	end

	self:_showLeftKnightPop()
end

function ActionPopComp:_onJumpBtnClicked()
	self.m_jumpBtn:setVisible(false)
	self.m_groupBgLoader:setVisible(false)

	if self._spine and not tolua.isnull(self._spine) then
		self._spine:pause()
		self._spine:setVisible(false)
		self._spine:dispose()

		self._spine = nil
	end

	self._knightPop:setVisible(true)
	self._knightPop:playNextKnight()
end

return ActionPopComp
