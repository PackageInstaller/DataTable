StageArchiveView = import("game.views.stageArchive.StageArchiveView")

local ChapterStageArchiveInfoView = class("ChapterStageArchiveInfoView", StageArchiveView)

function ChapterStageArchiveInfoView:UIName()
	return "Widget/System/Operation/OperationDiaryUI"
end

return ChapterStageArchiveInfoView
