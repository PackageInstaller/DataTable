local MainAdpterView = class("MainAdpterView", import("...base.MainBaseView"))

function MainAdpterView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	MainAdpterView.super.Ctor(self, arg_1_1, nil)

	self.foldableHelperBottom = MainFoldableHelper.New(arg_1_2, Vector2(0, -1))
	self.foldableHelperRight = MainFoldableHelper.New(arg_1_3, Vector2(1, 0))

	return
end

function MainAdpterView:Fold(arg_2_1, arg_2_2)
	MainAdpterView.super.Fold(self, arg_2_1, arg_2_2)
	self.foldableHelperBottom:Fold(arg_2_1, arg_2_2)
	self.foldableHelperRight:Fold(arg_2_1, arg_2_2)

	return
end

function MainAdpterView:GetDirection()
	return Vector2(0, 1)
end

function MainAdpterView:Dispose()
	MainAdpterView.super.Dispose(self)
	self.foldableHelperBottom:Dispose()
	self.foldableHelperRight:Dispose()

	return
end

return MainAdpterView
