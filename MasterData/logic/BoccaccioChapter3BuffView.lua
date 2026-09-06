-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapter3BuffView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapter3BuffView", package.seeall)

local BoccaccioChapter3BuffView = class("BoccaccioChapter3BuffView", ViewComponent)

function BoccaccioChapter3BuffView:ctor()
	BoccaccioChapter3BuffView.super.ctor(self)
end

function BoccaccioChapter3BuffView:unbindEvents()
	BoccaccioChapter3BuffView.super.unbindEvents(self)
end

function BoccaccioChapter3BuffView:bindEvents()
	BoccaccioChapter3BuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BoccaccioChapter3BuffView:buildUI()
	BoccaccioChapter3BuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local goTab = self:getGo("tableview")
	local goCell = self:getGo("tableview/tablecell")

	self._tableview = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BoccaccioChapter3BuffView:onExit()
	BoccaccioChapter3BuffView.super.onExit(self)
	self._tableview:dispose()
	BoccaccioChapterController.instance:setChapter3SelectedBuffId(self._activityId, self._selectBuffId)
end

function BoccaccioChapter3BuffView:onEnter()
	BoccaccioChapter3BuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_BoccaccioChapter3SignUpRes, self._handleSignUp, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 580001
	end

	self._buffCfgs = BoccaccioChapterConfig.instance:getChapter3SignUpBuffDatas(self._activityId) or {}
	self._showBuffCfgs = {}

	local emptyBuffCfg = {}

	emptyBuffCfg.buffId = 0
	emptyBuffCfg.buffDesc = "无效果"
	emptyBuffCfg.signUpDay = 0

	table.insert(self._showBuffCfgs, emptyBuffCfg)

	for _, cfg in ipairs(self._buffCfgs) do
		table.insert(self._showBuffCfgs, cfg)
	end

	self._selectBuffId = BoccaccioChapterController.instance:getChapter3SelectedBuffId(self._activityId) or 0

	self:_checkSignIn()
	self:_updateUIByInfo()
end

function BoccaccioChapter3BuffView:_switchSelectBuff(buffId)
	self._selectBuffId = buffId

	self._tableview:reloadData(self._showBuffCfgs)
end

function BoccaccioChapter3BuffView:_checkSignIn()
	local hasSignUpDays = 0
	local isSignUp = false
	local subMo = BoccaccioChapterController.instance:getSubMo(self._activityId)

	if subMo then
		local chapter3Info = subMo:getChapterInfo(BoccaccioChapterEnum.ChapterId_3)

		if chapter3Info then
			hasSignUpDays = checknumber(chapter3Info.hasSignUpDays)
			isSignUp = chapter3Info.isSignUpToday
		end
	end

	if isSignUp then
		return
	end

	local maxBuffCfg = self._buffCfgs[#self._buffCfgs]

	if hasSignUpDays >= checknumber(maxBuffCfg.signUpDay) then
		return
	end

	BoccaccioChapterController.instance:sendPM_BoccaccioChapter3SignUpReq(self._activityId)
end

function BoccaccioChapter3BuffView:_handleSignUp()
	FloatWordMgr.instance:show("签到成功")
	self:_updateUIByInfo()
end

function BoccaccioChapter3BuffView:_updateUIByInfo()
	self._hasSignUpDays = 0

	local subMo = BoccaccioChapterController.instance:getSubMo(self._activityId)

	if subMo then
		local chapter3Info = subMo:getChapterInfo(BoccaccioChapterEnum.ChapterId_3)

		if chapter3Info then
			self._hasSignUpDays = checknumber(chapter3Info.hasSignUpDays)
		end
	end

	self._tableview:reloadData(self._showBuffCfgs)
end

function BoccaccioChapter3BuffView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local txtLv = goutil.findChildTextComponent(go, "txtLv")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtLock = goutil.findChildTextComponent(go, "txtLock")
	local btnSelect = goutil.findChild(go, "btnSelect")
	local mark = goutil.findChild(go, "btnSelect/mark")
	local buffId = checknumber(data.buffId)

	goutil.setActive(mark, self._selectBuffId == buffId)

	txtLv.text = string.format("%s级", checknumber(data.buffId))
	txtDesc.text = data.buffDesc or ""

	local signUpDay = checknumber(data.signUpDay)

	if signUpDay > self._hasSignUpDays then
		txtLock.text = string.format("再签到%s天解锁", signUpDay - self._hasSignUpDays)

		goutil.setActive(btnSelect, false)
	else
		txtLock.text = ""

		goutil.setActive(btnSelect, true)
	end

	GameUtil.addClickHandler(btnSelect, function()
		self:_switchSelectBuff(buffId)
	end, self)
end

function BoccaccioChapter3BuffView:_clearCell(cell)
	local go = cell.gameObject
	local btnSelect = goutil.findChild(go, "btnSelect")

	GameUtil.rmClickHandler(btnSelect)
end

return BoccaccioChapter3BuffView
