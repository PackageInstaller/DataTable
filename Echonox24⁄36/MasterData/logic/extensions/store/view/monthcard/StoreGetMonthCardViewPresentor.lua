-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/monthcard/StoreGetMonthCardViewPresentor.lua

module("logic.extensions.store.view.monthcard.StoreGetMonthCardViewPresentor", package.seeall)

local M = class("StoreGetMonthCardViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Store_prime_member_open_tips
	}
end

function M:buildViews()
	local views = {}

	self._mainView = StoreGetMonthCardView.New()

	table.insert(views, self._mainView)
	table.insert(views, BlurBgView.New())

	return views
end

function M:onClickOutside()
	self._mainView:onClose()
end

return M
