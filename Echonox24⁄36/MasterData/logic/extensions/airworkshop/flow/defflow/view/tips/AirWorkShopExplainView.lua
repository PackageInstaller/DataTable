-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/tips/AirWorkShopExplainView.lua

module("logic.extensions.airworkshop.flow.defflow.view.tips.AirWorkShopExplainView", package.seeall)

local M = class("AirWorkShopExplainView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("middle_tips_common_bg/btnClose")
	self._btnBg = self:getBtnByPath("middle_tips_common_bg/clickExit")
	self._tabPanelGo = self:getGoByPath("allContent/left_tab_list/scrollViewTab")
	self._tabLoopGridView = LoopGridViewHelper.New(self._tabPanelGo)

	self._tabLoopGridView:InitGridView(0, self._updateScrollTab, self)

	self._videoPanelGo = self:getGoByPath("allContent/layout/objVideo")
	self._PhotoPanelGo = self:getGoByPath("allContent/layout/objPhoto")
	self._textPanelGo = self:getGoByPath("allContent/layout/objText")
	self._descTitleTxt = self:getTextByPath("allContent/layout/objText/txtTitle")
	self._descTxt = goutil.findChildComponent(self.mainGO, "allContent/layout/objText/txtContent", typeof(TMPro.TMP_Text))
	self._descImg = UIComponentType.ImageBigBG(self:getGoByPath("allContent/layout/objPhoto/imgPhoto"))
	self._video1Mgr = CriWareVideoMgr.Get(self:getGoByPath("allContent/layout/objVideo/video1"))
	self._video2Mgr = CriWareVideoMgr.Get(self:getGoByPath("allContent/layout/objVideo/video2"))
	self._btnVideo = self:getBtnByPath("allContent/layout/objVideo/btnClick")
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)
	self._btnVideo:AddClickListener(self._onClickVideo, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()
	self._btnVideo:RemoveClickListener()
end

function M:onDestroy()
	if self._video1Mgr then
		self._video1Mgr:DestroyMovie()
	end

	if self._video2Mgr then
		self._video2Mgr:DestroyMovie()
	end

	self._tabLoopGridView:Dispose()
end

function M:onEnter()
	self._videoIndex = 1

	self:_initExplain()
	self._tabLoopGridView:SetListItemCount(#self._explainCOList)
	self:_onSelectTab(1)
end

function M:_initExplain()
	if self._explainCOList then
		return
	end

	self._explainCOList = {}

	local coList = AirWorkShopConfig.instance:getAllAirExplainCO()

	for k, v in pairs(coList) do
		table.insert(self._explainCOList, v)
	end
end

function M:onExit()
	self._video1Mgr:Reset()
	self._video2Mgr:Reset()
	self._descImg:ClearImage()
end

function M:_updateScrollTab(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._tabLoopGridView:NewListViewItem("tab_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, AirWorkShopExplainItem)
	local co = self._explainCOList[curIndex]

	itemView:setData(co.tabName, curIndex)
	itemView:setSeleted(curIndex == self._selectIdx)
	itemView:setClickCallBack(self._onSelectTab, self)

	return item
end

function M:_onSelectTab(idx)
	self._selectIdx = idx

	self._tabLoopGridView:RefreshAllShownItem()
	self:_refreshRightPanel(self._selectIdx)
end

function M:_refreshRightPanel()
	local explainCO = self._explainCOList[self._selectIdx]
	local hasVideo = not string.nilorempty(explainCO.video)
	local hasImage = not string.nilorempty(explainCO.image)
	local hasText = not string.nilorempty(explainCO.text)

	self._descTitleTxt.text = explainCO.tabName

	goutil.setActive(self._videoPanelGo, hasVideo)
	goutil.setActive(self._PhotoPanelGo, hasImage)
	goutil.setActive(self._textPanelGo, hasText)

	if hasVideo then
		local fullVideoPath = GameUrl.getVideoUrl(string.format("air_workshop/%s", explainCO.video))

		self._curVideoPath = fullVideoPath

		local videoMgr = self:_getVideoMgr()

		videoMgr:StopMovie()

		self._videoIndex = self._videoIndex == 1 and 2 or 1
		videoMgr = self:_getVideoMgr()

		videoMgr:PlayMovie(fullVideoPath, true, true, self._onPlayFinished, self)
	else
		local videoMgr = self:_getVideoMgr()

		videoMgr:StopMovie()
	end

	if hasImage then
		self._descImg:SetImage(string.format("ui/bigbg/air_workshop/teach/%s.png", explainCO.image), nil, self)
	end

	if hasText then
		self._descTxt.text = explainCO.text
	end
end

function M:_onPlayFinished()
	return
end

function M:_getVideoMgr()
	if self._videoIndex == 1 then
		return self._video1Mgr
	else
		return self._video2Mgr
	end
end

function M:_onClickClose()
	self:close()
end

function M:_onClickVideo()
	if self._curVideoPath then
		ViewMgr.instance:open(ViewName.VideoPlayerView, self._curVideoPath, true)
	end
end

return M
