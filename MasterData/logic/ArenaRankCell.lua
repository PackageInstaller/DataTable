-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaRankCell.lua

module("logic.extensions.arena.view.ArenaRankCell", package.seeall)

local ArenaRankCell = class("ArenaRankCell")
local LuaComponentContainer = Framework.LuaComponentContainer

function ArenaRankCell.AddOnce(go)
	local component = ArenaRankCell.Get(go)

	component = component or LuaComponentContainer.Add(go, ArenaRankCell)

	return component
end

function ArenaRankCell.Remove(go)
	LuaComponentContainer.Remove(go, ArenaRankCell)
end

function ArenaRankCell.Get(go)
	return (LuaComponentContainer.Get(go, ArenaRankCell))
end

function ArenaRankCell:ctor(container)
	self._container = container
	self._cellData = nil
end

function ArenaRankCell:initCell(cellData)
	self._cellData = cellData
	self._txtRank = goutil.findChildTextComponent(self._container, "TxtRank")
	self._TxtArea = goutil.findChildTextComponent(self._container, "TxtArea")
	self._Btn_Get = goutil.findChild(self._container, "Btn_Get")
	self._Img_Get = goutil.findChild(self._container, "Img_Get")
	self._txtRank.text = cellData.topGroupName
	self._TxtArea.text = cellData.topGroupArea

	local groupPrize = MaterialMgr.changeItemStrArr(cellData.achieveGroupPrize)
	local achieveGroupPrize_array = MaterialMgr.changeItemStrArr(cellData.achieveGroupPrize)

	if groupPrize then
		for i, v in ipairs(groupPrize) do
			local item = goutil.findChild(self._container, "Item_" .. i)

			item.gameObject:SetActive(true)

			local icon = goutil.findChild(item, "Bg")
			local txt = goutil.findChildTextComponent(item, "TxtNum")

			txt.gameObject:SetActive(false)
			MaterialMgr.resetAll(icon)

			if achieveGroupPrize_array[i] and achieveGroupPrize_array[i] ~= "" then
				local proxy = MaterialMgr.setCellByCfg(achieveGroupPrize_array[i], icon)

				Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.7, 0.7, 1)
			end
		end
	end

	Framework.ButtonAdapter.Get(self._Btn_Get.gameObject):AddClickListener(self._onBtnGet, self)
end

function ArenaRankCell:refreshCell(achieveInfo)
	local btn_get_gray = false
	local btn_get_active = true
	local ret_can_get = false

	if achieveInfo.maxTopGroupId > 0 and self._cellData.topGroupId >= achieveInfo.maxTopGroupId then
		btn_get_gray = false
		ret_can_get = true
	else
		btn_get_gray = true
	end

	local num = bit.lshift(1, self._cellData.topGroupId)
	local isGetReward = bit.band(achieveInfo.gainBit, num) > 0

	if isGetReward then
		btn_get_active = false

		self._Img_Get.gameObject:SetActive(true)

		ret_can_get = false
	else
		self._Img_Get.gameObject:SetActive(false)
	end

	if btn_get_active then
		uGuiUtil.setGoGrayState(self._Btn_Get.gameObject, btn_get_gray)
		self._Btn_Get.gameObject:SetActive(true)
	else
		self._Btn_Get.gameObject:SetActive(false)
	end

	return ret_can_get
end

function ArenaRankCell:hasGainPrize()
	self._Btn_Get.gameObject:SetActive(false)
	self._Img_Get.gameObject:SetActive(true)
end

function ArenaRankCell:_onBtnGet()
	ArenaAgent.instance:sendGainAchievePrizeReq()
end

function ArenaRankCell:onExit()
	Framework.ButtonAdapter.Get(self._Btn_Get.gameObject):RemoveClickListener()

	local index = 1
	local item = goutil.findChild(self._container, "Item_" .. index)

	while item do
		local icon = goutil.findChild(item, "Bg")

		MaterialMgr.resetAll(icon)

		index = index + 1
		item = goutil.findChild(self._container, "Item_" .. index)
	end
end

return ArenaRankCell
