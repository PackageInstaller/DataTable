-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccaccioclg/view/BoccaccioclgextView.lua

module("logic.extensions.boccaccioclg.view.BoccaccioclgextView", package.seeall)

local BoccaccioclgextView = class("BoccaccioclgextView", ViewComponent)

function BoccaccioclgextView:ctor()
	BoccaccioclgextView.super.ctor(self)
end

function BoccaccioclgextView:unbindEvents()
	BoccaccioclgextView.super.unbindEvents(self)
end

function BoccaccioclgextView:bindEvents()
	BoccaccioclgextView.super.bindEvents(self)
end

function BoccaccioclgextView:buildUI()
	BoccaccioclgextView.super.buildUI(self)

	self._txtDesc = self:getTxt("tips/txt")
	self._nodeGos = {}

	for i = 1, 9 do
		local go = self:getGo(string.format("img%d", i))

		table.insert(self._nodeGos, go)
	end
end

function BoccaccioclgextView:onExit()
	BoccaccioclgextView.super.onExit(self)
end

function BoccaccioclgextView:onEnter()
	BoccaccioclgextView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo._activityId
	self._stageId = self._fmtMo._stageId
	self._stageCfg = BoccaccioclgConfig.instance:getStageCfg(self._activityId, self._stageId)

	self:_updateUI()
end

function BoccaccioclgextView:_updateUI()
	self._txtDesc.text = self._stageCfg.topDesc

	local creepsCfgs = BoccaccioclgConfig.instance:getCreepsCfgs(self._stageCfg.creepsMasterId)
	local posToCreepsId = {}

	for i, v in ipairs(creepsCfgs) do
		posToCreepsId[v.posId] = v.creepsId
	end

	for i, v in ipairs(self._nodeGos) do
		local creepsId = posToCreepsId[i]
		local isHit = false

		if creepsId then
			local creepsCfg = BoccaccioclgConfig.instance:getCreepsCfg(self._stageCfg.creepsMasterId, creepsId)
			local imgState = goutil.findChild(v, "imgState")
			local txtDesc = goutil.findChildTextComponent(v, "txtDesc")
			local txtDescChangeComp = txtDesc.gameObject:GetComponent(ComponentType.UITextColorChange)
			local spriteChangeComp = imgState:GetComponent(ComponentType.UIImageSpriteChange)
			local outlineStateComp = txtDesc:GetComponent(ComponentType.OutlineEx)
			local outlineColor = GameUtil.getColorByHexColor("FFFFFF")

			if creepsCfg.buffType > 0 then
				isHit = true

				local buff = BoccaccioclgConfig.instance:getSignBuffCfg(self._activityId, creepsCfg.buffType)

				if creepsCfg.buffType == BoccaccioclgController.BuffType.Blood then
					txtDesc.text = "血"
					outlineColor = GameUtil.getColorByHexColor("300000")
				elseif creepsCfg.buffType == BoccaccioclgController.BuffType.Attack then
					txtDesc.text = "攻"
					outlineColor = GameUtil.getColorByHexColor("002e5d")
				else
					txtDesc.text = "防"
					outlineColor = GameUtil.getColorByHexColor("4d3100")
				end

				outlineStateComp.OutlineWidth = 1

				outlineStateComp:SetColorRGBA(outlineColor.r, outlineColor.g, outlineColor.b, outlineColor.a)
				txtDescChangeComp:SetState(creepsCfg.buffType - 1)
				spriteChangeComp:SetState(creepsCfg.buffType - 1)
			end
		else
			goutil.setActive(v, false)
		end

		goutil.setActive(v, isHit)
	end
end

return BoccaccioclgextView
