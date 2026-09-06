-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doloresclg/view/atlasclg/AtlasclglevelView.lua

module("logic.extensions.doloresclg.view.atlasclg.AtlasclglevelView", package.seeall)

local AtlasclglevelView = class("AtlasclglevelView", DoloresclglevelView)

function AtlasclglevelView:getTxtCountDesc(color, cur, total)
	return langPara("<color=%s>%s/%s</color>", color, cur, total)
end

function AtlasclglevelView:_updateTabCell(view, cell, data, tag)
	local tab = goutil.findChild(cell, "tab")
	local bg = goutil.findChild(cell, "tab/bg")
	local txtName = goutil.findChildTextComponent(cell, "tab/bg/txtName")
	local txtLevel = goutil.findChildTextComponent(cell, "tab/txtLevel")
	local pass = goutil.findChild(cell, "tab/pass")
	local lock = goutil.findChild(cell, "tab/lock")
	local select = goutil.findChild(cell, "tab/select")
	local txtLock = goutil.findChildTextComponent(cell, "tab/lock/txtLock")

	txtLevel.text = langPara("第%s关", data.phaseId)

	local str, isLock = ActivityDefineController.instance:getActTimeShowWithOpenDay(self._activityId, data.openDay)

	txtLock.text = lang("请先通关上一层")
	txtName.text = str

	GameUtil.SetActive(bg, isLock)
	GameUtil.SetActive(select, data.phaseId == self._passedPhaseId + 1)
	GameUtil.SetActive(lock, data.phaseId > self._passedPhaseId + 1 or isLock)
	GameUtil.SetActive(pass, data.phaseId <= self._passedPhaseId)
end

return AtlasclglevelView
