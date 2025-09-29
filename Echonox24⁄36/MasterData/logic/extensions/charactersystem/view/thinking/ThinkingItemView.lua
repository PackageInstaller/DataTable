-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingItemView.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingItemView", package.seeall)

local M = class("ThinkingItemView")

function M:ctor(compContainer)
	self._mainGo = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)
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
	self._thoughtIcon = self._registry:getImage("thought_item_-156919607")
	self._thoughtIconLock = self._registry:getImage("thought_item_209238713")
	self._normalGo = self._registry:getGo("thought_item_1690568622")
	self._lockGo = self._registry:getGo("thought_item_675613424")
	self._selectGo = self._registry:getGo("thought_item_-1415342344")
	self._btnClick = self._registry:getBtn("thought_item_921289562")
	self._atPresentGo = self._registry:getGo("thought_item_1672766528")
	self._activeGo = goutil.findChild(self._mainGo, "move/stateActivated")
	self._txtName2 = self._registry:getText("thought_item_739325031")
	self._txtInfo = self._registry:getText("thought_item_698557862")
	self._infoGo = goutil.findChild(self._mainGo, "move/objInfo")
	self._imgProgress = goutil.findChildImageComponent(self._mainGo, "move/objInfo/imgDi/imgProgress")
	self._txtTag1 = goutil.findChildTextComponent(self._mainGo, "move/objInfo/sign_group/item/txtSign")
	self._txtTag2 = goutil.findChildTextComponent(self._mainGo, "move/objInfo/sign_group/item (1)/txtSign")
	self._skillGo = goutil.findChild(self._mainGo, "move/objInfo/objSkill")
	self._txtSkill = goutil.findChildComponent(self._mainGo, "move/objInfo/objSkill/txtContent", UIComponentType.TextMeshProUGUI)

	goutil.setActive(self._btnClick.gameObject, true)
end

function M:destroyUI()
	self:setClickCallback(nil, nil)
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:getThinkingId()
	return self._thinkingId
end

function M:refreshView(thinkingId, thinkingItemData)
	if self._thinkingId and self._thinkingId == thinkingId then
		-- block empty
	end

	self._thinkingId = thinkingId

	local thinkingMO = ThinkingModel.instance:getMoById(self._thinkingId)
	local cfg = ThinkingConfig.instance:getThinkingCO(self._thinkingId)
	local icon = cfg and cfg.icon or ""
	local name = cfg and cfg.name or ""

	if not string.nilorempty(icon) then
		IconLoader.setSprite(self._thoughtIcon, IconType.Thought, icon)
		IconLoader.setSprite(self._thoughtIconLock, IconType.Thought, icon)
	end

	self._txtTag1.text = cfg and cfg.tags[1] or ""
	self._txtTag2.text = cfg and cfg.tags[2] or ""
	self._txtName2.text = name

	goutil.setActive(self._txtTag2.gameObject.transform.parent.gameObject, #cfg.tags > 1)

	if thinkingMO then
		local skills = thinkingMO:getSkills()
		local upTotalLv = 0
		local total = ThinkingConfig.instance:getThinkingSkillTotalLevel(cfg.skills or {})

		for i, v in ipairs(skills) do
			upTotalLv = upTotalLv + v.level
		end

		self._txtInfo.text = string.format("(<size=30><color=#ffffff>%s</color></size>/%s)", upTotalLv, total)
		self._imgProgress.fillAmount = upTotalLv / total
	end

	if thinkingItemData then
		local usingThinkingSkillId = thinkingItemData:getWearingSkillId()
		local hasUsingThinkingSkill = usingThinkingSkillId and usingThinkingSkillId > 0

		if hasUsingThinkingSkill then
			local thinkingMO = ThinkingModel.instance:getMoById(thinkingId)
			local skillLevel = thinkingMO:getSkillLevel(usingThinkingSkillId)
			local skillName, skillDesc, skillIcon = thinkingMO:getSkillData(usingThinkingSkillId, skillLevel)

			self._txtSkill.text = skillDesc
		end

		goutil.setActive(self._skillGo, hasUsingThinkingSkill)
	end
end

function M:setSelected(isSelected, hideSelect)
	if self._isSelected == isSelected then
		return
	end

	goutil.setActive(self._selectGo, isSelected)

	self._isSelected = isSelected

	if hideSelect then
		goutil.setActive(self._selectGo, false)
	end
end

function M:setIsRecommend(isRecommend)
	return
end

function M:setIsUsing(isUsing)
	goutil.setActive(self._atPresentGo, isUsing)
	goutil.setActive(self._skillGo, isUsing)
end

function M:_onClick()
	if self._clickCallbackFunc then
		if self._clickCallbackHandler then
			self._clickCallbackFunc(self._clickCallbackHandler, self._thinkingId)
		else
			self._clickCallbackFunc(self._thinkingId)
		end
	end
end

function M:setClickCallback(clickCallbackFunc, clickCallBackHandler)
	self._clickCallbackFunc = clickCallbackFunc
	self._clickCallbackHandler = clickCallBackHandler
end

function M:setVisible(visible)
	goutil.setActive(self._mainGo, visible)
end

function M:setActiveFlagVisible(visible)
	goutil.setActive(self._activeGo, visible)
end

function M:setLockVisible(visible)
	goutil.setActive(self._lockGo, visible)
	goutil.setActive(self._normalGo, not visible)
end

function M:setImgAddVisible(visible)
	goutil.setActive(self._thoughtIcon.gameObject, not visible)
end

function M:setObjInfoVisible(visible)
	goutil.setActive(self._infoGo, visible)
end

return M
