local RectTransform = CS.UnityEngine.RectTransform
local ItemObjectTip, Super = System.NewComponent("ItemObjectTip")

function ItemObjectTip:ctor(res, maskNode, data)
  Super.ctor(self)
  self.ui = Item_Public_Object_TipResource(res)
  self.data = data
  self.maskNode = maskNode
end

function ItemObjectTip:OnBind(binder)
  self.binder = binder
  self.transform = self.ui.uiNode.transform
  self.gainTipTrans = self.ui.Goods_Gain_Tips.transform
  binder:SetActive(self.ui.Image_Text, false)
  binder:SetActive(self.ui.Image_Bg, not self.data.isEnergy)
  if self.data.isMonster then
    local config, iconPath, name, desc
    config = CopyDataUtils.GetMonsterConfig(self.data.configId)
    name = LT.Text(config.MonsterName)
    desc = LT.Text(config.Desc or "你没配描述")
    iconPath = config.MiniIcon
    self.binder:SetImage(self.ui.Icon_Article, iconPath or "")
    binder:SetActive(self.ui.Text_Level, true)
    local path = ""
    local str = ""
    local titleImagePath = ""
    if config.MonsterClass == CommonDefine.MonsterClass.Boss then
      path = DT.Constant.BattleHard_Boss.Data[1]
      str = "Battle_Boss_Tips"
      titleImagePath = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Image_Text_leader1.png"
    end
    if config.MonsterClass == CommonDefine.MonsterClass.Elite then
      path = DT.Constant.BattleHard_Elite.Data[1]
      str = "Battle_Elite_Tips"
      titleImagePath = "UIResources/AtlasSource/UI_Common_Image2/UI_Common_Image_Text_leader2.png"
    end
    if config.MonsterClass == CommonDefine.MonsterClass.Common then
      path = DT.Constant.BattleHard_Common.Data[1]
      str = ""
      titleImagePath = ""
    end
    if "" ~= titleImagePath then
      binder:SetActive(self.ui.Image_Text, true)
      binder:SetImage(self.ui.Image_Text, titleImagePath)
    end
    binder:SetImage(self.ui.Image_Bg, path)
    binder:SetText(self.ui.Text_Level, string.format("<color=#%s>%s</color>", "D71B1B", LT.Text(str)))
    binder:SetText(self.ui.Text_Title, name)
    binder:SetText(self.ui.Text_Desc_1, desc)
    binder:SetActive(self.ui.Text_Desc_2, false)
    binder:SetActive(self.ui.Text_Count, false)
    binder:SetActive(self.ui.Goods_Gain_Tips, false)
  end
  binder:SetActive(self.ui.Image_Quality, not self.data.isMonster)
  if self.data.isItem then
    local config = ItemDataUtils.GetItemConfig(self.data.configId)
    local itemAttrCfg = DT.ItemQuality[config.Quality]
    binder:SetImage(self.ui.Image_Bg, itemAttrCfg.ItemQualityColor)
    binder:SetActive(self.ui.Text_Level, false)
    local color = DT.ItemQuality[config.Quality].ItemNameColor
    local nameStr = string.format("<color=#%s>%s</color>", color, LT.Text(config.Name))
    binder:SetText(self.ui.Text_Title, nameStr)
    local desc = ItemDataUtils.GetItemDesc(self.data.configId)
    local iconPath = ItemDataUtils.GetItemIcon(self.data.configId)
    binder:SetImage(self.ui.Icon_Article, iconPath)
    binder:SetImage(self.ui.Image_Quality, ItemDataUtils.GetQualityFramePath(self.data.configId))
    binder:SetText(self.ui.Text_Desc_1, desc)
    binder:SetActive(self.ui.Text_Count, ItemDataUtils.GetItemByTid(self.data.configId) ~= nil)
    binder:SetText(self.ui.Text_Count, LT.Textf("Shop_Now_Num_Goods_Str", ItemDataUtils.GetItemNum(self.data.configId)))
    binder:SetActive(self.ui.Text_Desc_2, self.data.configId == CommonDefine.CurrencyType.Ticket)
    if self.data.configId == CommonDefine.CurrencyType.Ticket then
      binder:BindToRaw(function(_, nVal)
        if not nVal then
          return
        end
        self.restoreLeftTime = PlayerDataUtils.GetTicketRestoreLeftTime()
      end, function()
        return DataCenter.playerData.DRole.ticketRestoredTimestamp or 0
      end)
      binder:BindToRaw(function(_, nVal)
        if not nVal then
          return
        end
        binder:SetText(self.ui.Text_Count, LT.Textf("Shop_Now_Num_Goods_Str", nVal))
      end, PlayerDataUtils.GetTicketNum)
      self.restoreLeftTime = PlayerDataUtils.GetTicketRestoreLeftTime()
      self:SetTicketCounterText()
      binder:BindTimer(1, -1, function()
        self.restoreLeftTime = self.restoreLeftTime - 1
        if self.restoreLeftTime < 0 then
          self.restoreLeftTime = 0
        end
        self:SetTicketCounterText()
      end)
    end
    if self.data.showGetApproach and config.Gets then
      binder:SetActive(self.ui.Goods_Gain_Tips, true)
      binder:BindComponent(ItemPublicGetApproachPanel(self.ui.Goods_Gain_Tips, self.data.configId, System.fn(self, self.OnMaskClicked)))
    else
      binder:SetActive(self.ui.Goods_Gain_Tips, false)
    end
  end
  if self.data.isEnergy then
    self.binder:SetImage(self.ui.Icon_Article, ItemDataUtils.GetItemIcon(self.data.configId))
    local config = ItemDataUtils.GetItemConfig(self.data.configId)
    local color = DT.ItemQuality[config.Quality].ItemNameColor
    local nameStr = string.format("<color=#%s>%s</color>", color, LT.Text(config.Name))
    binder:SetText(self.ui.Text_Title, nameStr)
    binder:SetImage(self.ui.Image_Quality, ItemDataUtils.GetQualityFramePath(self.data.configId))
    local desc = ItemDataUtils.GetItemDesc(self.data.configId)
    binder:SetText(self.ui.Text_Desc_1, desc)
    binder:SetActive(self.ui.Text_Desc_2, true)
    binder:SetActive(self.ui.Text_Count, true)
    binder:SetActive(self.ui.Text_Level, false)
    binder:SetActive(self.ui.Goods_Gain_Tips, false)
    binder:BindToRaw(function(_, nVal)
      if not nVal then
        return
      end
      self.restoreLeftTime = PlayerDataUtils.GetEnergyRestoreLeftTime()
    end, function()
      return DataCenter.playerData.DRole.nextEnergyRestoreTimeStamp or 0
    end)
    binder:BindToRaw(function(_, nVal)
      if not nVal then
        return
      end
      binder:SetText(self.ui.Text_Count, LT.Textf("Shop_Now_Num_Goods_Str", nVal))
    end, function()
      do return end
      return PlayerDataUtils.GetEnergy, nil
    end)
    self.restoreLeftTime = PlayerDataUtils.GetEnergyRestoreLeftTime()
    self:SetEnergyCounterText()
    binder:BindTimer(1, -1, function()
      self.restoreLeftTime = self.restoreLeftTime - 1
      if self.restoreLeftTime < 0 then
        self.restoreLeftTime = 0
      end
      self:SetEnergyCounterText()
    end)
  end
  if self.data.itemType then
    if self.data.itemType == CommonDefine.ItemType.CopiesItem then
      if self.data.configId == CommonDefine.CurrencyType.CopiesMoney then
        local copiesMoneyData = DT.GetOriginalConstant("PhiloStone")
        binder:SetImage(self.ui.Image_Bg, "UIResources/AtlasSource/2_Icon/ToolQuality/UI_Tool_Quality_Nil.png")
        binder:SetText(self.ui.Text_Title, LT.Text("PhiloStone"))
        binder:SetImage(self.ui.Icon_Article, copiesMoneyData[2])
        binder:SetText(self.ui.Text_Desc_1, LT.Text("PhiloStone_Desc"))
        binder:SetActive(self.ui.Image_Quality, false)
        binder:SetActive(self.ui.Text_Desc_2, false)
        binder:SetActive(self.ui.Text_Level, false)
        binder:SetActive(self.ui.Text_Count, false)
        binder:SetActive(self.ui.Goods_Gain_Tips, false)
      end
    elseif self.data.itemType == CommonDefine.ItemType.Relic then
      local config = DT.RelicConfig[self.data.configId]
      local itemAttrCfg = DT.ItemQuality[config.Quality]
      binder:SetImage(self.ui.Image_Bg, itemAttrCfg.ItemQualityColor)
      local color = DT.ItemQuality[config.Quality].ItemNameColor
      local nameStr = string.format("<color=#%s>%s</color>", color, LT.Text(config.Name))
      binder:SetActive(self.ui.Image_Quality, false)
      binder:SetText(self.ui.Text_Title, nameStr)
      local desc = RelicDataUtils.GetRelicDesc(self.data.configId)
      local iconPath = config.SmallIcon
      binder:SetImage(self.ui.Icon_Article, iconPath)
      binder:SetText(self.ui.Text_Desc_1, desc)
      binder:SetText(self.ui.Text_Count, LT.Textf("Shop_Now_Num_Goods_Str", ItemDataUtils.GetItemNum(self.data.configId)))
      binder:SetActive(self.ui.Text_Count, false)
      binder:SetActive(self.ui.Text_Desc_2, false)
      binder:SetActive(self.ui.Text_Level, false)
      binder:SetActive(self.ui.Goods_Gain_Tips, false)
    elseif self.data.itemType == CommonDefine.ItemType.Rune then
      local config = DT.EnchantConfig[self.data.configId]
      local itemAttrCfg = DT.ItemQuality[config.Quality]
      binder:SetImage(self.ui.Image_Bg, itemAttrCfg.ItemQualityColor)
      local color = DT.ItemQuality[config.Quality].ItemNameColor
      local nameStr = string.format("<color=#%s>%s</color>", color, LT.Text(config.Name))
      binder:SetActive(self.ui.Image_Quality, false)
      binder:SetText(self.ui.Text_Title, nameStr)
      local desc = SkillUtils.GetEnchantDesc(self.data.configId)
      local iconPath = config.SmallIcon
      binder:SetImage(self.ui.Icon_Article, iconPath)
      binder:SetText(self.ui.Text_Desc_1, desc)
      binder:SetText(self.ui.Text_Count, LT.Textf("Shop_Now_Num_Goods_Str", ItemDataUtils.GetItemNum(self.data.configId)))
      binder:SetActive(self.ui.Text_Count, false)
      binder:SetActive(self.ui.Text_Desc_2, false)
      binder:SetActive(self.ui.Text_Level, false)
      binder:SetActive(self.ui.Goods_Gain_Tips, false)
    end
  end
  binder:BindEvent(EventMgr.Instance.TouchBeginEvent, function()
    self:OnMaskClicked()
  end)
  local groupTipRT = self.ui.Group_Tip:GetComponent(typeof(RectTransform))
  local oriHeight = groupTipRT.sizeDelta.y
  UIAdaptationUtils.RefreshGoHeightByTMPHeight(groupTipRT, self.binder:GetTextComp(self.ui.Text_Desc_1), oriHeight)
  if self.data.autoAdjustPos then
    TipsGenerateUtils.AdjustPosition(self.data.rootGameObject, self.ui.uiNode)
  end
