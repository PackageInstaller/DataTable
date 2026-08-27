local UINHandBookActBookFesItem = class("UINHandBookActBookFesItem", UIBaseNode)
local base = UIBaseNode
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local HandBookActReviewFunc = require("Game.HandBook.UI.Activity.HandBookActReviewFunc")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local HandBookActReviewOpenFunc = require("Game.HandBook.UI.Activity.HandBookActReviewOpenFunc")
local CS_DOTween = CS.DG.Tweening.DOTween

function UINHandBookActBookFesItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.item, self, self.OnClickEnterActFes)
  UIUtil.AddButtonListener(self.ui.rewardBg, self, self.OnClickRewardActFes)
end

function UINHandBookActBookFesItem:InitActBookFesItem(enterType, actFramId, honorWallFunc, resloader)
  self._actFrameId = actFramId
  self._honorWallFunc = honorWallFunc
  self._cfg = ConfigData.handbook_activity[enterType].content[actFramId]
  local activityCfg = ConfigData.activity[actFramId]
  if activityCfg ~= nil then
    local activityNameCfg = ConfigData.activity_name[activityCfg.name_id]
    self.ui.tex_ActName.text = LanguageUtil.GetLocaleText(activityNameCfg.name)
  end
  self.ui.img_ActBg.gameObject:SetActive(false)
  if #self._cfg.object_pic == 0 then
    error("res is NIL")
  else
    resloader:LoadABAssetAsync(PathConsts:GetHandbookItemPic(self._cfg.object_pic), function(texture)
      if IsNull(texture) or IsNull(self.transform) or texture.name ~= self._cfg.object_pic then
        return
      end
      self.ui.img_ActBg.gameObject:SetActive(true)
      self.ui.img_ActBg.texture = texture
    end)
  end
  self._totalRewardCount = #self._cfg.reward_list
  self.ui.rewardBg.gameObject:SetActive(0 < self._totalRewardCount)
  local activityCfg = ConfigData.activity[actFramId]
  local processFunc = HandBookActReviewOpenFunc.ReviewProcessFunc[activityCfg.type]
  local checkIsBlockSpecialLogicFunc = HandBookActReviewOpenFunc.ReviewCheckIsBlockSpecialProcess[activityCfg.type]
  local isBlockSpecialProcess = checkIsBlockSpecialLogicFunc ~= nil and checkIsBlockSpecialLogicFunc(activityCfg.activity_id)
  if not isBlockSpecialProcess and processFunc ~= nil then
    processFunc(activityCfg.activity_id, function(unlockCount, totalCount)
      if IsNull(self.transform) or self._cfg.id ~= activityCfg.id then
        return
      end
      self.ui.tex_avg_Progress:SetIndex(0, tostring(unlockCount), tostring(totalCount))
    end)
  else
    if HandBookActReviewFunc[activityCfg.type] == nil then
      error(string.format("Unsupported HandBookActReviewFunc, type:%s, actFramId:%s", activityCfg.type, actFramId))
      return
    end
    self._CPRData = HandBookActReviewFunc[activityCfg.type](activityCfg.activity_id)
    if self._cfg.repeat_remaster_act_id and #self._cfg.repeat_remaster_act_id > 0 then
      for i, v in pairs(self._cfg.repeat_remaster_act_id) do
        local remasterActivityCfg = ConfigData.activity[v]
        local remasterCPRData = HandBookActReviewFunc[activityCfg.type](remasterActivityCfg.activity_id)
        if remasterCPRData.totalUnlockedNum4Show > self._CPRData.totalUnlockedNum4Show then
          self._CPRData = remasterCPRData
        end
      end
    end
    local totalCount, unlockCount = self._CPRData:GetCPRAvgGroupUnlockNum()
    self.ui.tex_avg_Progress:SetIndex(0, tostring(unlockCount), tostring(totalCount))
  end
  self:__Refresh()
end

function UINHandBookActBookFesItem:__Refresh()
  if self._totalRewardCount > 0 then
    local hasRewardCount = 0
    for i, rewardId in ipairs(self._cfg.reward_list) do
      local itemCfg = ConfigData.item[rewardId]
      if itemCfg.type == eItemType.DormFurniture then
        if PlayerDataCenter.dormBriefData:ExistDormFntItem(rewardId) then
          hasRewardCount = hasRewardCount + 1
        end
      elseif itemCfg.type == eItemType.HeroCard then
        if PlayerDataCenter.heroDic[itemCfg.arg[1]] ~= nil then
          hasRewardCount = hasRewardCount + 1
        end
      elseif itemCfg.type == eItemType.Skin then
        if PlayerDataCenter.skinData:IsHaveSkin(itemCfg.arg[1]) then
          hasRewardCount = hasRewardCount + 1
        end
      elseif 0 < PlayerDataCenter:GetItemCount(rewardId) then
        hasRewardCount = hasRewardCount + 1
      end
    end
    self.ui.tex_reward_Progress.text = tostring(hasRewardCount) .. "/" .. tostring(self._totalRewardCount)
  end
end

function UINHandBookActBookFesItem:PlayBookFesAni(delayTime)
  if self._tween ~= nil then
    self._tween:Kill()
    self._tween = nil
  end
  self.ui.canvasGroup.alpha = 0
  self._tween = CS_DOTween.Sequence()
  self._tween:AppendInterval(delayTime)
  self._tween:AppendCallback(function()
    self.ui.canvasGroup.alpha = 1
    self.ui.ani_item:Play()
  end)
end

function UINHandBookActBookFesItem:OnClickEnterActFes()
  local activityCfg = ConfigData.activity[self._cfg.id]
  local checkIsBlockSpecialLogicFunc = HandBookActReviewOpenFunc.ReviewCheckIsBlockSpecialProcess[activityCfg.type]
  local isBlockSpecialProcess = checkIsBlockSpecialLogicFunc ~= nil and checkIsBlockSpecialLogicFunc(activityCfg.activity_id)
  if not isBlockSpecialProcess and HandBookActReviewOpenFunc.ReviewOpenFunc[activityCfg.type] ~= nil then
    HandBookActReviewOpenFunc.ReviewOpenFunc[activityCfg.type](activityCfg.activity_id)
  else
    UIManager:HideWindow(UIWindowTypeID.HandBookActBookFes)
    HandBookActReviewOpenFunc:OpenHandbookActReview(self._CPRData, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.HandBookActBookFes)
    end)
  end
end

function UINHandBookActBookFesItem:OnClickRewardActFes()
  if self._honorWallFunc ~= nil then
    self._honorWallFunc(self._actFrameId, self.ui.rewardBg.transform.position)
  end
end

function UINHandBookActBookFesItem:OnDelete()
  if self._tween ~= nil then
    self._tween:Kill()
    self._tween = nil
  end
  base.OnDelete(self)
end

return UINHandBookActBookFesItem
