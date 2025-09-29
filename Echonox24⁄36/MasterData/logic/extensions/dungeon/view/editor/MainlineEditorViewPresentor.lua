-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/editor/MainlineEditorViewPresentor.lua

module("logic.extensions.dungeon.view.editor.MainlineEditorViewPresentor", package.seeall)

local M = class("MainlineEditorViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Hacktool_mainline_view,
		ResName.Instance_instance_view_copy,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dungeon)
	}
end

function M:attachToWhichRoot()
	return ViewRootType.Top
end

function M:buildViews()
	local views = {}

	self._editorView = MainlineEditorView.New()

	table.insert(views, self._editorView)

	self._dungeonView = MainlineDungeonEditorView.New()

	table.insert(views, self._dungeonView)

	return views
end

function M:getDungeonView()
	return self._dungeonView
end

function M:getEditorView()
	return self._editorView
end

return M
