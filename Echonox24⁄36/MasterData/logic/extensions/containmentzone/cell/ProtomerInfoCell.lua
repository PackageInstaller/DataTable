-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/ProtomerInfoCell.lua

module("logic.extensions.containmentzone.cell.ProtomerInfoCell", package.seeall)

local M = class("ProtomerInfoCell", UIReusableLuaBehavior)

function M:buildUI()
	self._txtTitleCh = goutil.findChildTextComponent(self.mainGO, "smallTitle/txtTitle2")
	self._txtTitleEn = goutil.findChildTextComponent(self.mainGO, "smallTitle/txtTitle1")
	self._rectTransRecord = goutil.findChildComponent(self.mainGO, "Record", goutil.Type_RectTransform)
	self._goTxtItem = goutil.findChild(self.mainGO, "Record/txtRecord_1")
	self._rectTransLayout = goutil.findChildComponent(self.mainGO, "layout", goutil.Type_RectTransform)
	self._goLayOutItem = goutil.findChild(self.mainGO, "layout/preference_item")
end

function M:destroyUI()
	self._txtTitleCh = nil
	self._txtTitleEn = nil
	self._rectTransRecord = nil
	self._goTxtItem = nil
	self._rectTransLayout = nil
	self._goLayOutItem = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	self:_clearCreateCell()

	self._cellCreate = nil
end

function M:setData(protomerId, theTyp, infoData, handler)
	local typ = theTyp
	local protomerMo = ProtomerModel.instance:getProtomerInfo(protomerId)
	local itemLst = infoData
	local count = infoData and #infoData or 0

	self._txtTitleCh.text = ContainmentUtil.getProtomerInfoTitle(typ, true)
	self._txtTitleEn.text = ContainmentUtil.getProtomerInfoTitle(typ, false)

	self:_clearCreateCell()

	if count > 0 then
		for key, value in pairs(infoData) do
			local id = value.item
			local isUnLock = protomerMo and protomerMo:isIntelligenceUnlock(id) or false

			if value.condition == ContainmentEnum.ProtomerInfoUnlockCondition.Default then
				isUnLock = true
			end

			if isUnLock then
				if typ == ContainmentEnum.ProtomerInfoMsgTyp.AttrPreference then
					self:_createAttrPreferenceShow(value, protomerId)
				else
					self:_createTxtContentShow(value)
				end
			else
				self:_createLockShow(value)
			end
		end
	end
end

function M:_clearCreateCell()
	if self._cellCreate then
		for key, value in pairs(self._cellCreate) do
			UnityEngine.GameObject.Destroy(value.gameObject)
		end
	end

	self._cellCreate = {}
end

function M:_createAttrPreferenceShow(infoData, protomerId)
	local cfgInfo = ContainmentConfig.instance:getProtomerInfoById(protomerId)

	if not cfgInfo then
		return
	end

	local len = cfgInfo.preferen and #cfgInfo.preferen or 0

	if len == 0 then
		return
	end

	local like = tonumber(infoData.content) == 1
	local likeTyp = cfgInfo.preferen[1]
	local hateTyp = cfgInfo.preferen[2] or 0

	if not like and hateTyp == 0 then
		return
	end

	local typId = like and likeTyp or hateTyp
	local cfgPreferen = ContainmentConfig.instance:getPreferenCfg(typId)

	if not cfgPreferen then
		return
	end

	local tmpGo = goutil.cloneAndSetParent(self._goLayOutItem, self._rectTransLayout)
	local goTyp1 = goutil.findChild(tmpGo.gameObject, "type1").gameObject
	local goTyp2 = goutil.findChild(tmpGo.gameObject, "type2").gameObject
	local imgAttrIcon = goutil.findChildImageComponent(goTyp1, "txtPreference/imgIcon")
	local txtAttrName = goutil.findChildTextComponent(goTyp1, "txtPreference")

	if like then
		txtAttrName.text = string.format("<color=#65ABA2>%s%s</color>", lang("tip_like"), cfgPreferen.nameattr or "")
	else
		txtAttrName.text = string.format("<color=#C15056>%s%s</color>", lang("tip_hate"), cfgPreferen.nameattr or "")
	end

	IconLoader.setSprite(imgAttrIcon, IconType.DynSpriteAtlas_Room, cfgPreferen.iconattr)

	self._cellCreate[tmpGo:GetInstanceID()] = tmpGo

	goutil.setActive(goTyp1, true)
	goutil.setActive(goTyp2, false)
	goutil.setActive(tmpGo, true)
end

function M:_createTxtContentShow(infoData)
	local tmpGo = goutil.cloneAndSetParent(self._goTxtItem, self._rectTransRecord)
	local txtContent = goutil.findChildTextComponent(tmpGo, "")

	txtContent.text = infoData.content
	self._cellCreate[tmpGo:GetInstanceID()] = tmpGo

	goutil.setActive(tmpGo, true)
end

function M:_createLockShow(infoData)
	local tmpGo = goutil.cloneAndSetParent(self._goLayOutItem, self._rectTransLayout)
	local goTyp1 = goutil.findChild(tmpGo.gameObject, "type1").gameObject
	local goTyp2 = goutil.findChild(tmpGo.gameObject, "type2").gameObject
	local txtUnlock = goutil.findChildTextComponent(goTyp2, "txtLock")
	local requirePoint = infoData.param
	local _condition = ContainmentEnum.ProtomerInfoUnlockCondition

	if infoData.condition == _condition.ByLevel then
		txtUnlock.text = string.format(lang("tip_protomer_info_unlock_hint_1"), requirePoint)
	elseif infoData.condition == _condition.ByPoint then
		txtUnlock.text = string.format(lang("tip_protomer_info_unlock_hint_2"), requirePoint)
	elseif infoData.condition == _condition.ByFinishReport then
		txtUnlock.text = string.format(lang("tip_protomer_info_unlock_hint_3"), requirePoint)
	elseif infoData.condition == _condition.ByFailReport then
		txtUnlock.text = string.format(lang("tip_protomer_info_unlock_hint_4"), requirePoint)
	end

	self._cellCreate[tmpGo:GetInstanceID()] = tmpGo

	goutil.setActive(goTyp1, false)
	goutil.setActive(goTyp2, true)
	goutil.setActive(tmpGo, true)
end

return M
