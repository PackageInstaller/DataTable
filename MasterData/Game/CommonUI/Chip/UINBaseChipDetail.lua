local UINBaseChipDetail = class("UINBaseChipDetail", UIBaseNode)
local base = UIBaseNode
local UINChipLevel = require("Game.CommonUI.Chip.UINChipLevel")
local UINChipDetailSuitItem = require("Game.CommonUI.Chip.UINChipDetailSuitItem")
local UINChipDetailSuitInfo = require("Game.CommonUI.Chip.UINChipDetailSuitInfo")
local UINRichIntroButtom = require("Game.CommonUI.RichIntro.UINRichIntroButtom")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local cs_Edge = CS.UnityEngine.RectTransform.Edge

function UINBaseChipDetail:OnInit()
  local transform = self.ui.rootTransform == nil and self.transform or self.ui.rootTransform
  UIUtil.LuaUIBindingTable(transform, self.ui)
  self.ui.obj_Level:SetActive(false)
  local suitItem = UINChipDetailSuitItem.New()
  suitItem:Init(self.ui.obj_SuitItem)
  self.suitItem = suitItem
  self.suitInfoNode = UINChipDetailSuitInfo.New()
  self.suitInfoNode:Init(self.ui.chipSuitDetail)
  self.btnRichIntro = UINRichIntroButtom.New()
  self.btnRichIntro:Init(self.ui.obj_RichIntro)
  self.btnRichIntro:InitRichIntroButtom(BindCallback(self, self._ShowRichIntro))
  UIUtil.AddButtonListener(self.ui.btn_suitInfo, self, self._OnClickSuitInfo)
  self._onDescribeChange = BindCallback(self, self._OnDescribeChange)
  MsgCenter:AddListener(eMsgEventId.DescribeSettingChange, self._onDescribeChange)
end

function UINBaseChipDetail:SetBaseChipDetailDynChipSuitMgr(dynChipSuitMgr)
  self._dynChipSuitMgr = dynChipSuitMgr
end

function UINBaseChipDetail:InitBaseChipDetail(index, chipData, dynPlayer, resloader, isHideNxtLvlInfo, isOwnData)
  self.index = index
  self._chipData = chipData
  self._resloader = resloader
  self._isOwnData = isOwnData
  self._dynPlayer = dynPlayer
  self._isHideNxtLvlInfo = isHideNxtLvlInfo
  self.isFirstGet = self:_IsFirstGet(chipData, dynPlayer)
  self.suitInfoNode:Hide()
  self.ui.chipInfoNode:SetActive(true)
  self:_InitChipLevel(chipData, dynPlayer, isHideNxtLvlInfo, isOwnData)
  self:_InitChipPlane(chipData, dynPlayer, isOwnData)
  self:_InitChipDescription(chipData, dynPlayer, isHideNxtLvlInfo)
end

function UINBaseChipDetail:_InitChipPlane(chipData, dynPlayer, isOwnData)
  local quality = chipData:GetQuality()
  local colData = ChipDetailColor[quality]
  self.ui.img_QualityCol.color = colData.normal
  self.ui.img_QualityLightCol.color = colData.light
  self.ui.img_CornerIcon.sprite = CRH:GetSprite(chipData:GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
  self.ui.tex_Name.text = chipData:GetName()
  local isConsumeChip = chipData:IsConsumeSkillChip()
  self.ui.img_Icon.gameObject:SetActive(not isConsumeChip)
  self.ui.skillIconNode:SetActive(isConsumeChip)
  if isConsumeChip then
    local color = chipData:GetColor()
    self.ui.img_SkillIcon.sprite = CRH:GetSprite(chipData:GetIcon(), CommonAtlasType.SkillIcon)
    self.ui.img_SkillQuality.color = color
    self.ui.img_SkillMark.color = color
  else
    local iconSprite = CRH:GetSprite(chipData:GetIcon())
    self.ui.img_Icon.sprite = iconSprite
    self.ui.img_IconSD.sprite = iconSprite
  end
  self.ui.fx_NewSuitEffect:SetActive(false)
  self:SetAddSuitFxActive(self.isFirstGet)
  self:_InitChipSuit(chipData, dynPlayer, isOwnData)
  local sepcQuality = chipData:GetChipSpecQuality()
  self.ui.img_WcSpecQuality.gameObject:SetActive(0 < sepcQuality)
  if 0 < sepcQuality then
    self.ui.img_WcSpecQuality:SetIndex(sepcQuality)
    self.ui.img_WcSpecQuality.image.color = self.ui.color_WcSpecQuality[chipData:GetChipCount()]
  end
  self.ui.obj_time:SetActive(false)
  if chipData:GetChipType() == ChipEnum.eChipType.Rain then
    self.ui.obj_rainbowBG:SetActive(true)
  else
    self.ui.obj_rainbowBG:SetActive(false)
  end
  if isConsumeChip then
    return
  end
  local chipCfg = chipData:GetChipCfg()
  if 0 < #chipCfg.attribute_id then
    return
  end
  local hasCD, CD = chipData:TryGetSkillCD(self.level:GetCurrLevel(), 2)
  self.ui.obj_time:SetActive(hasCD)
  if hasCD then
    self.ui.tex_Time:SetIndex(0, CD)
  end
end

function UINBaseChipDetail:_InitChipSuit(chipData, dynPlayer, isOwnData)
  local chipCfg = chipData:GetChipCfg()
  local tagId = chipCfg.fun_tag
  local isConsumeChip = chipData:IsConsumeSkillChip()
  local unlockChipSuit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TagSuit)
  if unlockChipSuit and tagId ~= 0 and not isConsumeChip then
    self.ui.suitList:SetActive(true)
    local suitItem = self.suitItem
    if dynPlayer ~= nil then
      local haveCount, maxCount = dynPlayer:GetChipTagIdCount(tagId)
      suitItem:InitChipDetailSuitAndCount(tagId, haveCount, maxCount, dynPlayer, isOwnData, self.isFirstGet)
      if self.isFirstGet then
        local tagSuitCfg = ConfigData.chip_tag.tag_suits[tagId]
        for _, tag_suit in pairs(tagSuitCfg) do
          local active = false
          if haveCount + 1 >= tag_suit.number then
            active = true
          end
          if active and haveCount < tag_suit.number then
            self.ui.fx_NewSuitEffect:SetActive(true)
            break
          end
        end
      end
    else
      local haveCount, maxCount
      if self._dynChipSuitMgr then
        haveCount, maxCount = self._dynChipSuitMgr:GetChipTagIdCount(tagId)
      end
      suitItem:InitChipDetailSuit(tagId, haveCount, maxCount)
    end
    local chipTagCfg = ConfigData.chip_tag[tagId]
    if chipTagCfg == nil then
      error("chip tag cfg is null,id:" .. tostring(tagId))
      return
    end
    self.ui.tex_SuitName.text = LanguageUtil.GetLocaleText(chipTagCfg.tag_name)
  else
    self.ui.suitList:SetActive(false)
  end
end

function UINBaseChipDetail:_InitChipLevel(chipData, dynPlayer, isHideNxtLvlInfo, isOwnData)
  if self.level == nil then
    self.level = UINChipLevel.New()
    self.level:Init(self.ui.obj_Level)
    self.level:Show()
  end
  self.level:InitChipLevel(chipData, dynPlayer, isHideNxtLvlInfo, isOwnData)
  if chipData:GetChipType() == ChipEnum.eChipType.Rain then
    self.ui.obj_rainbowLevel:SetActive(true)
    self.level:Hide()
  else
    self.ui.obj_rainbowLevel:SetActive(false)
  end
end

function UINBaseChipDetail:_InitChipDescription(chipData, dynPlayer, _isHideNxtLvlInfo)
  local haveNum = 0
  if dynPlayer ~= nil then
    local playerChipDic = dynPlayer:GetNormalChipDic()
    if playerChipDic[chipData.dataId] ~= nil then
      haveNum = playerChipDic[chipData.dataId]:GetCount()
    end
  end
  local nextLevel = self.level:GetNextLevel()
  self.uiIntroData = nil
  self.btnRichIntro:SetIntroBtnActive(false)
  local isShowDetail = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  local chipCfg = chipData:GetChipCfg()
  if 0 < #chipCfg.attribute_id then
    local attrId = chipCfg.attribute_id
    local initValue = chipCfg.attribute_initial
    local increaseVal = chipCfg.level_increase
    local attrInfo
    if not _isHideNxtLvlInfo then
      if 0 < haveNum and haveNum < nextLevel then
        attrInfo = BattleUtil.GetChipAttrUpgradeInfo(attrId, initValue, increaseVal, haveNum, nextLevel)
      else
        attrInfo = BattleUtil.GetChipAttrInfo(attrId, initValue, increaseVal, chipData:GetCount(), chipData:GetChipMaxLevel())
      end
    else
      attrInfo = BattleUtil.GetChipAttrInfo(attrId, initValue, increaseVal, chipData:GetCount())
    end
    local descDetail = ConfigData:GetChipinfluenceIntro(chipCfg.id, attrInfo)
    self.ui.tex_Description.text = descDetail
  elseif chipData:GetSkillCfg() ~= nil then
    local skillCfg = chipData:GetSkillCfg()
    if not _isHideNxtLvlInfo then
      if 0 < haveNum and haveNum < nextLevel then
        self.ui.tex_Description.text = skillCfg:GetLevelUpDescribe(haveNum, nextLevel, ConfigData.buildinConfig.ChipLevelUpSign, ConfigData:GetChipQualityColor(haveNum), ConfigData:GetChipQualityColor(nextLevel), isShowDetail)
      else
        self.ui.tex_Description.text = skillCfg:GetChipSkillTotalLevelDesc(chipData:GetCount(), chipData:GetChipMaxLevel(), ConfigData.buildinConfig.ChipLevelDarkColor, ConfigData.buildinConfig.ChipLevelLightColor, isShowDetail)
      end
    else
      self.ui.tex_Description.text = skillCfg:GetLevelDescribe(chipData:GetCount(), false, isShowDetail)
    end
  else
    self.ui.tex_Description.text = ""
  end
  local skillId = chipData:GetSkillID()
  if skillId == nil then
    return
  end
  local tab = {}
  local btnActive = false
  local skillLabeIdList
  local labelDic = ConfigData.battle_skill.skill_label_Dic[skillId]
  if labelDic ~= nil then
    for id, unlockLevel in pairs(labelDic) do
      if unlockLevel <= haveNum + 1 then
        btnActive = true
        table.insert(tab, id)
      end
    end
  end
  if btnActive then
    self.uiIntroData = {}
    self.uiIntroData.skillLabeIdList = tab
    self.btnRichIntro:SetIntroBtnActive(btnActive)
  end
end

function UINBaseChipDetail:GetChipQuality()
  return self._chipData:GetQuality()
end

function UINBaseChipDetail:SetUIModifier(modifier)
  self._modifier = modifier
end

function UINBaseChipDetail:_ShowRichIntro()
  if self.uiIntroData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
    if win ~= nil then
      local parent = self.ui.tran_RichIntroHolder
      self.uiIntroData.introShowPos = 2
      win:SetRichIntroList(parent, self.uiIntroData)
      win:SetIntroListPosition(cs_Edge.Left, cs_Edge.Top)
      win:SetIntroListModifier(self._modifier, false)
      AudioManager:PlayAudioById(1055)
    end
  end)
end

function UINBaseChipDetail:_OnClickSuitInfo()
  local rot = self.ui.img_Arrow.localEulerAngles
  if self.suitCloseCallback == nil then
    self.suitCloseCallback = BindCallback(self, self._SuitCloseCallback, rot)
  end
  if self.suitInfoNode.active then
    self.suitInfoNode:Hide()
    self.suitCloseCallback()
  else
    local chipCfg = self._chipData:GetChipCfg()
    local tagId = chipCfg.fun_tag
    self.suitInfoNode:InitChipDetailSuitInfo(tagId, self._chipData, self.suitCloseCallback)
    self.suitInfoNode:Show()
    rot.z = 225
    self.ui.img_Arrow.localEulerAngles = rot
    AudioManager:PlayAudioById(1072)
  end
end

function UINBaseChipDetail:_SuitCloseCallback(rot)
  self.ui.chipInfoNode:SetActive(true)
  rot.z = 45
  self.ui.img_Arrow.localEulerAngles = rot
end

function UINBaseChipDetail:_OnDescribeChange(eTypeId)
  if eTypeId ~= eGameSetDescType.chip then
    return
  end
  if self._chipData == nil then
    return
  end
  if self.suitInfoNode.active then
    local chipCfg = self._chipData:GetChipCfg()
    local tagId = chipCfg.fun_tag
    self.suitInfoNode:RefreshSuitInfo(tagId, self._chipData)
  else
    self:_InitChipDescription(self._chipData, self._dynPlayer, self._isHideNxtLvlInfo)
  end
end

function UINBaseChipDetail:SetBaseBackground(parent)
  self.ui.background:SetParent(parent)
  self.ui.background.localPosition = Vector3.zero
  self.ui.background.sizeDelta = Vector2.zero
  self.ui.background:SetAsFirstSibling()
end

function UINBaseChipDetail:SetAddSuitFxActive(active)
  self.ui.fx_AddSuit:SetActive(active)
end

function UINBaseChipDetail:_IsFirstGet(chipData, dynPlayer)
  local firstGet = false
  if dynPlayer ~= nil then
    local playerChipDic = dynPlayer:GetNormalChipDic()
    firstGet = playerChipDic[chipData.dataId] == nil
  end
  return firstGet
end

function UINBaseChipDetail:OnHide()
  if self._onDescribeChange ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.DescribeSettingChange, self._onDescribeChange)
  end
end

function UINBaseChipDetail:OnDelete()
  self.suitInfoNode:Delete()
  self.suitItem:Delete()
  self.btnRichIntro:Delete()
  if self._onDescribeChange ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.DescribeSettingChange, self._onDescribeChange)
  end
  base.OnDelete(self)
end

return UINBaseChipDetail
