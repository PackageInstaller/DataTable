-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/componentNew/EquipLvUpDetailInfoComponentNew.lua

module("logic.extensions.charactersystem.view.equip.componentNew.EquipLvUpDetailInfoComponentNew", package.seeall)

local M = class("EquipLvUpDetailInfoComponentNew", EquipDetailInfoComponentNew)
local kAttributeMaxNum = 2

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()

	self._lvEffectGo = self:getGo("backpack_equip_detail_tips_copy_1391818441")

	goutil.setActive(self._lvEffectGo, false)
end

function M:bindEvents()
	M.super.bindEvents(self)
	self._btnLvUp:AddClickListener(self._onClickLvUp, self)
end

function M:unbindEvents()
	M.super.unbindEvents(self)
	self._btnLvUp:RemoveClickListener()
	goutil.setActive(self._lvEffectGo, false)
	removetimer(self._showLvUpGo, self)
	removetimer(self._hideLvUpGo, self)
end

function M:_onClickLvUp()
	ViewMgr.instance:open(ViewName.EquipUpgradeView)
end

function M:refreshView()
	M.super.refreshView(self)

	local isMax = self._equipMo:isMaxLv()

	goutil.setActive(self._btnLvUp.gameObject, not isMax)
	goutil.setActive(self._lvMaxGo, isMax)
end

function M:_refreshSuitInfo()
	goutil.setActive(self._suitContentGo, false)
	goutil.setActive(self._suitLineGo, false)
end

function M:_refreshAttrInfo()
	local attrList = self._equipMo:getAttrList()

	for i = 1, kAttributeMaxNum do
		goutil.setActive(self._attributeRootList[i], i <= #attrList)

		if i <= #attrList then
			self._attributeTxtList[i].text = attrList[i]:getName()
			self._attrNumTxtList[i].text = attrList[i]:getValue()
		end
	end

	goutil.setActive(self._d6LineGo, false)
	goutil.setActive(self._d6AttrParent, false)
end

function M:playeLvUpEffect()
	goutil.setActive(self._lvEffectGo, false)
	removetimer(self._showLvUpGo, self)
	removetimer(self._hideLvUpGo, self)
	settimer(0, self._showLvUpGo, self, false)
	settimer(2, self._hideLvUpGo, self, false)
end

function M:_showLvUpGo()
	goutil.setActive(self._lvEffectGo, true)
end

function M:_hideLvUpGo()
	goutil.setActive(self._lvEffectGo, false)
end

return M
