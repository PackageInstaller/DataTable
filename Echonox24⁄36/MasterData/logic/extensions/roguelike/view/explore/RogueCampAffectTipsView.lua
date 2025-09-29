-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueCampAffectTipsView.lua

module("logic.extensions.roguelike.view.explore.RogueCampAffectTipsView", package.seeall)

local M = class("RogueCampAffectTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._campAffectItems = {}
end

function M:buildUI()
	self._traCampParent = self:getGo("camp_affect_tips_-1993994572").transform
	self._goCampAffectItem = self:getGo("camp_affect_tips_-1882273415")
	self._btnClose = self:getBtn("0&empty_mask_tips_29887572")

	goutil.setActive(self._goCampAffectItem, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:updateData()
end

function M:onExit()
	return
end

function M:updateData()
	local curSelectRoleIds = self:getFirstParam()

	function GetSelectRoleCampCount(campId)
		local count = 0

		for k, v in pairs(curSelectRoleIds or {}) do
			local characterCo = CharacterConfig.instance:getCharacterItemInfo(v)

			if characterCo.camp == campId then
				count = count + 1
			end
		end

		return count
	end

	for k, v in pairs(self._campAffectItems) do
		v:setActive(false)
	end

	local allCampAffect = RoguelikeConfig.instance:getAllCampAffect()

	for idx, v in pairs(allCampAffect) do
		local item = self._campAffectItems[idx]

		if not item then
			local go = goutil.cloneAndSetParent(self._goCampAffectItem, self._traCampParent)

			item = Astral.LuaComponentContainer.Add(go, RogueCampAffectItem)
			self._campAffectItems[idx] = item
		end

		local data = {}

		data.camp = v.camp
		data.numText = GetSelectRoleCampCount(v.camp) .. "/" .. 3
		data.campNum = GetSelectRoleCampCount(v.camp)
		data.desc = v.desc
		data.desc = v.desc

		item:updateData(data)
	end
end

function M:_onClickClose()
	self:close()
end

return M
