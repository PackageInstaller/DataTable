-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueEntranceSelectRoleView.lua

module("logic.extensions.roguelike.view.explore.RogueEntranceSelectRoleView", package.seeall)

local PropItem = class("PropItem")

function PropItem:ctor(container)
	local go = container.gameObject

	self._go = go
	self._imgIcon = goutil.findChildImageComponent(go, "Image")
	self._txtContent = goutil.findChildTextComponent(go, "txt")
end

function PropItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function PropItem:updateData(data)
	self._txtContent.text = data.content

	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(data.pattern)))
	self:setActive(true)
end

local M = class("RogueEntranceSelectRoleView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._cardSelectRoleItems = {}
	self._selectRoleIds = {}
	self._propItems = {}
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._canvasGroup = goutil.addComponentOnce(self.mainGO, ComponentType.CanvasGroup)
	self._btnClose = self:getBtn("title_view_-878360263")
	self._btnHome = self:getBtn("title_view_1398742689")
	self._traSelectRoleParent = self:getGo("run_group_select_charater_view_-875782417").transform
	self._txtHint = self:getText("run_group_select_charater_view_1244518461")
	self._goPropItem = self:getGo("run_group_select_charater_view_copy_389845447")
	self._traPropItemParent = self._goPropItem.transform.parent
	self._goEquipItem = self:getGo("run_group_select_charater_view_copy_-297337357")
	self._goEquipCell = goutil.findChild(self._goEquipItem, "cell")
	self._imgEquipIcon = goutil.findChildImageComponent(self._goEquipCell, "backpack_item/imgIcon")
	self._imgEquipQuality = goutil.findChildImageComponent(self._goEquipCell, "backpack_item/imgQuality")
	self._btnEquip = self:getBtn("run_group_select_charater_view_1895349012")
	self._btnExplore = self:getBtn("run_group_select_charater_view_-1308285604")
	self._animBtnExplore = self:getUIComponent("run_group_select_charater_view_-1308285604", ComponentType.Animation)
	self._goCamp = self:getGo("run_group_select_charater_view_copy_1692548201")
	self._imgCamp = self:getImage("run_group_select_charater_view_copy_-1888101423")
	self._goCampEffExist = self:getGo("run_group_select_charater_view_1709606669")
	self._goCampEffNone = self:getGo("run_group_select_charater_view_1042884873")
	self._heroData = HeroDepotModel.instance:getHeroDepotData()
	self._showHeroData = self._heroData:getShowDataList()

	goutil.setActive(self._goPropItem, false)
end

function M:destroyUI()
	goutil.destroy(self._goBtn)

	self._goBtn = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnExplore:AddClickListener(self._onClickExplore, self)
	self._btnEquip:AddClickListener(self._onClickEquip, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnExplore:RemoveClickListener()
	self._btnEquip:RemoveClickListener()
end

function M:onEnter()
	self._isOpen = true
	self._selectRoles = RoguelikeUtil.instance:createSelectRoles()

	for k, v in pairs(self._selectRoles) do
		goutil.setActive(v.go, false)
	end

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)
	self:setEvent(true)

	for k, v in pairs(self._cardSelectRoleItems) do
		v:bindEvents()
	end

	self._selectRoleIds = RogueLocalStorageUtil.instance:getSelectRoleList()
	self._isGuideFinish = RoguelikeConst.IsGuideFinish()

	local lastEquipId = RogueLocalStorageUtil.instance:getLastEquipId()

	if lastEquipId ~= 0 then
		RoguelikeModel.instance:setTempEquipId(lastEquipId)
	end

	self:updateRecommend()
	self:updateEquipment()
	self:autoUseGuideParam()
	self:_onEquipRefresh()
	self:showCardState()
	self:initGoBtn()
end

function M:initGoBtn()
	local mapParent = RoguelikeController.instance:getMapParent(1)

	if not goutil.isNil(mapParent) and self._goBtn == nil then
		local go = self:getResInstance(ResName.Rungroupother_rungroup_btn_go)

		goutil.addChildToParent(go, mapParent.transform)

		self._goBtn = go
		self._goBtnReady = goutil.findChild(go, "btnGo")
		self._goBtnNo = goutil.findChild(go, "btnNot")
	end
end

function M:showCardState()
	goutil.setActive(self._traSelectRoleParent.gameObject, false)
	settimer(0.7, self._delayShowCard, self, false)
end

function M:_delayShowCard()
	goutil.setActive(self._traSelectRoleParent.gameObject, true)
	self:updateSelectCard()
end

function M:onEnterFinished()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_TEAM_UP_SUCCESS, self._onTeamUpSuccess, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_ROOM_INFO_REFRESH, self._onRoomInfoRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SCENE_LOAD_FINISH, self._onSceneLoadFinish, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_TEAM_UP_SUCCESS, self._onTeamUpSuccess, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_EQUIP_REFRESH, self._onEquipRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_ROOM_INFO_REFRESH, self._onRoomInfoRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SCENE_LOAD_FINISH, self._onSceneLoadFinish, self)
	end
