local StickerView = class("StickerView", ReduxView)

function StickerView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = self.gameObject_.transform
	self.id_ = arg_1_3

	self:Init()
end

function StickerView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function StickerView:InitUI()
	self:BindCfgUI()

	self.btn_ = {}
	self.img_ = {}
	self.sizeCon_ = {}
	self.stateCon_ = {}
	self.cfg_ = StickViewTemplateCfg[self.id_]

	for iter_3_0, iter_3_1 in ipairs(self.cfg_.range_list) do
		self.btn_[iter_3_0] = self["btn_" .. iter_3_0]
		self.sizeCon_[iter_3_0] = ControllerUtil.GetController(self.btn_[iter_3_0].transform, "size")
		self.stateCon_[iter_3_0] = ControllerUtil.GetController(self.btn_[iter_3_0].transform, "state")
		self.img_[iter_3_0] = {}

		for iter_3_2 = 1, 3 do
			self.img_[iter_3_0][iter_3_2] = self["img_" .. iter_3_0 .. "_" .. iter_3_2]
		end
	end
end

function StickerView:AddUIListeners()
	for iter_4_0, iter_4_1 in ipairs(self.btn_) do
		self:AddBtnListener(iter_4_1, nil, function()
			if self.clickFunc_ then
				self.clickFunc_(self.info_[iter_4_0], iter_4_0)
			end
		end)
	end
end

function StickerView:SetData(arg_6_1)
	self.info_ = arg_6_1
end

function StickerView:RefreshUI(arg_7_1)
	local var_7_0 = true

	self.isEditor_ = arg_7_1

	for iter_7_0, iter_7_1 in ipairs(self.cfg_.range_list) do
		local var_7_1 = self.info_[iter_7_0]

		if self.cfg_.range_list[iter_7_0][2][1] < self.info_[iter_7_0].size then
			var_7_1.size = self.cfg_.range_list[iter_7_0][2][1]
		end

		self.sizeCon_[iter_7_0]:SetSelectedState(var_7_1.size)
		self.stateCon_[iter_7_0]:SetSelectedState(var_7_1.stickerID > 0 and "active" or "add")
		SetActive(self.btn_[iter_7_0].gameObject, self.isEditor_ or var_7_1.stickerID > 0)

		if var_7_1.stickerID > 0 then
			var_7_0 = false
			self.img_[iter_7_0][var_7_1.size].sprite = ItemTools.getItemSprite(var_7_1.stickerID, {
				size = var_7_1.size
			})

			self.img_[iter_7_0][var_7_1.size]:SetNativeSize()
		end
	end

	SetActive(self.nothingGo_, not self.isEditor_ and var_7_0)
end

function StickerView:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function StickerView:RegistClickFunc(arg_9_1)
	self.clickFunc_ = arg_9_1
end

function StickerView:OnExit()
	SetActive(self.gameObject_, false)
end

function StickerView:Dispose()
	self:RemoveAllListeners()
	StickerView.super.Dispose(self)
end

return StickerView
