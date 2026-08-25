local BattleAttachPostSkillPanel, Super = System.NewClass("BattleAttachPostSkillPanel", UIBasePanel)
BattleAttachPostSkillPanel.uiResCls = "UI/UI_Battle/UI_Battle_Prefab/UI_Battle_Popup_AttachPostSkill.prefab"
local T_UIAnimController = typeof(CS.Z1Client.UIAnimationController)

function BattleAttachPostSkillPanel:ctor(awakerTid, skillTid, curSkin, roleGender, performType)
  Super.ctor(self)
  self.awakerTid = awakerTid
  self.skillTid = skillTid
  self.curSkin = curSkin
  self.roleGender = roleGender
  self.performType = performType
  print("BattleAttachPostSkillPanel:ctor", awakerTid, skillTid, curSkin, roleGender, performType)
end

function BattleAttachPostSkillPanel:OnUnbind()
  Super.OnUnbind(self)
end

function BattleAttachPostSkillPanel:OnBind(binder)
  self.binder = binder
  self.defaultAwakerPos = self.ui.Image_Awaker.transform.anchoredPosition
  self:SetPaintingImage()
  self:SetSkillName()
  self:PlayEnterAnim()
end

function BattleAttachPostSkillPanel:SetPaintingImage()
  if self.performType == cd.AttachPostActionPerformType.CardFace then
    if self.defaultAwakerPos then
      self.ui.Image_Awaker.transform.anchoredPosition = self.defaultAwakerPos
    end
    local skillCfg = DT.Skill and DT.Skill[self.skillTid]
    if not (skillCfg and skillCfg.Icon) or skillCfg.Icon == "" then
      return
    end
    self.binder:SetImage(self.ui.Image_Awaker, skillCfg.Icon)
    local portraitNo
    local _, _, code, suffix = string.find(skillCfg.Icon, "Portrait_[A%d%a_]+_([A%d%a_]+)_([AN]F)%.png")
    if code and suffix then
      portraitNo = string.format("%s_%s", code, suffix)
    end
    if portraitNo then
      local alignPortraitNo = portraitNo
      if DT.PortraitCenter then
        local awakerKey = string.format("Portrait_Middle_Awaker_%s", portraitNo)
        local spCharKey = string.format("Portrait_Middle_SpChar_%s", portraitNo)
        if DT.GetPortraitCenter(awakerKey) then
          alignPortraitNo = portraitNo
        elseif DT.GetPortraitCenter(spCharKey) then
          alignPortraitNo = string.format("SpChar_%s", portraitNo)
        else
          print(string.format("找不到PortraitCenter配置, skillIcon=%s, portraitNo=%s", skillCfg.Icon, portraitNo))
          alignPortraitNo = nil
        end
      end
      if alignPortraitNo then
        PortraitUtils.HorizontalCenter(self.ui.AwakerCon.transform, self.ui.Image_Awaker.transform, alignPortraitNo)
        PortraitUtils.VerticalCenter(self.ui.AwakerCon.transform, self.ui.Image_Awaker.transform, alignPortraitNo)
      end
    end
  elseif self.roleGender and 0 ~= self.roleGender then
    self:SetRoleImage()
  else
    self:SetAwakerAndMonsterImage()
  end
end

function BattleAttachPostSkillPanel:SetRoleImage()
  local path
  if self.roleGender == CommonDefine.GenderID.Boy then
    path = GenderDataUtils.GetPaintingRes(self.roleGender)
  else
    path = GenderDataUtils.GetPaintingRes(self.roleGender)
  end
  print("----------------set role image", path)
  self.binder:SetImage(self.ui.Image_Awaker, path, true)
  self.ui.Image_Awaker.transform.anchoredPosition = CS.UnityEngine.Vector2(-654, -718)
end

function BattleAttachPostSkillPanel:SetAwakerAndMonsterImage()
  if self.defaultAwakerPos then
    self.ui.Image_Awaker.transform.anchoredPosition = self.defaultAwakerPos
  end
  local awakerTid = self.awakerTid
  local curSkin = self.curSkin
  local portraitNo, path
  if AwakerDataUtils.IsAwakerTid(awakerTid) then
    portraitNo = AwakerSkinUtils.GetSkinResNum(curSkin, awakerTid)
    path = AwakerDataUtils.GetPortraitByNo(portraitNo)
  elseif DT.MonsterConfig[awakerTid] then
    local monsterCfg = DT.MonsterConfig[awakerTid]
    local miniIcon = monsterCfg.MiniIcon
    if miniIcon then
      local _, _, code = string.find(miniIcon, "Portrait_Minihead_EnemyAwaker_([A%d%a_]+)%.png")
      portraitNo = code
      path = AwakerDataUtils.GetPortraitByNo(portraitNo)
    end
  end
  if not path then
    return
  end
  self.binder:SetImage(self.ui.Image_Awaker, path, true)
  PortraitUtils.HorizontalCenter(self.ui.AwakerCon.transform, self.ui.Image_Awaker.transform, portraitNo)
  PortraitUtils.VerticalCenter(self.ui.AwakerCon.transform, self.ui.Image_Awaker.transform, portraitNo)
end

function BattleAttachPostSkillPanel:SetSkillName()
  local skillName = BattleSkillUtils.GetSkillNameByTid(self.skillTid, nil)
  self.binder:SetText(self.ui.Text_SkillName, skillName)
end

function BattleAttachPostSkillPanel:PlayEnterAnim()
  local uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimController)
  uiAnimController:PlayState("UI_Battle_Popup_AttachPostSkill_Open", function()
    self:Close()
  end)
end

return BattleAttachPostSkillPanel
