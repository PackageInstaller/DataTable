local UIEventGrowBag = class("UIEventGrowBag", UIBaseWindow)
local base = UIBaseWindow
local UINEventGrowBag = require("Game.EventGrowBag.UI.UINEventGrowBag")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")

function UIEventGrowBag:OnInit()
  self.ui.AdvanTitleCol = self.ui.img_AdvanTitle.color
  self.ui.scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.itemDic = {}
  self.__OnClickBuyCallback = BindCallback(self, self.OnClickBuy)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnClickBuy)
  UIUtil.AddButtonListener(self.ui.btn_Achieve, self, self.OnBtnAchieveOpen)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnClickGetAll)
  self.__OnDataChangeCallback = BindCallback(self, self.OnDataChange)
  self.__RefreshCallback = BindCallback(self, self.Refresh)
  MsgCenter:AddListener(eMsgEventId.BattlePassChange, self.__OnDataChangeCallback)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__RefreshCallback)
  self.__onRefreshAchievementLevel = BindCallback(self, self.RefreshAchievementLevel)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__onRefreshAchievementLevel)
  MsgCenter:AddListener(eMsgEventId.UpdatePickedRewardLevel, self.__onRefreshAchievementLevel)
  if Consts.GameChannelType.IsJp() then
    self.ui.obj_JpQZ:SetActive(true)
  end
end

function UIEventGrowBag:InitEventGrow()
  local id, def
  for k, v in pairs(ConfigData.battlepass_type) do
    if v.condition == BattlePassEnum.ConditionType.AchievementLevel then
      id = k
      def = v
      break
    end
  end
  if id == nil then
    return
  end
  self.info = PlayerDataCenter.battlepassData.passInfos[id]
  local itemId = self.info.passCfg.senior_reward_id
  local itemNum = self.info.passCfg.senior_reward_num
  local itemName = LanguageUtil.GetLocaleText(ConfigData.item[itemId].name)
  self.ui.tex_BuyDesc.text = tostring(itemNum)
  self.levelCfg = ConfigData.battlepass[id]
  itemId = ConstGlobalItem.PaidSubItem
  itemNum = 0
  for k, v in pairs(self.levelCfg) do
    for i, v2 in ipairs(v.senior_item_ids) do
      if v2 == itemId then
        itemNum = itemNum + v.senior_item_nums[i]
        break
      end
    end
  end
  itemName = LanguageUtil.GetLocaleText(ConfigData.item[itemId].name)
  self.ui.tex_ReturnDesc.text = tostring(itemNum)
  local payCtr = ControllerManager:GetController(ControllerTypeId.Pay, true)
  self.ui.tex_Price.text = payCtr:GetPayPriceShow(self.info.passCfg.senior_price)
  local tableArray = {}
  for k, v in pairs(self.levelCfg) do
    table.insert(tableArray, v)
  end
  table.sort(tableArray, function(a, b)
    return a.level < b.level
  end)
  self.tableArray = tableArray
  self.ui.scroll:ClearCells()
  self.ui.scroll.totalCount = #tableArray
  self.ui.scroll:RefillCells()
  self:Refresh()
end

function UIEventGrowBag:OnDataChange(id)
  if id == self.info.passCfg.id then
    self:Refresh()
  end
end

function UIEventGrowBag:Refresh()
  for k, v in pairs(self.itemDic) do
    v:Refresh()
  end
  self.ui.btn_Buy.gameObject:SetActive(not self.info.unlockSenior)
  self.ui.mask:SetActive(not self.info.unlockSenior)
  self.ui.obj_AdvanLock:SetActive(not self.info.unlockSenior)
  self.ui.img_AdvanTitle.color = self.info.unlockSenior and self.ui.AdvanTitleCol or self.ui.col_AdvanTitle
  local sizeDelta = self.ui.btn_GetAll.transform.sizeDelta
  sizeDelta.x = self.info.unlockSenior and self.ui.number_getAllExrX or self.ui.number_getAllNorX
  self.ui.btn_GetAll.transform.sizeDelta = sizeDelta
  self:RefreshAchievementLevel()
  local isCanGet = self:IsCanGet()
  self.ui.img_GetAll.color = isCanGet and self.ui.color_canBuy or self.ui.color_Buyed
  self.ui.btn_GetAll.enabled = isCanGet
end

function UIEventGrowBag:__OnNewItem(go)
  local item = UINEventGrowBag.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UIEventGrowBag:__OnChangeItem(go, index)
  local item = self.itemDic[go]
  local data = self.tableArray[index + 1]
  item:InitItem(data, self.info, self.__OnClickBuyCallback)
end

function UIEventGrowBag:OnClickBuy()
  if self.info.unlockSenior then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.BattlePass)
  network:CS_BATTLEPASS_Buy(self.info.passCfg.senior_price)
end

function UIEventGrowBag:RefreshAchievementLevel()
  local curLevel = PlayerDataCenter.playerLevel.level
  self.ui.tex_AchieveLv.text = "LV." .. tostring(curLevel)
end

function UIEventGrowBag:OnBtnAchieveOpen()
  UIManager:ShowWindowAsync(UIWindowTypeID.AchievementSystem, function(win)
    if win ~= nil then
      win:InitAchievement(nil, false)
      win:SetOnAchievementSystemCloseCallback(function()
        UIManager:ShowWindowOnly(UIWindowTypeID.ActivityFrameMain)
      end)
      UIManager:HideWindow(UIWindowTypeID.ActivityFrameMain)
    end
  end)
end

function UIEventGrowBag:OnClickGetAll()
  if not self:IsCanGet() then
    return
  end
  local battlePassNetwork = NetworkManager:GetNetwork(NetworkTypeID.BattlePass)
  battlePassNetwork:CS_BATTLEPASS_Take(self.info.passCfg.id, nil, BattlePassEnum.TakeWay.All)
end

function UIEventGrowBag:IsCanGet()
  local levelDic = {}
  for index, cfg in ipairs(self.tableArray) do
    local rewardState = self.info.taken[cfg.level]
    local isNormalLocked = PlayerDataCenter.playerLevel.level < cfg.level
    local isNormalGetReward = rewardState ~= nil and rewardState.base
    local isSeniorLocked = isNormalLocked or not self.info.unlockSenior
    local isSeniorGetReward = rewardState ~= nil and rewardState.senior
    local baseCanGet = not isNormalLocked and (rewardState == nil or not rewardState.base)
    local seniorCanGet = not isSeniorLocked and self.info.unlockSenior and (rewardState == nil or not rewardState.senior)
    local isCanGet = baseCanGet or seniorCanGet
    if isCanGet then
      return true
    end
  end
  return false
end

function UIEventGrowBag:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.BattlePassChange, self.__OnDataChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__RefreshCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__onRefreshAchievementLevel)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedRewardLevel, self.__onRefreshAchievementLevel)
  base.OnDelete(self)
end

return UIEventGrowBag
