-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/CourseRoguelikeItem.lua

module("logic.extensions.playerinfo.view.course.widgets.CourseRoguelikeItem", package.seeall)

local M = class("CourseRoguelikeItem")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject

	self:buildUI()
end

function M:OnDestroy()
	return
end

function M:buildUI()
	local registry = ViewElementsRegistry.New(self.mainGO)

	self._imgBg = registry:findUIElement("player_course_roguelike_item_-733578963", UIComponentType.Image)
	self._imgFill = registry:findUIElement("player_course_roguelike_item_-1839634282", UIComponentType.Image)
	self._txtFill = registry:findUIElement("player_course_roguelike_item_-590758427", UIComponentType.Text)
	self._txtPass = registry:findUIElement("player_course_roguelike_item_-186905015", UIComponentType.Text)
	self._txtClue = registry:findUIElement("player_course_roguelike_item_-2019643368", UIComponentType.Text)
	self._txtLvMax = registry:findUIElement("player_course_roguelike_item_-1191418535", UIComponentType.Text)
end

function M:setData(data)
	local id = data:getId()
	local cfg = RoguelikeConfig.instance:getScriptById(id)

	if cfg then
		IconLoader.setSprite(self._imgBg, IconType.RunGroup, string.format("rungroup_drama/%s", cfg.thumbnail))
	end

	local rate = data:getFinishedRate()

	self._imgFill.fillAmount = rate
	self._txtFill.text = string.format("%.0f", math.floor(rate * 100))
	self._txtPass.text = data:getPass()
	self._txtClue.text = string.format("%d/<size=24>%d</size>", data:getClue(), data:getClueCfg())
	self._txtLvMax.text = data:getLvMax()
end

return M