end

function M:updateRecommend()
	local recommend = ""
	local co = self:getOpenParam()[2]
	local props = {}

	for k, v in pairs(self._propItems) do
		v:setActive(false)
	end

	for idx, prop in pairs(props) do
		local map = RoguelikeConst.PROP_LANG_MAP[prop]
		local item = self._propItems[idx]

		if not item then
			local go = goutil.cloneAndSetParent(self._goPropItem, self._traPropItemParent)

			item = Astral.LuaComponentContainer.Add(go, PropItem)
			self._propItems[idx] = item
		end

		local data = {}

		data.content = map.name
		data.pattern = prop

		item:updateData(data)
	end
end

function M:updateEquipment()
	local hadEquip = #RoguelikeModel.instance:getEquipMOS() > 0

	goutil.setActive(self._btnEquip.transform:GetChild(0).gameObject, hadEquip)
end

function M:checkBtnGo()
	local isEmpty = false

	for i = 1, 4 do
		if self._selectRoleIds[i] == nil then
			isEmpty = true
		end
	end

	goutil.setActive(self._goBtnNo, isEmpty)
	goutil.setActive(self._goBtnReady, not isEmpty)
end

function M:updateSelectCard(changIndex)
	for i = 0, self._traSelectRoleParent.childCount - 1 do
		goutil.setActive(self._traSelectRoleParent:GetChild(i).gameObject, false)
	end

	self._inRoleAniTime = true

	for i = 1, 4 do
		local item = self._cardSelectRoleItems[i]

		if not item then
			local go = self._traSelectRoleParent:GetChild(i - 1).gameObject

			item = RogueRoleLiPaiItem.New(go)
			self._cardSelectRoleItems[i] = item
		end

		local data = {}

		data.roleId = self._selectRoleIds[i] ~= nil and self._selectRoleIds[i] or 0
		data.index = i
		data.isAllowEmptyClick = true

		local index = i

		function data.callback()
			self:onSelectCardClickCallback(index)
		end

		data.showAddBtn = true

		settimer(1, function()
			if self._isOpen then
				item:updateData(data)
				item:setModelActive(false)
			end

			self._inRoleAniTime = false
		end, self, false)

		local waitTime = changIndex ~= nil and 0.02 or i * 0.2

		settimer(waitTime, function()
			if self._isOpen then
				local mapRole = self._selectRoles[i]

				if mapRole ~= nil then
					if data.roleId ~= 0 then
						local characterCO = CharacterConfig.instance:getCfgInfoByID(data.roleId)
						local modelId = characterCO.modelId
						local modelCO = ModelConfig.instance:getModelConfig(modelId)

						mapRole.meshModel:setBody(GameUrl.getRoguelikeMeshModelUrl(modelCO.rogueResName))
						mapRole.meshModel:setDirection(UnitSpineDir.Right)

						if not changIndex or changIndex == i then
							mapRole.meshModel:play(RoguelikeConst.ROGUE_ROLE_ANI.FALL, false, true)
							CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_chess_fall)
						end

						local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
						local x = -kMapItemSize * (4 - i)

						Astral.TransformUtil.SetLocalPos(mapRole.go.transform, x, 0, 0)
						goutil.setActive(mapRole.go, true)
					end

					goutil.setActive(mapRole.go, data.roleId ~= 0)
				end
			end
		end, self, false)
	end

	self:checkShowCampEffect()
	self:checkBtnGo()
end

function M:onSelectCardClickCallback(index)
	if not self._isGuideFinish or self._inRoleAniTime then
		return
	end

	local param = self:getOpenParam()

	self:setSceneObjActive(false)
	ViewMgr.instance:open(ViewName.RogueRoleSelect, index, self._selectRoleIds, function(selectRoleIndex, selectRoleId)
		if selectRoleIndex ~= nil then
			if selectRoleId ~= nil then
				for k, v in pairs(self._selectRoleIds) do
					if v == selectRoleId and k ~= selectRoleIndex then
						self._selectRoleIds[k] = nil
					end
				end
			else
				self._selectRoleIds[selectRoleIndex] = nil
			end

			self._selectRoleIds[selectRoleIndex] = selectRoleId

			self:updateSelectCard(selectRoleIndex)
		end

		self:setSceneObjActive(true)
	end)
end

