-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/BackShareView.lua

module("logic.extensions.playerreturn.view.BackShareView", package.seeall)

local BackShareView = class("BackShareView", ViewComponent)

function BackShareView:ctor()
	BackShareView.super.ctor(self)
end

function BackShareView:bindEvents()
	BackShareView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._fsCopyBtn:AddClickListener(self._onClickFSShareBtn, self)
end

function BackShareView:unbindEvents()
	BackShareView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._fsCopyBtn:RemoveClickListener()
end

function BackShareView:onExit()
	BackShareView.super.onExit(self)
	SDKManager.unregisterShareListener()
end

function BackShareView:destroyUI()
	BackShareView.super.destroyUI(self)
end

function BackShareView:buildUI()
	BackShareView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._inputTxt = goutil.findChildTextComponent(self.mainGO, "codeInp/codeTxt")
	self._fsCopyBtn = self:getBtn("fsCopyBtn")
	self._tipsTxt = goutil.findChildTextComponent(self.mainGO, "tipsTxt")
	self._tipsTxt.text = ""
end

function BackShareView:onEnter()
	BackShareView.super.onEnter(self)

	local code = self:getFirstParam()

	if string.nilorempty(code) then
		printError("sr--- 回归玩家2 BackShareView:onEnter()   传入的码为空！！")

		return
	end

	local nowTime = ServerTime.now()
	local index = math.floor(nowTime - math.floor(nowTime / 3) * 3)
	local indexStr = "text_recall_desc_" .. index + 30

	self._codeStr = langPara(indexStr, code)
	self._inputTxt.text = self._codeStr

	SDKManager.registerShareListener(function(cade, desc)
		self:_onShareHander(cade, desc)
	end)

	if Clipboard._checkCanUse() then
		GameUtil.SetActive(self._fsCopyBtn, true)
		GameUtil.SetActive(self._tipsTxt, false)
	else
		GameUtil.SetActive(self._fsCopyBtn, false)
		GameUtil.SetActive(self._tipsTxt, true)

		self._tipsTxt.text = lang("text_recall_desc_33")
	end
end

function BackShareView:_onClickQQShareBtn()
	SDKManager.share(SDKManager.SHARE_TEXT, langPara("text_recall_desc_27", self._codeStr), "我的邀请", nil, nil, 3)
	self:close()
end

function BackShareView:_onClickWXShareBtn()
	SDKManager.share(SDKManager.SHARE_TEXT, langPara("text_recall_desc_27", self._codeStr), "我的邀请", nil, nil, 1)
	self:close()
end

function BackShareView:_onClickFSShareBtn()
	NativeBridge.instance:invoke("com.baitian.wrap.ClipboardWrap", "copyclip", {
		content = self._codeStr
	})
	self:close()
end

function BackShareView:_onShareHander(cade, desc)
	local btplatformId = BootstrapUtil.getPlatformId()

	if cade ~= SDKManager.SHARE_STATUS_CODE_SUCCESS and btplatformId ~= 2 and btplatformId ~= 10 then
		-- block empty
	end

	if cade == SDKManager.SHARE_STATUS_CODE_SUCCESS then
		if btplatformId == 2 or btplatformId == 10 then
			TipsFacade.instance:openTipWindow(lang("text_share_name"), lang("text_recall_desc_5"))
		end
	elseif cade == SDKManager.SHARE_STATUS_CODE_FAIL then
		if SDKManager.isShowShareFailDesc() == true then
			TipsFacade.instance:openTipWindow("分享失败", desc)
		end
	elseif cade == SDKManager.SHARE_STATUS_CODE_CANCEL and (btplatformId == 2 or btplatformId == 10) then
		TipsFacade.instance:openTipWindow(lang("text_share_name"), desc)
	end
end

return BackShareView
