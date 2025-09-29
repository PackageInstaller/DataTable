-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/claw_doll/sencemgr/ClawDollBollTrigger.lua

module("logic.extensions.welfare.controller.claw_doll.sencemgr.ClawDollBollTrigger", package.seeall)

local M = class("ClawDollBollTrigger")

function M:ctor(go)
	self._go = go.gameObject
end

function M:Start()
	return
end

function M:updateData(id)
	self._dollID = id
end

function M:OnCollisionEnter(collision)
	if collision.gameObject.name == "exit_trigger" then
		goutil.setActive(self._go, false)
		ClawDollAgent.instance:sendClipDollRequest({
			cfgId = ClawDollActivityView.CONFIGID,
			dollId = self._dollID
		})
	end
end

function M:OnTriggerEnter(collision)
	return
end

function M:OnTriggerExit(collision)
	if collision.gameObject.name == "bollpass_trigger" then
		self:_setEdge(orangeHemisphere, 0.03)
	end
end

return M
