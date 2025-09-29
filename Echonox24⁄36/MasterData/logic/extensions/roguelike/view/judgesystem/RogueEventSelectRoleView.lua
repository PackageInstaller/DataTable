-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueEventSelectRoleView.lua

module("logic.extensions.roguelike.view.judgesystem.RogueEventSelectRoleView", package.seeall)

local M = class("RogueEventSelectRoleView", ViewComponent)

function M:ctor()
	self.super.ctor(self)

	self._cardItems = {}
	self._txtQua6List = nil
end

function M:buildUI()
	self._imgBigPropIcon = self:getImage("select_character_challenge_view_-1534348656")
	self._txtProp = self:getText("select_character_challenge_view_-64991285")
	self._txtDiff = self:getText("select_character_challenge_view_-1552967274")
	self._traCardParent = self:getGo("select_character_challenge_view_-1357496139").transform
	self._goCardItem = self:getGo("select_character_challenge_view_481850100")
	self._eventPanelGo = self:getGo("select_character_challenge_view_2125184391")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	for k, v in pairs(self._cardItems) do
		v:bindEvents()
	end

	goutil.setActive(self._eventPanelGo, true)

	local eventId = self:getFirstParam()
	local eventCo = RoguelikeConfig.instance:getRoguelikeEventById(eventId)

	self._eventId = eventId

	local replyCo = RogueMgr.instance:getModel():getCurReplyCo()

	self._replyCo = replyCo

	self:updateRoleInfo()
	self:updateInfoByCo(replyCo)
end

function M:onExit()
	for k, v in pairs(self._cardItems) do
		v:unbindEvents()
	end
end

function M:updateRoleInfo()
	for i = 0, self._traCardParent.childCount - 1 do
		goutil.setActive(self._traCardParent:GetChild(i).gameObject, false)
	end

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()

	for i = 1, #allRoles do
		local item = self._cardItems[i]

		if not item then
			local go = Astral.GameObjectUtil.CloneAndSetParent(self._goCardItem, self._traCardParent, nil)

			item = RogueRoleCardItem.New(go)
			self._cardItems[i] = item
		end

		if allRoles[i].roleProp:getIsDeath() then
			-- block empty
		end

		local data = {}

		data.roleId = allRoles[i].roleProp:getIsDeath() and 0 or allRoles[i].roleProp:getRoleId()
		data.index = i
		data.hp = allRoles[i].roleProp:getHp()
		data.san = allRoles[i].roleProp:getSan()

		local index = i

		function data.callback()
			if data.roleId == 0 then
				return
			end

			self:onCardClickCallback(index)
		end

		item:updateData(data)
	end
end

function M:onCardClickCallback(idx)
	RogueMgr.instance:getModel():setCurRoleIndex(idx)
	RogueMgr.instance:getModel():setCurEventInfo({
		self._eventId,
		self._replyCo
	})

	if RogueMgr.instance:getHackToolModel() then
		RogueMgr.instance:getModel():setCurEventInfo(nil)
		RogueMgr.instance:enterEvent(self._eventId, self._replyCo.type + 1)
		print("开始跳转事件")
		self:_onClickClose()

		return
	end

	RoguelikeController.instance:enterRunGroupJudgeScene(function()
		RoguelikeController.instance:closeMapView()

		local eventInfo = RogueMgr.instance:getModel():getCurEventInfo()

		ViewMgr.instance:open(ViewName.RogueEventJudge, eventInfo)
		RogueMgr.instance:getModel():setCurEventInfo(nil)
	end)
	self:_onClickClose()
end

function M:updateInfoByCo(co)
	local prop = RogueMgr.instance:getModel():getEventProp()

	prop = prop or co.testedAttribute

	IconLoader.setSprite(self._imgBigPropIcon, IconType.DynSpriteAtlas_Dice, "dice_" .. prop)

	local map = RoguelikeConst.PROP_LANG_MAP[prop]

	if not map then
		printError("不正确的事件属性配置", prop)

		return
	end

	self._txtProp.text = lang("tip_r_judge_test_prop") .. map.name
	self._txtDiff.text = lang("tip_r_event_diff_txt") .. co.difficulty
end

function M:_onClickClose()
	self:close()
end

return M
