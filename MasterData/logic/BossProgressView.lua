-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/BossProgressView.lua

module("logic.extensions.sharetask.view.BossProgressView", package.seeall)

local BossProgressView = class("BossProgressView", TableViewComponent)

function BossProgressView:ctor()
	BossProgressView.super.ctor(self)

	self.mvpIndex = 0
end

function BossProgressView:bindEvents()
	BossProgressView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.helpMeBtn:AddClickListener(self.OnClickHelpBtn, self)
end

function BossProgressView:unbindEvents()
	BossProgressView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.helpMeBtn:RemoveClickListener()
end

function BossProgressView:onExit()
	BossProgressView.super.onExit(self)
	removetimer(self.CalculationSurplusTime, self)
end

function BossProgressView:destroyUI()
	BossProgressView.super.destroyUI(self)
	self.petPhoto:clear()

	self.mvpIndex = 0
end

function BossProgressView:buildUI()
	BossProgressView.super.buildUI(self)

	self.viewCloseBtn = self:getBtn("viewCloseBtn")

	local spriteRawGo = self:getGo("spriteRawIma")

	self.petPhoto = PetPhotoShow.Get(spriteRawGo)
	self.runTimeTxt = goutil.findChildTextComponent(self.mainGO, "runTimeTxt")
	self.bloodBarSli = goutil.findChild(self.mainGO, "bloodBarSli"):GetComponent("Slider")
	self.bloodCountTxt = goutil.findChildTextComponent(self.mainGO, "bloodCountTxt")
	self.bloodValueTxt = goutil.findChildTextComponent(self.mainGO, "bloodValueTxt")
	self.bossLevelTxt = goutil.findChildTextComponent(self.mainGO, "bossLevelTxt")
	self.bossNameTxt = goutil.findChildTextComponent(self.mainGO, "bossNameTxt")
	self.challCountTxt = goutil.findChildTextComponent(self.mainGO, "challCountTxt")
	self.bossStageIma = self:getGo("stageIma"):GetComponent("UIImageSpriteChange")
	self.noDataGo = self:getGo("noDataGo")
	self.helpMeBtn = self:getBtn("helpMeBtn")
	self.btnTxt = goutil.findChildTextComponent(self.mainGO, "helpMeBtn/btnTxt")
	self.runTimeTxt.text = ""
	self.bloodCountTxt.text = ""
	self.bloodBarSli.value = 0
	self.bloodValueTxt.text = ""
	self.bossLevelTxt.text = ""
	self.bossNameTxt.text = ""
	self.challCountTxt.text = ""

	GameUtil.SetActive(self.bossStageIma, false)
	self.noDataGo:SetActive(false)
	self.helpMeBtn.gameObject:SetActive(false)
end

function BossProgressView:onEnter()
	BossProgressView.super.onEnter(self)
	removetimer(self.CalculationSurplusTime, self)

	self.isOtherBoss = false

	if self._viewPresentor._openParam and self._viewPresentor._openParam[1] then
		self.isOtherBoss = true
	end

	self.ownId = RoleModel.instance:getUserId()

	if self.isOtherBoss then
		self.btnTxt.text = "助战"
		self.bossInfo = ShareTaskModel.instance:GetOtherShareBossInfo()

		self.helpMeBtn.gameObject:SetActive(true)
	else
		self.btnTxt.text = "求助"
		self.bossInfo = ShareTaskModel.instance:GetMyShareBossInfo()

		self.helpMeBtn.gameObject:SetActive(self.bossInfo.isChallenged)
	end

	if self.bossInfo == nil or not self.bossInfo.isHaveBoss then
		printError("sr----- 怪物来袭      BossProgressView:onEnter()     没有Boss信息！")
	end

	self.bossCfg = ShareTaskConfig.instance:GetBossBaseCfg(self.bossInfo.bossTypeId)

	local cfg = CharacterConfig.instance:getModelCo(self.bossCfg.monsterId)
	local showLihui = cfg and not string.nilorempty(cfg.bustName)

	self.petPhoto:showPetEffect(self.bossCfg.monsterId, showLihui, self.bossCfg.modelSize)

	local value = math.floor(self.bossInfo.curHp * 100 / self.bossInfo.maxHp)

	self.bloodCountTxt.text = value .. "%"
	self.bloodBarSli.value = self.bossInfo.curHp / self.bossInfo.maxHp
	self.bloodValueTxt.text = self.bossInfo.curHp .. "/" .. self.bossInfo.maxHp
	self.bossNameTxt.text = self.bossCfg.name
	self.bossLevelTxt.text = "Lv." .. self.bossCfg.monsterLevel
	self._curViewDatas = self.bossInfo.partnerList or {}

	if self._curViewDatas then
		if not #self._curViewDatas then
			local count = 0

			self.mvpIndex = 0

			if count <= 0 then
				self.noDataGo:SetActive(true)

				self.challCountTxt.text = string.format("助战人次 0/%s", self.bossCfg.memberLimit)
			else
				self.noDataGo:SetActive(false)

				self.challCountTxt.text = string.format("助战人次 %s/%s", count, self.bossCfg.memberLimit)

				for i = 1, count do
					if self._curViewDatas and self._curViewDatas[i] and not self._curViewDatas[i].forFree then
						self.mvpIndex = i

						break
					end
				end
			end

			self._tableview:ReloadData()

			local stageNum = self:GetBossChallengeStage()

			if stageNum < 0 then
				GameUtil.SetActive(self.bossStageIma, false)
			else
				GameUtil.SetActive(self.bossStageIma, true)
				self.bossStageIma:SetState(stageNum)
			end

			if self.bossInfo.isFleeBoss then
				self.runTimeTxt.text = "此怪物已逃离"

				return
			end

			if self.bossInfo.isKillBoss then
				self.runTimeTxt.text = "此怪物已被击杀"

				return
			end

			local allTime = ShareTaskConfig.instance:GetBossShowTime()

			self.surplusTime = math.ceil(self.bossInfo.startTime / 1000 + allTime - checknumber(ServerTime.now()))

			if self.surplusTime <= 0 then
				self.runTimeTxt.text = "此怪物已逃离"

				return
			end

			self:ShowSurplusTime()
			settimer(1, self.CalculationSurplusTime, self, true)
		end
	end
