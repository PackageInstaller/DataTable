local WorldMediaCollectionTemplateLayer = class("WorldMediaCollectionTemplateLayer", import("view.base.BaseSubView"))

function WorldMediaCollectionTemplateLayer:getUIName()
	assert(false, "Need Assign UIName " .. self.__cname)

	return
end

function WorldMediaCollectionTemplateLayer:Ctor(arg_2_1, ...)
	WorldMediaCollectionTemplateLayer.super.Ctor(self, ...)

	self.viewParent = arg_2_1
	self.buffer = setmetatable({}, {
		__index = function(arg_3_0, arg_3_1)
			return function(arg_4_0, ...)
				self:ActionInvoke(arg_3_1, ...)

				return
			end
		end,
		__newindex = function()
			errorMsg("Cant write Data in ActionInvoke buffer")

			return
		end
	})

	return
end

function WorldMediaCollectionTemplateLayer:Show()
	WorldMediaCollectionTemplateLayer.super.Show(self)

	if self._top then
		self:OverlayPanel(self._top)
	end

	return
end

function WorldMediaCollectionTemplateLayer:Hide()
	if self._top then
		self:UnOverlayPanel(self._top, self._tf)
	end

	WorldMediaCollectionTemplateLayer.super.Hide(self)

	return
end

function WorldMediaCollectionTemplateLayer:OnSelected()
	self:Show()

	return
end

function WorldMediaCollectionTemplateLayer:OnReselected()
	return
end

function WorldMediaCollectionTemplateLayer:OnDeselected()
	self:Hide()

	return
end

function WorldMediaCollectionTemplateLayer:OnBackward()
	return
end

function WorldMediaCollectionTemplateLayer:SetActive(arg_12_1)
	if arg_12_1 then
		self:Show()
	else
		self:Hide()
	end

	return
end

function WorldMediaCollectionTemplateLayer:UpdateView()
	return
end

return WorldMediaCollectionTemplateLayer
