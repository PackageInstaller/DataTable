-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/LotteryHacktoolCView.lua

module("logic.extensions.hacktool.view.LotteryHacktoolCView", package.seeall)

local M = class("LotteryHacktoolCView")
local SPACE = " "

local function toLeft(content, formatLength)
	local length = StringUtil.utfstrlen(content)

	if length < formatLength then
		return content .. string.rep(SPACE, formatLength - length)
	end

	return content
end

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._btnLottery = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "btn/btnEnsure"))
	self._btnCopy = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGo, "btn/btnCopy"))
	self._inputMallId = Astral.InputFieldAdapter.GetFrom(self._mainGo, "btn/InputField1")
	self._inputTime = Astral.InputFieldAdapter.GetFrom(self._mainGo, "btn/InputField2")

	local goScroll = goutil.findChild(self._mainGo, "scroll")

	self._goTemplate = goutil.findChild(goScroll, "view/content/temple")

	goutil.setActive(self._goTemplate, false)

	self._scrollTransition = goutil.addComponentOnce(goScroll, typeof(Astral.ScrollRectTransition))
	self._scrollList = Astral.ScrollRectLoop.Get(goScroll)

	self._scrollList:InitFix(kScrollDirV, 1800, 36, 2, 0, 1, self._onCellUpdate, self, nil, self)
end

function M:onEnter()
	self:bindEvents()
	self:_setEvent(true)

	self._resultList = {}

	self:_updateResultList()
end

function M:onExit()
	self:unbindEvents()
	self:_setEvent(false)
	self._inputMallId:SetText("")
	self._inputTime:SetText("")
end

function M:_setEvent(add)
	if add then
		RetrieveDispatcher:addEventListener(RetrieveEventType.onTestLotteryCharacterNO3Reply, self._onTestLotteryCardReply, self)
	else
		RetrieveDispatcher:removeEventListener(RetrieveEventType.onTestLotteryCharacterNO3Reply, self._onTestLotteryCardReply, self)
	end
end

function M:bindEvents()
	self._btnLottery:AddClickListener(self._onClickLottery, self)
	self._btnCopy:AddClickListener(self._onClickCopy, self)
end

function M:unbindEvents()
	self._btnLottery:RemoveClickListener()
	self._btnCopy:RemoveClickListener()
end

function M:_onCellUpdate(cellRect, curIndex, prevIndex)
	curIndex = curIndex + 1

	local itemGo = goutil.findChild(cellRect.gameObject, "item")

	if not itemGo then
		itemGo = goutil.clone(self._goTemplate, "item")

		goutil.setActive(itemGo, true)
		goutil.addChildToParent(itemGo, cellRect.gameObject)
	end

	local lotteryText = itemGo:GetComponent(goutil.Type_UIText)

	lotteryText.text = self._resultList[curIndex]
end

function M:_onClickClose()
	self:close()
end

function M:_onClickLottery()
	local mallId = checkint(self._inputMallId:GetText())
	local time = checkint(self._inputTime:GetText())
	local data = HackToolUtil.createLotteryCmd3(mallId, time)

	HackToolAgent.instance:sendGmRequest(data)
end

function M:_onClickCopy()
	local sb = StringBuffer.New()

	for _, content in pairs(self._resultList) do
		sb:append(content):appendLine()
	end

	TextUtils.SetClipboard(sb:toString())
	FloatWordMgr.instance:show("copy sucess!")
end

function M:_onTestLotteryCardReply(e, msg)
	for i, v in ipairs(msg.results) do
		local sb = StringBuffer.New()

		sb:clear()
		sb:append(toLeft(tostring(v.seq), 10))
		sb:append(toLeft(tostring(v.quality), 8))
		sb:append(toLeft(tostring(v.code), 12))
		sb:append(toLeft(tostring(v.name), 12))

		local rate = string.sub(tostring(v.rate * 100), 0, 5)

		sb:append(toLeft(rate .. "%", 12))
		sb:append(toLeft(tostring(v.tagged), 10))
		table.insert(self._resultList, sb:toString())
	end

	self:_updateResultList()
end

function M:_updateResultList()
	self._scrollList.TotalCellNum = #self._resultList

	self._scrollTransition:FocusCell(0)
end

function M:clearResultList()
	self._resultList = {}
end

return M
