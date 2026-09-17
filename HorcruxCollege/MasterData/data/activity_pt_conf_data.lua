local var_0_0 = {}

for iter_0_0, iter_0_1 in pairs({
	"data.activity_pt.activity_pt_conf_basic_data"
}) do
	table.merge(var_0_0, (require(iter_0_1)))
end

setmetatable(var_0_0, {
	__index = function(arg_1_0, arg_1_1)
		if arg_1_1 then
			print("activity_pt_conf_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
