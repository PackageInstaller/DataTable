-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/equip/RogueEquipMainView.lua

module("logic.extensions.roguelike.view.explore.equip.RogueEquipMainView", package.seeall)

local M = class("RogueEquipMainView", ViewComponent)
local kMaxEquipLevel = 10
local coinId = 1100013

function M:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._imgEquipIcon = self:getImage("rungroup_equip_main_view_-1480059542")
	self._imgEquipIcon2 = self:getImage("rungroup_equip_main_view_-424295038")
	self._imgCostIcon = self:getImage("rungroup_equip_main_view_-2038346395")
	self._btn_clickCost = self:getBtn("rungroup_equip_main_view_1999397939")
	self._txtEquipName = self:getText("rungroup_equip_main_view_-1541164687")
	self._txtEquipDesc = self:getText("rungroup_equip_main_view_1996667338")
	self._txtEquipCurLv = self:getText("rungroup_equip_main_view_-1182299931")
	self._txtEquipNextLv = self:getText("rungroup_equip_main_view_-93144019")
	self._txtEquipNextLv2 = self:getText("rungroup_equip_main_view_-1146267467")
	self._descBox1UpgradeBefore = RogueEquipDescBox.New(self:getGo("rungroup_equip_main_view_481893172"))
	self._descBox2UpgradeBefore = RogueEquipDescBox.New(self:getGo("rungroup_equip_main_view_225311945"))
	self._descBox1UpgradeAfter = RogueEquipDescBox.New(self:getGo("rungroup_equip_main_view_-1735980339"))
	self._descBox2UpgradeAfter = RogueEquipDescBox.New(self:getGo("rungroup_equip_main_view_-1986413303"))
	self._descBox1ShowPanel = RogueEquipDescBox.New(self:getGo("rungroup_equip_main_view_-1611223487"))
	self._descBox2ShowPanel = RogueEquipDescBox.New(self:getGo("rungroup_equip_main_view_-964351904"))
	self._descBox1MaxPanel = RogueEquipDescBox.New(self:getGo("rungroup_equip_main_view_-1082083741"))
	self._descBox2MaxPanel = RogueEquipDescBox.New(self:getGo("rungroup_equip_main_view_-1496385238"))
	self._descBox1MaxTips = RogueEquipDescBox.New(self:getGo("rungroup_equip_main_view_-88226194"))
	self._descBox2MaxTips = RogueEquipDescBox.New(self:getGo("rungroup_equip_main_view_-345431661"))
	self._descWear1ShowPanel = RogueEquipDescBox.New(self:getGo("4&rungroup_equip_wear_tips_785458736"))
	self._descWear2ShowPanel = RogueEquipDescBox.New(self:getGo("4&rungroup_equip_wear_tips_-1808805893"))
	self._txtCostCount = self:getText("rungroup_equip_main_view_-498891606")
	self._btnUpgrade = self:getBtn("rungroup_equip_main_view_-657133378")
	self._btnCloseUpgrade = self:getBtn("rungroup_equip_main_view_-8830003")
	self._goUpgradePanel = self:getGo("rungroup_equip_main_view_-1886372418")
	self._guiAnimUpgradePanel = goutil.addComponentOnce(self._goUpgradePanel, typeof(Astral.GUITimelineAniLua))

	goutil.setActive(self._goUpgradePanel, true)
	goutil.setActive(self._goUpgradePanel, false)

	self._goUpgradeFixedPanel = self:getGo("rungroup_equip_main_view_1769128359")
	self._goMaxLevelPanel = self:getGo("rungroup_equip_main_view_-2073284469")
	self._goEquipScroll = self:getGo("rungroup_equip_main_view_-273873212")
	self._goUpgrade = self:getGo("rungroup_equip_main_view_-1397694600")
	self._goWear = goutil.findChild(self.mainGO, "rungroup_equip_wear_tips")
	self._guiAnimWearTips = goutil.addComponentOnce(self._goWear, typeof(Astral.GUITimelineAniLua))
	self._txtEquipWearLv = self:getText("4&rungroup_equip_wear_tips_1512715924")
	self._btnWear = self:getBtn("4&rungroup_equip_wear_tips_-2054943939")
	self._animBtnWear = self:getUIComponent("4&rungroup_equip_wear_tips_-2054943939", ComponentType.Animation)
	self._txtBtnWear = self:getText("4&rungroup_equip_wear_tips_-2132672984")
	self._equipScroll = LoopGridViewHelper.New(self._goEquipScroll)

	self._equipScroll:InitGridView(0, self._onCellUpdate, self)

	self._equipScrollRect = self._goEquipScroll:GetComponent(UIComponentType.ScrollRect)
	self._btnMaxTips = self:getBtn("rungroup_equip_main_view_-365022157")
	self._goMaxTips = self:getGo("rungroup_equip_main_view_-1491437984")
	self._btnMaxTipsClose = self:getBtn("3&empty_mask_tips_29887572")
	self._screenshotBlurImage = goutil.findChildRawImageComponent(self._goUpgradePanel, "common_blur_rt")
	self._screenshotImage = CaptureScreenshotImage.Get(self._screenshotBlurImage.gameObject)
	self._uiGlassBlur = SpaceX.UIGlassBlurUtil.Get(self._screenshotBlurImage.gameObject)
	self._uiGlassBlur.enabled = false
	self._timelineTask = TimelineTask.New()
