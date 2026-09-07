local MainBaseView = class("MainBaseView", import("view.base.BaseEventLogic"))

function MainBaseView:Ctor(arg_1_1, arg_1_2)
	MainBaseView.super.Ctor(self, arg_1_2)
	pg.DelegateInfo.New(self)

	self._tf = arg_1_1
	self._go = arg_1_1.gameObject
	self.foldableHelper = MainFoldableHelper.New(arg_1_1, self:GetDirection())
	self._canvasGroup = GetOrAddComponent(self._tf, typeof(CanvasGroup))

	return
end

function MainBaseView:Init()
	return
end

function MainBaseView:Fold(arg_3_1, arg_3_2)
	self.foldableHelper:Fold(arg_3_1, arg_3_2)

	return
end

function MainBaseView:Refresh()
	return
end

function MainBaseView:Disable()
	return
end

function MainBaseView:GetDirection()
	return Vector2.zero
end

function MainBaseView:SetVisible(arg_7_1)
	setActive(self._tf, arg_7_1)

	return
end

function MainBaseView:SetEffectVisible(arg_8_1)
	return
end

function MainBaseView:SetAlpha(arg_9_1)
	self._canvasGroup.alpha = arg_9_1

	return
end

function MainBaseView:SetInteractable(arg_10_1)
	self._canvasGroup.interactable = arg_10_1 and arg_10_1 or false

	return
end

function MainBaseView:SetBlocksRaycasts(arg_11_1)
	self._canvasGroup.blocksRaycasts = arg_11_1 and arg_11_1 or false

	return
end

function MainBaseView:IgnoreParentGroups(arg_12_1)
	self._canvasGroup.ignoreParentGroups = arg_12_1

	return
end

function MainBaseView:Dispose()
	self.exited = true

	self:disposeEvent()

	if self.foldableHelper then
		pg.DelegateInfo.Dispose(self)
		self.foldableHelper:Dispose()

		self.foldableHelper = nil
	end

	return
end

return MainBaseView
