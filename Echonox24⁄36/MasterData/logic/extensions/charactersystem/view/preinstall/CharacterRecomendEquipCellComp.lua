-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/CharacterRecomendEquipCellComp.lua

module("logic.extensions.charactersystem.view.preinstall.CharacterRecomendEquipCellComp", package.seeall)

local M = class("CharacterRecomendEquipCellComp", RewardCellComp)

function M:_clickSelect()
	if self._itemCode == 0 then
		return
	end

	if self._clickCallBackFunc then
		local ifContinue = self._clickCallBackFunc(self._clickCallBackObj, self._index)

		if not ifContinue then
			return
		end
	end

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_select, nil, nil, nil)

	local count = ItemModel.instance:getItemCountByItemId(self._itemCode)
	local itemData = ItemUtil.createItemData({
		itemId = self._itemCode
	})

	itemData:setCount(count)

	local data = ToolTipsUtil.createFackItemTipsData(itemData, self._itemGo, true)

	if self._fackRecommendD6 then
		local fackAttLst = {}
		local fackStrSplit = string.split(self._fackRecommendD6, "\r\n")

		if fackStrSplit[1] ~= "" then
			for k, v in ipairs(fackStrSplit) do
				local temp = {}

				temp.itemId = 2501006
				temp.attrs = {
					{
						diceAttrId = 111,
						level = 0,
						fackAttrType = EquipEnum.FackAttrType.Recommended,
						fackRecommendD6 = v
					}
				}
				temp.effectIndex = k
				temp.effectFace = 1
				fackAttLst[k] = temp
			end
		end

		data.baseData:setDiceAttr(false)
		data.baseData:setFackD6(fackAttLst)
	end

	if ItemUtil.isCharacterById(self._itemCode) then
		CharacterUtil.openCharacterPreviewView(self._itemCode)
	else
		ToolTipsMgr.showTips(data.viewName, data)
	end
end

function M:updateData(data)
	M.super.updateData(self, data)

	self._fackRecommendD6 = data.fackRecommendD6

	local itemData = ItemUtil.createItemData({
		itemId = self._itemCode
	})

	self._levelText.text = itemData:getMaxLevel()

	goutil.setActive(self._level, true)
end

return M
