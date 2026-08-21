local var_0_0 = class("ServerNotice", import(".Notice"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.version = arg_1_1.version
	arg_1_0.btnTitle = arg_1_1.btn_title
	arg_1_0.titleImage = arg_1_1.title_image
	arg_1_0.timeDes = arg_1_1.time_desc
	arg_1_0.type = arg_1_1.tag_type
	arg_1_0.icon = arg_1_1.icon
	arg_1_0.track = arg_1_1.track
	arg_1_0.priority = arg_1_1.priority
	arg_1_0.need_level = arg_1_1.need_level

	local var_1_0 = string.split(arg_1_0.title, "&")

	if #var_1_0 > 1 then
		arg_1_0.title = var_1_0[1]
		arg_1_0.pageTitle = var_1_0[2]
	else
		arg_1_0.title = var_1_0[1]
		arg_1_0.pageTitle = var_1_0[1]
	end

	local var_1_1 = string.match(arg_1_0.titleImage, "<config.*/>")

	arg_1_0.paramType = var_1_1 and tonumber(string.match(var_1_1, "type%s*=%s*(%d+)")) or nil

	if arg_1_0.paramType then
		if arg_1_0.paramType == 1 then
			arg_1_0.param = string.match(var_1_1, "param%s*=%s*'(.*)'")
		elseif arg_1_0.paramType == 2 then
			arg_1_0.param = string.match(var_1_1, "param%s*=%s*'(.*)'")
		elseif arg_1_0.paramType == 3 then
			arg_1_0.param = string.match(var_1_1, "param%s*=%s*(%d+)")
			arg_1_0.param = arg_1_0.param and tonumber(arg_1_0.param) or arg_1_0.param
		elseif arg_1_0.paramType == 4 then
			arg_1_0.param = string.match(var_1_1, "param%s*=%s*(%d+)")
			arg_1_0.param = arg_1_0.param and tonumber(arg_1_0.param) or arg_1_0.param
		end
	end

	if var_1_1 then
		local var_1_2, var_1_3 = string.find(arg_1_0.titleImage, var_1_1, 1, true)

		arg_1_0.titleImage = string.sub(arg_1_0.titleImage, var_1_3 + 1, -1)
	end

	arg_1_0.code = arg_1_0:prefKey()

	return
end

function var_0_0.ShouldShow(arg_2_0)
	local var_2_0 = getProxy(PlayerProxy)

	return var_2_0:getRawData().level > arg_2_0.need_level
end

function var_0_0.prefKey(arg_3_0)
	return "ServerNotice" .. arg_3_0.id
end

return var_0_0