end

function M:destroyUI()
	self._imgEquipIcon = nil
	self._imgCostIcon = nil
	self._txtEquipName = nil
	self._txtEquipDesc = nil
	self._txtEquipCurLv = nil
	self._txtEquipNextLv = nil
	self._txtCostCount = nil
	self._btnUpgrade = nil

	self._equipScroll:Dispose()

	self._equipScroll = nil
	self._equipScrollRect = nil
	self._guiAnimUpgradePanel = nil
end

function M:bindEvents()
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
	self._btnCloseUpgrade:AddClickListener(self._onHideUpgradePanel, self)
	self._btnWear:AddClickListener(self._onClickWear, self)
	self._btnMaxTips:AddClickListener(self._onClickMaxTips, self)
	self._btnMaxTipsClose:AddClickListener(self._onClickMaxTipsClose, self)
	self._btn_clickCost:AddClickListener(self._onClickCost, self)
end

function M:unbindEvents()
	self._btnUpgrade:RemoveClickListener()
	self._btnCloseUpgrade:RemoveClickListener()
	self._btnWear:RemoveClickListener()
	self._btnMaxTips:RemoveClickListener()
	self._btnMaxTipsClose:RemoveClickListener()
	self._guiAnimUpgradePanel:RemoveListener()
	self._btn_clickCost:RemoveClickListener()
end

function M:onEnter()
	self._canvasGroup.interactable = true
	self._itemCell = {}

	local showWearBtn = self:getFirstParam()

	goutil.setActive(self._goWear, showWearBtn)
	goutil.setActive(self._goUpgrade, not showWearBtn)
	goutil.setActive(self._goUpgradeFixedPanel, not showWearBtn)
	self:setEvent(true)

	self._curSelectIndex = nil

	self:showAllEquips(true)
	self._guiAnimWearTips:StopTimelineAni()

	if showWearBtn then
		self._guiAnimWearTips:PlayAniByName("open")
	end

	self._itemData = ItemUtil.createItemData({
		itemId = coinId
	})
end

function M:onExit()
	self:setEvent(false)
	self:_playItemOpenAni(false)

	for _, shower in pairs(self._itemCell or {}) do
		shower:StopAni()
		shower:setAlpha(0)
	end

	self._itemCell = nil

	self._equipScroll:ClearCells()
	self._timelineTask:clear()
	self._screenshotImage:Clear()
	self._guiAnimWearTips:StopTimelineAni()

	if self._goWear.gameObject.activeSelf then
		self._guiAnimWearTips:PlayAniByName("close")
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_UPGRADE, self._onEquipUpgrade, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_WEAR, self._onEquipWear, self)
		GlobalDispatcher:addEventListener(EventType.BLUR_BG_CAPTURE, self._initBlurEffect, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_UPGRADE, self._onEquipUpgrade, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_WEAR, self._onEquipWear, self)
		GlobalDispatcher:removeEventListener(EventType.BLUR_BG_CAPTURE, self._initBlurEffect, self)
	end
end

function M:_handleAniDownUpgradePanel(tagName, reason)
	if tagName == "showPanel_close" then
		self._guiAnimUpgradePanel:StopTimelineAni()
		self._guiAnimUpgradePanel:SetAniTime(0)
		goutil.setActive(self._goUpgradePanel, false)
		self._screenshotImage:Clear()
	end
end

