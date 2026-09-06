-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulategift/view/AccumulategiftView.lua

module("logic.extensions.accumulategift.view.AccumulategiftView", package.seeall)

local AccumulategiftView = class("AccumulategiftView", ViewComponent)

function AccumulategiftView:ctor()
	AccumulategiftView.super.ctor(self)

	self._curItemDatas = nil
	self._curRewardDatas = nil
	self._achieveList = nil
	self._yearFeeInfo = nil
	self._yearCount = 198
end

function AccumulategiftView:buildUI()
	AccumulategiftView.super.buildUI(self)

	self.tipsBtn = self:getBtn("tipsBtn")
	self.gotoBtn = self:getBtn("gotoBtn")
	self.itemListSR = self:getGo("itemListSR"):GetComponent("UITableview")
	self.itemCell = self:getGo("itemCell")

	self.itemCell:SetActive(false)

	self.timeTxt = goutil.findChildTextComponent(self.mainGO, "timeTxt")
	self.petNameTxt = goutil.findChildTextComponent(self.mainGO, "petNameTxt")
	self.petQualityIma = self:getGo("petQualityIma"):GetComponent("UIImageSpriteChange")
	self.progressTxt = goutil.findChildTextComponent(self.mainGO, "progressTxt")
	self.rewardListSR = self:getGo("rewardListSR"):GetComponent("UITableview")
	self.rewardCell = self:getGo("rewardCell")

	self.rewardCell:SetActive(false)

	self.progressGo = self:getGo("rewardListSR/Viewport/progBarGo/progressSld")
	self.progressSld = self.progressGo:GetComponent("Slider")
	self.fillImaGo = goutil.findChild(self.progressGo, "FillArea/FillIma1/FillIma2")
	self.rewardCell = self:getGo("rewardCell")
	self.sldEffGo = goutil.findChild(self.progressGo, "sldEffGo")
	self.progressSld.value = 0

	self.rewardCell:SetActive(false)
	self:_RegistCallbacks()
end

function AccumulategiftView:_buildBkgview()
	local prefab = self._viewPresentor:getPrefab(MountPresentor.MountViewBkgView)

	self._bkgViewGo = goutil.clone(prefab)
	self._avatarRoot = goutil.findChild(self._bkgViewGo, "avatarRoot/avatar")
end

function AccumulategiftView:_RegistCallbacks()
	self.itemListSR:RegisterCallback(self._ItemInView, function()
		return 542, 116
	end, self._ItemAtIndex, self)
	self.itemListSR:RegisterUpdateCellCallback(self._OnItemCellUpdate)
	self.rewardListSR:RegisterCallback(self._RewardInView, function()
		return 140, 160
	end, self._RewardAtIndex, self)
	self.rewardListSR:RegisterUpdateCellCallback(self._OnRewardCellUpdate)
	self.rewardListSR:AddOnScrollValueChanged(self.OnCellUpdatePosition, self)
end

function AccumulategiftView:_ItemInView()
	if not self._curItemDatas then
		return 0
	end

	return #self._curItemDatas
end

function AccumulategiftView:_ItemAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.itemCell)

	local data = self._curItemDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateItemCell(view, cell, data)

	return cell
end

function AccumulategiftView:_OnItemCellUpdate(view, cell)
	local index = cell.index
	local data = self._curItemDatas[index + 1]

	cell.data = index + 1

	self:_UpdateItemCell(view, cell, data)
end

function AccumulategiftView:_RewardInView()
	if not self._curRewardDatas then
		return 0
	end

	return #self._curRewardDatas
end

function AccumulategiftView:_RewardAtIndex(view, index)
	local cell
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self.rewardCell)

	local data = self._curRewardDatas[index + 1]

	cell.data = index + 1
	cell.index = index

	self:_UpdateRewardCell(view, cell, data)

	return cell
end

function AccumulategiftView:_OnRewardCellUpdate(view, cell)
	local index = cell.index
	local data = self._curRewardDatas[index + 1]

	cell.data = index + 1

	self:_UpdateRewardCell(view, cell, data)
end

function AccumulategiftView:bindEvents()
	AccumulategiftView.super.bindEvents(self)
	self.tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "accumulategift")
	end, self)
	self.gotoBtn:AddClickListener(function()
		if self.supTime <= 0 then
			FloatWordMgr.instance:show("活动已结束！")

			return
		end

		PayShopController.instance:openView(GameEnum.PayShopEasyJump.MibaoShop)
	end, self)
