local UIComDungeonsDivingTitle, Super = NewViewComponent("UIComDungeonsDivingTitle")
UIComDungeonsDivingTitle.uiResCls = "UI/UI_Dungeous/UI_Dungeous_Prefab/UI_Dungeons_Item_DivingTitle.prefab"
local DEFAULT_WIDTH = 200
local EXPAND_WIDTH = 6

function UIComDungeonsDivingTitle:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UIUtils.GetUIByUINode(uiNode)
  self.obj = uiNode
  self.data = data
  self.realWidth = data.width or 0
end

function UIComDungeonsDivingTitle:OnEnterComponent()
  if self.data.width then
    self.ui.TitleView.transform.sizeDelta = CS.UnityEngine.Vector2(self.data.width, self.ui.TitleView.transform.sizeDelta.y)
  end
  if self.data.rankId then
    self:InitByRankId()
  else
    self:InitByTitleData()
  end
end

function UIComDungeonsDivingTitle:InitByRankId()
  local rankCfg = DT.Rank[self.data.rankId]
  local titleText = rankCfg and LT.Text(rankCfg.Name) or "-"
  if "" == titleText then
    titleText = "-"
  end
  self.binder:UpdateLocalizedTextAndResouce(self.obj)
  self:SetActive(self.obj, true)
  self:SetActive(self.ui.TitleView, false)
  self:SetActive(self.ui.Text_Title, true)
  self.ui.TitleView.transform.sizeDelta = CS.UnityEngine.Vector2(self.data.width or DEFAULT_WIDTH, self.ui.TitleView.transform.sizeDelta.y)
  self:SetActive(self.ui.Image_Frame, "-" ~= titleText)
  self:SetText(self.ui.Text_Title, titleText)
  local width = StrUtils.SetPreferredWidth(self.ui.Text_Title)
  if width > (self.data.width or DEFAULT_WIDTH) then
    self:SetActive(self.ui.Text_Title, false)
    self:SetActive(self.ui.TitleView, true)
    self:SetText(self.ui.Text_View_Title, titleText)
    AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_View_Title)
    width = self.data.width or DEFAULT_WIDTH
  end
  self:SetImage(self.ui.Group_Title, "-" ~= titleText and rankCfg and rankCfg.RankIcon)
  ColorUtils.SetRankTitleColor(self.binder, rankCfg and rankCfg.RankIcon, self.ui.Text_Title, self.ui.Text_View_Title)
  self.realWidth = width
  self.ui.Group_Title.transform.sizeDelta = CS.UnityEngine.Vector2(width + EXPAND_WIDTH, self.ui.Group_Title.transform.sizeDelta.y)
end

function UIComDungeonsDivingTitle:InitByTitleData()
  local titleText = self.data.titleText or "-"
  if "" == titleText then
    titleText = "-"
  end
  self.binder:UpdateLocalizedTextAndResouce(self.obj)
  self:SetActive(self.obj, true)
  self:SetActive(self.ui.TitleView, false)
  self:SetActive(self.ui.Text_Title, true)
  self.ui.TitleView.transform.sizeDelta = CS.UnityEngine.Vector2(self.data.width or DEFAULT_WIDTH, self.ui.TitleView.transform.sizeDelta.y)
  self:SetActive(self.ui.Image_Frame, "-" ~= titleText)
  self:SetText(self.ui.Text_Title, titleText)
  local width = StrUtils.SetPreferredWidth(self.ui.Text_Title)
  if width > (self.data.width or DEFAULT_WIDTH) then
    self:SetActive(self.ui.Text_Title, false)
    self:SetActive(self.ui.TitleView, true)
    self:SetText(self.ui.Text_View_Title, titleText)
    AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_View_Title)
    width = self.data.width or DEFAULT_WIDTH
  end
  self:SetImage(self.ui.Group_Title, "-" ~= titleText and self.data.titleIcon)
  ColorUtils.SetRankTitleColor(self.binder, self.data.titleIcon, self.ui.Text_Title, self.ui.Text_View_Title)
  self.realWidth = width
  self.ui.Group_Title.transform.sizeDelta = CS.UnityEngine.Vector2(width + EXPAND_WIDTH, self.ui.Group_Title.transform.sizeDelta.y)
