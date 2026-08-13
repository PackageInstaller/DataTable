local var_0_0 = {}

MangaConst = MangaConst
var_0.Version = 0
var_0.NewCount = 0

function var_0.setVersionAndNewCount()
	pg = var_1_10000

	local var_1_0 = #var_1_10000.cartoon.all

	pg = var_1_10001

	local var_1_1 = var_1_10001.cartoon.all[var_1_0]
	local var_1_2 = var_0

	pg = var_1_10003
	var_1_2.Version = var_1_10003.cartoon[var_1_1].mark

	local var_1_3 = 0

	for iter_1_0 = var_1_0, 1, -1 do
		pg = var_1_10007
		var_1_10007 = var_1_10007.cartoon.all[iter_1_0]
		pg = var_1_10008

		if var_1_10008.cartoon[var_1_10007].mark == var_0.Version then
			var_1_3 = var_1_3 + 1
		elseif var_1_10008 < var_0.Version then
			break
		end
	end

	var_0.NewCount = var_1_3

	return
end

var_0.MANGA_PATH_PREFIX = "mangapic/"
var_0.SET_MANGA_LIKE = 0
var_0.CANCEL_MANGA_LIKE = 1

function var_0.isMangaEverReadByID(arg_2_0)
	getProxy = var_1_10001
	AppreciateProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getMangaReadIDList(var_2_0)

	table = var_1_10003

	return var_1_10003.contains(var_2_1, arg_2_0)
end

function var_0.isMangaNewByID(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.cartoon[arg_3_0]

	assert = var_1_10002

	local var_3_1 = var_3_0
	local var_3_2 = "Manga info is null, ID:"

	tostring = var_1_10006

	var_1_10002(var_3_1, var_3_2 .. var_1_10006(arg_3_0))

	return var_3_0.mark >= var_0.Version
end

function var_0.isMangaLikeByID(arg_4_0)
	getProxy = var_1_10001
	AppreciateProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)
	local var_4_1 = var_1.getMangaLikeIDList(var_4_0)

	table = var_1_10002

	return var_1_10002.contains(var_4_1, arg_4_0)
end

function var_0.GetMangaPicPathByID(arg_5_0)
	pg = var_1_10001

	if not var_1_10001.cartoon[arg_5_0] then
		return nil
	end

	local var_5_0 = var_1.resource

	return var_0.MANGA_PATH_PREFIX .. var_5_0
end

return var_0
