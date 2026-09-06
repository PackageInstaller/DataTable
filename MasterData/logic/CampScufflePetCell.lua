-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampscuffle/CampScufflePetCell.lua

module("logic.extensions.funcamp.view.funcampscuffle.CampScufflePetCell", package.seeall)

local CampScufflePetCell = class("CampScufflePetCell")

function CampScufflePetCell:buildUI(go)
	self._go = go
	self._itemPet = goutil.findChild(go, "itemPet")
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._selectedGo = goutil.findChild(go, "selected")
	self._banGo = goutil.findChild(go, "ban")
	self._txtPower = goutil.findChildTextComponent(go, "txtPower")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btnClick")

	self._btnClick:AddClickListener(self._onClick, self)
end

function CampScufflePetCell:init(index, id)
	self._index = index
	self._id = id

	local bagPetMo = CampScuffleModel.instance:createPet(id)

	MaterialMgr.setCellByMo(bagPetMo, self._itemPet)

	self._txtName.text = bagPetMo:getName()
	self._txtPower.text = bagPetMo:getFightingPower()

	self._selectedGo:SetActive(false)
	self._banGo:SetActive(false)
	self:_removeEffect()
end

function CampScufflePetCell:onReset()
	MaterialMgr.resetAll(self._itemPet)
	self._btnClick:RemoveClickListener()
	self:_removeEffect()
	self:_removeTween()
end

function CampScufflePetCell:_onClick()
	if not CampScuffleModel.instance:isCanSelectBanPet() then
		printInfo("test 当前处于不可选状态")

		return
	end

	if CampScuffleModel.instance:isSelectBanPet(self._id) then
		CampScuffleModel.instance:removePetFromBanList(self._id)
		self._banGo:SetActive(false)
		GlobalDispatcher:dispatch(GlobalNotify.CampScuffleSelectPet)
	else
		if CampScuffleModel.instance:isMaxBanCount() then
			FloatWordMgr.instance:show("达到最大选择数量")

			return
		end

		local isSuccess = CampScuffleModel.instance:addPetToBanList(self._id)

		self._banGo:SetActive(isSuccess)
		GlobalDispatcher:dispatch(GlobalNotify.CampScuffleSelectPet)
	end
end

function CampScufflePetCell:isRandomSelectPet()
	local isMyRandom = CampScuffleModel.instance:isExistMyRandomPet(self._id)
	local isEnemyRandom = CampScuffleModel.instance:isExistEnemyRandomPet(self._id)

	return isMyRandom or isEnemyRandom
end

function CampScufflePetCell:setRandomSelect(internalTime, view, rangeRect)
	local isBan = CampScuffleModel.instance:isExistMyBanPet(self._id) or CampScuffleModel.instance:isExistEnemyBanPet(self._id)

	self._banGo:SetActive(isBan)

	local isMyRandom = CampScuffleModel.instance:isExistMyRandomPet(self._id)
	local isEnemyRandom = CampScuffleModel.instance:isExistEnemyRandomPet(self._id)
	local isSelect = isMyRandom or isEnemyRandom

	self._selectedGo:SetActive(isSelect)

	if internalTime and internalTime >= 0 then
		if isMyRandom then
			self:_loadEffect(true, internalTime, view, rangeRect)
		elseif isEnemyRandom then
			self:_loadEffect(false, internalTime, view, rangeRect)
		end
	end
end

function CampScufflePetCell:_loadEffect(isMy, internalTime, view, rangeRect)
	if isMy then
		if not CampScuffleBanViewPresentor.BluePath then
			local path = CampScuffleBanViewPresentor.RedPath

			self._tween = TweenUtil.DoDelay(internalTime, function()
				if not goutil.isNil(self._btnClick) and view then
					self._uiEffect = UIEffectManager.instance:playEffect(view, path, self._btnClick.gameObject.transform, 0, 0, true, false, nil, function(target, eff)
						if not goutil.isNil(rangeRect) then
							eff:setClipping(rangeRect)
						end
					end)

					self._uiEffect:setParent(self._btnClick.gameObject.transform)
					self._uiEffect:setScale(1)
				end
			end)
		end
	end
end

function CampScufflePetCell:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function CampScufflePetCell:_removeTween()
	if self._tween then
		self._tween:Kill()

		self._tween = nil
	end
end

return CampScufflePetCell