end

function AccumulategiftView:unbindEvents()
	AccumulategiftView.super.unbindEvents(self)
	self.tipsBtn:RemoveClickListener()
	self.gotoBtn:RemoveClickListener()
	self.rewardListSR:UnRegisterAllCallbacks()
end

function AccumulategiftView:onExit()
	AccumulategiftView.super.onExit(self)
	removetimer(self._CalculationSurplusTime, self)
	removetimer(self._CalculationProgressValue, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	if self._sldEff1 then
		UIEffectManager.instance:stopEffect(self._sldEff1)
	end

	if self._sldEff2 then
		UIEffectManager.instance:stopEffect(self._sldEff2)
	end

	self._sldEff1 = nil
	self._sldEff2 = nil
	self._isViewOver = false
	self._achieveList = nil
	self._yearFeeInfo = nil
	self._curItemDatas = nil
	self._curRewardDatas = nil
end

function AccumulategiftView:destroyUI()
	AccumulategiftView.super.destroyUI(self)
end

function AccumulategiftView:onEnter()
	AccumulategiftView.super.onEnter(self)
	removetimer(self._CalculationSurplusTime, self)
	removetimer(self._CalculationProgressValue, self)

	self._petRaceId = 1016701
	self._isViewOver = false
	self._rewardCount = 0
	self.actId = AccumulategiftConfig.instance:GetOpenActivityId()

	if self.actId <= 0 then
		self.actId = AccumulategiftConfig.instance._lastActivityId
	end

	if checknumber(self.actId) <= 0 then
		error("sr----  AccumulategiftView:onEnter() y运营-累计充值    配置错误，@曾国敏 @曾国敏 @曾国敏 = " .. self.actId)

		return
	end

	self.planId = AccumulategiftConfig.instance:GetActivityPlanID(self.actId)
	self.allCfgs = AccumulategiftConfig.instance:GetConsumeGiftCfg(self.planId)
	self._achieveList = {}
	self._yearFeeInfo = {
		beforeCount = 0,
		isPopup = false,
		isAnnuity = false,
		allMoney = 0,
		nowCount = 0,
		allCount = 0
	}

	self:_UpdataItemListSR()
	self:_UpdataRewardItems()

	local actCfg = ActivityDefineConfig.instance:getCfgById(22, self.actId)
	local timeEnd = GameUtil.string2time(actCfg.endTime)

	self.supTime = timeEnd - ServerTime.now()

	if self.supTime <= 0 then
		self.timeTxt.text = "活动结束"
		self._isViewOver = true
	else
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self.supTime)

		self.timeTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)

		settimer(1, self._CalculationSurplusTime, self, true)
	end

	local effPath = "fx_ui_leichong/fx_ui_zi_shiguangzhishi_leichong.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
	CampaignConsumeAgent.instance:sendPM_CampaignConsumeGetInfoReq(self.actId, function(msg)
		if msg.gainPrizeIds then
			self._achieveList = msg.gainPrizeIds
		end

		self._yearFeeInfo = self._yearFeeInfo or {}
		self._yearFeeInfo.isPopup = msg.hasSignPanel
		self._yearFeeInfo.beforeCount = math.floor(msg.annuityMoney / 100)
		self._yearFeeInfo.nowCount = math.floor(msg.money / 100)
		self._yearFeeInfo.allCount = self._yearFeeInfo.nowCount

		if self._yearFeeInfo.isPopup then
			self._yearFeeInfo.allCount = self._yearFeeInfo.nowCount + self._yearFeeInfo.beforeCount
		end

		self:_OpenActivationPopup()
	end)
end

function AccumulategiftView:_ShowPetModelInfo()
	self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._avatar:setParent(self._avatarRoot.transform)
	self._avatar:setLayer(SceneLayer.UI3D_Value)
	self._avatar:addListener(AvatarNotify.OnMountLoaded, self._onMountLoaded, self)

	self.avatarMo = DressModel.instance:getAvatarMoByOrigin(SceneMainPlayer.instance.userVar)
	self.avatarMo.mount = self._mountId
	self.avatarMo.isMount = true

	self._avatar:updateByMo(self.avatarMo)
end

