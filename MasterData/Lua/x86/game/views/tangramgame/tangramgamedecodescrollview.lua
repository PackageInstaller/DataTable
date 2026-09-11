local TangramGameDecodeScrollView = class("TangramGameDecodeScrollView", ReduxView)

function TangramGameDecodeScrollView:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterID = arg_1_2
	self.stageID = ActivityTangramGameChapterCfg[arg_1_2].inference_stage_list[1]
	self.mainPage = arg_1_3

	self:Init()
end

function TangramGameDecodeScrollView:Init()
	self:InitUI()

	self.stageItemList = {}

	for iter_2_0 = 1, #ActivityTangramGameStageCfg[self.stageID].ori_pos do
		self.stageItemList[iter_2_0] = TangramGameBigStageItem.New(self["stageitem" .. iter_2_0 .. "Go_"], ActivityTangramGameStageCfg[self.stageID].ori_pos[iter_2_0], self.stageID, self.mainPage)
	end
end

function TangramGameDecodeScrollView:InitUI()
	self:BindCfgUI()
end

function TangramGameDecodeScrollView:RefreshView(arg_4_1)
	if self.stageItemList then
		for iter_4_0, iter_4_1 in pairs(self.stageItemList) do
			iter_4_1:RefreshView(arg_4_1)
		end
	end
end

function TangramGameDecodeScrollView:Dispose()
	for iter_5_0, iter_5_1 in pairs(self.stageItemList) do
		iter_5_1:Dispose()
	end

	TangramGameDecodeScrollView.super.Dispose(self)
end

return TangramGameDecodeScrollView
