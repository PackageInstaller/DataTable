-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aixinmm/view/AixinmmmainView.lua

module("logic.extensions.aixinmm.view.AixinmmmainView", package.seeall)

local AixinmmmainView = class("AixinmmmainView", ViewComponent)

function AixinmmmainView:ctor()
	AixinmmmainView.super.ctor(self)
end

function AixinmmmainView:buildUI()
	AixinmmmainView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._jinhuaBtn = self:getBtn("jinhuaBtn")
	self._challengeBtn = self:getBtn("challengeBtn")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnInfo = self:getBtn("btnInfo")
	self._btnRule = self:getBtn("btnRule")
	self._roleConGo = self:getGo("roleCon")
	self._nameText = goutil.findChildTextComponent(self.mainGO, "nameText")
	self._rareEffectGo = self:getGo("rare")

	goutil.setActive(self._btnInfo.gameObject, false)

	self._challengeBtnEffectTr = self:getGo("challengeBtn").transform
	self._effectTr = self:getGo("effect").transform
	self.btnShop = self:getGo("btnShop")
	self.head = self:getGo("btnShop/head")
end

function AixinmmmainView:bindEvents()
	AixinmmmainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickcloseBtn, self)
	self._jinhuaBtn:AddClickListener(self._onClickjinhuaBtn, self)
	self._challengeBtn:AddClickListener(self._onClickchallengeBtn, self)
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
	self._btnRule:AddClickListener(self._onClickBtnRule, self)
	GameUtil.addClickHandler(self.btnShop, self.onClickShop, self)
end

function AixinmmmainView:unbindEvents()
	AixinmmmainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._jinhuaBtn:RemoveClickListener()
	self._challengeBtn:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnShop)
end

function AixinmmmainView:destroyUI()
	AixinmmmainView.super.destroyUI(self)
end

function AixinmmmainView:onEnter()
	AixinmmmainView.super.onEnter(self)

	self._raceId = AixinmmModel.instance:getMainViewShowRaceId()
	self._skinId = self._raceId

	GlobalDispatcher:addListener(AixinmmController.PM_AiXinMMClgGetInfoRes, self._PM_AiXinMMClgGetInfoRes, self)
	AiXinMMClgAgent.instance:sendPM_AiXinMMClgGetInfoReq()
	self:_updateView()
	self:_setFullEffect()
	self:_setBtnEffect()
	self:updateGoShop()
end

function AixinmmmainView:updateGoShop()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(7)

	local raceId = self._challengeCfg.raceId

	MaterialMgr.setIcon(self.head, MatType.Pet, raceId)
end

function AixinmmmainView:onClickShop()
	local goodsId = AixinmmConfig.instance:getCommonCfg("GOODS_ID")

	PayShopController.instance:buyShopItemWithTips(goodsId)
end

function AixinmmmainView:onEnterFinished()
	AixinmmmainView.super.onEnterFinished(self)
end

function AixinmmmainView:onExit()
	AixinmmmainView.super.onExit(self)
	self:_resetRole()
	UIEffectManager.instance:stopEffect(self._fullEffectHandler)
	UIEffectManager.instance:stopEffect(self._btnEffectHandler)
	MaterialMgr.clearIcon(self.head)
end

function AixinmmmainView:onExitFinished()
	AixinmmmainView.super.onExitFinished(self)
end

function AixinmmmainView:_onClickcloseBtn()
	self:close()
end

function AixinmmmainView:_onClickjinhuaBtn()
	if self._isEverEvolvePet then
		FloatWordMgr.instance:show("已完成爱心梦梦进化，请期待下一次活动开启哦！")

		return
	end

	local cid = AixinmmConfig.instance:getChallengeId()
	local exchangeCfg = TimeLimitedConfig.instance:getCfgById(cid)
	local evolveMo = EvolveMo.New()

	evolveMo:setParamById(AixinmmConfig.instance:getEvolvePetRaceId(), exchangeCfg.raceId)
	UIStateManager.instance:push(ViewName.Evolve, evolveMo)
end

function AixinmmmainView:_onClickchallengeBtn()
	UIStateManager.instance:push(ViewName.AixinmmchallengeView)
end

function AixinmmmainView:_onClickbtnChallenge()
	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self._raceId)
end

function AixinmmmainView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function AixinmmmainView:_updateView()
	self:_setRole()
	self:_setBtnState()
end

function AixinmmmainView:_setRole()
	local cfg = CharacterConfig.instance:getPetCo(self._raceId)

	if cfg then
		self._nameText.text = cfg.name or "未知"
	end

	local x, y, scale = AixinmmConfig.instance:getMainViewModelSizeCfg()

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._skinId, self._roleConGo, scale, nil, true, x, y)

	local path = "fx_ui_mangmianban/new/fx_ui_chuanshuo_daizi.prefab"

	local function loadCallBack()
		self._effectHandler:setClipping(self._rareEffectGo:GetComponent(goutil.Type_RectTransform))
	end

	self._effectHandler = UIEffectManager.instance:playEffect(self, path, self._rareEffectGo, 0, 0, true, false, nil, loadCallBack)

	self._effectHandler:setParent(self._rareEffectGo.transform)
	self._effectHandler:setScale(1)
	self._effectHandler:setLocalPos(0, 0)
end

function AixinmmmainView:_resetRole()
	RoleObjectPool.instance:removeRole(self._roleObj)
	UIEffectManager.instance:stopEffect(self._effectHandler)
end

function AixinmmmainView:_setBtnState()
	self._isAllClgPass = false
	self._isEverEvolvePet = AixinmmModel.instance:isEverEvolvePet()

	if not self._isEverEvolvePet then
		self._isAllClgPass = AixinmmModel.instance:isAllClgPass()
	end

	GameUtil.SetGray(self._jinhuaBtn, self._isEverEvolvePet)
end

function AixinmmmainView:_PM_AiXinMMClgGetInfoRes(status)
	if status == 0 then
		self:_setBtnState()
	end
end

function AixinmmmainView:_setFullEffect()
	local path = "fx_ui_tiaozhanaixinmengmeng/prefab/fx_ui_tiaozhan_aixinmengmeng_04.prefab"

	self._fullEffectHandler = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, false)

	self._fullEffectHandler:setParent(self._effectTr)
	self._fullEffectHandler:setScale(1)
	self._fullEffectHandler:setLocalPos(0, 0)
end

function AixinmmmainView:_setBtnEffect()
	local path = "fx_ui_tiaozhanaixinmengmeng/prefab/fx_ui_tiaozhan_aixinmengmeng_01.prefab"

	self._btnEffectHandler = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, false)

	self._btnEffectHandler:setParent(self._challengeBtnEffectTr)
	self._btnEffectHandler:setScale(1)
	self._btnEffectHandler:setLocalPos(0, 0)
end

function AixinmmmainView:_onClickBtnRule()
	ViewMgr.instance:open(ViewName.RulesView, "aixinmmchallenge")
end

return AixinmmmainView
