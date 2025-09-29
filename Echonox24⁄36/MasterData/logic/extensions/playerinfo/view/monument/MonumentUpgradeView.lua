-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/monument/MonumentUpgradeView.lua

module("logic.extensions.playerinfo.view.monument.MonumentUpgradeView", package.seeall)

local M = class("MonumentUpgradeView", ViewComponent)
local ShowType = {
	UnLock = "unlock",
	UpGrade = "upgrade"
}

function M:ctor()
	M.super.ctor(self)

	self._step = 1
	self._isPlayingAnim = false
end

function M:buildUI()
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "common_full_tips_bg/clickExit"))
	self._panelGet = goutil.findChild(self.mainGO, "allContent/panel1")
	self._panelList = goutil.findChild(self.mainGO, "allContent/panel2")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "allContent/panel1/syndrome_card_item_copy/imgSyndromeCard")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "allContent/txtTitle")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "allContent/panel1/syndrome_card_item_copy/txtName")
	self._txtContent = goutil.findChildComponent(self.mainGO, "allContent/panel1/txtContent", UIComponentType.TextMeshProUGUI)
	self._redPointGo = goutil.findChild(self.mainGO, "allContent/panel1/syndrome_card_item_copy/red_point")

	goutil.setActive(self._redPointGo, false)

	self._scrollGo = goutil.findChild(self.mainGO, "allContent/panel2/scroll")
	self._scrollRect = self._scrollGo:GetComponent(UIComponentType.ScrollRect)
	self._loopGridHelper = LoopGridViewHelper.New(self._scrollGo)

	self._loopGridHelper:InitGridView(0, self._onCellUpdate, self)

	self._txtUnlockCount = goutil.findChildTextComponent(self.mainGO, "allContent/panel2/txtNum")
	self._moveItemGo = goutil.findChild(self.mainGO, "allContent/panel1/syndrome_card_item_copy")
	self._animation = self._moveItemGo:GetComponent(ComponentType.Animation)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._btnClose, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	local ids = MonumentModel.instance:getAllMonumentIds()

	MonumentModel.instance:updateMonumentListModel(ids)

	local params = self:getFirstParam()

	self._showType = params.type or ShowType.UnLock
	self._syndromeCards = MonumentModel.instance:getMonumentListModel():getMoList()
	self._step = 1
	self._data = params.data
	self._txtName.text = self._data.title
	self._txtContent.text = self._data.mo:getText()

	IconLoader.setSprite(self._imgIcon, IconType.Monument, self._data.iconName)

	local maxLv = MonumentModel.instance:getMaxLevel(self._data.mo:getNo())
	local material = self._imgIcon.material

	if MonumentUtil.isLoaded() then
		if maxLv == self._data.mo:getLv() then
			material = MonumentUtil.getMaterial(3)
		elseif self._data.mo:getLv() == 1 then
			material = MonumentUtil.getMaterial(1)
		else
			material = MonumentUtil.getMaterial(2)
		end
	end

	self._imgIcon.material = material

	self._animation:Stop()
	self._animation:Play("syndrome_card_item_open1")

	self._isPlayingAnim = true

	settimer(2, self._animDone, self, false)

	if self._showType == ShowType.UpGrade then
		self._txtTitle.text = lang("tip_monument_upgrade")
	else
		self._txtTitle.text = lang("tip_monument_unlock")

		local mo

		for i, v in ipairs(self._syndromeCards) do
			if v:getId() == self._data.mo:getId() then
				mo = table.remove(self._syndromeCards, i)
			end
		end

		if mo then
			table.insert(self._syndromeCards, mo)
		end
	end

	self:_setContent()
end

function M:onExit()
	removetimer(self._animDone, self)
	removetimer(self._btnClose, self)
	removetimer(self._disableScroll, self)
	FloatWordMgr.instance:show(lang("tip_monument_update"))
	IconLoader.clearSprite(self._imgIcon)

	self._targetGo = false
	self._isPlayingAnim = false
end

function M:onExitFinished()
	self:_onClearClone()
end

function M:_setContent()
	goutil.setActive(self._panelGet, self._step == 1)
	goutil.setActive(self._panelList, self._step == 2)

	self._scrollRect.enabled = true
	self._txtUnlockCount.text = string.format(lang("tip_monument_unlock_num_des"), #self._syndromeCards)

	self._loopGridHelper:SetListItemCount(#self._syndromeCards, false)
	self._loopGridHelper:RefreshAllShownItem()

	local pos = self._focusIndex and self._focusIndex or #self._syndromeCards

	if not self._focusIndex then
		self._focusIndex = #self._syndromeCards
	end

	if self._showType == ShowType.UnLock or self._focusIndex and self._focusIndex > 4 then
		self._loopGridHelper:MoveToItemIndex(math.ceil(pos))
	end

	settimer(0.1, self._disableScroll, self, false)

	if self._step == 2 then
		if self._targetGo then
			self._animation:Stop()

			self._moveCloneGo = goutil.cloneAndSetParent(self._moveItemGo, self._panelList.transform)
			self._animation = self._moveCloneGo:GetComponent(ComponentType.Animation)

			self._animation:Stop()

			local x, y, z = Astral.TransformUtil.GetLocalPos(self._targetGo.transform, 0, 0, 0)
			local width = goutil.getWidth(self._targetGo.transform)
			local height = goutil.getHeight(self._targetGo.transform)

			Astral.TransformUtil.SetLocalPos(self._targetGo.transform, x + width / 2, y - height / 2, 0)

			local vec3Temp = Vector3.New()

			vec3Temp:Set(x + width / 2, y - height / 2, z)
			self._moveCloneGo.transform:DOMove(self._targetGo.transform.position, 0.3):OnComplete(self._onMoveFinish, self)
		else
			self:_btnClose()
		end
	end
end

function M:_disableScroll()
	if not goutil.isNil(self._scrollGo) then
		self._scrollRect.enabled = false
	end
end

function M:_animDone()
	self._isPlayingAnim = false
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopGridHelper:NewListViewItem("syndrome_card_item_copy")
	local view = Astral.LuaComponentContainer.Add(item.gameObject, MonumentItemCell)
	local monumentMo = self._syndromeCards[curIndex]

	view:playAutomatically(true)
	view:updateData(monumentMo, true, false)
	view:showRedPoint(false)

	if self._data.title == monumentMo:getName() then
		self._targetGo = item
		self._focusIndex = curIndex

		goutil.setActive(item.gameObject, false)
	end

	return item
end

function M:_onMoveFinish()
	self._animation:Stop()
	self._animation:Play("syndrome_card_item_open2")

	self._isPlayingAnim = true

	settimer(2.5, self._animDone, self, false)
	settimer(2.8, self._btnClose, self, false)
end

function M:_onClearClone()
	goutil.setActive(self._moveCloneGo, false)
	goutil.destroy(self._moveCloneGo)
end

function M:_btnClose()
	if self._isPlayingAnim then
		return
	end

	self._step = self._step + 1

	self:_setContent()

	if self._step > 2 then
		ViewMgr.instance:close(ViewName.MonumentUpgrade)
	end
end

return M
