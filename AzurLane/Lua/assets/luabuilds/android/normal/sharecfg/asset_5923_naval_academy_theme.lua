pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "naval_academy_theme") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "naval_academy_theme"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.naval_academy_theme = var_0_2
pg = var_0
pg = var_0_2

local var_0_3

if not var_0_2.base then
	var_0_3 = {}
end

var_0.base = var_0_3
pg = var_0
var_0.base.naval_academy_theme = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.naval_academy_theme

	var_1_0.spring = {
		theme_name = "spring",
		resource_path = "NavalAcademySpringUI"
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.naval_academy_theme

	var_1_1.summer = {
		theme_name = "summer",
		resource_path = "NavalAcademySummerUI"
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.naval_academy_theme

	var_1_2.autumn = {
		theme_name = "autumn",
		resource_path = "NavalAcademyAutumnUI"
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.naval_academy_theme

	var_1_3.winter = {
		theme_name = "winter",
		resource_path = "NavalAcademyWinterUI"
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.naval_academy_theme

	var_1_4.christmas = {
		theme_name = "christmas",
		resource_path = "NavalAcademyChristmasUI"
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.naval_academy_theme

	var_1_5.newyear = {
		theme_name = "newyear",
		resource_path = "NavalAcademyNewYearUI"
	}
	pg = var_1_5
	var_1_5.base.naval_academy_theme.springfes = {
		theme_name = "springfes",
		resource_path = "NavalAcademySpringFesUI"
	}

	return
end)()

return
