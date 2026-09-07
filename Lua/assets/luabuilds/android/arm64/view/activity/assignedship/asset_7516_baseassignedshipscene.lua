local BaseAssignedShipScene = class("BaseAssignedShipScene", import("view.base.BaseUI"))

BaseAssignedShipScene.TipWords = {
	shrine_year = "seven_choose_one",
	login_year = "nine_choose_one",
	login_santa = "five_choose_one",
	shrine_year_winterfestival_2025 = "seven_choose_one",
	greeting_year = "spring_invited_2021"
}

function BaseAssignedShipScene:getUIName()
	assert(false)

	return
end

function BaseAssignedShipScene:setItemVO(arg_2_1)
	self.itemVO = arg_2_1
	self.idList = self.itemVO:getConfig("usage_arg")
	self.shipIdList = underscore.map(self.idList, function(arg_3_0)
		return pg.item_usage_invitation[arg_3_0].ship_id
	end)
	self.style, self.title = unpack(self.itemVO:getConfig("open_ui"))
	self.strTip = BaseAssignedShipScene.TipWords[self.style]

	return
end

function BaseAssignedShipScene:init()
	local var_4_0 = self._tf:Find("layer")

	self.backBtn = var_4_0:Find("back")
	self.confirmBtn = var_4_0:Find("confirm")
	self.print = var_4_0:Find("print")
	self.rtName = var_4_0:Find("name")
	self.rtTitle = var_4_0:Find("title")
	self.selectPanel = var_4_0:Find("select_panel/layout")
	self.itemList = UIItemList.New(self.selectPanel, self.selectPanel:Find("item"))

	self.itemList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			GetImageSpriteFromAtlasAsync("extra_page/" .. self.style .. "/i_" .. self.shipIdList[arg_5_1], "", arg_5_2)
			GetImageSpriteFromAtlasAsync("extra_page/" .. self.style .. "/is_" .. self.shipIdList[arg_5_1], "", arg_5_2:Find("selected"))
			onToggle(self, arg_5_2, function(arg_6_0)
				if arg_6_0 and self.selectTarget ~= arg_5_1 then
					LeanTween.cancel(self.print)

					if self.rtName then
						LeanTween.cancel(self.rtName)
					end

					self:setSelectTarget(arg_5_1)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)

	self.selectTarget = nil
	self.count = 1
	self.spList = {}
	self.afterAnima = {}

	return
end

function BaseAssignedShipScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(BaseAssignedShipScene.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(self, self.confirmBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n(self.strTip, pg.ship_data_statistics[self.selectedShipNumber].name),
			onYes = function()
				self:emit(AssignedShipMediator.ON_USE_ITEM, self.itemVO.id, self.count, {
					self.idList[self.selectTarget]
				})

				return
			end
		})

		return
	end, SFX_PANEL)
	self.itemList:align(#self.idList)
	setActive(self.rtTitle, self.title)

	if self.title then
		GetImageSpriteFromAtlasAsync("extra_page/" .. self.style .. "/" .. self.title, "", self.rtTitle, true)
	end

	triggerToggle(self.selectPanel:GetChild(0), true)

	return
end

function BaseAssignedShipScene:checkAndSetSprite(arg_11_1, arg_11_2)
	if self.spList[arg_11_1] and self.afterAnima[arg_11_1] then
		setImageSprite(arg_11_2, self.spList[arg_11_1], true)

		arg_11_2:GetComponent(typeof(Image)).enabled = true
		self.spList[arg_11_1] = nil
		self.afterAnima[arg_11_1] = nil

		LeanTween.alpha(arg_11_2, 1, 0.3):setFrom(0)
	end

	return
end

function BaseAssignedShipScene:changeShowCharacter(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3 then
		LeanTween.alpha(rtf(arg_12_2), 0, 0.3):setOnComplete(System.Action(function()
			arg_12_2:GetComponent(typeof(Image)).enabled = false
			self.afterAnima[arg_12_1] = true

			self:checkAndSetSprite(arg_12_1, arg_12_2)

			return
		end))
	else
		arg_12_2:GetComponent(typeof(Image)).enabled = false
		self.afterAnima[arg_12_1] = true
	end

	GetSpriteFromAtlasAsync("extra_page/" .. self.style .. "/" .. arg_12_1, "", function(arg_14_0)
		self.spList[arg_12_1] = arg_14_0

		self:checkAndSetSprite(arg_12_1, arg_12_2)

		return
	end)

	return
end

function BaseAssignedShipScene:setSelectTarget(arg_15_1)
	self:changeShowCharacter("p_" .. self.shipIdList[arg_15_1], self.print, self.selectTarget)

	if self.rtName then
		self:changeShowCharacter("n_" .. self.shipIdList[arg_15_1], self.rtName, self.selectTarget)
	end

	self.selectTarget = arg_15_1
	self.selectedShipNumber = self.shipIdList[arg_15_1]

	return
end

function BaseAssignedShipScene:willExit()
	return
end

return BaseAssignedShipScene
