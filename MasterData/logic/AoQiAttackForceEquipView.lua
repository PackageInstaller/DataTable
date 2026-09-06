-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceEquipView.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceEquipView", package.seeall)

local AoQiAttackForceEquipView = class("AoQiAttackForceEquipView", ViewComponent)

function AoQiAttackForceEquipView:ctor()
	AoQiAttackForceEquipView.super.ctor(self)
end

function AoQiAttackForceEquipView:unbindEvents()
	AoQiAttackForceEquipView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnUse)
	GameUtil.rmClickHandler(self._btnUpgrade)
end

function AoQiAttackForceEquipView:bindEvents()
	AoQiAttackForceEquipView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnUse, self._onClickBtnUse, self)
	GameUtil.addClickHandler(self._btnUpgrade, self._onClickBtnUpgrade, self)
end

function AoQiAttackForceEquipView:buildUI()
	AoQiAttackForceEquipView.super.buildUI(self)

	self._txtTarget = self:getTxt("right/txtTarget")
	self._txtCD = self:getTxt("right/txtCD")
	self._txtHeal = self:getTxt("right/txtHeal")
	self._txtAtkRange = self:getTxt("right/txtAtkRange")
	self._txtHp = self:getTxt("right/txtHp")
	self._txtLv = self:getTxt("right/txtLv")
	self._txtName = self:getTxt("right/txtName")
	self._txtType = self:getTxt("right/txtType")
	self._txtAtk = self:getTxt("right/txtAtk")
	self._lvDescCellList = {}

	for i = 1, 5 do
		local cell = {}
		local path = "right/lvDesc/lv" .. i

		cell.txt = self:getTxt(path)
		cell.txtColorChange = cell.txt:GetComponent("UITextColorChange")
		self._lvDescCellList[i] = cell
	end

	self._upgrade = self:getGo("right/upgrade")
	self._iconCost = self:getGo("right/upgrade/cost/img")
	self._txtNumCost = self:getTxt("right/upgrade/cost/txtNum")
	self._btnUpgrade = self:getGo("right/upgrade/btn")
	self._txtBtnUpgrade = self:getTxt("right/upgrade/btn/txt")
	self._use = self:getGo("right/use")
	self._btnUse = self:getGo("right/use/btn")
	self._txtBtnUse = self:getTxt("right/use/btn/txt")
	self._txtTipsUse = self:getTxt("right/use/txtTips")

	local tableviewGo = self:getGo("tableview")
	local cellGo = self:getGo("tablecell")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("leftTop/btnClose")
	self._goldBarCon = self:getGo("goldBarCon")
end

function AoQiAttackForceEquipView:onExit()
	AoQiAttackForceEquipView.super.onExit(self)
	self._tableview:dispose()
	MaterialMgr.resetAll(self._iconCost)
end

function AoQiAttackForceEquipView:onEnter()
	AoQiAttackForceEquipView.super.onEnter(self)

	self._curSelectMo = nil
	self._curSelectId = nil
	self._params = self:getOpenParam()
	self._activityId = checknumber(self:getFirstParam())
	self._isOnlyShow = self._params[2]
	self._actCfg = AoQiAttackForceConfig.instance:getActivityCfg(self._activityId)

	self.addGEvent(self, GlobalNotify.AQAFGetInfoRes, self._updateInfo, self)
	self.addGEvent(self, GlobalNotify.AQAFEquipmentInfoUpdate, self._updateInfo, self)
	AoQiAttackForceController.instance:getInfo(self._activityId)

	local showCoins = {}

	for i = 1, 3 do
		local cfg = AoQiAttackForceConfig.instance:getChallengeCfg(self._activityId, i)
		local itemList = string.split(cfg.showPrize, "#")

		if not itemList[1] then
			local coinStr = ""
			local coinParam = string.split(coinStr, ":")
			local showCoinStr = coinParam[1] .. ":" .. coinParam[2]

			table.insert(showCoins, {
				showAdd = false,
				id = showCoinStr
			})
		end
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, showCoins)
end

