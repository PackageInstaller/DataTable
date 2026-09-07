local FormationCard = class("FormationCard")

function FormationCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tr = arg_1_1.transform
	self.content = self.tr:Find("content")
	self.bgImage = self.content:Find("bg"):GetComponent(typeof(Image))
	self.paintingTr = self.content:Find("ship_icon/painting")
	self.paintingDefaultAngle = self.paintingTr.localEulerAngles
	self.detailTF = self.content:Find("detail")
	self.lvTxt = self.detailTF:Find("top/level"):GetComponent(typeof(Text))
	self.shipType = self.detailTF:Find("top/type")
	self.propsTr = self.detailTF:Find("info")
	self.nameTxt = self.detailTF:Find("name_mask/name")
	self.frame = self.content:Find("front/frame")
	self.UIlist = UIItemList.New(self.content:Find("front/stars"), self.content:Find("front/stars/star_tpl"))
	self.shipState = self.content:Find("front/flag")
	self.proposeMark = self.content:Find("front/propose")
	self.otherBg = self.content:Find("front/bg_other")

	setActive(self.shipState, false)

	self.loader = AutoLoader.New()

	return
end

function FormationCard:update(arg_2_1)
	if arg_2_1 then
		setActive(self.content, true)

		self.shipVO = arg_2_1

		self:flush()
	else
		setActive(self.content, false)
	end

	return
end

function FormationCard:flush()
	self.lvTxt.text = "Lv." .. self.shipVO.level

	local var_3_0 = self.shipVO:getStar()

	self.UIlist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			setActive(arg_4_2:Find("star"), arg_4_1 < var_3_0)
		end

		return
	end)
	self.UIlist:align((self.shipVO:getMaxStar()))
	setScrollText(self.nameTxt, self.shipVO:GetColorName())
	self:updateProps({})
	setPaintingPrefabAsync(self.paintingTr, self.shipVO:getPainting(), "biandui", nil, {
		skinID = self.shipVO:getSkinId(),
		rotateZ = self.paintingDefaultAngle.z
	})

	local var_3_1 = self.shipVO:rarity2bgPrint()

	GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_3_1, "", self.bgImage)

	local var_3_2, var_3_3 = self.shipVO:GetFrameAndEffect(true)

	setRectShipCardFrame(self.frame, var_3_1, var_3_2)
	setFrameEffect(self.otherBg, var_3_3)
	setProposeMarkIcon(self.proposeMark, self.shipVO)
	setImageSprite(self.shipType, GetSpriteFromAtlas("shiptype", shipType2print((self.shipVO:getShipType()))))

	return
end

function FormationCard:updateProps(arg_5_1)
	for iter_5_0 = 0, 2 do
		local var_5_0 = self.propsTr:GetChild(iter_5_0)

		if iter_5_0 < #arg_5_1 then
			var_5_0.gameObject:SetActive(true)

			var_5_0:GetChild(0):GetComponent("Text").text = arg_5_1[iter_5_0 + 1][1]
			var_5_0:GetChild(1):GetComponent("Text").text = arg_5_1[iter_5_0 + 1][2]
		else
			var_5_0.gameObject:SetActive(false)
		end
	end

	return
end

function FormationCard:clear()
	if self.shipVO then
		retPaintingPrefab(self.paintingTr, self.shipVO:getPainting())
	end

	self.loader:Clear()

	return
end

return FormationCard
