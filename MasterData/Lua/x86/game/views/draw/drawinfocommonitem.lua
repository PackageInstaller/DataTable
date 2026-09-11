local DrawInfoCommonItem = class("DrawInfoCommonItem", ReduxView)

function DrawInfoCommonItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddUIListener()

	self.upCon_ = self.transform_:GetComponent("ControllerExCollection"):GetController("UP")
end

function DrawInfoCommonItem:AddUIListener()
	self:AddBtnListener(self.btnBg_, nil, function()
		if self.isHero then
			JumpTools.OpenPageByJump("/heroPreviewMain", {
				isEnter = true,
				hid = DrawItemCfg[self.itemId].item_id
			})
		else
			self:Go("/showServantView", {
				stage = 5,
				state = "onlydetail",
				id = DrawItemCfg[self.itemId].item_id
			})
		end
	end)
end

function DrawInfoCommonItem:RefreshData(arg_4_1, arg_4_2)
	if self.item then
		self.item:Dispose()

		self.item = nil
	end

	self:Show(true)

	self.item = CommonItemView.New(self.commonItem)
	self.isHero = arg_4_2
	self.itemId = arg_4_1

	if DrawItemCfg[arg_4_1] == nil then
		Debug.LogError(string.format("配置表 DrawItemCfg 找不到 id : %s ", arg_4_1))

		return
	end

	local var_4_0 = DrawItemCfg[arg_4_1].item_id or 0

	if arg_4_2 then
		self.item:SetData({
			id = var_4_0
		})
	else
		self.item:SetData({
			id = var_4_0
		})
	end
end

function DrawInfoCommonItem:RefreshUp(arg_5_1, arg_5_2)
	if arg_5_1 and #arg_5_1 > 0 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			if self.itemId == iter_5_1 then
				self.upCon_:SetSelectedIndex(1)

				break
			end
		end
	else
		self.upCon_:SetSelectedIndex(0)
	end

	if not arg_5_2 then
		self.upCon_:SetSelectedIndex(0)
	end
end

function DrawInfoCommonItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

function DrawInfoCommonItem:Dispose()
	DrawInfoCommonItem.super.Dispose(self)

	if self.item then
		self.item:Dispose()
		Object.Destroy(self.item.gameObject_)

		self.item = nil
	end

	self.gameObject_ = nil
	self.transform_ = nil
end

return DrawInfoCommonItem