function AoQiAttackForceEquipView:_updateInfo()
	self._curDataList = self:_getCurDataList()

	if not self._curSelectMo then
		self._curSelectMo = self._curDataList[1]
		self._curSelectId = self._curSelectMo.equipmentId
	end

	self:_updateSelectInfo()
end

function AoQiAttackForceEquipView:_getCurDataList()
	self._curUseNum = 0

	local curdataList = {}
	local baseInfo = AoQiAttackForceModel.instance:getBaseInfoByActId(self._activityId)

	if baseInfo then
		if not baseInfo.equipments then
			local equipInfos = {}

			for _, equipInfo in ipairs(equipInfos) do
				local data = {}

				data.isUsed = equipInfo.isUsed
				data.level = equipInfo.level
				data.equipmentId = equipInfo.equipmentId
				curdataList[data.equipmentId] = data

				if equipInfo.isUsed then
					self._curUseNum = self._curUseNum + 1
				end
			end

			local equipCfgs = AoQiAttackForceConfig.instance:getEquipmentCfgs(self._activityId)

			for _, cfg in ipairs(equipCfgs) do
				local temData = curdataList[cfg.equipmentId]

				if not temData then
					local data = {}

					data.isUsed = false
					data.level = 0
					data.equipmentId = cfg.equipmentId
					curdataList[cfg.equipmentId] = data
					temData = data
				end

				if temData.equipmentId == self._curSelectId then
					self._curSelectMo = temData
				end
			end

			if self._isOnlyShow then
				local onlyShowDatas = {}

				for _, data in pairs(curdataList) do
					if data.isUsed then
						table.insert(onlyShowDatas, data)
					end
				end

				curdataList = onlyShowDatas
			end

			table.sort(curdataList, function(a, b)
				if a.isUsed and not b.isUsed then
					return true
				elseif not a.isUsed and b.isUsed then
					return false
				else
					return a.level > b.level
				end
			end)
			self._tableview:reloadData(curdataList)

			return curdataList
		end
	end
end

