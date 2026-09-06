-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/herotrial/view/BattleHeroTrialView.lua

module("logic.extensions.herotrial.view.BattleHeroTrialView", package.seeall)

local BattleHeroTrialView = class("BattleHeroTrialView")

function BattleHeroTrialView:ctor(go, view, bloodBar)
	self._view = view
	self.mainGO = go
	self._bloodBar = bloodBar
end

function BattleHeroTrialView:onExit()
	return
end

function BattleHeroTrialView:buildUI()
	self.txtVerifyEffect = goutil.findChildTextComponent(self.mainGO, "top/txtVerifyEffect")
	self._txtBoxNum = goutil.findChildComponent(self.mainGO, "top/box/txtBoxNum", "Text")
	self.imgEffect = Framework.ImageBigBG.GetFrom(self.mainGO, "top/imgVerify")
end

function BattleHeroTrialView:setActive(active)
	goutil.setActive(self.mainGO, active)
end

function BattleHeroTrialView:onEnter()
	local activityId = HerotrialModel.instance:getActivityId()
	local progressPrizeId = HerotrialConfig.instance:getHeroTrialActivity(activityId).progressPrizeId
	local prizeCfg = TimelimitrankConfig.instance:getProgressPrizeById(progressPrizeId)

	self._cfgs = {}

	for k, v in pairs(prizeCfg) do
		if checknumber(v.progress) > 0 then
			table.insert(self._cfgs, {
				interval = v.progress
			})
		end
	end

	table.sort(self._cfgs, function(a, b)
		return a.interval < b.interval
	end)

	local verifyCfg = HerotrialController.instance:getCurVerifyPlan()

	if verifyCfg then
		local color = "60ee85"
		local verifyName = string.format(verifyCfg.name, color)
		local verifyDes = string.format(verifyCfg.des, color)

		self.txtVerifyEffect.text = string.format("%s \n%s", verifyName, verifyDes)
	else
		self.txtVerifyEffect.text = "未激活鼓舞"
	end

	local plans = HerotrialConfig.instance:getVerifyPlans(activityId)
	local tempStr = string.split((verifyCfg or nil) and verifyCfg.bossBuff, ":")
	local buffId = tempStr[1]
	local buffIcon = BattleConfig.instance:getBuffCo(tonumber(buffId))

	self.imgEffect:SetImage(GameUrl.getExpEventUrl(buffIcon.icon))

	self._txtBoxNum.text = "进度奖 " .. 1
end

function BattleHeroTrialView:updateValue(cur, total, isForce)
	local value = total - cur

	if self._cfgs == nil then
		return
	end

	value = checknumber(value)
	value = math.max(0, value)
	self._value = checknumber(self._value)
	self._value = math.max(0, self._value)

	local targetCfg, targetIdx = self:_getCurCfgAndNeed(value)

	self._bloodBar:setTextProgress(string.format("总伤害：%s/%s", value, targetCfg.interval))

	local sliderValue = targetIdx - 1 + value / targetCfg.interval

	self._bloodBar:setProgress(sliderValue, isForce)

	self._value = value

	for i, v in ipairs(self._cfgs) do
		self._txtBoxNum.text = "进度奖 " .. i

		if value < v.interval then
			break
		end
	end
end

function BattleHeroTrialView:_getCurCfgAndNeed(value)
	local idx

	for i = 1, #self._cfgs do
		if value < self._cfgs[i].interval then
			idx = i

			break
		end
	end

	idx = idx or #self._cfgs

	local cfg = self._cfgs[idx]

	return cfg, idx
end

return BattleHeroTrialView
