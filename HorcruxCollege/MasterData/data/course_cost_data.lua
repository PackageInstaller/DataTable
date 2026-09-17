local var_0_0 = {}
local var_0_1 = {
	"data.course.course_an_cost_data",
	"data.course.course_basic_cost_data",
	"data.course.course_devil_cost_data",
	"data.course.course_dianci_cost_data",
	"data.course.course_guang_cost_data",
	"data.course.course_imaginary_cost_data",
	"data.course.course_liangzi_cost_data",
	"data.course.course_mimicry_cost_data",
	"data.course.course_other_cost_data",
	"data.course.course_positive_cost_data",
	"data.course.course_reneng_cost_data"
}

if DeviceManager.platform == "windows" then
	local var_0_2 = {}

	for iter_0_0, iter_0_1 in ipairs(var_0_1) do
		for iter_0_2, iter_0_3 in pairs((require(iter_0_1))) do
			if var_0_2[iter_0_2] then
				error(iter_0_2 .. " is conflict between " .. var_0_2[iter_0_2] .. " and " .. iter_0_1 .. ", 快叫凯达去改表")
			else
				var_0_2[iter_0_2] = iter_0_1
			end
		end
	end
end

for iter_0_4, iter_0_5 in pairs(var_0_1) do
	table.merge(var_0_0, (require(iter_0_5)))
end

setmetatable(var_0_0, {
	__index = function(arg_1_0, arg_1_1)
		if arg_1_1 then
			print("course_cost_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
