-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/binglingwang/BinglingwangdetailView.lua

module("logic.extensions.timelimitedchallenge.view.binglingwang.BinglingwangdetailView", package.seeall)

local BinglingwangdetailView = class("BinglingwangdetailView", ViewComponent)

function BinglingwangdetailView:ctor()
	BinglingwangdetailView.super.ctor(self)
end

function BinglingwangdetailView:buildUI()
	BinglingwangdetailView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTip = self:getGo("btnTip")
	self.txtCount = self:getTxt("survivePet/txtCount")
	self.cellList = {}

	for i = 1, 5 do
		local go = self:getGo("level_" .. i)

		table.insert(self.cellList, go)
	end

	self.btnDoor = self:getGo("btnDoor")
	self.bubble = self:getGo("bubble")
	self.txtBubble = self:getTxt("bubble/txtDesc")
end

function BinglingwangdetailView:bindEvents()
	BinglingwangdetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnDoor, self.onClickDoor, self)
	GameUtil.addClickHandler(self.btnTip, self.onClickRule, self)
end

function BinglingwangdetailView:unbindEvents()
	BinglingwangdetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnDoor)
	GameUtil.rmClickHandler(self.btnTip)
end

function BinglingwangdetailView:onClickDoor()
	local todayPassStage = checknumber(self.infoMo.todayPassStage)
	local isAll = checkbool(self.infoMo.everPassAllStage)
	local day = checknumber(self.infoMo.participateDays)
	local cfg = BinglingwangConfig.instance:getMonsterCfg(self.challengeId, day)

	if isAll or ((cfg or nil) and #cfg) <= todayPassStage then
		UIStateManager.instance:push(ViewName.LongnvmainView)
	else
		TipsFacade.instance:openCommonTips(lang("击败浮冰之路5个敌阵开启！"))
	end
end

function BinglingwangdetailView:onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "binglingwangchallenge1")
end

function BinglingwangdetailView:destroyUI()
	BinglingwangdetailView.super.destroyUI(self)
end

function BinglingwangdetailView:onEnter()
	BinglingwangdetailView.super.onEnter(self)

	self.challengeId = 15

	GlobalDispatcher:addListener(GlobalNotify.PM_IKCGetInfoRes, self.onRefreshUI, self)
	BinglingwangModel.instance:sendGetChanllengeInfo(self.challengeId)
	self:onRefreshUI()

	local effPath = "fx_ui_binglingwangtiaozhan/fx_ui_binglingwangtiaozhan_1.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setScale(1)

	local effPath = "fx_ui_binglingwangtiaozhan/fx_ui_fubingzhilu_chuansongmen.prefab"

	self._pmEff2 = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff2:setParent(self.mainGO.transform)
	self._pmEff2:setScale(1)
end

function BinglingwangdetailView:onExit()
	BinglingwangdetailView.super.onExit(self)
	self:clearTimer()
	GlobalDispatcher:removeListener(GlobalNotify.PM_IKCGetInfoRes, self.onRefreshUI, self)
	UIEffectManager.instance:stopEffect(self._pmEff)
	UIEffectManager.instance:stopEffect(self._pmEff2)
end

function BinglingwangdetailView:clearTimer()
	removetimer(self.onTimeBubble, self)
end

function BinglingwangdetailView:updateBubble(txtBubble)
	self.currentTxtBubble = txtBubble

	self:clearTimer()
	self:onTimeBubble()

	self.timer = settimer(5, self.onTimeBubble, self)
end

function BinglingwangdetailView:onTimeBubble()
	self.currentTxtBubble.text = BinglingwangConfig.instance:getRandBubbleTxt()
end

