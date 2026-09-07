local ShipDetailCard = class("ShipDetailCard")
local var_0_1 = 0.5

function ShipDetailCard:Ctor(arg_1_1, arg_1_2)
	self.go = arg_1_1
	self.tr = arg_1_1.transform
	self.tagFlags = arg_1_2 or {}
	self.toggle = GetOrAddComponent(self.tr, typeof(Toggle))
	self.content = findTF(self.tr, "content").gameObject
	self.quit = findTF(self.tr, "quit_button").gameObject
	self.detail = findTF(self.tr, "content/dockyard/detail").gameObject
	self.detailLayoutTr = findTF(self.detail, "layout")
	self.imageQuit = self.quit:GetComponent("Image")
	self.imageFrame = findTF(self.tr, "content/front/frame"):GetComponent("Image")
	self.labelName = findTF(self.tr, "content/info/name_mask/name")
	self.npc = findTF(self.tr, "content/dockyard/npc")

	setActive(self.npc, false)

	self.lock = findTF(self.tr, "content/dockyard/container/lock")
	self.maskStatusOb = findTF(self.tr, "content/front/status_mask")
	self.iconStatus = findTF(self.tr, "content/dockyard/status")
	self.iconStatusTxt = findTF(self.tr, "content/dockyard/status/Text"):GetComponent("Text")
	self.selectedGo = findTF(self.tr, "content/front/selected").gameObject
	self.energyTF = findTF(self.tr, "content/dockyard/container/energy")
	self.proposeTF = findTF(self.tr, "content/dockyard/propose")

	self.selectedGo:SetActive(false)

	self.hpBar = findTF(self.tr, "content/dockyard/blood")

	return
end

function ShipDetailCard:update(arg_2_1)
	if self.shipVO ~= arg_2_1 then
		self.shipVO = arg_2_1

		self:flush()
	end

	return
end

function ShipDetailCard:updateSelected(arg_3_1)
	self.selected = arg_3_1

	self.selectedGo:SetActive(self.selected)

	if self.selected then
		self.selectedTw = self.selectedTw or LeanTween.alpha(self.selectedGo.transform, 1, var_0_1):setFrom(0):setEase(LeanTweenType.easeInOutSine):setLoopPingPong()
	elseif self.selectedTw then
		LeanTween.cancel(self.selectedTw.uniqueId)

		self.selectedTw = nil
	end

	return
end

function ShipDetailCard:flush()
	local var_4_0 = tobool(self.shipVO)

	if var_4_0 then
		if not self.shipVO:getConfigTable() then
			return
		end

		flushShipCard(self.tr, self.shipVO)

		local var_4_1 = self.shipVO:isActivityNpc()

		setActive(self.npc, var_4_1)

		if self.lock then
			self.lock.gameObject:SetActive(self.shipVO:GetLockState() == Ship.LOCK_STATE_LOCK)
		end

		local var_4_2 = self.shipVO.energy <= Ship.ENERGY_MID

		if self.shipVO.energy <= Ship.ENERGY_MID then
			local var_4_3 = GetSpriteFromAtlas("energy", self.shipVO:getEnergyPrint())

			if not var_4_3 then
				warning("找不到疲劳")
			end

			setImageSprite(self.energyTF, var_4_3)
		end

		setActive(self.energyTF, var_4_2)
		setScrollText(self.labelName, self.shipVO:getName())

		local var_4_4 = ShipStatus.ShipStatusToTag(self.shipVO, self.tagFlags)

		if var_4_4 then
			self.iconStatusTxt.text = var_4_4[3]

			GetSpriteFromAtlasAsync(var_4_4[1], var_4_4[2], function(arg_5_0)
				setImageSprite(self.iconStatus, arg_5_0, true)
				setActive(self.iconStatus, true)

				if var_4_4[1] == "shipstatus" then
					self.iconStatus.sizeDelta = Vector2(195, 36)
					self.iconStatusTxt.fontSize = 30
				end

				return
			end)
		else
			setActive(self.iconStatus, false)
		end

		local var_4_5, var_4_6 = self.shipVO:getIntimacyIcon()

		setActive(self.proposeTF, tobool(var_4_6 and not var_4_1))
	end

	self.content:SetActive(var_4_0)

	return
end

function ShipDetailCard:clear()
	if self.selectedTw then
		LeanTween.cancel(self.selectedTw.uniqueId)

		self.selectedTw = nil
	end

	return
end

return ShipDetailCard
