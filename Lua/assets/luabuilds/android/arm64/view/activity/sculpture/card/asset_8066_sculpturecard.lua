local SculptureCard = class("SculptureCard")

function SculptureCard:Ctor(arg_1_1)
	self.tr = arg_1_1
	self.go = arg_1_1.gameObject
	self.nameImg = arg_1_1:Find("name/Image"):GetComponent(typeof(Image))
	self.roleImg = arg_1_1:Find("role"):GetComponent(typeof(Image))
	self.consumeTxt = arg_1_1:Find("mask/Text"):GetComponent(typeof(Text))
	self.consumeIcon = arg_1_1:Find("mask/icon"):GetComponent(typeof(Image))
	self.finishBtn = arg_1_1:Find("btns/finish")
	self.continueBtn = arg_1_1:Find("btns/continue")
	self.presentedBtn = arg_1_1:Find("btns/presented")
	self.lockBtn = arg_1_1:Find("mask")

	return
end

function SculptureCard:Update(arg_2_1, arg_2_2)
	self.activity = arg_2_2
	self.id = arg_2_1

	local var_2_0 = arg_2_2:GetSculptureState(arg_2_1)

	if var_2_0 < SculptureActivity.STATE_UNLOCK then
		self:UpdateConsume()
	end

	self:UpdateName()
	self:UpdateRole(var_2_0)
	self:UpdateBtns(var_2_0)

	return
end

function SculptureCard:Flush(arg_3_1)
	self.activity = arg_3_1

	local var_3_0 = self.activity:GetSculptureState(self.id)

	self:UpdateBtns(var_3_0)
	self:UpdateRole(var_3_0)

	return
end

function SculptureCard:UpdateConsume()
	local var_4_0, var_4_1 = self.activity:_GetComsume(self.id)

	self.consumeTxt.text = var_4_1
	self.consumeIcon.sprite = LoadSprite("props/" .. pg.activity_workbench_item[var_4_0].icon)
	rtf(self.consumeIcon.gameObject).sizeDelta = Vector2(60, 60)

	return
end

function SculptureCard:UpdateName()
	self.nameImg.sprite = GetSpriteFromAtlas("ui/SculptureUI_atlas", self.activity:GetResorceName(self.id) .. "_title")

	self.nameImg:SetNativeSize()

	return
end

function SculptureCard:UpdateRole(arg_6_1)
	local var_6_0 = self.activity:GetResorceName(self.id)

	if arg_6_1 == SculptureActivity.STATE_FINSIH then
		self.roleImg.sprite = nil

		setActive(self.roleImg.gameObject, false)
		self:LoadChar(var_6_0)
	else
		if arg_6_1 >= SculptureActivity.STATE_UNLOCK then
			var_6_0 = var_6_0 .. "_gray"
		end

		LoadSpriteAtlasAsync("SculptureRole/" .. var_6_0, nil, function(arg_7_0)
			if self.exited then
				return
			end

			self.roleImg.sprite = arg_7_0

			self.roleImg:SetNativeSize()

			return
		end)
	end

	return
end

function SculptureCard:LoadChar(arg_8_1)
	if self.charName == arg_8_1 then
		return
	end

	self:ClearChar()
	PoolMgr.GetInstance():GetSpineChar("takegift_" .. arg_8_1, true, function(arg_9_0)
		arg_9_0.transform:SetParent(self.roleImg.gameObject.transform.parent)

		arg_9_0.transform.localScale = Vector3(0.8, 0.8, 0)
		arg_9_0.transform.localPosition = Vector3(0, -180, 0)

		arg_9_0:GetComponent(typeof(SpineAnimUI)):SetAction("take_wait_" .. arg_8_1, 0)

		self.charGo = arg_9_0

		return
	end)

	self.charName = arg_8_1

	return
end

function SculptureCard:ClearChar()
	if self.charName and self.charGo then
		PoolMgr.GetInstance():ReturnSpineChar(self.charName, self.charGo)

		self.charName = nil
		self.charGo = nil
	end

	return
end

function SculptureCard:UpdateBtns(arg_11_1)
	setActive(self.finishBtn, arg_11_1 == SculptureActivity.STATE_FINSIH)
	setActive(self.continueBtn, arg_11_1 >= SculptureActivity.STATE_UNLOCK and arg_11_1 < SculptureActivity.STATE_JOINT)
	setActive(self.presentedBtn, arg_11_1 == SculptureActivity.STATE_JOINT)
	setActive(self.lockBtn, arg_11_1 < SculptureActivity.STATE_UNLOCK)

	return
end

function SculptureCard:Dispose()
	self.exited = true

	self:ClearChar()

	return
end

return SculptureCard
