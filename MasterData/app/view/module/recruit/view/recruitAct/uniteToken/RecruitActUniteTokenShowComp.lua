local ShowFactory = require("app.view.module.show.ShowFactory")
local RecruitActUniteTokenShowComp = class("RecruitActUniteTokenShowComp", require("app.fairyGUI.recruitActUniteToken.UI_RecruitActUniteTokenShowComp"), function()
	return fgui.GComponent:create({
		resName = "RecruitActUniteTokenShowComp",
		pkgPath = "ui/recruitActUniteToken/recruitActUniteToken",
		pkgName = "recruitActUniteToken"
	})
end)

function RecruitActUniteTokenShowComp:ctor()
	self.m_bg:setURL("bg/recruit/bg_zm_new_guwu1.jpg")

	self._bgEff = nil

	self.m_enterTransition:setHook("play2", handler(self, self._onPlay2Call))
	self.m_enterTransition:setHook("play", handler(self, self._onPlayCall))
end

function RecruitActUniteTokenShowComp:_onPlay2Call()
	self._bgEff = self.m_effBg:addEffectSpine({
		anim = "play2",
		name = "eff_ui_recruitActUniteToken_bg",
		isLoop = false
	})
end

function RecruitActUniteTokenShowComp:_onPlayCall()
	if self._bgEff then
		self._bgEff:setAnimation(0, "play", true)
	end
end

function RecruitActUniteTokenShowComp:initView(arg_5_1)
	for iter_5_0 = 1, 5 do
		self["m_stoneComp" .. iter_5_0]:addClickListener(handler(self, self._onOpenStone))
		self["m_stoneComp" .. iter_5_0]:setEffTag(iter_5_0)
		self:addListen(self["m_stoneComp" .. iter_5_0])
	end

	self.m_stoneOneComp:addClickListener(handler(self, self._onOpenStone))
	self:addListen(self.m_stoneOneComp)

	self._param = arg_5_1
	self._awards = arg_5_1.awards
	self._curClickIndex = 0
	self._openCount = 0
	self._fullShowAwards = ShowFactory:getUniteTokenShowArr(arg_5_1)

	if self._param.num == 5 then
		self._maxNum = 5

		self.m_typeController:setSelectedIndex(1)
	elseif self._param.num == 20 then
		self._maxNum = 5

		self.m_typeController:setSelectedIndex(1)
	else
		self._maxNum = 1

		self.m_typeController:setSelectedIndex(0)
		self.m_stoneOneComp:setEffTag((math.random(1, 5)))
	end
end

function RecruitActUniteTokenShowComp:_onOpenStone(arg_6_1)
	local var_6_0 = arg_6_1:getSender()

	arg_6_1:stopPropagation()

	if var_6_0:isOpened() then
		return
	end

	self:_openStone()
	var_6_0:setOpened(self._awards[self._curClickIndex])
end

function RecruitActUniteTokenShowComp:_openStone()
	self._curClickIndex = self._curClickIndex + 1

	if self._curClickIndex >= self._maxNum then
		self:dispatchCompEvent("SHOW_ALL_REWARD_OPE_FINISH")
	end
end

function RecruitActUniteTokenShowComp:receiveCompEvent(arg_8_1)
	if arg_8_1 == "OPEN_STONE_FINISH" then
		self._openCount = self._openCount + 1

		if self._openCount >= self._maxNum then
			self.m_openTransition:play()

			self._maxQuality = self:getMaxQuality()

			self:playFinishEff()
		end
	end
end

function RecruitActUniteTokenShowComp:getMaxQuality()
	local var_9_0 = 0

	if self._maxNum == 5 then
		for iter_9_0 = 1, 5 do
			local var_9_1 = self["m_stoneComp" .. iter_9_0]:getQuality()

			var_9_0 = var_9_0 < var_9_1 and var_9_1 or var_9_0
		end
	else
		var_9_0 = self.m_stoneOneComp:getQuality()
	end

	return var_9_0
end

function RecruitActUniteTokenShowComp:playFinishEff()
	self._lastTable = self._maxNum == 1 and {
		1
	} or {
		1,
		2,
		3,
		4,
		5
	}

	self:dispatchCompEvent("OPEN_STONE_FINISH_ALL", {
		callBack = handler(self, self._onOpenStoneEff),
		maxQuality = self._maxQuality,
		maxNum = self._maxNum,
		finishCall = handler(self, self._onShowFinish)
	})
	self.m_effHolder:addEffectSpine({
		name = "eff_ui_recruitActUniteToken_ssrfive",
		isLoop = false,
		anim = "play_" .. math.max(2, self._maxQuality + 1)
	})
end

function RecruitActUniteTokenShowComp:_onOpenStoneEff()
	if not self._lastTable or #self._lastTable == 0 then
		return
	end

	local var_11_0 = math.random(1, #self._lastTable)

	table.remove(self._lastTable, var_11_0)

	if self._maxNum == 1 then
		self.m_stoneOneComp:playBreak()
	else
		self["m_stoneComp" .. self._lastTable[var_11_0]]:playBreak()
	end
end

function RecruitActUniteTokenShowComp:onClickSkip()
	self:_onShowFinish()
end

function RecruitActUniteTokenShowComp:onOpenAll()
	self._openAll = true

	if self._maxNum == 5 then
		self:openOne()
		self:newScheduleOnce(handler(self, self.openOne), 0.2)
	elseif not self.m_stoneOneComp:isOpened() then
		self:_openStone()
		self.m_stoneOneComp:isOpened()
		self.m_stoneOneComp:setOpened(self._awards[self._curClickIndex])
	end
end

function RecruitActUniteTokenShowComp:openOne()
	local var_14_0 = false

	for iter_14_0 = 1, 5 do
		if not self["m_stoneComp" .. iter_14_0]:isOpened() then
			self:_openStone()
			self["m_stoneComp" .. iter_14_0]:isOpened()
			self["m_stoneComp" .. iter_14_0]:setOpened(self._awards[self._curClickIndex])

			var_14_0 = true

			break
		end
	end

	if var_14_0 then
		self:newScheduleOnce(handler(self, self.openOne), 0.2)
	end
end

function RecruitActUniteTokenShowComp:isAllOpen()
	if self._openAll then
		return true
	end

	for iter_15_0 = 1, 5 do
		if not self["m_stoneComp" .. iter_15_0]:isOpened() then
			return false
		end
	end

	return true
end

function RecruitActUniteTokenShowComp:_onShowFinish()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)
	g.core.module.ModuleManager:popComponent()

	local var_16_0 = self._fullShowAwards
	local var_16_1 = self._param

	local function var_16_2()
		g.core.module.ModuleManager:pushPopup(require("app.view.module.recruit.view.recruitAct.uniteToken.RecruitActUniteTokenRewardPop").new(var_16_1))
	end

	if #self._fullShowAwards > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
			showNow = true,
			frontShow = {
				{
					flag = "RecruitGetUniteToken",
					func = function()
						local var_18_0 = require("app.view.module.recruit.view.uniteToken.RecruitRewardUniteTokenPop").new(var_16_0, var_16_2)

						g.core.module.ModuleManager:pushPopup(var_18_0)

						return var_18_0
					end
				}
			}
		})
	else
		var_16_2()
	end
end

function RecruitActUniteTokenShowComp:onUnload()
	self:cancelAllSchedule()
end

return RecruitActUniteTokenShowComp
