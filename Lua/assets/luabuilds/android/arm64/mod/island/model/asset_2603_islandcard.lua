local IslandCard = class("IslandCard")

IslandCard.PHOTO_TYPE_ID = 1
IslandCard.PHOTO_TYPE_ADDRESS = 2

function IslandCard:Ctor(arg_1_1, arg_1_2)
	self.userId = arg_1_1
	self.name = arg_1_2.name
	self.photoStr = arg_1_2.picture

	if self.photoStr == "" then
		self.photoStr = tostring(pg.island_set.island_card_photo_default.key_value_int)
	end

	self.word = arg_1_2.visit_word

	if self.word == "" then
		self.word = i18n("island_card_default_word")
	end

	self.level = arg_1_2.lv
	self.socialFlag = arg_1_2.social_flag
	self.labelFlag = arg_1_2.label_view_flag
	self.labelData = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2.label_list or {}) do
		self.labelData[iter_1_1.id] = iter_1_1.num
	end

	self.achvList = arg_1_2.achieve_list or {}
	self.achvCnt = arg_1_2.achieve_num
	self.visitCnt = arg_1_2.visit_num
	self.likeCnt = arg_1_2.good_num
	self.shipCnt = arg_1_2.ship_num
	self.bookCnt = arg_1_2.book_num
	self.likeMark = arg_1_2.good_flag == 1
	self.labelMark = arg_1_2.label_flag == 1
	self.whiteMark = arg_1_2.white_flag == 1
	self.blackMark = arg_1_2.black_flag == 1

	return
end

function IslandCard:ShowLabel()
	return self.labelFlag == 1
end

function IslandCard:GetLabelList()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(self.labelData) do
		table.insert(var_3_0, {
			id = iter_3_0,
			num = iter_3_1
		})
	end

	return var_3_0
end

function IslandCard:AddLabel(arg_4_1)
	self.labelData[arg_4_1] = (self.labelData[arg_4_1] or 0) + 1

	return
end

function IslandCard:ShowSocial()
	return self.socialFlag == 1
end

return IslandCard
