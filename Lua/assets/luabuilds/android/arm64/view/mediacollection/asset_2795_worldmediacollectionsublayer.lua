local WorldMediaCollectionSubLayer = class("WorldMediaCollectionSubLayer", import("view.base.BaseSubView"))

function WorldMediaCollectionSubLayer:Ctor(arg_1_1, ...)
	WorldMediaCollectionSubLayer.super.Ctor(self, ...)

	self.viewParent = arg_1_1
	self.buffer = setmetatable({}, {
		__index = function(arg_2_0, arg_2_1)
			return function(arg_3_0, ...)
				self:ActionInvoke(arg_2_1, ...)

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

function WorldMediaCollectionSubLayer:SetActive(arg_5_1)
	if arg_5_1 then
		self:Show()
	else
		self:Hide()
	end

	return
end

function WorldMediaCollectionSubLayer:OnDestroy()
	if self.loader then
		self.loader:Clear()

		self.loader = nil
	end

	return
end

return WorldMediaCollectionSubLayer
