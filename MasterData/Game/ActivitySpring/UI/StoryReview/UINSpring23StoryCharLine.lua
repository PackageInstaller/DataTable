local UINSpring23StoryCharLine = class("UINSpring23StoryCharLine", UIBaseNode)
local base = UIBaseNode
local UINSpring23StoryCharItem = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryCharItem")

function UINSpring23StoryCharLine:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.extraItem, self, self.OnClickExtra)
  self._itemPool = UIItemPool.New(UINSpring23StoryCharItem, self.ui.awardItem)
  self.ui.awardItem:SetActive(false)
end

function UINSpring23StoryCharLine:InitSpring23StoryCharLine(springStoryData, heroId, charCfgList, resloader, extraClickFunc, avgDetailCallback)
  self._heroId = heroId
  self._extraClickFunc = extraClickFunc
  local heroCfg = ConfigData.hero_data[self._heroId]
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(heroCfg.name)
  self._itemPool:HideAll()
  for i, cfg in ipairs(charCfgList) do
    local item = self._itemPool:GetOne()
    if springStoryData ~= nil then
      item:InitSpring23StoryItem(springStoryData, cfg, resloader, avgDetailCallback)
    else
      item:InitSpring23StoryItemReview(cfg, resloader, avgDetailCallback)
    end
  end
  self.ui.extraItem.transform:SetAsLastSibling()
  self.ui.extraItem.gameObject:SetActive(springStoryData ~= nil)
  local markCfg = charCfgList[1]
  local interactInfoCfg = ConfigData.activity_interact_info[markCfg.story]
  resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(interactInfoCfg.character), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.heroPic.texture = texture
  end)
end

function UINSpring23StoryCharLine:ResetSpring23StoryCharLineAniState()
  self.ui.ani_root:Stop()
  self.ui.canvasGroup_root.alpha = 0
  self.ui.detail.anchoredPosition = Vector2.zero
  for i, v in ipairs(self._itemPool.listItem) do
    v:ResetSpring23StoryItemAniState()
  end
end

function UINSpring23StoryCharLine:SetSpring23StoryCharLineTween(delayTime, sequeceTween)
  sequeceTween:InsertCallback(delayTime, function()
    self.ui.ani_root:Play()
  end)
  sequeceTween:Insert(delayTime, self.ui.detail:DOLocalMoveY(-50, 0.5):From():SetAutoKill(false))
  for i, v in ipairs(self._itemPool.listItem) do
    v:SetSpring23StoryItemTween(delayTime + (i - 1) * 0.1, sequeceTween)
  end
end

function UINSpring23StoryCharLine:OnClickExtra()
  if self._extraClickFunc ~= nil then
    self._extraClickFunc(self._heroId)
  end
end

return UINSpring23StoryCharLine
