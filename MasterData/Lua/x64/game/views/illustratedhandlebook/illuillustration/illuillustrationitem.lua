local IlluIllustrationItem = class("IlluIllustrationItem", ReduxView)

function IlluIllustrationItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IlluIllustrationItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function IlluIllustrationItem:InitUI()
	self:BindCfgUI()

	self.itemiconImg_.cacheLimit = 3
	self.roleiconImg_.cacheLimit = 3
	self.controller_ = ControllerUtil.GetController(self.gameObject_.transform, "conName")
	self.giftCon_ = ControllerUtil.GetController(self.gameObject_.transform, "gift")
	self.haveCon_ = ControllerUtil.GetController(self.gameObject_.transform, "have")
	self.selectCon_ = ControllerUtil.GetController(self.gameObject_.transform, "select")
	self.multitCon_ = ControllerUtil.GetController(self.gameObject_.transform, "multi")
end

function IlluIllustrationItem:RefreshUI(arg_4_1, arg_4_2, arg_4_3)
	self.id_ = arg_4_1
	self.type_ = CollectPictureCfg[arg_4_1].type
	self.index_ = arg_4_3

	if self.type_ == 1 then
		self.controller_:SetSelectedState("item")

		self.itemiconImg_.spriteSync = SpritePathCfg.CollectPictureSmall.path .. CollectPictureCfg[arg_4_1].picture
	else
		self.controller_:SetSelectedState("role")

		self.roleiconImg_.spriteSync = SpritePathCfg.CollectPictureSmall.path .. CollectPictureCfg[arg_4_1].picture
	end

	self.have_ = IllustratedData:GetIllustrationInfo()[self.id_]

	if self.have_ then
		if not arg_4_2 then
			local var_4_0 = 1

			for iter_4_0, iter_4_1 in ipairs(CollectPictureCfg.get_id_list_by_group_id[CollectPictureCfg[self.id_].group_id]) do
				local var_4_1 = IllustratedData:GetIllustrationInfo()[iter_4_1]

				if var_4_1 and var_4_1.is_receive == 0 then
					var_4_0 = 0

					break
				end
			end

			if var_4_0 == 1 then
				self.giftCon_:SetSelectedState("notShow")
			else
				self.giftCon_:SetSelectedState("show")
			end
		else
			self.giftCon_:SetSelectedState("notShow")
		end

		self.haveCon_:SetSelectedState("1")

		self.itemBtn_.interactable = true
	else
		self.haveCon_:SetSelectedState("0")

		self.itemBtn_.interactable = false
	end

	local var_4_2 = CollectPictureCfg[self.id_]

	self.nameText_.text = GetI18NText(CollectPictureCfg[self.id_].name)

	self.multitCon_:SetSelectedState(#(CollectPictureCfg.get_id_list_by_group_id[var_4_2.group_id] or {}) > 1 and not arg_4_2 and "true" or "false")
end

function IlluIllustrationItem:SetSelect(arg_5_1)
	self.selectCon_:SetSelectedState(arg_5_1 and "true" or "false")
end

function IlluIllustrationItem:RegisterGiftFunc(arg_6_1)
	self.registerGiftFunc_ = arg_6_1
end

function IlluIllustrationItem:RegisterItemFunc(arg_7_1)
	self.itemClickFunc_ = arg_7_1
end

function IlluIllustrationItem:AddUIListener()
	self:AddBtnListener(self.itemBtn_, nil, function()
		if self.itemClickFunc_ then
			self.itemClickFunc_(self.id_, self.index_)
		end
	end)
	self:AddBtnListener(self.receiveBtn_, nil, function()
		if self.registerGiftFunc_ then
			self.registerGiftFunc_()
		end
	end)
end

function IlluIllustrationItem:Show(arg_11_1)
	SetActive(self.gameObject_, arg_11_1)
end

function IlluIllustrationItem:Dispose()
	IlluIllustrationItem.super.Dispose(self)
end

return IlluIllustrationItem
