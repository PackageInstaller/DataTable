local FormationDetailCard = class("FormationDetailCard")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function FormationDetailCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tr = arg_1_1.transform
	self.lockTF = self.tr:Find("lock")
	self.addTF = self.tr:Find("add")
	self.content = self.tr:Find("content")
	self.bgImage = self.content:Find("bg"):GetComponent(typeof(Image))
	self.paintingTr = self.content:Find("ship_icon/painting")
	self.paintingDefaultAngle = self.paintingTr.localEulerAngles
	self.detailTF = self.content:Find("detail")
	self.lvTxtTF = self.detailTF:Find("top/level")
	self.lvTxt = self.lvTxtTF:GetComponent(typeof(Text))
	self.shipType = self.detailTF:Find("top/type")
	self.propsTr = self.detailTF:Find("info")
	self.propsTr1 = self.detailTF:Find("info1")
	self.nameTxt = self.detailTF:Find("name_mask/name")
	self.frame = self.content:Find("front/frame")
	self.UIlist = UIItemList.New(self.content:Find("front/stars"), self.content:Find("front/stars/star_tpl"))
	self.shipState = self.content:Find("front/flag")
	self.proposeMark = self.content:Find("front/propose")
	self.otherBg = self.content:Find("front/bg_other")

	setActive(self.propsTr1, false)
	setActive(self.shipState, false)
	setText(self.tr:Find("add/Text"), i18n("rect_ship_card_tpl_add"))

	return
end

function FormationDetailCard:update(arg_2_1, arg_2_2)
	self.shipVO = arg_2_1
	self.isLocked = arg_2_2

	self:flush()

	return
end

function FormationDetailCard:getState()
	if self.isLocked then
		return var_0_1
	elseif self.shipVO then
		return var_0_3
	elseif not self.isLocked and not self.shipVO then
		return var_0_2
	end

	return
end

function FormationDetailCard:flush()
	local var_4_0 = self:getState()

	if self.otherBg then
		eachChild(self.otherBg, function(arg_5_0)
			setActive(arg_5_0, false)

			return
		end)
	end

	if var_4_0 == var_0_1 then
		-- block empty
	elseif var_4_0 == var_0_3 then
		self.lvTxt.text = "Lv." .. self.shipVO.level

		local var_4_1 = self.shipVO:getStar()

		self.UIlist:make(function(arg_6_0, arg_6_1, arg_6_2)
			if arg_6_0 == UIItemList.EventUpdate then
				setActive(arg_6_2:Find("star"), arg_6_1 < var_4_1)
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

		local var_4_2 = self.shipVO:rarity2bgPrint()

		GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_4_2, "", self.bgImage)

		local var_4_3, var_4_4 = self.shipVO:GetFrameAndEffect(true)

		setRectShipCardFrame(self.frame, var_4_2, var_4_3)
		setFrameEffect(self.otherBg, var_4_4)
		setProposeMarkIcon(self.proposeMark, self.shipVO)
		setImageSprite(self.shipType, GetSpriteFromAtlas("shiptype", shipType2print((self.shipVO:getShipType()))))
	elseif var_4_0 == var_0_2 then
		-- block empty
	end

	setActive(self.lockTF, var_4_0 == var_0_1)
	setActive(self.addTF, var_4_0 == var_0_2)
	setActive(self.content, var_4_0 == var_0_3)

	return
end

function FormationDetailCard:updateProps(arg_7_1)
	for iter_7_0 = 0, 2 do
		local var_7_0 = self.propsTr:GetChild(iter_7_0)

		if iter_7_0 < #arg_7_1 then
			var_7_0.gameObject:SetActive(true)

			var_7_0:GetChild(0):GetComponent("Text").text = arg_7_1[iter_7_0 + 1][1]
			var_7_0:GetChild(1):GetComponent("Text").text = arg_7_1[iter_7_0 + 1][2]
		else
			var_7_0.gameObject:SetActive(false)
		end
	end

	return
end

function FormationDetailCard:clear()
	if self.shipVO then
		retPaintingPrefab(self.paintingTr, self.shipVO:getPainting())
	end

	return
end

return FormationDetailCard
