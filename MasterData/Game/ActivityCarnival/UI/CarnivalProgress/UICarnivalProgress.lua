local base = UIBaseWindow
local UICarnivalProgress = class("UICarnivalProgress", base)
local UINCarnivalEmptyItem = require("Game.ActivityCarnival.UI.CarnivalProgress.UINCarnivalEmptyItem")
local cs_MessageCommon = CS.MessageCommon
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local cs_MessageCommon = CS.MessageCommon

function UICarnivalProgress:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self._OnClickGetAll)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self._OnClickInfo)
  self._OnPickRewardLevelFunc = BindCallback(self, self._OnPickRewardLevel)
  self._OnPickCycleRewardFunc = BindCallback(self, self._OnPickCycleReward)
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._ItemDic = {}
  self._OnExpLevelChnageFunc = BindCallback(self, self._OnExpLevelChnage)
  MsgCenter:AddListener(eMsgEventId.ActivityCarnivalExpLevelChange, self._OnExpLevelChnageFunc)
  self._OnJumpItemCallback = BindCallback(self, self._OnJumpItem)
end

function UICarnivalProgress:BindCarnivalJumpEnvFunc(func)
  self._jumpEnvFunc = func
end

function UICarnivalProgress:BindCarnivalJumpSectorStageFunc(func)
  self._jumpSectorStageFunc = func
end

function UICarnivalProgress:InitCarnivalProgress(carnivalData, callback)
  self._carnivalData = carnivalData
  self:_UpdExpLevel(carnivalData)
  self:_RefillScrollRect()
  self._callback = callback
end

function UICarnivalProgress:_UpdExpLevel(carnivalData)
  local curlevel, exp = carnivalData:GetCarnivalLevelExp()
  self._curlevel = curlevel
  self.ui.tex_Level:SetIndex(0, tostring(curlevel))
  local cnvExpCfg = carnivalData:GetCarnivalExpCfg()
  local maxLv = carnivalData:GetCarnivalMaxLevel()
  local levelDataList = {}
  for i = 1, maxLv do
    local expCfg = cnvExpCfg[i]
    if expCfg == nil then
      error("Cant get CarnivalExpCfg, level = " .. tostring(i))
    else
      table.insert(levelDataList, {
        level = i,
        carnivalExpCfg = expCfg,
        curLevel = curlevel,
        curExp = exp,
        maxLevel = maxLv
      })
    end
  end
  self.levelDataList = levelDataList
  self:_UpdPickAll()
end

function UICarnivalProgress:_RefillScrollRect()
  self.ui.scrollRect.totalCount = #self.levelDataList + 1
  if self._curlevel > self.ui.scrollRect.totalCount - 4 then
    self.ui.scrollRect:RefillCellsFromEnd()
  else
    local offsetIndex = math.max(self._curlevel - 4, 0)
    self.ui.scrollRect:RefillCells(offsetIndex)
  end
  self.ui.scrollRect:RefreshCells()
end

function UICarnivalProgress:_UpdateScrollRect()
  self.ui.scrollRect:RefreshCells()
end

function UICarnivalProgress:_UpdPickAll()
  local pickableAll = false
  for i = 1, self._curlevel do
    if not self._carnivalData:IsReceivedLevelReward(i) then
      pickableAll = true
      break
    end
  end
  pickableAll = pickableAll or self._carnivalData:IsCanCarnivalCycleReward()
  self.ui.btn_ReceiveAll.targetGraphic.color = pickableAll and Color.white or Color.gray
  self._pickableAll = pickableAll
end

function UICarnivalProgress:__OnNewItem(go)
  local item = UINCarnivalEmptyItem.New()
  item:Init(go)
  self._ItemDic[go] = item
end

function UICarnivalProgress:__OnChangeItem(go, index)
  local item = self._ItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  if index + 1 <= #self.levelDataList then
    local levelData = self.levelDataList[index + 1]
    if levelData == nil then
      error("Can't find levelData by index, index = " .. tonumber(index))
    end
    local isGetReward = self._carnivalData:IsReceivedLevelReward(levelData.level)
    item:InitCarnivalNormalItem(self._carnivalData, levelData, isGetReward, self._OnPickRewardLevelFunc, self._OnJumpItemCallback)
  else
    item:InitCarnivalCycleItem(self._carnivalData, self._OnPickCycleRewardFunc)
  end
end

function UICarnivalProgress:_OnPickRewardLevel(level)
  self._carnivalData:ReqCarnivalLevelReward(level, function()
    if not IsNull(self.transform) then
      self:_OnPickReward()
    end
  end)
end

function UICarnivalProgress:_OnPickCycleReward()
  self._carnivalData:ReqCarnivalCycleReward(function()
    if not IsNull(self.transform) then
      self:_OnPickReward()
    end
  end)
end

function UICarnivalProgress:_OnClickGetAll()
  if not self._pickableAll then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7117))
    return
  end
  self._carnivalData:ReqCarnivalAllReward(function()
    if not IsNull(self.transform) then
      self:_OnPickReward()
    end
  end)
end

function UICarnivalProgress:_OnJumpItem(levelData)
  if levelData.curLevel < levelData.level then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7122, tostring(levelData.level)))
    return
  end
  local envId = ConfigData.activity_carnival_env.levelEnvDic[self._carnivalData:GetActId()][levelData.level]
  if 0 < (envId or 0) then
    if not self._carnivalData:IsActivityRunning() then
      return
    end
    local sectorId = self._carnivalData:GetCarnivalMainCfg().main_stage
    if SectorStageDetailHelper.IsSectorHasUnComplete(sectorId) or not SectorStageDetailHelper.IsSectorNoCollide(sectorId) then
      local playerModule = SectorStageDetailHelper.SectorPlayMoudle(sectorId)
      SectorStageDetailHelper.TryToShowCurrentLevelTips(playerModule)
      return
    end
    if self._jumpEnvFunc ~= nil then
      self._jumpEnvFunc(envId)
    end
  elseif 0 < levelData.carnivalExpCfg.unlock_story then
    if self._jumpSectorStageFunc ~= nil then
      self._jumpSectorStageFunc(levelData.carnivalExpCfg.unlock_story, true)
    end
  elseif 0 < levelData.carnivalExpCfg.unlock_sector_stage and self._jumpSectorStageFunc ~= nil then
    self._jumpSectorStageFunc(levelData.carnivalExpCfg.unlock_sector_stage, false)
  end
end

function UICarnivalProgress:_OnPickReward()
  self:_UpdPickAll()
  self:_UpdateScrollRect()
end

function UICarnivalProgress:_OnClickInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.Carnival22InfoWindow, function(win)
    if win == nil then
      return
    end
    win:InitCarnivalInfoWindow(self._carnivalData:GetCarnivalMainCfg().exp_rule_id)
  end)
end

function UICarnivalProgress:_OnExpLevelChnage()
  self:_UpdExpLevel(self._carnivalData)
  self:_UpdateScrollRect()
end

function UICarnivalProgress:_OnClickBack()
  self:Delete()
  if self._callback then
    self._callback()
  end
end

function UICarnivalProgress:OnDelete()
  for k, v in pairs(self._ItemDic) do
    v:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.ActivityCarnivalExpLevelChange, self._OnExpLevelChnageFunc)
  base.OnDelete(self)
end

return UICarnivalProgress