function M:setSceneObjActive(isActive)
	local mapParent = RoguelikeController.instance:getMapParent(1)

	goutil.setActive(mapParent, isActive)

	local roleRoot = RogueMapGenerator.getRoleRoot()

	goutil.setActive(roleRoot, isActive)
	goutil.setActive(self._traSelectRoleParent.gameObject, isActive)
	goutil.setActive(self._goEquipItem, isActive)
end

function M:checkIsSelect(roleId)
	for k, v in pairs(self._selectRoleIds) do
		if roleId == v then
			return true
		end
	end

	return false
end

function M:checkShowCampEffect()
	local scriptId = self:getOpenParam() and self:getOpenParam()[2].id or 0
	local level = self:getOpenParam() and self:getOpenParam()[3] or 0

	self._scriptId = scriptId

	if not RoguelikeUtil.instance:checkOpenCampEffect(scriptId, level) then
		goutil.setActive(self._goCamp, false)

		return
	end

	local allCamps = {}

	for k, v in ipairs(self._selectRoleIds or {}) do
		local characterCo = CharacterConfig.instance:getCharacterItemInfo(v)

		allCamps[characterCo.camp] = allCamps[characterCo.camp] or 0
		allCamps[characterCo.camp] = allCamps[characterCo.camp] + 1
	end

	local markCamp

	for k, v in pairs(allCamps) do
		if not markCamp and v >= 3 then
			markCamp = k
		end
	end

	if markCamp then
		IconLoader.setSprite(self._imgCamp, IconType.CharaterCampCornerIcon, CommEnum.CampType2SmallIcon[markCamp])
	end

	goutil.setActive(self._goCampEffExist, markCamp)
	goutil.setActive(self._goCampEffNone, not markCamp)
	goutil.setActive(self._goCamp, true)
end

function M:_refreshHeroDepotData()
	if self._heroListBinderView then
		self._heroListBinderView:refreshView()
	end
end

function M:onExit()
	self._isOpen = false
	self._inRoleAniTime = false

	self:setEvent(false)

	for k, v in pairs(self._cardSelectRoleItems) do
		v:unbindEvents()
	end

	for i = 0, self._traSelectRoleParent.childCount - 1 do
		goutil.setActive(self._traSelectRoleParent:GetChild(i).gameObject, false)
	end

	RoguelikeModel.instance:setTempEquipId(0)
	removetimer(self._delayShowCard, self)

	if self._moveAniIndex and self._moveAniIndex > 0 then
		return
	end
end

function M:onExitFinished()
	self._selectRoleIds = {}
	self._moveAniIndex = 0
end

function M:_onTeamUpSuccess()
	local callback = self:getFirstParam()

	if callback then
		-- block empty
	end

	RoguelikeController.instance:setDelayEntering(true)
	self:initRogue()
end

function M:initRogue()
	if RogueMgr.instance:isInRogue() then
		return
	end

	local tb = {}

	tb.roleIds = {}

	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if allRoleState == nil then
		print("组队完成但是没角色")

		return
	end

	for k, v in pairs(allRoleState) do
		table.insert(tb.roleIds, v.code)
	end

	RogueMgr.instance:enter(tb)
	FloatWordMgr.instance:show(lang("tip_r_select_role_finish"))
end

function M:_onClickClose()
	if self._moveAniIndex and self._moveAniIndex > 0 then
		return
	end

	self:close()
	RoguelikeUtil.instance:destroySelectRoles()
	RoguelikeController.instance:exitRunGroupSceneFlow()
end

function M:_onClickHome()
	if self._moveAniIndex and self._moveAniIndex > 0 then
		return
	end

	self:close()
	RoguelikeUtil.instance:destroySelectRoles()
	RoguelikeController.instance:jumpToRoomScene()
end

function M:dealExplore()
	if self._moveAniIndex and self._moveAniIndex > 0 then
		return
	end

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_paotuan_start)

	self._moveAniIndex = 1

	goutil.setActive(self._traSelectRoleParent.gameObject, false)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close1")

	local equipId = RoguelikeModel.instance:getTempEquipId()

	if equipId ~= 0 then
		-- block empty
	end

	RogueTempModel.instance:setCurEquipId(equipId)
	RogueTempModel.instance:setCurRoleIds(self._selectRoleIds)

	if self._isGuideFinish then
		RogueLocalStorageUtil.instance:saveLastEquipId(equipId)
		RogueLocalStorageUtil.instance:savaSelectRoleList(self._selectRoleIds)
	end

	local scriptInfo = RogueTempModel.instance:getCurScriptInfo()

	RogueExploreAgent.instance:sendStartRequest(equipId, self._selectRoleIds, scriptInfo[1], scriptInfo[2])
end

function M:getSelectRoleReady()
	local count = 0

	for k, v in pairs(self._selectRoleIds) do
		if k <= 4 and v ~= nil then
			count = count + 1
		end
	end

	return count >= 4
