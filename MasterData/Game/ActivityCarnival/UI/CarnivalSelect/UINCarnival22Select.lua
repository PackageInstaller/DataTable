local UINCarnival22Select = class("UINCarnival22Select", UIBaseNode)
local base = UIBaseNode
local UINCarnival22SelectBox = require("Game.ActivityCarnival.UI.CarnivalSelect.UINCarnival22SelectBox")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function UINCarnival22Select:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.select, self, self.OnClickItem)
  self._boxPool = UIItemPool.New(UINCarnival22SelectBox, self.ui.buffBg)
  self.ui.buffBg:SetActive(false)
end

function UINCarnival22Select:InitSelectItem(carnivalData, diffcultyCfg, onClickFunc)
  self._carnivalData = carnivalData
  self._diffcultyCfg = diffcultyCfg
  self._onClickFunc = onClickFunc
  self.ui.tex_ENMode.text = self._diffcultyCfg.difficulty_name_en
  self.ui.tex_CNMode.text = LanguageUtil.GetLocaleText(self._diffcultyCfg.difficulty_name)
  self.ui.tex_CNMode_Des.text = LanguageUtil.GetLocaleText(self._diffcultyCfg.difficulty_des)
  self.ui.tex_Number:SetIndex(0, string.format("%03d", self._diffcultyCfg.id))
  if self._diffcultyCfg.id > #self.ui.colors_mode then
    self.ui.modeBg.color = Color.white
    self.ui.img_info_modeBg:SetIndex(1)
  else
    self.ui.modeBg.color = self.ui.colors_mode[self._diffcultyCfg.id]
    self.ui.img_info_modeBg:SetIndex(0)
  end
  self._boxPool:HideAll()
  for _, catalogId in ipairs(self._diffcultyCfg.catalog) do
    local catalogCfg = ConfigData.activity_carnival_catalog[catalogId]
    if catalogCfg ~= nil then
      local item = self._boxPool:GetOne()
      item:InitSelectBox(catalogCfg.catalog_des, catalogCfg.catalog_des2)
    end
  end
end

function UINCarnival22Select:SetDiffcultySelected(flag)
  self.ui.selected:SetActive(flag)
end

function UINCarnival22Select:RefreshDiffcultyCost(envId)
  local envCfg = self._carnivalData:GetCarnivalEnvCfgById(envId)
  local stageId = envCfg.stage_id[self._diffcultyCfg.id]
  if stageId == nil then
    self.ui.tex_cost_Number.text = "0"
  else
    local stageCfg = ConfigData.sector_stage[stageId]
    local cost = stageCfg.cost_strength_num or 0
    self.ui.tex_cost_Number.text = tostring(cost)
  end
  self:__RefreshUnlock(envId)
end

function UINCarnival22Select:__RefreshUnlock(envId)
  local envCfg = self._carnivalData:GetCarnivalEnvCfgById(envId)
  local stageId = envCfg.stage_id[self._diffcultyCfg.id]
  if stageId ~= nil and PlayerDataCenter.sectorStage:IsStageUnlock(stageId) then
    self._islock = false
    self.ui.img_Locked:SetActive(false)
    return
  end
  self._islock = true
  self.ui.img_Locked:SetActive(true)
  local isHasDiculty = stageId ~= nil
  local firstDiffEnvId = ConfigData.activity_carnival_env.diffStartEnvIdDic[self._carnivalData:GetActId()][self._diffcultyCfg.id]
  local isLockedDiculty = not self._carnivalData:IsCarnivalUnlockEnv(firstDiffEnvId)
  local overriedEnvCfg = self._carnivalData:GetCarnivalEnvCfgById(firstDiffEnvId)
  local overriedStageId = overriedEnvCfg.stage_id[self._diffcultyCfg.id]
  local info = ""
  local logicStageId = stageId
  if isLockedDiculty then
    logicStageId = overriedStageId
  end
  local preStageId
  local isTimeUnLock = true
  if logicStageId ~= nil and ConfigData.sector_stage[logicStageId] ~= nil then
    local overriedStageCfg = ConfigData.sector_stage[logicStageId]
    for i = 1, #overriedStageCfg.pre_condition do
      local condition = overriedStageCfg.pre_condition[i]
      if CheckerTypeId.CompleteStage == condition then
        preStageId = overriedStageCfg.pre_para1[i]
      elseif CheckerTypeId.TimeRange == condition then
        local pc = {
          CheckerTypeId.TimeRange
        }
        local p1 = {
          overriedStageCfg.pre_para1[i]
        }
        local p2 = {
          overriedStageCfg.pre_para2[i]
        }
        if not CheckCondition.CheckLua(pc, p1, p2) then
          info = CheckCondition.GetUnlockInfoLua(pc, p1, p2)
          isTimeUnLock = false
        end
      end
    end
  end
  if isTimeUnLock then
    if isLockedDiculty then
      if preStageId ~= nil and envId >= firstDiffEnvId then
        local preStageCfg = ConfigData.sector_stage[preStageId]
        info = string.format(ConfigData:GetTipContent(7124), LanguageUtil.GetLocaleText(preStageCfg.name)) .. "\n"
      end
      info = info .. string.format(ConfigData:GetTipContent(7125), LanguageUtil.GetLocaleText(overriedEnvCfg.env_name))
    elseif isHasDiculty then
      if preStageId ~= nil then
        local preStageCfg = ConfigData.sector_stage[preStageId]
        info = string.format(ConfigData:GetTipContent(7124), LanguageUtil.GetLocaleText(preStageCfg.name))
      end
    else
      info = string.format(ConfigData:GetTipContent(7125), LanguageUtil.GetLocaleText(overriedEnvCfg.env_name))
    end
  end
  self.ui.tex_Condition.text = info
end

function UINCarnival22Select:GetSelectItemDiffcultyCfg()
  return self._diffcultyCfg
end

function UINCarnival22Select:OnClickItem()
  if self._islock then
    return
  end
  AudioManager:PlayAudioById(1224)
  if self._onClickFunc ~= nil then
    self._onClickFunc(self)
  end
end

return UINCarnival22Select
