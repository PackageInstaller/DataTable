-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/petshow/AceteamshowView.lua

module("logic.extensions.aceteam.view.petshow.AceteamshowView", package.seeall)

local AceteamshowView = class("AceteamshowView", ViewComponent)
local TabConst = {
	SourceTrace = 9,
	PetSkillView = 2
}
local STACK_LIST = {
	[4] = ViewName.AceteamequipView,
	[3] = ViewName.AceteamstargodView,
	[2] = ViewName.AceteampetskillView,
	[7] = ViewName.AceteamawakeView,
	[8] = ViewName.AceteamHolyStripeView,
	[9] = ViewName.AceteamsourcetraceView
}
local STACK_ID = {
	nil,
	2,
	1,
	3,
	nil,
	nil,
	4,
	5,
	2
}

function AceteamshowView:ctor()
	AceteamshowView.super.ctor(self)
end

function AceteamshowView:unbindEvents()
	AceteamshowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function AceteamshowView:bindEvents()
	AceteamshowView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnAdd, self.onClickBtnAdd, self)
end

function AceteamshowView:buildUI()
	AceteamshowView.super.buildUI(self)

	self.btnClose = self:getGo("Left/btn_close")
	self._roleGo = self:getGo("mask/role")
	self.score = self:getGo("score")
	self.txtScore = self:getTxt("score/txtScore")
	self.item = self:getGo("score/item")
	self.btnAdd = self:getGo("score/btnAdd")
	self.txt_name = self:getTxt("Middle/info/txt_name")
	self.txtPower = self:getTxt("Middle/info/txtPower")
	self.tableview = self:getGo("petList/tableview")
	self.cell = self:getGo("petList/cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self._tabs = {}

	local btn

	for i = 1, 9 do
		local go = self:getGo("Left/yeqian/tab_" .. i)

		table.insert(self._tabs, go)
		self:getBtn(string.format("Left/yeqian/tab_%s", i)):AddClickListener(function()
			self:_onClickTab(i)
		end)
	end

	self._Container = self:getGo("container")
	self._goldBarCon = self:getGo("goldBarCon")
	self.tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
end

function AceteamshowView:onExit()
	AceteamshowView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)
end

function AceteamshowView:onEnter()
	AceteamshowView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ACETEAM_GETINFO, self.onRefreshUI, self)

	local groupId = checknumber(AceTeamModel.instance.teamId)
	local list = AceTeamConfig.instance:getPetListByGroupId(groupId)
	local petList = {}

	for i, cfg in ipairs(list) do
		local petMo = AceTeamModel.instance:getPetMoByCfgId(cfg.creepsMasterId, cfg.creepsId)

		table.insert(petList, petMo)

		if i == 1 then
			AceTeamModel.instance:setCurrPetMo(petMo)
		end
	end

	self.scrollList:reloadData(petList)

	for k, v in pairs(STACK_LIST) do
		local isOpen = self:getTabIsOpen(k)
		local go = self._tabs[k]

		if go then
			local lock = goutil.findChild(go, "lock")

			GameUtil.SetActive(lock, not isOpen)
		end
	end

	self:_onClickTab(4)
	MaterialMgr.setIcon(self.item, MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT)
	self:onRefreshUI()

	local btnList = {
		{
			showAdd = true,
			id = MaterialMgr.createSerName(MatType.Item_Fake, AceTeamModel.ITEM_ACE_POINT),
			showAddCallBack = function()
				AceTeamController.instance:sendAddPointCount()
			end
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function AceteamshowView:onRefreshUI()
	local petMo = AceTeamModel.instance:getCurrPetMo() or {}

	self:showPetView(petMo)
end

function AceteamshowView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local top = goutil.findChild(cell, "top")
	local selected = goutil.findChild(cell, "selected")

	GameUtil.addClickHandler(top, GameUtil.handler(self.clickCell, self, data))
	MaterialMgr.setCell(MatType.Pet, data.curFaceId, con)

	local petMo = AceTeamModel.instance:getCurrPetMo() or {}

	GameUtil.SetActive(selected, data.petId == petMo.petId)
	self:showPetView(petMo)
end

function AceteamshowView:clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function AceteamshowView:clickCell(petMo)
	AceTeamModel.instance:setCurrPetMo(petMo)
	self:showPetView(petMo)
	self.scrollList:refresh()
end

function AceteamshowView:onClickBtnAdd()
	AceTeamController.instance:sendAddPointCount()
end

function AceteamshowView:_onClickTab(idx)
	local isOpen = self:getTabIsOpen(idx, true)

	if isOpen then
		self:onShowView(idx)
	end
end

function AceteamshowView:getTabIsOpen(idx, isShowTips)
	local malNum = checknumber(AceTeamModel.instance.historyMedal)
	local cfg = AceTeamConfig.instance:getTeamLvlCfg()

	for i, v in ipairs(cfg) do
		if v.openStrengthenLvUp == STACK_ID[idx] then
			if malNum >= v.medal then
				do return true end

				break
			end

			if isShowTips then
				FloatWordMgr.instance:show(v.lockTips)
			end

			break
		end
	end

	return false
end

function AceteamshowView:onShowView(idx)
	local name = STACK_LIST[idx]

	if name == nil then
		FloatWordMgr.instance:show(ConstString.NotRelease)

		return
	end

	if self._tabs[idx] then
		for i = 1, #self._tabs do
			local btn = self._tabs[i]:GetComponent(goutil.Type_UIButton)

			btn.interactable = i ~= idx
		end
	end

	self.curTabIdx = idx

	self:showTabAt(self._Container, name)
end

function AceteamshowView:showPetView(petMo)
	local groupId = checknumber(AceTeamModel.instance.teamId)
	local petId = petMo.petId

	self.txt_name.text = petMo:getName()
	self.txtPower.text = petMo:getFightingPower()

	local cfg = AceTeamConfig.instance:getPetCfgById(groupId, petId)
	local skinId = petMo.curFaceId
	local loader
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		local x = 0

		if not modelCfg[2] then
			local y = 0

			if cfg.offset then
				x = modelCfg[1] + cfg.offset[1]
				y = y + cfg.offset[2]
			end

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._roleGo, scale, function(go)
					if go ~= nil then
						self:setAllSkeletonMask(go)
					end
				end, true, modelCfg[1], y)

				local isSourceTrace = false
				local groupId = checknumber(AceTeamModel.instance.teamId)
				local petId = petMo.petId
				local cfg = AceTeamConfig.instance:getPetCfgById(groupId, petId)
				local sourceTraceGroupId = checknumber(cfg.sourceTraceGroupId)

				if sourceTraceGroupId > 0 then
					isSourceTrace = PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.JobZhDefine.SourceTrace)
				end

				GameUtil.SetActive(self._tabs[TabConst.PetSkillView], not isSourceTrace)
				GameUtil.SetActive(self._tabs[TabConst.SourceTrace], isSourceTrace)

				if self.curTabIdx == TabConst.SourceTrace and not isSourceTrace then
					self:_onClickTab(TabConst.PetSkillView)
				end

				if self.curTabIdx == TabConst.PetSkillView and isSourceTrace then
					self:_onClickTab(TabConst.SourceTrace)
				end
			end
		end
	end
end

function AceteamshowView:setAllSkeletonMask(go)
	local skeleton = goutil.findChildComponent(go, "skeleton", "SkeletonGraphic")

	if skeleton then
		self.tempMat.mainTexture = skeleton.material.mainTexture
		skeleton.material = self.tempMat
	end

	local trs = go.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)

		self:setAllSkeletonMask(child)
	end
end

return AceteamshowView