function M:_initBlurEffect()
	self._guiAnimUpgradePanel:RemoveListener()

	local uiRoot = ViewMgr.instance:getUIRoot()
	local rectTransform = uiRoot.transform
	local width = rectTransform.rect.width
	local height = rectTransform.rect.height

	self._screenshotImage:Build(width, height)
	self._timelineTask:addTask(0, self._tCaptureFrame, self)
	self._timelineTask:addTask(0, self._tShowCaptureFrame, self)
	self._timelineTask:start()
end

function M:_tCaptureFrame()
	self._screenshotImage:CaptureFrame(self._onCaptureFinish, self)
end

function M:_tShowCaptureFrame()
	local viewName = self._viewPresentor and self._viewPresentor:getViewName() or "BlurBgView"

	GlobalDispatcher:dispatchEvent(EventType.ON_BLUR_BG_CAPTURE_FINISH, viewName)
end

function M:_onCaptureFinish()
	local downSample = self._downSample or 4
	local iteration = self._iteration or 4
	local renderTexture = SpaceX.CommandBufferEffectUtils.Blur(self._screenshotBlurImage.texture, CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.BlurMat), downSample, iteration)

	self._screenshotImage:SetRenderTexture(renderTexture)
	self._guiAnimUpgradePanel:RemoveListener()
	goutil.setActive(self._goUpgradePanel, true)

	self._screenshotBlurImage.enabled = true

	self._guiAnimUpgradePanel:StopTimelineAni()
	self._guiAnimUpgradePanel:PlayAniByName("showPanel_open")
end

function M:_onEquipRefresh()
	self:showAllEquips(false)
end

function M:_onEquipWear()
	self:close()
end

function M:_onEquipUpgrade(sender, id, lv)
	local equipCo = RoguelikeConfig.instance:getEquipById(id, lv)

	if equipCo then
		self:_initBlurEffect()

		local itemCo = BackpackConfig.instance:getItemInfoByItemId(id)

		self._descBox1UpgradeAfter:upadateData(equipCo.passiveEffectDescription)
		self._descBox2UpgradeAfter:upadateData(equipCo.activeEffectDescription)
		self._descBox1ShowPanel:upadateData(equipCo.passiveEffectDescription)
		self._descBox1MaxPanel:upadateData(equipCo.passiveEffectDescription)
		self._descBox2ShowPanel:upadateData(equipCo.activeEffectDescription)
		self._descBox2MaxPanel:upadateData(equipCo.activeEffectDescription)
		IconLoader.setSprite(self._imgEquipIcon2, IconType.ItemIcon, itemCo.icon)

		local costItem2 = equipCo.cost and equipCo.cost[1] or nil

		if costItem2 then
			local co1 = BackpackConfig.instance:getItemInfoByItemId(costItem2.id)

			IconLoader.setSprite(self._imgCostIcon, IconType.ItemIcon, co1.icon)
		end

		self._txtEquipNextLv2.text = lv

		local maxLevel = RoguelikeConfig.instance:getEquipMaxLevel(id)

		goutil.setActive(self._goUpgradeFixedPanel, lv < maxLevel)
		goutil.setActive(self._goMaxLevelPanel, maxLevel <= lv)

		if self._curSelectIndex then
			self:updateCurShowEquip(self._equipMos[self._curSelectIndex])
		end
	end
end

function M:showAllEquips(playItemOpenAni)
	local equipsMos = RoguelikeModel.instance:getEquipMOS()
	local count = equipsMos and #equipsMos or 0
	local scriptId = self:getOpenParam()[2]

	table.sort(equipsMos, function(a, b)
		local aInReject = a:getIsInRejectedScripts(scriptId) and -1 or 1
		local bInReject = b:getIsInRejectedScripts(scriptId) and -1 or 1

		if aInReject == bInReject then
			local aLevel = a:getLevel()
			local bLevel = b:getLevel()

			if aLevel == bLevel then
				return a:getId() > b:getId()
			else
				return bLevel < aLevel
			end
		else
			return bInReject < aInReject
		end
	end)

	self._equipMos = equipsMos

	if count > 0 and self._curSelectIndex == nil then
		self._curSelectIndex = 1
	end

	self._needPlayItemCellOpenAni = playItemOpenAni
	self._equipScrollRect.enabled = not playItemOpenAni

	self._equipScroll:ClearCells()
	self._equipScroll:SetListItemCount(count, true)
	self._equipScroll:RefreshAllShownItem()

	if playItemOpenAni then
		settimer(0.1, function()
			self:_playItemOpenAni(true)
		end, self, false)
	else
		self:_playItemOpenAni(false)
	end

	if self._curSelectIndex then
		self:updateCurShowEquip(self._equipMos[self._curSelectIndex])
	end
