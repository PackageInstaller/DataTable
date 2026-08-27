local UICharDunShopVer2 = class("UICharDunShopVer2", UIBaseWindow)
local base = UIBaseWindow
local UINCharDunShopVer2Line = require("Game.ActivityHeroGrow.UI.UINCharDunShopVer2Line")
local UINCharDunShopVer2Item = require("Game.ActivityHeroGrow.UI.UINCharDunShopVer2Item")
local cs_ResLoader = CS.ResLoader

function UICharDunShopVer2:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickCloseShopVer2)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnClickRewardAll)
  self.__OnRewardOneCallback = BindCallback(self, self.__OnRewardOne)
  self._lineHorizePool = UIItemPool.New(UINCharDunShopVer2Line, self.ui.lineHri)
  self.ui.lineHri:SetActive(false)
  self._lineVerticalPool = UIItemPool.New(UINCharDunShopVer2Line, self.ui.lineVer)
  self.ui.lineVer:SetActive(false)
  self.ui.shopList.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.shopList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.shopList.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.__ItemUpdateCallback = BindCallback(self, self.__ItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__ItemUpdateCallback)
  self._resloader = cs_ResLoader.Create()
  self._itemDic = {}
end

function UICharDunShopVer2:InitCharDunShopVer2(heroGrowData, callback)
  self._heroGrowData = heroGrowData
  self._callback = callback
  self:__ReplaceByUICfg()
  self:__InitUI()
  self:RefreshCharDunShopVer2()
end

function UICharDunShopVer2:__InitUI()
  local uiCfg = ConfigData.activity_hero_ui_config[self._heroGrowData:GetActId()]
  self.ui.tex_TileName.text = LanguageUtil.GetLocaleText(uiCfg.reward_panel_name)
  local itemId = self._heroGrowData:GetHeroGrowCostId()
  self.ui.imgToken.sprite = CRH:GetSpriteByItemId(itemId)
  local itemName = ConfigData:GetItemName(itemId)
  self.ui.tex_HeadName.text = itemName
  self.ui.tex_DateType:SetIndex(0)
  local date = TimeUtil:TimestampToDate(self._heroGrowData:GetActivityDestroyTime(), false, true)
  self.ui.tex_Time.text = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
  local tip = ConfigData:GetTipContent(7045)
  local taskName = LanguageUtil.GetLocaleText(uiCfg.mission_panel_name)
  self.ui.tex_Tip.text = string.format(tip, taskName, itemName)
  self:__CreateItem()
  self:__CountDown()
  self._timerId = TimerManager:StartTimer(1, self.__CountDown, self)
  self.ui.tex_TileName.color = Color.New(uiCfg.shop_title_color[1] / 255, uiCfg.shop_title_color[2] / 255, uiCfg.shop_title_color[3] / 255)
end

function UICharDunShopVer2:__ReplaceByUICfg()
  local uiCfg = ConfigData.activity_hero_ui_config[self._heroGrowData:GetActId()]
  local bgPath = PathConsts:GetCharDunVer2Bg(uiCfg.background_res)
  self.ui.background.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(bgPath, function(texture)
    if texture == nil or IsNull(self.transform) then
      return
    end
    self.ui.background.gameObject:SetActive(true)
    self.ui.background.texture = texture
  end)
  local frameColors = uiCfg.frame_color
  local color = Color.New(frameColors[1] / 255, frameColors[2] / 255, frameColors[3] / 255)
  for i, v in ipairs(self.ui.array_colorRep) do
    v.color = color
  end
  if #uiCfg.main_top_res == 0 then
    self.ui.Img_Up.gameObject:SetActive(false)
  else
    local nameResPath = PathConsts:GetCharDunVer2Bg(uiCfg.main_top_res)
    self._resloader:LoadABAssetAsync(nameResPath, function(texture)
      if texture == nil or IsNull(self.transform) then
        return
      end
      self.ui.Img_Up.gameObject:SetActive(true)
      self.ui.Img_Up.texture = texture
    end)
    self.ui.Img_Up.transform.sizeDelta = Vector2.Temp(uiCfg.main_top_size[1], uiCfg.main_top_size[2])
  end
  if #uiCfg.main_down_res == 0 then
    self.ui.Img_Down.gameObject:SetActive(false)
  else
    local nameResPath = PathConsts:GetCharDunVer2Bg(uiCfg.main_down_res)
    self._resloader:LoadABAssetAsync(nameResPath, function(texture)
      if texture == nil or IsNull(self.transform) then
        return
      end
      self.ui.Img_Down.gameObject:SetActive(true)
      self.ui.Img_Down.texture = texture
    end)
    self.ui.Img_Down.transform.sizeDelta = Vector2.Temp(uiCfg.main_down_size[1], uiCfg.main_down_size[2])
  end
end

