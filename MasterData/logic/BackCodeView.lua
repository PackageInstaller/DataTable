-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/BackCodeView.lua

module("logic.extensions.playerreturn.view.BackCodeView", package.seeall)

local BackCodeView = class("BackCodeView", ViewComponent)

function BackCodeView:ctor()
	BackCodeView.super.ctor(self)
end

function BackCodeView:bindEvents()
	BackCodeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._exchangeBtn:AddClickListener(self._onClickExchange, self)
end

function BackCodeView:unbindEvents()
	BackCodeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._exchangeBtn:RemoveClickListener()
end

function BackCodeView:buildUI()
	BackCodeView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._inputTxt = self:getInput("input/IptItem")
	self._exchangeBtn = self:getBtn("input/btnExchange")
	self._titleTxt = goutil.findChildTextComponent(self.mainGO, "input/txtTitle")
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "input/txtTip")
end

function BackCodeView:onExit()
	BackCodeView.super.onExit(self)
end

function BackCodeView:destroyUI()
	BackCodeView.super.destroyUI(self)
end

function BackCodeView:onEnter()
	BackCodeView.super.onEnter(self)

	self._titleTxt.text = lang("text_recall_desc_36")
	self._descTxt.text = lang("text_recall_desc_37")

	local osType = BootstrapUtil.getHotUpdateDeviceType()
	local codeStr = ""

	if osType == 0 then
		local str = NativeBridge.instance:invokeString("com.baitian.wrap.ClipboardWrap", "pasteclip")

		if not string.nilorempty(str) then
			codeStr = str
		end
	end

	self._inputTxt:SetText(codeStr)
end

function BackCodeView:_onClickExchange()
	local str = self._inputTxt:GetText()

	if string.nilorempty(str) then
		FloatWordMgr.instance:show(lang("text_recall_desc_37"))

		return
	end

	local list = string.split(str, "：")

	if list == nil or #list == 0 then
		FloatWordMgr.instance:show(lang("text_recall_desc_38"))

		return
	end

	local code = list[#list]

	PlayerReturnController.instance:csGetCIUseCodeReq(code)
	self:close()
end

return BackCodeView
