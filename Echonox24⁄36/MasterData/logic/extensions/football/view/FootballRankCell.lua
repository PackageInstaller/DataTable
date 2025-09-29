-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/football/view/FootballRankCell.lua

module("logic.extensions.football.view.FootballRankCell", package.seeall)

local M = class("FootballRankCell", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._rankTxt = goutil.findChildTextComponent(self._go, "normalType/txtNum1")
	self._winTxt = goutil.findChildTextComponent(self._go, "normalType/txtNum2")
	self._loseTxt = goutil.findChildTextComponent(self._go, "normalType/txtNum3")
	self._drawTxt = goutil.findChildTextComponent(self._go, "normalType/txtNum4")
	self._scoreTxt = goutil.findChildTextComponent(self._go, "normalType/txtNum5")
	self._nameTxt = goutil.findChildTextComponent(self._go, "normalType/txtPlayerName")
	self._imgHeadIcon = goutil.findChildImageComponent(self._go, "normalType/cell/head_item/mask/headIcon")
end

function M:setData(rankNO)
	self._rankNO = rankNO

	self:_refreshCell()
end

function M:_refreshCell()
	self._rankTxt.text = self._rankNO.rank

	if self._rankNO.rank <= 0 then
		self._rankTxt.text = "未上榜"
	end

	self._winTxt.text = self._rankNO.win
	self._loseTxt.text = self._rankNO.fail
	self._drawTxt.text = self._rankNO.draw
	self._scoreTxt.text = self._rankNO.score
	self._nameTxt.text = self._rankNO.nickname

	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(self._rankNO.portrait)

	if portraitCO then
		IconLoader.setSprite(self._imgHeadIcon, IconType.Portrait, portraitCO.icon)
	end
end

function M:OnDestroy()
	return
end

return M
