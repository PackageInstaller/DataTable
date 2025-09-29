-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingModuleTipsView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingModuleTipsView", package.seeall)

local M = class("FacilityHoldingModuleTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnCloseBg = self:getBtn("facility_holding_module_tips_-1879196215")
	self._btnClose = self:getBtn("facility_holding_module_tips_619131737")
	self._txtTitle = self:getText("facility_holding_module_tips_-1289702923")
	self._txtName = self:getText("facility_holding_module_tips_1860839797")
	self._txtNameUnlock = self:getText("facility_holding_module_tips_2122265926")
	self._goLock = self:getGo("facility_holding_module_tips_1493673431")
	self._goUnLock = self:getGo("facility_holding_module_tips_-1375615140")
	self._txtDesc = self:getText("facility_holding_module_tips_1514100596")
	self._goPresureRoot = self:getGo("facility_holding_module_tips_1847485937")
	self._goDmgManageRoot = self:getGo("facility_holding_module_tips_2405988")
	self._goEchoEffectRoot = self:getGo("facility_holding_module_tips_742480090")
	self._goItemVal = self:getGo("facility_holding_module_tips_1799694684")
	self._btnUpgrade = self:getBtn("facility_holding_module_tips_239378463")
	self._goUpgradeMarkLock = self:getGo("facility_holding_module_tips_1788118982")
	self._goUpgradeMarkNormal = self:getGo("facility_holding_module_tips_3225006")
	self._txtUpgradeBtn = self:getText("facility_holding_module_tips_1814655346")
	self._goPriceRoot = self:getGo("facility_holding_module_tips_506612990")
	self._goPriceItem = self:getGo("facility_holding_module_tips_1351837771")
	self._imgPrice1 = self:getImage("facility_holding_module_tips_1073307964")
	self._txtPrice1 = self:getText("facility_holding_module_tips_2035161291")
	self._imgPrice2 = self:getImage("facility_holding_module_tips_1850186739")
	self._txtPrice2 = self:getText("facility_holding_module_tips_1811335847")
end

function M:destroyUI()
	self._guiAnimation = nil
	self._btnCloseBg = nil
	self._btnClose = nil
	self._txtTitle = nil
	self._txtName = nil
	self._txtNameUnlock = nil
	self._goLock = nil
	self._goUnLock = nil
	self._txtDesc = nil
	self._goPresureRoot = nil
	self._goDmgManageRoot = nil
	self._goEchoEffectRoot = nil
	self._goItemVal = nil
	self._goUpgradeMarkLock = nil
	self._goUpgradeMarkNormal = nil
	self._txtUpgradeBtn = nil
	self._goPriceRoot = nil
	self._goPriceItem = nil
end

function M:bindEvents()
	self._btnCloseBg:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnUpgrade:AddClickListener(self._onClickUpgrade, self)
end

function M:unbindEvents()
	self._btnCloseBg:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
end

function M:onEnter()
	self._cellAnimationLst = {}

	GlobalDispatcher:addEventListener(EventType.HOUSE_PROTOMER_INFO_CHANGE, self._handleHouseProtomerInfoChange, self)

	local info = self:getFirstParam()

	self._protomerId = info.protomerId
	self._moduleCode = info.moduleCode
	self._moduleId = info.moduleId
	self._moduleLockTyp = info.moduleLockTyp
	self._cfgModule = ContainmentConfig.instance:getHouseModelCoByCodeAndModule(self._moduleCode, self._moduleId)
	self._needModulePoint = self._cfgModule.modulePoint

	self:updateShow()
	self:updateBtnShow()
	self:updateTopCurrencyShow()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.HOUSE_PROTOMER_INFO_CHANGE, self._handleHouseProtomerInfoChange, self)
	ProtomerModel.instance:setCurSelectProtomerId(nil)

	self._protomerId = nil
	self._moduleId = nil
	self._moduleLockTyp = nil

	for _, value in pairs(self._cellAnimationLst or {}) do
		value:Stop()
	end

	self._cellAnimationLst = nil

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
end

function M:_handleHouseProtomerInfoChange()
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(self._protomerId)

	if protomerInfoMo:getIsModuleUpGrade(self._moduleId) then
		self._moduleLockTyp = ContainmentEnum.ModuleLockTyp.isUpgrade
	end

	self:updateShow()
	self:updateBtnShow()
	GlobalDispatcher:dispatchEvent(EventType.ITEM_MODEL_CHANGED_ANY)
end

function M:_onClickClose()
	self:close()
end

function M:_onClickUpgrade()
	if self._moduleLockTyp == ContainmentEnum.ModuleLockTyp.CanUpgrade then
		if self:_resEnoughToUpgrade() then
			ContainmentZoneAgent.instance:sendUpgradeProtomerModuleRequest(self._protomerId, self._moduleId)
		elseif self:_enoughRes() == false then
			FloatWordMgr.instance:show(lang("tip_materials_not_enough"))
		else
			FloatWordMgr.instance:show(lang("tip_house_protomer_point_not_enough"))
		end
	end