function AccumulategiftView:_onMountLoaded()
	local mountCo = MountConfig.instance:getMountCo(self._mountId)

	if mountCo then
		local x, y, z = 0, 0, 0
		local scale = 1

		if mountCo.position then
			x = mountCo.position[1] or 0
			y = mountCo.position[2] or 0
			z = mountCo.position[3] or 0
		end

		scale = mountCo.scale

		if mountCo.scale == 0 then
			scale = 1
		end

		Framework.TransformUtil.SetLocalPos(self._avatarRoot.transform, x, y, z)
		Framework.TransformUtil.SetLocalScale(self._avatarRoot.transform, scale * 1.3, scale * 1.3, scale * 1.3)
	end
end

function AccumulategiftView:_OnClickSkillExplainBtn(isSkill)
	if self.supTime <= 0 then
		FloatWordMgr.instance:show("活动已结束！")

		return
	end

	UIJumper.instance:pushOneStack(self._viewPresentor.viewName, true)

	if isSkill then
		PetbookController.instance:previewBattle(self._petRaceId)
	else
		UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, self._petRaceId)
	end
end

function AccumulategiftView:_CalculationSurplusTime()
	self.supTime = self.supTime - 1

	if self.supTime <= 0 then
		removetimer(self._CalculationSurplusTime, self)

		self.timeTxt.text = "活动结束"
		self._isViewOver = true

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self.supTime)

	self.timeTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function AccumulategiftView:_ShowSpriteRawInfo()
	local cfg = MaterialMgr.getMatCfg(MatType.PET_SKIN, self._petRaceId)

	self.petNameTxt.text = cfg.skinName

	self.petQualityIma:SetState(cfg.quality)
	self.photoEff:setEffectLoadedCallback(function(go)
		GoUtil.PlaySpineAnim(go, "idle", true, true)
		Framework.TransformUtil.SetLocalScale(go.transform, -1, 1, 1)
		Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	end)

	local resCfg = CharacterConfig.instance:getModelCo(checknumber(self._petRaceId))

	self.photoEff:showEffectsFullScreen({
		GameUrl.getLihuiSpineUrl(resCfg.bustName)
	})
	self.photoEff:setCameraPosition(0.3, 4.2, -1)
	self.photoEff:setCameraSize(3.3)

	local camera = self.photoEff._photo.producer.rtCamera

	camera.orthographic = true

	Game.ImageUtil.SetRawImageAlpha(self.roleImg, 1)
end

function AccumulategiftView:_UpdataItemListSR()
	self._curItemDatas = {}

	for _, cfg in pairs(self.allCfgs or {}) do
		if cfg and not string.nilorempty(cfg.gift) then
			if cfg.consumeMoney > self._yearFeeInfo.allMoney then
				self._yearFeeInfo.allMoney = cfg.consumeMoney
			end

			local data = {}

			data.id = cfg.id
			data.needCount = cfg.consumeMoney
			data.icon = cfg.icon
			data.name = cfg.name
			data.goodsList = string.split(cfg.gift, "#")
			data.stageNum = self:_GetItemStageNum(cfg)

			table.insert(self._curItemDatas, data)
		end
	end

	if #self._curItemDatas > 1 then
		table.sort(self._curItemDatas, function(a, b)
			if a.stageNum == b.stageNum then
				return a.needCount < b.needCount
			end

			return a.stageNum < b.stageNum
		end)
	end

	self.itemListSR:ReloadData()
end

function AccumulategiftView:_GetItemStageNum(cfg)
	for k, coun in pairs(self._achieveList or {}) do
		if k and checknumber(coun) > 0 and cfg.id == coun then
			return 3
		end
	end

	if cfg.consumeMoney <= self._yearFeeInfo.allCount then
		return 1
	end

	return 2
end

