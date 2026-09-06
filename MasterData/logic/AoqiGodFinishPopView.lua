-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqigod/view/AoqiGodFinishPopView.lua

module("logic.extensions.aoqigod.view.AoqiGodFinishPopView", package.seeall)

local AoqiGodFinishPopView = class("AoqiGodFinishPopView", ViewComponent)

function AoqiGodFinishPopView:ctor()
	AoqiGodFinishPopView.super.ctor(self)
end

function AoqiGodFinishPopView:buildUI()
	AoqiGodFinishPopView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._descStr = "您已成功帮助<color=#4786C0FF>%s</color>完成<color=#4786C0FF>%s</color>的挑战！"
	self._txtNilPrizeDesc = goutil.findChildTextComponent(self.mainGO, "txtNilPrizeDesc")
	self._nilPrizeDescStr = self._txtNilPrizeDesc.text
	self._txtReward = MaterialMgr.findGraphicText(self.mainGO, "txtReward")
end

function AoqiGodFinishPopView:bindEvents()
	AoqiGodFinishPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClose, self)
end

function AoqiGodFinishPopView:unbindEvents()
	AoqiGodFinishPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function AoqiGodFinishPopView:onEnter()
	AoqiGodFinishPopView.super.onEnter(self)

	self._txtNilPrizeDesc.text = "挑战已完成，奖励已发放"

	GameUtil.SetActive(self._txtNilPrizeDesc.gameObject, true)
	GameUtil.SetActive(self._txtReward.gameObject, false)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._info = params[2]
	self._msg = self._info and self._info.msg
	self._helpItem = self._info and self._info.helpItem

	if self._msg and self._msg:HasField("changeSetId") then
		self._changeSetId = self._msg.changeSetId
	end

	if self._activityId <= 0 or self._msg == nil or self._helpItem == nil or self._helpItem:isEmpty() then
		printError("[AoqiGodFinishPopView] invalid finish info", self._activityId, self._msg ~= nil, self._helpItem ~= nil)

		return
	end

	self._aoqiGodMo = AoqiGodController.instance:getAoqiGodMo(self._activityId)

	local playerName = self._helpItem:getPlayerName()
	local challengeId = self._helpItem:getChallengeId()
	local clgData = AoqiGodConfig.instance:getClgData(self._activityId, challengeId)

	if clgData == nil then
		printError("[AoqiGodFinishPopView] challenge config missing", self._activityId, challengeId)

		return
	end

	local clgName = CharacterConfig.instance:getPetName(clgData.skinId)
	local preStr = string.format(self._descStr, playerName, clgName)
	local cur = self._aoqiGodMo:getDailyHelperTimes()
	local max = self._aoqiGodMo:getGodDailyTimes()
	local isHavePrize = cur <= max

	if isHavePrize then
		local score = checknumber(clgData.helpAddScore)
		local size = 40
		local offsetY = -15
		local resultStr = {}

		if score > 0 then
			local strScore = langPara("%s积分", clgData.helpAddScore)

			table.insert(resultStr, strScore)
		end

		if checknumber(self._msg.charmValue) > 0 then
			local strCharm = langPara("%s魅力值", self._msg.charmValue)

			table.insert(resultStr, strCharm)
		end

		if not string.nilorempty(clgData.godPrize) then
			local rewards = string.split(clgData.godPrize, "#")
			local rewardStrList = {}

			for i, itemStr in ipairs(rewards) do
				local matType, matId, matNum = MaterialMgr.getMatParams(itemStr)
				local content = MaterialMgr.getContentMatCfg(matType, matId, size, offsetY, MaterialMgr.ICON_TYPE_ICON)

				table.insert(rewardStrList, string.format("%sx%s", content, matNum))
			end

			local strPrize = table.concat(rewardStrList, "、")

			table.insert(resultStr, strPrize)
		end

		local strResult = table.concat(resultStr, "、")

		self._txtReward.text = string.format("%s\n获得%s", preStr, strResult)
	else
		local score = clgData.helpAddScore
		local petName = ""
		local petData = CharacterConfig.instance:getPetCo(clgData.skinId)

		if petData then
			petName = petData.name
		end

		local resultStr = {}
		local scoreStr = langPara("%s积分", score)

		table.insert(resultStr, scoreStr)

		if checknumber(self._msg.charmValue) > 0 then
			local strCharm = langPara("%s魅力值", self._msg.charmValue)

			table.insert(resultStr, strCharm)
		end

		local strResult = table.concat(resultStr, "、")

		self._txtNilPrizeDesc.text = string.format(self._nilPrizeDescStr, playerName, clgName, strResult)
	end

	GameUtil.SetActive(self._txtNilPrizeDesc.gameObject, not isHavePrize)
	GameUtil.SetActive(self._txtReward.gameObject, isHavePrize)
end

function AoqiGodFinishPopView:onExit()
	AoqiGodFinishPopView.super.onExit(self)

	self._info = nil
	self._msg = nil
	self._helpItem = nil
	self._changeSetId = nil
end

function AoqiGodFinishPopView:_onClose()
	local changeSetId = self._changeSetId

	self:close()

	if changeSetId then
		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

return AoqiGodFinishPopView