end

function ItemObjectTip:SetTicketCounterText()
  local binder = self.binder
  local showStr = self:GetCounterStr()
  binder:SetText(self.ui.Text_Desc_2, showStr)
end

function ItemObjectTip:SetEnergyCounterText()
  local binder = self.binder
  local showStr = self:GetEnergyCounterStr()
  binder:SetText(self.ui.Text_Desc_2, showStr)
end

function ItemObjectTip:GetCounterStr()
  local showStr = ""
  local restoreMaxNum = PlayerDataUtils.GetMaxTicketRestoreNum()
  if restoreMaxNum <= 0 or restoreMaxNum <= PlayerDataUtils.GetTicketNum() then
    showStr = LT.Text("Ticket_Revert_Time_Tips")
    return showStr
  end
  if not self.restoreLeftTime or type(self.restoreLeftTime) ~= "number" then
    return showStr
  end
  if self.restoreLeftTime <= 0 then
    return showStr
  end
  local showTime = TimeUtils.format(self.restoreLeftTime, CommonDefine.TimeParseType.hms)
  showStr = LT.Textf("Ticket_Countdown_Str", showTime)
  return showStr
end

function ItemObjectTip:GetEnergyCounterStr()
  local showStr = ""
  local level = DataCenter.playerData.DRole.level
  local restoreMaxNum = PlayerDataUtils.GetEnergyNaturalRecoverLimit(level)
  if restoreMaxNum <= 0 or restoreMaxNum <= PlayerDataUtils.GetEnergy() then
    showStr = LT.Text("Function_Use_Desc_Energy")
    return showStr
  end
  if not self.restoreLeftTime or type(self.restoreLeftTime) ~= "number" then
    return showStr
  end
  if self.restoreLeftTime <= 0 then
    return showStr
  end
  local showTime = TimeUtils.format(self.restoreLeftTime, CommonDefine.TimeParseType.hms)
  showStr = LT.Textf("Function_Use_Desc_Energy_2", showTime)
  return showStr
end

function ItemObjectTip:SetCount(count)
  self.binder:SetText(self.ui.Text_Count, LT.Textf("Shop_Now_Num_Goods_Str", count))
end

function ItemObjectTip:OnMaskClicked()
  self.binder:teardown()
end

return ItemObjectTip
