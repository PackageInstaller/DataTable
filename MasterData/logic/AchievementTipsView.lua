-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/view/AchievementTipsView.lua

module("logic.extensions.achievement.view.AchievementTipsView", package.seeall)

local AchievementTipsView = class("AchievementTipsView", ViewComponent)

function AchievementTipsView:ctor()
	AchievementTipsView.super.ctor(self)
end

function AchievementTipsView:destroyUI()
	AchievementTipsView.super.destroyUI(self)
end

function AchievementTipsView:onExitFinished()
	AchievementTipsView.super.onExitFinished(self)
end

function AchievementTipsView:onEnterFinished()
	AchievementTipsView.super.onEnterFinished(self)
end

function AchievementTipsView:unbindEvents()
	AchievementTipsView.super.unbindEvents(self)
end

function AchievementTipsView:bindEvents()
	AchievementTipsView.super.bindEvents(self)
end

function AchievementTipsView:onExit()
	AchievementTipsView.super.onExit(self)

	for _, item in ipairs(self._items) do
		goutil.setActive(item.mainGO, false)
	end

	removetimer(self._updateCell, self)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = {}
end

function AchievementTipsView:buildUI()
	AchievementTipsView.super.buildUI(self)

	self._items = {}
	self._content = self:getGo("content")

	for i = 1, self._content.transform.childCount do
		local go = self._content.transform:GetChild(i - 1).gameObject

		self:_insertItem(go)

		if i == 1 then
			self._cloneGo = go
		end
	end
end

function AchievementTipsView:_getFreeItem()
	local t = {}

	for _, item in ipairs(self._items) do
		if not item.mainGO.activeSelf then
			return item
		else
			table.insert(t, item)
		end
	end

	table.sort(t, function(a, b)
		local x1, y1, z1 = Framework.TransformUtil.GetLocalPos(a.mainGO.transform, 0, 0, 0)
		local x2, y2, z2 = Framework.TransformUtil.GetLocalPos(b.mainGO.transform, 0, 0, 0)

		return y2 < y1
	end)
	goutil.setActive(t[1].mainGO, false)

	return t[1]
end

function AchievementTipsView:_insertItem(go)
	local item = {}

	item.mainGO = go

	local container = goutil.findChild(go, "scale")

	item.txtName = goutil.findChildTextComponent(container, "txtName", "Text")
	item.txtContent = goutil.findChildTextComponent(container, "txtContent", "Text")
	item.imgIcon = goutil.findChildComponent(container, "icon/imgIcon", "UIImageSpriteChange")
	item._animator = go:GetComponent("Animator")

	table.insert(self._items, item)
	goutil.setActive(go, false)

	return item
end

local effPaths = {
	{
		goPath = "content/1/scale/point_eff1",
		path = "fx_ui_chengjiu/fx_ui_chengjiu.prefab"
	},
	{
		goPath = "content/2/scale/point_eff1",
		path = "fx_ui_chengjiu/fx_ui_chengjiu.prefab"
	},
	{
		goPath = "content/3/scale/point_eff1",
		path = "fx_ui_chengjiu/fx_ui_chengjiu.prefab"
	}
}

function AchievementTipsView:_createEffects()
	self._effs = {}

	for i, effPath in ipairs(effPaths) do
		local parent = self:getGo(effPath.goPath)
		local eff = UIEffectManager.instance:playHUDEffect(effPath.path, parent, true, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(parent) + 1)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

			eff.effGo.name = "fx_ui_chengjiu"

			self._items[i]._animator:Rebind()
		end, nil, false)

		table.insert(self._effs, eff)
	end
end

function AchievementTipsView:onEnter()
	AchievementTipsView.super.onEnter(self)
	self:_createEffects()
	self:_tryUpdateUI()
end

function AchievementTipsView:_tryUpdateUI()
	if not self._effLoaded then
		-- block empty
	end

	self._curViewDatas = AchievementModel.instance:enQueueNeedShow()

	Framework.TransformUtil.SetLocalPos(self._content.transform, 0, -215, 0)

	self._curShowIndex = 1

	settimer(0.6, self._updateCell, self)
	self:_updateCell()
end

function AchievementTipsView:_updateCell()
	local item = self:_getFreeItem()
	local achievementId = self._curViewDatas[self._curShowIndex]
	local cfg = AchievementConfig.instance:getCfgById(achievementId)

	if cfg == nil then
		print("invalid achievementId = " .. tostring(achievementId))
	else
		item.txtName.text = cfg.title
		item.txtContent.text = cfg.name

		item.imgIcon:SetState(cfg.root - 1)
	end

	Framework.TransformUtil.SetLocalPos(item.mainGO.transform, 0, -110 * (self._curShowIndex - 1), 0)
	goutil.setActive(item.mainGO, true)
	AudioPlayerEx.instance:playEffect(30224)

	if self._curShowIndex > 1 then
		local x, y, z = Framework.TransformUtil.GetLocalPos(self._content.transform, 0, 0, 0)

		self._content.transform:DOLocalMoveY(-215 + 110 * (self._curShowIndex - 1), 0.5, false)
	end

	self._curShowIndex = self._curShowIndex + 1

	if self._curShowIndex > #self._curViewDatas then
		removetimer(self._updateCell, self)
		settimer(1, self.close, self, false)
	end
end

return AchievementTipsView
