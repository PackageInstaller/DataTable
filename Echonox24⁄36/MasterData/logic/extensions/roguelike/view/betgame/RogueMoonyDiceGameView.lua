-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/betgame/RogueMoonyDiceGameView.lua

module("logic.extensions.roguelike.view.betgame.RogueMoonyDiceGameView", package.seeall)

local M = class("RogueMoonyDiceGameView", ViewComponent)
local DiceRewardItem = class("DiceRewardItem")

function DiceRewardItem:ctor(container)
	local go = container.gameObject

	self._imgIcon = go:GetComponent(UIComponentType.Image)
	self._btnClick = UIComponentType.ButtonAdapter(self._imgIcon.gameObject)
	self._go = go

	self._btnClick:AddClickListener(self.onClick, self)
end

function DiceRewardItem:onClick()
	ViewMgr.instance:open(ViewName.RoguePropTips, self._id)
end

function DiceRewardItem:OnDestroy()
	self._btnClick:RemoveClickListener()
end

function DiceRewardItem:updateData(data)
	self._id = data.id
	self._index = data.index
	self._isTaken = data.isTaken

	local propCo = RoguelikeConfig.instance:getPropById(data.id)

	if propCo then
		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, propCo.art)
	end
end

local DiceRewardItem2 = class("DiceRewardItem2")

function DiceRewardItem2:ctor(go)
	self._imgIcon = goutil.findChild(go, "txtReward/icon"):GetComponent("SpriteRenderer")
	self._txtCount = goutil.findChild(go, "txtReward"):GetComponent("TextMesh")
	self._isGet = goutil.findChild(go, "done")
end

function DiceRewardItem2:updateData(data)
	self._id = data.id
	self._index = data.index
	self._isTaken = data.isTaken
	self._txtCount.text = data.price

	local propCo = RoguelikeConfig.instance:getPropById(data.id)

	if propCo then
		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, propCo.art)

		self._imgIcon.sprite = self._imgIcon.gameObject:GetComponent("Image").sprite
		self._txtCount.text = propCo.name

		settimer(0.5, self.delayAsyncIcon, self, false)
	end

	goutil.setActive(self._isGet, data.isTaken)
end

function DiceRewardItem2:delayAsyncIcon()
	self._imgIcon.sprite = self._imgIcon.gameObject:GetComponent("Image").sprite
end

local JiaZiItem = class("JiaZiItem")

function JiaZiItem:ctor(container)
	self._go = container.gameObject
	self._skeletonAnimation = self._go:GetComponent(UnitCompSpine.SkeletonAnimationType)

	self._skeletonAnimation:Initialize(false)
	self:play("idle", true)
end

function JiaZiItem:play(animState, isLoop, isForceRestart)
	isLoop = isLoop or false

	if not animState then
		return
	end

	if self._isLoop == isLoop and isLoop == true and self._curAnimState == animState then
		return
	end

	self._curAnimState = animState
	self._isLoop = isLoop

	if self._skeletonAnimation then
		if isForceRestart then
			self._skeletonAnimation:PlayAnimation(animState, self._isLoop, true)
		else
			self._skeletonAnimation.loop = self._isLoop
			self._skeletonAnimation.AnimationName = animState
		end
	end
end

function JiaZiItem:getCurAniState()
	return self._curAnimState
end

local kDefaultCameraPos = Vector3.New(0, 12, -20.5)