function AccumulategiftView:_UpdateItemCell(view, cell, data)
	local tagTxt = goutil.findChildTextComponent(cell, "tagTxt")
	local goodsItemList = {
		goutil.findChild(cell, "goods_1"),
		goutil.findChild(cell, "goods_2"),
		goutil.findChild(cell, "goods_3"),
		goutil.findChild(cell, "goods_4")
	}
	local achieveTxt = goutil.findChildTextComponent(cell, "achieveTxt")
	local progsTxt = goutil.findChildTextComponent(cell, "progsTxt")
	local achieveBtnGo = goutil.findChild(cell, "achieveBtn")

	GameUtil.asBtn(achieveBtnGo):RemoveClickListener()

	for i = 1, #goodsItemList do
		if goodsItemList[i] then
			MaterialMgr.resetAll(goodsItemList[i])
		end
	end

	tagTxt.text = string.format("累充%s元", data.needCount)

	if data.stageNum == 1 then
		achieveTxt.text = ""

		achieveBtnGo:SetActive(true)

		progsTxt.text = string.format("<color=#11A568FF>%s</color>/%s", self._yearFeeInfo.allCount, data.needCount)
	elseif data.stageNum == 2 then
		achieveBtnGo:SetActive(false)

		achieveTxt.text = "未满足"
		progsTxt.text = string.format("<color=#EB4642FF>%s</color>/%s", self._yearFeeInfo.allCount, data.needCount)
	elseif data.stageNum == 3 then
		achieveBtnGo:SetActive(false)

		achieveTxt.text = "已领取"
		progsTxt.text = ""
	end

	if data.goodsList and #data.goodsList > 0 then
		for i = 1, #data.goodsList do
			if goodsItemList[i] and not string.nilorempty(data.goodsList[i]) then
				local info = string.split(data.goodsList[i], ":")
				local itemType = checknumber(info[1])
				local proxy = MaterialMgr.setCell(itemType, checknumber(info[2]), goodsItemList[i])

				proxy.binder:setNum(checknumber(info[3]))

				if itemType == MatType.Pet then
					local lv = info[4] and checknumber(info[4]) or 1

					proxy.binder:setLvl(lv)
				end
			end
		end
	end

	if data.stageNum ~= 1 then
		return
	end

	GameUtil.asBtn(achieveBtnGo):AddClickListener(function()
		self:_OnClickAchieveBtn(data.id)
	end, self)
end

function AccumulategiftView:_OnClickAchieveBtn(id)
	for k, value in pairs(self._achieveList or {}) do
		if k and checknumber(value) == id then
			FloatWordMgr.instance:show("已领取，请勿重复领取！")

			return
		end
	end

	CampaignConsumeAgent.instance:sendPM_CampaignConsumeGainPrizeReq(self.actId, id, function(msg)
		self._achieveList = self._achieveList or {}

		table.insert(self._achieveList, id)
		self:_UpdataItemListSR()
	end)
end

function AccumulategiftView:_OpenActivationPopup()
	if self._yearFeeInfo.isPopup then
		self:_UpdataItemListSR()
		self:_UpdataRewardItems()

		return
	end

	if self._yearFeeInfo.nowCount + self._yearFeeInfo.beforeCount < self._yearCount then
		local value = GameUtil.getUserDayData("OpenAccumulategiftPopup")

		if checknumber(value) ~= 1 then
			GameUtil.saveUserDayData("OpenAccumulategiftPopup", 1)

			local des = "激活年费卡，累充进度<color=#EB4642FF>直接增加至198元</color>，\n全年年费累充活动均有效，<color=#EB4642FF>免费领198元</color>累充奖励！"

			TipsFacade.instance:openTipWindow("年费累充", des, function()
				PayShopController.instance:openView(GameEnum.PayShopEasyJump.YearCard)
			end, "激活年费", UnityEngine.TextAnchor.MiddleCenter)
		end

		self:_UpdataItemListSR()
		self:_UpdataRewardItems()

		return
	end

	local str = "您已激活年费卡，年费累充进度<color=#EB4642FF>直接增加至198元</color>，\n全年年费累充活动均有效，<color=#EB4642FF>免费领198元</color>累充奖励！"

	TipsFacade.instance:openTipWindowNoX("年费累充", str, function()
		self._yearFeeInfo.isPopup = true
		self._yearFeeInfo.allCount = self._yearFeeInfo.nowCount + self._yearFeeInfo.beforeCount

		CampaignConsumeAgent.instance:sendPM_CampaignSignPanelReq(self.actId)
		self:_UpdataItemListSR()
		self:_UpdataRewardItems(true)

		if self._yearIndex <= 0 or self._rewardCount <= 0 or self._rewardCount < self._yearIndex then
			print("sr--- AccumulategiftView:_OpenActivationPopup()  诺亚累充  未找到配置 = ", self._yearIndex, self._rewardCount)

			return
		end

		self._allValue = self._yearIndex / self._rewardCount
		self._timer = 0.01
		self._nowValue = 0
		self.progressSld.value = 0

		settimer(self._timer, self._CalculationProgressValue, self, true)
	end, "太棒了", UnityEngine.TextAnchor.MiddleCenter)
end

