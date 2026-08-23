local var_0_0 = g.core.model.User.domainData
local var_0_1 = g.core.const.ConstMgr.DomainConst
local DomainSlotMachinePop = class("DomainSlotMachinePop", require("app.fairyGUI.domainDungeon.UI_DomainSlotMachinePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/domainDungeon/domainDungeon",
		resName = "DomainSlotMachinePop",
		pkgName = "domainDungeon"
	}, ...)
end)

function DomainSlotMachinePop:ctor(arg_2_1)
	self:showAtCenter()
	self.m_touchArea:setSize(display.width, display.height)
	self.m_closeBtn:addClickListener(handler(self, self._onClose))

	self._dungeonData = arg_2_1.dungeon

	self.m_bgEff:addEffectSpine({
		isLoop = true,
		anim = "loop_2",
		name = "eff_ui_domainDungeon_gamebg_" .. self._dungeonData:getId()
	})

	self._surpriseData = var_0_0:getSurprise()
	self._finalAwards = self._surpriseData.awards
	self._slotType = g.core.config.domain_slot_info.get(self._surpriseData.value or 1).type
	self._awardData, self._effPos = self:_randomCardsByType(self._slotType)
	self._slotSpines = {}

	for iter_2_0 = 1, 4 do
		self:_initSlotSpine(iter_2_0)
	end

	self.m_bg1:setURL(var_0_0:getDungeonResource(self._dungeonData:getId(), "pic_mnly_laohuji01.png"))
	self.m_bg2:setURL(var_0_0:getDungeonResource(self._dungeonData:getId(), "pic_mnly_laohuji02.png"))
	self.m_bg3:setURL(var_0_0:getDungeonResource(self._dungeonData:getId(), "pic_mnly_laohuji04.png"))
	self.m_enterTransition:play(handler(self, self._onPlayEnterEnd))
end

function DomainSlotMachinePop:_initSlotSpine(arg_3_1)
	local var_3_1 = self["m_eff" .. arg_3_1]:addEffectSpine({
		isLoop = false,
		anim = "idle",
		name = "eff_ui_domainDungeon_rolltxt",
		eventHandler = (arg_3_1 == 4 or nil) and handler(self, self._onSpineEvent)
	})

	for iter_3_0 = 1, 11 do
		local var_3_2 = display.newSprite((g.core.common.Path:getDomainSlotIcon(self._dungeonData:getId(), math.random(1, 3), false)))

		var_3_2:setAnchorPoint(cc.p(0.5, 0.5))
		var_3_1:getNodeForSlot("slot_" .. iter_3_0):addChild(var_3_2)
	end

	local var_3_3 = display.newSprite((g.core.common.Path:getDomainSlotIcon(self._dungeonData:getId(), self._awardData[arg_3_1], false)))

	var_3_3:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_1:getNodeForSlot("slot_award"):addChild(var_3_3)

	local var_3_4 = display.newSprite((g.core.common.Path:getDomainSlotIcon(self._dungeonData:getId(), self._awardData[arg_3_1], true)))

	var_3_4:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_1:getNodeForSlot("slot_light"):addChild(var_3_4)
	table.insert(self._slotSpines, var_3_1)
	self["m_mask" .. arg_3_1]:setURL(var_0_0:getDungeonResource(self._dungeonData:getId(), "pic_mnly_laohuji03.png"))
	self["m_zs" .. arg_3_1]:setURL(var_0_0:getDungeonResource(self._dungeonData:getId(), "pic_mnly_laohuji05.png"))
end

function DomainSlotMachinePop:_onPlayEnterEnd()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self._slotSpines) do
		local var_4_1 = "play_1"

		if self._slotType < var_0_1.SURPRISE_SLOT.TWO_PAIRS and iter_4_0 == 4 then
			var_4_1 = "play_2"
		end

		table.insert(var_4_0, fgui.FSequence:create({
			fgui.FDelayTime:create(0.2),
			fgui.FCallFunc:create(handler(self, function()
				iter_4_1:setAnimation(0, var_4_1, false)
			end))
		}))
	end

	self:runFGAction(fgui.FSequence:create(var_4_0))
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SecretCodeTurn)
end

