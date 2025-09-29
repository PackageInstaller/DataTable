-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/cell/AirWorkShopDynMsgCell.lua

module("logic.extensions.airworkshop.cell.AirWorkShopDynMsgCell", package.seeall)

local M = class("AirWorkShopDynMsgCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()

	self._txtPlayerName = goutil.findChildComponent(mainGO, "txtName", UIComponentType.Text)
	self._txtTime = goutil.findChildComponent(mainGO, "txtTime", UIComponentType.Text)
	self._btnJump = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnJump"))
	self._goRootLevel = goutil.findChild(mainGO, "objLevel")
	self._imgLevel = goutil.findChildComponent(mainGO, "objLevel/imgLevel", UIComponentType.Image)
	self._txtLevelId = goutil.findChildComponent(mainGO, "objLevel/txtID", UIComponentType.Text)
	self._btnPlayer = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "btnPlayer"))
	self._imgPlayerMask = goutil.findChildComponent(mainGO, "btnPlayer/maskIcon", UIComponentType.Image)
	self._goStateMsgRoot = goutil.findChild(mainGO, "stateMessage")
	self._imgEmoji = goutil.findChildComponent(mainGO, "stateMessage/imgEmoji", UIComponentType.Image)
	self._goVoiceMark = goutil.findChild(mainGO, "stateMessage/imgVoice")
	self._txtMsg = goutil.findChildComponent(mainGO, "stateMessage/txtMessage", UIComponentType.TextMeshProUGUI)
	self._btnVoice = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "stateMessage/btnVoice"))
	self._goStateLikeRoot = goutil.findChild(mainGO, "stateLike")
	self._goStateRecordRoot = goutil.findChild(mainGO, "stateRecord")
	self._goRecordWin = goutil.findChild(mainGO, "stateRecord/objWin")
	self._goRecordFail = goutil.findChild(mainGO, "stateRecord/objFail")
	self._scrollRecord = goutil.findChildComponent(mainGO, "stateRecord/scrollView", UIComponentType.ScrollRect)
end

function M:destroyUI()
	self:setHandler(nil)

	for _, theItem in pairs(self._heroCell or {}) do
		theItem.career:destroy()
		IconLoader.clearSprite(theItem.imgIcon)
	end

	self._heroCell = nil
	self._leaveMsgMo = nil
	self._playerInfo = nil
	self.mainGO = nil
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	self._btnJump:AddClickListener(self._onClickJump, self)
	self._btnPlayer:AddClickListener(self._onClickPlayer, self)
	self._btnVoice:AddClickListener(self._onClickVoice, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, self._onSceneImageUpdate, self)
	self._btnJump:RemoveClickListener()
	self._btnPlayer:RemoveClickListener()
	self._btnVoice:RemoveClickListener()
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getMainGo()
	return self.mainGO
end

function M:_onClickJump()
	if self._mapId then
		local levelMo = AirWorkMapModel.instance:getLevelMOById(self._mapId)

		if levelMo then
			AirWorkShopModel.instance:saveLastEditLevelMo(levelMo)
		end

		AirWorkShopDefMgr.instance:tryEnterCreateMode()
	end
end

function M:_onClickPlayer()
	if self._playerInfo then
		local bindGo = self._btnPlayer.gameObject
		local uid = self._playerInfo.userId
		local playerLv = self._playerInfo.playerLv
		local portrait = self._playerInfo.portrait
		local nickName = self._playerInfo.nickname

		ToolTipsMgr.showPlayerInfoTips(bindGo, uid, playerLv, portrait, nickName)
	end
end

function M:_onClickVoice()
	if self._mapNewType ~= GameEnum.AirMapNewsEnum.Comment then
		return
	end

	if not self._leaveMsgMo then
		return
	end

	self._leaveMsgMo:playVoice()
end

function M:_onSceneImageUpdate(_, cover)
	if self._cover == cover then
		self:_updateSceneImage(cover)
	end
end

function M:_updateSceneImage(cover)
	AirWorkShopUtil.loadSceneImage(self._imgLevel, cover, true)
end

function M:_updateBaseData(airWorkMapNewsMO, mapNewType)
	self._mapNewType = mapNewType
	self._mapId = airWorkMapNewsMO:getId()
	self._cover = airWorkMapNewsMO:getCover()
	self._time = airWorkMapNewsMO:getTime()
	self._playerInfo = airWorkMapNewsMO:getPlayerInfo()

	self:_updateSceneImage(self._cover)

	self._txtTime.text = ServerTime.formatTimeServerLook(self._time * 0.001, "%Y/%m/%d")
	self._txtPlayerName.text = self._playerInfo.nickname
	self._txtLevelId.text = string.format("ID:%s", self._mapId)

	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(self._playerInfo.portrait)

	if portraitCO then
		IconLoader.setSprite(self._imgPlayerMask, IconType.PlayerInfoMask, portraitCO.icon)
	end