function UICharDunShopVer2:__CreateItem()
  local allCfg = ConfigData.activity_hero_token_reward[self._heroGrowData:GetActId()]
  local count = #allCfg
  local itemCount = PlayerDataCenter:GetItemCount(self._heroGrowData:GetHeroGrowCostId())
  self._lvSort = {}
  local oneLineLinit = self.ui.rect.constraintCount
  local unRewardLv = 0
  local targetRewardLv = 0
  for i = 1, count do
    local reverse = (i - 1) // oneLineLinit % 2 == 1
    if reverse then
      local oriIndex = (i - 1) // oneLineLinit * oneLineLinit
      local diff = (i - 1) % oneLineLinit
      self._lvSort[i] = oriIndex + oneLineLinit - diff
    else
      self._lvSort[i] = i
    end
    if itemCount >= allCfg[i].need_token then
      targetRewardLv = i
      if not self._heroGrowData:IsHeroGrowLvReceived(i) then
        unRewardLv = i
      end
    end
  end
  if isGameDev and #self._lvSort ~= count then
    error("排序大错")
  end
  self.ui.shopList.totalCount = count
  if 0 < unRewardLv then
    self.ui.shopList:SrollToCell(unRewardLv - 1, 999)
  elseif 0 < targetRewardLv then
    self.ui.shopList:SrollToCell(targetRewardLv - 1, 999)
  else
    self.ui.shopList:RefillCells(0)
  end
end

function UICharDunShopVer2:__CreateItemLine(item)
  self:__CycleItemLine(item)
  local allCfg = ConfigData.activity_hero_token_reward[self._heroGrowData:GetActId()]
  local lv = item:GetCharDunShopVer2Lv()
  if lv == #allCfg then
    return
  end
  local itemCount = PlayerDataCenter:GetItemCount(self._heroGrowData:GetHeroGrowCostId())
  if self._horizeLineDic == nil then
    self._horizeLineDic = {}
    self._vertlineDic = {}
    self._tempLines = {}
    local cellSize = self.ui.rect.cellSize
    local spacing = self.ui.rect.spacing
    self._horizeUnit = cellSize.x + spacing.x
    self._point2LeftUnit = cellSize.x / 2 + self.ui.leftOffset
    self._point2RightUnit = cellSize.x / 2 + self.ui.rightOffset
    self._verUnit = cellSize.y + spacing.y
    self._lineLimit = self.ui.rect.constraintCount
    self._startOffset = self.ui.pointOffset
  end
  if self._horizeLineDic[item] == nil then
    self._horizeLineDic[item] = {}
    self._vertlineDic[item] = {}
  end
  local line = (lv - 1) // self._lineLimit
  local reverse = line % 2 == 1
  if lv % self._lineLimit ~= 0 then
    local line = self._lineHorizePool:GetOne()
    line.transform:SetParent(item.transform)
    table.insert(self._horizeLineDic[item], line)
    local length = self._horizeUnit - self._startOffset * 2
    local startScore = allCfg[lv].need_token
    local endScore = allCfg[lv + 1].need_token
    line:InitCharDunShopVer2LineHorize(length, reverse, startScore, endScore)
    line:RefreshCharDunShopVer2Line(itemCount)
    local startoffset = reverse and -self._startOffset or self._startOffset
    item:SetChildHeroVer2HorizePointLine(line, startoffset)
  else
    local firstLine = self._lineHorizePool:GetOne()
    table.insert(self._horizeLineDic[item], firstLine)
    table.insert(self._tempLines, firstLine)
    local firstLenght = (reverse and self._point2LeftUnit or self._point2RightUnit) - self._startOffset
    local secondLine = self._lineVerticalPool:GetOne()
    table.insert(self._vertlineDic[item], secondLine)
    table.insert(self._tempLines, secondLine)
    local secondLenght = self._verUnit
    local thridLine = self._lineHorizePool:GetOne()
    table.insert(self._horizeLineDic[item], thridLine)
    table.insert(self._tempLines, thridLine)
    local thridLenght = (reverse and self._point2LeftUnit or self._point2RightUnit) - self._startOffset
    local startScore = allCfg[lv].need_token
    local endScore = allCfg[lv + 1].need_token
    local allLenght = firstLenght + secondLenght + thridLenght
    local scoreTemp1 = startScore + (endScore - startScore) / allLenght * firstLenght
    local scoreTemp2 = scoreTemp1 + (endScore - startScore) / allLenght * secondLenght
    firstLine:InitCharDunShopVer2LineHorize(firstLenght, reverse, startScore, scoreTemp1)
    firstLine:RefreshCharDunShopVer2Line(itemCount)
    secondLine:InitCharDunShopVer2LineVertial(secondLenght, false, scoreTemp1, scoreTemp2)
    secondLine:RefreshCharDunShopVer2Line(itemCount)
    thridLine:InitCharDunShopVer2LineHorize(thridLenght, not reverse, scoreTemp2, endScore)
    thridLine:RefreshCharDunShopVer2Line(itemCount)
    local startoffset = reverse and -self._startOffset or self._startOffset
    item:SetChildHeroVer2NewLinePointLine(self._tempLines, startoffset)
    table.removeall(self._tempLines)
  end
end

