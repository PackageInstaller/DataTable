local UINSpring23StoryCharExtra = class("UINSpring23StoryCharExtra", UIBaseNode)
local base = UIBaseNode
local UINSpring23StoryCharExtraItem = require("Game.ActivitySpring.UI.StoryReview.UINSpring23StoryCharExtraItem")

function UINSpring23StoryCharExtra:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBtnClose)
  UIUtil.AddButtonListener(self.ui.finalItem, self, self.OnClickShowRewardDetail)
  self._itemPool = UIItemPool.New(UINSpring23StoryCharExtraItem, self.ui.item)
  self.ui.item:SetActive(false)
  self.ui.finalItem.gameObject:SetActive(true)
end

function UINSpring23StoryCharExtra:InitSpring23StoryCharExtra(springStoryData, heroId, fixCfgList, ranCfg)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Hide):PushTopStatusDataToBackStack()
  local heroCfg = ConfigData.hero_data[heroId]
  local finalItemId = ranCfg.important_reward_ids[1]
  self._finalItemCfg = ConfigData.item[finalItemId]
  local actLongId = springStoryData:GetStoryActId()
  self.ui.tex_Title:SetIndex(0, LanguageUtil.GetLocaleText(heroCfg.name))
  self.ui.img_Award.sprite = CRH:GetSpriteByItemId(finalItemId)
  self.ui.tex_Rule.text = ConfigData:GetTipContent(ConfigData.activity_interact_main[actLongId].des_individual[1])
  self.ui.tex_FinalDes.text = ConfigData:GetTipContent(ConfigData.activity_interact_main[actLongId].des_individual[2])
  self._itemPool:HideAll()
  for i, v in ipairs(fixCfgList) do
    local item = self._itemPool:GetOne()
    local flag = springStoryData:GetThisTalkStateById(v.id)
    item:InitSpring23StoryCharExtraItem(v, i, flag)
  end
  self._itemPool.listItem[#fixCfgList]:HideSpring23StoryCharExtraItemBar()
  self.ui.finalItem.transform:SetAsLastSibling()
  local pos = self.ui.rect.anchoredPosition
  pos.x = 0
  self.ui.rect.anchoredPosition = pos
end

function UINSpring23StoryCharExtra:OnClickBtnClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINSpring23StoryCharExtra:OnClickShowRewardDetail()
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:InitCommonItemDetail(self._finalItemCfg)
    end
  end)
end

return UINSpring23StoryCharExtra
