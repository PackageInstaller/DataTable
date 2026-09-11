local TagViewPanel = class("TagViewPanel", ReduxView)

function TagViewPanel:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function TagViewPanel:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TagViewPanel:InitUI()
	self:BindCfgUI()

	self.tagItem_ = {}
end

function TagViewPanel:AddUIListeners()
	return
end

function TagViewPanel:OnEnter()
	return
end

function TagViewPanel:RefreshData(arg_6_1)
	self.list_ = arg_6_1

	for iter_6_0, iter_6_1 in ipairs(self.list_) do
		if not self.tagItem_[iter_6_0] then
			self.tagItem_[iter_6_0] = TagItem.New((Object.Instantiate(self.tagTemplate_, self.transform_)))

			self.tagItem_[iter_6_0]:RegisterClickFunction(function(arg_7_0)
				if self.callback_ then
					self.callback_(arg_7_0)
				end
			end)
		end

		self.tagItem_[iter_6_0]:SetData(iter_6_1)
	end

	for iter_6_2 = #self.list_ + 1, #self.tagItem_ do
		self.tagItem_[iter_6_2]:Show(false)
	end
end

function TagViewPanel:RefreshSelect(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self.tagItem_) do
		iter_8_1:RefreshSelect(arg_8_1[iter_8_1.id_] == true)
	end
end

function TagViewPanel:RegisterClickFunction(arg_9_1)
	self.callback_ = arg_9_1
end

function TagViewPanel:OnExit()
	for iter_10_0, iter_10_1 in ipairs(self.tagItem_) do
		iter_10_1:OnExit()
	end
end

function TagViewPanel:Dispose()
	self:RemoveAllEventListener()

	for iter_11_0, iter_11_1 in ipairs(self.tagItem_) do
		iter_11_1:Dispose()
	end

	TagViewPanel.super.Dispose(self)
end

return TagViewPanel
