local UINPlayerSkillItem = class("UINPlayerSkillItem", UIBaseNode)
local base = UIBaseNode

function UINPlayerSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.img_CD.enabled = false
  self.ui.tran_Line.localScale = Vector3.zero
  self.ui.ani_mpMax.transform.localScale = Vector3.zero
  self.ui.Ani_Item.onComplete:AddListener(function()
    self.ui.tran_Line.localScale = Vector3.zero
  end)
  self.ui.Ani_Item.onPlay:AddListener(function()
    self.ui.tran_Line.localScale = Vector3.one
  end)
  self._defaultPressDurationTime = self.ui.btnPlus_Root.pressDurationTime
  self._defaultPressRepeatInterval = self.ui.btnPlus_Root.pressRepeatInterval
end

function UINPlayerSkillItem:InitPlayerSkillItem(battleSkill, reslaoder, clickFunc, longPressFunc, pressUpFunc, pressDownFunc)
  self.battleSkill = battleSkill
  self.skillId = battleSkill.dataId
  self.clickFunc = clickFunc
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  self.pressDownFunc = pressDownFunc
  self.isSkillNoCD = battleSkill.totalCDTime == 0
  self.ui.tex_Cost.text = tostring(battleSkill.skillCfg.PlayerMpCost)
  self.ui.img_Icon.enabled = false
  self.ui.cantUse:SetActive(false)
  self.ui.img_ManualSkill:SetActive(battleSkill.isManualMode)
  if not string.IsNullOrEmpty(battleSkill.skillCfg.Icon) then
    reslaoder:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
      if spriteAtlas == nil then
        return
      end
      self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, battleSkill.skillCfg.Icon)
      self.ui.img_Icon.enabled = true
    end)
  end
  if not self.battleSkill.isManualMode then
    self.ui.btnPlus_Root.onClick:AddListener(BindCallback(self, self.__OnSkillClicked))
  else
    self.ui.btnPlus_Root.onClick:AddListener(BindCallback(self, self.__OnSkillClicked))
  end
  self.ui.btnPlus_Root.responseOnceByPress = false
  self.ui.btnPlus_Root.pressDurationTime = ConfigData.game_config.noCdCommanderSkillInterval
  self.ui.btnPlus_Root.pressRepeatInterval = ConfigData.game_config.noCdCommanderSkillInterval
  self.ui.btnPlus_Root.onPress:AddListener(BindCallback(self, self.__OnSkillLongPress))
  self.ui.btnPlus_Root.onPressUp:AddListener(BindCallback(self, self.__OnSkillPressUp))
  self.isSkillDown = false
end

function UINPlayerSkillItem:SetSkillBtnEnabled(enabled)
  if IsNull(self.gameObject) then
    return
  end
  self.ui.btnPlus_Root.enabled = enabled
end

function UINPlayerSkillItem:RefreshPlayerSkillItemMp(curMp, isMax)
  if type(curMp) == "number" then
    self.curMp = curMp
  else
    self.curMp = curMp.RawValue
  end
  local decoloration = 0.5
  if self.curMp ~= nil then
    decoloration = self.curMp >= self.battleSkill.skillCfg.PlayerMpCost and 1 or 0.5
  end
  self.ui.Fade.alpha = decoloration
  self:__SetPlayerSkillMPMaxUI(isMax)
end

function UINPlayerSkillItem:OnUpdateLogic_PlayerSkillItem()
  if not self.isSkillNoCD then
    local skill = self.battleSkill
    if skill:IsReadyToTake() then
      if self.ui.img_CD.enabled then
        self:RefreshPlayerSkillItemMp(self.curMp)
      end
      self.ui.img_CD.enabled = false
    else
      self.ui.img_CD.enabled = true
      self.curCDRatio = (skill.totalCDTime - skill.UICdTime) / skill.totalCDTime
      self.nextCDRatio = (skill.totalCDTime - skill.NextUICdTime) / skill.totalCDTime
      self.ui.img_CD.fillAmount = self.curCDRatio
      self.ui.Fade.alpha = 0.5
      self.ui.ani_mpMax.transform.localScale = Vector3.Temp(0, 0, 0)
    end
  end
end

function UINPlayerSkillItem:OnUpdateRender_PlayerSkillItem(deltaTime, interpolation)
  if not self.isSkillNoCD and self.ui.img_CD.enabled then
    self.ui.img_CD.fillAmount = Mathf.Lerp(self.curCDRatio, self.nextCDRatio, interpolation)
  end
end

function UINPlayerSkillItem:__OnSkillClicked()
  if self.ui.cantUse.activeSelf or BattleUtil.IsBattleInPause() then
    return
  end
  if self.ui.Fade.alpha == 1 then
    self.ui.Ani_Item:DORestart()
  end
  if self.clickFunc ~= nil then
    self.clickFunc(self.battleSkill)
  end
end

function UINPlayerSkillItem:__OnSkillLongPress()
  if self.longPressFunc ~= nil then
    self.longPressFunc(self, self.battleSkill)
  end
end

function UINPlayerSkillItem:__OnSkillPressUp()
  if self.pressUpFunc ~= nil then
    self.pressUpFunc()
  end
  if self.isSkillDown then
    self.isSkillDown = false
  end
end

function UINPlayerSkillItem:__SetPlayerSkillMPMaxUI(isMax)
  if self.curMp >= self.battleSkill.skillCfg.PlayerMpCost and isMax then
    self.ui.ani_mpMax.transform:SetLocalScale(1, 1, 1)
  else
    self.ui.ani_mpMax.transform:SetLocalScale(0, 0, 0)
  end
  if isMax then
    self.ui.ani_mpMax:DORestart()
  else
    self.ui.ani_mpMax:DOPause()
  end
end

function UINPlayerSkillItem:SetSkillItemLock(isLock)
  self.ui.cantUse:SetActive(isLock)
end

function UINPlayerSkillItem:OnDelete()
  self.isSkillDown = false
  self.ui.ani_mpMax:DOKill()
  base.OnDelete(self)
end

return UINPlayerSkillItem
