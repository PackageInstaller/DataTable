local ActivitySkinLimitController = class("ActivitySkinLimitController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local ActivitySkinLimitData = require("Game.ActivitySkinLimit.Data.ActivitySkinLimitData")
local cs_MessageCommon = CS.MessageCommon

function ActivitySkinLimitController:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.activity_skinlimit_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_skinlimit_skin)
  self._dataDic = {}
  self.__TaskChangeCallback = BindCallback(self, self.TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
end

function ActivitySkinLimitController:InitSkinLimit(msg)
  local data = ActivitySkinLimitData.New()
  self._dataDic[msg.actId] = data
  data:InitSkinLimitData(msg)
  return data
end

function ActivitySkinLimitController:ShowSkinLimitMainByActId(actId)
  local data = self:GetSkinLimitDataByActId(actId)
  if data == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ActivitySkinLimitMain, function(win)
    if win == nil then
      return
    end
    win:InitSkinLimitMain(actId)
  end)
end

function ActivitySkinLimitController:GetSkinLimitDataByActId(actId)
  return self._dataDic[actId]
end

function ActivitySkinLimitController:RemoveSkinLimit(actId)
  self._dataDic[actId] = nil
end

function ActivitySkinLimitController:IsHaveSkinLimit()
  return table.count(self._dataDic) > 0
end

function ActivitySkinLimitController:OnClickSkinLimitPreset(heroId, skinCfg)
  local adjData = PlayerDataCenter.allAdjCustomData:GetAdjCustomPresetData(1)
  if adjData ~= nil and adjData:GetAdjMainHeroSkinId() == skinCfg.id then
    return
  end
  if not PlayerDataCenter:ContainsHeroData(heroId) then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9710))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    
    local function confimFunc()
      PlayerDataCenter.allAdjCustomData:TryAdjSkinChange(heroId, skinCfg.id, 1)
      PlayerClickCollectManager:BtnClickNumCollect(1023)
    end
    
    win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(9709), confimFunc)
  end)
end

function ActivitySkinLimitController:OnClickSkinLimitExperience(skinCfg, skinLimitData, callback)
  local itemId = ConstGlobalItem.SkinLimit
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("cant find item id:" .. itemId)
    return
  end
  local itemCount = PlayerDataCenter:GetItemCount(itemId)
  local useCount = 1
  if itemCount < useCount then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win == nil then
      return
    end
    
    local function confimFunc()
      local heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
      local WarehouseNetwork = NetworkManager:GetNetwork(NetworkTypeID.Warehouse)
      WarehouseNetwork:CS_BACKPACK_SelectItem(itemId, useCount, {
        skinLimitData.item_id
      }, function()
        UIManager:ShowWindowAsync(UIWindowTypeID.GetHeroSkin, function(window)
          if window == nil then
            return
          end
          window:InitGetHeroSkin(skinCfg, callback)
        end)
      end)
      PlayerClickCollectManager:BtnClickNumCollect(1022)
    end
    
    local d = TimeUtil:TimestampToTimeInter(skinLimitData.duration, false, true)
    local tipStr = string.format(ConfigData:GetTipContent(9707), LanguageUtil.GetLocaleText(itemCfg.name), d, LanguageUtil.GetLocaleText(skinCfg.name))
    win:ShowTextBoxWithYesAndNo(tipStr, confimFunc)
  end)
end

function ActivitySkinLimitController:TaskProcessUpdate()
  for k, v in pairs(self._dataDic) do
    v:__RefreshSkinLimitRedHasTask()
  end
end

function ActivitySkinLimitController:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_skinlimit_main)
  ConfigData:ReleaseDynCfg(eDynConfigData.activity_skinlimit_skin)
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
end

return ActivitySkinLimitController