end

function M:_onClickExplore()
	if self._moveAniIndex and self._moveAniIndex > 0 then
		return
	end

	if not self:getSelectRoleReady() then
		FloatWordMgr.instance:show(lang("tip_r_not_select_role_enough"))

		return
	end

	self._animBtnExplore:Stop()
	self._animBtnExplore:Play("run_group_select_charater_view_btnexplore")

	local equipId = RoguelikeModel.instance:getTempEquipId()
	local equipsMos = RoguelikeModel.instance:getEquipMOS()
	local count = equipsMos and #equipsMos or 0

	if equipId == 0 and count > 0 then
		local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_r_bring_equip_enter"))

		dialog:setConfirmListener(function()
			self:dealExplore()
		end, self)

		return
	end

	self._canvasGroup.interactable = false

	settimer(0.3, function()
		if self._isOpen then
			self._canvasGroup.interactable = true

			self:dealExplore()
		end
	end, self, false)
end

function M:showMoveRoleAni()
	if self._moveAniIndex > 4 then
		return
	end

	local moveTime = 0.5
	local index = self._moveAniIndex or 1
	local role = self._selectRoles[1]

	if index > 1 then
		local lastRole = self._selectRoles[index]

		goutil.setActive(lastRole.go, false)

		if index == 4 then
			self:close()

			return
		end
	end

	local transform = role.go.transform
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local x = -kMapItemSize * (4 - index - 1)
	local pos = Vector3.New(x, 0, 0)

	transform:DOLocalMove(pos, moveTime, false):OnComplete(self.showMoveRoleAni, self)

	self._moveAniIndex = self._moveAniIndex + 1
end

function M:_onClickEquip()
	if self._moveAniIndex and self._moveAniIndex > 0 then
		return
	end

	if not self._isGuideFinish then
		return
	end

	local equips = RoguelikeModel.instance:getEquipMOS() or {}

	if #equips == 0 and not RoguelikeConst.IsGuildMode() then
		FloatWordMgr.instance:show(lang("tip_r_not_equip"))

		return
	end

	local hadCurScriptEquip = false

	for k, v in pairs(equips) do
		if not v:getIsInRejectedScripts(self._scriptId) then
			hadCurScriptEquip = true
		end
	end

	if not hadCurScriptEquip and not RoguelikeConst.IsGuildMode() then
		FloatWordMgr.instance:show(lang("tip_r_not_equip_in_script"))

		return
	end

	ViewMgr.instance:open(ViewName.RogueEquipMain, {}, self._scriptId)
end

function M:_onEquipRefresh()
	local curEquip = RogueEquipMo.New({
		id = RoguelikeModel.instance:getTempEquipId()
	})
	local hadEquip = curEquip ~= nil and curEquip:getId() ~= 0

	goutil.setActive(self._goEquipCell, hadEquip)
	goutil.setActive(self._btnEquip.transform:GetChild(0).gameObject, not hadEquip)

	if hadEquip then
		IconLoader.setSprite(self._imgEquipIcon, IconType.ItemIcon, curEquip:getIcon())
		IconLoader.setSprite(self._imgEquipQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(curEquip:getQuality()))
	end

	if self._moveAniIndex and self._moveAniIndex > 0 then
		return
	end

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:_onRoomInfoRefresh()
	local allRoleState = RoguelikeModel.instance:getAllRoleState()

	if allRoleState then
		self._allRoleState = allRoleState

		self:initRogue()

		for k, v in ipairs(allRoleState) do
			local heroData = HeroDepotModel.instance:getHeroInfoByID(v.code)

			if heroData then
				HeroPowerAgent.instance:sendHeroPowerInfoRequest(v.code)
			end
		end

		self:showMoveRoleAni()
		RoguelikeController.instance:switchSelectScene2RunGroupScene(self._scriptId)
	end
end

function M:_onSceneLoadFinish()
	self:initGoBtn()
end

function M:enterRunGroupScene()
	RoguelikeController.instance:switchSelectScene2RunGroupScene(self._scriptId)
end

function M:showExitAni()
	local aniTime = 0.3

	for k, v in pairs(self._cardSelectRoleItems) do
		v:playAni("arise")
	end

	settimer(aniTime, self.enterRunGroupScene, self, false)
end

function M:autoUseGuideParam()
	if not self._isGuideFinish then
		local equipId = RoguelikeConfig.instance:getConstByName("GuideEquipId").numValue

		RoguelikeModel.instance:setTempEquipId(equipId)

		local roleIds = RoguelikeConfig.instance:getConstByName("GuideSelectRoleId").numValues

		self._selectRoleIds = roleIds

		self:showCardState()
	end
end

return M
