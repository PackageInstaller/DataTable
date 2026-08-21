local var_0_0 = class("IslandCard")

var_0_0.PHOTO_TYPE_ID = 1
var_0_0.PHOTO_TYPE_ADDRESS = 2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.userId = arg_1_1
	arg_1_0.name = arg_1_2.name
	arg_1_0.photoStr = arg_1_2.picture

	if arg_1_0.photoStr == "" then
		arg_1_0.photoStr = tostring(pg.island_set.island_card_photo_default.key_value_int)
	end

	arg_1_0.word = arg_1_2.visit_word

	if arg_1_0.word == "" then
		arg_1_0.word = i18n("island_card_default_word")
	end

	arg_1_0.level = arg_1_2.lv
	arg_1_0.socialFlag = arg_1_2.social_flag
	arg_1_0.labelFlag = arg_1_2.label_view_flag
	arg_1_0.labelData = {}

	local var_1_0 = arg_1_2.label_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0.labelData[iter_1_1.id] = iter_1_1.num
	end

	arg_1_0.achvList = arg_1_2.achieve_list or {}
	arg_1_0.achvCnt = arg_1_2.achieve_num
	arg_1_0.visitCnt = arg_1_2.visit_num
	arg_1_0.likeCnt = arg_1_2.good_num
	arg_1_0.shipCnt = arg_1_2.ship_num
	arg_1_0.bookCnt = arg_1_2.book_num
	arg_1_0.likeMark = arg_1_2.good_flag == 1
	arg_1_0.labelMark = arg_1_2.label_flag == 1
	arg_1_0.whiteMark = arg_1_2.white_flag == 1
	arg_1_0.blackMark = arg_1_2.black_flag == 1

	return
end

function var_0_0.ShowLabel(arg_2_0)
	return arg_2_0.labelFlag == 1
end

function var_0_0.GetLabelList(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.labelData) do
		table.insert({}, {
			id = iter_3_0,
			num = iter_3_1
		})
	end

	return {}
end

function var_0_0.AddLabel(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.labelData[arg_4_1] or 0

	arg_4_0.labelData[arg_4_1] = var_4_0 + 1

	return
end

function var_0_0.ShowSocial(arg_5_0)
	return arg_5_0.socialFlag == 1
end

return var_0_0