function AoQiAttackForceEquipView:_updateSelectInfo()
	if self._curSelectMo then
		local equipId = self._curSelectMo.equipmentId
		local equipLv = self._curSelectMo.level
		local isUsed = self._curSelectMo.isUsed
		local toCfg = AoQiAttackForceConfig.instance:getEquipmentCfg(self._activityId, equipId)
		local equipCfg = AoQiAttackForceConfig.instance:getEquipmentUpgradeCfgByLv(self._activityId, equipId, equipLv == 0 and 1 or equipLv)
		local equipInGameId = toCfg.equipmentInGameId
		local equipInGameCfg = AoQiAttackForceConfig.instance:getEquipmentInGameCfg(equipInGameId, 1)
		local targetType = equipInGameCfg.targetType

		if targetType == AQAFGameEnum.WeaponTargetType.Last then
			self._txtTarget.text = "目标：最近敌人"
		elseif targetType == AQAFGameEnum.WeaponTargetType.Random then
			self._txtTarget.text = "目标：随机敌人"
		elseif targetType == AQAFGameEnum.WeaponTargetType.Player then
			self._txtAtk.text = "目标：自身"
		end

		self._txtCD.text = string.format("冷却：%sS", equipCfg.CD)

		goutil.setActive(self._txtHeal.gameObject, equipCfg.Heal > 0 or equipCfg.AddShield > 0)

		self._txtHeal.text = equipCfg.Heal > 0 and equipCfg.AddShield > 0 and string.format("回血：%s 护盾：%s", equipCfg.Heal, equipCfg.AddShield) or equipCfg.Heal > 0 and string.format("回血：%s", equipCfg.Heal) or equipCfg.AddShield > 0 and string.format("护盾：%s", equipCfg.AddShield) or ""

		goutil.setActive(self._txtAtkRange.gameObject, checknumber(equipInGameCfg.AtkRange) > 0)

		self._txtAtkRange.text = string.format("射程：%s", equipInGameCfg.AtkRange)

		goutil.setActive(self._txtHp.gameObject, equipCfg.MaxHP > 0)

		self._txtHp.text = string.format("血量：%s", equipCfg.MaxHP)
		self._txtLv.text = string.format("等级%s", equipLv)
		self._txtName.text = equipInGameCfg.name

		local equipType = equipInGameCfg.equipmentType

		if equipType == AQAFGameEnum.WeaponType.Physics then
			self._txtType.text = "物理"
		elseif equipType == AQAFGameEnum.WeaponType.Magic then
			self._txtType.text = "魔法"
		elseif equipType == AQAFGameEnum.WeaponType.Defense then
			self._txtType.text = "防具"
		end

		goutil.setActive(self._txtAtk.gameObject, equipCfg.Atk > 0)

		self._txtAtk.text = string.format("攻击：%s", equipCfg.Atk)

		local equipUpgradeCfgs = AoQiAttackForceConfig.instance:getEquipmentUpgradeCfgs(self._activityId, equipId)
		local posY = 0

		for i = 1, 5 do
			local cell = self._lvDescCellList[i]
			local upgradeCfg = equipUpgradeCfgs[i]

			if upgradeCfg then
				goutil.setActive(cell.txt.gameObject, true)
				GameUtil.setAnchoredPos(cell.txt.gameObject, 0, posY)

				cell.txt.text = upgradeCfg.desc

				local line = GameUtil.calculateTextLinesNum(cell.txt)

				if i <= equipLv then
					cell.txtColorChange:SetState(1)
				else
					cell.txtColorChange:SetState(0)
				end

				posY = posY - line * 21 - 3
			else
				goutil.setActive(cell.txt.gameObject, false)
			end
		end

		local lvMax = #equipUpgradeCfgs

		self._txtTipsUse.text = string.format("装备上阵限制：\n%s/%s", self._curUseNum, self._actCfg.useEquipmentLimit)

		if isUsed then
			self._txtBtnUse.text = "下阵"

			GameUtil.SetGray(self._btnUpgrade, false)
		else
			self._txtBtnUse.text = "上阵"

			GameUtil.SetGray(self._btnUpgrade, self._curUseNum >= self._actCfg.useEquipmentLimit)
		end

		if equipLv < lvMax then
			local costCfg = equipUpgradeCfgs[equipLv + 1]
			local costItem = costCfg.cost
			local matType, matId, matNum = MaterialMgr.getMatParams(costItem)

			MaterialMgr.setIcon(self._iconCost, matType, matId)
			GameUtil.SetGray(self._btnUpgrade, not MaterialMgr.getMatEnough(costItem))

			self._txtNumCost.text = string.format("%s/%s", MaterialModel.instance:getMaterialsNumber(matType, matId), matNum)
		else
			GameUtil.SetGray(self._btnUpgrade, false)
		end

		local unlockCfg = equipUpgradeCfgs[1]

		if equipLv == 0 then
			goutil.setActive(self._upgrade, true)
			goutil.setActive(self._use, false)

			local unlockCost = unlockCfg.cost

			self._txtBtnUpgrade.text = MaterialMgr.getMatEnough(unlockCost) and "可解锁" or "解锁"
		elseif equipLv == lvMax then
			goutil.setActive(self._upgrade, false)
			goutil.setActive(self._use, true)
		else
			goutil.setActive(self._upgrade, true)
			goutil.setActive(self._use, true)

			self._txtBtnUpgrade.text = "升级"
		end

		if self._isOnlyShow then
			goutil.setActive(self._upgrade, false)
			goutil.setActive(self._use, false)
		end
	end
end

