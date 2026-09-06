-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/BinglingwangController.lua

module("logic.extensions.timelimitedchallenge.controller.BinglingwangController", package.seeall)

local BinglingwangController = class("BinglingwangController", BaseController)

function BinglingwangController:ctor()
	BinglingwangController.super.ctor(self)
end

function BinglingwangController:onInit()
	self:onReset()
end

function BinglingwangController:onReset()
	return
end

function BinglingwangController:sendGetInfo(challengeId)
	BinglingwangModel.instance:sendGetInfo(challengeId)
end

function BinglingwangController:sendGetDailyPrize(challengeId)
	BinglingwangModel.instance:sendGetDailyPrize(challengeId)
end

function BinglingwangController:sendGetProgressPrize(challengeId, prizeId)
	BinglingwangModel.instance:sendGetProgressPrize(challengeId, prizeId)
end

function BinglingwangController:sendSweep(challengeId, stage)
	BinglingwangModel.instance:sendSweep(challengeId, stage)
end

function BinglingwangController:sendFight(challengeId, stage)
	BinglingwangModel.instance:sendFight(challengeId, stage)
end

function BinglingwangController:onBattleEnd(challengeId, idx)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local isWin = BinglingwangModel.instance.isWin

	BinglingwangModel.instance.isWin = false

	local title = lang("战斗失败")
	local content = lang("未能击败敌阵全部精灵，战斗失败")
	local btnTxt = lang("知道了")

	if isWin then
		local mo = BinglingwangModel.instance:getChallangeInfoById(challengeId) or {}

		if not mo.everAlivePets then
			local everAlivePets = {}
			local alive = checknumber(everAlivePets[idx])
			local ratio = (BinglingwangConfig.instance:getBaseConfig(challengeId) or {}).ratio
			local num = checknumber(ratio) * alive

			title = lang("战斗胜利")
			content = langPara("击败敌阵全部精灵，破阵成功！\n\n精灵存活=%s只\n冰晶雪花=%s片", alive, num)
		end
	end

	TipsFacade.instance:openTipWindowValidX(title, content, function()
		BattleController.instance:endBattle()
	end, btnTxt, UnityEngine.TextAnchor.MiddleCenter)

	return true
end

BinglingwangController.instance = BinglingwangController.New()

return BinglingwangController
