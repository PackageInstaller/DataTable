-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattlePetTipsView.lua

module("logic.extensions.battle.view.BattlePetTipsView", package.seeall)

local BattlePetTipsView = class("BattlePetTipsView", ViewComponent)

function BattlePetTipsView:buildUI()
	self._customInput = UICustomInput.Get(self.mainGO)

	self:_buildNoBuffNode()
	self:_buildBuffNode()
end

function BattlePetTipsView:_buildNoBuffNode()
	self._noBuffNode = self:getGo("noBuffs")
	self._noBuffName = self:getGo("noBuffs/Name"):GetComponent("Text")
	self._noBuffHpVal = self:getGo("noBuffs/HPValue"):GetComponent("Text")
	self._noBuffMpVal = self:getGo("noBuffs/MPValue"):GetComponent("Text")
	self._noBuffAdjPos = self._noBuffNode:GetComponent("UIAdjustPosition")

	local hp = self:getGo("noBuffs/HP"):GetComponent("Text")
	local mp = self:getGo("noBuffs/MP"):GetComponent("Text")

	hp.text = lang("text_hp")
	mp.text = lang("text_vigour")
	self._noBuffHeadBg = self:getGo("noBuffs/head/headBg"):GetComponent(typeof(UIImageSpriteChange))
	self._noBuffHeadIcon = self:getGo("noBuffs/head/headIcon")
	self._noBuffHeadFrame = self:getGo("noBuffs/head/headFrame"):GetComponent(typeof(UIImageSpriteChange))
	self._noBuffLevel = self:getGo("noBuffs/head/headLevel"):GetComponent(goutil.Type_UIText)
	self._noBuffTxtPower = self:getGo("noBuffs/power/txtPower"):GetComponent(typeof(ImgNumber))
	self._noBuffAttr = self:getGo("noBuffs/attr/Img_attr"):GetComponent(typeof(UIImageSpriteChange))
	self._noBuffJob = self:getGo("noBuffs/job/ImgC_Job"):GetComponent(typeof(UIImageSpriteChange))

	self._noBuffNode:SetActive(false)
end

function BattlePetTipsView:_buildBuffNode()
	self._buffNode = self:getGo("withBuffs")
	self._buffName = self:getGo("withBuffs/Name"):GetComponent("Text")
	self._buffHpVal = self:getGo("withBuffs/HPValue"):GetComponent("Text")
	self._buffMpVal = self:getGo("withBuffs/MPValue"):GetComponent("Text")
	self._buffAdjPos = self._buffNode:GetComponent("UIAdjustPosition")
	self._buffsView = self:getGo("withBuffs/ScrollRect"):GetComponent("ScrollRect")
	self._buffsViewContent = self:getGo("withBuffs/ScrollRect/Viewport/Content"):GetComponent("RectTransform")
	self._buffsLayout = goutil.findChild(self._buffsViewContent, "Buffs"):GetComponent("UILayoutSingleLine")

	local rectView = self:getGo("withBuffs/ScrollRect/Viewport"):GetComponent("RectTransform")

	self._viewSize = rectView.sizeDelta.y

	local hp = self:getGo("withBuffs/HP"):GetComponent("Text")
	local mp = self:getGo("withBuffs/MP"):GetComponent("Text")

	hp.text = lang("text_hp")
	mp.text = lang("text_vigour")

	self._buffNode:SetActive(false)

	self._buffHeadBg = self:getGo("withBuffs/head/headBg"):GetComponent(typeof(UIImageSpriteChange))
	self._buffHeadIcon = self:getGo("withBuffs/head/headIcon")
	self._buffHeadFrame = self:getGo("withBuffs/head/headFrame"):GetComponent(typeof(UIImageSpriteChange))
	self._buffLevel = self:getGo("withBuffs/head/headLevel"):GetComponent(goutil.Type_UIText)
	self._buffTxtPower = self:getGo("withBuffs/power/txtPower"):GetComponent(typeof(ImgNumber))
	self._buffAttr = self:getGo("withBuffs/attr/Img_attr"):GetComponent(typeof(UIImageSpriteChange))
	self._buffJob = self:getGo("withBuffs/job/ImgC_Job"):GetComponent(typeof(UIImageSpriteChange))
end

function BattlePetTipsView:onEnter()
	self._entity = self._viewPresentor:getFirstParam()
	self._touchPosition = UGUIToolHelper.GetTouchPosition()

	self._customInput:AddListener(self._onCustomInputCallback, self)
	self:_updateByEntity()
	GlobalDispatcher:addListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
end

function BattlePetTipsView:onExit()
	self:_clearImageCaches()
	GlobalDispatcher:removeListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)

	self._entity = nil
	self._buffs = nil
	self._touchPosition = nil
	self._adjustPos = nil

	self._customInput:RemoveListener()
end

function BattlePetTipsView:_clearImageCaches()
	local transform = self._buffsLayout.transform
	local childCount = transform.childCount - 1

	for i = 0, childCount do
		local go = transform:GetChild(i).gameObject
		local icon = goutil.findChild(go, "Icon")
		local bigImg = icon:GetComponent("ImageBigBG")

		if bigImg then
			bigImg:ClearImage()
		end
	end
end

