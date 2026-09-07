local DockyardFriend = class("DockyardFriend")

DockyardFriend.DetailType0 = 0
DockyardFriend.DetailType1 = 1
DockyardFriend.DetailType2 = 2

local var_0_1 = 0.5

function DockyardFriend:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tf = arg_1_1.transform
	self.nameTF = self.tf:Find("content/request_info/name"):GetComponent(typeof(Text))
	self.levelTF = self.tf:Find("content/request_info/lv_bg/lv/Text"):GetComponent(typeof(Text))
	self.iconTF = self.tf:Find("content/icon_contaon/icon"):GetComponent(typeof(Image))
	self.starsTF = self.tf:Find("content/icon_contaon/stars")
	self.starTF = self.tf:Find("content/icon_contaon/stars/star")
	self.date = self.tf:Find("content/date"):GetComponent(typeof(Text))
	self.manifestoTF = self.tf:Find("content/request_content/bg/Text"):GetComponent(typeof(Text))
	self.powerTF = self.tf:Find("content/item/value")
	self.propose = self.tf:Find("content/icon_contaon/propose")
	self.content = self.tf:Find("content")
	self.detail = self.tf:Find("detail")
	self.detailLayoutTr = findTF(self.detail, "layout")
	self.quit = self.tf:Find("quit_button")
	self.selectedGo = findTF(self.tf, "selected").gameObject

	self.selectedGo:SetActive(false)

	return
end

function DockyardFriend:update(arg_2_1, arg_2_2)
	if self.shipVO ~= arg_2_1 then
		self.shipVO = arg_2_1

		local var_2_0 = tobool(arg_2_1)

		if var_2_0 then
			self.friendVO = arg_2_2[arg_2_1.playerId]

			self:flush()
			self:flushDetail()
		end

		setActive(self.content, var_2_0)
		setActive(self.quit, not var_2_0)
	end

	return
end

function DockyardFriend:updateSelected(arg_3_1)
	self.selected = arg_3_1

	self.selectedGo:SetActive(self.selected)

	if self.selected then
		self.selectedTwId = self.selectedTwId or LeanTween.alpha(self.selectedGo.transform, 1, var_0_1):setFrom(0):setEase(LeanTweenType.easeInOutSine):setLoopPingPong().uniqueId
	elseif self.selectedTwId then
		LeanTween.cancel(self.selectedTwId)

		self.selectedTwId = nil
	end

	return
end

function DockyardFriend:flush()
	if self.shipVO then
		local var_4_0 = pg.ship_data_statistics[self.shipVO.configId]

		LoadSpriteAsync("qicon/" .. self.shipVO:getPainting(), function(arg_5_0)
			self.iconTF.sprite = arg_5_0

			return
		end)
		setActive(self.propose, self.shipVO:ShowPropose())

		for iter_4_0 = self.starsTF.childCount, var_4_0.star - 1 do
			cloneTplTo(self.starTF, self.starsTF)
		end

		for iter_4_1 = 1, self.starsTF.childCount do
			setActive(self.starsTF:GetChild(iter_4_1 - 1), iter_4_1 <= var_4_0.star)
		end
	end

	if self.friendVO then
		self.nameTF.text = self.friendVO.name
		self.levelTF.text = self.friendVO.level
		self.manifestoTF.text = self.friendVO.manifesto or ""
		self.date.text = self.friendVO.online == Friend.ONLINE and i18n("word_online") or getOfflineTimeStamp(self.friendVO.preOnLineTime)
	end

	return
end

function DockyardFriend:updateDetail(arg_6_1)
	self.detailType = arg_6_1

	self:flushDetail()

	return
end

function DockyardFriend:flushDetail()
	local var_7_0 = tobool(self.shipVO)

	if var_7_0 and self.detailType > DockyardFriend.DetailType0 then
		local var_7_1 = self.shipVO:getShipProperties()
		local var_7_2 = {
			"name",
			AttributeType.Durability,
			AttributeType.Cannon,
			AttributeType.Torpedo,
			AttributeType.Air,
			AttributeType.AntiAircraft,
			AttributeType.ArmorType,
			AttributeType.Reload,
			AttributeType.Dodge
		}
		local var_7_3 = self.shipVO:getShipCombatPower()

		for iter_7_0 = 1, 6 do
			local var_7_4 = self.detailLayoutTr:GetChild(iter_7_0 - 1)
			local var_7_5 = var_7_4:GetChild(0):GetComponent("Text")
			local var_7_6 = var_7_4:GetChild(1):GetComponent("Text")

			if self.detailType == DockyardFriend.DetailType1 then
				if iter_7_0 == 1 then
					var_7_5.alignment = TextAnchor.MiddleCenter
					var_7_5.text = self.shipVO:getName()
					var_7_6.text = ""
				else
					local var_7_7 = var_7_2[iter_7_0]

					var_7_5.text = AttributeType.Type2Name(var_7_2[iter_7_0])
					var_7_6.text = tostring(math.floor(var_7_1[var_7_7]))
				end
			elseif self.detailType == DockyardFriend.DetailType2 then
				if iter_7_0 == 6 then
					var_7_5.text = "<color=#A9F548FF>" .. i18n("word_synthesize_power") .. "</color>"
					var_7_6.text = tostring(var_7_3)
				elseif iter_7_0 == 5 then
					var_7_5.text = "<color=#A9F548FF>" .. i18n("word_level") .. "</color>"
					var_7_6.text = "Lv." .. self.shipVO.level
				elseif iter_7_0 == 1 then
					var_7_5.alignment = TextAnchor.MiddleCenter
					var_7_5.text = self.shipVO:getShipArmorName()
					var_7_6.text = ""
				elseif iter_7_0 == 4 then
					var_7_5.text = AttributeType.Type2Name(AttributeType.Expend)
					var_7_6.text = tostring(math.floor((self.shipVO:getBattleTotalExpend())))
				else
					local var_7_8 = var_7_2[iter_7_0 + 6]

					var_7_5.text = AttributeType.Type2Name(var_7_2[iter_7_0 + 6])
					var_7_6.text = tostring(math.floor(var_7_1[var_7_8]))
				end
			end
		end
	end

	setActive(self.detail, var_7_0 and self.detailType > DockyardFriend.DetailType0)

	return
end

function DockyardFriend:clear()
	if self.selectedTwId then
		LeanTween.cancel(self.selectedTwId)

		self.selectedTwId = nil
	end

	return
end

return DockyardFriend
