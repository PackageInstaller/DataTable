SubPlotSectionView = import("game.views.sectionSelect.subPlot.SubPlotSectionView")

local SubPlotLinKage_4_2View = class("SubPlotLinKage_4_2View", SubPlotSectionView)

function SubPlotLinKage_4_2View:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Plot/V4_2_GodEaterUI_StageUI"
end

function SubPlotLinKage_4_2View:GetItemClass()
	return SubPlotSectionItem
end

function SubPlotLinKage_4_2View:Init()
	SubPlotLinKage_4_2View.super.Init(self)
end

function SubPlotLinKage_4_2View:OnEnter()
	SubPlotLinKage_4_2View.super.OnEnter(self)
end

function SubPlotLinKage_4_2View:OnExit()
	SubPlotLinKage_4_2View.super.OnExit(self)
end

function SubPlotLinKage_4_2View:RefreshUI()
	SubPlotLinKage_4_2View.super.RefreshUI(self)
end

function SubPlotLinKage_4_2View:Dispose()
	SubPlotLinKage_4_2View.super.Dispose(self)
end

return SubPlotLinKage_4_2View
