-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemPreviewPresentor.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemPreviewPresentor", package.seeall)

local M = class("EchoItemPreviewPresentor", EchoItemMainViewNewPresentor)

function M:buildViews()
	local views = {}

	table.insert(views, EchoItemPreview.New())
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DefaultHideType))

	local blurBgView = CaptureSceneView.New()

	table.insert(views, TitleView.New():blockOrgBtn(true, true, false))

	return views
end

return M
