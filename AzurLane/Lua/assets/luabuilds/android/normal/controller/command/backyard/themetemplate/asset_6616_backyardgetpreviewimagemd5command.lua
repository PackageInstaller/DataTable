class = var_0_10000

local var_0_0 = "BackYardGetPreviewImageMd5Command"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	DormProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.GetListByType(var_1_3, var_1_0)

	table = var_1_3

	if var_1_3.getCount(var_1_4) == 0 then
		if var_1_1 then
			var_1_1()
		end

		return
	end

	local var_1_5 = {}

	pairs = var_8

	for iter_1_0, iter_1_1 in var_8(var_1_4) do
		table = var_1_10013

		var_1_10013.insert(var_1_5, iter_1_1.id)
	end

	pg = var_8

	local var_1_6 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 19131, {
		id_list = var_1_5
	}, 19132, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.list) do
			var_2_0[iter_2_1.id] = iter_2_1.md5
		end

		pairs = var_2

		for iter_2_2, iter_2_3 in var_2(var_1_4) do
			if not var_2_0[iter_2_3.id] then
				local var_2_1 = arg_1_0

				var_7.DeleteByType(var_2_1, var_1_0, iter_2_3.id)
			else
				local var_2_2 = arg_1_0

				var_7.UpdateMd5ByType(var_2_2, var_1_0, iter_2_3.id, var_2_0[iter_2_3.id])
			end
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

function var_0_1.GetListByType(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	DormProxy = var_1_10003

	local var_3_0 = var_1_10002(var_1_10003)

	BackYardConst = var_1_10003

	if arg_3_1 == var_1_10003.THEME_TEMPLATE_TYPE_SHOP then
		return var_3_0:GetShopThemeTemplates()
	else
		BackYardConst = var_3

		if arg_3_1 == var_3.THEME_TEMPLATE_TYPE_COLLECTION then
			return var_3_0:GetCollectionThemeTemplates()
		end
	end

	assert = var_3

	var_3(false)

	return
end

function var_0_1.DeleteByType(arg_4_0, arg_4_1, arg_4_2)
	getProxy = var_1_10003
	DormProxy = var_1_10004

	local var_4_0 = var_1_10003(var_1_10004)

	BackYardConst = var_1_10004

	if arg_4_1 == var_1_10004.THEME_TEMPLATE_TYPE_SHOP then
		var_4_0:DeleteShopThemeTemplate(arg_4_2)
	else
		BackYardConst = var_4

		if arg_4_1 == var_4.THEME_TEMPLATE_TYPE_COLLECTION then
			var_4_0:DeleteCollectionThemeTemplate(arg_4_2)
		end
	end

	return
end

function var_0_1.UpdateMd5ByType(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	getProxy = var_1_10004
	DormProxy = var_1_10005

	local var_5_0 = var_1_10004(var_1_10005)
	local var_5_1

	BackYardConst = var_1_10006

	if arg_5_1 == var_1_10006.THEME_TEMPLATE_TYPE_SHOP then
		var_5_1 = var_5_0:GetShopThemeTemplateById(arg_5_2)
	else
		BackYardConst = var_6

		if arg_5_1 == var_6.THEME_TEMPLATE_TYPE_COLLECTION then
			var_5_1 = var_5_0:GetCollectionThemeTemplateById(arg_5_2)
		end
	end

	if var_5_1 then
		var_5_1:UpdateIconMd5(arg_5_3)
	end

	return
end

return var_0_1
