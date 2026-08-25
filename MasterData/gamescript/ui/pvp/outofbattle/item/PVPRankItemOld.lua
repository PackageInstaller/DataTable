local rankCfgs = {}
for _, cfg in pairs(DT.PVPRank) do
  table.insert(rankCfgs, cfg)
end
table.sort(rankCfgs, function(a, b)
  return a.BaseSortID < b.BaseSortID
end)
local PVPRankItem, Super = System.NewComponent("PVPRankItem")

function PVPRankItem:ctor(obj, data)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_ListResource(obj)
  self.data = data
end

function PVPRankItem:OnBind(binder)
  binder:SetText(self.ui.Text_Ranking, self.data.rankIdx)
  local headRes = ItemDataUtils.GetAvatarIcon(self.data.icon)
  binder:SetImage(self.ui.Image_Avatar, headRes)
  binder:SetText(self.ui.Text_Name, self.data.name)
  binder:SetText(self.ui.Text_Uid, self.data.uid)
  local rankCfg
  for _, cfg in ipairs(rankCfgs) do
    if cfg.ScoreRequired <= self.data.score then
      rankCfg = cfg
    end
  end
  binder:SetImage(self.ui.Image_Icon, rankCfg.Icon)
  binder:SetImage(self.ui.Image_Grade, CommonDefine.PVPRankStageIcon[rankCfg.Stage])
  binder:SetText(self.ui.Text_Level, LT.Text(rankCfg.Name))
  if rankCfg.ID == CommonDefine.HighestPVPRank.ID then
    self.ui.Image_Hoist:SetActive(true)
    local numStars = self.data.score - rankCfg.ScoreRequired + 1
    binder:SetText(self.ui.Text_Star, numStars)
  else
    self.ui.Image_Hoist:SetActive(false)
  end
  binder:BindButtonClick(self.ui.Button_Head, System.fn(self, self._OnClick))
end

function PVPRankItem:_OnClick()
  SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, self.data.uid)
end

return PVPRankItem
