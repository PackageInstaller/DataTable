local base = UIBaseNode
local UINCharDunNormalQuestMapItem = class("UINCharDunNormalQuestMapItem", base)
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINCharDunNormalQuestMapItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Touch, self, self.__OnClick)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItemWithCount, false)
end

function UINCharDunNormalQuestMapItem:InitCharDunNormalQuestMapItem(dunStagId, normalData, heroGrowV3Data, clikcCallback, resloader)
  self.dunStagId = dunStagId
  self.normalData = normalData
  self.clikcCallback = clikcCallback
  self.resloader = resloader
  self.heroGrowV3Data = heroGrowV3Data
  self:__RefreshDeco()
  self:__RefreshDyn()
end

function UINCharDunNormalQuestMapItem:SetCharDunNormalQuestMapItemPos(isUp, isLast)
  if isUp then
    self.ui.holder.anchoredPosition = Vector2.Temp(0, 116)
    self.ui.line.localScale = Vector3.Temp(1, -1, 1)
  else
    self.ui.holder.anchoredPosition = Vector2.zero
    self.ui.line.localScale = Vector3.one
  end
  self.ui.line.gameObject:SetActive(not isLast)
end

function UINCharDunNormalQuestMapItem:__RefreshDeco()
  local showCfg = self.normalData:GetHGV3NormalDunLevelItemShowCfg(self.dunStagId)
  local iconResName = showCfg.dungeon_icon
  self.ui.Img_Icon.sprite = AtlasUtil.GetSpriteFromAtlas("SectorLevelIcon", iconResName, self.resloader)
  self.ui.Tex_Stage:SetIndex(0, showCfg.dungeon_name)
  local decoColor = self.heroGrowV3Data:GetHGV3DecoColor()
  for _, colorComp in pairs(self.ui.color_array) do
    colorComp.color = decoColor
  end
end

function UINCharDunNormalQuestMapItem:__RefreshDyn()
  local curIndex = self.normalData:GetHGV3CurLvProgress()
  local index = self.normalData:GetHGV3StageIndex(self.dunStagId)
  local isCur = index == curIndex + 1
  self.ui.obj_Tip:SetActive(not isCur)
  local isUnlock = index <= curIndex + 1
  self.ui.Obj_Lock:SetActive(not isUnlock)
  self.ui.Img_Locked:SetActive(not isUnlock)
  local isComplete = isUnlock and curIndex >= index
  self.ui.Img_Completed:SetActive(isComplete)
  if not isCur then
    if not isUnlock then
      local preIndex = index - 1
      if preIndex <= 9 then
        self.ui.Tex_Addition:SetIndex(1, "0" .. tostring(preIndex))
      else
        self.ui.Tex_Addition:SetIndex(1, tostring(preIndex))
      end
    elseif isComplete then
      self.ui.Tex_Addition:SetIndex(0)
    end
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.obj_Tip.transform)
  local isPicked = self.normalData:GetHGV3IsRewardPicked(self.dunStagId)
  self.ui.go_RewardReceived:SetActive(isPicked)
  self.ui.go_RewardList:SetActive(not isPicked)
  if not isPicked then
    self.rewardItemPool:HideAll()
    local idList, numList = self.normalData:GetHGVFirstClearRewards(self.dunStagId)
    for index, itemId in ipairs(idList) do
      local itemCfg = ConfigData.item[itemId]
      local num = numList[index]
      local item = self.rewardItemPool:GetOne()
      item:InitItemWithCount(itemCfg, num)
    end
  end
  self.ui.go_infoGroup.transform:SetAsLastSibling()
end

function UINCharDunNormalQuestMapItem:__OnClick()
  local curIndex = self.normalData:GetHGV3CurLvProgress()
  local index = self.normalData:GetHGV3StageIndex(self.dunStagId)
  local isUnlock = index <= curIndex + 1
  if not isUnlock then
    return
  end
  local isComplete = curIndex >= index
  if isComplete then
    return
  end
  if self.clikcCallback ~= nil then
    self.clikcCallback(self.dunStagId)
  end
end

function UINCharDunNormalQuestMapItem:PlayQuestMapItemSingleAni(delayTime)
  self:__StopTween()
  self.ui.item_canvasGroup:DOFade(0, 0.3):From():SetDelay(delayTime):SetLink(self.gameObject)
  self.ui.line_canvasGroup:DOFade(0, 0.3):From():SetDelay(delayTime + 0.07):SetLink(self.gameObject)
end

function UINCharDunNormalQuestMapItem:__StopTween()
  self.ui.item_canvasGroup:DOComplete()
  self.ui.line_canvasGroup:DOComplete()
end

function UINCharDunNormalQuestMapItem:OnDelete()
  base.OnDelete(self)
end

return UINCharDunNormalQuestMapItem
