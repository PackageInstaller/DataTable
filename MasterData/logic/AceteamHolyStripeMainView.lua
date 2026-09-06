-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamHolyStripeMainView.lua

module("logic.extensions.aceteam.view.petshow.AceteamHolyStripeMainView", package.seeall)

local AceteamHolyStripeMainView = class("AceteamHolyStripeMainView", ViewComponent)

AceteamHolyStripeMainView.HolyStripePosition = {
	{
		rotate = 90,
		x = -42.2,
		y = -203.9
	},
	{
		rotate = 45,
		x = 6.7,
		y = -75.7
	},
	{
		rotate = 0,
		x = 137.1,
		y = -27.9
	},
	{
		rotate = -45,
		x = 266.7,
		y = -76.8
	},
	{
		rotate = -90,
		x = 316.4,
		y = -204.1
	}
}

function AceteamHolyStripeMainView:ctor()
	AceteamHolyStripeMainView.super.ctor(self)
end

function AceteamHolyStripeMainView:buildUI()
	AceteamHolyStripeMainView.super.buildUI(self)

	self._tableView = self:getGo("rightRoot/attrRoot/tableview")
	self._tableCell = self:getGo("rightRoot/attrRoot/tablecell")
	self._suitIcon = self:getGo("rightRoot/attrRoot/attrIcon")
	self._suitDesc = self:getTxt("rightRoot/attrRoot/txtDesc")
	self._changeBtnGo = self:getGo("rightRoot/changeBtn")
	self._changeBtn = self:getBtn("rightRoot/changeBtn")
	self._changeBtnIcon = self:getImg("rightRoot/changeBtn")
	self._suitPreviewBtn = self:getBtn("rightRoot/suitPreviewBtn")
	self._recommenItemCon = self:getGo("rightRoot/txtRecommen")
	self._txtRecommen = self:getTxt("rightRoot/txtRecommen")
	self._backEffectGo = self:getGo("rightRoot/bgEffect")
	self._lineEffectGo = self:getGo("rightRoot/suitEffect")
	self._effectBgGo = self:getGo("rightRoot")
	self._effectBgRt = self:getGo("rightRoot"):GetComponent(goutil.Type_RectTransform)
	self._oneKeyTakeOffBtn = self:getBtn("rightRoot/oneKeyTakeoffBtn")

	self:_buildEquipItems()

	self._attrScrollList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updataCell, self), GameUtil.handler(self._clearCell, self))
	self._suitChangeGo = self:getGo("suitFitlerRoot")
	self._tipGo = self:getGo("content")
	self._changeTip = self:getGo("rightRoot/txtChangeTip")
	self._changeTipImg = self:getGo("rightRoot/txtChangeTip/txt/img")
	self._changeTipTxt = self:getTxt("rightRoot/txtChangeTip/txt")
end

function AceteamHolyStripeMainView:_buildEquipItems()
	local equipCell = self:getGo("rightRoot/equipRoot/cell1")
	local equipRoot = self:getGo("rightRoot/equipRoot")

	self._equipItems = {}

	local goList = {
		equipCell
	}

	for i = 2, 5 do
		goList[i] = goutil.cloneAndSetParent(equipCell, equipRoot.transform, "cell" .. i)
	end

	for i, go in ipairs(goList) do
		local btn = Framework.ButtonAdapter.GetFrom(go, "raycast")
		local icon = goutil.findChild(go, "icon")
		local lvText = goutil.findChildTextComponent(go, "lvText")
		local nameText = goutil.findChildTextComponent(go, "nameText")
		local effect = goutil.findChild(go, "effect")
		local redpoint = goutil.findChild(go, "redpoint")
		local select = goutil.findChild(go, "select")
		local quality = goutil.findChild(go, "quality")
		local qualityUIChange = goutil.findChildComponent(go, "quality", "UIImageSpriteChange")

		self._equipItems[i] = {
			btn = btn,
			icon = icon,
			lvText = lvText,
			effect = effect,
			nameText = nameText,
			redPoint = redpoint,
			select = select,
			quality = quality,
			qualityUIChange = qualityUIChange
		}

		local pos = AceteamHolyStripeMainView.HolyStripePosition[i]

		GameUtil.setAnchoredPos(go, pos.x, pos.y)

		if select then
			Framework.TransformUtil.SetLocalRotation(select.transform, 0, 0, pos.rotate)
		end

		if quality then
			Framework.TransformUtil.SetLocalRotation(quality.transform, 0, 0, pos.rotate)
		end
	end
end

function AceteamHolyStripeMainView:bindEvents()
	AceteamHolyStripeMainView.super.bindEvents(self)
	self._changeBtn:AddClickListener(self._onChangeBtnClick, self)
end

function AceteamHolyStripeMainView:unbindEvents()
	AceteamHolyStripeMainView.super.unbindEvents(self)
	self._changeBtn:RemoveClickListener()
end

