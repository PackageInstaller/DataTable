local UINEventNoviceSign = class("UINEventNoviceSign", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local TaskEnum = require("Game.Task.TaskEnum")
local UINEventNoviceSignItem = require("Game.EventNoviceSign.UI.UINEventNoviceSignItem")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UINEventNoviceSign:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Click, self, self.OnClickNoviceSignReceive)
  self.itemPool = UIItemPool.New(UINEventNoviceSignItem, self.ui.obj_RewardItem)
  self.ui.obj_RewardItem:SetActive(false)
  self.__nowUp = false
end

function UINEventNoviceSign:InitNoviceSignItem(data, awardCfg, resloader)
  self.data = data
  self.awardCfg = awardCfg
  self.resloader = resloader
  self.ui.img_date:SetIndex(self.awardCfg.day - 1)
  if self.awardCfg.rare == true then
    self.ui.img_dayBG:SetIndex(2)
    self.ui.tex_ItemName.color = Color.white
  else
    self.ui.img_dayBG:SetIndex(0)
  end
  self.itemPool:HideAll()
  for n = 1, #self.awardCfg.awardIds do
    local item = self.itemPool:GetOne()
    local awardId = self.awardCfg.awardIds[n]
    local awardCount = self.awardCfg.awardCounts[n]
    item:InitNoviceSignItemsItem(self.data, self.awardCfg, awardId, awardCount, self.resloader)
  end
  self:RefreshNoviceSignItem()
end

function UINEventNoviceSign:RefreshNoviceSignItem()
  local state = self.data:GetReceiveState(self.awardCfg.day)
  self.ui.btn_Click.gameObject:SetActive(state == TaskEnum.eTaskState.Completed)
  self.ui.obj_Received:SetActive(state == TaskEnum.eTaskState.Picked)
  if state == TaskEnum.eTaskState.Completed then
    if self.awardCfg.day ~= 7 then
      self.ui.img_dayBG:SetIndex(1)
    end
    if self.__nowUp == false then
      local startPos = self.ui.obj_nromal.transform.anchoredPosition
      self.ui.obj_nromal.transform.anchoredPosition = Vector2.New(startPos.x, startPos.y + 17.7)
      self.__nowUp = true
    end
    self.ui.obj_GetReward:SetActive(true)
  end
end

function UINEventNoviceSign:OnClickNoviceSignReceive()
  if self.data:GetReceiveState(self.awardCfg.day) == TaskEnum.eTaskState.Completed then
    NetworkManager:GetNetwork(NetworkTypeID.EventNoviceSign):CS_SIGNACTIVITY_Pick(self.data.id, function(objList)
      self:RefreshNoviceSignItem()
      if objList.Count == 0 then
        error("objList.Count == 0")
        return
      end
      local rewardDic = objList[0]
      local rewardIdList = {}
      local rewardNumList = {}
      for k, v in pairs(rewardDic) do
        table.insert(rewardIdList, k)
        table.insert(rewardNumList, v)
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window ~= nil then
          local CRData = CommonRewardData.CreateCRDataUseList(rewardIdList, rewardNumList)
          window:AddAndTryShowReward(CRData)
        end
      end)
      if self.awardCfg.day ~= 7 then
        self.ui.img_dayBG:SetIndex(0)
      end
      if self.__nowUp == true then
        local startPos = self.ui.obj_nromal.transform.anchoredPosition
        self.ui.obj_nromal.transform.anchoredPosition = Vector2.New(startPos.x, startPos.y - 17.7)
        self.__nowUp = false
      end
      self.ui.obj_GetReward:SetActive(false)
      for i, v in ipairs(self.itemPool.listItem) do
        v:hasClicked()
      end
    end)
  end
end

function UINEventNoviceSign:OnDelete()
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINEventNoviceSign
