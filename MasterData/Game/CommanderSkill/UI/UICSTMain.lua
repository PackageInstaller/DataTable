local UICSTMain = class("UICSTMain", UIBaseWindow)
local base = UIBaseWindow
local UINCSTreeTogItem = require("Game.CommanderSkill.UI.Main.UINCSTreeTogItem")
local UINCSTSkill = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkill")
local UINCSTSkillDetail = require("Game.CommanderSkill.UI.SkillDetail.UINCSTSkillDetail")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader

function UICSTMain:OnInit()
  self.ui.treeItem:SetActive(false)
  self.treeItemPool = UIItemPool.New(UINCSTreeTogItem, self.ui.treeItem)
  self._selectTreeFunc = BindCallback(self, self._OnSelectTree)
  self.skillNode = UINCSTSkill.New(self)
  self.skillNode:Init(self.ui.skillNode)
  self.skillDetailNode = UINCSTSkillDetail.New()
  self.skillDetailNode:Init(self.ui.cSTDetailNode)
  self.skillDetailNode:Hide()
  self.resLoader = cs_ResLoader.Create()
  UIUtil.SetTopStatus(self, self._OnClickReturn)
  UIUtil.SetTopStatusBtnShow(false, false)
end

function UICSTMain:InitCSTMain(cmdSkillCtrl, cstDataList, curCSTId)
  self.cmdSkillCtrl = cmdSkillCtrl
  self.cstDataList = cstDataList
  self.treeItemPool:HideAll()
  for cstId, cstData in ipairs(self.cstDataList) do
    local treeTogItem = self.treeItemPool:GetOne()
    treeTogItem:InitCSTreeTogItem(cstData, self._selectTreeFunc)
    if cstId == self.curCSTId then
      treeTogItem:SetCSTreeTogItemSelect(true)
    end
  end
  self:_OnSelectTree(curCSTId)
end

function UICSTMain:ShowCSTSkillDetail(skillData)
  self.skillDetailNode:Show()
  AudioManager:PlayAudioById(1067)
  local slotIndex = skillData:GetCSTSkillSlot()
  local realSkillId = skillData:GetCSTSkillRealSkilllId()
  local surSkillData = self.curCSTData:GetCSTCurSkillDataBySlot(slotIndex)
  local isEquip = surSkillData ~= nil and surSkillData:GetCSTSkillRealSkilllId() == realSkillId
  self.skillDetailNode:InitCSTSkillDetail(self.cmdSkillCtrl, skillData, self.resLoader, isEquip)
  if skillData:GetCSTSkillSlot() == 3 then
    self.skillDetailNode.transform.position = self.ui.detailPosLeft.position
  else
    self.skillDetailNode.transform.position = self.ui.detailPosRight.position
  end
end

function UICSTMain:HideCSTSkillDetail()
  AudioManager:PlayAudioById(1068)
  self.skillDetailNode:HideSelf()
end

function UICSTMain:_OnSelectTree(treeId)
  if self.curCSTId == treeId then
    return
  end
  local cstData = self.cstDataList[treeId]
  if not cstData:IsCmdTreeUnlock() then
    cs_MessageCommon.ShowMessageTips(cstData:GetCmdSkillTreeUnlockInfo())
    return
  end
  self.curCSTId = treeId
  self.curCSTData = cstData
  self.skillNode:InitUINCSTSkill(cstData, self.resLoader)
  self.cmdSkillCtrl:SelectCmdSkillTree(treeId)
  for _, item in ipairs(self.treeItemPool.listItem) do
    item:SetCSTreeTogItemSelect(item:GetCSTTogTreeId() == treeId)
  end
end

function UICSTMain:_OnClickReturn(tohome)
  self.cmdSkillCtrl:ExitCmdSkill(tohome)
  self:Delete()
end

function UICSTMain:OnDelete()
  self.resLoader:Put2Pool()
  self.resLoader = nil
  self.treeItemPool:DeleteAll()
  self.skillNode:Delete()
  self.skillDetailNode:Delete()
  base.OnDelete(self)
end

return UICSTMain
