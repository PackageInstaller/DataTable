local MetaPTDataRequestCommand = class("MetaPTDataRequestCommand", pm.SimpleCommand)

function MetaPTDataRequestCommand:execute(arg_1_1)
	local var_1_0 = getProxy(MetaCharacterProxy)
	local var_1_1 = {}

	if arg_1_1:getBody().isAll then
		for iter_1_0, iter_1_1 in ipairs((var_1_0:getMetaProgressVOList())) do
			if iter_1_1:isPtType() and (iter_1_1:isInAct() or iter_1_1:isInArchive()) then
				table.insert(var_1_1, iter_1_1.id)
			end
		end
	end

	print("34001 meta pt request:", table.concat(var_1_1, ","))
	pg.ConnectionMgr.GetInstance():Send(34001, {
		group_id = var_1_1
	}, 34002, function(arg_2_0)
		print("34002 meta pt request done:", #var_1_1)
		var_1_0:setAllProgressPTData(arg_2_0.meta_ship_list)

		return
	end)

	return
end

return MetaPTDataRequestCommand