function M:buildUI()
	self._btnClose = self:getBtn("title_view_-878360263")
	self._btnPlay = self:getBtn("magnet_dice_game_view_-575714469")
	self._goDiceImg = self:getGo("magnet_dice_game_view_1660909789")
	self._goBoundEffect = self:getGo("magnet_dice_game_view_-1211299965")
	self._txtCost = self:getText("magnet_dice_game_view_-526222995")
	self._goDoneParent = self:getGo("magnet_dice_game_view_-1460623531")
	self._goRewardParent = self:getGo("magnet_dice_game_view_1018105853")
	self._txtCoin = self:getText("magnet_dice_game_view_1190878073")
	self._imgCoin2 = self:getImage("magnet_dice_game_view_-53221795")
	self._btnDrag = UIPassableDragTrigger.Get(self._goDiceImg)
	self._effect = PhotoEffect.Get(self._goDiceImg)

	self._effect:clear()

	self._resLoader = MultiResLoader.New()

	local path = GameUrl.getScenePrefabUrl("common_npc_props/npc_shaizi/prefab/moony_dice_item")

	self._resLoader:addResPath(path, true)
	self._resLoader:load(false, self._onOneLoaded, self)

	self._goCourse = self:getGo("magnet_dice_game_view_-298468449")
	self._txtPlay = goutil.findChildTextComponent(self._btnPlay.gameObject, "Text")
	self._rewardItems = {}
	self._rewardItems2 = {}
	self._goRewardItems = {}
	self._goRewardItems2 = {}
	self._goDoneItems = {}
	self._curCost = 0

	for i = 1, 4 do
		local rewardItem = goutil.findChild(self._goRewardParent, "icon_reward" .. i)

		self._goRewardItems[i] = rewardItem
		self._rewardItems[i] = Astral.LuaComponentContainer.Add(rewardItem, DiceRewardItem)
	end

	local rewardItem = self:getGo("magnet_dice_game_view_-730198719")
	local backpackItem = goutil.findChild(rewardItem, "backpack_item")
	local item = Astral.LuaComponentContainer.Add(backpackItem, RoguePropItem)

	self._btnBigReward = UIComponentType.ButtonAdapter(goutil.findChild(backpackItem, "click"))
	self._bigRewardItem = item

	for i = 1, 4 do
		self._goDoneItems[i] = goutil.findChild(self._goDoneParent, "done" .. i)
	end
end

function M:_onOneLoaded(res)
	if res.IsSuccess then
		self._diceAsset = res:GetAsset(nil, nil)

		self:generateDice()
	end
end

function M:generateDice()
	if not self._diceAsset or self._diceInst then
		return
	end

	self._diceInst = goutil.clone(self._diceAsset)
	self._diceInst.transform.localScale = Vector3.New(0.6, 0.6, 0.6)

	local rigidbody = self._diceInst:GetComponent("Rigidbody")

	rigidbody.isKinematic = true
	rigidbody.useGravity = false
	self._diceRigidbody = rigidbody

	goutil.setActive(self._diceInst, false)

	self._samePosCount = 0
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnPlay:AddClickListener(self._onClickPlay, self)
	self._btnBigReward:AddClickListener(self._onClickBigReward, self)
	self._btnDrag:AddBeginDragListener(self._onBeginDrag, self)
	self._btnDrag:AddDragListener(self._onDrag, self)
	self._btnDrag:AddEndDragListener(self._onEndDrag, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnPlay:RemoveClickListener()
	self._btnBigReward:RemoveClickListener()
	self._btnDrag:RemoveBeginDragListener()
	self._btnDrag:RemoveDragListener()
	self._btnDrag:RemoveEndDragListener()
	self._btnDrag:SetPassToGameObject(nil)
end

function M:onEnter()
	self:setEvent(true)
	self:updateGoldNum()
	self:loadMoonyDiceBg()
	self:generateDice()
end

function M:onExit()
	self:setEvent(false)
	goutil.setActive(self._goCourse, false)
	goutil.setActive(self._btnClose.gameObject, true)
	removetimer(self._onDragBg, self)
	removetimer(self.checkCameraFollowDice, self)
	removetimer(self.checkShowDice, self)
	removetimer(self.blinkAnimation, self)
	removetimer(self.delayHideBoundEffect, self)

	self._isFalling = false
	self._startDrag = false

	self:initDicePosition()

	self._cameraPos = false

	self._effect:clear()
	goutil.destroy(self._diceInst)
	self:setRewardActive(true)

	self._diceInst = nil
	self._samePosCount = 0
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_GOLD, self._onRefreshGold, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_ROOM_PRIZES, self._onShowRoomPrizes, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_GOLD, self._onRefreshGold, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_ROOM_PRIZES, self._onShowRoomPrizes, self)
	end
