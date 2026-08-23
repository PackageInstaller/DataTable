local ShowFactory = require("app.view.module.show.ShowFactory")
local RecruitActUniteTokenShowPop = class("RecruitActUniteTokenShowPop", require("app.fairyGUI.recruitActUniteToken.UI_RecruitActUniteTokenShowPop"), function()
	return fgui.GComponent:create({
		resName = "RecruitActUniteTokenShowPop",
		pkgPath = "ui/recruitActUniteToken/recruitActUniteToken",
		pkgName = "recruitActUniteToken"
	})
end)

function RecruitActUniteTokenShowPop:ctor(arg_2_1)
	self:getView():setSize(display.width, display.height)
	self:showAtCenter()
	self.m_enterTransition:play()
	self.m_bgCom:initView(arg_2_1)
	self:addListen(self.m_bgCom)
	self.m_skipBtn:addClickListener(handler(self, self._onSkipClick))

	self._param = arg_2_1
	self._awards = arg_2_1.awards
	self._fullShowAwards = ShowFactory:getUniteTokenShowArr(arg_2_1)
end

function RecruitActUniteTokenShowPop:_onSkipClick(arg_3_1)
	if not self.m_bgCom:isAllOpen() then
		self.m_bgCom:onOpenAll()
	else
		if self._inClose then
			return
		end

		self._inClose = true

		self.m_bgCom:onClickSkip()
	end
end

function RecruitActUniteTokenShowPop:receiveCompEvent(arg_4_1)
	local var_4_0 = {
		...
	}

	if arg_4_1 == "OPEN_STONE_FINISH_ALL" then
		self:playOpenFinish(var_4_0[1].callBack, var_4_0[1].maxQuality, var_4_0[1].maxNum, var_4_0[1].finishCall)
	end
end

function RecruitActUniteTokenShowPop:playOpenFinish(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = ({
		{
			"nsr_1",
			"ssr_1"
		},
		[5] = {
			"nsr_5",
			"ssr_5"
		}
	})[arg_5_3]
	local var_5_1 = ""

	var_5_1 = arg_5_2 >= 3 and "m_" .. var_5_0[2] .. "Transition" or "m_" .. var_5_0[1] .. "Transition"

	if arg_5_3 == 5 then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_ACTIVE_FIVE)

		self._lastTable = {
			1,
			2,
			3,
			4,
			5
		}

		for iter_5_0 = 1, 5 do
			self[var_5_1]:setHook("st" .. iter_5_0, arg_5_1)
		end
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RECRUIT_UNITE_TOKEN_ACTIVE_SINGLE)

		self._lastTable = {
			1
		}

		self[var_5_1]:setHook("st1", arg_5_1)
	end

	self[var_5_1]:setHook("cut", arg_5_4)
	self[var_5_1]:play()
end

function RecruitActUniteTokenShowPop:_onShowFinish()
	g.core.module.ModuleManager:popComponent()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_CHECK_SHOW_READY)

	local var_6_0 = self._param

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "RecruitGetUniteToken",
				func = function()
					local var_7_0 = require("app.view.module.recruit.view.recruitAct.uniteToken.RecruitUniteTokenRewardPop").new(var_6_0)

					g.core.module.ModuleManager:pushPopup(var_7_0)

					return var_7_0
				end
			}
		}
	})
end

return RecruitActUniteTokenShowPop
