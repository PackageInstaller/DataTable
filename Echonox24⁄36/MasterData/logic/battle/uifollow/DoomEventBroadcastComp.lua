-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uifollow/DoomEventBroadcastComp.lua

module("logic.battle.uifollow.DoomEventBroadcastComp", package.seeall)

local M = class("DoomEventBroadcastComp")
local bgVector2 = Vector2.New(5.24, 0.52)

function M:ctor(mainGO)
	self.mainGO = mainGO

	self:setVisible(false)
	self:buildUI()
end

function M:buildUI()
	self._contentGo = goutil.findChild(self.mainGO, "txtContent")
	self._contentTxt = goutil.findChildComponent(self.mainGO, "txtContent", typeof(TMPro.TMP_Text))
	self._bgRotateAnim = goutil.findChild(self.mainGO, "Image2"):GetComponent(ComponentType.Animation)
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._encryptGo = goutil.findChild(self.mainGO, "yinbo")
	self._encryptGoList = {
		goutil.findChild(self.mainGO, "yinbo/yinbo01"),
		goutil.findChild(self.mainGO, "yinbo/yinbo02"),
		goutil.findChild(self.mainGO, "yinbo/yinbo03")
	}
	self._bgRender = goutil.findChild(self.mainGO, "Image1"):GetComponent("SpriteRenderer")

	self._guiAnimation:AddListener(self._dealTimelineListener, self)
end

function M:setVisible(status, playAnim)
	goutil.setActive(self.mainGO, status)
end

function M:_showEncrypt()
	goutil.setActive(self._contentGo, false)
	goutil.setActive(self._encryptGo, true)

	for i = 1, 3 do
		goutil.setActive(self._encryptGoList[i], i <= self._lineCount)
	end
end

function M:_showDecrypt()
	goutil.setActive(self._contentGo, true)
	goutil.setActive(self._encryptGo, false)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:showNotify(doomLogic, randomType)
	local effectIndex = doomLogic:getSelectedEffectIndex()
	local actionIndex = doomLogic:getSelectedActionIndex()
	local targetIndex = doomLogic:getSelectedTargetIndex()
	local doomActionIndex = doomLogic:getSelectedDoomActionIndex()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(doomLogic:getSourceEntityId())

	unit.uiProxy:setCareerVisible(false, "doomForecast")
	goutil.addChildToParent(self.mainGO, unit.mountRoot:getBarRoot())
	Astral.TransformUtil.SetLocalPos(self.mainGO.transform, 1, 3, -1)

	local actionDesc = doomLogic:getActionDescription(effectIndex, actionIndex, doomActionIndex)

	if randomType ~= 3 then
		self._targetDesc = doomLogic:getTargetDescription(effectIndex, actionIndex, targetIndex)
	end

	local targetDesc = string.format("[%s]", self._targetDesc)
	local str = self:_getContent(actionDesc, targetDesc, randomType)

	self._lineCount = TextUtils.GetTMPLineCount(str, self._contentTxt)
	self._contentTxt.text = str

	self:setVisible(true)

	if randomType ~= 3 then
		self._bgRotateAnim:Stop()
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open")
	end

	self:_updateBgLine()
end

function M:_updateBgLine()
	local height = 0.52

	if self._lineCount == 1 then
		height = 0.52
	elseif self._lineCount == 2 then
		height = 0.79
	elseif self._lineCount == 3 then
		height = 1.04
	end

	bgVector2:Set(bgVector2.x, height)

	self._bgRender.size = bgVector2
end

function M:_dealTimelineListener(tagName)
	if tagName == "open" then
		self._bgRotateAnim:Stop()
		self._bgRotateAnim:Play("battle_badluck_fore_image2_loop")
	end
end

function M:_getContent(actionDesc, targetDesc, randomType)
	local content = ""

	if randomType == 1 then
		local strs = string.split(actionDesc, "$")

		strs[1] = StringUtil.randomReplaceTMPToBlackBlock(strs[1])
		strs[2] = StringUtil.randomReplaceTMPToBlackBlock(strs[2])
		content = string.format("%s%s%s", strs[1], targetDesc, strs[2])
	elseif randomType == 2 then
		targetDesc = StringUtil.randomReplaceTMPToBlackBlock(targetDesc)
		content = string.gsub(actionDesc, "%$", targetDesc)
	else
		content = string.gsub(actionDesc, "%$", targetDesc)
	end

	content = ActiveSkillCOUtil.buildBuffAndTagDesc(content, false, false, false, true)
	content = ActiveSkillCOUtil.replaceDescriptionSpecialColor(content)

	return string.format("<nobr>%s</nobr>", content)
end

function M:clear()
	self._bgRotateAnim:Stop()
	self._guiAnimation:RemoveListener()

	if self._timelineTask then
		self._timelineTask:clear()
	end

	goutil.destroy(self.mainGO)
end

return M
