local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local DrawKnight = require("app.view.common.DrawKnight")
local SSRAction = class("SSRAction")
local var_0_4 = g.core.common.Goods

function SSRAction:ctor(arg_1_1, arg_1_2, arg_1_3)
	self._parent = arg_1_1
	self._comps = arg_1_2
	self._ssr1Trans = arg_1_3.ssr1
	self._ssr2Trans = arg_1_3.ssr2
	self._bgTrans = arg_1_3.bg
	self._teamTrans = arg_1_3.team

	self._comps.mask:setVisible(false)
end

function SSRAction:updateAction(arg_2_1)
	self._params = arg_2_1

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self._params.awards) do
		local var_2_1 = var_0_4:convert(iter_2_1)

		if iter_2_1.type == var_0_4.TYPE_KNIGHT and (iter_2_1.isNew or var_2_1.quality >= 3) then
			table.insert(var_2_0, {
				knightId = iter_2_1.value,
				quality = var_2_1.quality,
				isNew = iter_2_1.isNew
			})
		end
	end

	self._showInfos = var_2_0
	self._playIdx = 1

	self:_createKnightPop()
	self:_updateSSR()
	self._comps.mask:setVisible(true)
end

function SSRAction:_getPopShowInfos()
	local var_3_0 = {}

	if self._showInfos[self._playIdx] and self._showInfos[self._playIdx].quality > 2 then
		var_3_0[1] = self._showInfos[self._playIdx]
	else
		return var_3_0
	end

	for iter_3_0 = self._playIdx + 1, #self._showInfos do
		if self._showInfos[iter_3_0].quality > 2 then
			break
		end

		table.insert(var_3_0, self._showInfos[iter_3_0])
	end

	return var_3_0
end

function SSRAction:_getShowDatas(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = {}
		local var_4_2 = {
			resId = iter_4_1.knightId,
			skinId = iter_4_1.skinId
		}

		var_4_1.spineParams = var_4_2
		var_4_1.spineParams.isShowBg = true
		var_4_1.num = iter_4_1.num or 1
		var_4_1.isNew = iter_4_1.isNew

		if not var_4_2.resId and var_4_2.skinId then
			var_4_1.type = 1
			var_4_1.info = g.core.config.skin_info.get(var_4_2.skinId)
		else
			var_4_1.type = 0
			var_4_1.info = g.core.config.knight_info.get(var_4_2.resId)
			var_4_1.baseInfo = g.core.config.knight_base_info.get(var_4_2.resId)
		end

		table.insert(var_4_0, var_4_1)
	end

	return var_4_0
end

function SSRAction:_updateSSR()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_SSR)
	self:_reset()
	self._knightPop:updatePop({
		callBack = handler(self, self._playNextSSR)
	}, (self:_getPopShowInfos()))
	self._knightPop:setVisible(false)
	self._comps.spineNode:setVisible(true)

	local var_5_0 = {
		"AVG1",
		"ssr1",
		"enter",
		"ssr2",
		"end"
	}

	self._spine = self._comps.spineNode:addEffectSpine({
		remove = true,
		name = "eff_ui_recruit_ssr",
		isLoop = false,
		anim = "ssr_play",
		eventHandler = function(self, arg_6_1)
			if self.type == "event" then
				local var_6_0 = table.remove(var_5_0, 1)

				if var_6_0 == "AVG1" then
					self._bgTrans:play()
					self._comps.bgLoader:setVisible(true)
					self._comps.bgLoaderEff:setVisible(true)
				elseif var_6_0 == "ssr1" then
					self._ssr1Trans:play()
					self:_showKnightComps(1)
				elseif var_6_0 == "enter" then
					self._teamTrans:play()
					self._comps.groupIcon:setVisible(true)
				elseif var_6_0 == "ssr2" then
					self._ssr2Trans:play()
					self:_showKnightComps(2)
				elseif var_6_0 == "end" then
					self._knightPop:setVisible(true)
					self._knightPop:playNextKnight()
				end
			elseif self.type == "complete" then
				-- block empty
			end
		end
	})

	self:_initTextSlot(self._knightPop:getShowDatas()[1])
	self:_initGroupSlot(self._knightPop:getShowDatas()[1])
	self:_initKnightComps(self._knightPop:getShowDatas()[1])
