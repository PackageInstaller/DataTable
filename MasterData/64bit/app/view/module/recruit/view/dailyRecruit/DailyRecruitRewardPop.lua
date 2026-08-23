local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.module.ModuleManager
local RecruitRewardUniteTokenPop = require("app.view.module.recruit.view.uniteToken.RecruitRewardUniteTokenPop")
local ArtifactShowTimePop = require("app.view.base.infoPop.ArtifactShowTimePop")
local KnightShowTimePop = require("app.view.base.infoPop.KnightShowTimePop")
local PetShowTimePop = require("app.view.base.infoPop.PetShowTimePop")
local var_0_6 = g.core.model.User.recruitData
local var_0_7 = g.core.common.Goods
local DailyRecruitRewardPop = class("DailyRecruitRewardPop", require("app.fairyGUI.recruitDaily.UI_DailyRecruitRewardPop"), function()
	return fgui.GComponent:create({
		pkgName = "recruitDaily",
		isFullScreen = true,
		pkgPath = "ui/recruitDaily/recruitDaily",
		resName = "DailyRecruitRewardPop"
	})
end)

function DailyRecruitRewardPop:ctor(arg_2_1)
	self._goodList = {}
	self._popGoodList = {}
	self._curPopIndex = 0
	self._isPlaying = true
	self._isClose = false

	self:initShowList(arg_2_1)
	self:initView()
end

function DailyRecruitRewardPop:initView()
	self.m_isShowAwardController:setSelectedIndex(0)
	self:addClickListener(handler(self, self._onClickClose))
end

function DailyRecruitRewardPop:_onClickClose()
	if self._isPlaying then
		return
	end

	if not self._isClose then
		self._isClose = true

		self:dispatchCompEvent("DailyRecruit_RewardPop_End")
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function DailyRecruitRewardPop:initShowList(arg_5_1)
	for iter_5_0 = 1, #arg_5_1 do
		local var_5_0 = var_0_7:convert(arg_5_1[iter_5_0])
		local var_5_1 = false

		if var_5_0.type == var_0_7.TYPE_KNIGHT then
			var_5_0.isNew = var_0_6:checkIsNew(var_5_0.value)
		elseif var_5_0.type == var_0_7.TYPE_UNITETOKEN then
			var_5_0.isNew = var_0_6:isNewUniteToken(var_5_0.value)
		elseif var_5_0.type == var_0_7.TYPE_ARTIFACT then
			var_5_0.isNew = var_0_6:checkIsNewArtifact(var_5_0.value)
		elseif var_5_0.type == var_0_7.TYPE_PET then
			var_5_0.isNew = var_0_6:checkIsNewPet(var_5_0.value)
		else
			var_5_1 = true
			var_5_0.isNew = false
		end

		if not var_5_1 and (var_5_0.isNew or var_5_0.quality >= var_0_0.SSR) then
			table.insert(self._popGoodList, var_5_0)
		end

		var_5_0.showIndex = iter_5_0
		self._goodList[iter_5_0] = var_5_0
	end
end

function DailyRecruitRewardPop:onLoad()
	self:startPopNext()
end

function DailyRecruitRewardPop:startPopNext()
	self._curPopIndex = self._curPopIndex + 1

	if self._popGoodList[self._curPopIndex] then
		self:popShowGood(self._popGoodList[self._curPopIndex])
	else
		self:endShowPop()
	end
end

function DailyRecruitRewardPop:popDelayCall()
	self:newScheduleOnce(handler(self, self.startPopNext))
end

function DailyRecruitRewardPop:popShowGood(arg_9_1)
	if arg_9_1.type == var_0_7.TYPE_KNIGHT then
		var_0_1:pushPopup(KnightShowTimePop.new({
			hideFrag = false,
			knightId = arg_9_1.value,
			callBack = handler(self, self.popDelayCall),
			isNew = arg_9_1.isNew
		}, nil, nil, true))
	elseif arg_9_1.type == var_0_7.TYPE_UNITETOKEN then
		var_0_1:pushPopup(RecruitRewardUniteTokenPop.new({
			{
				good = arg_9_1
			}
		}, handler(self, self.popDelayCall)))
	elseif arg_9_1.type == var_0_7.TYPE_ARTIFACT then
		var_0_1:pushPopup(ArtifactShowTimePop.new({
			callBack = handler(self, self.popDelayCall),
			awards = {
				arg_9_1
			}
		}))
	elseif arg_9_1.type == var_0_7.TYPE_PET then
		var_0_1:pushPopup(PetShowTimePop.new({
			callBack = handler(self, self.popDelayCall),
			awards = {
				arg_9_1
			}
		}))
	end
end

function DailyRecruitRewardPop:endShowPop()
	self._popGoodList = {}
	self._curPopIndex = 0

	self:showAwardView()
	self.m_enterTransition:play(handler(self, self.enterTranEnd))
end

function DailyRecruitRewardPop:enterTranEnd()
	self._isPlaying = false
end

function DailyRecruitRewardPop:showAwardView()
	self.m_isShowAwardController:setSelectedIndex(1)

	if #self._goodList == 1 then
		self.m_rewardTypeController:setSelectedIndex(0)
		self.m_award0:updateRewardComp(self._goodList[1])
		self.m_award0:playEnterTran()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SingleJiesuan_CN)
	else
		self.m_rewardTypeController:setSelectedIndex(1)

		for iter_12_0 = 1, 10 do
			local var_12_0 = self["m_award" .. iter_12_0]

			self.m_enterTransition:setHook(tostring(iter_12_0), function()
				var_12_0:setVisible(true)
				var_12_0:playEnterTran()
			end)
			self["m_award" .. iter_12_0]:setVisible(false)
			self["m_award" .. iter_12_0]:updateRewardComp(self._goodList[iter_12_0])
		end

		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_MutipleJiesuan_CN)
	end
end

function DailyRecruitRewardPop:onRemoved()
	g.core.model.User.recruitData:clearNewUniteToken()
end

return DailyRecruitRewardPop
