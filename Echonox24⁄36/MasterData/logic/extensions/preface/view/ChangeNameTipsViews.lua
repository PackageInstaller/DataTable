-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/view/ChangeNameTipsViews.lua

module("logic.extensions.preface.view.ChangeNameTipsViews", package.seeall)

local ChangeNameTipsViews = class("ChangeNameTipsViews", ViewComponent)
local maxCount = 14

function ChangeNameTipsViews:buildUI()
	self._btnOK = self:getBtn("start_benamed_view_-774906132")
	self._iptName = self:getInput("start_benamed_view_-690492698")
	self._txtDefault = self:getText("start_benamed_view_-135630089")
end

function ChangeNameTipsViews:bindEvents()
	self._btnOK:AddClickListener(self._onClickOk, self)
	self._iptName:AddOnValueChanged(self._onNameChange, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_ROLE_NAME_SUC, self._onChangeNameSuc, self)
end

function ChangeNameTipsViews:unbindEvents()
	self._btnOK:RemoveClickListener()
	self._iptName:RemoveOnValueChanged()
	GlobalDispatcher:removeEventListener(EventType.UPDATE_ROLE_NAME_SUC, self._onChangeNameSuc, self)
end

function ChangeNameTipsViews:destroyUI()
	self._btnOK = nil
end

function ChangeNameTipsViews:onEnter()
	self._nextPlotId = self:getFirstParam()
	self._txtDefault.text = PlayerModel.instance:getNickName()
end

function ChangeNameTipsViews:onExit()
	self._iptName:SetText("")
	StoryMgr.instance:clearStep()

	if not string.nilorempty(self._nextPlotId) then
		StoryMgr.instance:startSingle(self._nextPlotId)
	end
end

function ChangeNameTipsViews:_onNameChange(nickName)
	if string.nilorempty(nickName) then
		return
	end

	local limitCount = StringUtil.getCharacterLimit(nickName, maxCount)

	self._iptName:SetCharacterLimit(limitCount)
end

function ChangeNameTipsViews:_onChangeNameSuc()
	self:close()
end

function ChangeNameTipsViews:_onClickOk()
	local curNickName = PlayerModel.instance:getNickName()
	local nickName = self._iptName:GetText()

	if string.nilorempty(nickName) then
		nickName = string.format("主管%s", PlayerModel.instance:getId())

		self._iptName:SetText(nickName)
	end

	if StringUtil.filterSpecialStr(nickName) then
		FloatWordMgr.instance:show(lang("tip_name_error_1"))

		return
	end

	if nickName == "" or string.gsub(nickName, "^%s*(.-)%s*$", "%1") == "" then
		FloatWordMgr.instance:show(lang("tip_name_error"))

		return
	end

	if StringUtil.getStringLength(nickName) > maxCount then
		FloatWordMgr.instance:show(lang("tip_name_too_long"))

		return
	end

	local nickName = self._iptName:GetText()

	PlayerAgent.instance:sendChangeNicknameRequest(GameEnum.ChangeNicknameTypeEnum.Prologue, nickName)
end

return ChangeNameTipsViews