function AoQiAttackForceEquipView:_updateCell(view, cell, data)
	local equipId = data.equipmentId
	local equipLv = data.level
	local isUsed = data.isUsed
	local equipCfg = AoQiAttackForceConfig.instance:getEquipmentCfg(self._activityId, equipId)
	local equipInGameId = equipCfg.equipmentInGameId
	local equipInGameCfg = AoQiAttackForceConfig.instance:getEquipmentInGameCfg(equipInGameId, 1)
	local txtLv = goutil.findChildTextComponent(cell, "txtLv")
	local maskUsed = goutil.findChild(cell, "mask")
	local showIcon = goutil.findChild(cell, "icon/Image")
	local cover = goutil.findChild(cell, "cover")
	local unlockTips = goutil.findChild(cell, "cover/unlockTips")
	local lock = goutil.findChild(cell, "cover/lock")
	local select = goutil.findChild(cell, "select")
	local shapeTypeGo = goutil.findChild(cell, "shapeType")

	for i = 1, shapeTypeGo.transform.childCount do
		local childGo = goutil.findChild(shapeTypeGo, "type_" .. i)

		goutil.setActive(childGo, i == equipInGameCfg.shapeType)
	end

	txtLv.text = string.format("等级%s", equipLv)

	goutil.setActive(maskUsed, isUsed)

	local picPath = AoQiAttackForceConfig.instance:getEquipmentInGameIconPath(equipInGameId)

	uGuiUtil.setSpriteToImage(showIcon.gameObject, uGuiUtil.SpriteType.BigBg, picPath, function()
		local img = showIcon.gameObject:GetComponent(goutil.Type_UIImage)

		img:SetNativeSize()

		img.raycastTarget = false
	end)
	goutil.setActive(cover, equipLv == 0)

	if equipLv == 0 then
		local costCfg = AoQiAttackForceConfig.instance:getEquipmentUpgradeCfgByLv(self._activityId, equipId, 1)
		local isEnough = MaterialMgr.getMatEnough(costCfg.cost)

		goutil.setActive(unlockTips, isEnough)
		goutil.setActive(lock, not isEnough)
	end

	goutil.setActive(select, self._curSelectMo == data)
	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onSelectEquip, self, data))
end

function AoQiAttackForceEquipView:_clearCell(cell)
	local showIcon = goutil.findChild(cell, "icon/Image")

	uGuiUtil.clearImage(showIcon)
	GameUtil.rmClickHandler(cell)
end

function AoQiAttackForceEquipView:_onClickBtnUse()
	if self._curSelectMo then
		local equipId = self._curSelectMo.equipmentId
		local isUsed = self._curSelectMo.isUsed
		local equipCfg = AoQiAttackForceConfig.instance:getEquipmentCfg(self._activityId, equipId)
		local equipInGameId = equipCfg.equipmentInGameId
		local equipInGameCfg = AoQiAttackForceConfig.instance:getEquipmentInGameCfg(equipInGameId, 1)

		if isUsed then
			AoQiAttackForceController.instance:adjustEquipment(self._activityId, equipId, not isUsed)
		elseif self._curUseNum >= self._actCfg.useEquipmentLimit then
			TipsFacade.instance:openCommonTips("已达上限")
		else
			AoQiAttackForceController.instance:adjustEquipment(self._activityId, equipId, not isUsed)
		end
	end
end

function AoQiAttackForceEquipView:_onClickBtnUpgrade()
	if self._curSelectMo then
		local equipId = self._curSelectMo.equipmentId
		local equipLv = self._curSelectMo.level
		local equipUpgradeCfgs = AoQiAttackForceConfig.instance:getEquipmentUpgradeCfgs(self._activityId, equipId)

		if equipLv < #equipUpgradeCfgs then
			local costCfg = equipUpgradeCfgs[equipLv + 1]
			local costItem = costCfg.cost
			local matType, matId, matNum = MaterialMgr.getMatParams(costItem)
			local addTips = equipLv == 0 and "解锁" or "升级"
			local content = langPara("花费%d%s%s该装备", matNum, MaterialMgr.getMaterialsName(matType, matId), addTips)

			TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
				AoQiAttackForceController.instance:upgradeEquipment(self._activityId, equipId)
			end)
		else
			TipsFacade.instance:openCommonTips("已满级")
			goutil.setActive(self._upgrade, false)
		end
	end
end

function AoQiAttackForceEquipView:_onSelectEquip(data)
	self._curSelectMo = data
	self._curSelectId = self._curSelectMo.equipmentId

	self:_updateSelectInfo()
	self._tableview:reloadData(self._curDataList)
end

return AoQiAttackForceEquipView
