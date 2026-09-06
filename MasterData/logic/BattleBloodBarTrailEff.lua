-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleBloodBarTrailEff.lua

module("logic.extensions.battle.view.BattleBloodBarTrailEff", package.seeall)

local BattleBloodBarTrailEff = class("BattleBloodBarTrailEff")

function BattleBloodBarTrailEff:ctor(teamId, effNode, tailNode, view)
	self._view = view
	self._teamId = teamId
	self._effNode = effNode
	self._tailNode = tailNode
end

function BattleBloodBarTrailEff:onEnter()
	self:_playEffect()
end

function BattleBloodBarTrailEff:onExit()
	self:_stopEffect()
end

function BattleBloodBarTrailEff:_playEffect()
	local effPath

	self._eff = UIEffectManager.instance:playEffect(self._view, self._teamId == GameEnum.BattleTeam.Left and "fx_ui_zhandou/fx_ui_huihe_you.prefab" or "fx_ui_zhandou/fx_ui_huihe_zuo.prefab", self._effNode, 0, 0, true)

	self._eff:setParent(self._effNode)
	self._eff:setLocalPos(0, 0, 0)
	self._eff:setScale(1)
end

function BattleBloodBarTrailEff:_stopEffect()
	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function BattleBloodBarTrailEff:updateEffectNode(currSliderValue)
	if currSliderValue <= 0 then
		if self._effNode.gameObject.activeSelf then
			self._effNode.gameObject:SetActive(false)
		end

		if self._tailNode.gameObject.activeSelf then
			self._tailNode.gameObject:SetActive(false)
		end
	else
		if not self._effNode.gameObject.activeSelf then
			self._effNode.gameObject:SetActive(true)
		end

		if not self._tailNode.gameObject.activeSelf then
			self._tailNode.gameObject:SetActive(true)
		end
	end
end

return BattleBloodBarTrailEff
