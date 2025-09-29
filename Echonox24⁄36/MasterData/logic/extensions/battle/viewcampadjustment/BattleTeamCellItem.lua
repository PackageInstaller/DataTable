-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleTeamCellItem.lua

module("logic.extensions.battle.viewcampadjustment.BattleTeamCellItem", package.seeall)

local M = class("BattleTeamCellItem", UIReusableLuaBehavior)
local teamMaxHeroCount = 5
local kSaveAnimName = "team_item_content_open"
local kSelectAnimName = "team_item_imgselect_open"

M.State = {
	BATTLE = 2,
	SAVE = 1,
	NONE = 0
}

function M:buildUI()
	self._viewComponent = false
	self._registry = ViewElementsRegistry.New(self.mainGO)
	self._goContent = self._registry:findUIElement("team_item_-1807299599")
	self._goHeroRoot = self._registry:findUIElement("team_item_559671774")
	self._goImgNormal = self._registry:findUIElement("team_item_1093807578")
	self._goImgSelect = self._registry:findUIElement("team_item_284055086")
	self._btnSave = self._registry:findUIElement("1&btn_middle_-31477526", UIComponentType.ButtonAdapter)
	self._btnBattle = self._registry:findUIElement("team_item_941895800", UIComponentType.ButtonAdapter)
	self._btnDelete = self._registry:findUIElement("team_item_-1435597513", UIComponentType.ButtonAdapter)
	self._textTeamPlace = goutil.findChildComponent(self._btnBattle.gameObject, "Text1", UIComponentType.Text)
	self._inputName = self._registry:findUIElement("team_item_1864896590", UIComponentType.InputFieldAdapter)
	self._textHolder = self._registry:findUIElement("team_item_-1682502180", UIComponentType.Text)
	self._heroHeadItem = self._registry:findUIElement("0&hero_item_1481649446")
	self._animSelect = goutil.addComponentOnce(self._goImgSelect, ComponentType.Animation)
	self._animSave = goutil.addComponentOnce(self._goContent, ComponentType.Animation)
	self._heroItemList = {}
	self._clickHandler = false
	self._teamMO = false
	self._sameCampCount = 0
	self._currentState = M.State.NONE
	self._timeWaiter = TimeWaiter.New()
	self._placeholderStr = self._textHolder.text
	self._textTeamPlace.text = lang("tip_team_place")
end

function M:destroyUI()
	self:_clearHeroItemList()
	self._registry:cleanRegistry()

	self._viewComponent = false
	self._registry = false
	self._goContent = false
	self._goHeroRoot = false
	self._goImgNormal = false
	self._goImgSelect = false
	self._btnSave = false
	self._btnBattle = false
	self._heroItemList = false
	self._clickHandler = false
	self._teamMO = false
end

function M:bindEvents()
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnBattle:AddClickListener(self._onClickBattle, self)
	self._btnDelete:AddClickListener(self._onClickDelete, self)
	self._inputName:AddOnEndEdit(self._onEndEditName, self)
end

function M:unbindEvents()
	self._btnSave:RemoveClickListener()
	self._btnBattle:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._inputName:RemoveOnEndEdit()
end

function M:onEnter()
	self._currentState = M.State.NONE
end

function M:onExit()
	self._animSelect:Stop()
	self._animSave:Stop()
end

function M:setViewComponent(viewComponent)
	self._viewComponent = viewComponent
end

function M:setClickHandler(handler)
	self._clickHandler = handler
end

function M:setTeamMO(teamMO, needAnimation)
	self._teamMO = teamMO

	self._inputName:SetText(self._teamMO.teamName)
	self:resetPlaceHolder()
	self:_updateHeroList(teamMO.roles, needAnimation)
	goutil.setActive(self._goContent, true)

	self._maxLen = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.TeamNameMaxLen)
end

function M:resetPlaceHolder()
	if self._teamMO.tid == nil then
		self._teamMO.teamName = lang("tip_current_team")
		self._textHolder.text = lang("tip_current_team")

		self._inputName:SetText("")
	end
end

function M:setSelected(isSelect)
	goutil.setActive(self._goImgSelect, isSelect)

	if isSelect then
		self:_playSelectAnim()
	end
end

function M:changeButtonState(state)
	self._currentState = state

	goutil.setActive(self._btnSave.gameObject, state == M.State.SAVE)
	goutil.setActive(self._btnBattle.gameObject, state == M.State.BATTLE)
	goutil.setActive(self._btnDelete.gameObject, state == M.State.BATTLE)
end

function M:_onClickSave()
	self._teamMO.name = self._inputName:GetText()

	self._clickHandler:onClickTeamCellSave(self._teamMO)
end

function M:_onClickBattle()
	self._clickHandler:onClickTeamCellBattle(self._teamMO)
end

function M:_onClickDelete()
	local dialog = Dialog.showWarnMessage(lang("tip_delete_team_title"), lang("tip_delete_team"))

	dialog:setConfirmListener(self._confirmDeleteTeam, self)
end

function M:_confirmDeleteTeam()
	TeamAgent.instance:sendDeleteTeamRequest(self._teamMO.tid)
end

function M:_onEndEditName()
	local newName = self._inputName:GetText()
	local charLimit = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.TeamNameMaxLen)

	if charLimit < string.utf8len(newName) then
		FloatWordMgr.instance:show(lang("tip_char_limit"))

		return
	end

	if string.nilorempty(newName) then
		self._inputName:SetText(self._teamMO.teamName)
		self:resetPlaceHolder()

		return
	end

	if newName == self._teamMO.teamName then
		return
	end

	if self._teamMO.tid ~= nil then
		TeamAgent.instance:sendEditTeamNameRequest(self._teamMO.tid, newName)
	else
		self._teamMO.teamName = newName
	end
end

function M:_updateHeroList(heroIdList, needAnimation)
	local index = 0

	for i = 1, teamMaxHeroCount do
		local heroItem = self._heroItemList[i]

		if not heroItem then
			local newHeadItem = goutil.cloneAndSetParent(self._heroHeadItem, self._goHeroRoot.transform)

			heroItem = Astral.LuaComponentContainer.Add(newHeadItem, HeroHeadItem)
			self._heroItemList[i] = heroItem
		end

		goutil.setActive(heroItem.mainGO, true)

		local heroId = heroIdList[i]

		if heroId then
			local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

			if heroMO then
				index = index + 1

				heroItem:setHeroMO(heroMO)
				heroItem:showCamp(true)
				heroItem:playOpenAnimation(not needAnimation)
				heroItem:setHandler(self)
			end
		end
	end

	while index < teamMaxHeroCount do
		index = index + 1

		local heroItem = self._heroItemList[index]

		heroItem:setIsNone(true)
	end
end

function M:onClickHeroItem(heroItem)
	if heroItem:getHeroMO() then
		CharacterUtil.openCharacterDetailView(heroItem:getHeroMO():getId())
	end
end

function M:_clearHeroItemList()
	for _, heroItem in pairs(self._heroItemList) do
		heroItem:destroy()
	end

	BattleTableUtil.clearTable(self._heroItemList)
end

function M:_playSelectAnim()
	self._animSelect:Play(kSelectAnimName)
end

function M:playSaveAnim()
	self._animSave:Play(kSaveAnimName)
end

function M:getSaveAnimDuration()
	return self._animSave:GetClip(kSaveAnimName).length
end

function M:stopSaveAnim()
	local state = self._animSave.this:get(kSaveAnimName)

	state.normalizedTime = 1

	self._animSave:Sample()
	self._animSave:Stop(kSaveAnimName)
end

return M
