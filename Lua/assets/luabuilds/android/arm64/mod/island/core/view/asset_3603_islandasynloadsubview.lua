local IslandASynLoadSubView = class("IslandASynLoadSubView", import(".IslandBaseSubView"))

function IslandASynLoadSubView:Ctor(arg_1_1)
	IslandASynLoadSubView.super.Ctor(self, arg_1_1)

	self.__funcList = {}
	self.isloading = false

	return
end

function IslandASynLoadSubView:Init(...)
	self.isloading = true

	IslandASynLoadSubView.super.Init(self, ...)

	return
end

function IslandASynLoadSubView:OnLoaded()
	self.isloading = false

	self:ExecuteFuncList()

	return
end

function IslandASynLoadSubView:ExecuteFuncList()
	if #self.__funcList <= 0 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(self.__funcList) do
		self[iter_4_1.name](self, unpackEx(iter_4_1.args))
	end

	self.__funcList = {}

	return
end

function IslandASynLoadSubView:GetUIParent(arg_5_1)
	return self:GetView().pageContianer
end

function IslandASynLoadSubView:Show(...)
	if self:IsEmpty() then
		self:Init(...)
	else
		self:ShowOrHideGameObject(self._go, true)
		self:Flush(...)
	end

	self:OnShow()

	return
end

function IslandASynLoadSubView:OnShow()
	return
end

function IslandASynLoadSubView:Hide()
	self:ShowOrHideGameObject(self._go, false)
	self:OnHide()

	return
end

function IslandASynLoadSubView:OnHide()
	return
end

function IslandASynLoadSubView:ShowOrHideGameObject(arg_10_1, arg_10_2)
	local var_10_0 = GetOrAddComponent(arg_10_1, typeof(CanvasGroup))

	var_10_0.alpha = arg_10_2 and 1 or 0
	var_10_0.blocksRaycasts = arg_10_2

	return
end

function IslandASynLoadSubView:Execute(arg_11_1, ...)
	if self:IsLoaded() or not self:IsLoaded() and #self.__funcList == 0 and arg_11_1 == "Show" then
		self[arg_11_1](self, ...)
	elseif self.isloading then
		table.insert(self.__funcList, {
			name = arg_11_1,
			args = packEx(...)
		})
	end

	return
end

return IslandASynLoadSubView