end

function M:updateShow()
	self._txtTitle.text = self._cfgModule.name
	self._txtName.text = self._cfgModule.name
	self._txtNameUnlock.text = self._cfgModule.name

	goutil.setActive(self._goLock, self._moduleLockTyp ~= ContainmentEnum.ModuleLockTyp.isUpgrade)
	goutil.setActive(self._goUnLock, self._moduleLockTyp == ContainmentEnum.ModuleLockTyp.isUpgrade)

	self._txtDesc.text = self._cfgModule.desc

	self:_updatePresureShow(self._protomerId)
	self:_updateDmgManageShow(self._protomerId)
	self:_updateEchoEffectShow(self._protomerId)
	self:_updateCostShow(self._moduleCode, self._moduleId)
end

function M:updateTopCurrencyShow()
	ProtomerModel.instance:setCurSelectProtomerId(self._protomerId)

	local showType = self._cfgModule.moduletyp == 1 and CommEnum.MoneyShowType.ProtomerModelUpgradeShowType2 or CommEnum.MoneyShowType.ProtomerModelUpgradeShowType3

	self:localNotify(EventType.UPDAET_TOP_MONEY_VIEW_SHOW, showType)
end

function M:_updateCostShow(moduleCode, moduleId)
	self._updateCost = {}

	table.insert(self._updateCost, {
		id = 0,
		num = self._needModulePoint
	})

	if self._cfgModule then
		for key, value in pairs(self._cfgModule.cost or {}) do
			table.insert(self._updateCost, {
				id = value.id,
				num = value.num
			})
		end
	else
		printError(string.format("无法找到升级模块配置，code[%d]id[%d]", moduleCode, moduleId))
	end

	local count = #self._updateCost
	local rootTrans = self._goPriceRoot.transform

	while count > rootTrans.childCount do
		goutil.cloneAndSetParent(self._goPriceItem, self._goPriceRoot.transform)
	end

	for i = 0, rootTrans.childCount - 1 do
		local tmpGo = rootTrans:GetChild(i).gameObject
		local show = i < count

		if show then
			local itemData = self._updateCost[i + 1]
			local itemId = itemData.id
			local imgIcon = goutil.findChildImageComponent(tmpGo, "imgIcon")
			local txtNum = goutil.findChildTextComponent(tmpGo, "txtValue")
			local enough = false

			if itemId > 0 then
				local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

				if itemCo then
					IconLoader.setSprite(imgIcon, IconType.ItemIcon, itemCo.icon)
				end

				local nowCount = ItemModel.instance:getItemCountByItemId(itemId)

				enough = nowCount >= itemData.num
			else
				local itemCo = BackpackConfig.instance:getItemInfoByItemId(CommEnum.CurrencyCodeEnum.ProtomerModulePointCode)

				if itemCo then
					IconLoader.setSprite(imgIcon, IconType.ItemIcon, itemCo.icon)
				end

				enough = self:_enoughMoudlePoint()
			end

			txtNum.text = enough and itemData.num or string.format("<color=#ff3e48>%d</color>", itemData.num)
		end

		goutil.setActive(tmpGo, show)
	end
end

function M:updateBtnShow()
	if self._moduleLockTyp == ContainmentEnum.ModuleLockTyp.Lock then
		goutil.setActive(self._goUpgradeMarkLock, true)
		goutil.setActive(self._goUpgradeMarkNormal, false)

		self._txtUpgradeBtn.text = lang("tip_activate")
	elseif self._moduleLockTyp == ContainmentEnum.ModuleLockTyp.CanUpgrade then
		goutil.setActive(self._goUpgradeMarkLock, false)
		goutil.setActive(self._goUpgradeMarkNormal, true)

		self._txtUpgradeBtn.text = lang("tip_activate")
	else
		goutil.setActive(self._goUpgradeMarkLock, true)
		goutil.setActive(self._goUpgradeMarkNormal, false)

		self._txtUpgradeBtn.text = lang("tip_already_activate")
	end
end

function M:_resEnoughToUpgrade()
	return self:_enoughMoudlePoint() and self:_enoughRes()
end

function M:_enoughMoudlePoint()
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(self._protomerId)
	local curNum = protomerInfoMo:getModulePoint()

	return curNum >= self._needModulePoint
end

function M:_enoughRes()
	local enough = true

	if self._cfgModule then
		for key, value in pairs(self._cfgModule.cost or {}) do
			local nowCount = ItemModel.instance:getItemCountByItemId(value.id)

			if nowCount < value.num then
				enough = false

				break
			end
		end
	else
		printError(string.format("无法找到升级模块配置，code[%d]id[%d]", self._moduleCode, self._moduleId))

		enough = true
	end

	return enough
end