end

function SSRAction:_playNextSSR()
	self._playIdx = self._playIdx + 1

	if #self:_getPopShowInfos() > 0 then
		self:_updateSSR()
		self._comps.mask:setVisible(true)
	else
		self:_actionEnd()
	end
end

function SSRAction:_reset()
	if self._knightPop then
		self._knightPop:setVisible(false)
	end

	for iter_8_0, iter_8_1 in pairs(self._comps) do
		iter_8_1:setVisible(false)
	end
end

function SSRAction:_createKnightPop()
	if self._knightPop then
		return
	end

	self._knightPop = require("app.view.base.infoPop.KnightShowTimePop").new(nil, nil, true)

	self._parent:addChild(self._knightPop)
	self._knightPop:setVisible(false)
end

function SSRAction:_removeKnightPop()
	if not self._knightPop then
		return
	end

	self._knightPop:removeFromParent()

	self._knightPop = nil
end

function SSRAction:_initTextSlot(arg_11_1)
	local var_11_0 = string.split(g.core.lang:get(108100 + arg_11_1.info.group), " ")

	for iter_11_0 = 1, 2 do
		local var_11_1 = ccui.Text:create(var_11_0[iter_11_0], FONT_NUMBER_PATH, 70)

		var_11_1:setTextColor(g.core.common.Color.A6)
		var_11_1:setAnchorPoint(0.5, 0.5)
		var_11_1:setPosition(cc.p(0, 0))
		self._spine:getNodeForSlot("Art_word_" .. iter_11_0):addChild(var_11_1)
	end

	for iter_11_1 = 1, 2 do
		local var_11_2 = ccui.Text:create("", FONT_NUMBER_PATH, 40)

		var_11_2:setTextColor(g.core.common.Color.A1)
		var_11_2:setString(var_11_0[iter_11_1])
		var_11_2:setAnchorPoint(0.5, 0.5)
		var_11_2:setPosition(cc.p(0, 0))
		self._spine:getNodeForSlot("teamname_slot" .. 3):addChild(var_11_2)
	end

	local var_11_4 = ccui.Text:create(arg_11_1.info.name, FONT_PATH, 50)

	var_11_4:setTextColor(g.core.common.Color.A1)
	var_11_4:setAnchorPoint(0.5, 0.5)
	var_11_4:setPosition(cc.p(-35, 0))
	self._spine:getNodeForSlot("name_slot2"):addChild(var_11_4)
end

function SSRAction:_initTextSlotOld(arg_12_1)
	local var_12_0 = g.core.utils.String.splitStringToList((g.core.lang:get(108100 + arg_12_1.info.group)))
	local var_12_1 = 0

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		var_12_1 = var_12_1 + 1

		if iter_12_1 ~= " " then
			local var_12_2 = ccui.Text:create("", FONT_NUMBER_PATH, 60)

			var_12_2:setTextColor(g.core.common.Color.A6)
			var_12_2:setString(iter_12_1)
			var_12_2:setAnchorPoint(0.5, 0.5)
			var_12_2:setPosition(cc.p(0, 0))
			self._spine:getNodeForSlot("teamname_slot" .. var_12_1):addChild(var_12_2)
		else
			var_12_1 = 10
		end
	end

	local var_12_3 = 0

	for iter_12_2, iter_12_3 in ipairs(var_12_0) do
		var_12_3 = var_12_3 + 1

		if iter_12_3 ~= " " then
			local var_12_4 = ccui.Text:create("", FONT_NUMBER_PATH, 30)

			var_12_4:setTextColor(g.core.common.Color.A1)
			var_12_4:setString(iter_12_3)
			var_12_4:setAnchorPoint(0.5, 0.5)
			var_12_4:setPosition(cc.p(0, 0))
			self._spine:getNodeForSlot("teamname_slot" .. var_12_3):addChild(var_12_4)
		else
			var_12_3 = 10
		end
	end

	local var_12_5 = 0

	for iter_12_4, iter_12_5 in ipairs((g.core.utils.String.splitStringToList(arg_12_1.info.name))) do
		if iter_12_5 ~= " " then
			var_12_5 = var_12_5 + 1

			local var_12_6 = ccui.Text:create("", FONT_NUMBER_PATH, 30)

			var_12_6:setTextColor(g.core.common.Color.A1)
			var_12_6:setString(iter_12_5)
			var_12_6:setAnchorPoint(0.5, 0.5)
			var_12_6:setPosition(cc.p(0, 0))
			self._spine:getNodeForSlot("name_slot" .. var_12_5):addChild(var_12_6)
		end
	end
