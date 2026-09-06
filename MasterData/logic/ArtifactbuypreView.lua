-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/saintknight/ArtifactbuypreView.lua

module("logic.extensions.bonus.view.saintknight.ArtifactbuypreView", package.seeall)

local ArtifactbuypreView = class("ArtifactbuypreView", ViewComponent)

function ArtifactbuypreView:ctor()
	ArtifactbuypreView.super.ctor(self)
end

function ArtifactbuypreView:unbindEvents()
	ArtifactbuypreView.super.unbindEvents(self)

	for j = 1, #self._btnJumpList do
		GameUtil.rmClickHandler(self._btnJumpList[j])
	end

	for i = 1, #self._btnInfoList do
		GameUtil.rmClickHandler(self._btnInfoList[i])
	end

	GameUtil.rmClickHandler(self._btnH5)
end

function ArtifactbuypreView:bindEvents()
	ArtifactbuypreView.super.bindEvents(self)

	for j = 1, #self._btnJumpList do
		GameUtil.addClickHandler(self._btnJumpList[j], function()
			self:_onClickJump(self._jumpStr[j], self._behaviorId[j])
		end, self)
	end

	for i = 1, #self._btnInfoList do
		GameUtil.addClickHandler(self._btnInfoList[i], function()
			self:_onClickPetInfo(self._raceInfos[i])
		end, self)
	end

	GameUtil.addClickHandler(self._btnH5, self._onClickH5, self)
end

function ArtifactbuypreView:buildUI()
	ArtifactbuypreView.super.buildUI(self)

	self._imgBg = self:getGo("bg")
	self._btnJumpList = {}
	self._btnJumpTxtList = {}
	self._behaviorId = {}
	self._behaviorId[1] = 201065
	self._behaviorId[2] = 201066

	for j = 1, 2 do
		local jump = self:getBtn("btnJump_" .. j)
		local txt = goutil.findChildTextComponent(jump, "Text")

		if jump then
			table.insert(self._btnJumpList, jump)
			table.insert(self._btnJumpTxtList, txt)
		end
	end

	self._btnInfoList = {}

	for i = 1, 2 do
		local btn = self:getBtn("btnInfo_" .. i)

		if btn then
			table.insert(self._btnInfoList, btn)
		end
	end

	self._itemCon = self:getGo("itemCon")
	self._btnH5 = self:getBtn("btnH5")
	self._txtDesc1 = self:getTxt("desc_1/txt")
end

function ArtifactbuypreView:onExit()
	ArtifactbuypreView.super.onExit(self)
	MaterialMgr.resetAll()
	uGuiUtil.clearImage(self._imgBg)
end

function ArtifactbuypreView:onEnter()
	ArtifactbuypreView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local paramStr = params[1]
	local arr = string.split(paramStr, "#")

	self._artifactId = checknumber(arr[1])

	local descStr = arr[2]

	self._cfg = XiaonuoBirthConfig.instance:getArtifactCfgById(self._artifactId)

	uGuiUtil.setSpriteToImage(self._imgBg, nil, GameUrl.getBigbgFolderUrl("bonus", self._cfg.imgBg))

	self._raceInfos = self._cfg.raceId
	self._posList = string.split(self._cfg.infoPos, "#")

	GameUtil.SetActive(self._btnInfoList[1], self._raceInfos[1])
	GameUtil.SetActive(self._btnInfoList[2], self._raceInfos[2])

	for i = 1, #self._btnInfoList do
		if self._posList then
			local rect = self._btnInfoList[i]:GetComponent(goutil.Type_RectTransform)
			local posXY = string.split(self._posList[i], ",")

			GameUtil.setLocalPos(rect, checknumber(posXY[1]), checknumber(posXY[2]))
		end
	end

	self._jumpDesc = string.split(self._cfg.txtJump, "#")
	self._jumpStr = string.split(self._cfg.jumpTo, ";")

	for j = 1, 2 do
		if self._jumpDesc[j] then
			self._btnJumpTxtList[j].text = self._jumpDesc[j]
		end
	end

	self._matArr = string.split(self._cfg.items, "#")

	MaterialMgr.resetAll(self._itemCon)

	for k, v in ipairs(self._matArr) do
		MaterialMgr.setCellByCfg(self._matArr[k], self._itemCon, nil, nil, false)
	end

	self._txtDesc1.text = descStr
end

function ArtifactbuypreView:_onClickPetInfo(raceId)
	if raceId == nil then
		return
	end

	PetbookController.instance:openPetinfoView(raceId)
end

function ArtifactbuypreView:_onClickJump(str, id)
	if str == nil then
		return
	end

	GotoMgr.gotoByString(str)
	SurveyController.instance:reportBehavior(id)
end

function ArtifactbuypreView:_onClickH5()
	local isOffical = SDKManager.isOfficial()

	if isOffical then
		local str = XiaonuoBirthConfig.instance:getCommonValue("H5_URL")

		UnityEngine.Application.OpenURL(str)
	else
		TipsFacade.instance:openTipWindow("提示", lang("浏览器搜索【奥奇传说H5】或登录百田网，即可登录奥奇传说页游，领取超多福利！"), function()
			ViewMgr.instance:close(ViewName.Popupwindow)
		end)
	end
end

return ArtifactbuypreView
