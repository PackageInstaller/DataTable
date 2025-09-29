-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/D6AttrItemPreviewView.lua

module("logic.extensions.backpack.view.D6AttrItemPreviewView", package.seeall)

local M = class("D6AttrItemPreviewView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()

	self._data = nil
end

function M:_buildUI()
	self._txtD6AttributeUnlock = goutil.findChildComponent(self._mainGo, "unlock/txtD6Attribute", typeof(TMPro.TMP_Text))
	self._txtD6AttributeUnknow = goutil.findChildComponent(self._mainGo, "unknown/txtD6Attribute", typeof(TMPro.TMP_Text))
	self._txtD6AttributeUnknow.text = StringUtil.randomReplaceTMPToBlackBlock("?????")
	self._txtD6AttributeLock = goutil.findChildTextComponent(self._mainGo, "lock/txtLock")
	self._txtD6AttrOrigin = goutil.findChildTextComponent(self._mainGo, "unalterable/txtD6Attribute")
	self._statusGo = {
		goutil.findChild(self._mainGo, "unalterable"),
		goutil.findChild(self._mainGo, "lock"),
		goutil.findChild(self._mainGo, "noCalibration"),
		goutil.findChild(self._mainGo, "unlock"),
		goutil.findChild(self._mainGo, "seal"),
		goutil.findChild(self._mainGo, "unknown")
	}

	local equipHoleItemGo = goutil.findChild(self._mainGo, "equip_hole_item")

	self._equipHoleItemView = Astral.LuaComponentContainer.Add(equipHoleItemGo, EquipHoleItemView)

	self._equipHoleItemView:setNoCalibrationIcon(false)

	self._currentGo = goutil.findChild(self._mainGo, "unlock/current")
	self._RomeNum = {}

	for i = 1, 6 do
		local item = goutil.findChild(self._mainGo, "dice/" .. i)

		self._RomeNum[i] = item
	end

	self._currentGo:SetActive(false)

	self._enhanceAniGo = {
		goutil.findChild(self._mainGo, "equip_hole_item/vfx04_loop02"),
		goutil.findChild(self._mainGo, "equip_hole_item/vfx04_loop01")
	}

	for _, go in ipairs(self._enhanceAniGo) do
		goutil.setActive(go, false)
	end
end

return M
