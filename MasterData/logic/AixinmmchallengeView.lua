-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/view/AixinmmchallengeView.lua

module("logic.extensions.aixinmm.view.AixinmmchallengeView", package.seeall)

local AixinmmchallengeView = class("AixinmmchallengeView", ViewComponent)

function AixinmmchallengeView:ctor()
	AixinmmchallengeView.super.ctor(self)
end

function AixinmmchallengeView:buildUI()
	AixinmmchallengeView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._btnSkill = self:getBtn("btnSkill")
	self._btnInfo = self:getBtn("btnInfo")
	self._challengeBtn = self:getBtn("challengeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._cellConGo = self:getGo("cellCon")
	self._itemGroup = ItemGroup.New(self._cellConGo)
	self._roleConGo = self:getGo("roleCon")
	self._nameText = goutil.findChildTextComponent(self.mainGO, "nameText")
	self._descText = goutil.findChildTextComponent(self.mainGO, "descText")
	self._rareEffectGo = self:getGo("rare")
	self._challengeBtnTextChange = self:getGo("challengeBtn/text"):GetComponent(ComponentType.UIImageSpriteChange)
	self._btnRule = self:getBtn("btnRule")
	self._nameEffectGo = self:getGo("img/effect")
end

function AixinmmchallengeView:bindEvents()
	AixinmmchallengeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
	self._challengeBtn:AddClickListener(self._onClickchallengeBtn, self)
	self._tipsBtn:AddClickListener(self._onClicktips, self)
	self._btnRule:AddClickListener(self._onClickbtnRule, self)
end

function AixinmmchallengeView:unbindEvents()
	AixinmmchallengeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._challengeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function AixinmmchallengeView:destroyUI()
	AixinmmchallengeView.super.destroyUI(self)
end

function AixinmmchallengeView:onEnter()
	AixinmmchallengeView.super.onEnter(self)

	self._mcfgs = AixinmmConfig.instance:getMonsterCfgs()
	self._selectIndex = self._selectIndex or 1

	self:_updateView()
	self:_setRareEffect()
	self:_setNameEffect()
end

function AixinmmchallengeView:onEnterFinished()
	AixinmmchallengeView.super.onEnterFinished(self)
end

function AixinmmchallengeView:onExit()
	AixinmmchallengeView.super.onExit(self)
	self:_resetRole()
	self._itemGroup:dispose(function(item)
		return
	end)
	UIEffectManager.instance:stopEffect(self._effectHandler)
	UIEffectManager.instance:stopEffect(self._nameEffectHandler)
end

function AixinmmchallengeView:onExitFinished()
	AixinmmchallengeView.super.onExitFinished(self)
end

function AixinmmchallengeView:_onClickcloseBtn()
	self:close()
end

function AixinmmchallengeView:_onClickbtnSkill()
	if self._raceId then
		PetCvController.instance:turnOffCurCv()
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function AixinmmchallengeView:_onClickbtnInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function AixinmmchallengeView:_onClickchallengeBtn()
	if self._creepsMasterId then
		UIStateManager.instance:push(ViewName.AixinmmMissionView, self._creepsMasterId)
	end
end

function AixinmmchallengeView:_onClicktips()
	UIStateManager.instance:push(ViewName.AixinmmtipsView)
end

function AixinmmchallengeView:_onClickbtnRule()
	TipsFacade.instance:openRulesView("aixinmm_" .. self._selectIndex)
end

function AixinmmchallengeView:_updateView()
	self:_switch(self._selectIndex, true)
end

function AixinmmchallengeView:_updateItems()
	self._itemGroup:updateWithNoCreate(5, function(item, index)
		local cfg = self._mcfgs[index]
		local btn = Framework.ButtonAdapter.Get(item.mainGO)
		local ywcGo = goutil.findChild(item.mainGO, "ywc")
		local selectGo = goutil.findChild(item.mainGO, "select")
		local isFinish = AixinmmModel.instance:getClgPassStateById(cfg.creepsMasterId)

		goutil.setActive(item.mainGO, true)
		goutil.setActive(ywcGo, isFinish)
		goutil.setActive(selectGo, self._selectIndex == index)
		btn:AddClickListener(function()
			self:_switch(index)
		end)
	end)
end

function AixinmmchallengeView:_switch(index, force)
	if self._selectIndex == index and not force then
		return
	end

	local mcfg = self._mcfgs[index]

	if not mcfg then
		return
	end

	local isFinish = AixinmmModel.instance:getClgPassStateById(mcfg.creepsMasterId)

	self._selectIndex = index
	self._raceId = mcfg.showRaceId
	self._skinId = mcfg.showRaceId

	local petCo = CharacterConfig.instance:getPetCo(mcfg.showRaceId)

	if petCo then
		if not petCo.name then
			local x, y, scale = mcfg.modelSize[1], mcfg.modelSize[2], mcfg.modelSize[3]

			self._nameText.text = "未知"
			self._descText.text = mcfg.description
			self._creepsMasterId = mcfg.creepsMasterId

			self:_setRole(x, y, scale)
			self:_updateItems()
			self._challengeBtnTextChange:SetState(isFinish and 1 or 0)
		end
	end
end

function AixinmmchallengeView:_setRole(x, y, scale)
	self:_resetRole()

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._skinId, self._roleConGo, scale, nil, true, x, y)
end

function AixinmmchallengeView:_resetRole()
	RoleObjectPool.instance:removeRole(self._roleObj)
end

function AixinmmchallengeView:_setRareEffect()
	local path = "fx_ui_mangmianban/new/fx_ui_chuanshuo_daizi.prefab"

	local function loadCallBack()
		self._effectHandler:setClipping(self._rareEffectGo:GetComponent(goutil.Type_RectTransform))
	end

	self._effectHandler = UIEffectManager.instance:playEffect(self, path, self._rareEffectGo, 0, 0, true, false, nil, loadCallBack)

	self._effectHandler:setParent(self._rareEffectGo.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0)
end

function AixinmmchallengeView:_setNameEffect()
	local path = "fx_ui_tiaozhanhetimengmeng/prefab/fx_ui_tiaozhan_hetimengmeng_01.prefab"

	self._nameEffectHandler = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, false)

	self._nameEffectHandler:setParent(self._nameEffectGo.transform)
	self._nameEffectHandler:setScale(1)
	self._nameEffectHandler:setLocalPos(0, 0)
end

return AixinmmchallengeView