end

function SSRAction:_initKnightComps(arg_13_1)
	for iter_13_0 = 1, 5 do
		self._comps["knightComp" .. iter_13_0]:updateComp(arg_13_1)
	end
end

function SSRAction:_showKnightComps(arg_14_1)
	local var_14_0 = 3
	local var_14_1 = 0

	if arg_14_1 == 2 then
		var_14_0 = 5
		var_14_1 = 3
	end

	for iter_14_0 = 1, var_14_0 do
		self._comps["knightComp" .. iter_14_0]:fixPosAndScale(iter_14_0 + var_14_1)
		self._comps["knightComp" .. iter_14_0]:setVisible(true)
	end

	self:_fixKnightPos(var_14_0)
end

function SSRAction:_fixKnightPos(arg_15_1)
	if arg_15_1 == 3 then
		for iter_15_0 = 1, 3 do
			local var_15_0 = self._comps["knightComp" .. 4 - iter_15_0]:getPosition()

			var_15_0.x = display.width - iter_15_0 * self._comps["knightComp" .. 4 - iter_15_0]:getSize().width - (iter_15_0 - 1) * 14

			self._comps["knightComp" .. 4 - iter_15_0]:setPosition(var_15_0)
		end
	else
		for iter_15_1, iter_15_2 in ipairs({
			2,
			1,
			3,
			4,
			5
		}) do
			local var_15_1 = self._comps["knightComp" .. iter_15_2]
			local var_15_2 = self._comps["knightComp" .. iter_15_2]:getPosition()
			local var_15_3 = self._comps["knightComp" .. iter_15_2]:getSize()

			var_15_2.x = iter_15_1 == 1 and display.width / 2 - var_15_3.width / 2 or display.width / 2 + math.ceil((iter_15_1 - 1) / 2) * var_15_3.width * math.pow(-1, iter_15_1 - 1) - var_15_3.width / 2

			var_15_1:setPosition(var_15_2)
		end
	end
end

function SSRAction:getGroupBg(arg_16_1, arg_16_2)
	return (arg_16_1 == var_0_1.GROUP_TYPE.JIAO_GUO and "bg/recruit/bg_ssr_jiaoguo" or arg_16_1 == var_0_1.GROUP_TYPE.LIN_DONG and "bg/recruit/bg_ssr_lindong" or arg_16_1 == var_0_1.GROUP_TYPE.DONG_XI and "bg/recruit/bg_ssr_dongxi" or "bg/recruit/bg_ssr_linjin") .. arg_16_2 .. ".jpg"
end

function SSRAction:_initGroupSlot(arg_17_1)
	self._comps.bgLoader:setURL((self:getGroupBg(arg_17_1.info.group, 2)))
	self._comps.bgLoader:setScale(2)
	self._comps.bgLoaderEff:setURL((self:getGroupBg(arg_17_1.info.group, 1)))
	self._comps.bgLoaderEff:setScale(2)
	self._comps.groupIcon:setURL((var_0_0:getCampURL(arg_17_1.info.group, 8)))
	self._comps.groupIcon:setVisible(false)
end

function SSRAction:_actionEnd()
	self:_reset()
	self:_removeKnightPop()

	self._params.justShowResult = true

	g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_REWARD, self._params)
end

return SSRAction