function UICharDunShopVer2:__CycleItemLine(item)
  if self._horizeLineDic == nil then
    return
  end
  local horizeLines = self._horizeLineDic[item]
  if horizeLines ~= nil then
    for i, line in ipairs(horizeLines) do
      self._lineHorizePool:HideOne(line)
      line.parent = self.ui.lineHri.parent
    end
    table.removeall(horizeLines)
  end
  local vertLines = self._vertlineDic[item]
  if vertLines ~= nil then
    for i, line in ipairs(vertLines) do
      self._lineVerticalPool:HideOne(line)
      line.parent = self.ui.lineVer.parent
    end
    table.removeall(vertLines)
  end
end

function UICharDunShopVer2:RefreshCharDunShopVer2()
  local itemCount = PlayerDataCenter:GetItemCount(self._heroGrowData:GetHeroGrowCostId())
  for k, v in pairs(self._itemDic) do
    v:RefreshCharDunShopVer2Item()
  end
  for i, v in ipairs(self._lineHorizePool.listItem) do
    v:RefreshCharDunShopVer2Line(itemCount)
  end
  for i, v in ipairs(self._lineVerticalPool.listItem) do
    v:RefreshCharDunShopVer2Line(itemCount)
  end
  self.ui.tex_TokenNum.text = tostring(itemCount)
  local allCfg = ConfigData.activity_hero_token_reward[self._heroGrowData:GetActId()]
  local curLevel = 0
  local nextLvScore = 0
  for i, v in ipairs(allCfg) do
    if itemCount < v.need_token then
      nextLvScore = v.need_token
      break
    end
    curLevel = i
  end
  self.ui.tex_Lvl.text = tostring(curLevel)
  if nextLvScore == 0 then
    self.ui.text:SetIndex(1)
    self.ui.tex_Exp.text = "MAX"
  else
    self.ui.text:SetIndex(0)
    self.ui.tex_Exp.text = tostring(nextLvScore - itemCount)
  end
  self.ui.btn_GetAll.gameObject:SetActive(self._heroGrowData:IsHeroGrowExistLvReward())
end

function UICharDunShopVer2:__CountDown()
  local diff = self._heroGrowData:GetActivityDestroyTime() - PlayerDataCenter.timestamp
  if diff < 0 then
    self.ui.tex_Day:SetIndex(3, "0")
    return
  end
  local d, h, m, s = TimeUtil:TimestampToTimeInter(diff, false, true)
  if 0 < d then
    self.ui.tex_Day:SetIndex(1, tostring(d))
  elseif 0 < h then
    self.ui.tex_Day:SetIndex(2, tostring(h))
  elseif 0 < m then
    self.ui.tex_Day:SetIndex(3, tostring(m))
  else
    self.ui.tex_Day:SetIndex(3, "0")
  end
end

function UICharDunShopVer2:__OnInstantiateItem(go)
  local item = UINCharDunShopVer2Item.New()
  item:Init(go)
  self._itemDic[go] = item
end

function UICharDunShopVer2:__OnChangeItem(go, index)
  local item = self._itemDic[go]
  if item == nil then
    if isGameDev then
      error("scoreItem is nil " .. tostring(index))
    end
    return
  end
  local lv = self._lvSort[index + 1]
  item:InitCharDunShopVer2Item(self._heroGrowData, lv, self.__OnRewardOneCallback)
  self:__CreateItemLine(item)
end

function UICharDunShopVer2:__OnReturnItem(go)
  local item = self._itemDic[go]
  self:__CycleItemLine(item)
end

function UICharDunShopVer2:__ItemUpdate(updateItem)
  if updateItem[self._heroGrowData:GetHeroGrowCostId()] == nil then
    return
  end
  self:RefreshCharDunShopVer2()
end

function UICharDunShopVer2:__OnRewardOne(lv, item)
  if self._heroGrowData:IsHeroGrowLvReceived(lv) then
    return
  end
  local allCfg = ConfigData.activity_hero_token_reward[self._heroGrowData:GetActId()]
  if allCfg[lv] == nil or allCfg[lv].need_token > PlayerDataCenter:GetItemCount(self._heroGrowData:GetHeroGrowCostId()) then
    return
  end
  self._heroGrowData:ReqHeroGrowSingleTokenReward(lv, function()
    if IsNull(self.transform) then
      return
    end
    self:RefreshCharDunShopVer2()
  end)
end

function UICharDunShopVer2:OnClickRewardAll()
  if not self._heroGrowData:IsHeroGrowExistLvReward() then
    return
  end
  self._heroGrowData:ReqHeroGrowAllTokenReward(function()
    if IsNull(self.transform) then
      return
    end
    self:RefreshCharDunShopVer2()
  end)
end

function UICharDunShopVer2:OnClickCloseShopVer2()
  self:Delete()
  if self._callback then
    self._callback()
  end
end

function UICharDunShopVer2:OnDelete()
  self._resloader:Put2Pool()
  self._resloader = nil
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__ItemUpdateCallback)
  TimerManager:StopTimer(self._timerId)
  self._timerId = nil
  base.OnDelete(self)
end

return UICharDunShopVer2
