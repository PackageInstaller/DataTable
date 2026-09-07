local PuzzleConnectDetail = class("PuzzleConnectDetail")

function PuzzleConnectDetail:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._leftIcon1 = findTF(self._tf, "ad/leftIcon1/mask/img")
	self._leftIcon2 = findTF(self._tf, "ad/leftIcon2/mask/img")
	self._playerDesc = findTF(self._tf, "ad/playerDesc")
	self._progressTitle = findTF(self._tf, "ad/progressTitle")
	self._chatText = findTF(self._tf, "ad/chat/text")
	self._btnGo = findTF(self._tf, "ad/btnGo")
	self._btnGoText = findTF(self._tf, "ad/btnGo/text")

	onButton(self._event, self._btnGo, function()
		self._stateType = PuzzleConnectMediator.GetPuzzleActivityState(self._configData.id, self._activity)

		if self._stateType == PuzzleConnectMediator.state_collection then
			pg.m02:sendNotification(GAME.GO_SCENE, SCENE.LEVEL)
		elseif self._stateType == PuzzleConnectMediator.state_puzzle then
			self._event:emit(PuzzleConnectLayer.OPEN_GAME, self._data)
		elseif self._stateType == PuzzleConnectMediator.state_connection then
			self._event:emit(PuzzleConnectLayer.OPEN_GAME, self._data)
		end

		return
	end, SFX_CONFIRM)
	onButton(self._event, findTF(self._tf, "ad/btnClose"), function()
		self._event:emit(PuzzleConnectLayer.OPEN_MENU)

		return
	end, SFX_CONFIRM)
	onButton(self._event, findTF(self._tf, "bottom"), function()
		self._event:emit(PuzzleConnectLayer.OPEN_MENU)

		return
	end, SFX_CONFIRM)

	self._timer = Timer.New(function()
		self._chatIndex = self._chatIndex + 1

		if self._chatIndex > self._chatLengh then
			self._timer:Stop()

			return
		end

		setText(self._chatText, (utf8.sub(self._chatStr, 1, self._chatIndex)))

		return
	end, 0.1, -1)

	setText(findTF(self._tf, "ad/title/text"), i18n("tolovegame_puzzle_title_desc"))

	return
end

function PuzzleConnectDetail:startChat()
	self._chatIndex = 1

	self._timer:Start()

	return
end

function PuzzleConnectDetail:show()
	setActive(self._tf, true)

	return
end

function PuzzleConnectDetail:hide()
	self._timer:Stop()
	setActive(self._tf, false)

	return
end

function PuzzleConnectDetail:setData(arg_9_1)
	self._data = arg_9_1
	self._configData = arg_9_1.data
	self._index = arg_9_1.index
	self._chatStr = self._configData.desc_bubble
	self._chatLengh = utf8.len(self._chatStr)
	self._stepDescList = self._configData.desc_step

	self:updateUI()
	self:startChat()

	return
end

function PuzzleConnectDetail:setActivity(arg_10_1)
	self._activity = arg_10_1

	if not self._configData then
		return
	end

	self._stateType = PuzzleConnectMediator.GetPuzzleActivityState(self._configData.id, self._activity)

	setActive(self._btnGo, true)

	local var_10_0 = self._configData.need[3]
	local var_10_1 = 0

	if self._stateType == PuzzleConnectMediator.state_collection then
		setText(self._btnGoText, i18n("tolovegame_puzzle_detail_collect"))

		var_10_0 = getProxy(PlayerProxy):getData():getResource(pg.activity_tolove_jigsaw[self._configData.id].need[2])
		var_10_1 = 0
	elseif self._stateType == PuzzleConnectMediator.state_puzzle then
		setText(self._btnGoText, i18n("tolovegame_puzzle_detail_puzzle"))

		var_10_1 = 2
	elseif self._stateType == PuzzleConnectMediator.state_connection then
		setText(self._btnGoText, i18n("tolovegame_puzzle_detail_connection"))

		var_10_1 = 3
	elseif self._stateType == PuzzleConnectMediator.state_complete then
		setActive(self._btnGo, false)

		var_10_1 = 4
	end

	for iter_10_0 = 1, #self._stepDescList do
		local var_10_2 = findTF(self._tf, "ad/list/text_" .. iter_10_0)

		setText(var_10_2, self:replaceStr(self._stepDescList[iter_10_0], self._configData.need[3], var_10_0, self._configData.need[3]))

		GetComponent(var_10_2, "RichText").color = iter_10_0 <= var_10_1 and Color.New(0.49, 0.5, 0.53, 1) or Color.New(0.18, 0.16, 0.18, 1)

		if iter_10_0 > 2 and iter_10_0 > var_10_1 + 1 then
			setActive(var_10_2, false)
		else
			setActive(var_10_2, true)
		end
	end

	return
end

function PuzzleConnectDetail:updateUI()
	LoadImageSpriteAsync("SquareIcon/" .. self._configData.portrait_up, self._leftIcon1)
	LoadImageSpriteAsync("SquareIcon/" .. self._configData.portrait_down, self._leftIcon2)
	setText(findTF(self._tf, "ad/player"), i18n("tolovegame_puzzle_ship_need", pg.ship_data_statistics[self._configData.ship_id].name))
	setText(self._playerDesc, self._configData.desc_demand)
	setText(self._progressTitle, i18n("tolovegame_puzzle_task_need"))
	setText(self._chatText, self._configData.desc_bubble)

	return
end

function PuzzleConnectDetail:replaceStr(arg_12_1, ...)
	if arg_12_1 then
		for iter_12_0, iter_12_1 in ipairs({
			...
		}) do
			arg_12_1 = string.gsub(arg_12_1, "$" .. iter_12_0, iter_12_1)
		end

		return arg_12_1
	end

	return arg_12_1
end

function PuzzleConnectDetail:dispose()
	if self._timer and self._timer.running then
		self._timer:Stop()

		self._timer = nil
	end

	return
end

return PuzzleConnectDetail
