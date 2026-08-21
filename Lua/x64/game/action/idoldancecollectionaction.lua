local var_0_0 = {}

manager.net:Bind(58203, function(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.collection_list) do
		if iter_1_1.type == 2 then
			IdolDanceCollectionData:InitFromServer(iter_1_1.viewed_id_list)
		end
	end
end)

function var_0_0.ViewCollectionRecord(arg_2_0)
	if not IdolDanceCollectionData:IsCollectionRecordViewed(arg_2_0) then
		manager.net:Push(58196, {
			type = 2,
			id = arg_2_0
		})
		IdolDanceCollectionData:MarkCollectionRecordAsViewed(arg_2_0)
		manager.notify:Invoke("IDOL_DANCE_COLLECTION_VIEWED", arg_2_0)
	end
end

return var_0_0