end

function M:showBoundEffect()
	removetimer(self.delayHideBoundEffect, self)
	goutil.setActive(self._goBoundEffect, false)
	settimer(0.02, self.delayHideBoundEffect, self, false)
end

function M:delayHideBoundEffect()
	goutil.setActive(self._goBoundEffect, true)
end

function M:showCollisionEffect(go)
	if go.name == "ignore" then
		return
	end

	local effect = goutil.clone(self._diceCollisionEff)

	effect.transform.position = go.transform.position

	goutil.setActive(effect, true)
	settimer(0.5, function()
		goutil.destroy(effect)
	end, self, false)
end

function M:_onClickClose()
	self:close()
end

function M:_onClickBigReward()
	if self._curPrizes then
		local isAllGet = true
		local isBigRewardGet = false

		for k, v in ipairs(self._curPrizes) do
			if k <= 4 then
				if not v.taken then
					isAllGet = false
				end
			elseif k == 5 then
				isBigRewardGet = v.taken
			end
		end

		if isAllGet and not isBigRewardGet then
			self:getRewardByIndex(5)
		else
			local id = self._curPrizes[5] and self._curPrizes[5].id or self._curPrizes[#self._curPrizes].id

			ViewMgr.instance:open(ViewName.RoguePropTips, id)
		end
	end
end

function M:_onClickPlay()
	if self._curPrizes then
		local isAllGet = true

		for k, v in ipairs(self._curPrizes) do
			if k <= 4 and not v.taken then
				isAllGet = false
			end
		end

		if isAllGet then
			FloatWordMgr.instance:show(lang("tip_r_cant_bet"))

			return
		end
	end

	if RoguelikeModel.instance:getGold() <= 0 or RoguelikeModel.instance:getGold() < self._curCost then
		FloatWordMgr.instance:show(lang("tip_r_not_enough_coin"))

		return
	end

	if self._isFalling or not self._isInitDice then
		return
	end

	self:initDicePosition()
	goutil.setActive(self._goCourse, true)

	self._startDrag = true
end

function M:showBlinkAnimation(index)
	if self._blinkIndex ~= nil then
		goutil.setActive(self._goDoneItems[self._blinkIndex], true)
		removetimer(self.blinkAnimation, self)
	end

	self._blinkIndex = index
	self._blinkCount = 10

	settimer(0.15, self.blinkAnimation, self, true)
end

function M:blinkAnimation()
	self._isBlinkShow = not self._isBlinkShow

	goutil.setActive(self._goDoneItems[self._blinkIndex], self._isBlinkShow)

	self._blinkCount = self._blinkCount - 1

	if self._blinkCount < 0 then
		removetimer(self.blinkAnimation, self)
		goutil.setActive(self._goDoneItems[self._blinkIndex], true)
	end
end

function M:setRewardActive(isActive)
	goutil.setActive(self._goRewardParent, isActive)
end

function M:initDicePosition()
	if not self._diceRigidbody then
		return
	end

	self._diceRigidbody.isKinematic = true
	self._diceRigidbody.useGravity = false

	self._diceInst.transform:SetParent(self._jiaziPoint.transform, false)

	self._diceInst.transform.localPosition = Vector3.zero
	self._diceInst.transform.eulerAngles = Vector3.zero
	self._jiaziInst.transform.position = self._originDicePos

	self._jiaziItem:play("idle", true)

	self._dragLeftTime = 0
	self._dragRightTime = 0

	self._effect:setCameraPosition(kDefaultCameraPos.x, kDefaultCameraPos.y, kDefaultCameraPos.z)

	self._cameraPos = Vector3.New(kDefaultCameraPos.x, kDefaultCameraPos.y, kDefaultCameraPos.z)
end

function M:loadMoonyDiceBg()
	local path = GameUrl.getScenePrefabUrl("common_npc_props/npc_shaizi/prefab/moony_dice")

	self._effect:setRtFormat(UnityEngine.RenderTextureFormat.RGB111110Float)
	self._effect:showEffects(path)
	self._effect:setCameraPostProcessing(true, SceneLayer.UI3D_Value)
	self._effect:setCameraRotation(0, 0, 0)
	self._effect:setCameraPosition(kDefaultCameraPos.x, kDefaultCameraPos.y, kDefaultCameraPos.z)
	self._effect:setEffectLoadedCallback(self._effectCallback, self)
end

function M:_effectCallback(inst, res)
	local screenAspect = ViewMgr.instance:getUIWidth() / ViewMgr.instance:getUIHeight()
	local scaleX = 1
	local scaleZ = 1

	if screenAspect > FullscreenPhotoEffect.ASPECT then
		scaleZ = ViewMgr.instance:getUIWidth() / FullscreenPhotoEffect.ASPECT / FullscreenPhotoEffect.WIDTH
	end

	self._bgInst = inst
	self._originBgPosY = self._bgInst.transform.position.y
	self._jiaziInst = goutil.findChild(inst, "jiazi")
	self._jiaziPoint = goutil.findChild(inst, "jiazi/jiazi_p/touzi")
	self._jiaziItem = Astral.LuaComponentContainer.Add(goutil.findChild(inst, "jiazi/jiazi_p"), JiaZiItem)

	self._effect:setCameraOrthographic(3.86)

	self._diceCollisionEff = goutil.findChild(inst, "props/vfx_magnet_collision")

	self:generateCollisionTrigger(inst)

	if self._diceInst then
		self:initDice()
	else
		settimer(0.1, self.checkShowDice, self, true)
	end

	local rewardParent = goutil.findChild(inst, "bottom")

	for i = 1, 4 do
		local rewardItem = goutil.findChild(rewardParent, "reward" .. i)

		self._goRewardItems2[i] = rewardItem
	end

	if RogueMgr.instance:getHackToolModel() then
		local msg = RoguelikeModel.instance:getCurHackToolRoomInfo()

		self:updateRoomByMsg(msg)
	else
		RoguelikeAgent.instance:sendLoadAllRoomPrizesRequest()
	end
end

function M:generateCollisionTrigger(inst)
	local child = goutil.findChild(inst, "props/s451_obj_cylinder_02b")

	if child then
		child = child.transform

		for i = 0, child.childCount - 1 do
			local it = child:GetChild(i):GetComponent("MeshCollider")

			if it then
				local trigger = Astral.CollisionLuaComponentContainer.Add(it.gameObject, RogueMoonyDiceTrigger)

				trigger:setEnterCallback(function(collision, go)
					self:showCollisionEffect(collision.gameObject)
				end)
			end
		end
	end

	function addWallCollision(wall)
		if not wall then
			return
		end

		local tra = wall.transform

		for i = 0, tra.childCount - 1 do
			local go = tra:GetChild(i).gameObject
			local trigger = Astral.CollisionLuaComponentContainer.Add(go, RogueMoonyDiceTrigger)

			trigger:setEnterCallback(function(collision)
				self:showBoundEffect()
			end)
		end
	end

	addWallCollision(goutil.findChild(inst, "collider/leftWall"))
	addWallCollision(goutil.findChild(inst, "collider/leftWall (1)"))
end

function M:checkShowDice()
	if self._diceInst then
		removetimer(self.checkShowDice, self)
		self:initDice()
	end
end

function M:initDice()
	self._diceInst.transform:SetParent(self._jiaziPoint.transform, false)
	goutil.setActive(self._diceInst, true)

	self._originDicePos = self._jiaziInst.transform.position
	self._isInitDice = true
end

function M:_onBeginDrag(eventData)
	if not self._startDrag then
		return true
	end

	goutil.setActive(self._goCourse, false)

	self._originPos = eventData.position
	self._lastDragPos = eventData.position

	settimer(0.1, self._onDragBg, self, true)

	return true
end

function M:_onDragBg()
	if self._isDragLeft ~= nil then
		if self._isDragLeft then
			self._dragRightTime = 0
			self._dragLeftTime = self._dragLeftTime + 0.1

			if self._dragLeftTime > 0 and self._dragLeftTime < 0.9 then
				self._jiaziItem:play("run_zuo_1")
			elseif self._dragLeftTime > 0.9 and self._dragLeftTime < 1.8 then
				self._jiaziItem:play("run_zuo_2")
			elseif self._dragLeftTime > 1.8 and self._dragLeftTime < 3.6 then
				self._jiaziItem:play("run_zuo_3")
			elseif self._dragLeftTime > 3.6 then
				-- block empty
			end
		else
			self._dragLeftTime = 0
			self._dragRightTime = self._dragRightTime + 0.1

			if self._dragRightTime > 0 and self._dragRightTime < 0.9 then
				self._jiaziItem:play("run_you_1")
			elseif self._dragRightTime > 0.9 and self._dragRightTime < 1.8 then
				self._jiaziItem:play("run_you_2")
			elseif self._dragRightTime > 1.8 and self._dragRightTime < 3.6 then
				self._jiaziItem:play("run_you_3")
			elseif self._dragRightTime > 3.6 then
				-- block empty
			end
		end
	end
end

function M:_onDrag(eventData)
	if not self._startDrag or not self._isInitDice then
		return true
	end

	local pos = eventData.position

	if self._lastDragPos.x < pos.x then
		self._isDragLeft = false
	else
		self._isDragLeft = true
	end

	local offset = pos - self._originPos

	if self._diceInst then
		local offsetX = offset.x / 80

		if offsetX > 5 then
			offsetX = 5
		elseif offsetX < -5 then
			offsetX = -5
		end

		local posX = self._originDicePos.x + offsetX

		self._jiaziInst.transform.position = Vector3.New(posX, self._originDicePos.y, self._originDicePos.z)
	end

	self._lastDragPos = pos

	return true
end

function M:_onEndDrag(eventData)
	if not self._startDrag or not self._isInitDice then
		return true
	end

	removetimer(self._onDragBg, self)

	self._dragRightTime = 0
	self._dragLeftTime = 0

	self._jiaziItem:play("fang")

	local endPosition = eventData.position

	self._diceInst.transform:SetParent(nil)

	self._diceRigidbody.isKinematic = false
	self._diceRigidbody.useGravity = true
	self._startDrag = false
	self._isFalling = true

	goutil.setActive(self._btnClose.gameObject, false)
	settimer(0.01, self.checkCameraFollowDice, self, true)

	return true
end

function M:checkCameraFollowDice()
	if not self._cameraPos then
		self._cameraPos = Vector3.New(kDefaultCameraPos.x, kDefaultCameraPos.y, kDefaultCameraPos.z)
	end

	if self._diceInst.transform.position.y - self._originBgPosY < self._cameraPos.y and self._cameraPos.y > -10.9 then
		self._cameraPos.y = self._diceInst.transform.position.y - self._originBgPosY

		self._effect:setCameraPosition(kDefaultCameraPos.x, self._cameraPos.y, kDefaultCameraPos.z)
	end

	self:checkDiceStop()
end

function M:checkDiceStop()
	local bottom = -14.5 + self._originBgPosY
	local pos = self._diceInst.transform.position

	if self._lastPos and math.abs(self._lastPos.y - pos.y) < 0.02 then
		self._samePosCount = self._samePosCount + 1
	else
		self._samePosCount = 0
	end

	if self._samePosCount > 10 then
		self._samePosCount = 0

		local rigidbody = self._diceRigidbody

		if rigidbody then
			local isLeft = self._originDicePos.x - pos.x > 0

			rigidbody:AddExplosionForce(40, pos - Vector3.New(isLeft and -0.5 or 0.5, 0.5, 0), 40, -4, UnityEngine.ForceMode.Impulse)
		end
	end

	if bottom >= pos.y then
		self:onDiceStop()
	end

	self._lastPos = pos
end

function M:onDiceStop()
	removetimer(self.checkCameraFollowDice, self)

	self._isFalling = false

	goutil.setActive(self._btnClose.gameObject, true)

	local pos = self._diceInst.transform.position
	local offsetX = pos.x - self._originDicePos.x
	local index = 1

	if offsetX > -5.1 and offsetX < -2.5 then
		index = 1
	elseif offsetX >= -2.5 and offsetX < 0 then
		index = 2
	elseif offsetX >= 0 and offsetX < 2.5 then
		index = 3
	elseif offsetX >= 2.5 and offsetX < 5.1 then
		index = 4
	end

	print("骰子掉落区间", index)
	self:getRewardByIndex(index)

	if self._curPrizes then
		local isAllGet = true

		for k, v in ipairs(self._curPrizes) do
			if k <= 4 and not v.taken then
				isAllGet = false
			end
		end
	end

	self:initDicePosition()
end

function M:getRewardByIndex(index)
	if self._curPrizes then
		local prize = self._curPrizes[index]

		if prize then
			if not prize.taken then
				RoguelikeAgent.instance:sendLuckyDiceRequest(prize.id)
			else
				RoguelikeAgent.instance:sendLuckyDiceRequest(prize.id)
			end
		else
			print("没有对应奖励", index)
		end
	end
end

function M:_onRefreshGold()
	self:updateGoldNum()
end

function M:updateGoldNum()
	self._txtCoin.text = RoguelikeModel.instance:getGold() or 0
end

function M:updateRoomByMsg(msg)
	local prizes = msg.prize or {}

	for k, v in pairs(self._goRewardItems) do
		goutil.setActive(v, false)
	end

	for k, v in pairs(self._goRewardItems2) do
		goutil.setActive(v, false)
	end

	for k, v in pairs(self._goDoneItems) do
		goutil.setActive(v, false)
	end

	if self._curPrizes then
		for k, v in ipairs(prizes) do
			if not self._curPrizes[k].taken and v.taken then
				self:showBlinkAnimation(k)

				local id = v.id
			end
		end
	end

	self._curPrizes = prizes

	local increment = msg.increment ~= nil and msg.increment or 0
	local initialPrice = RoguelikeConfig.instance:getConstByName("LuckyDiceInitialPrice").numValue
	local priceIncrement = RoguelikeConfig.instance:getConstByName("LuckyDicePriceIncrement").numValue
	local count = initialPrice + increment * priceIncrement

	count = count ~= 0 and count or 1

	local gambleAdd = RoguelikeModel.instance:getGambleAdd()
	local cost = count * gambleAdd

	cost = math.max(count * 0.1, cost)
	self._txtCost.text = cost
	self._curCost = cost

	for k, v in ipairs(prizes) do
		local data = {}

		data.id = v.id
		data.index = k
		data.isTaken = v.taken
		data.price = v.price

		if self._goDoneItems[k] and v.taken then
			goutil.setActive(self._goDoneItems[k], true)
		end

		if k == 5 then
			local data1 = {}

			data1.propId = v.id
			data1.showMask = v.taken

			self._bigRewardItem:updateData(data1)
		end

		if self._rewardItems[k] == nil then
			return
		end

		self._rewardItems[k]:updateData(data)
		goutil.setActive(self._goRewardItems[k], not v.taken)
	end
end

function M:_onShowRoomPrizes(sender, msg, ignoreCurRoom)
	if not RoguelikeModel.instance:getCurRoomMo() and not ignoreCurRoom then
		return
	end

	local curRoomPrize

	for k, v in pairs(msg.roomPrize) do
		if v.room == RoguelikeModel.instance:getCurRoomMo():getCoordinateStr() then
			curRoomPrize = v
		end
	end

	if curRoomPrize == nil then
		return
	end

	msg = curRoomPrize

	self:updateRoomByMsg(msg)
end

return M
