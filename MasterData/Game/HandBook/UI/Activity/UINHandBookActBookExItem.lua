local UINHandBookActBookExItem = class("UINHandBookActBookExItem", UIBaseNode)
local base = UIBaseNode
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local HandBookActReviewFunc = require("Game.HandBook.UI.Activity.HandBookActReviewFunc")
local CS_DOTween = CS.DG.Tweening.DOTween

function UINHandBookActBookExItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.item, self, self.OnClickEnterActEx)
  UIUtil.AddButtonListener(self.ui.btn_RewardBg, self, self.OnClickRewardActEx)
end

function UINHandBookActBookExItem:InitActBookExItem(enterType, actFramId, enterFunc, honorWallFunc, resloader)
  self._actFrameId = actFramId
  self._enterFunc = enterFunc
  self._honorWallFunc = honorWallFunc
  self._cfg = ConfigData.handbook_activity[enterType].content[actFramId]
  local activityCfg = ConfigData.activity[actFramId]
  if activityCfg ~= nil then
    local activityNameCfg = ConfigData.activity_name[activityCfg.name_id]
    self.ui.tex_ActName.text = LanguageUtil.GetLocaleText(activityNameCfg.name)
  end
  self.ui.bottom.gameObject:SetActive(false)
  if #self._cfg.object_pic == 0 then
    error("res is NIL")
  else
    resloader:LoadABAssetAsync(PathConsts:GetHandbookItemPic(self._cfg.object_pic), function(texture)
      if IsNull(texture) or IsNull(self.transform) or texture.name ~= self._cfg.object_pic then
        return
      end
      self.ui.bottom.gameObject:SetActive(true)
      self.ui.bottom.texture = texture
    end)
  end
  self._totalRewardCount = #self._cfg.reward_list
  self.ui.btn_RewardBg.gameObject:SetActive(0 < self._totalRewardCount)
  if 0 < self._totalRewardCount then
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
  local CPRData = HandBookActReviewFunc[activityCfg.type](activityCfg.activity_id)
  local total, unlockCount = CPRData:GetCPRAvgGroupUnlockNum()
  self.ui.tex_avg_Progress.text = tostring(unlockCount) .. "/" .. tostring(total)
end

function UINHandBookActBookExItem:PlayBookExAni(delayTime)
  if self._tween ~= nil then
    self._tween:Kill()
    self._tween = nil
  end
  self.ui.canvasGroup.alpha = 1
  self.ui.canvasGroup:DOFade(0, 0.2):From():SetDelay(delayTime)
  self._tween = CS_DOTween.Sequence()
  self._tween:AppendInterval(delayTime)
  self._tween:AppendCallback(function()
    self.ui.ani_item:Play()
  end)
end

function UINHandBookActBookExItem:OnClickEnterActEx()
  if self._enterFunc ~= nil then
    self._enterFunc(self._actFrameId)
  end
end

function UINHandBookActBookExItem:OnClickRewardActEx()
  if self._honorWallFunc ~= nil then
    self._honorWallFunc(self._actFrameId, self.ui.btn_RewardBg.transform.position)
  end
end

function UINHandBookActBookExItem:OnDelete()
  if self._tween ~= nil then
    self._tween:Kill()
    self._tween = nil
  end
  self.ui.canvasGroup:DOComplete()
  base.OnDelete(self)
end

return UINHandBookActBookExItem