function BinglingwangdetailView:onRefreshUI(cid)
	self.infoMo = BinglingwangModel.instance:getChallangeInfoById(self.challengeId) or {}

	local count = checknumber(self.infoMo.todayAlivePetCount)

	self.txtCount.text = langPara("今日存活精灵：<color=#20b376>%s</color>只", count)

	self:clearTimer()

	for i, v in ipairs(self.cellList) do
		self:updateCell(i, v)
	end

	local todayPassStage = checknumber(self.infoMo.todayPassStage)
	local isAll = checkbool(self.infoMo.everPassAllStage)

	self.txtBubble.text = lang("首次击败5个敌阵\n开启龙塔传送门")

	local day = checknumber(self.infoMo.participateDays)
	local cfg = BinglingwangConfig.instance:getMonsterCfg(self.challengeId, day)

	if isAll or ((cfg or nil) and #cfg) <= todayPassStage then
		self.txtBubble.text = lang("通往龙塔\n传送门已开启！")
	end
end

function BinglingwangdetailView:updateCell(idx, go)
	local day = checknumber(self.infoMo.participateDays)
	local todayPassStage = checknumber(self.infoMo.todayPassStage)

	if not self.infoMo.everAlivePets then
		local everAlivePets = {}
		local cfg = BinglingwangConfig.instance:getMonsterCfg(self.challengeId, day)

		GameUtil.SetActive(go, false)

		if cfg and cfg[idx] then
			local data = cfg[idx]

			GameUtil.SetActive(go, true)

			local btnChallenge = goutil.findChild(go, "btnChallenge")
			local con = goutil.findChild(go, "btnChallenge/con")
			local passed = goutil.findChild(go, "btnChallenge/passed")
			local btnSweep = goutil.findChild(go, "btnSweep")
			local bubble = goutil.findChild(go, "bubble")
			local txtBubble = goutil.findChildTextComponent(go, "bubble/txtDesc")

			GameUtil.SetActive(btnSweep, false)
			GameUtil.SetActive(passed, false)
			GameUtil.SetActive(bubble, false)
			GameUtil.addClickHandler(btnChallenge, GameUtil.handler(self.onClickChallenge, self, idx, cfg))
			GameUtil.addClickHandler(btnSweep, GameUtil.handler(self.onClickSweep, self, idx, cfg))
			MaterialMgr.setIcon(con, MatType.Pet, data.showFaceId)

			if idx <= todayPassStage then
				GameUtil.SetActive(passed, true)
			elseif todayPassStage == idx - 1 then
				GameUtil.SetActive(bubble, true)
				self:updateBubble(txtBubble)

				local count = checknumber(everAlivePets[idx])
				local baseCfg = BinglingwangConfig.instance:getBaseConfig(self.challengeId) or {}

				if count >= checknumber(baseCfg.sweepNeedAlivePetCount) then
					GameUtil.SetActive(btnSweep, true)
				end
			end
		end
	end
end

function BinglingwangdetailView:onClickSweep(idx, cfg)
	local mo = BinglingwangModel.instance:getChallangeInfoById(self.challengeId) or {}

	if not mo.everAlivePets then
		local everAlivePets = {}
		local alive = checknumber(everAlivePets[idx])
		local ratio = (BinglingwangConfig.instance:getBaseConfig(self.challengeId) or {}).ratio
		local num = checknumber(ratio) * alive
		local str = langPara("你将开启扫荡直接通过本关\n按本关历史最高存活数计算\n（如未达到最高6只存活数，可选择继续挑战）\n<color=#ff0000>精灵存活=%s只</color>\n<color=#ff0000>冰晶雪花=%s片</color>", alive, num)

		TipsFacade.instance:openPopupWindow(lang("tip"), str, function()
			BinglingwangController.instance:sendSweep(self.challengeId, idx)
		end, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	end
end

function BinglingwangdetailView:onClickChallenge(idx, cfg)
	local todayPassStage = checknumber(self.infoMo.todayPassStage)

	if idx <= todayPassStage then
		TipsFacade.instance:openCommonTips(lang("今日已通关！"))
	elseif todayPassStage == idx - 1 then
		local params = {}

		params.challengeId = self.challengeId
		params.index = idx

		UIStateManager.instance:push(ViewName.BinglingwangMission, params)
	else
		TipsFacade.instance:openCommonTips(lang("请先通过前面挑战！"))
	end
end

return BinglingwangdetailView
