-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipTimingAnimationView.lua

module("logic.extensions.charactersystem.view.equip.EquipTimingAnimationView", package.seeall)

local M = class("EquipTimingAnimationView", ViewComponent)

function M:buildUI()
	local imgMask1Go = goutil.findChild(self.mainGO, "imgMask1")

	goutil.addComponentOnce(imgMask1Go, goutil.Type_UIButton)

	self._btnImgMask = UIComponentType.ButtonAdapter(imgMask1Go)
	self._goDiceModel = self:getGo("timing_or_reset_show_view_-804771387")
	self._diceModel = Astral.LuaComponentContainer.Add(self._goDiceModel, PhotoModel)

	self._diceModel:setModelLoadCallback(self._onModelLoaded, self)

	self._resultGo = goutil.findChild(self.mainGO, "content")
	self._resultAni = self._resultGo:GetComponent(ComponentType.Animation)
	self._itemView = Astral.LuaComponentContainer.Add(goutil.findChild(self._resultGo, "d6_attribute_item_copy"), D6AttrComponentItem)

	goutil.setActive(self._resultGo, false)

	self._isResulted = false
	self._mockMod = 5
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnImgMask:AddClickListener(self._onClickImgMask, self)
end

function M:unbindEvents()
	self._btnImgMask:RemoveClickListener()
end

function M:onEnter()
	self._d6Mo = self:getFirstParam()

	local quality = self._d6Mo:getQuality()

	self._diceModel:updateRes(GameUrl.getEquipTimingDiceAnimPrefab(EquipEnum.d6Quality2DiceModel[quality]), nil, UnityEngine.RenderTextureFormat.ARGBHalf, 2)
	self._diceModel:setCameraPosition(0, 15, -7.6)
	self._diceModel:setRotation(65, 0, 0)
	self._diceModel:setCameraTag("RTCamera")
	EquipIntensifyModel.instance:setNeedPlayTimingAni(true)

	self._isResulted = false

	goutil.setActive(self._resultGo, false)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqijiediantiaojiao2, nil, nil, nil)
end

function M:onExit()
	removetimer(self.mockMove, self)
end

function M:_onClickImgMask()
	if not self._isResulted then
		return
	end

	local pos = EquipIntensifyModel.instance:getTuoweiPos()

	if pos then
		ViewMgr.instance:openSpecialView(ViewName.EquipTimingTuowei, {
			pos = pos,
			event = EventType.EQUIP_TIMGING_TUOWEI
		})
	end

	self:close()
end

function M:_onModelLoaded(inst, res)
	if not inst then
		return
	end

	Astral.GameObjectUtil.SetLayerRecursively(inst, SceneLayer.UI3D_Value)
	self._diceModel:setCameraCullingLayer(SceneLayer.UI3D_Value)

	self._diceTransform = self._diceModel:getTransform()
	self._xOffset = self._diceTransform.parent.parent.localPosition.x

	Astral.TransformUtil.SetLocalScale(self._diceTransform, 3, 3, 3)
	LightMgr.instance:turnOn(LightName.UIEquip)

	local effectFace = self._d6Mo:getEffectFace()

	self:_playDiceAni(effectFace)
end

function M:onAniEnd()
	goutil.setActive(self._resultGo, true)
	self._itemView:setSourceData(self._d6Mo:getEffectAttr(), true)
	self._itemView:setCurrentGoVisible(false)
	self._itemView:setTimingIndex(self._d6Mo:getEffectFace())
	self._resultAni:Stop()
	self._resultAni:Play("timing_jieguo")
	ToolTipsMgr.showCharacterTopToast(lang("tip_equip_timing_suc"), CommEnum.CharacterTopToastIcon.Succ, 1)
end

function M:_playDiceAni(face)
	local configData = EquipmentConfig.instance:getConfig(ConfigName.DiceClipInfo)
	local pos = configData.pos[face]
	local qua = configData.qua[face]
	local index = math.random(1, #pos)
	local indexCfg = EquipmentConfig.instance:getConfig(ConfigName.DiceClipInfoIndex)
	local indexAll = indexCfg[face]

	if indexAll then
		local allLen = #indexAll

		if allLen and allLen > 0 then
			index = indexAll[math.random(allLen)]
		end
	end

	self._aniPos = pos[index]
	self._aniQua = qua[index]
	self._mockIndex = 1
	self._mockLerp = 0

	local carPos = self._aniPos[self._mockIndex]

	Astral.TransformUtil.SetPos(self._diceTransform, carPos.x + self._xOffset, carPos.y, carPos.z)

	local frame = PlayerLocalStorageModel.instance:getGameFrame()
	local frameNum = SettingConst.KFrameNumberValue[frame]
	local time = frameNum and frameNum == 30 and 0.013 or 0.02

	settimer(time, self.mockMove, self, true)
end

function M:mockMove()
	local carPos = self._aniPos[self._mockIndex]
	local nextPos = self._aniPos[self._mockIndex + 1]
	local carQua = self._aniQua[self._mockIndex]
	local nextQua = self._aniQua[self._mockIndex + 1]
	local lerp = self._mockLerp / self._mockMod
	local pos = LerpPos(carPos, nextPos, lerp)
	local qua = LerpQua(carQua, nextQua, lerp)

	Astral.TransformUtil.SetPos(self._diceTransform, pos.x + self._xOffset, pos.y, pos.z)
	Astral.TransformUtil.SetRotation(self._diceTransform, qua.x, qua.y, qua.z, qua.w)

	self._mockLerp = self._mockLerp + 1

	if self._mockLerp == self._mockMod then
		self._mockLerp = 0
		self._mockIndex = self._mockIndex + 1
	end

	if self._mockIndex >= #self._aniPos then
		removetimer(self.mockMove, self)

		self._isResulted = true

		self:onAniEnd()
	end
end

function LerpPos(pos1, pos2, lerp)
	local v1 = Vector3.New(pos1.x, pos1.y, pos1.z)
	local v2 = Vector3.New(pos2.x, pos2.y, pos2.z)

	return Vector3.Lerp(v1, v2, lerp)
end

function LerpQua(pos1, pos2, lerp)
	local q1 = Quaternion.New(pos1.x, pos1.y, pos1.z, pos1.w)
	local q2 = Quaternion.New(pos2.x, pos2.y, pos2.z, pos2.w)

	return Quaternion.Lerp(q1, q2, lerp)
end

return M
