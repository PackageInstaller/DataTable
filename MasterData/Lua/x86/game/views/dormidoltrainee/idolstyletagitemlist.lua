local IdolStyleTagItemList = class("IdolStyleTagItemList", BaseView)

function IdolStyleTagItemList:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function IdolStyleTagItemList:Init()
	self:BindCfgUI()

	self.styleUIList = {}

	for iter_2_0, iter_2_1 in pairs(IdolTraineeConst.style) do
		local var_2_0 = EnterBattleStyleListItem.New((Object.Instantiate(self.styleTag_, self.styleTagListContent_)))

		var_2_0:SetData(iter_2_0)

		self.styleUIList[iter_2_0] = var_2_0
	end
end

function IdolStyleTagItemList:SetData(arg_3_1)
	for iter_3_0, iter_3_1 in pairs(self.styleUIList) do
		SetActive(iter_3_1.gameObject_, false)
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_1) do
		if self.styleUIList[iter_3_3] then
			SetActive(self.styleUIList[iter_3_3].gameObject_, true)
		end
	end
end

function IdolStyleTagItemList:Dispose()
	for iter_4_0, iter_4_1 in pairs(self.styleUIList) do
		iter_4_1:Dispose()
	end

	self.styleUIList = nil
end

return IdolStyleTagItemList
