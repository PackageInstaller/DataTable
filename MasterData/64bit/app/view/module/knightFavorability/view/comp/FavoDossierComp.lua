local var_0_0 = 6
local FavoDossierComp = class("FavoDossierComp", require("app.fairyGUI.knightFavorability.UI_FavoDossierComp"))

function FavoDossierComp:ctor(arg_1_1)
	self._knightInfo = {}
	self._storyInfoList = {}
	self._favoLevel = 0
	self._scrollPane = self:getScrollPane()

	self:_initView()
end

function FavoDossierComp:updateView(arg_2_1)
	self:setIsShow()
	self._scrollPane:setPercY(0)

	self._knightInfo = arg_2_1 or {}

	local var_2_0 = self._knightInfo:getBaseInfoList()

	self._favoLevel = self._knightInfo:getBaseKnightInfo():getFavoLevel()
	self._storyInfoList = self._knightInfo:getStoryList()

	for iter_2_0 = 1, var_0_0 do
		if var_2_0[iter_2_0] and string.len(var_2_0[iter_2_0]) > 0 then
			self["m_info" .. iter_2_0]:setText(var_2_0[iter_2_0])
			self["m_info" .. iter_2_0]:setVisible(true)
		else
			self["m_info" .. iter_2_0]:setVisible(false)
		end
	end

	self.m_info3:setVisible(false)
	self.m_contentList:setNumItems(#self._storyInfoList)
	self.m_contentList:resizeToFit(#self._storyInfoList)
end

function FavoDossierComp:_initView()
	self.m_contentList:setIniter()
	self.m_contentList:setItemRenderer(handler(self, self._onItemRenderer))
end

function FavoDossierComp:_onItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateView(self._storyInfoList[arg_4_1 + 1], self._favoLevel, arg_4_1)
end

function FavoDossierComp:setIsShow()
	for iter_5_0, iter_5_1 in pairs(self._storyInfoList) do
		if iter_5_1.story_unlock <= self._favoLevel then
			self._knightInfo:setStoryPlayedByIndex(iter_5_1)
		else
			break
		end
	end
end

function FavoDossierComp:onUnload()
	self:setIsShow()
end

return FavoDossierComp