function DomainSlotMachinePop:_onSpineEvent(arg_6_1)
	if arg_6_1.type == "event" and arg_6_1.eventData.name == "get" then
		self["m_getEff" .. self._effPos]:addEffectSpine({
			isLoop = false,
			name = "eff_ui_domainDungeon_rollget_" .. self._dungeonData:getId(),
			anim = "play_" .. self._slotType,
			eventHandler = handler(self, self._onGetSpineEvent)
		})
	end
end

function DomainSlotMachinePop:_onGetSpineEvent(arg_7_1)
	if arg_7_1.type == "event" and arg_7_1.eventData.name == "popUp" then
		self:showReward()
	end
end

function DomainSlotMachinePop:_randomCardsByType(arg_8_1)
	local var_8_0 = {
		1,
		1,
		1,
		1
	}
	local var_8_1 = 1
	local var_8_3 = 1
	local var_8_4 = 1

	if arg_8_1 == var_0_1.SURPRISE_SLOT.FOUR_SAME then
		local var_8_5 = math.random(1, 3)

		var_8_0[1], var_8_0[2], var_8_0[3], var_8_0[4] = var_8_5, var_8_5, var_8_5, var_8_5
		var_8_1 = 1
	elseif arg_8_1 == var_0_1.SURPRISE_SLOT.THIRD_SAME then
		local var_8_6 = math.random(1, 3)

		repeat
			var_8_3 = math.random(1, 3)
		until var_8_3 ~= var_8_6

		if math.random(1, 2) == 1 then
			var_8_0[1], var_8_0[2], var_8_0[3], var_8_0[4] = var_8_6, var_8_6, var_8_6, var_8_3
			var_8_1 = 2
		else
			var_8_0[1], var_8_0[2], var_8_0[3], var_8_0[4] = var_8_3, var_8_6, var_8_6, var_8_6
			var_8_1 = 3
		end
	elseif arg_8_1 == var_0_1.SURPRISE_SLOT.TWO_PAIRS then
		local var_8_7 = math.random(1, 3)

		repeat
			var_8_3 = math.random(1, 3)
		until var_8_3 ~= var_8_7

		if math.random(1, 2) == 1 then
			var_8_0[1], var_8_0[2], var_8_0[3], var_8_0[4] = var_8_7, var_8_7, var_8_3, var_8_3
		else
			var_8_0[1], var_8_0[2], var_8_0[3], var_8_0[4] = var_8_3, var_8_3, var_8_7, var_8_7
		end

		var_8_1 = 1
	elseif arg_8_1 == var_0_1.SURPRISE_SLOT.ONE_PAIRS then
		local var_8_8 = math.random(1, 3)

		repeat
			var_8_3 = math.random(1, 3)
		until var_8_3 ~= var_8_8

		repeat
			var_8_4 = math.random(1, 3)
		until var_8_4 ~= var_8_8 and var_8_4 ~= var_8_3

		local var_8_9 = math.random(1, 3)

		if var_8_9 == 1 then
			var_8_0[1], var_8_0[2], var_8_0[3], var_8_0[4] = var_8_8, var_8_8, var_8_3, var_8_4
			var_8_1 = 4
		elseif var_8_9 == 2 then
			var_8_0[1], var_8_0[2], var_8_0[3], var_8_0[4] = var_8_8, var_8_3, var_8_3, var_8_4
			var_8_1 = 1
		else
			var_8_0[1], var_8_0[2], var_8_0[3], var_8_0[4] = var_8_8, var_8_3, var_8_4, var_8_4
			var_8_1 = 5
		end
	end

	return {
		1,
		1,
		1,
		1
	}, var_8_1
end

function DomainSlotMachinePop:_onClose()
	var_0_0:resetSurprise()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function DomainSlotMachinePop:showReward()
	if self._finalAwards then
		var_0_0:awardSummary({
			isAuto = false,
			award = self._finalAwards,
			dungeonId = self._dungeonData:getId(),
			callBack = handler(self, self._onClose)
		})

		self._finalAwards = nil
	end
end

function DomainSlotMachinePop:onUnload()
	self:showReward()
end

return DomainSlotMachinePop
