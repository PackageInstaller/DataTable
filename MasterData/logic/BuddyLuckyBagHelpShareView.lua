-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/buddyluckybag/view/BuddyLuckyBagHelpShareView.lua

module("logic.extensions.buddyluckybag.view.BuddyLuckyBagHelpShareView", package.seeall)

local BuddyLuckyBagHelpShareView = class("BuddyLuckyBagHelpShareView", ViewComponent)
local CodeTips = {
	[0] = "已成功拆福袋！",
	[-1] = "福袋码不存在",
	[-4] = "系统繁忙，请重试",
	[-3] = "已帮该小奥奇拆过福袋啦，不能再帮忙了~",
	[-5] = "对方已拆完福袋，帮拆失败~",
	[-2] = "目标玩家不存在"
}

function BuddyLuckyBagHelpShareView:buildUI()
	BuddyLuckyBagHelpShareView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtTips = self:getTxt("tips/txt")
	self._strTxtTips = self._txtTips.text
	self._txtHelpTimes = self:getTxt("tips/txtHelpTimes")
	self._strTxtHelpTimes = self._txtHelpTimes.text
	self._txtHelpBagCount = self:getTxt("tips/txtHelpBagCount")
	self._strTxtHelpBagCount = self._txtHelpBagCount.text
	self._inputComp = self:getInput("InputC_Search")
end

function BuddyLuckyBagHelpShareView:bindEvents()
	BuddyLuckyBagHelpShareView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
end

function BuddyLuckyBagHelpShareView:unbindEvents()
	BuddyLuckyBagHelpShareView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	self._inputComp:RemoveOnValueChanged()
end

function BuddyLuckyBagHelpShareView:onEnter()
	BuddyLuckyBagHelpShareView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._inviteStr = params[2] or ""
	self._subMo = BuddyLuckyBagController.instance:getSubMo(self._activityId)
	self._inviteCodeResult = 0

	self:_inputSetText(self._inviteStr)
	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.HandlePM_BuddyLuckyBagHelpOpenBagRes, self._handlePM_BuddyLuckyBagHelpOpenBagRes, self)
end

function BuddyLuckyBagHelpShareView:onExit()
	BuddyLuckyBagHelpShareView.super.onExit(self)
	GameUtil.SetGray(self._btnSure, false)
end

function BuddyLuckyBagHelpShareView:_handlePM_BuddyLuckyBagHelpOpenBagRes(msg)
	local code = msg.resultCode

	self._inviteCodeResult = code

	local tips = CodeTips[code]

	FloatWordMgr.instance:show(tips)

	if code == 0 then
		self:_inputSetText("")
		self:_onUpdate()
	else
		self:_onUpdateBtnSureUI()
	end
end

function BuddyLuckyBagHelpShareView:_inputValueChanged(text)
	local subStr = string.sub(text, 1, 550)

	if self._inputComp:GetText() == self._lastInputTxt then
		return
	end

	self._lastInputTxt = subStr

	local cleanStr = string.gsub(subStr, "%s", "")
	local inviteCode = string.match(cleanStr, "%【(.-)%】")

	inviteCode = inviteCode or cleanStr
	self._inviteCode = inviteCode
	self._inviteCodeResult = 0

	self:_onUpdateBtnSureUI()
end

function BuddyLuckyBagHelpShareView:_inputSetText(text)
	self._inputComp:SetText(text)
end

function BuddyLuckyBagHelpShareView:_onUpdate()
	local curGainHelpBagTimes = self._subMo:getCurGainHelpBagTimes()
	local firstHelpUnlockCount = self._subMo:getFirstHelpUnlockCount()
	local leftHelpTimes = self._subMo:getLeftHelpTimes()
	local maxHelpTimes = self._subMo:getMaxHelpTimes()

	self._txtTips.text = string.format(self._strTxtTips, firstHelpUnlockCount)
	self._txtHelpBagCount.text = string.format(self._strTxtHelpBagCount, Mathf.Max(firstHelpUnlockCount - curGainHelpBagTimes, 0), firstHelpUnlockCount)
	self._txtHelpTimes.text = string.format(self._strTxtHelpTimes, leftHelpTimes, maxHelpTimes)

	self:_onUpdateBtnSureUI()
end

function BuddyLuckyBagHelpShareView:_onUpdateBtnSureUI()
	local result = self:_getTrySureResultAndTips(false, self._inviteCode)

	GameUtil.SetGray(self._btnSure, result ~= GameEnum.ResultCode.Success)
end

function BuddyLuckyBagHelpShareView:_onClickBtnSure()
	local result = self:_getTrySureResultAndTips(true, self._inviteCode)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	BuddyLuckyBagController.instance:sendPM_BuddyLuckyBagHelpOpenBagReq(self._activityId, self._inviteCode)
end

function BuddyLuckyBagHelpShareView:_getTrySureResultAndTips(isNeedTips, inviteCode)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success and self._inviteCodeResult ~= 0 then
		result = GameEnum.ResultCode.Error
		tips = CodeTips[self._inviteCodeResult]
	end

	if result == GameEnum.ResultCode.Success and string.nilorempty(inviteCode) then
		result = GameEnum.ResultCode.Error
		tips = "分享码不存在，再仔细检查下~"
	end

	if result == GameEnum.ResultCode.Success then
		local myCode = self._subMo:getMyCode()

		if myCode == inviteCode then
			result = GameEnum.ResultCode.Error
			tips = "无法给自己帮拆噢，请重新输入福袋码"
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftHelpTimes = self._subMo:getLeftHelpTimes()

		if leftHelpTimes <= 0 then
			result = GameEnum.ResultCode.Error
			tips = "帮拆次数不足"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

return BuddyLuckyBagHelpShareView
