-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/CommRewardView.lua

module("logic.extensions.common.view.CommRewardView", package.seeall)

local M = class("CommRewardView", ViewComponent)

function M:ctor()
	return
end

function M:buildUI()
	self._btnClose = self:getBtnByPath("brnClose")
	self._btnBg = self:getBtn("empty_mask_tips_29887572")
	self._goTextFirst = self:getGo("settle_details_view_1837928725")
	self._goMain = self:getGo("settle_details_view_712178973")
	self._goSecond = self:getGo("settle_details_view_1592464312")
	self._goList = self:getGo("settle_details_view_1442752100")

	goutil.setActive(self._goTextFirst, false)
	goutil.setActive(self._goMain, false)
	goutil.setActive(self._goSecond, false)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:_initData()
	self:_refreshView()
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_initData()
	local info = self:getFirstParam()

	self._rewardList = info.rewardList or {}
end

function M:_refreshView()
	goutil.clearChildren(self._goList)

	for _, rewardData in ipairs(self._rewardList) do
		local go = self:getResInstance(ResName.Common_Backpack_Item)

		go:SetActive(true)

		local cell = Astral.LuaComponentContainer.Add(go, RewardCell)

		goutil.addChildToParent(go, self._goList)
		cell:updateData(rewardData)
	end
end

function M:_onClickClose()
	self:close()
end

return M
