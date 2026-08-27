local UIEventBattlePassBuyLevel_Halloween = class("UIEventBattlePassBuyLevel_Halloween", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UIEventBattlePassBuyLevel_Halloween:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseBattlePass, {
    ConstGlobalItem.PaidItem,
    ConstGlobalItem.PaidSubItem
  })
  UIUtil.SetTopStatusBtnShow(false, false)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickCloseBattlePass)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  self.ui.baseItem:SetActive(false)
  self._baseRewardPool = UIItemPool.New(UINBaseItemWithCount, self.ui.baseItem)
end

function UIEventBattlePassBuyLevel_Halloween:InitBPHallowBuy(hallowData, callback)
  self._data = hallowData
  self._callback = callback
  local itemId = self._data:GetHallowmasScoreItemId()
  local itemName = ConfigData:GetItemName(itemId)
  self.ui.textTitle:SetIndex(1)
  self.ui.btn_Add.gameObject:SetActive(false)
  self.ui.btn_Max.gameObject:SetActive(false)
  self.ui.btn_Least.gameObject:SetActive(false)
  self.ui.btn_Sub.gameObject:SetActive(false)
  self._levelCount = 1
  local curLevel = self._data:GetHallowmasLv()
  local nextLevel = curLevel + self._levelCount
  local rewardDic = {}
  self._costId = nil
  self._costNum = 0
  for i = curLevel, nextLevel - 1 do
    local costExpCfg = self._data:GetHallowmasExpCfg()[i]
    self._costId = costExpCfg.level_cost_id
    self._costNum = self._costNum + costExpCfg.level_cost_num
    local rewardExpCfg = self._data:GetHallowmasExpCfg()[i + 1]
    for i, v in ipairs(rewardExpCfg.level_reward_ids) do
      local count = rewardDic[v] or 0
      rewardDic[v] = count + rewardExpCfg.level_reward_nums[i]
    end
  end
  self.ui.tex_CurLevel:SetIndex(0, tostring(curLevel))
  self.ui.tex_NextLevel:SetIndex(0, tostring(nextLevel))
  self.ui.tex_SelCount.text = tostring(self._levelCount)
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(self._costId, true)
  self.ui.tex_money.text = tostring(self._costNum)
  self._baseRewardPool:HideAll()
  for itemId, itemCount in pairs(rewardDic) do
    local itemCfg = ConfigData.item[itemId]
    local item = self._baseRewardPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount)
  end
end

function UIEventBattlePassBuyLevel_Halloween:OnClickBuy()
  local function buyFunc()
    UIUtil.OnClickBackByUiTab(self)
    
    if self._callback ~= nil then
      self._callback(self._levelCount)
    end
  end
  
  local haveCount = PlayerDataCenter:GetItemCount(self._costId)
  if haveCount < self._costNum then
    local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
    if not payCtrl:TryConvertPayItem(self._costId, self._costNum - haveCount, nil, nil, buyFunc, true) then
      CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(25))
    end
    return
  end
  buyFunc()
end

function UIEventBattlePassBuyLevel_Halloween:OnClickCloseBattlePass()
  UIUtil.OnClickBackByUiTab(self)
end

function UIEventBattlePassBuyLevel_Halloween:OnCloseBattlePass()
  UIUtil.SetTopStatusBtnShow(true, true)
  self:Delete()
end

return UIEventBattlePassBuyLevel_Halloween
