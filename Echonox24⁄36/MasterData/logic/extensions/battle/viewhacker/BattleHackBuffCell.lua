-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewhacker/BattleHackBuffCell.lua

module("logic.extensions.battle.viewhacker.BattleHackBuffCell", package.seeall)

local M = class("BattleHackBuffCell", CellBaseComponent)
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
	self._nameTxt = goutil.findChildTextComponent(self._go, "txtBuffName")
	self._idInputField = Astral.InputFieldAdapter.Get(goutil.findChild(self._go, "InputField"))
	self._roundInputField = Astral.InputFieldAdapter.Get(goutil.findChild(self._go, "InputField2"))
	self._layerInputField = Astral.InputFieldAdapter.Get(goutil.findChild(self._go, "InputField3"))
	self._cannotLayerGo = goutil.findChild(self._go, "txtOverlay")
	self._clickBtn = ButtonAdapter.Get(goutil.findChild(self._go, "btn"))

	self._clickBtn:AddClickListener(self._onClickDeleteBtn, self)
	self._idInputField:AddOnEndEdit(self._onEndEditId, self)
	self._roundInputField:AddOnEndEdit(self._onEndEditRound, self)
	self._layerInputField:AddOnEndEdit(self._onEndEditLayer, self)
end

function M:setData(buffNO, index)
	self._buffNO = buffNO
	self._index = index

	self:_refreshCell()
end

function M:setClickCallBack(func, handle)
	self._clickFunc = func
	self._handle = handle
end

function M:_refreshCell()
	self._idInputField:SetText(self._buffNO.code)
	self._roundInputField:SetText(self._buffNO.round)
	self._layerInputField:SetText(self._buffNO.layer)

	local buffCO = BuffConfig.instance:getBuffCO(self._buffNO.code, true)

	if buffCO then
		self._nameTxt.text = buffCO.name
	else
		self._nameTxt.text = "错误ID"
	end
end

function M:_onClickDeleteBtn()
	if self._clickFunc then
		self._clickFunc(self._handle, self._index)
	end
end

function M:_onEndEditId()
	local code = checkint(self._idInputField:GetText())
	local buffCO = BuffConfig.instance:getBuffCO(code, true)

	if buffCO then
		self._buffNO.code = code
		self._nameTxt.text = buffCO.name

		local buffEffectCO = BuffConfig.instance:getBuffEffectCO(buffCO.buffType)

		if buffEffectCO.composition == 1 then
			self._buffNO.layer = 1

			goutil.setActive(self._cannotLayerGo, true)
			goutil.setActive(self._layerInputField.gameObject, false)
		else
			goutil.setActive(self._cannotLayerGo, false)
			goutil.setActive(self._layerInputField.gameObject, true)
		end
	else
		self._nameTxt.text = "错误ID"
	end
end

function M:_onEndEditRound()
	self._buffNO.round = checkint(self._roundInputField:GetText())
end

function M:_onEndEditLayer()
	self._buffNO.layer = checkint(self._layerInputField:GetText())
end

function M:OnDestroy()
	self._clickBtn:RemoveClickListener()
	self._idInputField:RemoveOnEndEdit()
	self._roundInputField:RemoveOnEndEdit()
	self._layerInputField:RemoveOnEndEdit()
end

return M
