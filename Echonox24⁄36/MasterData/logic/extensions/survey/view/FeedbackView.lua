-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/view/FeedbackView.lua

module("logic.extensions.survey.view.FeedbackView", package.seeall)

local M = class("FeedbackView", ViewComponent)
local json = require("cjson")

function M:buildUI()
	self._btnClose = self:getBtn("1&universal_second_tips_common_bg_1201003252")
	self._txtTitle = self:getUIComponent("survey_tips_707196451", UIComponentType.InputFieldAdapter)
	self._txtContent = self:getUIComponent("feedback_tips_2043161020", UIComponentType.InputFieldAdapter)
	self._btnPicSubmit = self:getBtn("feedback_tips_1599233880")
	self._txtHint = self:getText("feedback_tips_1804147866")
	self._btnCancel = self:getBtn("feedback_tips_109191743")
	self._btnSubmit = self:getBtn("3&btn_right_1251431307")
	self._btnClose2 = self:getBtn("2&btn_left_-1571983320")
	self._feedbackPanel = self:getGo("feedback_tips_105758917")
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnPicSubmit:AddClickListener(self._onClickPic, self)
	self._btnCancel:AddClickListener(self._onClickCancel, self)
	self._btnSubmit:AddClickListener(self._onClickSubmit, self)
	self._btnClose2:AddClickListener(self._onClickClose, self)
	GlobalDispatcher:addEventListener(EventType.PICK_IMG_EVENT, self._onImgLoaded, self)
	PhotoPicker.registerPickImageListener(self._pickImg)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnPicSubmit:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnSubmit:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.PICK_IMG_EVENT, self._onImgLoaded, self)
	PhotoPicker.unregisterPickImageListener()
end

local FEEDBACK_COUNT = "feedback_count"
local FEEDBACK_DATA = "feedback_data"

function M:onEnter()
	goutil.setActive(self._feedbackPanel, true)
	goutil.setActive(self._btnCancel.gameObject, false)

	self._hasImg = false

	self._txtTitle:SetText("")
	self._txtContent:SetText("")

	self._txtHint.text = "可上传png/jpg/jpeg格式截图，附件大小不超过10M"
end

function M:_onImgLoaded(evt, hint)
	self._txtHint.text = hint
	self._hasImg = true

	goutil.setActive(self._btnCancel.gameObject, self._hasImg)
end

function M._pickImg(filePath, status, filename)
	if status ~= 0 then
		return
	end

	printWarn(filePath, filename)

	M._imgurl = filePath

	local imgName = string.match(filePath, "([^/]+)$")

	if filename then
		imgName = filename
	end

	M._imgSize = SpaceXFileUtil.GetSizeImg(filePath)

	local hint = false

	if M._imgSize > 10240 then
		hint = string.format("%s(<color=#c93b3b>%.1fMB</color>)", imgName, M._imgSize / 1024)
	elseif M._imgSize >= 1024 then
		hint = string.format("%s(%.1fMB)", imgName, M._imgSize / 1024)
	else
		hint = string.format("%s(%.1fKB)", imgName, M._imgSize)
	end

	GlobalDispatcher:dispatchEvent(EventType.PICK_IMG_EVENT, hint)
end

function M:_onClickPic()
	if Astral.OSDef.RunOS ~= Astral.OSDef.Android and Astral.OSDef.RunOS ~= Astral.OSDef.IOS then
		FloatWordMgr.instance:show("不支持的平台")

		return
	end

	PhotoPicker.pickImage(1, 1, nil, nil, false)
end

function M:_onClickCancel()
	self._hasImg = false
	self._txtHint.text = "可上传png/jpg/jpeg格式截图，附件大小不超过10M"

	goutil.setActive(self._btnCancel.gameObject, self._hasImg)
end

function M:_onClickSubmit()
	local url = BootstrapGameConfigMgr.getFeedbackUrl() .. "v3/addfeedback.json"
	local params = {
		param0 = {
			{
				feedbackType = "建议",
				account = SDKGameRoleInfo.roleName,
				content = self._txtContent:GetText(),
				createDate = tonumber(ServerTime.now() .. "000"),
				feedbacker = SDKGameRoleInfo.roleName,
				gameId = SDKManager.getSDKInstacne():getGameId(),
				platformId = BootstrapUtil.getPlatformId(),
				title = self._txtTitle:GetText(),
				userId = tonumber(SDKGameRoleInfo.roleId),
				zoneId = BootstrapGameConfigMgr.getZoneId(),
				zoneName = LoginModel.instance:getServerName()
			}
		}
	}
	local paramjson = json.encode(params)

	if not self:_checkCount() then
		return
	end

	if self._hasImg then
		if self:_checkImg(self._imgurl) then
			SpaceXFileUtil.AddPhotoPost(self._imgurl, paramjson, url)
		else
			return
		end
	else
		HttpUtils.PostJson(url, paramjson)
	end

	local today = ServerTime.formatNow("%x")
	local record = Astral.LocalStorage.Instance:GetString(FEEDBACK_DATA)
	local count = Astral.LocalStorage.Instance:GetInt(FEEDBACK_COUNT)

	if today ~= record then
		count = 0
	end

	Astral.LocalStorage.Instance:SetString(FEEDBACK_DATA, today)
	Astral.LocalStorage.Instance:SetInt(FEEDBACK_COUNT, count + 1)
	FloatWordMgr.instance:show(lang("tips_feed_back_thanks_1"))
	self:close()
end

function M:_checkCount()
	if self._txtContent:GetText() == "" or self._txtTitle:GetText() == "" then
		FloatWordMgr.instance:show("标题和内容不能为空")

		return false
	end

	local today = ServerTime.formatNow("%x")
	local record = Astral.LocalStorage.Instance:GetString(FEEDBACK_DATA)
	local count = Astral.LocalStorage.Instance:GetInt(FEEDBACK_COUNT)

	if record == today and count > 2 then
		FloatWordMgr.instance:show("今天提交次数已达3次，无法提交")

		return false
	end

	return true
end

function M:_checkImg(url)
	if self._imgSize > 10240 then
		FloatWordMgr.instance:show("图片大小超过10M，无法提交")

		return false
	end

	if not SpaceXFileUtil.CheckImgType(url) then
		FloatWordMgr.instance:show("图片格式错误，只能选择png/jpg/jpeg格式")

		return false
	end

	return true
end

function M:_onClickClose()
	self:close()
end

return M
