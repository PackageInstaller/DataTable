-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManBossCell.lua

module("logic.extensions.beastrichman.view.BeastRichManBossCell", package.seeall)

local BeastRichManBossCell = class("BeastRichManBossCell", BeastRichManBaseCell)

function BeastRichManBossCell:ctor(nodes)
	BeastRichManBossCell.super.ctor(self, nodes)
end

function BeastRichManBossCell:init(activityId, zoneId, beastType, beastId, offsetPosX, offsetPosY)
	self._beastType = beastType
	self._beastId = beastId

	local bossGridCfg = BeastRichmanConfig.instance:getBossGridCfg(activityId, zoneId, beastType, beastId)

	BeastRichManBossCell.super.init(self, activityId, zoneId, bossGridCfg.uniqueId, offsetPosX, offsetPosY)
end

function BeastRichManBossCell:_initUI()
	BeastRichManBossCell.super._initUI(self)

	local mainGo = self:getNodeGo("main")

	if mainGo then
		self._btnEvent = goutil.findChild(mainGo, "btn")

		GameUtil.addClickHandler(self._btnEvent, function()
			if self._beastType == BeastRichManEnum.BossType.Boss then
				UIStateManager.instance:push(ViewName.BeastrichmanbossView, self._activityId, self._zoneId, self._beastType, self._beastId)
			else
				UIStateManager.instance:push(ViewName.BeastrichmanbreakView, self._activityId, self._zoneId, self._beastType, self._beastId)
			end
		end, self)

		local bossCfg = BeastRichmanConfig.instance:getBossGridCfg(self._activityId, self._zoneId, self._beastType, self._beastId)
		local bossImgName = bossCfg.bossImgName
		local path = string.format("ui/bigbg/game/beastrichman/%s.png", bossImgName)

		uGuiUtil.setSpriteToImage(mainGo, uGuiUtil.SpriteType.BigBg, path)
	end

	GameUtil.SetActive(self._nodes.bg, false)
end

function BeastRichManBossCell:clearCell()
	local mainGo = self:getNodeGo("main")

	if mainGo then
		uGuiUtil.clearImage(mainGo)
	end

	GameUtil.rmClickHandler(self._btnEvent)
end

return BeastRichManBossCell
