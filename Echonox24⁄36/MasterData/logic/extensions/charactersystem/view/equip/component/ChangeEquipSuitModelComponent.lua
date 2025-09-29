-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/ChangeEquipSuitModelComponent.lua

module("logic.extensions.charactersystem.view.equip.component.ChangeEquipSuitModelComponent", package.seeall)

local M = class("ChangeEquipSuitModelComponent", EquipSuitModelComponent)
local Y = {
	205,
	228,
	240
}

function M:build()
	self._aniNameOnLoad = "open"
	self._aniNameOnIdle = "open_idle1"
	self._lastEquipName = {}
	self._operatePos = false

	M.super.build(self)
	self:setEnableRotation()
end

function M:onDestroy()
	table.clear(self._lastEquipName)
end

function M:refreshView()
	if not self._heroData or not self._isLoaded then
		return
	end

	self._equipModel:setEmptyPos(false)

	local equipHeroData = self._heroData:getHeroEquipData()

	for index = 1, EquipEnum.MaxPartType do
		local equipMo = false

		if self._operatePos and self._operatePos == index then
			equipMo = EquipController.instance:getSelectedEquipMo()
		else
			equipMo = equipHeroData:getEquipByPart(EquipEnum.PartTypeList[index])
		end

		if self._loadedRefreshed then
			self:_refreshOneEquip(index, equipMo)
		else
			self:_loadOneEquip(index, equipMo)
		end
	end

	self._loadedRefreshed = true
end

function M:setCurOperatePos(pos)
	if not pos then
		printError("角色更换装备界面错误：当前操作部位为空")

		return
	end

	if self._operatePos and pos == self._operatePos then
		return
	end

	self._operatePos = pos

	self:refreshView()

	local x, y, z = self._equipModel:getTargetRotation()

	Astral.TransformUtil.DOLocalRotate(self._equipModel:getTransform(), x, Y[pos], z, 0.3)
end

function M:refreshOperatePos()
	if not self._operatePos then
		return
	end

	local equipMo = EquipController.instance:getSelectedEquipMo()

	self:_refreshOneEquip(self._operatePos, equipMo)
end

function M:_loadOneEquip(index, equipMo)
	self._equipModel:clearAttachEffect(index)

	if equipMo then
		self._equipModel:showEmptyGo(index, false)
		self._equipModel:clearAttachEffect(index)

		self._lastEquipName[index] = equipMo:getUuid()

		self._equipModel:attachEffect(index, GameUrl.getEquipMeshModelUrl(equipMo:getModelId()), self._aniNameOnLoad, false)
	else
		self._equipModel:showEmptyGo(index, true)
		self:_playEmptyAni(index, self._aniNameOnLoad, false)
	end
end

function M:_refreshOneEquip(index, equipMo)
	if not equipMo then
		self._equipModel:clearAttachEffect(index)

		self._lastEquipName[index] = false

		self._equipModel:showEmptyGo(index, true)
		self:_playEmptyAni(index, self._aniNameOnIdle, true)

		return
	end

	self._equipModel:showEmptyGo(index, false)

	local lastName = self._lastEquipName[index]
	local name = equipMo:getUuid()

	if lastName and lastName == name then
		local inst = self._equipModel:getEquipInst(index)

		self:setPosSelectStatus(index, inst)

		return
	end

	self._equipModel:hideEquip(index, true)
	settimer(0.1, function()
		self._equipModel:hideEquip(index, false)

		local aniPlayer = self._equipModel:getAniPlayer(index)

		if aniPlayer then
			aniPlayer:JumpToTime(0)
			aniPlayer:Evaluate()
		end
	end, self, false)
	self._equipModel:clearAttachEffect(index)

	self._lastEquipName[index] = name

	self._equipModel:attachEffect(index, GameUrl.getEquipMeshModelUrl(equipMo:getModelId()), self._aniNameOnIdle, true)
end

function M:_onModelLoaded()
	M.super._onModelLoaded(self)
	self._equipModel:setTargetRotationY(Y[1])
end

function M:_playEmptyAni(index, aniName, loop)
	local inst = self._equipModel:getEmptyInst(index)

	if not inst then
		return
	end

	if aniName then
		local aniPlayer = AnimationPlayer.Get(inst)

		if aniPlayer then
			aniPlayer:PlayAnimation(aniName, loop, true)

			if self._aniNameOnLoad and aniName == self._aniNameOnLoad then
				aniPlayer:SetListener(function(self)
					aniPlayer:RemoveListener()
					aniPlayer:PlayAnimation(self._aniNameOnIdle, true, true)
					aniPlayer:JumpToTime(0)
					aniPlayer:Evaluate()
				end, self)
			else
				aniPlayer:JumpToTime(0)
				aniPlayer:Evaluate()
			end
		end
	end
end

function M:_onAttachEffect(inst, aniName, loop, index)
	if not inst then
		return
	end

	if aniName then
		local aniPlayer = AnimationPlayer.Get(inst)

		if aniPlayer then
			aniPlayer:PlayAnimation(aniName, loop, true)

			if self._aniNameOnLoad and aniName == self._aniNameOnLoad then
				aniPlayer:SetListener(function(self)
					aniPlayer:RemoveListener()
					aniPlayer:PlayAnimation(self._aniNameOnIdle, true, true)
					aniPlayer:JumpToTime(0)
					aniPlayer:Evaluate()
				end, self)
			else
				aniPlayer:JumpToTime(0)
				aniPlayer:Evaluate()
			end
		end
	end

	self:setPosSelectStatus(index, inst)
end

function M:setPosSelectStatus(index, inst)
	if not self._operatePos then
		return
	end

	if not inst or goutil.isNil(inst) then
		return
	end

	HackOptimiseUtils.AddXiaoshiqiSkinnedMeshRendererSelectOutLine(inst, index == self._operatePos)
end

function M:onExit()
	M.super.onExit(self)
	self._equipModel:hideEquip(1, true)
	self._equipModel:hideEquip(2, true)
	self._equipModel:hideEquip(3, true)
end

function M:onEnter()
	M.super.onEnter(self)
	self._equipModel:hideEquip(1, false)
	self._equipModel:hideEquip(2, false)
	self._equipModel:hideEquip(3, false)
end

function M:setEnableRotation()
	self._equipModel:enableTouch(Handler.New(self._clickEquipModel, self), Handler.New(self._beginDragEquipModel, self), Handler.New(self._onDragEquipModel, self), Handler.New(self._endDragEquipModel, self))
end

function M:_clickEquipModel()
	return
end

function M:_beginDragEquipModel(posX, posY, pointerId)
	self._beginX = posX
	self._lastFrame = Time.frameCount
end

function M:_onDragEquipModel(posX, posY, pointerId)
	return
end

function M:_endDragEquipModel(posX, posY, pointerId)
	local deltaX = posX - self._beginX
	local currFrame = Time.frameCount

	self:_changeEquipPos(deltaX)

	self._beginX = posX
	self._lastFrame = currFrame
end

function M:_changeEquipPos(deltaX)
	if not deltaX then
		printError("校时器旋转失败，没有正确的拖拽值")

		return
	end

	if deltaX > 10 then
		GlobalDispatcher:dispatchEvent(EventType.EQUIP_MODEL_DRAG_PART, true)
	end

	if deltaX < -10 then
		GlobalDispatcher:dispatchEvent(EventType.EQUIP_MODEL_DRAG_PART, false)
	end
end

return M
