-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/ActivityTiliView.lua

module("logic.extensions.lottery.view.ActivityTiliView", package.seeall)

local ActivityTiliView = class("ActivityTiliView", ViewComponent)

function ActivityTiliView:ctor()
	ActivityTiliView.super.ctor(self)

	self.timerItemList = nil
end

function ActivityTiliView:bindEvents()
	self.viewCloseBtn:AddClickListener(function()
		self:close()
	end, self)
end

function ActivityTiliView:unbindEvents()
	self.viewCloseBtn:RemoveClickListener()
end

function ActivityTiliView:buildUI()
	self.viewCloseBtn = self:getBtn("upShowTran/viewCloseBtn")

	local tiliShowObj = self:getGo("upShowTran/tiliShowObj")

	self.tiliCountTxt = goutil.findChild(tiliShowObj, "tiliCountTxt"):GetComponent("Text")

	if self.timerItemList == nil then
		self.timerItemList = {}

		for i = 1, 3 do
			self.timerItemList[i] = self.timerItemList[i] or {}

			local parentObj = self:getGo("timerIma_" .. i)

			self.timerItemList[i].itemIma = parentObj:GetComponent("UIImageSpriteChange")
			self.timerItemList[i].notShowObj = goutil.findChild(parentObj, "infoTran/notShowBg")
			self.timerItemList[i].receiveBtnObj = goutil.findChild(parentObj, "infoTran/receiveBtn")
			self.timerItemList[i].timeShowTxt = goutil.findChild(parentObj, "infoTran/timeShowBg/timeShowTxt"):GetComponent("Text")
			self.timerItemList[i].receiveTxt = goutil.findChild(parentObj, "infoTran/receiveBtn/receiveTxt"):GetComponent("Text")
		end
	end
end

function ActivityTiliView:destroyUI()
	return
end

function ActivityTiliView:onEnter()
	self:UpdateShowTili()
	self:UpdateFreeTimeTili()
	SupplyController.instance:registerNotify(GlobalNotify.UpdataTiliCount, self.UpdateShowTili, self)
	SupplyController.instance:registerLocalNotify("UpdateFreeTimeTili", self.UpdateFreeTimeTili, self)
end

function ActivityTiliView:onEnterFinished()
	return
end

function ActivityTiliView:onExit()
	SupplyController.instance:unregisterNotify(GlobalNotify.UpdataTiliCount, self.UpdateShowTili, self)
	SupplyController.instance:unregisterLocalNotify("UpdateFreeTimeTili", self.UpdateFreeTimeTili, self)
end

function ActivityTiliView:onExitFinished()
	return
end

function ActivityTiliView:UpdateShowTili()
	local haveTili = SupplyModel.instance:getHaveTiliCount()

	self.tiliCountTxt.text = tostring(haveTili)
end

function ActivityTiliView:UpdateFreeTimeTili()
	local timeInfo = LotteryModel.instance:getTiliTimeInfo()

	if self.timerItemList and timeInfo then
		for i = 1, #self.timerItemList do
			if timeInfo[i] == nil then
				error("sr__ ActivityTiliView:onEnter()   体力免费领取小于3个！")
			end

			GameUtil.asBtn(self.timerItemList[i].receiveBtnObj):RemoveClickListener()

			self.timerItemList[i].timeShowTxt.text = timeInfo[i].startTime .. "-" .. timeInfo[i].endTime

			if timeInfo[i].recType <= 1 then
				self.timerItemList[i].itemIma:SetState(0)
				self.timerItemList[i].notShowObj:SetActive(true)
				self.timerItemList[i].receiveBtnObj:SetActive(false)
			elseif timeInfo[i].recType == 2 then
				self.timerItemList[i].itemIma:SetState(0)
				self.timerItemList[i].notShowObj:SetActive(false)
				self.timerItemList[i].receiveBtnObj:SetActive(true)

				self.timerItemList[i].receiveTxt.text = "领取"
			elseif timeInfo[i].recType == 3 then
				self.timerItemList[i].itemIma:SetState(0)
				self.timerItemList[i].notShowObj:SetActive(false)
				self.timerItemList[i].receiveBtnObj:SetActive(true)

				self.timerItemList[i].receiveTxt.text = "补领"
			else
				self.timerItemList[i].itemIma:SetState(1)
				self.timerItemList[i].notShowObj:SetActive(false)
				self.timerItemList[i].receiveBtnObj:SetActive(true)

				self.timerItemList[i].receiveTxt.text = "已领取"
			end

			local num = i

			GameUtil.asBtn(self.timerItemList[i].receiveBtnObj):AddClickListener(function()
				self:OnClickReceiveBtn(num)
			end, self)
		end
	end
end

function ActivityTiliView:OnClickReceiveBtn(index)
	local timeInfo = SupplyModel.instance:getTiliTimeInfo()

	if timeInfo == nil or timeInfo[index] == nil then
		return
	end

	local stge = timeInfo[index].recType

	if stge <= 1 then
		return
	end

	if stge == 2 then
		SupplyController.instance:CSRequestFreeStrength(index - 1)

		return
	end

	if stge == 3 then
		local haveCount = RoleModel.instance:getPresentDiamond()
		local commInfo = SupplyModel.instance:getTiliCommonInfo()

		if commInfo then
			if not commInfo.consumeCount then
				local needCount = 20

				if haveCount < needCount then
					FloatWordMgr.instance:show(lang("text_lottery_desc_9"))

					return
				end

				SupplyController.instance:CSRequestReplacementTili(index - 1)

				return
			end
		end
	end

	FloatWordMgr.instance:show(lang("text_lottery_desc_10"))
end

return ActivityTiliView
