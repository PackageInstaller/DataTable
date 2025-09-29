-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/thinking/ThinkingUnlockView.lua

module("logic.extensions.charactersystem.view.thinking.ThinkingUnlockView", package.seeall)

local M = class("ThinkingUnlockView", ViewComponent)

function M:buildUI()
	self._btnCancel = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "content/btn_left"))
	self._btnSure = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "content/btn_right"))
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "universal_second_tips_common_bg/content/btnClose"))
	self._btnBg = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "universal_second_tips_common_bg/clickExit"))
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "content/Text1")
	self._rectCostContent = goutil.findChild(self.mainGO, "content/group").transform
	self._itemGo = goutil.findChild(self.mainGO, "content/group/backpack_item")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnCancel:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function M:unbindEvents()
	self._btnCancel:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	local param = self:getFirstParam()

	self._heroData = param.heroData
	self._thinkingId = param.thinkingId

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
	local cfg = ThinkingConfig.instance:getThinkingCO(self._thinkingId)

	self._txtContent.text = string.format(lang("是否消耗材料，解锁<color=#ffffff>%s</color>对思维<color=#ffffff>【%s】</color>的使用权"), self._heroData:getName(), cfg and cfg.name or "")

	local thinkingItemData = self._heroData:getThinkingItemData()
	local unlockCount = thinkingItemData:getUnlockCount()
	local cfgCost = ThinkingConfig.instance:getThinkingUnlockCfg(unlockCount)
	local cost = cfgCost and cfgCost.cost or {}
	local costItem = {}

	for _, val in ipairs(cost) do
		table.insert(costItem, ItemUtil.createItemData({
			itemId = val.id,
			count = val.num
		}))
	end

	if #costItem > 0 then
		while self._rectCostContent.childCount < #costItem do
			goutil.cloneAndSetParent(self._rectCostContent:GetChild(0).gameObject, self._rectCostContent)
		end

		for i = 0, self._rectCostContent.childCount - 1 do
			local go = self._rectCostContent:GetChild(i).gameObject
			local _data = costItem[i + 1]

			if _data then
				local myCount = ItemModel.instance:getItemCountByItemId(_data:getItemId())
				local strNum = myCount >= _data:getCount() and string.format("%s/%s", ItemUtil.formatItemCount(myCount), _data:getCount()) or string.format("<color=#ca3535>%s</color>/%s", myCount, _data:getCount())
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
	local heroData = self._heroData
	local thinkingId = self._thinkingId
	local thinkingItemData = heroData:getThinkingItemData()
	local isLockThinkingInCurHero = not thinkingItemData:isThinkingUnlocked(thinkingId)

	if isLockThinkingInCurHero then
		local unlockCount = thinkingItemData:getUnlockCount()
		local unlockCo = ThinkingConfig.instance:getThinkingUnlockCfg(unlockCount)
		local itemEnough = true

		for index = 1, #unlockCo.cost do
			local item = unlockCo.cost[index]

			if itemEnough and not ItemUtil.isItemEnough(item.id, item.num) then
				itemEnough = false
			end
		end

		if not itemEnough then
			ToolTipsMgr.showCharacterTopToast(lang("tip_lack_of_material"), CommEnum.CharacterTopToastIcon.Fail, 1)

			return
		end

		ThinkingAgent.instance:sendUnlockThinkingRequest(heroData:getId(), thinkingId)
		self:_onClickClose()
	else
		printWarn(string.format("角色[%s]思维[%s]已解锁,无需解锁", heroData:getId(), thinkingId))
	end
end

function M:_onClickClose()
	self:close()
end

return M
