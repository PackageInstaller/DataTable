-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameEggView.lua

module("logic.extensions.burygame.view.BuryGameEggView", package.seeall)

local BuryGameEggView = class("BuryGameEggView", ViewComponent)

function BuryGameEggView:unbindEvents()
	BuryGameEggView.super.unbindEvents(self)
	self._btnEgg:RemoveClickListener()
end

function BuryGameEggView:bindEvents()
	BuryGameEggView.super.bindEvents(self)
	self._btnEgg:AddClickListener(self._onClickEgg, self)
end

function BuryGameEggView:onExit()
	BuryGameEggView.super.onExit(self)
	self._multiLoader:clear()

	self._multiLoader = nil

	goutil.destroy(self._eggIns, true)
end

function BuryGameEggView:buildUI()
	BuryGameEggView.super.buildUI(self)

	self._bouns = self:getGo("bouns")
	self._btnEgg = self:getBtn("egg")
	self._items = self:getGo("items")
	self._txtCountDown = self:getTxt("countdown/txtTime")
	self._countdown = self:getGo("countdown")
	self._imgNum = self:getGo("egg/imgNum"):GetComponent(typeof(UIImgNumeralText))

	self._btnEgg.gameObject:SetActive(false)
	self._countdown:SetActive(true)

	self._eggPoint = self:getGo("egg/eggPoint")
end

function BuryGameEggView:onEnter()
	BuryGameEggView.super.onEnter(self)

	self._inGaming = false

	self._imgNum:SetText(0)
	self._bouns:SetActive(true)
	self._countdown:SetActive(false)
	settimer(2, self._startGame, self)

	self._prizeIds = BuryGameModel.instance:getSpecialPrizeIds()

	local activityId = BuryGameModel.instance:getActivityId()
	local cfg = BuryGameConfig.instance:getCfgById(activityId)

	self._specialPrizePlanId = cfg.specialPrizePlan
	self._multiLoader = MultiResLoader.New()

	local url = "effect/prefabs/ui/fx_ui_yirenzhixia/yirenzhixia_dan/dan-ui_p.prefab"

	self._multiLoader:addResPath(url, true)
	self._multiLoader:load(self._onAllLoaded, self._onOneLoaded, self)
end

function BuryGameEggView:_onOneLoaded(res)
	if res.IsSuccess then
		self._eggIns = goutil.clone(res:GetAsset(nil, nil))

		local trans = self._eggIns.transform

		goutil.addChildToParent(trans, self._eggPoint)
		Framework.TransformUtil.SetLocalPos(trans, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(trans, 1, 1, 1)

		self._sg = self._eggIns:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	end
end

function BuryGameEggView:_startGame()
	self._inGaming = true

	self._btnEgg.gameObject:SetActive(true)
	self._countdown:SetActive(true)
	removetimer(self._startGame, self)

	self._gainedPrizeNum = 0

	self._bouns:SetActive(false)

	self._tickedTime = 0
	self._gainedPrizeDict = {}
	self._duration = checknumber(BuryGameConfig.instance:getConstantValue("t5"))

	settimer(0, self._onTicking, self)
	self:_onTicking()
end

function BuryGameEggView:_onTicking()
	local deltaTime = UnityEngine.Time.deltaTime

	self._tickedTime = self._tickedTime + deltaTime

	local remainingTime = math.max(self._duration - self._tickedTime)

	self._txtCountDown.text = math.ceil(remainingTime)

	if remainingTime <= 0 then
		removetimer(self._onTicking, self)
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.BuryResumeGame, self._gainedPrizeNum)
	end
end

function BuryGameEggView:_playAnimation()
	local sg = self._sg

	if sg then
		local clipName = "2"

		sg.startingAnimation = clipName

		sg.AnimationState:SetAnimation(0, clipName, false)
		sg:Update(0)
	end
end

function BuryGameEggView:_onClickEgg()
	self:_playAnimation()

	if not self._inGaming then
		return
	end

	self:_playAnimation()

	local url = "fx_ui_yirenzhixia/yirenzhixia_dan/fx_ui_yirenzhixia_danda.prefab"

	self._eggEffect = UIEffectManager.instance:playEffect(self, url, self.mainGO, 0, 0, false, nil, nil, function(o, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setPos()
	end)

	local prizeId = self._prizeIds[self._gainedPrizeNum + 1]

	if prizeId then
		self._gainedPrizeNum = self._gainedPrizeNum + 1

		self._imgNum:SetText(self._gainedPrizeNum)

		local prizeCfg = BuryGameConfig.instance:getSpecialPrizeCfg(self._specialPrizePlanId, prizeId)
		local matType, matId, matNum = unpack(string.splitToNumber(prizeCfg.prize, ":"))
		local t = self._gainedPrizeDict[prizeId]

		if not t then
			self._gainedPrizeDict[prizeId] = {
				matType = matType,
				matId = matId,
				matNum = matNum
			}
		else
			t.matNum = matNum + t.matNum
		end

		self:_updatePrizes()
	end
end

function BuryGameEggView:_updatePrizes()
	local gainedPrizeList = {}

	for k, v in pairs(self._gainedPrizeDict) do
		table.insert(gainedPrizeList, v)
	end

	table.sort(gainedPrizeList, function(a, b)
		return a.matId < b.matId
	end)
	GameUtil.updateCellsWithCreate(self._items, gainedPrizeList, function(go, data)
		local str = string.format("%d:%d:%d", data.matType, data.matId, data.matNum)

		MaterialMgr.setCellByCfg(str, go)
	end)
end

return BuryGameEggView