end

function M:updateDataMsg(airWorkMapNewsMO, mapNewType)
	self:_updateBaseData(airWorkMapNewsMO, mapNewType)
	goutil.setActive(self._goStateMsgRoot, true)
	goutil.setActive(self._goStateLikeRoot, false)
	goutil.setActive(self._goStateRecordRoot, false)

	if not self._leaveMsgMo then
		self._leaveMsgMo = LeaveMsgMO.New()
	end

	self._leaveMsgMo:updateFromMessageCompositeNO(airWorkMapNewsMO:getMsg())

	local voice = self._leaveMsgMo:getVoice()

	if voice > 0 then
		self._txtMsg.text = self._leaveMsgMo:getPageAllFinish(LeaveMsgEnum.MsgType.Voice) and "<line-indent=5%>" .. self._leaveMsgMo:getPreviewMsg() or ""
	else
		self._txtMsg.text = self._leaveMsgMo:getPageAllFinish(LeaveMsgEnum.MsgType.Word) and self._leaveMsgMo:getPreviewMsg() or ""
	end

	goutil.setActive(self._goVoiceMark, voice > 0)

	local emoji = self._leaveMsgMo:getEmoji()

	if emoji and emoji > 0 then
		goutil.setActive(self._imgEmoji.gameObject, true)

		local cfg = ChatConfig.instance:getConfigByKey(ConfigName.ChatEmoji, emoji)

		IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, cfg.icon)
	else
		goutil.setActive(self._imgEmoji.gameObject, false)
	end
end

function M:updateDataLike(airWorkMapNewsMO, mapNewType)
	self:_updateBaseData(airWorkMapNewsMO, mapNewType)
	goutil.setActive(self._goStateMsgRoot, false)
	goutil.setActive(self._goStateLikeRoot, true)
	goutil.setActive(self._goStateRecordRoot, false)
end

function M:updateDataDefence(airWorkMapNewsMO, mapNewType)
	self:_updateBaseData(airWorkMapNewsMO, mapNewType)
	goutil.setActive(self._goStateMsgRoot, false)
	goutil.setActive(self._goStateLikeRoot, false)
	goutil.setActive(self._goStateRecordRoot, true)
	goutil.setActive(self._goRecordWin, airWorkMapNewsMO:getWin())
	goutil.setActive(self._goRecordFail, not airWorkMapNewsMO:getWin())

	self._scrollRecord.horizontalNormalizedPosition = 0

	local listNewsHeroNO = airWorkMapNewsMO:getHeroList()
	local len = listNewsHeroNO and #listNewsHeroNO or 0
	local rectTrRoot = self._scrollRecord.content

	while len > rectTrRoot.childCount do
		local sourceGo = rectTrRoot:GetChild(0).gameObject
		local go = goutil.cloneAndSetParent(sourceGo, rectTrRoot)
	end

	for i = 0, rectTrRoot.childCount - 1 do
		local go = rectTrRoot:GetChild(i).gameObject
		local show = i < len

		if show then
			local heroId = listNewsHeroNO[i + 1].heroId
			local heroLv = listNewsHeroNO[i + 1].lv

			self:_updateHeroItem(go, heroId, heroLv)
		end

		goutil.setActive(go, show)
	end

	self._scrollRecord.enabled = len > 5
end

function M:_updateHeroItem(go, heroId, heroLv)
	if not self._heroCell then
		self._heroCell = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._heroCell[key]

	if not theItem then
		theItem = {
			go = go,
			imgIcon = goutil.findChildImageComponent(go, "pos/normal/headScale/heroIcon"),
			imgQualityGrid = goutil.findChildImageComponent(go, "pos/normal/imgQuality"),
			imgQualityLine = goutil.findChildImageComponent(go, "pos/normal/imgQuality/imgLine"),
			txtLv = goutil.findChildTextComponent(go, "pos/normal/txtLv"),
			career = UIBattleCareer.New(goutil.findChild(go, "pos/normal/career"))
		}
		self._heroCell[key] = theItem
	end

	theItem.txtLv.text = string.format("Lv.%s", heroLv)

	local itemInfo = CharacterConfig.instance:getCfgInfoByID(heroId)

	theItem.career:setCareerAndColorType(itemInfo.career, itemInfo.colorType)

	local modelCO = ModelConfig.instance:getModelConfig(itemInfo.modelId)

	IconLoader.setSprite(theItem.imgIcon, IconType.RoleHeadIcon, modelCO.headIconName)
	IconLoader.setSprite(theItem.imgQualityGrid, IconType.Skinlib, CommEnum.Quality2SamllIcon[itemInfo.quality])
	IconLoader.setSprite(theItem.imgQualityLine, IconType.Skinlib, CharacterCOUtil.quality2LineName(itemInfo.quality))
end

return M
