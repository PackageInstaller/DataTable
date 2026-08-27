local UIVowSign = class("UIVowSign", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINSteinsGateVow = require("Game.VowSystem.UI.UINSteinsGateVow")
local UINVowStoryNode = require("Game.VowSystem.UI.VowStory.UINVowStoryNode")
local cs_ResLoader = CS.ResLoader

function UIVowSign:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.__OnClickCancle)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnClickConfirm)
  self.__OnClickChooseItem = BindCallback(self, self.OnClickChooseItem)
  self._itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount, false)
  self.resloader = CS.ResLoader.Create()
  self.vowStoryNode = UINVowStoryNode.New()
  self.vowStoryNode:Init(self.ui.obj_StoryNode)
end

function UIVowSign:InitVowStory(heroId)
  self.ui.obj_SignNode:SetActive(false)
  self.ui.obj_StoryNode:SetActive(true)
  self.ui.ani_VowWindow:Play("UI_VowSignWindowStoryNode")
  self.vowStoryNode:InitVowStoryNode(heroId, self.resloader, BindCallback(self, self.__OnClickCancle))
end

function UIVowSign:InitVowSign(heroId, confimCallback)
  self.ui.obj_SignNode:SetActive(true)
  self.ui.obj_StoryNode:SetActive(false)
  self.ui.ani_VowWindow:Play("UI_VowSignWindow")
  self._confimCallback = confimCallback
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  local userName = PlayerDataCenter.inforData:GetUserName()
  local heroName = heroData:GetName()
  local timeTex = TimeUtil:TimestampToDateString(math.floor(PlayerDataCenter.timestamp), false, true, ConfigData:GetTipContent(768))
  local heroVowCfg = heroData:GetVowCfg()
  local specialCostId = 0
  for itemId, _ in pairs(heroVowCfg.vow_cost_2) do
    specialCostId = itemId
  end
  local isSpecialCost = specialCostId ~= 0
  self._hasSpecialCost = isSpecialCost
  if not isSpecialCost then
    self:InitNormalCostVowSign(heroId)
  else
    self:InitSpecialCostVowSign(heroId)
  end
  self:InitCommonVowSign(heroId)
end

function UIVowSign:InitCommonVowSign(heroId)
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  local userName = PlayerDataCenter.inforData:GetUserName()
  local heroName = heroData:GetName()
  local timeTex = TimeUtil:TimestampToDateString(math.floor(PlayerDataCenter.timestamp), false, true, ConfigData:GetTipContent(768))
  local heroVowCfg = heroData:GetVowCfg()
  self.ui.tex_PlayerName.text = userName
  self.ui.tex_HeroName.text = heroName
  self.ui.tex_BeforLvl.text = tostring(ConfigData.hero_vow_config.basicVowLevel)
  self.ui.tex_AfterLvl.text = tostring(heroVowCfg.vow_friendship_level)
  self.ui.tex_Time.text = timeTex
  self._itemPool:HideAll()
  for rewardId, rewardNum in pairs(heroVowCfg.vow_reward) do
    local rewardItem = self._itemPool:GetOne()
    local itemCfg = ConfigData.item[rewardId]
    rewardItem:InitItemWithCount(itemCfg, rewardNum)
  end
end

function UIVowSign:InitNormalCostVowSign(heroId)
  self.ui.obj_normalGroup:SetActive(true)
  self.ui.obj_steinGateHolder:SetActive(false)
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  local heroVowCfg = heroData:GetVowCfg()
  local vowItemId = 0
  local vowItemNeedNum = 0
  for itemId, itemNum in pairs(heroVowCfg.vow_cost) do
    vowItemId = itemId
    vowItemNeedNum = itemNum
  end
  local itemCfg = ConfigData.item[vowItemId]
  local vowItemNum = PlayerDataCenter:GetItemCount(vowItemId)
  self._hasNormalVowItemCount = 0 < vowItemNum
  self.ui.tex_UseNum.text = tostring(vowItemNeedNum)
  self.ui.tex_RemainNum.text = tostring(vowItemNum)
  local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.tex_Label:SetIndex(0, itemName)
end

function UIVowSign:InitSpecialCostVowSign(heroId)
  self.ui.obj_normalGroup:SetActive(false)
  self.ui.obj_steinGateHolder:SetActive(true)
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  local heroVowCfg = heroData:GetVowCfg()
  local vowItemId = 0
  local vowItemNeedNum = 0
  local vowCostList = {}
  for itemId, itemNum in pairs(heroVowCfg.vow_cost) do
    vowItemId = itemId
    vowItemNeedNum = itemNum
  end
  local vowItemNum = PlayerDataCenter:GetItemCount(vowItemId)
  self._hasNormalVowItemCount = 0 < vowItemNum
  local vowCost2ItemId = 0
  local vowCost2NeedNum = 0
  for itemId, itemNum in pairs(heroVowCfg.vow_cost_2) do
    vowCost2ItemId = itemId
    vowCost2NeedNum = itemNum
  end
  self._vowCost2ItemId = vowCost2ItemId
  table.insert(vowCostList, {
    itemId = vowCost2ItemId,
    costNum = vowCost2NeedNum,
    isSpecialCost = true
  })
  table.insert(vowCostList, {itemId = vowItemId, costNum = vowItemNeedNum})
  self.steinsGateVowNode = UINSteinsGateVow.New()
  self.steinsGateVowNode:Init(self.ui.steinsGateVow)
  self.steinsGateVowNode:InitSteinsGateVow(heroId, vowCostList, self.__OnClickChooseItem)
end

function UIVowSign:OnClickChooseItem(isSpecialCost, itemId)
  self._isSpecialCost = isSpecialCost
  local itemCfg = ConfigData.item[itemId]
  self.ui.tex_Label:SetIndex(0, LanguageUtil.GetLocaleText(itemCfg.name))
end

function UIVowSign:__OnClickCancle()
  UIUtil.OnClickBackByUiTab(self)
end

function UIVowSign:__OnClickConfirm()
  if self._confimCallback then
    self._confimCallback(self._hasSpecialCost, self._isSpecialCost, self._hasNormalVowItemCount, self._vowCost2ItemId)
  end
  UIUtil.OnClickBackByUiTab(self)
end

function UIVowSign:__BackAction()
  self:Delete()
end

function UIVowSign:OnDelete()
  if self.steinsGateVowNode then
    self.steinsGateVowNode:Delete()
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIVowSign
