-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/player/PlayerInfoBaseFragmentView.lua

module("logic.extensions.playerinfo.view.player.PlayerInfoBaseFragmentView", package.seeall)

local M = class("PlayerInfoBaseFragmentView", DynamicFragmentView)
local NameState2Color = CommEnum.PlayerNameState2Color
local NameState = CommEnum.PlayerNameCreateState
local ViewInfoType = {
	Lihui = 2,
	Info = 1
}
local Attribute = {
	"知识",
	"敏捷",
	"力量",
	"幸运",
	"洞察",
	"沟通"
}
local Data2Img = {
	3,
	2,
	1,
	6,
	5,
	4
}

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._txtName = self._registry:getText("1&player_info_tips_-1766141246")
	self._playerInfoGo = self._registry:getGo("1&player_info_tips_-1751963405")
	self._addAttrPanelGo = self._registry:getGo("player_info_panel_copy_1664383489")
	self._addAttrReturnGo = self._registry:getGo("6&title_view_-478490097")
	self._playerInfoCanvasGroup = goutil.addComponentOnce(self._playerInfoGo, ComponentType.CanvasGroup)
	self._addAttrPanelCanvasGroup = goutil.addComponentOnce(self._addAttrPanelGo, ComponentType.CanvasGroup)
	self._addAttrTitleCanvasGroup = goutil.addComponentOnce(self._addAttrReturnGo, ComponentType.CanvasGroup)
	self._btnAttrPanelClose = self._registry:getBtn("6&title_view_-878360263")
	self._btnAttrPanelHome = self._registry:getBtn("6&title_view_1398742689")

	goutil.setActive(self._btnAttrPanelHome.gameObject, false)

	self._btnEditCard = self._registry:getBtn("1&player_info_tips_-1997304794")
	self._txtLevel = self._registry:getText("1&player_info_tips_copy_328444276")
	self._expProgress = self._registry:getImage("1&player_info_tips_copy_-1388809070")
	self._imgIcon = self._registry:getImage("1&player_info_tips_copy_-1800821240")
	self._imgCard = self._registry:getImage("1&player_info_tips_copy_-595620040")
	self._imgFrame = self._registry:getImage("1&player_info_tips_copy_-832178768")
	self._txtUID = self._registry:getText("1&player_info_tips_-381786658")
	self._txtDirthday = self._registry:getText("1&player_info_tips_-1161882955")
	self._txtMessageBoard = self._registry:getUIComponent("1&player_info_tips_-1718004023", UIComponentType.TextMeshProUGUI)
	self._goMsgVoiceMark = self._registry:getGo("1&player_info_tips_copy_-1809176887")
	self._btnMsgPlayVoice = self._registry:getBtn("1&player_info_tips_copy_-2025662989")
	self._goEmojiRoot = self._registry:getGo("1&player_info_tips_copy_262193796")
	self._imgEmoji = self._registry:getImage("1&4&chat_emoji_item1_-98144409")
	self._btnEdit2 = self._registry:getBtn("1&player_info_tips_-956546531")
	self._btnUpgrade = self._registry:getBtn("3&btn_middle_-31477526")
	self._btnConfirm = self._registry:getBtn("4&btn_middle_-31477526")
	self._btnTips = self._registry:getBtn("5&btn_middle_-31477526")
	self._guiAnimation = goutil.addComponentOnce(self._registry:getMainGO(), typeof(Astral.GUITimelineAniLua))
	self._click2Listener = Astral.UIGlobalTouchTrigger.Get(self.mainGO)
	self._editTips = self._registry:getGo("1&player_info_tips_copy_-1594337425")
	self._btnBirth = self._registry:getBtn("1&player_info_tips_copy_-2021143450")
	self._btnHead = self._registry:getBtn("1&player_info_tips_copy_1996364829")
	self._btnCard = self._registry:getBtn("1&player_info_tips_copy_-1733440669")
	self._btnEditBusinessCard = self._registry:getBtn("1&player_info_tips_copy_-1763073717")
	self._btnName = self._registry:getBtn("1&player_info_tips_copy_-351237424")
	self._btnAutograph = self._registry:getBtn("1&player_info_tips_copy_-1730772201")
	self._btnUID = self._registry:getBtn("1&player_info_tips_copy_-886961759")
	self._editTipsMask = self._registry:getBtn("1&0&empty_mask_tips_29887572")
	self.btn_btnRanking = self._registry:getBtn("player_info_panel_copy_-1513283499")
	self._imgDimensionCur = self._registry:getGo("0&sixdimensioninfo_-492787873"):GetComponent("UIPolygon")
	self._imgDimensionAfter = self._registry:getGo("0&sixdimensioninfo_-450446229"):GetComponent("UIPolygon")
	self._txtSixLevel = {
		self._registry:getText("0&sixdimensioninfo_-2033388935"),
		self._registry:getText("0&sixdimensioninfo_-1335132831"),
		self._registry:getText("0&sixdimensioninfo_-410819544"),
		self._registry:getText("0&sixdimensioninfo_-61014096"),
		self._registry:getText("0&sixdimensioninfo_1337588298"),
		self._registry:getText("0&sixdimensioninfo_-605687856")
	}
	self._btnProperties = {
		self._registry:getBtn("0&sixdimensioninfo_copy_-78348352"),
		self._registry:getBtn("0&sixdimensioninfo_copy_-1809765958"),
		self._registry:getBtn("0&sixdimensioninfo_copy_-54857560"),
		self._registry:getBtn("0&sixdimensioninfo_copy_-521884612"),
		self._registry:getBtn("0&sixdimensioninfo_copy_-769560786"),
		self._registry:getBtn("0&sixdimensioninfo_copy_-1116762816")
	}
	self._imgSelect = {
		self._registry:getGo("0&sixdimensioninfo_copy_1252482582"),
		self._registry:getGo("0&sixdimensioninfo_copy_-2964429"),
		self._registry:getGo("0&sixdimensioninfo_copy_-1927383723"),
		self._registry:getGo("0&sixdimensioninfo_copy_-615180255"),
		self._registry:getGo("0&sixdimensioninfo_copy_1429734893"),
		self._registry:getGo("0&sixdimensioninfo_copy_-1451712010")
	}
	self._txtMax = self._registry:getGo("player_info_panel_copy_-1920007841")
	self._hintGo = self._registry:getGo("player_info_panel_copy_-530474054")
	self._hintRoot = self._registry:getGo("player_info_panel_copy_-612075510")
	self._txtClue = self._registry:getText("player_info_panel_copy_-530474054")
	self._txtCount = self._registry:getText("player_info_panel_copy_-1040267055")
	self._countRootGo = self._registry:getGo("player_info_panel_copy_-67372299")
	self._mainPanel = self._registry:getGo("player_info_panel_-561456922")

	self:_buildRedDot()
	self:_bindRedDot(true)
end

function M:_buildRedDot()
	self._redDotComp = {}

	table.insert(self._redDotComp, {
		dotNode = goutil.findChild(self._registry:getGo("player_info_panel_-561456922"), "red_point").gameObject,
		keyList = {
			GameEnum.RedPointEnum.PlayerCardAttribute
		}
	})
end

function M:_bindRedDot(bind)
	if bind then
		for _, data in ipairs(self._redDotComp) do
			RedDotModel.instance:createDotView({
				dotNode = data.dotNode,
				keyList = data.keyList
			})
		end
	else
		for _, data in ipairs(self._redDotComp) do
			RedDotModel.instance:createDotView({
				dotNode = data.dotNode,
				keyList = {}
			})
		end
	end
end

function M:destroyUI()
	self._redDotComp = nil
end

function M:bindEvents()
	self._btnAttrPanelClose:AddClickListener(self._onClickCloseAddPanel, self)
	self._btnAttrPanelHome:AddClickListener(self._onClickAttrPanelHome, self)
	self._btnEdit2:AddClickListener(self._onClickEdit2, self)
	self._btnUpgrade:AddClickListener(self._onClickOpenAddPanel, self)
	self._btnConfirm:AddClickListener(self._onClickUpgrade, self)
	self._btnEditCard:AddClickListener(self._onClickEditCard, self)
	self._btnBirth:AddClickListener(self._onClickBirth, self)
	self._btnHead:AddClickListener(self._onClickHead, self)
	self._btnCard:AddClickListener(self._onClickCard, self)
	self._btnEditBusinessCard:AddClickListener(self._onClickEditBusinessCard, self)
	self._btnName:AddClickListener(self._onClickName, self)
	self._btnAutograph:AddClickListener(self._onClickAutograph, self)
	self._editTipsMask:AddClickListener(self._onClickMask, self)
	self._btnUID:AddClickListener(self._onClickCopy, self)
	self._btnMsgPlayVoice:AddClickListener(self._onClickMsgPlayVoice, self)
	self.btn_btnRanking:AddClickListener(self._onClickBanking, self)

	for i = 1, 6 do
		-- block empty
	end

	self._txtAttrAddList = {}
	self._btnAttrAddList = {}
	self._btnAttrReduceList = {}

	for i = 1, self._addAttrPanelGo.transform.childCount do
		local childGo = goutil.findChild(self._addAttrPanelGo, "attribute_" .. i)
		local txtAttr = goutil.findChildTextComponent(childGo, "addAttribute/Image1/txtAttribute")
		local btnAdd = UIComponentType.ButtonAdapter(goutil.findChild(childGo, "addAttribute/btnAdd"))
		local btnReduce = UIComponentType.ButtonAdapter(goutil.findChild(childGo, "addAttribute/btnReduce"))

		btnAdd:AddClickListener(function()
			self:_onClickAdd(i)
		end, self)
		btnReduce:AddClickListener(function()
			self:_onClickReduce(i)
		end, self)
		table.insert(self._txtAttrAddList, txtAttr)
		table.insert(self._btnAttrAddList, btnAdd)
		table.insert(self._btnAttrReduceList, btnReduce)
	end

	GlobalDispatcher:addEventListener(EventType.UPDATE_ROLE_NAME_SUC, self._onChangeNameSuc, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_ROLE_NAME_FAIL, self._onChangeNameFail, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_PORTRAIT_SUC, self._onChangePortraitSuc, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_DISPLAYCARD_SUC, self._onChangeDisplayCardSuc, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_BIRTHDAY_SUC, self._onChangeBirthDaysuc, self)
	GlobalDispatcher:addEventListener(EventType.CHANGE_PLAYER_SIGN_SUC, self._onChangeSignsuc, self)
	GlobalDispatcher:addEventListener(EventType.HIDE_PLAYER_DISPLAYCARD, self._onHidePlayerInfo, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_SELECT_HERO_EVENT, self._onReadyChangeHero, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_APPLY_SUCCESS, self._onApplySuccess, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_FRIEND_LIST, self._onApplySuccess, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_ATTRIBUTE_UPGRADE, self._handlePlayerAttributeUpgrade, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._updateRedPoint, self)
end

function M:unbindEvents()
	self._btnAttrPanelClose:RemoveClickListener()
	self._btnAttrPanelHome:RemoveClickListener()
	self._btnEdit2:RemoveClickListener()
	self._btnUpgrade:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
	self._btnEditCard:RemoveClickListener()
	self._btnBirth:RemoveClickListener()
	self._btnHead:RemoveClickListener()
	self._btnCard:RemoveClickListener()
	self._btnEditBusinessCard:RemoveClickListener()
	self._btnName:RemoveClickListener()
	self._btnAutograph:RemoveClickListener()
	self._editTipsMask:RemoveClickListener()
	self._btnUID:RemoveClickListener()
	self._btnMsgPlayVoice:RemoveClickListener()
	self.btn_btnRanking:RemoveClickListener()

	for i = 1, 6 do
		self._btnProperties[i]:RemoveClickListener()
	end

	for i, v in ipairs(self._btnAttrAddList) do
		v:RemoveClickListener()
	end

	for i, v in ipairs(self._btnAttrReduceList) do
		v:RemoveClickListener()
	end

	GlobalDispatcher:removeEventListener(EventType.UPDATE_ROLE_NAME_SUC, self._onChangeNameSuc, self)
	GlobalDispatcher:removeEventListener(EventType.UPDATE_ROLE_NAME_FAIL, self._onChangeNameFail, self)
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_PORTRAIT_SUC, self._onChangePortraitSuc, self)
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_DISPLAYCARD_SUC, self._onChangeDisplayCardSuc, self)
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_BIRTHDAY_SUC, self._onChangeBirthDaysuc, self)
	GlobalDispatcher:removeEventListener(EventType.CHANGE_PLAYER_SIGN_SUC, self._onChangeSignsuc, self)
	GlobalDispatcher:removeEventListener(EventType.HIDE_PLAYER_DISPLAYCARD, self._onHidePlayerInfo, self)
	GlobalDispatcher:removeEventListener(EventType.PLAYER_SELECT_HERO_EVENT, self._onReadyChangeHero, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_APPLY_SUCCESS, self._onApplySuccess, self)
	GlobalDispatcher:removeEventListener(EventType.UPDATE_FRIEND_LIST, self._onApplySuccess, self)
	GlobalDispatcher:removeEventListener(EventType.PLAYER_ATTRIBUTE_UPGRADE, self._handlePlayerAttributeUpgrade, self)
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._updateRedPoint, self)
end

function M:onEnter()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")

	self._viewType = ViewInfoType.Info
	self._birthday = false
	self._isSelf = false
	self._isShowTips = false
	self._playerData = false
	self._playerCardAttribute = {}
	self._addAttribute = {}
	self._curPoints = ItemModel.instance:getItemCountByItemId(1100012)

	local playerCardInfo = PlayerModel.instance:getPlayerCardInfo()

	self:_viewPlayerInfo(playerCardInfo)
	self:_switchView()
	self:_updateRedPoint()
end

function M:onExit()
	self._curSelect = false
	self._birthday = false
end

function M:_handlePlayerAttributeUpgrade(e)
	self:_updateImgSix()
end

function M:_onClickHead()
	ViewMgr.instance:open(ViewName.ChangeMaskView)
	goutil.setActive(self._editTips, false)
end

function M:_onClickCard()
	return
end

function M:_onClickName()
	local info = {}

	info.callBackFunc = self._onNameEditEnd
	info.callBackHandle = self

	ViewMgr.instance:open(ViewName.RenameTipsView, info)
	goutil.setActive(self._editTips, false)
end

function M:_onClickAutograph()
	if not self._isSelf then
		return
	end

	ViewMgr.instance:open(ViewName.PlayerInfoLeaveMsgView, {
		playerCardInfo = self._playerData
	})
end

function M:_onClickMask()
	goutil.setActive(self._editTips, false)
end

function M:_onClickMsgPlayVoice()
	if self._leaveMsgMO then
		self._leaveMsgMO:playVoice()
	end
end

function M:_onClickBanking()
	RankController.instance:enterRankMainView()
end

function M:_onNameEditEnd(name)
	if name == self._tempName then
		FloatWordMgr.instance:show("昵称无变化")

		return
	end

	local editName, state = PlayerCreateController.instance:checkNameState(name)

	if state == NameState.Normal then
		self:_handleTextDetectResult(0, name)
	elseif state ~= NameState.Normal then
		PlayerCreateModel.instance:setNameEditState(state)
	end
end

function M:_handleTextDetectResult(illegal, name)
	local nameState = illegal ~= 0 and NameState.Special or NameState.Normal

	PlayerCreateModel.instance:setNameEditState(nameState)

	if illegal == 0 then
		PlayerAgent.instance:sendChangeNicknameRequest(name)
	end
end

function M:_viewPlayerInfo(playerInfo)
	self._playerData = playerInfo

	local displayHero = playerInfo.displayHero
	local isSelf = playerInfo.userId == PlayerModel.instance:getId()

	self._isSelf = isSelf

	self:_updateText()

	local curExp = playerInfo.exp or 0
	local level = playerInfo.lv
	local maxExp = PlayerConfig.instance:getExpByLevel(level) or 1
	local name = PlayerModel.instance:getNickName()
	local expPercent = curExp / maxExp
	local guildName = playerInfo.guildName

	self._tempName = name

	if isSelf then
		self:_bindRedDot(true)
	else
		name = playerInfo.nickname

		self:_bindRedDot(false)
	end

	self._curUserId = playerInfo.userId
	self._txtUID.text = string.format("%s", self._curUserId)
	self._txtName.text = name

	local itemCO = BackpackConfig.instance:getItemInfoByItemId(playerInfo.portrait)

	if itemCO then
		IconLoader.setSprite(self._imgIcon, IconType.PlayerInfoMask, itemCO.icon)
	end

	for i, v in ipairs(playerInfo.displayCard or {}) do
		self:_setCardOrFrame(v)
	end

	self._txtLevel.text = langF("%d-%d", level / 10, level % 10)
	self._expProgress.fillAmount = PlayerModel.instance:getCurExpPercent()

	self:_parseBirthDay(playerInfo.birthday)

	if string.nilorempty(guildName) then
		guildName = "无"
	end

	local sign = playerInfo:HasField("sign") and playerInfo.sign or false

	self:_updateSign(sign)
	self:_updateImgSix(playerInfo)
	goutil.setActive(self._btnEdit2.gameObject, isSelf)
	goutil.setActive(self.btn_btnRanking.gameObject, isSelf)
end

function M:_setCardOrFrame(itemId)
	local itemCO = BackpackConfig.instance:getItemInfoByItemId(itemId)

	if itemCO then
		local iconType = self:_getIconType(itemId)

		if iconType == 1 then
			IconLoader.setSprite(self._imgCard, IconType.PlayerInfoCard, itemCO.icon2)
		else
			IconLoader.setSprite(self._imgFrame, IconType.PlayerInfoFrame, itemCO.icon2)
		end
	end
end

function M:_onClickSelect(pos)
	if not self._isSelf then
		return
	end

	self._curSelect = pos

	for i = 1, 6 do
		goutil.setActive(self._imgSelect[i], pos == i)
	end

	self:_refreshAttribute()
end

function M:_refreshAttribute()
	self:_changeAddReduceBtnStatus()

	local isMax = true

	for i = 1, 6 do
		if self._playerCardAttribute[i] < 6 then
			isMax = false

			break
		end
	end

	if isMax then
		goutil.setActive(self._txtMax, true)
		goutil.setActive(self._countRootGo, false)
		goutil.setActive(self._btnUpgrade.gameObject, false)
		goutil.setActive(self._btnTips.gameObject, false)
		goutil.setActive(self._btnConfirm.gameObject, false)

		return
	elseif self._curSelect then
		goutil.setActive(self._txtMax, false)
		goutil.setActive(self._hintRoot, false)
		goutil.setActive(self._btnUpgrade.gameObject, false)

		local isAdd = false

		for i, v in ipairs(self._addAttribute) do
			if v > 0 then
				isAdd = true
			end
		end

		goutil.setActive(self._btnTips.gameObject, not isAdd)
		goutil.setActive(self._btnConfirm.gameObject, isAdd)

		self._txtCount.text = self._curPoints

		return
	end

	goutil.setActive(self._txtMax, false)
	goutil.setActive(self._btnUpgrade.gameObject, self._isSelf)
	goutil.setActive(self._countRootGo, self._isSelf)
	goutil.setActive(self._btnTips.gameObject, false)
	goutil.setActive(self._btnConfirm.gameObject, false)

	self._txtCount.text = self._curPoints
end

function M:_updateImgSix(playerInfo)
	playerInfo = playerInfo or PlayerModel.instance:getMyPlayerInfo()

	local value = {}

	for i = 1, 6 do
		local attribute = playerInfo.attribute[i]
		local pos = Data2Img[attribute.id]

		self._addAttribute[i] = 0
		self._txtAttrAddList[i].text = attribute.level
		self._playerCardAttribute[attribute.id] = attribute.level
		value[pos] = attribute.level / 6
		self._txtSixLevel[i].text = attribute.level

		goutil.setActive(self._imgSelect[i], false)
	end

	self._imgDimensionCur:SetValue(value)
	self._imgDimensionAfter:SetValue(value)

	self._txtCount.text = self._curPoints

	local dungeonId = DungeonMainLineChapterModel.instance:getLastDungeonId()
	local configs = PlayerConfig.instance:getAttributeOfMainline()
	local nextAttrDungeonId = 0

	for i, v in ipairs(configs) do
		if dungeonId < v.id then
			nextAttrDungeonId = v.id

			break
		end
	end

	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(nextAttrDungeonId)

	goutil.setActive(self._hintRoot, dungeonCO ~= nil and self._isSelf)

	self._txtClue.text = dungeonCO and string.format(lang("tip_prop_next_get_dungeon"), TaskUtil.getDungeonFormatName(nextAttrDungeonId)) or ""

	self:_refreshAttribute()
end

function M:_changeAddReduceBtnStatus()
	for i, v in ipairs(self._btnAttrAddList) do
		local canvasGroup = self._btnAttrAddList[i].gameObject:GetComponent(ComponentType.CanvasGroup)
		local isMax = self._playerCardAttribute[i] + self._addAttribute[i] == 6

		canvasGroup.alpha = isMax and 0.2 or 1
	end

	for i, v in ipairs(self._btnAttrReduceList) do
		local canvasGroup = self._btnAttrReduceList[i].gameObject:GetComponent(ComponentType.CanvasGroup)
		local isOrign = self._addAttribute[i] == 0

		canvasGroup.alpha = isOrign and 0.2 or 1
	end
end

function M:_onClickAdd(pos)
	self._curSelect = pos

	if self._playerCardAttribute[self._curSelect] + self._addAttribute[self._curSelect] >= 6 then
		return
	end

	if self._curPoints <= 0 then
		FloatWordMgr.instance:show(lang("tip_prop_lack"))

		return
	end

	self._curPoints = self._curPoints - 1
	self._addAttribute[self._curSelect] = self._addAttribute[self._curSelect] + 1

	local valueOrign = self._playerCardAttribute[self._curSelect]
	local valueNew = self._addAttribute[self._curSelect] + valueOrign

	if valueOrign < valueNew then
		self._txtAttrAddList[self._curSelect].text = string.format("<color=#88c1d9>%s</color>", valueNew)
	else
		self._txtAttrAddList[self._curSelect].text = valueNew
	end

	local value = {}

	for i = 1, 6 do
		local pos = Data2Img[i]
		local level = self._playerCardAttribute[i] + self._addAttribute[i]

		value[pos] = level / 6
		self._txtSixLevel[i].text = level
	end

	self._imgDimensionAfter:SetValue(value)
	self:_refreshAttribute()
end

function M:_onClickReduce(pos)
	self._curSelect = pos

	if self._addAttribute[self._curSelect] <= 0 then
		return
	end

	self._curPoints = self._curPoints + 1
	self._addAttribute[self._curSelect] = self._addAttribute[self._curSelect] - 1

	local valueOrign = self._playerCardAttribute[self._curSelect]
	local valueNew = self._addAttribute[self._curSelect] + valueOrign

	if valueOrign < valueNew then
		self._txtAttrAddList[self._curSelect].text = string.format("<color=#88c1d9>%s</color>", valueNew)
	else
		self._txtAttrAddList[self._curSelect].text = valueNew
	end

	local value = {}

	for i = 1, 6 do
		local pos = Data2Img[i]
		local level = self._playerCardAttribute[i] + self._addAttribute[i]

		value[pos] = level / 6
		self._txtSixLevel[i].text = level
	end

	self._imgDimensionAfter:SetValue(value)
	self:_refreshAttribute()
end

function M:_onClickOpenAddPanel()
	if self._curPoints == 0 then
		FloatWordMgr.instance:show(lang("tip_prop_lack"))

		return
	end

	self._curSelect = true

	self:_openAddAttrPanel(true)
	GlobalDispatcher:dispatchEvent(EventType.PLAYER_ATTR_OPEN_CLOSE, true)
end

function M:_onClickCloseAddPanel()
	self._curSelect = false
	self._curPoints = ItemModel.instance:getItemCountByItemId(1100012)

	self:_openAddAttrPanel(false)
	GlobalDispatcher:dispatchEvent(EventType.PLAYER_ATTR_OPEN_CLOSE, false)
end

function M:_onClickAttrPanelHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_openAddAttrPanel(isOpen)
	self._addAttribute = {}

	self:_updateImgSix()

	self._playerInfoCanvasGroup.alpha = isOpen and 1 or 0
	self._addAttrPanelCanvasGroup.alpha = isOpen and 0 or 1
	self._addAttrTitleCanvasGroup.alpha = isOpen and 0 or 1

	goutil.setActive(self._playerInfoGo, true)
	goutil.setActive(self._addAttrPanelGo, true)
	goutil.setActive(self._addAttrReturnGo, true)
	goutil.setActive(self.btn_btnRanking.gameObject, not isOpen)
	self._playerInfoCanvasGroup:DOKill(false)
	self._addAttrPanelCanvasGroup:DOKill(false)
	self._addAttrTitleCanvasGroup:DOKill(false)
	self._playerInfoCanvasGroup:DOFade(isOpen and 0 or 1, 0.5)
	self._addAttrPanelCanvasGroup:DOFade(isOpen and 1 or 0, 0.5)
	self._addAttrTitleCanvasGroup:DOFade(isOpen and 1 or 0, 0.5)
	settimer(0.5, function()
		goutil.setActive(self._playerInfoGo, not isOpen)
		goutil.setActive(self._addAttrPanelGo, isOpen)
		goutil.setActive(self._addAttrReturnGo, isOpen)
	end, self, false)
end

function M:_onClickUpgrade()
	local isAdd = false
	local value = {}

	for i = 1, 6 do
		local pos = Data2Img[i]
		local level = self._playerCardAttribute[i] + self._addAttribute[i]

		value[pos] = level / 6

		if self._addAttribute[i] > 0 then
			isAdd = true

			PlayerAgent.instance:sendUpgradePlayerCardAttributeRequest(i, level)

			self._addAttribute[i] = 0
		end
	end

	self._imgDimensionCur:DotweenValue(value, 0.5)

	if not isAdd then
		if self._curPoints == 0 then
			FloatWordMgr.instance:show(lang("tip_prop_lack"))
		else
			FloatWordMgr.instance:show(lang("tip_prop_no_select"))
		end
	end

	self:_refreshAttribute()
end

function M:_parseBirthDay(birthdayTimeStamp)
	local tempStr = string.format("%s月%s日", "--", "--")

	birthdayTimeStamp = tonumber(birthdayTimeStamp)

	if birthdayTimeStamp > 0 then
		local birthdayTb = TimeUtil.instance:formatUnixTime2Date(birthdayTimeStamp / 1000)

		self._birthday = birthdayTb

		if birthdayTb then
			tempStr = string.format("%s月%s日", StringUtil.getLess10With0(birthdayTb.month), StringUtil.getLess10With0(birthdayTb.day))
		end
	end

	self._txtDirthday.text = tempStr
end

function M:_loadSkin(heroId, skinId)
	local skinMo = HeroSkinModel.instance:getSkinMo(heroId, skinId)

	if not skinMo then
		return
	end

	local modelCO = ModelConfig.instance:getModelConfig(skinMo:getModelId())

	if modelCO then
		IconLoader.setSprite(self._skinImg, IconType.CharaterBust, modelCO.wholeIconName, nil, nil, modelCO.code)
	end
end

function M:_onClickSwitch()
	return
end

function M:_switchView()
	local showSkin = self._viewType == ViewInfoType.Lihui and self._isSelf

	goutil.setActive(self._btnEditCard.gameObject, not showSkin and self._isSelf)
end

function M:_onClickCopy()
	if self._curUserId then
		TextUtils.CopyText(self._curUserId)
		FloatWordMgr.instance:show("拷贝成功")
	end

	goutil.setActive(self._editTips, false)
end

function M:_onClickBirth()
	if self._birthday then
		FloatWordMgr.instance:show("已经设置过生日了")
		goutil.setActive(self._editTips, false)

		return
	end

	local info = {}

	info.callBackFunc = self._changeBirthDay
	info.callBackHandle = self
	info.month = 1
	info.day = 1

	ViewMgr.instance:open(ViewName.BirthdayEditTips, info)
	goutil.setActive(self._editTips, false)
end

function M:_changeBirthDay(month, day)
	local tempts = os.time({
		hour = 0,
		year = 2400,
		second = 0,
		minute = 0,
		day = day,
		month = month
	}) * 1000

	PlayerAgent.instance:sendChangeBirthdayRequest(tempts)
end

function M:_onClickHint()
	self._isShowTips = true

	self:_setGlobalClick(self._isSelf and self._isShowTips)
end

function M:_onClickEdit2()
	if not self._isSelf then
		return
	end

	ViewMgr.instance:open(ViewName.PlayerInfoLeaveMsgView, {
		playerCardInfo = self._playerData
	})
end

function M:_onClickEditCard()
	goutil.setActive(self._editTips, true)
	goutil.setActive(self._btnBirth.gameObject, not self._birthday)
end

function M:_onClickEditBusinessCard()
	ViewMgr.instance:open(ViewName.PlayerBusinessCardView)
end

function M:_onClickChangeRole()
	ViewMgr.instance:open(ViewName.PlayerSelectCharacter)
end

function M:_onClickChangeCloth()
	local displayHero = self._playerData.displayHero
	local heroData = HeroDepotModel.instance:getHeroInfoByID(displayHero)
	local tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
	local index = tmpHeroList:getMoIndex(heroData)
	local list = tmpHeroList:getMoList()

	HeroDepotModel.instance:setViewPageMo({
		hero = heroData,
		index = index,
		list = list
	})
	ViewMgr.instance:open(ViewName.CharacterIntelligenceViewViewPresentor)
end

function M:_onSelectPlayerSkin(skinId)
	if self._playerData.displayHeroSkin == skinId then
		return
	end

	PlayerAgent.instance:sendChangeDisplayHeroSkinRequest(skinId)
end

function M:_onClickChangeHead()
	local view = {}

	view.index = 1

	ViewMgr.instance:open(ViewName.PlayerInfoShowViewViewPresentor, view)
end

function M:_onClickAddFriend()
	local isFriend = FriendModel.instance:isInRelationType(GameEnum.RelationTypeEnum.Friend, tonumber(self._playerData.userId))

	if not isFriend then
		FriendAgent.instance:sendApplyFriendRequest(self._playerData.userId)
	end
end

function M:_onClickTouch()
	self:_setGlobalClick(false)
end

function M:_setGlobalClick(state)
	self._click2Listener.enabled = state
end

function M:_onClickBack2Base()
	self._viewType = ViewInfoType.Info

	self:_switchView()
end

function M:_onChangeNameSuc(key, newName)
	self._txtName.text = newName

	PlayerModel.instance:setNickName(newName)
	FloatWordMgr.instance:show("修改昵称成功")

	self._tempName = newName
end

function M:_onChangeNameFail()
	return
end

function M:_onChangePortraitSuc(key, portrait)
	local itemCO = BackpackConfig.instance:getItemInfoByItemId(portrait)

	if itemCO then
		IconLoader.setSprite(self._imgIcon, IconType.PlayerInfoMask, itemCO.icon)
	end
end

function M:_onChangeDisplayCardSuc(key, displayCard)
	self:_setCardOrFrame(displayCard)
end

function M:_onChangeImageSuc(key, image)
	return
end

function M:_getIconType(itemId)
	local allCfgMap = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.DisplayCard)

	for _, v in pairs(allCfgMap) do
		if v.id == itemId then
			return v.subType
		end
	end
end

function M:_onChangeDiaplayHerosuc(key, displayHero, displayHeroSkin)
	self._playerData.displayHero = displayHero
	self._playerData.displayHeroSkin = displayHeroSkin
end

function M:_onChangeDiaplaySkinsuc(key, displayHeroSkin)
	self._playerData.displayHeroSkin = displayHeroSkin

	self:_loadSkin(self._playerData.displayHero, self._playerData.displayHeroSkin)
end

function M:_onChangeBirthDaysuc(key, birthday)
	birthday = tonumber(birthday)

	if birthday > 0 then
		local birthdayTb = TimeUtil.instance:formatUnixTime2Date(birthday / 1000)

		self._birthday = birthdayTb

		if birthdayTb then
			self._txtDirthday.text = string.format("%s月%s日", StringUtil.getLess10With0(birthdayTb.month), StringUtil.getLess10With0(birthdayTb.day))
		end
	end

	self:_updateRedPoint()
end

function M:_onChangeSignsuc(key, sign)
	self:_updateSign(sign)
end

function M:_onHidePlayerInfo()
	self._viewType = ViewInfoType.Info

	self:_switchView()
end

function M:_onReadyChangeHero(key, heroId)
	if self._playerData.displayHero == heroId then
		return
	end
end

function M:_onReadyChangeHeroSkin(key, skinId)
	return
end

function M:_refreshHeroSkin()
	self:_loadSkin(self._playerData.displayHero, self._playerData.displayHeroSkin)
end

function M:_onApplySuccess()
	self:_updateText()
end

function M:_updateText()
	local isFriend = FriendModel.instance:isInRelationType(GameEnum.RelationTypeEnum.Friend, tonumber(self._playerData.userId))
	local friendMo = FriendModel.instance:getSearchResultById(tonumber(self._playerData.userId))

	if friendMo then
		local isApply = friendMo:getRelationShip() == GameEnum.RelationTypeEnum.Apply

		if isApply then
			-- block empty
		end
	end
end

function M:_updateRedPoint()
	local btnEditCardRedPoint = goutil.findChild(self._btnEditCard.gameObject, "red_point")
	local btnBirthRedPoint = goutil.findChild(self._btnBirth.gameObject, "red_point")
	local btnHeadRedPoint = goutil.findChild(self._btnHead.gameObject, "red_point")
	local isShowPortraitRedPoint = false
	local curPortraitList = ItemModel.instance:getItemsByTS(GameEnum.ItemTypeEnum.Portrait, 1)

	if curPortraitList then
		for i = 1, #curPortraitList do
			if curPortraitList[i]:getRedPoint() == CommEnum.ItemRedPoint.New then
				isShowPortraitRedPoint = true
			end
		end
	end

	goutil.setActive(btnEditCardRedPoint, self._birthday == false or isShowPortraitRedPoint)
	goutil.setActive(btnBirthRedPoint, self._birthday == false or isShowPortraitRedPoint)
	goutil.setActive(btnHeadRedPoint, isShowPortraitRedPoint)
end

function M:_updateSign(sign)
	local msgPreviewStr, emoji, voice

	self._leaveMsgMO = nil

	if sign then
		self._leaveMsgMO = LeaveMsgMO.New(sign)

		self._leaveMsgMO:setPageType(sign.voice > 0 and LeaveMsgEnum.MsgType.Voice or LeaveMsgEnum.MsgType.Word)

		if Astral.OSDef.isEditor then
			TableUtil.dump(self._leaveMsgMO)
		end

		msgPreviewStr = self._leaveMsgMO:getPreviewMsg()
		emoji = self._leaveMsgMO:getEmoji()
		voice = self._leaveMsgMO:getVoice()
	end

	if msgPreviewStr == LeaveMsgEnum.EmptyMarkEdit then
		msgPreviewStr = nil
	end

	local isVoice = voice and voice > 0

	if string.nilorempty(msgPreviewStr) then
		isVoice = false
	end

	goutil.setActive(self._goMsgVoiceMark, isVoice)

	if isVoice then
		self._txtMessageBoard.text = "<line-indent=9%>" .. msgPreviewStr
	else
		self._txtMessageBoard.text = msgPreviewStr
	end

	goutil.setActive(self._txtMessageBoard.gameObject, true)

	if emoji and emoji > 0 then
		local cfg = ChatConfig.instance:getConfigByKey(ConfigName.ChatEmoji, emoji)

		if cfg then
			goutil.setActive(self._goEmojiRoot.gameObject, true)
			IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, cfg.icon)
		else
			goutil.setActive(self._goEmojiRoot.gameObject, false)
		end
	else
		goutil.setActive(self._goEmojiRoot.gameObject, false)
	end
end

return M
