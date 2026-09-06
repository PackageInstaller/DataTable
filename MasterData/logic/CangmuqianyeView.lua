-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/CangmuqianyeView.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.CangmuqianyeView", package.seeall)

local CangmuqianyeView = class("CangmuqianyeView", ViewComponent)

function CangmuqianyeView:buildUI()
	CangmuqianyeView.super.buildUI(self)

	self._closeBtn = self:getBtn("topleft/btnClose")
	self._ruleBtn = self:getBtn("topleft/btnRule")
	self._contract = {}

	local contract = self:getGo("contract")

	for i = 1, 4 do
		local path = "pet_" .. i

		self._contract[i] = {
			challengeBtn = Framework.ButtonAdapter.GetFrom(contract, path .. "/challengeBtn")
		}
		self._contract[i].name = goutil.findChildTextComponent(contract, path .. "/name")
		self._contract[i].desc = goutil.findChildTextComponent(contract, path .. "/desc")
		self._contract[i].tipBtn = Framework.ButtonAdapter.GetFrom(contract, path .. "/tipBtn")
		self._contract[i].useFlag = goutil.findChild(contract, path .. "/useFlag")
		self._contract[i].lock = goutil.findChild(contract, path .. "/lock")
		self._contract[i].lockText = goutil.findChildTextComponent(contract, path .. "/lock/txtLock")
		self._contract[i].con = goutil.findChild(contract, path .. "/pet/con")
		self._contract[i].rare = goutil.findChild(contract, path .. "/rare")
		self._contract[i].rareText = goutil.findChildTextComponent(contract, path .. "/rare/Text")
	end

	self._unLockText = self:getTxt("txtbg/Text")
	self._buffDesc = self:getTxt("buff/txtDesc")
end

function CangmuqianyeView:bindEvents()
	CangmuqianyeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._ruleBtn:AddClickListener(self._onClickRule, self)

	for i, v in ipairs(self._contract) do
		v.challengeBtn:AddClickListener(function()
			self:_onClickChallenge(i)
		end)
		v.tipBtn:AddClickListener(function()
			self:_onClickTip(i)
		end)
	end
end

function CangmuqianyeView:unbindEvents()
	CangmuqianyeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._ruleBtn:RemoveClickListener()

	for i, v in ipairs(self._contract) do
		v.challengeBtn:RemoveClickListener()
		v.tipBtn:RemoveClickListener()
	end
end

function CangmuqianyeView:onEnter()
	CangmuqianyeView.super.onEnter(self)
	GlobalDispatcher:addListener(TianmanKingController.PM_TMWCGetSingleChallengeInfoRes, self._handlePM_TMWCGetSingleChallengeInfoRes, self)
	TianManWangChallengeAgent.instance:sendPM_TMWCGetSingleChallengeInfoReq(1)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyRefresh, self)
end

function CangmuqianyeView:onExit()
	CangmuqianyeView.super.onExit(self)
	GlobalDispatcher:removeListener(TianmanKingController.PM_TMWCGetSingleChallengeInfoRes, self._handlePM_TMWCGetSingleChallengeInfoRes, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._dailyRefresh, self)
end

function CangmuqianyeView:_handlePM_TMWCGetSingleChallengeInfoRes(msg)
	self._timeOpenPassedStage = TianmanKingModel.instance:getTimeOpenPassedStage()
	self._unLockText.text = TianmanKingController.instance:getText("TEXT_8", self._timeOpenPassedStage.num, 4)

	local buffCfg = TianmanKingConfig.instance:getBuffByLevel(msg.buffLevel)

	self._buffDesc.text = buffCfg and TianmanKingController.instance:getText("TEXT_10", msg.buffLevel, buffCfg.des) or ""

	local supportPetCfg = TianmanKingConfig.instance:getSupportPet()

	for i, cell in ipairs(self._contract) do
		local petCo = CharacterConfig.instance:getPetCo(supportPetCfg[i + 1].raceId)

		cell.name.text = petCo.name

		uGuiUtil.setGoGrayState(cell.name.gameObject, not self._timeOpenPassedStage[i])
		uGuiUtil.setSpriteToImage(cell.con, uGuiUtil.SpriteType.BigBg, GameUrl.getLotteryPetImgUrl(petCo.raceId))
		uGuiUtil.setGoGrayState(cell.con, not self._timeOpenPassedStage[i])

		local stageCfg = TianmanKingConfig.instance:getStageByTypeAndStage(1, i)
		local opTime = GameUtil.string2time(stageCfg.unlockParams)

		goutil.setActive(cell.lock, opTime > ServerTime.now())

		if opTime > ServerTime.now() then
			cell.lockText.text = TianmanKingController.instance:getText("TEXT_11", os.date("%m月%d日 %H:%M:%S", opTime))

			goutil.setActive(cell.challengeBtn.gameObject, false)
		else
			goutil.setActive(cell.challengeBtn.gameObject, not self._timeOpenPassedStage[i])
		end

		cell.desc.text = supportPetCfg[i + 1].desc

		uGuiUtil.setGoGrayState(cell.rare, not self._timeOpenPassedStage[i])

		cell.rareText.text = TianmanKingController.instance:getText("TEXT_12", stageCfg.level)

		goutil.setActive(cell.useFlag, TianmanKingModel.instance:getCurSummon() == supportPetCfg[i + 1].supportPetId)
	end
end

function CangmuqianyeView:_dailyRefresh()
	for i, cell in ipairs(self._contract) do
		local opTime = GameUtil.string2time(stageCfg.unlockParams)

		goutil.setActive(cell.lock, opTime > ServerTime.now())

		if opTime > ServerTime.now() then
			cell.lockText.text = string.format(TianmanKingConfig.instance:getCommonValueByKey("TEXT_11"), os.date("%m月%d日 %H:%M:%S", opTime))

			goutil.setActive(cell.challengeBtn.gameObject, false)
		else
			goutil.setActive(cell.challengeBtn.gameObject, not self._timeOpenPassedStage[i])
		end
	end
end

function CangmuqianyeView:_onClickRule()
	local ruleKey = TianmanKingConfig.instance:getTypeByType(1).ruleKey

	UIStateManager.instance:push(ViewName.RulesView, ruleKey)
end

function CangmuqianyeView:_onClickChallenge(index)
	UIStateManager.instance:push(ViewName.TianmanKingMissionView, 1, index)
end

function CangmuqianyeView:_onClickTip(index)
	local supportPetCfg = TianmanKingConfig.instance:getSupportPet()

	CommonTipsMgr.instance:showMaxLvlPetTips(supportPetCfg[index + 1].raceId)
end

return CangmuqianyeView