function M:_updatePresureShow(protomerId)
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)
	local valDefault = protomerInfoMo:getPressureLimitCfgDefault()
	local valLimitMax = protomerInfoMo:getPressureLimitCfgMax()
	local valNow = protomerInfoMo:getPressureLimitEnhance()
	local rootTrans = self._goPresureRoot.transform
	local increaseNum = 0

	increaseNum = ContainmentUtil.moduleEnhanceFunc(increaseNum, ContainmentEnum.ModuleEnhanceEffId.PresureMaxUpGrade, self._cfgModule.effect1, self._cfgModule.param1)
	increaseNum = ContainmentUtil.moduleEnhanceFunc(increaseNum, ContainmentEnum.ModuleEnhanceEffId.PresureMaxUpGrade, self._cfgModule.effect2, self._cfgModule.param2)

	local highLightLst, weakenLst = self:_calculateEnhance(increaseNum, valNow)

	self:_duelItemProcess(rootTrans, valNow, valLimitMax, highLightLst, weakenLst)
end

function M:_updateDmgManageShow(protomerId)
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)
	local valDefault = protomerInfoMo:getDmgManageLimitCfgDefault()
	local valLimitMax = protomerInfoMo:getDmgManageLimitCfgMax()
	local valNow = protomerInfoMo:getDmgManageLimitEnhance()
	local rootTrans = self._goDmgManageRoot.transform
	local increaseNum = 0

	increaseNum = ContainmentUtil.moduleEnhanceFunc(increaseNum, ContainmentEnum.ModuleEnhanceEffId.DmgManageMaxUpGrade, self._cfgModule.effect1, self._cfgModule.param1)
	increaseNum = ContainmentUtil.moduleEnhanceFunc(increaseNum, ContainmentEnum.ModuleEnhanceEffId.DmgManageMaxUpGrade, self._cfgModule.effect2, self._cfgModule.param2)

	local highLightLst, weakenLst = self:_calculateEnhance(increaseNum, valNow)

	self:_duelItemProcess(rootTrans, valNow, valLimitMax, highLightLst, weakenLst)
end

function M:_updateEchoEffectShow(protomerId)
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)
	local valDefault = protomerInfoMo:getEchoEffLimitCfgDefault()
	local valLimitMax = protomerInfoMo:getEchoEffLimitCfgMax()
	local valNow = protomerInfoMo:getEchoEffLimitEnhance()
	local rootTrans = self._goEchoEffectRoot.transform
	local increaseNum = 0

	increaseNum = ContainmentUtil.moduleEnhanceFunc(increaseNum, ContainmentEnum.ModuleEnhanceEffId.EchoEffMaxUpGrade, self._cfgModule.effect1, self._cfgModule.param1)
	increaseNum = ContainmentUtil.moduleEnhanceFunc(increaseNum, ContainmentEnum.ModuleEnhanceEffId.EchoEffMaxUpGrade, self._cfgModule.effect2, self._cfgModule.param2)

	local highLightLst, weakenLst = self:_calculateEnhance(increaseNum, valNow)

	self:_duelItemProcess(rootTrans, valNow, valLimitMax, highLightLst, weakenLst)
end

function M:_calculateEnhance(increaseNum, valNow, highLightLst, weakenLst)
	local highLightLst = {}
	local weakenLst = {}

	if increaseNum < 0 then
		for i = valNow, valNow + increaseNum + 1, -1 do
			weakenLst[i - 1] = 1
		end
	elseif increaseNum > 0 then
		if self._moduleLockTyp == ContainmentEnum.ModuleLockTyp.isUpgrade then
			for i = valNow, valNow - increaseNum + 1, -1 do
				highLightLst[i - 1] = 1
			end
		else
			for i = valNow + 1, valNow + increaseNum do
				highLightLst[i - 1] = 1
			end
		end
	end

	return highLightLst, weakenLst
end

function M:_duelItemProcess(rootTrans, valDefault, valLimitMax, highLightLst, weakenLst)
	while valLimitMax > rootTrans.childCount do
		goutil.cloneAndSetParent(self._goItemVal, rootTrans)
	end

	for i = 0, rootTrans.childCount - 1 do
		local show = i < valLimitMax
		local isDefault = i < valDefault
		local isEnhance = highLightLst[i] ~= nil
		local isWeaken = weakenLst[i] ~= nil
		local tempGo = rootTrans:GetChild(i).gameObject

		if show then
			local goDefault = goutil.findChild(tempGo, "startValue")
			local goEnhance = goutil.findChild(tempGo, "up").gameObject
			local goWeaken = goutil.findChild(tempGo, "down").gameObject

			goutil.setActive(goDefault, isDefault)
			goutil.setActive(goEnhance, isEnhance)
			goutil.setActive(goWeaken, isWeaken)

			if isEnhance then
				local aniEnhance = goEnhance:GetComponent(ComponentType.Animation)

				aniEnhance:Play("up_loop")

				self._cellAnimationLst[goEnhance:GetInstanceID()] = aniEnhance
			end

			if isWeaken then
				local aniWeaken = goEnhance:GetComponent(ComponentType.Animation)

				aniWeaken:Play("up_loop")

				self._cellAnimationLst[goEnhance:GetInstanceID()] = aniWeaken
			end
		end

		goutil.setActive(tempGo, show)
	end
end

return M
