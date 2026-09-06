-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/scufflemission/CampScuffleMissionFmtView.lua

module("logic.extensions.funcamp.view.scufflemission.CampScuffleMissionFmtView", package.seeall)

local CampScuffleMissionFmtView = class("CampScuffleMissionFmtView", MissionFmtView)

function CampScuffleMissionFmtView:ctor()
	CampScuffleMissionFmtView.super.ctor(self)

	self._scuffleCellList = {}
end

function CampScuffleMissionFmtView:buildUI()
	CampScuffleMissionFmtView.super.buildUI(self)

	self._Nego_Seats = self:getGo("FmtRight/Nego_Seats")
	self._layerBg = self:getGo("FmtRight/layerBg")
	self._layerRole = self:getGo("FmtRight/layerRole")
	self._layerUI = self:getGo("FmtRight/layerUI")

	self:_buildUIExtension()
end

function CampScuffleMissionFmtView:bindEvents()
	CampScuffleMissionFmtView.super.bindEvents(self)
end

function CampScuffleMissionFmtView:unbindEvents()
	CampScuffleMissionFmtView.super.unbindEvents(self)
end

function CampScuffleMissionFmtView:_buildUIExtension()
	self._extension = self:getGo("extension")

	local go = self:getResInstance(CampScuffleMissionViewPresentor.FmtPetsPath)

	goutil.addChildToParent(go, self._extension)

	local name = "scufflefmtpets"

	go.name = name
	self._scrollRect = self:getGo(string.format("extension/%s/tableview", name)):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._petContainer = self:getGo(string.format("extension/%s/tableview/viewport/petContainer", name))
	self._petCell = self:getGo(string.format("extension/%s/petCell", name))

	self._petCell:SetActive(false)

	local prePath = "extension/" .. name .. "/"

	self._headIcon = self:getGo(string.format("extension/%s/playerInfo/headIcon", name))
	self._txtName = self:getTxt(string.format("extension/%s/playerInfo/name/txtName", name))
	self._txtArea = self:getTxt(string.format("extension/%s/playerInfo/txtArea", name))
	self._txtRank = self:getTxt(string.format("extension/%s/playerInfo/txtRank", name))
	self._levelIcon = self:getGo(string.format("extension/%s/playerInfo/grade", name))
	self._txtLeftTime = self:getTxt(string.format("extension/%s/txtLeftTime", name))
	self._waitShow = self:getGo(string.format("extension/%s/waitShow", name))
	self._txtWait = self:getTxt(string.format("extension/%s/waitShow/txtWait", name))
	self._btnBuff = self:getBtn(prePath .. "btnBuff")

	goutil.setActive(self._btnBuff.gameObject, false)
end

function CampScuffleMissionFmtView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.CS_SetFormRes, self._onSetFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CampScuffleClickEnterBattle, self._onClickStartBtn, self)
	self:_closeFormationShow()
	self:_setRightSpeedAndPower("？？？", "？？？")
	self:_setEnemyInfo()
	self:_initPetList()

	self._countdown = CampScuffleModel.instance:getFormationCountDown()
	self._isCountDown = true

	self:_showTxtLeftTime(self._countdown)
	self:_endWaitShow()
	settimer(1, self._onSecond, self)
end

function CampScuffleMissionFmtView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CS_SetFormRes, self._onSetFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ScuffleClickEnterBattle, self._onClickStartBtn, self)
	removetimer(self._onSecond, self)
	self:_removeCardList()
	self:_removeHeadIcon()
	self:_removeLevelIcon()
	self:_endWaitShow()
end

function CampScuffleMissionFmtView:_onSetFormRes()
	self:_showWaitTxt()
	self:_startWaitShow(self._countdown)
end

function CampScuffleMissionFmtView:_onClickStartBtn()
	self._isCountDown = false
end

function CampScuffleMissionFmtView:_onSecond()
	if self._isCountDown then
		if self._countdown > 0 then
			self._countdown = self._countdown - 1

			self:_showTxtLeftTime(self._countdown)
		else
			self._isCountDown = false
		end
	end

	if self._isStartWaitShow then
		if self._waitCountdown > 0 then
			self._waitCountdown = self._waitCountdown - 1

			self:_showWaitLeftTime(self._waitCountdown)
		else
			self:_stopWaitShow()
		end
	end
end

function CampScuffleMissionFmtView:_closeFormationShow()
	self._Btn_HeroSkill.gameObject:SetActive(false)
	goutil.setActive(self._psychicSkillGo, false)
	goutil.setActive(self._domainSkillGo, false)
	self._Nego_Seats:SetActive(false)
	self._layerBg:SetActive(false)
	self._layerRole:SetActive(false)
	self._layerUI:SetActive(false)
end

function CampScuffleMissionFmtView:_initPetList()
	self._scuffleCellList = {}

	local creepsIdList = CampScuffleModel.instance:getEnemyAllPets()

	for index, id in ipairs(creepsIdList) do
		local go = goutil.cloneAndSetParent(self._petCell, self._petContainer.transform, "fmtCell" .. index)

		go:SetActive(true)

		local cell = GameUtil.AddLuaOnce(go, CampScuffleFmtCell)

		cell:buildUI(go)
		cell:init(index, id)
		table.insert(self._scuffleCellList, cell)
	end

	self._scrollRect.verticalNormalizedPosition = 1
end

function CampScuffleMissionFmtView:_removeCardList()
	for i, v in ipairs(self._scuffleCellList) do
		v:onReset()
	end

	table.clear(self._scuffleCellList)
	goutil.clearChildren(self._petContainer)
end

function CampScuffleMissionFmtView:_setEnemyInfo()
	self._txtRank.text = "排名 " .. CampScuffleModel.instance:getEnemyRank()
	self._txtName.text = CampScuffleModel.instance:getEnemyName()
	self._txtArea.text = CampScuffleModel.instance:getEnemyAreaName()

	HeadItemController.instance:setHeadCellByInfo(self._headIcon, CampScuffleModel.instance:getEnemyHeadInfo())

	local cfg = CampGameConfig.instance:getLevelCfgByScore(CampScuffleModel.instance:getEnemyScore())

	if cfg then
		uGuiUtil.setSpriteToImage(self._levelIcon, uGuiUtil.SpriteType.BigBg, string.format(CampScuffleModel.LevelPath, cfg.icon))
	end
end

function CampScuffleMissionFmtView:_removeLevelIcon()
	local enemyLevel = Framework.ImageBigBG.Get(self._levelIcon)

	enemyLevel:ClearImage()
end

function CampScuffleMissionFmtView:_removeHeadIcon()
	MaterialMgr.resetAll(self._headIcon)
end

function CampScuffleMissionFmtView:_showTxtLeftTime(num)
	self._txtLeftTime.text = string.format("剩余时间：%d秒", num)
end

function CampScuffleMissionFmtView:_showWaitTxt()
	self._txtLeftTime.text = "等待对方布阵"
end

function CampScuffleMissionFmtView:_startWaitShow(time)
	self._isStartWaitShow = true
	self._waitCountdown = time

	self._waitShow:SetActive(true)
	self:_showWaitLeftTime(self._waitCountdown)
end

function CampScuffleMissionFmtView:_stopWaitShow()
	self._isStartWaitShow = false
end

function CampScuffleMissionFmtView:_endWaitShow()
	self:_stopWaitShow()
	self._waitShow:SetActive(false)
end

function CampScuffleMissionFmtView:_showWaitLeftTime(second)
	self._txtWait.text = string.format("剩余<color=#ff0000>%d</color>秒", math.max(0, second))
end

return CampScuffleMissionFmtView