end

function M:_onShowUpgradePanel()
	if self._curSelectEquipMo and not self._curSelectEquipMo:getIsMaxLevel() then
		self._guiAnimUpgradePanel:RemoveListener()
		goutil.setActive(self._goUpgradePanel, true)
		self._guiAnimUpgradePanel:StopTimelineAni()
		self._guiAnimUpgradePanel:PlayAniByName("showPanel_open")
	else
		FloatWordMgr.instance:show(lang("tip_r_equip_max_level"))
	end
end

function M:_onHideUpgradePanel()
	self._guiAnimUpgradePanel:StopTimelineAni()
	self._guiAnimUpgradePanel:AddListener(self._handleAniDownUpgradePanel, self)
	self._guiAnimUpgradePanel:PlayAniByName("showPanel_close")
end

function M:checkIsWear(id)
	return RoguelikeModel.instance:getTempEquipId() == id
end

function M:_onClickMaxTips()
	goutil.setActive(self._goMaxTips, true)
end

function M:_onClickMaxTipsClose()
	goutil.setActive(self._goMaxTips, false)
end

function M:_onClickCost()
	GlobalDispatcher:dispatchEvent(EventType.ITEM_NORMAL_MARK_TYPE, self._itemData, self._btn_clickCost.gameObject, 0, true, false)
end

function M:_onClickWear()
	if self._curSelectEquipMo then
		local scriptId = self:getOpenParam()[2]
		local inInRejectScript = self._curSelectEquipMo:getIsInRejectedScripts(scriptId)

		if inInRejectScript then
			FloatWordMgr.instance:show(lang("tip_r_equip_cant_use"))

			return
		end

		local isInWear = self._curSelectEquipMo:getId() == RoguelikeModel.instance:getTempEquipId()

		if isInWear then
			RoguelikeModel.instance:setTempEquipId(0)
			RogueLocalStorageUtil.instance:saveLastEquipId(0)
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_EQUIP_REFRESH)
			self:close()

			return
		end

		if self._curSelectEquipMo:getId() == RoguelikeModel.instance:getTempEquipId() then
			-- block empty
		end

		local id = self._curSelectEquipMo:getId()

		RoguelikeModel.instance:setTempEquipId(id)
		self._animBtnWear:Stop()
		self._animBtnWear:Play("rungroup_equip_wear_tips_btnwear_open")

		self._canvasGroup.interactable = false

		settimer(0.3, function()
			self:close()
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_EQUIP_REFRESH)
		end, self, false)
	else
		print("暂未选择装备")
	end
end

function M:_onClickUpgrade()
	if self._curSelectEquipMo then
		local isMaxLevel = self._curSelectEquipMo:getIsMaxLevel()

		if isMaxLevel then
			FloatWordMgr.instance:show(lang("tip_r_equip_max_level"))

			return
		end

		RoguelikeAgent.instance:sendUpgradeEquipRequest(self._curSelectEquipMo:getId())
	else
		print("暂未选择装备")
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._equipScroll:NewListViewItem("cell")
	local data = self._equipMos[curIndex]
	local scriptId = self:getOpenParam()[2]

	if scriptId then
		data.inInRejectScript = data:getIsInRejectedScripts(scriptId)
	end

	data.isWear = self:checkIsWear(data:getId())

	local shower = Astral.LuaComponentContainer.Add(item.gameObject, RogueEquipItem)

	shower.view = self

	shower:setCellData(data, curIndex, self._curSelectIndex)
	shower:setClickCallBack(self._clickEquipCallBack, self)

	if self._needPlayItemCellOpenAni then
		self._itemCell[curIndex] = shower

		shower:setAlpha(0)
	else
		shower:setAlpha(1)
	end

	return item
end

function M:_playItemOpenAni(play)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}

	if play then
		local maxDelay = 0

		for index, shower in ipairs(self._itemCell or {}) do
			shower:StopAni()
			shower:setAlpha(0)

			local delay = index * 0.07

			delay = delay > 1 and 1 or delay
			maxDelay = maxDelay <= delay and delay or maxDelay

			local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
				shower:setAlpha(1)
				shower:playOpenAni()
			end)

			table.insert(self._cacheTweenLst, tweenDelay)
		end

		table.insert(self._cacheTweenLst, DoTweenUtil.DelayedCall(maxDelay, function()
			self._itemCell = {}
			self._needPlayItemCellOpenAni = false
			self._equipScrollRect.enabled = true
		end))
	else
		for _, shower in pairs(self._itemCell or {}) do
			shower:setAlpha(1)
		end

		self._cacheTweenLst = nil
		self._itemCell = {}
		self._needPlayItemCellOpenAni = false
	end
