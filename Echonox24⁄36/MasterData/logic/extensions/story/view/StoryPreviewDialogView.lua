-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryPreviewDialogView.lua

module("logic.extensions.story.view.StoryPreviewDialogView", package.seeall)

local M = class("StoryPreviewDialogView", ViewComponent)
local PLOT_TEST_ID = "storytestid"
local PLOT_DEFAULT_ID = 1000101

function M:bindEvents()
	if self._btnEnter then
		self._btnEnter:AddClickListener(self._onClickTestPlot, self)
	end

	if self._iptPlotID then
		self._iptPlotID:AddOnValueChanged(self._onChangePlotID, self)
	end
end

function M:_onChangePlotID()
	local value = self._iptPlotID:GetText()

	if not string.nilorempty(value) then
		Astral.LocalStorage.Instance:SetString(PLOT_TEST_ID, value)
	end
end

function M:_onClickTestPlot()
	local plotid = PLOT_DEFAULT_ID

	if self._iptPlotID then
		local commandStr = self._iptPlotID:GetText()

		if string.nilorempty(commandStr) then
			FloatWordMgr.instance:show("请输入剧情id")

			return
		end

		plotid = tonumber(commandStr)

		if isInEditorMode then
			local path = string.format("%s/GameAssets/shared/story/stories/%s/cfgdata.json", UnityEngine.Application.dataPath, plotid)
			local fileExist = SpaceXFileUtil.IsFileExists(path)

			if not fileExist then
				FloatWordMgr.instance:show("剧情配置不存在")

				return
			end
		end

		StoryController.instance:Open(plotid, self._previewFinish, self)
		Astral.LocalStorage.Instance:SetString(PLOT_TEST_ID, plotid)
		self:close()
	end
end

function M:_previewFinish()
	ViewMgr.instance:openSpecialView(ViewName.StoryPreviewDialogView)
end

function M:unbindEvents()
	self._btnEnter:RemoveClickListener()
	self._btnExit:RemoveClickListener()
	self._iptPlotID:RemoveOnValueChanged()
end

function M:buildUI()
	self._iptPlotID = self:getInput("story_preview_dialog_-42745739")
	self._btnEnter = self:getBtn("story_preview_dialog_-242943676")
	self._btnExit = self:getBtn("story_preview_dialog_829007857")
	self._iptStepId = self:getInput("story_preview_dialog_541917595")
	self._previewSceneLight = goutil.find("SceneLight")
end

function M:destroyUI()
	return
end

function M:onEnter()
	self._iptPlotID:SetText(tonumber(Astral.LocalStorage.Instance:GetString(PLOT_TEST_ID, PLOT_DEFAULT_ID)))
	goutil.setActive(self._previewSceneLight, false)
end

function M:onExit()
	return
end

return M
