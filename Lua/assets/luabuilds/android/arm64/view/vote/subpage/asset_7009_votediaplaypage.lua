local VoteDiaplayPage = class("VoteDiaplayPage", import("...base.BaseSubView"))

function VoteDiaplayPage:getUIName()
	return "VoteDisplay"
end

function VoteDiaplayPage:OnInit()
	self.paitingTF = findTF(self._tf, "painting")
	self.numberTxt = findTF(self._tf, "filter_bg/Text"):GetComponent(typeof(Text))
	self.nameTxt = findTF(self._tf, "frame/bg/name"):GetComponent(typeof(Text))
	self.enNameTxt = findTF(self._tf, "frame/bg/en_name"):GetComponent(typeof(Text))
	self.descTxt = findTF(self._tf, "frame/bg/scroll/desc"):GetComponent(typeof(Text))
	self.valueInput = findTF(self._tf, "frame/bg/InputField"):GetComponent(typeof(InputField))
	self.addBtn = findTF(self._tf, "frame/bg/add")
	self.miunsBtn = findTF(self._tf, "frame/bg/miuns")
	self.maxBtn = findTF(self._tf, "frame/bg/max")
	self.submitBtn = findTF(self._tf, "frame/bg/submit")
	self.rankTxt = findTF(self._tf, "frame/bg/rank"):GetComponent(typeof(Text))
	self.votesTxt = findTF(self._tf, "frame/bg/votes"):GetComponent(typeof(Text))
	self.shiptypeTxt = findTF(self._tf, "frame/bg/shiptype"):GetComponent(typeof(Text))
	self.nationImg = findTF(self._tf, "frame/bg/nation"):GetComponent(typeof(Image))
	self.bg1 = findTF(self._tf, "frame/bg/bg1")
	self.bg2 = findTF(self._tf, "frame/bg/bg2")

	return
end

function VoteDiaplayPage:Open(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.callback = arg_3_5

	assert(self.callback)

	self.maxValue = arg_3_3
	self.rank = arg_3_2
	self.value = 1

	setActive(self.bg1, not arg_3_4)
	setActive(self.bg2, arg_3_4)

	self.votes = arg_3_4 or "-"

	setActive(self._tf, true)

	self.numberTxt.text = "X" .. arg_3_3

	if arg_3_1 ~= self.voteShip then
		self.voteShip = arg_3_1

		self:Update(arg_3_1)
	end

	onInputEndEdit(self, go(self.valueInput), function()
		local var_4_0 = tonumber((getInputText(go(self.valueInput))))

		self.value = var_4_0 < 1 and 1 or var_4_0 > self.maxValue and math.max(1, self.maxValue) or var_4_0

		self:UpdateCnt()

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function VoteDiaplayPage:UpdateCnt()
	self.valueInput.text = self.value

	return
end

function VoteDiaplayPage:Update(arg_6_1)
	self.nameTxt.text = arg_6_1:getShipName()
	self.enNameTxt.text = arg_6_1:getEnName()
	self.descTxt.text = arg_6_1:GetDesc()
	self.votesTxt.text = self.votes
	self.rankTxt.text = self.rank
	self.shiptypeTxt.text = arg_6_1:getShipTypeName()

	local var_6_0 = arg_6_1:getNationality()

	self.nationImg.sprite = var_6_0 and LoadSprite("prints/" .. nation2print(var_6_0) .. "_0") or GetSpriteFromAtlas("ui/VoteUI_atlas", "nation")

	self:UpdateCnt()
	onButton(self, self._tf, function()
		self:Close()

		return
	end)
	onButton(self, self.addBtn, function()
		if self.value >= self.maxValue then
			return
		end

		self.value = self.value + 1

		self:UpdateCnt()

		return
	end, SFX_PANEL)
	onButton(self, self.miunsBtn, function()
		if self.value == 1 then
			return
		end

		self.value = self.value - 1

		self:UpdateCnt()

		return
	end, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		if self.maxValue == 0 then
			return
		end

		self.value = self.maxValue

		self:UpdateCnt()

		return
	end, SFX_PANEL)
	onButton(self, self.submitBtn, function()
		self.callback(self.value)
		self:Close()

		return
	end, SFX_PANEL)

	self.paintingName = arg_6_1:getPainting()

	LoadPaintingPrefabAsync(self.paitingTF, self.paintingName, self.paintingName, "jiesuan")

	return
end

function VoteDiaplayPage:Close()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parent)
	setActive(self._tf, false)
	retPaintingPrefab(self.paitingTF, self.paintingName)

	self.callback = nil
	self.maxValue = 0
	self.rank = 0
	self.value = 1
	self.voteShip = nil

	return
end

function VoteDiaplayPage:OnDestroy()
	self:Close()

	return
end

return VoteDiaplayPage
