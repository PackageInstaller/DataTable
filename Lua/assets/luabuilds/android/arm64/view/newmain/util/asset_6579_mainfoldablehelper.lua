local MainFoldableHelper = class("MainFoldableHelper")

function MainFoldableHelper:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self.foldPosition = self:InitFoldPositions(arg_1_2)

	return
end

function MainFoldableHelper:IsInit()
	return self._tf ~= nil
end

function MainFoldableHelper:InitFoldPositions(arg_3_1)
	if not self:IsInit() then
		return nil
	end

	local var_3_0 = self._tf.anchoredPosition
	local var_3_1 = 200
	local var_3_2 = 0
	local var_3_3 = 0

	if arg_3_1.x > 0 then
		var_3_2 = var_3_0.x + 1500
	elseif arg_3_1.x < 0 then
		var_3_2 = var_3_0.x - 1500
	end

	if arg_3_1.y > 0 then
		var_3_3 = var_3_0.y + var_3_1
	elseif arg_3_1.y < 0 then
		var_3_3 = var_3_0.y - var_3_1
	end

	return Vector4(self._tf.anchoredPosition.x, var_3_2, self._tf.anchoredPosition.y, var_3_3)
end

function MainFoldableHelper:Fold(arg_4_1, arg_4_2)
	if not self:IsInit() then
		return
	end

	LeanTween.cancel(self._tf.gameObject)

	if self.foldPosition.y ~= 0 then
		self:LeanTweenValue(arg_4_1 and Vector2(self.foldPosition.x, self.foldPosition.y) or Vector2(self.foldPosition.y, self.foldPosition.x), arg_4_2, true)
	end

	if self.foldPosition.w ~= 0 then
		self:LeanTweenValue(arg_4_1 and Vector2(self.foldPosition.z, self.foldPosition.w) or Vector2(self.foldPosition.w, self.foldPosition.z), arg_4_2, false)
	end

	return
end

function MainFoldableHelper:LeanTweenValue(arg_5_1, arg_5_2, arg_5_3)
	local function var_5_0(arg_6_0)
		if arg_5_3 then
			setAnchoredPosition(self._tf.gameObject, {
				x = arg_6_0
			})
		else
			setAnchoredPosition(self._tf.gameObject, {
				y = arg_6_0
			})
		end

		return
	end

	if arg_5_2 <= 0 then
		var_5_0(arg_5_1.y)

		return
	end

	LeanTween.value(self._tf.gameObject, arg_5_1.x, arg_5_1.y, arg_5_2):setOnUpdate(System.Action_float(var_5_0)):setEase(LeanTweenType.easeInOutExpo)

	return
end

function MainFoldableHelper:Dispose()
	if not self:IsInit() then
		return nil
	end

	LeanTween.cancel(self._tf.gameObject)

	return
end

return MainFoldableHelper
