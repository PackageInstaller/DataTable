local SkinDrawInfoContentItemOld = class("SkinDrawInfoContentItemOld", ReduxView)

function SkinDrawInfoContentItemOld:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkinDrawInfoContentItemOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SkinDrawInfoContentItemOld:InitUI()
	self:BindCfgUI()

	self.item_ = {}
end

function SkinDrawInfoContentItemOld:AddUIListeners()
	return
end

function SkinDrawInfoContentItemOld:RefreshData(arg_5_1, arg_5_2)
	self.data_ = arg_5_1
	self.activityID_ = arg_5_2

	self:RefreshUI()
end

function SkinDrawInfoContentItemOld:RefreshUI()
	self:RefreshTitle()
	self:RefreshPool()
end

function SkinDrawInfoContentItemOld:RefreshTitle()
	SetActive(self.UpGo_, false)
	self:Show(true)

	self.labelTxt_.text = GetI18NText(self.data_.name)
	self.tips01.text = ""
	self.tips02.text = ""
end

function SkinDrawInfoContentItemOld:RefreshPool()
	for iter_8_0 = 1, #self.data_.list do
		local var_8_0

		if not self.item_[iter_8_0] then
			self.item_[iter_8_0] = SkinDrawInfoItemOld.New((Object.Instantiate(self.infoItem_, self.contentTrs_)))
			var_8_0 = ActivityLimitedDrawPoolCfg[self.data_.list[iter_8_0]]
		end

		local var_8_1 = ActivitySkinDrawDataOld:GetDrawInfo(self.activityID_, self.data_.list[iter_8_0])
		local var_8_2 = var_8_0.total
		local var_8_3

		if var_8_1 then
			var_8_3 = var_8_1.num or var_8_2
		end

		self.item_[iter_8_0]:RefreshData(var_8_0.reward[1][1], var_8_0.reward[1][2])
		self.item_[iter_8_0]:SetBottomText(var_8_3 .. "/" .. var_8_2)
	end

	for iter_8_1 = #self.data_.list + 1, #self.item_ do
		self.item_[iter_8_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
end

function SkinDrawInfoContentItemOld:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function SkinDrawInfoContentItemOld:OnExit()
	for iter_10_0 = 1, #self.item_ do
		self.item_[iter_10_0]:OnExit()
	end
end

function SkinDrawInfoContentItemOld:Dispose()
	self:RemoveAllListeners()

	for iter_11_0 = 1, #self.item_ do
		self.item_[iter_11_0]:Dispose()
	end

	self.super.Dispose(self)
end

return SkinDrawInfoContentItemOld