function AceteamHolyStripeMainView:onEnter()
	AceteamHolyStripeMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_GETINFO, self._updataView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_PETCHANGE, self._updataView, self)
	GlobalDispatcher:addListener(GlobalNotify.AceteamHolyStripeSuitTryChange, self._updataView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_HOLYSTRIPE_CHANGE, self._PM_ACETEAM_HOLYSTRIPE_CHANGE, self)
	self.addGEvent(self, GlobalNotify.PM_ACETEAM_HOLYSTRIPE_LEVELUP, self._handlerLevelUp, self)

	self._backEffectPath = "20220701/zhihuijitan/fx_ui_zhjt_lwth.prefab"
	self._backEffectHandler = UIEffectManager.instance:playEffect(self, self._backEffectPath, nil, 0, 0, true, nil, nil, function()
		self._backEffectHandler:setClipping(self._effectBgRt)
	end)
	self._shineEffect = {}

	self._backEffectHandler:setParent(self._backEffectGo.transform)
	self._backEffectHandler:setLocalPos(0, 0, 0)
	self._backEffectHandler:setScale(1)
	self:_initView()
	self._tableCell:SetActive(false)
	self:_updataView()
end

function AceteamHolyStripeMainView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_GETINFO, self._updataView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_PETCHANGE, self._updataView, self)
	GlobalDispatcher:removeListener(GlobalNotify.AceteamHolyStripeSuitTryChange, self._updataView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_HOLYSTRIPE_CHANGE, self._PM_ACETEAM_HOLYSTRIPE_CHANGE, self)
	self:_resetEquipItems()
	UIEffectManager.instance:stopEffect(self._backEffectHandler)
	UIEffectManager.instance:stopEffect(self._lineEffect)

	for i, v in pairs(self._shineEffect) do
		UIEffectManager.instance:stopEffect(v)
	end

	MaterialMgr.resetAll(self._suitIcon)
	uGuiUtil.clearImage(self._suitIcon)
	MaterialMgr.resetAll(self._changeTipImg)
end

function AceteamHolyStripeMainView:_initView()
	MaterialMgr.resetAll(self._changeTipImg)
	MaterialMgr.setIcon(self._changeTipImg, MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)

	local changeCost = AceTeamConfig.instance:getCommonValue("CHANGE_HOLY_STRIPE_SUIT_COST", true)

	self._changeTipTxt.text = langPara("%d", changeCost)
end

function AceteamHolyStripeMainView:_updataView(suitId)
	self.petMo = AceTeamModel.instance:getCurrPetMo()

	if self.petMo then
		self:_setEquipItems(suitId)
		self:_showSuit(suitId)
		self:_refreshAllAttr(suitId)
		GameUtil.SetActive(self._changeTip, false)

		if suitId and suitId ~= self.petMo.holyStripeSuitId then
			GameUtil.SetActive(self._changeTip, true)
		end
	else
		GameUtil.SetActive(self._changeTip, false)
	end
end

function AceteamHolyStripeMainView:_setEquipItems(suitId)
	for i, v in ipairs(self._equipItems) do
		v.lvText.text = ""
		v.nameText.text = ""

		v.btn:RemoveClickListener()
		v.btn:AddClickListener(function()
			self:_onChangeBtnClick()
		end)
		goutil.setActive(v.icon, false)
		goutil.setActive(v.quality, false)
		uGuiUtil.clearImage(v.icon)

		if v.select then
			goutil.setActive(v.select, false)
		end
	end

	if not suitId and self.petMo.holyStripeSuitId <= 0 then
		return
	end

	local suitCfg = AceTeamConfig.instance:getHolyStripeSuitCfg(suitId or self.petMo.holyStripeSuitId)

	for i, v in ipairs(self.petMo.holyStripeSlots or {}) do
		local iconGo = self._equipItems[v.positionId].icon
		local quality = self._equipItems[v.positionId].quality
		local qualityUIChange = self._equipItems[v.positionId].qualityUIChange
		local slotCfg = AceTeamConfig.instance:getHolyStripeCfg(v.positionId, v.level)

		self._equipItems[v.positionId].lvText.text = slotCfg and slotCfg.showLevel > 0 and "Lv." .. slotCfg.showLevel or ""

		local stripeCfg = HolyStripeConfig.instance:getHolyStripeCfg(suitCfg.cfgIds[v.positionId])
		local color

		_, color = PetEquipController:GetQualityStrByNum(stripeCfg.quality)
		self._equipItems[v.positionId].nameText.text = langPara("<color=%s>%s</color>", color, stripeCfg.name)

		goutil.setActive(quality, true)
		qualityUIChange:SetState(stripeCfg.quality)
		MaterialMgr.setIcon(iconGo, MatType.HolyStripe, stripeCfg.id)
		goutil.setActive(iconGo, true)
		self._equipItems[v.positionId].btn:RemoveClickListener()
		goutil.setActive(self._equipItems[v.positionId].redPoint, false)
		self._equipItems[v.positionId].btn:AddClickListener(function()
			self:_onItemBtnClick(v.positionId, v.level, suitId or self.petMo.holyStripeSuitId, true)
		end)
	end
end

function AceteamHolyStripeMainView:_resetEquipItems()
	for i, item in ipairs(self._equipItems) do
		item.btn:RemoveClickListener()
		uGuiUtil.clearImage(item.icon)
		MaterialMgr.resetAll(item.icon)
	end
