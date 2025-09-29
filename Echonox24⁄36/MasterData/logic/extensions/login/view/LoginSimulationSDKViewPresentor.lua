-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/LoginSimulationSDKViewPresentor.lua

module("logic.extensions.login.view.LoginSimulationSDKViewPresentor", package.seeall)

local M = class("LoginSimulationSDKViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Login_login_simulation_sdk_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LoginSimulationSDKView.New())

	return views
end

function M:onClickOutside()
	return
end

return M
