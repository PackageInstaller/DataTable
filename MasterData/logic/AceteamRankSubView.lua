-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/AceteamRankSubView.lua

module("logic.extensions.aceteam.view.AceteamAceteamRankSubView", package.seeall)

local AceteamRankSubView = class("AceteamRankSubView", TableViewComponent)

function AceteamRankSubView:buildUI(parentGo)
	self.mainGO = parentGo

	AceteamRankSubView.super.buildUI(self)

	self._scroll = self:getScrollRect("tableview")
end

function AceteamRankSubView:bindEvents()
	AceteamRankSubView.super.bindEvents(self)
end

function AceteamRankSubView:unbindEvents()
	AceteamRankSubView.super.unbindEvents(self)
end

function AceteamRankSubView:onEnter()
	AceteamRankSubView.super.onEnter(self)

	self._curSeasonId = AceTeamModel.instance:getCurrSeasonId()
	self._isFirst = true
end

function AceteamRankSubView:onExit()
	AceteamRankSubView.super.onExit(self)
end

function AceteamRankSubView:show()
	self.mainGO:SetActive(true)
	self:_resetTopPos()

	if self._isFirst then
		self._isFirst = false

		self:_updateRankList()
	end
end

function AceteamRankSubView:hide()
	self.mainGO:SetActive(false)
end

function AceteamRankSubView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "tableview"
	}
end

function AceteamRankSubView:_updateCell(view, cell, data)
	local goContent = goutil.findChild(cell, "content")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgRank = goutil.findChild(cell, "imgRank")

	if #data.ranks == 1 and data.ranks[1] == 1 then
		goutil.setActive(imgRank, true)
		goutil.setActive(txtRank.gameObject, false)
	else
		goutil.setActive(imgRank, false)
		goutil.setActive(txtRank.gameObject, true)

		if data.ranks == 1 then
			txtRank.text = data.ranks[1] or string.format("%d - %d 名", data.ranks[1], data.ranks[2])
		end
	end

	local arrProxy = MaterialMgr.setCellListByCfg(data.cfg.prize, goContent)

	for i, v in ipairs(arrProxy) do
		Framework.TransformUtil.SetLocalScale(v.view.transform, 0.7, 0.7, 0.7)
	end
end

function AceteamRankSubView:_clearTableview(cell)
	local goContent = goutil.findChild(cell, "content")

	MaterialMgr.resetAll(goContent)
end

function AceteamRankSubView:_resetTopPos()
	self._scroll.scrollRect.verticalNormalizedPosition = 1
end

function AceteamRankSubView:_updateRankList()
	local temps = AceTeamConfig.instance:getRankPrizeCfgs(self._curSeasonId)
	local cfgs = {}

	for k, v in pairs(temps) do
		table.insert(cfgs, v)
	end

	table.sort(cfgs, function(a, b)
		return a.rightTop < b.rightTop
	end)

	local list = {}
	local preCfg

	for i, v in pairs(cfgs) do
		local element = {}

		element.cfg = v

		if i == 1 then
			element.ranks = {
				v.rightTop
			}
		else
			local startNum = cfgs[i - 1].rightTop + 1

			element.ranks = v.rightTop - startNum == 0 and {
				v.rightTop
			} or {
				startNum,
				v.rightTop
			}
		end

		table.insert(list, element)
	end

	self:updateListData(list)
end

return AceteamRankSubView
