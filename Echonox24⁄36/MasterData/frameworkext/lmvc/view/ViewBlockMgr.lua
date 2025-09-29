module("frameworkext.lmvc.view.ViewBlockMgr", package.seeall)

local var_0_0 = class("ViewBlockMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._blockKeys = {}
	arg_1_0._blockClickMaskGO = nil
	arg_1_0._transparentColor = "#00000000"
end

function var_0_0.blockClick(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or ViewBlockKey.Default

	if arg_2_1 then
		if not arg_2_0._blockKeys[arg_2_2] then
			arg_2_0._blockKeys[arg_2_2] = true

			arg_2_0:_tryCreateBlockClickMask()

			if not arg_2_0._blockClickMaskGO.activeSelf then
				goutil.setActive(arg_2_0._blockClickMaskGO, true)
			end
		end
	else
		arg_2_0._blockKeys[arg_2_2] = nil

		if arg_2_0._blockClickMaskGO and arg_2_0._blockClickMaskGO.activeSelf and table.nums(arg_2_0._blockKeys) == 0 then
			goutil.setActive(arg_2_0._blockClickMaskGO, false)
		end
	end
end

function var_0_0.cancelAll(arg_3_0)
	table.clear(arg_3_0._blockKeys)

	if arg_3_0._blockClickMaskGO and arg_3_0._blockClickMaskGO.activeSelf then
		goutil.setActive(arg_3_0._blockClickMaskGO, false)
	end
end

function var_0_0.isOpen(arg_4_0)
	return arg_4_0._blockClickMaskGO.activeSelf
end

function var_0_0.isBlockClicking(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or ViewBlockKey.Default

	return arg_5_0._blockKeys[arg_5_1] ~= nil
end

function var_0_0._tryCreateBlockClickMask(arg_6_0)
	if arg_6_0._blockClickMaskGO then
		return
	end

	arg_6_0._blockClickMaskGO = goutil.create("ViewBlockMask")

	local var_6_0 = ViewMgr.instance:getRoot(ViewRootType.Top)

	goutil.addChildToParent(arg_6_0._blockClickMaskGO, var_6_0)

	goutil.addComponentOnce(arg_6_0._blockClickMaskGO, typeof(UnityEngine.UI.Image)).color = parsecolor(arg_6_0._transparentColor)

	local var_6_1 = arg_6_0._blockClickMaskGO.transform

	var_6_1.anchorMin = UnityEngine.Vector2.zero
	var_6_1.anchorMax = UnityEngine.Vector2.one
	var_6_1.offsetMin = UnityEngine.Vector2.New(-150, -150)
	var_6_1.offsetMax = UnityEngine.Vector2.New(150, 150)
end

var_0_0.instance = var_0_0.New()

return var_0_0
