local UIActivitySaveMoneyPreview = class("UIActivitySaveMoneyPreview", UIBaseWindow)
local base = UIBaseWindow
local UINSaveMoneyPreviewListItem = require("Game.ActivitySaveMoney.UI.UINSaveMoneyPreviewListItem")

function UIActivitySaveMoneyPreview:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickSaveMoneyPreviewClose)
  UIUtil.AddButtonListener(self.ui.background, self, self.OnClickSaveMoneyPreviewClose)
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.giftListItemPool = UIItemPool.New(UINSaveMoneyPreviewListItem, self.ui.giftPageDetailItem, false)
end

function UIActivitySaveMoneyPreview:InitSaveMoneyPreview(saveCfg)
  local saveMoneyController = ControllerManager:GetController(ControllerTypeId.ActivitySaveMoney, true)
  local saveMoneyData = saveMoneyController:GetSaveMoneyDataByActId(saveCfg.id)
  local allRewardCfg = saveMoneyData:GetSaveMoneyRewardsCfg()[saveCfg.save_level]
  self.ui.obj_giftList:SetActive(false)
  self.ui.obj_dayRewardList:SetActive(true)
  self.ui.tex_Title:SetIndex(2)
  self.ui.tex_Tips:SetIndex(2)
  self.ui.progress:SetActive(false)
  self.ui.tex_progress.gameObject:SetActive(false)
  self.giftListItemPool:HideAll()
  for _, rewardCfg in ipairs(allRewardCfg) do
    local itemList = {}
    for index, itemId in ipairs(rewardCfg.receive_rewards_ids) do
      local itemCfg = ConfigData.item[itemId]
      table.insert(itemList, {
        itemCfg = itemCfg,
        count = rewardCfg.receive_rewards_nums[index]
      })
    end
    local startTime, endTime = saveMoneyData:GetSaveMoneyStageStartEndTime(rewardCfg.save_level, rewardCfg.stage)
    local item = self.giftListItemPool:GetOne(true)
    item:InitSaveMoneyPreviewListItem(startTime, endTime, itemList)
  end
end

function UIActivitySaveMoneyPreview:BackAction()
  self:Delete()
end

function UIActivitySaveMoneyPreview:OnDelete()
  self.giftListItemPool:DeleteAll()
end

function UIActivitySaveMoneyPreview:OnClickSaveMoneyPreviewClose()
  UIUtil.OnClickBackByUiTab(self)
end

return UIActivitySaveMoneyPreview
