local UINBtnCommanderSkill = class("UINBtnCommanderSkill", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINCommanderSkill = require("Game.Formation.UI.2DFormation.UINCommanderSkill")
local CSTData = require("Game.CommanderSkill.CSTData")

function UINBtnCommanderSkill:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_CommanderSkill, self, self.OnClickItem)
  self.ui.skillItem:SetActive(false)
  self.itemPool = UIItemPool.New(UINCommanderSkill, self.ui.skillItem)
  self.ui.redDot:SetActive(false)
end

function UINBtnCommanderSkill:InitBtnCommanderSkill(resloader, clickFunc)
  self.resloader = resloader
  self.clickFunc = clickFunc
end

function UINBtnCommanderSkill:InitBtnCommanderSkill4FmtCtrl(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
  self.resloader = fmtCtrl:GetFmtCtrlResloader()
end

function UINBtnCommanderSkill:RefreshCstByTreeInfo(cstTreeData, cstDataList)
  self.cstTreeData = cstTreeData
  self.cstDataList = cstDataList
  self.treeId = cstTreeData.treeId
  self.skills = cstTreeData:GetUsingCmdSkillList()
  self.isFixed = false
  self:__RefreshCstBtnUI()
end

function UINBtnCommanderSkill:RefreshCstByIdAndList(treeId, skills, isFixed, fairyData)
  self.isFixed = isFixed
  if not isFixed and treeId ~= 0 then
    local fakeSkills = {}
    for index, value in ipairs(skills) do
      table.insert(fakeSkills, {skillId = value})
    end
    local cstTreeData = CSTData.New({id = treeId, skills = fakeSkills}, fairyData)
    self.cstTreeData = cstTreeData
    self.treeId = cstTreeData.treeId
    self.skills = cstTreeData:GetUsingCmdSkillList()
  else
    self.treeId = treeId
    self.skills = skills
  end
  self:__RefreshCstBtnUI()
end

function UINBtnCommanderSkill:__RefreshCstBtnUI()
  local treeCfg = ConfigData.commander_skill[self.treeId]
  if treeCfg == nil or self.isFixed then
    self.ui.img_ComSkillIcon.gameObject:SetActive(false)
    self.ui.tex_ComSkillName:SetIndex(1)
  else
    local treeName = LanguageUtil.GetLocaleText(treeCfg.name)
    self.ui.tex_ComSkillName:SetIndex(0, treeName)
    self.ui.img_ComSkillIcon.gameObject:SetActive(false)
    self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      self.ui.img_ComSkillIcon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, treeCfg.icon)
      self.ui.img_ComSkillIcon.gameObject:SetActive(true)
    end)
  end
  self.itemPool:HideAll()
  local cstUnlockCfg = ConfigData.commander_skill_unlock[self.treeId or 0]
  if cstUnlockCfg ~= nil then
    table.sort(self.skills, function(a, b)
      local cstsIda = ConfigData.commander_skill_unlock.realSkillId2CSTSIdDic[a]
      local cstsIdb = ConfigData.commander_skill_unlock.realSkillId2CSTSIdDic[b]
      local aCfg = cstUnlockCfg[cstsIda]
      local bCfg = cstUnlockCfg[cstsIdb]
      local aPlace = math.maxinteger
      local bPlace = math.maxinteger
      if aCfg ~= nil then
        aPlace = aCfg.place
      end
      if bCfg ~= nil then
        bPlace = bCfg.place
      end
      if aPlace ~= bPlace then
        return aPlace < bPlace
      end
      return a < b
    end)
  end
  if self.skills ~= nil and 0 < #self.skills then
    for index, skillId in ipairs(self.skills) do
      local cstsId = ConfigData.commander_skill_unlock.realSkillId2CSTSIdDic[skillId]
      if self.isFixed or cstUnlockCfg ~= nil and cstUnlockCfg[cstsId] ~= nil then
        local item = self.itemPool:GetOne()
        item.gameObject.name = tostring(index)
        item:InitCommanderSkill(skillId, self.resloader)
      end
    end
  end
  if not self.isFixed then
    local hasOverloadSkill2Install = self.cstTreeData:CSTHasOverloadSkill2Install()
    self.ui.redDot:SetActive(hasOverloadSkill2Install)
  end
end

function UINBtnCommanderSkill:GetCmderSkillItemByIndex(index)
  return self.itemPool.listItem[index]
end

function UINBtnCommanderSkill:SetCmderRootRaycastActive(active)
  self.ui.cg_CmderSkill.blocksRaycasts = active
end

function UINBtnCommanderSkill:OnClickItem()
  if self.clickFunc ~= nil then
    self.clickFunc(self.cstTreeData, self.cstDataList)
    return
  end
  local isFixed, skills = self.enterFmtData:GetFixedCstSkills()
  if isFixed then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.CstFixed))
    return
  end
  local commanderSkillCtrl = ControllerManager:GetController(ControllerTypeId.CommanderSkill, true)
  commanderSkillCtrl:InitCmdSkillCtrl(self.cstTreeData, self.cstDataList, function()
    self.fmtCtrl:OnFmtCloseCSTUI()
  end, function(cstDataList, selectedTreeId)
    self.fmtCtrl:SaveFmtCSTChange(cstDataList, selectedTreeId)
  end, function()
    self.fmtCtrl:OnFmtOpenCSTUI()
  end)
end

return UINBtnCommanderSkill
