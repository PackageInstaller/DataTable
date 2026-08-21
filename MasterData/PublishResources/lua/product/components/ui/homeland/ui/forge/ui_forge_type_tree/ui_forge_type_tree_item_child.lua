_class("UIForgeTypeTreeItemChild", UICustomWidget)
UIForgeTypeTreeItemChild = UIForgeTypeTreeItemChild

function UIForgeTypeTreeItemChild:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.data = self.mHomeland:GetForgeData()
end

function UIForgeTypeTreeItemChild:OnShow()
  self.bg = self:GetUIComponent("Image", "bg")
  self.txt = self:GetUIComponent("UILocalizationText", "txt")
  self.atlas = self:GetAsset("UIHomelandBuildInfo.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.HomelandForgeFoldFilterChild, self.FoldFilter)
end

function UIForgeTypeTreeItemChild:OnHide()
  self:DetachEvent(GameEventType.HomelandForgeFoldFilterChild, self.FoldFilter)
end

function UIForgeTypeTreeItemChild:Init(id, idChild)
  self.id = id
  self.idChild = idChild
  local f = self.data:GetForgeFilterById(id)
  local c = f:GetChildById(idChild)
  self.txt:SetText(c.name)
end

function UIForgeTypeTreeItemChild:FoldFilter(idChild)
  local bgSprite = ""
  local f = self.data:GetForgeFilterById(self.id)
  if idChild == self.idChild then
    bgSprite = "N17_produce_btn_classify_4"
  else
    bgSprite = "N17_produce_btn_classify_3"
  end
  self.bg.sprite = self.atlas:GetSprite(bgSprite)
end

function UIForgeTypeTreeItemChild:bgOnClick(go)
  self.data.filter = self.idChild
  self.data:FilterList()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideListSequence, true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeUpdateList)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandForgeFoldFilterChild, self.idChild)
end
