local EmojiGroup_Com, Super = NewViewComponent("EmojiGroup_Com")

function EmojiGroup_Com:ctor(uiNode, view, groupData, clickFunc)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Pvp_Item_Expression_ManageResource(uiNode)
  self.title = groupData.title
  self.datalist = groupData.emojiList
  self.clickFunc = clickFunc
end

function EmojiGroup_Com:RegisterNotifications()
end

function EmojiGroup_Com:OnEnterComponent()
  self:InitObj()
  self:InitCell()
  self:SetTitle()
end

function EmojiGroup_Com:UpdateShow()
  for _, com in ipairs(self.coms) do
    com:UpdateShow()
  end
end

function EmojiGroup_Com:SetTitle()
  self:SetText(self.ui.Text_Name, self.title)
end

function EmojiGroup_Com:InitCell()
  local list = self.datalist
  self.coms = {}
  for i = 1, #list do
    local data = list[i]
    local obj = self:GetCacheObj()
    local com = self:AddViewComponentOnce(obj, EmojiItem_Com, list[i], UI_Pvp_Item_Expression_BigResource)
    data.clickCB = self.clickFunc
    self.coms[i] = com
  end
end

function EmojiGroup_Com:InitObj()
  self.cacheObj = {}
  local tempTrans = self.ui.Content.transform
  for i = 0, tempTrans.childCount - 1 do
    local go = tempTrans:GetChild(i).gameObject
    go:SetActive(false)
    table.insert(self.cacheObj, go)
  end
end

function EmojiGroup_Com:GetCacheObj()
  local obj = table.remove(self.cacheObj, 1)
  if nil == obj then
    if nil == self.itemUINode then
      self.itemUINode = self:LoadAsset(UI_Pvp_Item_Expression_BigResource.assetPath)
    end
    obj = GameObject.Instantiate(self.itemUINode, self.ui.Content.transform)
  end
  obj:SetActive(true)
  return obj
end

return EmojiGroup_Com
