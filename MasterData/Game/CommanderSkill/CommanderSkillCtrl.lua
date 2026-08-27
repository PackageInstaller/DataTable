local base = ControllerBase
local CommanderSkillCtrl = class("CommanderSkillCtrl", base)
local CSTUtil = require("Game.CommanderSkill.CSTUtil")
local CSTData = require("Game.CommanderSkill.CSTData")

function CommanderSkillCtrl:OnInit()
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
end

function CommanderSkillCtrl:InitCmdSkillCtrl(cstTreeData, cstDataList, confirmFunc, saveChangeFunc, winOpenAction)
  self.cstDataList = cstDataList
  self.confirmFunc = confirmFunc
  self.saveChangeFunc = saveChangeFunc
  self.selectedTreeId = cstTreeData:GetCSTTreeId()
  if self.cstDataList == nil then
    self.cstDataList = self:GenTreeDataList(cstTreeData)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CSTMain, function(window)
    if window == nil then
      return
    end
    window:InitCSTMain(self, self.cstDataList, self.selectedTreeId)
    local func = winOpenAction
    if func ~= nil then
      winOpenAction = nil
      func()
    end
  end)
end

function CommanderSkillCtrl:RefreshCmdSkillCtrl(cstTreeData, cstDataList, fairyReplaceCSTSkillDic)
  local uiCstMain = UIManager:GetWindow(UIWindowTypeID.CSTMain)
  if uiCstMain == nil then
    return
  end
  self.cstDataList = cstDataList
  self.selectedTreeId = cstTreeData:GetCSTTreeId()
  uiCstMain:InitCSTMain(self, self.cstDataList, self.selectedTreeId)
end

function CommanderSkillCtrl:GenTreeDataList(cstTreeData)
  local cstDataList = {}
  local curCSTId = cstTreeData:GetCSTTreeId()
  local fairyData = cstTreeData:GetFairy4CST()
  for treeId, treeCfg in ipairs(ConfigData.commander_skill) do
    local treeData
    if treeId == curCSTId then
      local savingTreeMsg = cstTreeData:GetCSTSavingData()
      treeData = CSTData.New(savingTreeMsg, fairyData)
    else
      local defaultSavingData = CSTUtil.GetDefaultSavingData(treeId)
      treeData = CSTData.New(defaultSavingData, fairyData)
      local dfaultTreeData = PlayerDataCenter.cstDataDic[treeId]
      if dfaultTreeData ~= nil then
        treeData:ApplySavingData(dfaultTreeData:GetUsingCmdSkillList())
      end
    end
    table.insert(cstDataList, treeData)
  end
  return cstDataList
end

function CommanderSkillCtrl:SelectCmdSkillTree(treeId)
  if self.selectedTreeId ~= treeId then
    self.selectedTreeId = treeId
  end
end

function CommanderSkillCtrl:ChangeCSTSlotSkill(slotId, skillId)
  local treeData = self.cstDataList[self.selectedTreeId]
  treeData:SetCSTSkill(slotId, skillId)
  self:_OnChangeCSTSlotSkill(slotId)
end

function CommanderSkillCtrl:_OnChangeCSTSlotSkill(slotId)
  local cmdSkillWindow = UIManager:GetWindow(UIWindowTypeID.CSTMain)
  if cmdSkillWindow == nil then
    return
  end
  cmdSkillWindow.skillNode:CSTSkillCancelSelect()
  cmdSkillWindow.skillNode:UpdateUINCSTSkillAll()
  cmdSkillWindow.skillNode:PlayCSTSkillSlotAnim(slotId)
end

function CommanderSkillCtrl:ExitCmdSkill(tohome)
  if self.saveChangeFunc ~= nil then
    self.saveChangeFunc(self.cstDataList, self.selectedTreeId)
  end
  if self.confirmFunc ~= nil then
    self.confirmFunc()
  end
  self:Delete()
  if not tohome then
    GuideManager:TryTriggerGuide(eGuideCondition.InFormation)
    GuideManager:TryTriggerGuide(eGuideCondition.InFormationSpecial)
  end
end

function CommanderSkillCtrl:OnDelete()
  base.OnDelete(self)
end

return CommanderSkillCtrl
