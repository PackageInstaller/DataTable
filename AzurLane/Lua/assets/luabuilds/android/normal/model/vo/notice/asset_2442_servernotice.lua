class = var_0_10000

local var_0_0 = "ServerNotice"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Notice"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.version = arg_1_1.version
	arg_1_0.btnTitle = arg_1_1.btn_title
	arg_1_0.titleImage = arg_1_1.title_image
	arg_1_0.timeDes = arg_1_1.time_desc
	arg_1_0.type = arg_1_1.tag_type
	arg_1_0.icon = arg_1_1.icon
	arg_1_0.track = arg_1_1.track
	arg_1_0.priority = arg_1_1.priority
	arg_1_0.need_level = arg_1_1.need_level
	string = var_2

	if #var_2.split(arg_1_0.title, "&") > 1 then
		arg_1_0.title = var_2[1]
		arg_1_0.pageTitle = var_2[2]
	else
		arg_1_0.title = var_2[1]
		arg_1_0.pageTitle = var_2[1]
	end

	string = var_3

	if var_3.match(arg_1_0.titleImage, "<config.*/>") then
		tonumber = var_4
		string = var_5

		local var_1_0

		if not var_4(var_5.match(var_3, "type%s*=%s*(%d+)")) then
			var_1_0 = nil
		end

		arg_1_0.paramType = var_1_0

		if arg_1_0.paramType then
			if arg_1_0.paramType == 1 then
				string = var_1_1
				arg_1_0.param = var_1_1.match(var_3, "param%s*=%s*'(.*)'")

				goto label_1_0
			end

			if arg_1_0.paramType == 2 then
				string = var_1_1
				arg_1_0.param = var_1_1.match(var_3, "param%s*=%s*'(.*)'")

				goto label_1_0
			end

			if arg_1_0.paramType == 3 then
				string = var_1_1
				arg_1_0.param = var_1_1.match(var_3, "param%s*=%s*(%d+)")

				if arg_1_0.param then
					tonumber = var_1_1

					local var_1_1

					if not var_1_1(arg_1_0.param) then
						var_1_1 = arg_1_0.param
					end

					arg_1_0.param = var_1_1

					goto label_1_0

					if arg_1_0.paramType == 4 then
						string = var_1_1
						arg_1_0.param = var_1_1.match(var_3, "param%s*=%s*(%d+)")

						if arg_1_0.param then
							tonumber = var_1_1

							if not var_1_1(arg_1_0.param) then
								var_1_1 = arg_1_0.param
							end

							arg_1_0.param = var_1_1

							::label_1_0::

							if var_3 then
								string = var_1_1

								local var_1_2, var_1_3 = var_1_1.find(arg_1_0.titleImage, var_3, 1, true)

								string = var_6
								arg_1_0.titleImage = var_6.sub(arg_1_0.titleImage, var_1_3 + 1, -1)
							end

							arg_1_0.code = arg_1_0:prefKey()

							return
						end
					end
				end
			end
		end
	end
end

function var_0_1.ShouldShow(arg_2_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)

	return var_1.getRawData(var_2_0).level > arg_2_0.need_level
end

function var_0_1.prefKey(arg_3_0)
	return "ServerNotice" .. arg_3_0.id
end

return var_0_1
