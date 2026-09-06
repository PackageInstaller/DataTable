-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleEnemyHeadIcon.lua

module("logic.extensions.battle.view.BattleEnemyHeadIcon", package.seeall)

local BattleEnemyHeadIcon = class("BattleEnemyHeadIcon")

function BattleEnemyHeadIcon:ctor(go, view)
	self._view = view
	self.mainGO = go

	self:_buildUI()
end

function BattleEnemyHeadIcon:_buildUI()
	self._otherName = goutil.findChildTextComponent(self.mainGO, "OtherName")
	self._otherDefaultIcon = goutil.findChild(self.mainGO, "Otherheadicon/defaultIcon")
	self._otherRaceIdHeadIcon = Framework.ImageBigBG.Get(goutil.findChild(self.mainGO, "Otherheadicon/imgIcon"))
	self._otherLevel = goutil.findChild(self.mainGO, "Otherheadicon/level")
	self._txtOtherLevel = goutil.findChildTextComponent(self._otherLevel, "txtLevel")
	self._otherHeadPoint = goutil.findChild(self.mainGO, "Otherheadicon/con")
end

function BattleEnemyHeadIcon:onEnter()
	self:_updatePlayerIcons()
	self._otherName.gameObject:SetActive(true)

	self._otherName.text = BattleModel.instance:getEnemyNickName()
end

function BattleEnemyHeadIcon:onExit()
	MaterialMgr.resetAll(self._otherHeadPoint)

	if self._otherRaceIdHeadIcon then
		self._otherRaceIdHeadIcon:ClearImage()
	end
end

function BattleEnemyHeadIcon:setName(name)
	self._otherName.text = name
end

function BattleEnemyHeadIcon:getName()
	return self._otherName.text
end

function BattleEnemyHeadIcon:setNameVisible(visible)
	self._otherName.gameObject:SetActive(visible or false)
end

function BattleEnemyHeadIcon:_updatePlayerIcons()
	local otherHeadInfo = BattleModel.instance:getOtherHeadInfo()
	local hasIcon = otherHeadInfo.headIcon > 0 or otherHeadInfo.headRaceId ~= 0

	self._otherDefaultIcon:SetActive(not hasIcon)
	self._otherRaceIdHeadIcon.gameObject:SetActive(false)

	if hasIcon then
		if otherHeadInfo.headIcon > 0 then
			HeadItemController.instance:setHeadCell(self._otherHeadPoint, otherHeadInfo.headIcon, otherHeadInfo.headFrame, otherHeadInfo.vipLv)
		else
			local modelCo = CharacterConfig.instance:getModelCo(otherHeadInfo.headRaceId)

			if not modelCo then
				local petCo = CharacterConfig.instance:getPetCo(otherHeadInfo.headRaceId)

				modelCo = CharacterConfig.instance:getModelCo(tonumber(petCo.faceIds))
			end

			if modelCo and self._otherRaceIdHeadIcon then
				self._otherRaceIdHeadIcon.gameObject:SetActive(true)
				self._otherRaceIdHeadIcon:SetImage(GameUrl.getCharacterIconUrl(modelCo.headName))
			end

			BattleController.instance:updateHeadIconDir(self._otherRaceIdHeadIcon, otherHeadInfo.headRaceId)
		end
	end

	self._otherLevel:SetActive(false)

	if hasIcon and checknumber(otherHeadInfo.playerLv) > 0 then
		self._otherLevel:SetActive(true)

		self._txtOtherLevel.text = otherHeadInfo.playerLv
	end
end

return BattleEnemyHeadIcon