function AccumulategiftView:_UpdataRewardItems(isEff)
	if self._curRewardDatas == nil or #self._curRewardDatas == 0 then
		self._curRewardDatas = {}

		for _, cfg in pairs(self.allCfgs or {}) do
			if cfg and checknumber(cfg.consumeMoney) > 0 then
				table.insert(self._curRewardDatas, {
					needCount = cfg.consumeMoney,
					icon = cfg.icon,
					name = cfg.name
				})
			end
		end

		self._yearIndex = 0
		self._rewardCount = #self._curRewardDatas

		if self._rewardCount > 1 then
			table.sort(self._curRewardDatas, function(a, b)
				return a.needCount < b.needCount
			end)

			for i = 1, self._rewardCount do
				if self._curRewardDatas[i] and self._curRewardDatas[i].needCount == self._yearCount then
					self._yearIndex = i

					break
				end
			end
		end
	end

	self.progressTxt.text = self._yearFeeInfo.allCount .. "/" .. self._yearFeeInfo.allMoney

	self.rewardListSR:ReloadData()
	GameUtil.setWidth(self.progressGo, self._rewardCount * 140 + 6)
	GameUtil.setWidth(self.fillImaGo, self._yearIndex * 140)

	if self._yearFeeInfo.isPopup then
		if isEff then
			Framework.TransformUtil.SetLocalPos(self.sldEffGo.transform, 0, 0, 0)

			if self._sldEff1 == nil then
				local effPath = "fx_ui_leichong/fx_ui_jindutiao_leichong.prefab"

				self._sldEff1 = UIEffectManager.instance:playEffect(self, effPath, self.sldEffGo, 0, 0, true, nil, nil, nil, self)

				self._sldEff1:setParent(self.sldEffGo.transform)
				self._sldEff1:setLocalPos(0, 0, 0)
				self._sldEff1:setScale(1)
			end
		else
			Framework.TransformUtil.SetLocalPos(self.sldEffGo.transform, 140 * self._yearIndex, 0, 0)
		end
	end

	if self._rewardCount <= 0 or self._yearFeeInfo.allCount <= 0 then
		self.progressSld.value = 0

		return
	end

	local once = 1 / self._rewardCount
	local value = 0

	for i = 1, self._rewardCount do
		if self._curRewardDatas[i] then
			if self._curRewardDatas[i].needCount <= self._yearFeeInfo.allCount then
				value = value + once
			else
				local syc = 0

				if self._curRewardDatas[i - 1] and self._curRewardDatas[i - 1].needCount > 0 then
					syc = self._curRewardDatas[i - 1].needCount
				end

				local temp = (self._yearFeeInfo.allCount - syc) * once / (self._curRewardDatas[i].needCount - syc)

				value = value + temp

				break
			end
		end
	end

	self._progsValue = value
	self.progressSld.value = value
end

function AccumulategiftView:_CalculationProgressValue()
	self._nowValue = self._nowValue + self._timer
	self.progressSld.value = self._nowValue

	local w = GameUtil.getWidth(self.progressGo)

	Framework.TransformUtil.SetLocalPos(self.sldEffGo.transform, self._nowValue * w, 0, 0)

	if self._nowValue > self._allValue then
		removetimer(self._CalculationProgressValue, self)

		if self._progsValue < self._allValue then
			self._progsValue = self._allValue
		end

		self.progressSld.value = self._progsValue

		if self._sldEff1 then
			UIEffectManager.instance:stopEffect(self._sldEff1)
		end

		self._sldEff1 = nil

		if self._sldEff2 then
			UIEffectManager.instance:stopEffect(self._sldEff2)
		end

		self._sldEff2 = nil

		return
	end
end

function AccumulategiftView:_onReloadFinish()
	self:OnCellUpdatePosition()
end

function AccumulategiftView:_UpdateRewardCell(view, cell, data)
	local iconImaGo = goutil.findChild(cell, "iconImaGo")
	local progTxt = goutil.findChildTextComponent(cell, "progTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")

	uGuiUtil.setSpriteToImage(iconImaGo, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", data.icon))

	progTxt.text = tostring(data.needCount)
	nameTxt.text = data.name
end

function AccumulategiftView:OnCellUpdatePosition(pos)
	local contentGo = self.rewardListSR:GetContent()

	if self._curRewardDatas then
		if not #self._curRewardDatas then
			local count = 0
			local width = count * 140 + 70

			GameUtil.setWidth(contentGo, width)
			Framework.TransformUtil.SetLocalPos(self.progressGo.transform, contentGo.transform.localPosition.x, -120, 0)
		end
	end
end

return AccumulategiftView
