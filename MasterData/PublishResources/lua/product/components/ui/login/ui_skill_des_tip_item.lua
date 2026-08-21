_class("UISkillDesTipItem", UICustomWidget)
UISkillDesTipItem = UISkillDesTipItem

function UISkillDesTipItem:Constructor()
  self._skillID = 0
  self._skillType = 0
  self._callBack = 0
end

function UISkillDesTipItem:OnShow(uiParams)
  self._skillDesText = self:GetUIComponent("UILocalizationText", "skillDes")
  self._rectTran = self:GetUIComponent("RectTransform", "UISkillDesTipItem")
end

function UISkillDesTipItem:SetData(skillType, skillID, localPosition, callBack)
  self._skillType = skillType
  self._rectTran.localPosition = localPosition
  self._callBack = callBack
  local cfg
  if self._skillType == 0 then
    cfg = BattleSkillCfg(skillID)
  else
    cfg = Cfg.cfg_work_skill[skillID]
  end
  if cfg then
    self._skillID = skillID
    self._skillDesText.text = StringTable.Get(cfg.Desc)
  end
end

function UISkillDesTipItem:closeBtnOnClick(go)
  if self._callBack then
    self._callBack()
  end
end

function UISkillDesTipItem:closeBgBtnOnClick(go)
  if self._callBack then
    self._callBack()
  end
end
