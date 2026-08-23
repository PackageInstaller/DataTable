local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local FavoStoryComp = class("FavoStoryComp", require("app.fairyGUI.knightFavorability.UI_FavoSoundComp"))

function FavoStoryComp:ctor(arg_1_1)
	self._curLevel = 0
	self._resId = 0
	self._curPlayingIndex = nil
	self._soundDataArr = {}
	self._playedSoundDataDict = {}
	self._knightFavoStruct = nil

	self.m_soundList:setVirtual()
	self.m_soundList:doFairyBatching(false)
	self.m_soundList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_soundList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onItemsClick))
end

function FavoStoryComp:onUnload()
	self:_setSoundHasHeard()
	KnightVoiceCommon.stopVoice()
end

function FavoStoryComp:_setSoundHasHeard()
	if not self._knightFavoStruct then
		return
	end

	local var_3_0 = table.values(self._playedSoundDataDict)

	if #var_3_0 > 0 then
		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			iter_3_1.isPlayed = true
		end

		self._knightFavoStruct:setSoundsPlayed(self._resId, var_3_0)

		self._playedSoundDataDict = {}
	end
end

function FavoStoryComp:updateView(arg_4_1, arg_4_2)
	self:_setSoundHasHeard()

	if not arg_4_1 then
		return
	elseif not arg_4_2 or arg_4_2 < 1 then
		return
	elseif arg_4_2 == self._resId then
		self._soundDataArr = arg_4_1:getSoundDataArr(arg_4_2)

		self.m_soundList:setNumItems(#self._soundDataArr)
	else
		self._resId = arg_4_2
		self._knightFavoStruct = arg_4_1
		self._soundDataArr = arg_4_1:getSoundDataArr(arg_4_2)
		self._curLevel = arg_4_1:getBaseKnightInfo():getFavoLevel()

		KnightVoiceCommon.stopVoice()
		self.m_soundList:setNumItems(#self._soundDataArr)
		self.m_soundList:scrollToView(0)
		self.m_soundList:transitionShowCells("enter_down", 0.03)
	end
end

function FavoStoryComp:_onItemRenderer(arg_5_1, arg_5_2)
	local var_5_0 = self._soundDataArr[arg_5_1 + 1]
	local var_5_1 = self._curLevel >= self._soundDataArr[arg_5_1 + 1].unlockLevel

	if self._curLevel >= self._soundDataArr[arg_5_1 + 1].unlockLevel and not var_5_0.isPlayed then
		self._playedSoundDataDict[arg_5_1 + 1] = var_5_0
	end

	arg_5_2:updateCell({
		index = arg_5_1 + 1,
		resId = self._resId,
		favoStruct = self._knightFavoStruct,
		soundData = var_5_0,
		unlocked = var_5_1,
		unlockLevel = var_5_0.unlockLevel
	})
end

function FavoStoryComp:_onItemsClick(arg_6_1)
	local var_6_0 = arg_6_1:getDataValue()

	for iter_6_0, iter_6_1 in ipairs((self.m_soundList:getChildren())) do
		iter_6_1:onClickItem(var_6_0 + 1)
	end
end

return FavoStoryComp
