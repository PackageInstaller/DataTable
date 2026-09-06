-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/abyssgoldrush/view/AbyssGoldRushMatchSucView.lua

module("logic.extensions.abyssgoldrush.view.AbyssGoldRushMatchSucView", package.seeall)

local AbyssGoldRushMatchSucView = class("AbyssGoldRushMatchSucView", ViewComponent)

function AbyssGoldRushMatchSucView:ctor()
	AbyssGoldRushMatchSucView.super.ctor(self)
end

function AbyssGoldRushMatchSucView:unbindEvents()
	AbyssGoldRushMatchSucView.super.unbindEvents(self)
end

function AbyssGoldRushMatchSucView:bindEvents()
	AbyssGoldRushMatchSucView.super.bindEvents(self)
end

function AbyssGoldRushMatchSucView:buildUI()
	AbyssGoldRushMatchSucView.super.buildUI(self)

	self._suc = self:getGo("suc")
	self._headLeft = self:getGo("suc/animNode/root/left/information/head")
	self._Text01Left = self:getTxt("suc/animNode/root/left/information/group/Text01")
	self._Text02Left = self:getTxt("suc/animNode/root/left/information/group/Text02")
	self._Text03Left = self:getGo("suc/animNode/root/left/information/group/Text03")
	self._headRight = self:getGo("suc/animNode/root/right/information/head")
	self._Text01Right = self:getTxt("suc/animNode/root/right/information/group/Text01")
	self._Text02Right = self:getTxt("suc/animNode/root/right/information/group/Text02")
	self._Text03Right = self:getGo("suc/animNode/root/right/information/group/Text03")
	self._effectVS = self:getGo("suc/effectVS")
	self._effectSuccess = self:getGo("suc/effectSuccess")
end

function AbyssGoldRushMatchSucView:onExit()
	AbyssGoldRushMatchSucView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headLeft)
	HeadItemController.instance:resetHeadCell(self._headRight)
	removetimer(self._finishPlayAni, self)
end

function AbyssGoldRushMatchSucView:onEnter()
	AbyssGoldRushMatchSucView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AbyssGoldRushPushStepRes, self._PM_AbyssGoldRushPushStepRes, self)

	self._activityId = checknumber(self:getFirstParam())

	goutil.setActive(self._suc, false)
	HeadItemController.instance:setMyHeadCell(self._headLeft)

	self._Text01Left.text = RoleModel.instance:getUserName()
	self._Text02Left.text = langPara("%s", RoleModel.instance:getAreaName())

	goutil.setActive(self._Text03Left, false)

	local gameInfo = AbyssGoldRushGameModel.instance:getGameInfo()

	if gameInfo then
		::label_6_0::

		local var_6_0 = gameInfo.op

		if gameInfo.op then
			local headInfo = gameInfo.op.opPlayerHead

			if headInfo then
				HeadItemController.instance:setHeadCellByInfo(self._headRight, headInfo)

				if checknumber(headInfo.userId) > 0 then
					self._Text01Right.text = headInfo.userName
					self._Text02Right.text = langPara("%s", headInfo.areaName)

					goutil.setActive(self._Text03Right, false)
				else
					local robotId = -checknumber(headInfo.userId)
					local robotCfg = AbyssGoldRushConfig.instance:getRobotCfg(robotId, 1)
					local teamCfg = AbyssGoldRushConfig.instance:getTeamCfg(robotCfg.creepsMasterId)

					self._Text01Right.text = teamCfg.name
					self._Text02Right.text = ""

					goutil.setActive(self._Text03Right, false)
				end
			end

			self:_playAni()
		end
	end
end

function AbyssGoldRushMatchSucView:_playAni()
	goutil.setActive(self._suc, true)
	settimer(3, self._finishPlayAni, self, false)
end

function AbyssGoldRushMatchSucView:_finishPlayAni()
	AbyssGoldRushAgent.instance:sendPM_AbyssGoldRushPushStepReq(self._activityId, 1)
end

function AbyssGoldRushMatchSucView:_PM_AbyssGoldRushPushStepRes()
	UIStateManager.instance:push(ViewName.AbyssGoldRushPetSelectView, self._activityId)
	self:close()
end

return AbyssGoldRushMatchSucView
