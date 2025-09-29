module("framework.resource.loader.PrefabLoader", package.seeall)

local var_0_0 = class("PrefabLoader")

function var_0_0.Get(arg_1_0)
	return Astral.LuaComponentContainer.Add(arg_1_0, var_0_0)
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1.gameObject
	arg_2_0._url = nil
	arg_2_0._prefabRes = nil
	arg_2_0._prefabInst = nil
	arg_2_0._loadedHandler = nil
	arg_2_0._loadedHandlerObj = nil
end

function var_0_0.getUrl(arg_3_0)
	return arg_3_0._url
end

function var_0_0.getGO(arg_4_0)
	return arg_4_0._go
end

function var_0_0.getRes(arg_5_0)
	return arg_5_0._prefabRes
end

function var_0_0.getInst(arg_6_0)
	return arg_6_0._prefabInst
end

function var_0_0.OnDestroy(arg_7_0)
	arg_7_0:clear()

	arg_7_0._go = nil
end

function var_0_0.load(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_0._url == arg_8_1 then
		return
	end

	arg_8_0:clear()

	if arg_8_1 == nil then
		return
	end

	arg_8_0._url = arg_8_1
	arg_8_0._loadedHandler = arg_8_2
	arg_8_0._loadedHandlerObj = arg_8_3
	arg_8_4 = arg_8_4 or false

	getres(arg_8_0._url, arg_8_0._onPrefabLoaded, arg_8_0, nil, arg_8_4)
end

function var_0_0._onPrefabLoaded(arg_9_0, arg_9_1)
	if arg_9_1.IsSuccess and not arg_9_0._prefabInst and arg_9_0._url == arg_9_1.ResPath and arg_9_0._go and not goutil.isNil(arg_9_0._go) then
		local var_9_0 = arg_9_1:GetAsset(nil, nil)

		if var_9_0 then
			arg_9_0._prefabRes = arg_9_1

			arg_9_0._prefabRes:Retain()

			arg_9_0._prefabInst = Astral.GameObjectUtil.CloneAndSetParent(var_9_0, arg_9_0._go.transform, nil)
			arg_9_0._prefabInst.layer = arg_9_0._go.layer

			local var_9_1 = arg_9_0._loadedHandler
			local var_9_2 = arg_9_0._loadedHandlerObj

			arg_9_0._loadedHandler = nil
			arg_9_0._loadedHandlerObj = nil

			if var_9_1 ~= nil then
				if var_9_2 == nil then
					var_9_1(arg_9_0)
				else
					var_9_1(var_9_2, arg_9_0)
				end
			end
		else
			arg_9_0._loadedHandler = nil
			arg_9_0._loadedHandlerObj = nil
		end
	else
		arg_9_0._loadedHandler = nil
		arg_9_0._loadedHandlerObj = nil
	end
end

function var_0_0.clear(arg_10_0)
	if arg_10_0._url == nil then
		return
	end

	goutil.destroy(arg_10_0._prefabInst)

	arg_10_0._prefabInst = nil

	if arg_10_0._prefabRes ~= nil then
		arg_10_0._prefabRes:Release()
	else
		removeresl(arg_10_0._url, arg_10_0._onPrefabLoaded, arg_10_0)
	end

	arg_10_0._prefabRes = nil
	arg_10_0._url = nil
	arg_10_0._loadedHandler = nil
	arg_10_0._loadedHandlerObj = nil
end

return var_0_0
