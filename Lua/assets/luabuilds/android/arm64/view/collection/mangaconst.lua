MangaConst = {}

local var_0_0 = MangaConst

MangaConst.Version = 0
MangaConst.NewCount = 0

function MangaConst.setVersionAndNewCount()
	var_0_0.Version = pg.cartoon[pg.cartoon.all[#pg.cartoon.all]].mark

	local var_1_0 = 0

	for iter_1_0 = #pg.cartoon.all, 1, -1 do
		if pg.cartoon[pg.cartoon.all[iter_1_0]].mark == var_0_0.Version then
			var_1_0 = var_1_0 + 1
		elseif pg.cartoon[pg.cartoon.all[iter_1_0]].mark < var_0_0.Version then
			break
		end
	end

	var_0_0.NewCount = var_1_0

	return
end

MangaConst.MANGA_PATH_PREFIX = "mangapic/"
MangaConst.SET_MANGA_LIKE = 0
MangaConst.CANCEL_MANGA_LIKE = 1

function MangaConst.isMangaEverReadByID(arg_2_0)
	return table.contains(getProxy(AppreciateProxy):getMangaReadIDList(), arg_2_0)
end

function MangaConst.isMangaNewByID(arg_3_0)
	local var_3_0 = pg.cartoon[arg_3_0]

	assert(pg.cartoon[arg_3_0], "Manga info is null, ID:" .. tostring(arg_3_0))

	return var_3_0.mark >= var_0_0.Version
end

function MangaConst.isMangaLikeByID(arg_4_0)
	return table.contains(getProxy(AppreciateProxy):getMangaLikeIDList(), arg_4_0)
end

function MangaConst.GetMangaPicPathByID(arg_5_0)
	if not pg.cartoon[arg_5_0] then
		return nil
	end

	return var_0_0.MANGA_PATH_PREFIX .. pg.cartoon[arg_5_0].resource
end

return MangaConst
