-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingUpgradeView.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingUpgradeView", package.seeall)

local M = class("ThinkingUpgradeView", ViewComponent)

function M:buildUI()
	self._btnCancel = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "content/btn_left"))
	self._btnSure = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "content/btn_right"))
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "universal_second_tips_common_bg/content/btnClose"))
	self._txtLvPre = goutil.findChildTextComponent(self.mainGO, "content/txtLevel1")
	self._txtLvAft = goutil.findChildTextComponent(self.mainGO, "content/txtLevel2")
	self._txtContent = goutil.findChildComponent(self.mainGO, "content/scrollView/viewPort/content/txtContent", UIComponentType.TextMeshProUGUI)
	self._rectCostContent = goutil.findChild(self.mainGO, "content/group").transform
	self._itemGo = goutil.findChild(self.mainGO, "content/group/backpack_item")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local param = self:getFirstParam()

	self._thinkingId = param.thinkingId
	self._skillId = param.skillId

	self:_refreshView()
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		-- block empty
	end
end

function M:_refreshView()
	local thinkingId = self._thinkingId
	local thinkingMO = ThinkingModel.instance:getMoById(thinkingId)
	local skillId = self._skillId
	local skillLevel = thinkingMO:getSkillLevel(skillId)
	local isMaxLevel = thinkingMO:isMaxLevelSkill(skillId)
	local skillName, skillDesc, skillIcon = thinkingMO:getSkillData(skillId, skillLevel + 1)

	self._txtLvPre.text = string.format("LV.<size=44>%s</size>", skillLevel)
	self._txtLvAft.text = isMaxLevel and "MAX" or string.format("%s", skillLevel + 1)
	self._txtContent.text = skillDesc

	local costLzb, costItem = ThinkingConfig.instance:getSkillUpgradeCost(skillId, skillLevel + 1)

	goutil.setActive(self._rectCostContent.gameObject, #costItem > 0)

	if #costItem > 0 then
		while self._rectCostContent.childCount < #costItem do
			goutil.cloneAndSetParent(self._rectCostContent:GetChild(0).gameObject, self._rectCostContent)
		end

		for i = 0, self._rectCostContent.childCount - 1 do
			local go = self._rectCostContent:GetChild(i).gameObject
			local _data = costItem[i + 1]

			if _data then
				local myCount = ItemModel.instance:getItemCountByItemId(_data:getItemId())
				local strNum = myCount >= _data:getCount() and string.format("%s/%s", myCount, _data:getCount()) or string.format("<color=#ca3535>%s</color>/%s", myCount, _data:getCount())
				local itemCell = Astral.SimpleLuaComponentContainer.Add(go, ItemCell)

				itemCell:updateData(_data)
				itemCell:setShowTipsPassEvent(false)
				itemCell:setShowSelectedEffect(false)
				itemCell:getComponent("num"):setVisible(true)
				itemCell:getComponent("num"):setNumBgNodeVisible(false)
				itemCell:getComponent("num"):setCostTextActive(true)
				itemCell:getComponent("num"):setCostText(strNum)
				itemCell:getComponent("num"):setCountTextActive(false)
			end

			goutil.setActive(go, _data)
		end
	end
end

function M:_onClickSure()
	local thinkingId = self._thinkingId
	local thinkingMO = ThinkingModel.instance:getMoById(thinkingId)
	local skillId = self._skillId
	local skillLevel = thinkingMO:getSkillLevel(skillId)

	skillId = skillId or 0

	if skillId <= 0 then
		return
	end

	if thinkingMO:isMaxLevelSkill(skillId) then
		ToolTipsMgr.showCharacterTopToast(lang("tip_thought_skill_upgrade_fail_by_max_level"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	local costLzb, costItem = ThinkingConfig.instance:getSkillUpgradeCost(skillId, skillLevel + 1)

	if self:_getCostEnough(costLzb, costItem) then
		ThinkingAgent.instance:sendThinkingSkillUpgradeRequest(thinkingId, skillId)
		self:_onClickClose()
	end
end

function M:_getCostEnough(costLzb, costItemLst)
	if not ItemUtil.isItemEnough(CommEnum.CurrencyCodeEnum.LzbCode, costLzb) then
		ToolTipsMgr.showCharacterTopToast(lang("tip_lack_of_material"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return false
	end

	local itemEnough = true

	for _, itemData in ipairs(costItemLst) do
		if itemEnough and not ItemUtil.isItemEnough(itemData:getItemId(), itemData:getCount()) then
			itemEnough = false
		end
	end

	if not itemEnough then
		ToolTipsMgr.showCharacterTopToast(lang("tip_lack_of_material"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return false
	end

	return true
end

function M:_onClickClose()
	self:close()
end

return M
