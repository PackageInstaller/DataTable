local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions
local WorldStageAwardItem, Super = System.NewComponent("WorldStageAwardItem")

function WorldStageAwardItem:ctor(uiNode, data)
  Super.ctor(self)
  self.ui = UI_Dbgcopy_Item_Select_RewardResource(uiNode)
  self.tid = data.tid
  self.num = data.num
  self.itemType = data.itemType
  self.textNameFunc = data.textNameFunc
  self.textDescFunc = data.textDescFunc
end

function WorldStageAwardItem:OnBind(binder)
  binder:BindToText(self.ui.Text_Creation_Name, self.textNameFunc)
  binder:BindToText(self.ui.Text_Desc, self.textDescFunc)
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Desc, 0)
  if comp then
    local cfg_init = {
      fontSize = 32,
      autoSizeCN = false,
      autoSizeOther = false,
      alignmentCN = TextAlignmentOptions.TopLeft,
      alignmentOther = TextAlignmentOptions.TopLeft,
      widthCN = 300,
      widthOther = 300,
      height = 600,
      x = 0,
      y = 0,
      pivotX = 0,
      pivotY = 1,
      anchorX = 0,
      anchorY = 1
    }
    local cfg_adaption = {
      fontSize = 32,
      autoSizeCN = false,
      autoSizeOther = false,
      alignmentCN = TextAlignmentOptions.TopLeft,
      alignmentOther = TextAlignmentOptions.TopLeft,
      widthCN = 300,
      widthOther = 300,
      height = 600,
      x = 0,
      y = 0,
      pivotX = 0,
      pivotY = 1,
      anchorX = 0,
      anchorY = 1,
      contentSize = 180
    }
    comp:ForceUpdate({
      limitPercent = 1,
      lineLimit = 4,
      miniFontSize = 32,
      maxFontSize = 32,
      initCfg = cfg_init,
      adaptionCfg = cfg_adaption
    })
  end
  local itemData = {
    itemTid = self.tid,
    showText = self.num,
    ifShowAppr = true,
    ifShowDesc = true,
    itemType = self.itemType
  }
  binder:BindComponent(ItemPublicArticleCommon(self.ui.Group_Article, itemData))
end

return WorldStageAwardItem
