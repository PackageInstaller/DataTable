local TipsShortItemView = class("TipsShortItemView")

function TipsShortItemView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.data_ = arg_1_1
	self.gameObject_ = Object.Instantiate(arg_1_2, arg_1_3.transform)
	self.transform_ = self.gameObject_.transform

	self:InitUI()

	self.isFree_ = false
end

function TipsShortItemView:InitUI()
	self.text_ = self.transform_:Find("Text"):GetComponent("Text")
	self.levelImg_ = self.transform_:Find("levelImg"):GetComponent("Image")
	self.levelImgGo_ = self.transform_:Find("levelImg").gameObject
	self.levelText_ = self.transform_:Find("levelText"):GetComponent("Text")
	self.levelTextGo_ = self.transform_:Find("levelText").gameObject
	self.icon_ = self.transform_:Find("icon"):GetComponent("Image")
	self.iconGo_ = self.transform_:Find("icon").gameObject
end

function TipsShortItemView:IsFree()
	return self.isFree_
end

function TipsShortItemView:SetFree(arg_4_1)
	self.isFree_ = arg_4_1
end

function TipsShortItemView:RefreshUI(arg_5_1, arg_5_2, arg_5_3)
	self:SetFree(false)

	self.text_.text = arg_5_1

	self:RefreshTips(arg_5_2, arg_5_3)
	SetActive(self.gameObject_, true)
	self.transform_:SetAsLastSibling()

	self.transform_.localScale = Vector3(0, 0.1, 1)

	LeanTween.scale(self.gameObject_, Vector3(1.5, 0.1, 1), 0.1)
	LeanTween.scale(self.gameObject_, Vector3.one, 0.1):setDelay(0.1)
	self:EndDisplay()
end

function TipsShortItemView:EndDisplay()
	LeanTween.scale(self.gameObject_, Vector3(1, 0.1, 1), 0.1):setDelay(1.5)

	local var_6_0

	var_6_0 = LeanTween.scale(self.gameObject_, Vector3.zero, 0.1):setDelay(1.6):setOnComplete(System.Action(function()
		self:FinishAction()
		var_6_0:setOnComplete(nil)
	end))
end

function TipsShortItemView:FinishAction()
	self.data_:Finish()
	SetActive(self.gameObject_, false)
end

function TipsShortItemView:FastFinish()
	LeanTween.cancel(self.gameObject_)
end

function TipsShortItemView:RefreshTips(arg_10_1, arg_10_2)
	local var_10_0 = TipsCfg[arg_10_1]

	if TipsCfg[arg_10_1].type == 2 then
		self.levelText_.text = ""

		SetActive(self.iconGo_, false)
		SetActive(self.levelImgGo_, true)
		SetActive(self.levelTextGo_, false)

		self.levelImg_.sprite = getSprite("Atlas/Tips", var_10_0.pic1)

		self.levelImg_:SetNativeSize()
	elseif TipsCfg[arg_10_1].type == 3 then
		self.levelText_.text = arg_10_2 or ""

		local var_10_1 = var_10_0.pic1 ~= ""

		SetActive(self.iconGo_, true)
		SetActive(self.levelImgGo_, var_10_1)
		SetActive(self.levelTextGo_, true)

		if var_10_1 then
			self.levelImg_.sprite = getSprite("Atlas/Tips", var_10_0.pic1)

			self.levelImg_:SetNativeSize()
		end

		self.icon_.sprite = getSprite("Atlas/Tips", var_10_0.pic2)

		self.icon_:SetNativeSize()
	end
end

function TipsShortItemView:Dispose()
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
	self.levelText_ = nil
	self.levelImg_ = nil
	self.text_ = nil
	self.iconGo_ = nil
	self.icon_ = nil
	self.levelTextGo_ = nil
	self.levelImgGo_ = nil
end

return TipsShortItemView
