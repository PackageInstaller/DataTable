local TouchCakeItem = class("TouchCakeItem")

function TouchCakeItem:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._cakeTf = findTF(self._tf, "cake")
	self._cakeAnimUI = GetComponent(self._cakeTf, typeof(SpineAnimUI))
	self._propLeftSpine = findTF(self._tf, "prop_left/spine")
	self._propLeftIcon = findTF(self._tf, "prop_left/icon")
	self._propLeftAnimUI = GetComponent(self._propLeftSpine, typeof(SpineAnimUI))
	self._propRightSpine = findTF(self._tf, "prop_right/spine")
	self._propRightIcon = findTF(self._tf, "prop_right/icon")
	self._propRightAnimUI = GetComponent(self._propRightSpine, typeof(SpineAnimUI))
	self._props = {
		{
			direct = -1,
			iconTf = self._propLeftIcon,
			spineTf = self._propLeftSpine,
			anim = self._propLeftAnimUI
		},
		{
			direct = 1,
			iconTf = self._propRightIcon,
			spineTf = self._propRightSpine,
			anim = self._propRightAnimUI
		}
	}
	self._eventCallback = arg_1_2

	return
end

function TouchCakeItem:setParent(arg_2_1)
	SetParent(self._tf, arg_2_1, true)

	return
end

function TouchCakeItem:setPosition(arg_3_1)
	self._tf.anchoredPosition = arg_3_1

	return
end

function TouchCakeItem:setData(arg_4_1, arg_4_2, arg_4_3)
	self._cakeData = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(self._props) do
		iter_4_1.data = nil
	end

	if arg_4_2 then
		local var_4_0

		if not arg_4_3 then
			var_4_0 = self._props[math.random(1, #self._props)]
		else
			for iter_4_2, iter_4_3 in ipairs(self._props) do
				if iter_4_3.direct == arg_4_3 then
					var_4_0 = iter_4_3
				end
			end
		end

		var_4_0.data = arg_4_2
	end

	self:updateItem()

	return
end

function TouchCakeItem:updateItem()
	self:setAniamtion(self._cakeAnimUI, (self:getCakeAnimName(TouchCakeGameConst.cake_anim_normal)))

	for iter_5_0, iter_5_1 in ipairs(self._props) do
		setActive(iter_5_1.spineTf, false)
		setActive(iter_5_1.iconTf, false)

		if iter_5_1.data then
			setActive(iter_5_1.spineTf, iter_5_1.data.spine and true or false)
			setActive(iter_5_1.iconTf, iter_5_1.data.icon and true or false)

			if iter_5_1.data.spine then
				local var_5_1, var_5_2 = self:getPropAnimName(TouchCakeGameConst.prop_anim_normal, iter_5_1.data)

				iter_5_1.spineTf.localScale = Vector3(var_5_2, 1, 1)

				self:setAniamtion(iter_5_1.anim, nil)
			elseif iter_5_1.data.icon then
				self:setIconVisible(iter_5_1.iconTf, iter_5_1.data.icon)
			end
		end
	end

	return
end

function TouchCakeItem:setIconVisible(arg_6_1, arg_6_2)
	for iter_6_0 = 1, arg_6_1.childCount do
		local var_6_0 = arg_6_1:GetChild(iter_6_0 - 1)

		setActive(var_6_0, var_6_0.name == arg_6_2)
	end

	return
end

function TouchCakeItem:touchAction(arg_7_1, arg_7_2)
	self:setAniamtion(self._cakeAnimUI, self:getCakeAnimName(TouchCakeGameConst.cake_anim_action, arg_7_1), arg_7_2)
	self._eventCallback(TouchCakeScene.EVENT_ACTION_CAKE, {
		cake = Clone(self._cakeData)
	})

	return
end

function TouchCakeItem:getCakeAnimName(arg_8_1, arg_8_2)
	local var_8_0 = self:getCakeConfig("type")

	if arg_8_1 == TouchCakeGameConst.cake_anim_normal then
		return "normal" .. var_8_0
	elseif arg_8_1 == TouchCakeGameConst.cake_anim_action then
		if arg_8_2 == 1 then
			return "action_left_" .. var_8_0
		elseif arg_8_2 == -1 then
			return "action_right_" .. var_8_0
		end
	end

	return
end

function TouchCakeItem:getPropAnimName(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 == TouchCakeGameConst.prop_anim_normal then
		return "normal" .. arg_9_2.type, 1
	elseif arg_9_1 == TouchCakeGameConst.prop_anim_action then
		if arg_9_2.type == 4 then
			if arg_9_3 == 1 then
				return "action" .. arg_9_2.type, 1
			else
				return "action" .. arg_9_2.type .. "_left", -1
			end
		end

		return "action" .. arg_9_2.type, 1
	end

	return
end

function TouchCakeItem:getCakeConfig(arg_10_1)
	return self._cakeData[arg_10_1]
end

function TouchCakeItem:getPropConfig(arg_11_1)
	return self._propData[arg_11_1]
end

function TouchCakeItem:getTopPos()
	self._tf.anchoredPosition.y = self._tf.anchoredPosition.y + self:getCakeConfig("height")

	return self._tf.anchoredPosition
end

function TouchCakeItem:setLayerLast()
	self._tf:SetAsLastSibling()

	return
end

function TouchCakeItem:setLayerFirst()
	self._tf:SetAsFirstSibling()

	return
end

function TouchCakeItem:getPropDirect()
	for iter_15_0, iter_15_1 in ipairs(self._props) do
		if iter_15_1.data ~= nil then
			return iter_15_1.direct
		end
	end

	return nil
end

function TouchCakeItem:setAniamtion(arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:SetActionCallBack(nil)
	arg_16_1:SetAction(arg_16_2, 0)
	arg_16_1:SetActionCallBack(function(arg_17_0)
		if arg_17_0 == "finish" then
			arg_16_1:SetActionCallBack(nil)

			if arg_16_3 then
				arg_16_3()
			end
		end

		return
	end)

	return
end

function TouchCakeItem:stop()
	if isActive(self._cakeTf) then
		self._cakeAnimUI:Pause()
	end

	for iter_18_0, iter_18_1 in ipairs(self._props) do
		if iter_18_1.spineTf and isActive(iter_18_1.spineTf) and iter_18_1.anim then
			iter_18_1.anim:Pause()
		end
	end

	return
end

function TouchCakeItem:resume()
	if isActive(self._cakeTf) then
		self._cakeAnimUI:Resume()
	end

	for iter_19_0, iter_19_1 in ipairs(self._props) do
		if iter_19_1.spineTf and isActive(iter_19_1.spineTf) and iter_19_1.anim then
			iter_19_1.anim:Resume()
		end
	end

	return
end

function TouchCakeItem:propAction()
	for iter_20_0, iter_20_1 in ipairs(self._props) do
		if iter_20_1.data then
			self._eventCallback(TouchCakeScene.EVENT_ACTION_PROP, {
				prop = Clone(iter_20_1)
			}, function(arg_21_0)
				if iter_20_1.data.spine then
					local var_21_2, var_21_3 = self:getPropAnimName(TouchCakeGameConst.prop_anim_action, iter_20_1.data, iter_20_1.direct)

					iter_20_1.spineTf.localScale = Vector3(var_21_3, 1, 1)

					self:setAniamtion(iter_20_1.anim, var_21_2, function()
						setActive(iter_20_1.spineTf, false)

						return
					end)
				elseif iter_20_1.data.icon then
					setActive(iter_20_1.iconTf, false)
				end

				return
			end)
		end
	end

	return
end

function TouchCakeItem:clear()
	return
end

return TouchCakeItem
