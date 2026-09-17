local var_0_0 = {}

for iter_0_0, iter_0_1 in pairs({
	"data.explore.room_tile_data1.lua",
	"data.explore.room_tile_data2.lua",
	"data.explore.room_tile_data3.lua",
	"data.explore.room_tile_data4.lua",
	"data.explore.room_tile_data5.lua",
	"data.explore.room_tile_data6.lua",
	"data.explore.room_tile_data7.lua",
	"data.explore.room_tile_data8.lua",
	"data.explore.room_tile_data9.lua",
	"data.explore.room_tile_data10.lua",
	"data.explore.room_tile_data11.lua",
	"data.explore.room_tile_data12.lua"
}) do
	table.merge(var_0_0, (require(iter_0_1)))
end

setmetatable(var_0_0, {
	__index = function(arg_1_0, arg_1_1)
		if arg_1_1 then
			print("room_tile_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
