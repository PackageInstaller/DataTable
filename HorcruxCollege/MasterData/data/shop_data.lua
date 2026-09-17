local var_0_0 = {}
local var_0_1 = {
	"data.shop.shop_171_data",
	"data.shop.shop_195_data",
	"data.shop.shop_199_data",
	"data.shop.shop_1_data",
	"data.shop.shop_2024zq_data",
	"data.shop.shop_207_data",
	"data.shop.shop_217_data",
	"data.shop.shop_225_data",
	"data.shop.shop_227_data",
	"data.shop.shop_228_data",
	"data.shop.shop_232_data",
	"data.shop.shop_238_data",
	"data.shop.shop_248_data",
	"data.shop.shop_252_data",
	"data.shop.shop_275_data",
	"data.shop.shop_30day_data",
	"data.shop.shop_68_data",
	"data.shop.shop_70_data",
	"data.shop.shop_71_data",
	"data.shop.shop_72_data",
	"data.shop.shop_730_data",
	"data.shop.shop_731_data",
	"data.shop.shop_73_data",
	"data.shop.shop_745_data",
	"data.shop.shop_74_data",
	"data.shop.shop_755_data",
	"data.shop.shop_758_data",
	"data.shop.shop_766_data",
	"data.shop.shop_767_data",
	"data.shop.shop_775_data",
	"data.shop.shop_776_data",
	"data.shop.shop_787_data",
	"data.shop.shop_792_data",
	"data.shop.shop_805_data",
	"data.shop.shop_806_data",
	"data.shop.shop_811_data",
	"data.shop.shop_813_data",
	"data.shop.shop_830_data",
	"data.shop.shop_837_data",
	"data.shop.shop_838_data",
	"data.shop.shop_83_data",
	"data.shop.shop_846_data",
	"data.shop.shop_84_data",
	"data.shop.shop_855_data",
	"data.shop.shop_85_data",
	"data.shop.shop_861_data",
	"data.shop.shop_865_data",
	"data.shop.shop_866_data",
	"data.shop.shop_868_data",
	"data.shop.shop_869_data",
	"data.shop.shop_872_data",
	"data.shop.shop_876_data",
	"data.shop.shop_881_data",
	"data.shop.shop_887_data",
	"data.shop.shop_888_data",
	"data.shop.shop_891_data",
	"data.shop.shop_892_data",
	"data.shop.shop_894_data",
	"data.shop.shop_896_data",
	"data.shop.shop_897_data",
	"data.shop.shop_PVE_data",
	"data.shop.shop_awl_data",
	"data.shop.shop_basic_birthday_data",
	"data.shop.shop_basic_data",
	"data.shop.shop_bianhua_data",
	"data.shop.shop_christmas148_data",
	"data.shop.shop_clothes_add_data",
	"data.shop.shop_clothes_data",
	"data.shop.shop_double11_data",
	"data.shop.shop_family_data",
	"data.shop.shop_favor_data",
	"data.shop.shop_furniture_data",
	"data.shop.shop_gift_data",
	"data.shop.shop_guanggunZZ_data",
	"data.shop.shop_helloweenZZ_data",
	"data.shop.shop_helloween_data",
	"data.shop.shop_hk_data",
	"data.shop.shop_jinxiu2_data",
	"data.shop.shop_jjc_data",
	"data.shop.shop_lamia_data",
	"data.shop.shop_marry4_data",
	"data.shop.shop_marry_data",
	"data.shop.shop_monopoly_data",
	"data.shop.shop_old_sub_data",
	"data.shop.shop_overclock_data",
	"data.shop.shop_question_pt_data",
	"data.shop.shop_saya_180_data",
	"data.shop.shop_skintwist_data",
	"data.shop.shop_spring154_data",
	"data.shop.shop_spring_festival_data",
	"data.shop.shop_stable_173_data",
	"data.shop.shop_suzuran_182_data",
	"data.shop.shop_talk_data",
	"data.shop.shop_teacher2021_data",
	"data.shop.shop_tft_data",
	"data.shop.shop_twistmarry_data",
	"data.shop.shop_yuandancount157_data",
	"data.shop.shop_yuanxiao_156_data",
	"data.shop.shop_zhounian_data",
	"data.umaru.shop_umaru_data"
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
			print("shop_data id is nil: " .. arg_1_1)
		end

		return nil
	end
})

return var_0_0
