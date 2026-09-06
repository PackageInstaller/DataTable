-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bindmobile/view/BindmobileView.lua

module("logic.extensions.bindmobile.view.BindmobileView", package.seeall)

local BindmobileView = class("BindmobileView", ViewComponent)
local PHONE_REG = "[1][3,4,5,7,8,9]%d%d%d%d%d%d%d%d%d"

function BindmobileView:ctor()
	BindmobileView.super.ctor(self)
end

function BindmobileView:unbindEvents()
	BindmobileView.super.unbindEvents(self)
end

function BindmobileView:bindEvents()
	BindmobileView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGetPrize, self._onClickGetPrize, self)
	GameUtil.addClickHandler(self._btnClear, self._onCLickClear, self)
	GameUtil.addClickHandler(self._btnGetCode, self._onClickGetCode, self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOk, self)
end

function BindmobileView:buildUI()
	BindmobileView.super.buildUI(self)

	self._input = self:getGo("input")
	self._phoneInput = self:getInput("input/phoneInput")
	self._codeInput = self:getInput("input/codeInput")
	self._txtPlaceholder2 = self:getTxt("input/codeInput/Placeholder")
	self._btnClear = self:getGo("input/btnClear")
	self._btnGetCode = self:getGo("input/btnGetCode")
	self._txtGetCode = self:getTxt("input/btnGetCode/txtGetCode")
	self._btnOk = self:getGo("input/btnOk")
	self._desc = self:getGo("desc")
	self._txtPhoneNum = self:getTxt("desc/txtPhoneNum")
	self._btnGetPrize = self:getGo("btnGetPrize")
	self._prizeCon = self:getGo("prizeCon")
	self._tablecell = self:getGo("tablecell")

	GameUtil.SetActive(self._tablecell, false)
end

function BindmobileView:onExit()
	BindmobileView.super.onExit(self)
	removetimer(self._onTimer, self)
	self:_clearAllCell()
end

function BindmobileView:_clearAllCell()
	local trs = self._prizeCon.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)

		self:_clearCell(child.gameObject)
	end
end

function BindmobileView:onEnter()
	BindmobileView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BIND_MOBILE_INFO_UPDATE, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.AfterRedPointUpdate, self._onAfterRed, self)
	BindMobileAgent.instance:sendPM_BindMobileGetInfoReq()
	self:_refreshUI()
end

function BindmobileView:_onAfterRed()
	local isCanGet = RedPointModel.instance:isActive(750)

	if isCanGet then
		self:_refreshUI()
	end
end

function BindmobileView:_refreshUI()
	local info = BindMobileModel.instance:getInfo() or {}

	if not info.result then
		local result = {}

		self._sendCaptchaCdTimeMillis = checknumber(info.sendCaptchaCdTimeMillis) / 1000
		self._gainPrize = checkbool(info.gainPrize)

		local obj = ActivityParamsConfig.instance:getCfgByTypeAndId(11, "prize") or {}

		if not obj.value then
			local value = {}

			if not value.material then
				local material = ""
				local arr = string.split(material, "#") or {}

				self:_clearAllCell()
				goutil.clearChildren(self._prizeCon)

				for i, v in ipairs(arr) do
					local go = goutil.cloneAndSetParent(self._tablecell, self._prizeCon.transform, "cell_" .. i)

					GameUtil.SetActive(go, true)
					self._updateCell(self, self, go, v)
				end

				local isCanGet = RedPointModel.instance:isActive(750)

				GameUtil.SetActive(self._input, false)
				GameUtil.SetActive(self._desc, false)
				GameUtil.SetActive(self._btnGetPrize, false)

				if checknumber(result.code) == 0 then
					if checkbool(info.bindMobile) == true then
						GameUtil.SetActive(self._desc, true)

						self._txtPhoneNum.text = info.mobile
					else
						GameUtil.SetActive(self._input, true)
					end

					GameUtil.SetActive(self._btnGetPrize, isCanGet and not self._gainPrize)
				else
					GameUtil.SetActive(self._input, true)
					TipsFacade.instance:openPopupWindow(lang("tip"), result.message)
					BindMobileModel.instance:clearInfoResult()
				end

				settimer(1, self._onTimer, self)
				self:_onTimer()
			end
		end
	end
end

function BindmobileView:_onTimer()
	local now = ServerTime.now()
	local left = self._sendCaptchaCdTimeMillis - now

	if left > 0 then
		self._txtGetCode.text = langPara("(%ss)", math.floor(left))
	else
		removetimer(self._onTimer, self)

		self._txtGetCode.text = "获取验证码"
	end
end

function BindmobileView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local receive = goutil.findChild(cell, "receive")
	local effGo = goutil.findChild(cell, "effGo")

	MaterialMgr.setCellByCfg(data, con)
	GameUtil.SetActive(receive, self._gainPrize)

	local isCanGet = RedPointModel.instance:isActive(750)

	if not self._gainPrize and isCanGet then
		local eff = self:playViewEffectUniGo("fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", effGo, self.mainGO.transform, true, nil, nil)
	else
		self:stopViewEffectUniGo(effGo)
	end
end

function BindmobileView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")
	local effGo = goutil.findChild(cell, "effGo")

	MaterialMgr.resetAll(con)
	self:stopViewEffectUniGo(effGo)
end

function BindmobileView:_onClickGetPrize()
	local isCanGet = RedPointModel.instance:isActive(750)

	if not self._gainPrize and isCanGet then
		BindMobileAgent.instance:sendPM_BindMobileGainPrizeReq()
	end
end

function BindmobileView:_onCLickClear()
	self._phoneInput:SetText("")
end

function BindmobileView:_onClickGetCode()
	local now = ServerTime.now()
	local left = self._sendCaptchaCdTimeMillis - now

	if left > 0 then
		return
	end

	local str = self._phoneInput:GetText()

	if string.match(str, PHONE_REG) == str then
		BindMobileAgent.instance:sendPM_BindMobileGetCaptchaReq(str)
	else
		TipsFacade.instance:openCommonTips("请检查手机号")
	end
end

function BindmobileView:_onClickOk()
	local str = self._phoneInput:GetText()

	if string.match(str, PHONE_REG) == str then
		local captcha = self._codeInput:GetText()

		if not string.nilorempty(captcha) then
			BindMobileAgent.instance:sendPM_BindMobileBindReq(str, captcha)
		else
			TipsFacade.instance:openCommonTips("请输入正确验证码")
		end
	else
		TipsFacade.instance:openCommonTips("请检查手机号")
	end
end

return BindmobileView