end

function BossProgressView:GetBossChallengeStage()
	if self.bossInfo == nil or checknumber(self.bossInfo.bossId) < 1 then
		return -1
	end

	if self.bossInfo.curHp <= 0 then
		return 0
	end

	local allTime = ShareTaskConfig.instance:GetBossShowTime()
	local supTime = self.bossInfo.startTime / 1000 + allTime - checknumber(ServerTime.now())

	if supTime <= 0 then
		return 2
	elseif self.bossInfo.isChallenged then
		return 1
	end

	return -1
end

function BossProgressView:OnClickHelpBtn()
	if self.bossInfo.isFleeBoss then
		FloatWordMgr.instance:show("该怪物已逃离!")

		return
	end

	if self.bossInfo.isKillBoss then
		FloatWordMgr.instance:show("该怪物已被击败!")

		return
	end

	if self.bossInfo.isMaxChall then
		FloatWordMgr.instance:show("该怪物挑战已达上限!")

		return
	end

	if self._viewPresentor._openParam then
		if not self._viewPresentor._openParam[2] then
			local userName = "好友"

			self:close()

			if self.isOtherBoss then
				UIStateManager.instance:push(ViewName.ShareConfirm, userName, self.bossInfo.bossId)
			else
				UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.ShareBoss, self.bossInfo.bossId, self.bossInfo.bossTypeId)
			end
		end
	end
end

function BossProgressView:CalculationSurplusTime()
	self.surplusTime = self.surplusTime - 1

	if self.surplusTime <= 0 then
		self.runTimeTxt.text = "此怪物已逃离"

		FloatWordMgr.instance:show("暗瘾来袭活动结束！")
		removetimer(self.CalculationSurplusTime, self)
	end

	self:ShowSurplusTime()
end

function BossProgressView:ShowSurplusTime()
	local hour = math.floor(self.surplusTime / 3600)
	local min = math.floor((self.surplusTime - hour * 3600) / 60)
	local sec = self.surplusTime - hour * 3600 - min * 60

	self.runTimeTxt.text = hour > 0 and string.format("剩余时间 %s时%s分", hour, min) or string.format("剩余时间 %s分%s秒", min, sec)
end

function BossProgressView:_getPath()
	return {
		cellPath = "listItem",
		viewPath = "viewListSR"
	}
end

function BossProgressView:_cellSize()
	return 410, 85
end

function BossProgressView:_updateCell(view, cell, data)
	local headGo = goutil.findChild(cell, "headGo")
	local stageIma = goutil.findChild(cell, "stageIma"):GetComponent("UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local barSli = goutil.findChild(cell, "barSli"):GetComponent("Slider")

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	if self.bossInfo.isKillBoss then
		if self.mvpIndex == cell.data then
			stageIma.gameObject:SetActive(true)
			stageIma:SetState(0)
		elseif self.ownId == data.headInfo.userId then
			stageIma.gameObject:SetActive(true)
			stageIma:SetState(1)
		elseif data.forFree then
			stageIma.gameObject:SetActive(true)
			stageIma:SetState(2)
		else
			stageIma.gameObject:SetActive(false)
		end
	else
		stageIma.gameObject:SetActive(false)
	end

	rankTxt.text = tostring(cell.data)
	nameTxt.text = data.headInfo.userName
	powerTxt.text = data.causeDamage

	local value = data.causeDamage / self.bossInfo.maxHp

	if value > 0 and value < 0.02 then
		value = 0.02
	end

	barSli.value = value
end

return BossProgressView