end

function M:_clickEquipCallBack(index)
	self._curSelectIndex = index

	local count = self._equipMos and #self._equipMos or 0

	self._equipScroll:SetListItemCount(count, true)
	self._equipScroll:RefreshAllShownItem()
	self:updateCurShowEquip(self._equipMos[index])
end

function M:updateCurShowEquip(data)
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(data:getId())

	IconLoader.setSprite(self._imgEquipIcon, IconType.ItemIcon, itemCo.icon)

	local equipCo = RoguelikeConfig.instance:getEquipById(data:getId(), data:getLevel())

	self._txtEquipName.text = itemCo.name
	self._txtEquipDesc.text = StringUtil.replaceAllGraphicText2(itemCo.desc)

	self._descBox1UpgradeBefore:upadateData(equipCo.passiveEffectDescription)
	self._descBox1MaxPanel:upadateData(equipCo.passiveEffectDescription)
	self._descBox2UpgradeBefore:upadateData(equipCo.activeEffectDescription)
	self._descBox2MaxPanel:upadateData(equipCo.activeEffectDescription)
	self._descWear1ShowPanel:upadateData(equipCo.passiveEffectDescription)
	self._descWear2ShowPanel:upadateData(equipCo.activeEffectDescription)

	self._txtEquipWearLv.text = data:getLevel()
	self._txtEquipCurLv.text = data:getLevel()
	self._txtEquipNextLv.text = data:getIsMaxLevel() and lang("tip_r_equip_max_txt") or data:getLevel() + 1
	self._curSelectEquipMo = data

	local curEquipId = RoguelikeModel.instance:getTempEquipId() or 0

	self._txtBtnWear.text = self:checkIsWear(data:getId()) and lang("tip_r_equip_remove") or curEquipId > 0 and lang("tip_r_equip_replace") or lang("tip_r_equip_bring")

	if not data:getIsMaxLevel() then
		local equipCo2 = RoguelikeConfig.instance:getEquipById(data:getId(), data:getLevel() + 1)

		if equipCo2 then
			self._descBox1UpgradeAfter:upadateData(equipCo2.passiveEffectDescription)
			self._descBox2UpgradeAfter:upadateData(equipCo2.activeEffectDescription)

			local costItem2 = equipCo2.cost and equipCo2.cost[1] or nil

			if costItem2 then
				local co1 = BackpackConfig.instance:getItemInfoByItemId(costItem2.id)

				IconLoader.setSprite(self._imgCostIcon, IconType.ItemIcon, co1.icon)
			end
		else
			printError("找不到装备配置", data:getId(), data:getLevel() + 1)
		end

		local maxCo = RoguelikeConfig.instance:getEquipById(data:getId(), data:getMaxLevel())

		if maxCo then
			self._descBox1MaxTips:upadateData(maxCo.passiveEffectDescription)
			self._descBox2MaxTips:upadateData(maxCo.activeEffectDescription)
		end

		local costItem = equipCo2.cost and equipCo2.cost[1] or nil

		if costItem then
			local co1 = BackpackConfig.instance:getItemInfoByItemId(costItem.id)

			IconLoader.setSprite(self._imgCostIcon, IconType.ItemIcon, co1.icon)

			self._txtCostCount.text = "x" .. costItem.num

			goutil.setActive(self._imgCostIcon.gameObject, true)
			goutil.setActive(self._txtCostCount.gameObject, true)
		else
			goutil.setActive(self._imgCostIcon.gameObject, false)
			goutil.setActive(self._txtCostCount.gameObject, false)
		end
	else
		goutil.setActive(self._imgCostIcon.gameObject, false)
		goutil.setActive(self._txtCostCount.gameObject, false)
	end

	local showWearBtn = self:getFirstParam()

	goutil.setActive(self._goUpgradeFixedPanel, not data:getIsMaxLevel() and not showWearBtn)
	goutil.setActive(self._goMaxLevelPanel, data:getIsMaxLevel() and not showWearBtn)
end

return M
