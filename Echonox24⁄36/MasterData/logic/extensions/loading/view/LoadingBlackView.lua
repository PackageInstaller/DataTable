-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/LoadingBlackView.lua

module("logic.extensions.loading.view.LoadingBlackView", package.seeall)

local M = class("LoadingBlackView", ViewComponent)

function M:buildUI()
	return
end

function M:destroyUI()
	return
end

function M:onEnter()
	PlayerAttributeGainTipsController.instance:freeze("loading")
end

function M:onExit()
	PlayerAttributeGainTipsController.instance:unfreeze("loading", 0.2)
end

function M:onExitFinished()
	return
end

return M
