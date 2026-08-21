local var_0_0 = class("BackYardGetPreviewImageMd5Command", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(DormProxy)
	local var_1_3 = arg_1_0:GetListByType(var_1_0.type)

	if table.getCount(var_1_3) == 0 then
		if var_1_0.callback then
			var_1_0.callback()
		end

		return
	end

	local var_1_4 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_3) do
		table.insert(var_1_4, iter_1_1.id)
	end

	pg.ConnectionMgr.GetInstance():Send(19131, {
		id_list = var_1_4
	}, 19132, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.list) do
			({})[iter_2_1.id] = iter_2_1.md5
		end

		for iter_2_2, iter_2_3 in pairs(var_1_3) do
			if not ({})[iter_2_3.id] then
				arg_1_0:DeleteByType(var_0, iter_2_3.id)
			else
				arg_1_0:UpdateMd5ByType(var_0, iter_2_3.id, ({})[iter_2_3.id])
			end
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

function var_0_0.GetListByType(arg_3_0, arg_3_1)
	local var_3_0 = getProxy(DormProxy)

	if arg_3_1 == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		return var_3_0:GetShopThemeTemplates()
	elseif arg_3_1 == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		return var_3_0:GetCollectionThemeTemplates()
	end

	assert(false)

	return
end

function var_0_0.DeleteByType(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = getProxy(DormProxy)

	if arg_4_1 == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		var_4_0:DeleteShopThemeTemplate(arg_4_2)
	elseif arg_4_1 == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		var_4_0:DeleteCollectionThemeTemplate(arg_4_2)
	end

	return
end

function var_0_0.UpdateMd5ByType(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = getProxy(DormProxy)
	local var_5_1

	if arg_5_1 == BackYardConst.THEME_TEMPLATE_TYPE_SHOP then
		var_5_1 = var_5_0:GetShopThemeTemplateById(arg_5_2)
	elseif arg_5_1 == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		var_5_1 = var_5_0:GetCollectionThemeTemplateById(arg_5_2)
	end

	if var_5_1 then
		var_5_1:UpdateIconMd5(arg_5_3)
	end

	return
end

return var_0_0
