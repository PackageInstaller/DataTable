local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.module.ModuleManager
local RecruitRewardUniteTokenPop = require("app.view.module.recruit.view.uniteToken.RecruitRewardUniteTokenPop")
local ArtifactShowTimePop = require("app.view.base.infoPop.ArtifactShowTimePop")
local KnightShowTimePop = require("app.view.base.infoPop.KnightShowTimePop")
local PetShowTimePop = require("app.view.base.infoPop.PetShowTimePop")
local var_0_6 = g.core.model.User.recruitData
local var_0_7 = g.core.common.Goods
local ActivityWishpoolRewardPop = class("ActivityWishpoolRewardPop", require("app.fairyGUI.activity.UI_ActivityWishpoolRewardPop"), function()
	return fgui.GComponent:create({
		pkgName = "activity",
		isFullScreen = true,
		pkgPath = "ui/activity/activity",
		resName = "ActivityWishpoolRewardPop"
	})
end)
local var_0_9 = g.core.const.ConstMgr.DailyRecruitConst.GOOD_WEIGHT

function ActivityWishpoolRewardPop:ctor(arg_2_1)
	self._goodList = {}
	self._popGoodList = {}
	self._curPopIndex = 0
	self._isPlaying = true
	self._isClose = false
	self._exitFunc = arg_2_1.exitFunc

	self:initFish(arg_2_1.drop_id)
	self:initShowList(arg_2_1.awards)
	self:initView()
end

function ActivityWishpoolRewardPop:initView()
	self:addClickListener(handler(self, self._onClickClose))
end

function ActivityWishpoolRewardPop:_onClickClose()
	if self._isPlaying then
		return
	end

	if not self._isClose then
		self._isClose = true

		self:dispatchCompEvent("DailyRecruit_RewardPop_End")
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function ActivityWishpoolRewardPop:initFish(arg_5_1)
	self.m_fishComp:updateFish((g.core.config.wishpool_drop_info.get(arg_5_1[1])))
end

function ActivityWishpoolRewardPop:initShowList(arg_6_1)
	for iter_6_0 = 1, #arg_6_1 do
		local var_6_0 = var_0_7:convert(arg_6_1[iter_6_0])
		local var_6_1 = false

		if var_6_0.type == var_0_7.TYPE_KNIGHT then
			var_6_0.isNew = var_0_6:checkIsNew(var_6_0.value)
		elseif var_6_0.type == var_0_7.TYPE_UNITETOKEN then
			var_6_0.isNew = var_0_6:isNewUniteToken(var_6_0.value)
		elseif var_6_0.type == var_0_7.TYPE_ARTIFACT then
			var_6_0.isNew = var_0_6:checkIsNewArtifact(var_6_0.value)
		elseif var_6_0.type == var_0_7.TYPE_PET then
			var_6_0.isNew = var_0_6:checkIsNewPet(var_6_0.value)
		else
			var_6_1 = true
			var_6_0.isNew = false
		end

		if not var_6_1 and (var_6_0.isNew or var_6_0.quality >= var_0_0.SSR) then
			table.insert(self._popGoodList, var_6_0)
		end

		var_6_0.showIndex = iter_6_0
		self._goodList[iter_6_0] = var_6_0
	end

	table.sort(self._popGoodList, function(arg_7_0, arg_7_1)
		if arg_7_0.quality ~= arg_7_1.quality then
			return arg_7_0.quality > arg_7_1.quality
		end

		return var_0_9[arg_7_0.type] < var_0_9[arg_7_1.type]
	end)
end

function ActivityWishpoolRewardPop:onLoad()
	self:startPopNext()
end

function ActivityWishpoolRewardPop:startPopNext()
	self._curPopIndex = self._curPopIndex + 1

	if self._popGoodList[self._curPopIndex] then
		self:popShowGood(self._popGoodList[self._curPopIndex])
	else
		self:endShowPop()
	end
end

function ActivityWishpoolRewardPop:popDelayCall()
	self:newScheduleOnce(handler(self, self.startPopNext))
end

function ActivityWishpoolRewardPop:popShowGood(arg_11_1)
	if arg_11_1.type == var_0_7.TYPE_KNIGHT then
		var_0_1:pushPopup(KnightShowTimePop.new({
			hideFrag = false,
			knightId = arg_11_1.value,
			callBack = handler(self, self.popDelayCall),
			isNew = arg_11_1.isNew
		}, nil, nil, true))
	elseif arg_11_1.type == var_0_7.TYPE_UNITETOKEN then
		var_0_1:pushPopup(RecruitRewardUniteTokenPop.new({
			{
				good = arg_11_1
			}
		}, handler(self, self.popDelayCall)))
	elseif arg_11_1.type == var_0_7.TYPE_ARTIFACT then
		var_0_1:pushPopup(ArtifactShowTimePop.new({
			callBack = handler(self, self.popDelayCall),
			awards = {
				arg_11_1
			}
		}))
	elseif arg_11_1.type == var_0_7.TYPE_PET then
		var_0_1:pushPopup(PetShowTimePop.new({
			callBack = handler(self, self.popDelayCall),
			awards = {
				arg_11_1
			}
		}))
	end
end

function ActivityWishpoolRewardPop:endShowPop()
	self._popGoodList = {}
	self._curPopIndex = 0

	self:showAwardView()
	self.m_enterTransition:play(handler(self, self.enterTranEnd))
end

function ActivityWishpoolRewardPop:enterTranEnd()
	self._isPlaying = false
end

function ActivityWishpoolRewardPop:showAwardView()
	if #self._goodList == 1 then
		self.m_awardComp:updateRewardComp(self._goodList[1])
		self.m_awardComp:playEnterTran()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SingleJiesuan_CN)
	end
end

function ActivityWishpoolRewardPop:onRemoved()
	g.core.model.User.recruitData:clearNewUniteToken()

	if self._exitFunc then
		self._exitFunc()
	end
end

return ActivityWishpoolRewardPop
