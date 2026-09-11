local AutoChessScoreDetailItemView = class("AutoChessScoreDetailItemView", ReduxView)

function AutoChessScoreDetailItemView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function AutoChessScoreDetailItemView:Init()
	self:BindCfgUI()
end

function AutoChessScoreDetailItemView:SetData(arg_3_1)
	self.titleText_.text = AutoChessPVPScoreCfg[arg_3_1.id].title
	self.scoreText_.text = arg_3_1.score
	self.icon_.sprite = getSprite("Atlas/Activity_OsirisHorusAtlas", AutoChessPVPScoreCfg[arg_3_1.id].icon)
end

function AutoChessScoreDetailItemView:SetActive(arg_4_1)
	SetActive(self.gameObject_, arg_4_1)
end

return AutoChessScoreDetailItemView
