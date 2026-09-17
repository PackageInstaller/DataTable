local this = class("pageShowFish", G_UIPageBase)
local _fishTpl = L_GameTpl:getFishTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local LengthPath = {
  [1] = "UI/Atlas/FishingNew/tex_fishing_bg_tong.png",
  [2] = "UI/Atlas/FishingNew/tex_fishing_bg_yin.png",
  [3] = "UI/Atlas/FishingNew/tex_fishing_bg_jin.png"
}
local AudioEvent = {
  [1] = "Play_SFX_System_Fishing_Reward_Fish_Copper",
  [2] = "Play_SFX_System_Fishing_Reward_Fish_Silver",
  [3] = "Play_SFX_System_Fishing_Reward_Fish_Gold"
}

function this.bind()
  return {
    img_fish = nil,
    img_length_quality = nil,
    txt_length = nil,
    go_new = nil,
    txt_fishName = "",
    txt_fishDesc = "",
    richTxt_exchange = ""
  }
end

function this.methods()
  return {
    onClick_exchange = function(self)
      L_UI:close(self.pageName, nil, function()
        local fishFinish = L_FishingStore:getFishFinish()
        local data = {
          itemId = fishFinish:getFishId()
        }
        C_BagMgr:reqExchangeItem(data, function(rewards)
          L_FlyMsgManager:showItemServerRewards(rewards)
        end, true)
      end)
    end,
    onClick_collect = function(self)
      L_UI:close(self.pageName, nil, function()
        local fish = L_FishingStore:getFishFinish()
        L_FlyMsgManager:showItemServerRewards(fish:getRewards())
      end)
    end
  }
end

function this:escHandle()
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:initPage()
end

function this:close(options)
  this.super.close(self, options)
end

function this:initPage()
  self:initFish()
  self:initFishInfo()
end

function this:initFish()
  local fishFinish = L_FishingStore:getFishFinish()
  local tpl_commonItem = _commonItemTpl:getTplById(fishFinish:getFishId())
  self.bind.img_fish = _commonItemTpl:getIcon(tpl_commonItem)
  local subId = _commonItemTpl:getSubId(tpl_commonItem)
  local length = fishFinish:getFishWeight()
  local tpl_fish = _fishTpl:getTplById(subId)
  self.bind.txt_length = string.format("%.2fCM", length / 10000)
  local lengthQuality = _fishTpl:getLengthQuality(tpl_fish, length)
  self.bind.img_length_quality = LengthPath[lengthQuality]
  self.bind.go_new = fishFinish:getFishStatus() == L_Const.FishWeightStatusType.FWST_NEW
  C_AudioManager.Play(AudioEvent[lengthQuality])
end

function this:initFishInfo()
  local fishFinish = L_FishingStore:getFishFinish()
  local item = L_ItemTplManager:getCommonItem(fishFinish:getFishId())
  local tpl_rarity = L_RarityTpl:getTplById(item.quality)
  self.bind.txt_fishName = L_GameUtil.fillColor(item.name, L_Const.colorHtml[L_RarityTpl:getColor(tpl_rarity)])
  self.bind.txt_fishDesc = item.desc
  L_GameUtil.forceRebuildLayout(self.bindComponents.rect_content)
  local commonItemChangeTpl = L_GameTpl:getCommonItemChangeTpl()
  local tpl_exchange = commonItemChangeTpl:getTplByTypeAndId(L_Const.resType.commonItem, fishFinish:getFishId())
  local reward = L_DataUtil.parseRewardConfigItem(commonItemChangeTpl:getChange(tpl_exchange)[1])
  local configData = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
  self.bind.richTxt_exchange = L_WordsTpl:getValue("ui_fish_process_num", {
    [0] = configData.icon,
    [1] = reward.itemNum
  })
end

return this