end

function UIComDungeonsDivingTitle:BindByRankId(binder, uiNode, data)
  local rankCfg = DT.Rank[data.rankId]
  local titleUI = UIUtils.GetUIByUINode(uiNode)
  binder:UpdateLocalizedTextAndResouce(uiNode.gameObject)
  binder:SetActive(uiNode, true)
  binder:SetActive(titleUI.TitleView, false)
  binder:SetActive(titleUI.Text_Title, true)
  local titleText = rankCfg and LT.Text(rankCfg.Name) or "-"
  if "" == titleText then
    titleText = "-"
  end
  binder:SetActive(titleUI.Image_Frame, "-" ~= titleText)
  binder:SetText(titleUI.Text_Title, titleText)
  local width = StrUtils.SetPreferredWidth(titleUI.Text_Title)
  if width > (data.width or DEFAULT_WIDTH) then
    titleUI.TitleView.transform.sizeDelta = CS.UnityEngine.Vector2(data.width or DEFAULT_WIDTH, titleUI.TitleView.transform.sizeDelta.y)
    binder:SetActive(titleUI.Text_Title, false)
    binder:SetActive(titleUI.TitleView, true)
    binder:SetText(titleUI.Text_View_Title, titleText)
    AutoAdaptionText.StartAutoAdaptionText(titleUI.Text_View_Title)
    width = self.data.width or DEFAULT_WIDTH
  end
  binder:SetImage(titleUI.Group_Title, "-" ~= titleText and rankCfg and rankCfg.RankIcon)
  ColorUtils.SetRankTitleColor(binder, rankCfg and rankCfg.RankIcon, titleUI.Text_Title, titleUI.Text_View_Title)
  titleUI.Group_Title.transform.sizeDelta = CS.UnityEngine.Vector2(width + EXPAND_WIDTH, titleUI.Group_Title.transform.sizeDelta.y)
  return width
end

function UIComDungeonsDivingTitle.BindByTitleData(binder, uiNode, data)
  local titleUI = UIUtils.GetUIByUINode(uiNode)
  binder:UpdateLocalizedTextAndResouce(uiNode.gameObject)
  binder:SetActive(uiNode, true)
  binder:SetActive(titleUI.TitleView, false)
  binder:SetActive(titleUI.Text_Title, true)
  local titleText = data.titleText or "-"
  if "" == titleText then
    titleText = "-"
  end
  binder:SetActive(titleUI.Image_Frame, "-" ~= titleText)
  binder:SetText(titleUI.Text_Title, titleText)
  local width = StrUtils.SetPreferredWidth(titleUI.Text_Title)
  if width > (data.width or DEFAULT_WIDTH) then
    titleUI.TitleView.transform.sizeDelta = CS.UnityEngine.Vector2(data.width or DEFAULT_WIDTH, titleUI.TitleView.transform.sizeDelta.y)
    binder:SetActive(titleUI.Text_Title, false)
    binder:SetActive(titleUI.TitleView, true)
    binder:SetText(titleUI.Text_View_Title, titleText)
    AutoAdaptionText.StartAutoAdaptionText(titleUI.Text_View_Title)
    width = data.width or DEFAULT_WIDTH
  end
  binder:SetImage(titleUI.Group_Title, "-" ~= titleText and data.titleIcon)
  ColorUtils.SetRankTitleColor(binder, data.titleIcon, titleUI.Text_Title, titleUI.Text_View_Title)
  titleUI.Group_Title.transform.sizeDelta = CS.UnityEngine.Vector2(width + EXPAND_WIDTH, titleUI.Group_Title.transform.sizeDelta.y)
  return width
end

return UIComDungeonsDivingTitle