end

function AceteamHolyStripeMainView:_showSuit(suitId)
	local suitCfg = AceTeamConfig.instance:getHolyStripeSuitCfg(suitId or self.petMo.holyStripeSuitId)

	self._suitDesc.text = ""

	if suitCfg then
		goutil.setActive(self._suitIcon, true)
		uGuiUtil.clearImage(self._suitIcon)
		uGuiUtil.setSpriteToImage(self._suitIcon, nil, GameUrl.getItemIconUrl(suitCfg.suitIcon))

		self._suitDesc.text = suitCfg.suitDesc
	else
		goutil.setActive(self._suitIcon, false)

		self._suitDesc.text = lang("未激活套装4件套效果")
	end
end

function AceteamHolyStripeMainView:_refreshAllAttr(suitId)
	local attrs = AceTeamModel.instance:calcByHolyStripeAttrs(self.petMo.holyStripeSlots, suitId)
	local res = {}

	if #attrs == 0 then
		for i, v in ipairs(HolyStripeModel.DefaultAttr) do
			table.insert(res, {
				value = 0,
				type = v,
				name = ConstString.Attr[v]
			})
		end
	else
		for i, v in pairs(attrs) do
			table.insert(res, {
				type = i,
				value = v,
				name = ConstString.Attr[i]
			})
		end

		table.sort(res, function(a, b)
			return a.type > b.type
		end)
	end

	self._attrScrollList:reloadData(res)
end

function AceteamHolyStripeMainView:_onItemBtnClick(posType, level, suitId, equip)
	if checknumber(suitId) ~= 0 then
		UIStateManager.instance:push(ViewName.AceteamHolyStripeTipView, posType, level, suitId, equip)
	end
end

function AceteamHolyStripeMainView:_onChangeBtnClick()
	GlobalDispatcher:dispatch(GlobalNotify.AceteamHolyStripeSuitOpen, self.petMo.holyStripeSuitId)
end

function AceteamHolyStripeMainView:_updataCell(view, cell, data, tag)
	local go = cell.gameObject
	local nameTxt = goutil.findChildTextComponent(go, "nameText")
	local valueTxt = goutil.findChildTextComponent(go, "valueText")
	local iconGo = goutil.findChild(go, "attr")
	local icon = goutil.findChildComponent(go, "attr", "UIImageSpriteChange")

	if data.type then
		goutil.setActive(iconGo, true)
		icon:SetState(data.type - 1)
	else
		goutil.setActive(iconGo, false)
	end

	valueTxt.text = data.value > 0 and data.value < 1 and string.format("%s%%", data.value * 100) or data.value
	nameTxt.text = data.name
end

function AceteamHolyStripeMainView:_clearCell(cell)
	return
end

function AceteamHolyStripeMainView:_PM_ACETEAM_HOLYSTRIPE_CHANGE()
	if self.petMo.holyStripeSuitId > 0 then
		for i, v in ipairs(self.petMo.holyStripeSlots) do
			if v.level == 0 then
				AceTeamAgent.instance:sendPM_AceTeamHolyStripeLevelUpReq(self.petMo.petId, v.positionId)
			end
		end
	end

	self:_showEquipSuitEffect()
end

function AceteamHolyStripeMainView:_checkLevel()
	if self.petMo.holyStripeSuitId > 0 then
		for i, v in ipairs(self.petMo.holyStripeSlots) do
			if v.level == 0 then
				AceTeamAgent.instance:sendPM_AceTeamHolyStripeLevelUpReq(self.petMo.petId, v.positionId)
			end
		end
	end
end

function AceteamHolyStripeMainView:_showEquipSuitEffect()
	local shinePath = "20220701/zhihuijitan/fx_ui_wxwl_lwth_shangguang.prefab"
	local linePath = "20220701/zhihuijitan/fx_ui_wxwl_lwth_ljguangtiao.prefab"

	for j, k in ipairs(self._equipItems) do
		if self._shineEffect[j] then
			UIEffectManager.instance:stopEffect(self._shineEffect[j])

			self._shineEffect[j] = nil
		end

		self._shineEffect[j] = UIEffectManager.instance:playEffect(self, shinePath, nil, 0, 0, false, nil, nil, function()
			self._shineEffect[j]:setClipping(self._gRootRt)
		end)

		self._shineEffect[j]:setParent(k.effect.transform)
		self._shineEffect[j]:setLocalPos(0, 0, 0)
		self._shineEffect[j]:setScale(1)
	end

	if self._lineEffect then
		UIEffectManager.instance:stopEffect(self._lineEffect)

		self._lineEffect = nil
	end

	self._lineEffect = UIEffectManager.instance:playEffect(self, linePath, nil, 0, 0, false, nil, nil, function()
		self._lineEffect:setClipping(self._gRootRt)
	end)

	self._lineEffect:setParent(self._lineEffectGo.transform)
	self._lineEffect:setLocalPos(0, 0, 0)
	self._lineEffect:setScale(1.1)
end

function AceteamHolyStripeMainView:_handlerLevelUp()
	self:_updataView()
	self:_checkLevel()
end

return AceteamHolyStripeMainView