function BattlePetTipsView:_updateByEntity()
	self._buffs = self._entity.buffList:getServerBuffs()

	if not self._buffs or #self._buffs == 0 then
		self:_updateNoBuffNodes()
	else
		self:_updateBuffNodes()
	end
end

function BattlePetTipsView:_updateNoBuffNodes()
	self._buffNode:SetActive(false)
	self._noBuffNode:SetActive(true)

	local petCO = CharacterConfig.instance:getPetCo(self._entity.raceId)

	self._noBuffName.text = petCO.name
	self._noBuffHpVal.text = string.format("%d/%d", self._entity.attrs:getCurTempHp(), self._entity.attrs:getMaxHp())
	self._noBuffMpVal.text = string.format("%d/%d", self._entity.attrs:getCurVigour(), self._entity.attrs:getMaxVigour())

	if not self._adjustPos then
		self._adjustPos = true

		self._noBuffAdjPos:AdjustScreenPosition(self._touchPosition)
	end

	local modelCfg = CharacterConfig.instance:getModelCo(checknumber(petCO.faceIds))
	local bagPetMo = BagPetsFacade.instance:getPetInfo(self._entity.id)
	local skinId = checknumber(petCO.faceIds)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx((bagPetMo or nil) and bagPetMo.curFaceId)

	race = race % 10

	local targetValue = race - 1

	self._noBuffLevel.text = self._entity.attrs:getLevel()

	self._noBuffHeadBg:ChangeStateNow(targetValue)
	self._noBuffHeadFrame:ChangeStateNow(targetValue)
	uGuiUtil.setSpriteToImage(self._noBuffHeadIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCfg.headName))
	self._noBuffTxtPower:SetNum(self._entity.attrs:getFightingPower())
	self._noBuffAttr:ChangeStateNow(targetValue)
	self._noBuffJob:ChangeStateNow(targetValue)
end

function BattlePetTipsView:_updateBuffNodes()
	self._buffNode:SetActive(true)
	self._noBuffNode:SetActive(false)

	local petCO = CharacterConfig.instance:getPetCo(self._entity.raceId)

	self._buffName.text = petCO.name
	self._buffHpVal.text = string.format("%d/%d", self._entity.attrs:getCurTempHp(), self._entity.attrs:getMaxHp())
	self._buffMpVal.text = string.format("%d/%d", self._entity.attrs:getCurVigour(), self._entity.attrs:getMaxVigour())

	self:_updateBuffs()

	if not self._adjustPos then
		self._adjustPos = true

		self._buffAdjPos:AdjustScreenPosition(self._touchPosition)
	end

	Framework.TransformUtil.SetLocalPos(self._buffsViewContent, 0, 0, 0)
	self:_updateViewSize()

	local modelCfg = CharacterConfig.instance:getModelCo(checknumber(petCO.faceIds))
	local bagPetMo = BagPetsFacade.instance:getPetInfo(self._entity.id)
	local skinId = checknumber(petCO.faceIds)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx((bagPetMo or nil) and bagPetMo.curFaceId)

	race = race % 10

	local targetValue = race - 1

	self._buffLevel.text = self._entity.attrs:getLevel()

	self._buffHeadBg:ChangeStateNow(targetValue)
	self._buffHeadFrame:ChangeStateNow(targetValue)
	uGuiUtil.setSpriteToImage(self._buffHeadIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCfg.headName))
	self._buffTxtPower:SetNum(self._entity.attrs:getFightingPower())
	self._buffAttr:ChangeStateNow(targetValue)
	self._buffJob:ChangeStateNow(targetValue)
end

function BattlePetTipsView:_updateViewSize()
	local viewSize = self._buffsLayout.Count * 76
	local sizeDelta = self._buffsViewContent.sizeDelta

	sizeDelta.x = viewSize
	self._buffsViewContent.sizeDelta = sizeDelta

	local enabledView = viewSize > self._viewSize

	UGUIToolHelper.EnabledScrollRect(self._buffsView, enabledView)
end

function BattlePetTipsView:_updateBuffs()
	local transform = self._buffsLayout.transform
	local childCount = transform.childCount
	local itemNum = 0

	if self._buffs then
		itemNum = #self._buffs
	end

	while childCount < itemNum do
		local go = transform:GetChild(0).gameObject
		local goClone = goutil.cloneAndSetParent(go, transform)

		Framework.TransformUtil.SetLocalScale(goClone.transform, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(goClone.transform, 0, 0, 0)

		childCount = childCount + 1
	end

	local num = 1

	for i = 1, itemNum do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		self:_updateBuff(go, self._buffs[i])

		num = num + 1
	end

	for i = num, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._buffsLayout:Layout()
end

function BattlePetTipsView:_updateBuff(go, buff)
	local buffName = goutil.findChildTextComponent(go, "BuffName")
	local rounds = goutil.findChildTextComponent(go, "Rounds")
	local desc = goutil.findChildTextComponent(go, "Desc")
	local icon = goutil.findChild(go, "Icon")
	local buffCo = buff.buffCo

	buffName.text = buffCo.name
	desc.text = buffCo.buffDesc
	rounds.text = ""
end

function BattlePetTipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function BattlePetTipsView:_onBattleHurtData(hurtData)
	if hurtData.target == self._entity or hurtData.attacker == self._entity then
		self:_updateByEntity()
	end
end

return BattlePetTipsView
