local UIBattleSkillModule = class("UIBattleSkillModule", UIBaseWindow)
local base = UIBaseWindow
local UINBattleHudNode = require("Game.Battle.UI.SkillModule.HudNode.UINBattleHudNode")
local UINUltimateNode = require("Game.Battle.UI.SkillModule.UltimateSkill.UINUltimateNode")
local UINPlayerSkillNode = require("Game.Battle.UI.SkillModule.PlayerSkill.UINPlayerSkillNode")
local UIInputNode = require("Game.Battle.UI.SkillModule.UISkillInput")
local CS_ResLoader = CS.ResLoader
local CS_DOTween = CS.DG.Tweening.DOTween
local CS_CanvasGroup = CS.UnityEngine.CanvasGroup

function UIBattleSkillModule:OnInit()
  self.resloader = CS_ResLoader.Create()
  self.hudNode = UINBattleHudNode.New()
  self.hudNode:Init(self.ui.hUDNode)
  self.ultSkillNode = UINUltimateNode.New(self.resloader)
  self.ultSkillNode:Init(self.ui.ultimateNode)
  self.playerSkillNode = UINPlayerSkillNode.New(self.resloader)
  self.playerSkillNode:Init(self.ui.playerSkillNode)
  self.inputModeMaskUI = UIInputNode.New()
  self.inputModeMaskUI:Init(self.ui.mask)
  self.inputModeMaskUI:Hide()
  self.__OnPlayHeroUltrSkillAction = BindCallback(self, self.OnPlayHeroUltrSkillAction)
  MsgCenter:AddListener(eMsgEventId.OnUltSkillRoleActionStart, self.__OnPlayHeroUltrSkillAction)
  self.__OnPlayHeroUltrSkillVideo = BindCallback(self, self.OnPlayHeroUltrSkillVideo)
  MsgCenter:AddListener(eMsgEventId.OnUltSkillVideoStart, self.__OnPlayHeroUltrSkillVideo)
end

function UIBattleSkillModule:InitBattleHud(camera)
  self.hudNode:InitBattleHud(camera)
end

function UIBattleSkillModule:SetBattleHudScrollValue(value)
  self.hudNode:RefreshHudScroll(value)
end

function UIBattleSkillModule:InitBattlePlayerUltSkill(battleSkillList, useSkillFunc, ultEffectSkipFunc)
  self.ultSkillNode:InitBattlePlayerUltSkill(battleSkillList, useSkillFunc, ultEffectSkipFunc)
end

function UIBattleSkillModule:AddUltSkillItemInBattle(roleDataId, battleSkill)
  self.ultSkillNode:AddUltSkillItemInBattle(roleDataId, battleSkill)
end

function UIBattleSkillModule:RemoveUltSkillItemInBattle(roleDataId, battleSkill)
  self.ultSkillNode:RemoveUltSkillItemInBattle(roleDataId, battleSkill)
end

function UIBattleSkillModule:DisableHeroUltSkill(heroId, disable)
  self.ultSkillNode:DisableHeroUltSkill(heroId, disable)
end

function UIBattleSkillModule:ShowHeroReturnCD(heroId, returnCD)
  self.ultSkillNode:ShowHeroReturnCD(heroId, returnCD)
end

function UIBattleSkillModule:UpdateUltSkill(useEnable, curRatio, nextRatio, factor, interpolation)
  self.ultSkillNode:UpdateUltSkill(useEnable, curRatio, nextRatio, factor, interpolation)
end

function UIBattleSkillModule:UpdateUltSkillForce(useEnable, curRatio, factor)
  self.ultSkillNode:UpdateUltSkillForce(useEnable, curRatio, factor)
  MsgCenter:Broadcast(eMsgEventId.OnBattleUpdateUltSkill, useEnable, curRatio, factor)
end

function UIBattleSkillModule:CreateMpParticle(startPos, ratio)
end

function UIBattleSkillModule:ShowUltSkillFocusMask(show)
  self.ultSkillNode:ShowUltSkillFocusMask(show)
end

function UIBattleSkillModule:UpdateUltSkillFocusMask(screenPos)
  self.ultSkillNode:UpdateUltSkillFocusMask(screenPos)
end

function UIBattleSkillModule:GetUltSkillMovieRenderer()
  return self.ultSkillNode:GetUltSkillMovieRenderer()
end

function UIBattleSkillModule:GetUltSkipBtnRenderer()
  return self.ultSkillNode:GetUltSkipBtnRenderer()
end

function UIBattleSkillModule:ShowUltSkillNode(show)
  if show then
    self.ultSkillNode:Show()
  else
    self.ultSkillNode:Hide()
  end
end

function UIBattleSkillModule:GetUltVideoPath()
  return PathConsts.UltSkillVideoPath
end

function UIBattleSkillModule:AddHeroItemWithoutUltSkill(heroId, heroData)
  self.ultSkillNode:AddHeroItem(heroId, heroData)
end

function UIBattleSkillModule:SetUltSkipBtnActive(bValue)
  self.ultSkillNode:SetUltSkipBtnActive(bValue)
end

function UIBattleSkillModule:RemoveHeroItemWithoutUltSkill(heroId)
  self.ultSkillNode:RemoveHeroItem(heroId)
end

function UIBattleSkillModule:IsHaveHeroHeadInUlt(heroId)
  return self.ultSkillNode:IsHaveUltHead(heroId)
end

function UIBattleSkillModule:InitPlayerSkillNode(battlePlayerController, skillList)
  self.playerSkillNode:InitPlayerSkillNode(battlePlayerController, skillList)
end

function UIBattleSkillModule:OnPlayerMpChange(mp)
  self.playerSkillNode:OnPlayerMpChange(mp)
end

function UIBattleSkillModule:OnPlayerMaxMpChange(maxMp)
  self.playerSkillNode:OnPlayerMaxMpChange(maxMp)
end

function UIBattleSkillModule:ShowPlayerSkillNode(show)
  local isCSUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  if not isCSUnlock or BattleUtil.IsInBrotatBattle() then
    self.playerSkillNode:Hide()
    return
  end
  if show then
    if self.playerSkillNode:IsSkillEmpty() then
      return
    end
    self.playerSkillNode:Show()
  else
    self.playerSkillNode:Hide()
  end
end

function UIBattleSkillModule:RefreshUltSkillAutoUltToggle()
  if self.ultSkillNode ~= nil then
    self.ultSkillNode:RefreshAutoBattleToggle()
  end
end

function UIBattleSkillModule:BattleSkillMoveToTopSiblingIndex()
  if self.transform:GetSiblingIndex() ~= self.transform.parent.childCount - 1 then
    self.transform:SetAsLastSibling()
  end
end

function UIBattleSkillModule:OnUpdateLogic_BSkillModule()
  self.playerSkillNode:OnUpdateLogic_PlayerSkillNode()
  self.ultSkillNode:OnUpdateLogic_UltimateNode()
end

function UIBattleSkillModule:OnUpdateRender_BSkillModule(deltaTime, interpolation)
  self.playerSkillNode:OnUpdateRender_PlayerSkillNode(deltaTime, interpolation)
  self.ultSkillNode:OnUpdateRender_UltimateNode(deltaTime, interpolation)
end

function UIBattleSkillModule:__JoinHideTween(sequence, uiLayer)
  local layerTran = UIManager:GetUILayer(uiLayer)
  if not IsNull(layerTran) then
    sequence:Join(layerTran:DOScale(Vector3.one * 2, self.ui.hideTweenDuration))
    local canvasGroup = layerTran:FindComponent(eUnityComponentID.CanvasGroup)
    if IsNull(canvasGroup) then
      canvasGroup = layerTran.gameObject:AddComponent(typeof(CS_CanvasGroup))
    end
    sequence:Join(canvasGroup:DOFade(0, self.ui.hideTweenDuration))
  end
end

function UIBattleSkillModule:BattleHideAllUITween(hide)
  if self.__hideAllUISequence == nil then
    local sequence = CS_DOTween.Sequence()
    self:__JoinHideTween(sequence, EUILayoutLevel.Normal)
    self:__JoinHideTween(sequence, EUILayoutLevel.Middle)
    self:__JoinHideTween(sequence, EUILayoutLevel.High)
    sequence:OnRewind(function()
      if self.__isPlayBack then
        self.ui.ultSkillVideo:SetParent(self.transform)
        self.__isPlayBack = false
      end
    end)
    sequence:SetAutoKill(false)
    self.__hideAllUISequence = sequence
  end
  if hide then
    self.__isPlayBack = false
    self.__hideAllUISequence:Restart()
    local layerTran = UIManager:GetUILayer(EUILayoutLevel.Top)
    self.ui.ultSkillVideo:SetParent(layerTran)
  else
    self.__isPlayBack = true
    self.__hideAllUISequence:Complete()
    self.__hideAllUISequence:PlayBackwards()
  end
end

function UIBattleSkillModule:Show(withTween)
  if self.active then
    return
  end
  base.Show(self)
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade(self.ui.canvasGroup, 0, 1, 0.5)
  end
end

function UIBattleSkillModule:Hide(withTween)
  if not self.active then
    return
  end
  base.Hide(self)
  if withTween then
    self:__ClearFadeTween()
    self.__fadeTween = UIManager:PlayDoFade(self.ui.canvasGroup, 1, 0, 0.5)
  end
end

function UIBattleSkillModule:__ClearFadeTween()
  if self.__fadeTween ~= nil then
    self.__fadeTween:Kill()
    self.__fadeTween = nil
  end
end

function UIBattleSkillModule:SetSelectSkillType(isHeroSkill)
  self.isSelectHeroSkill = isHeroSkill
end

function UIBattleSkillModule:SetSkillInputState(isInInputState)
  if isInInputState then
    self.ultimateNodeActiveRecord = self.ui.ultimateNode.gameObject.activeSelf
    self.playerSkillNodeActiveRecord = self.ui.playerSkillNode.gameObject.activeSelf
    self.ui.ultimateNode.gameObject:SetActive(self.isSelectHeroSkill)
    self.ui.playerSkillNode.gameObject:SetActive(not self.isSelectHeroSkill)
  else
    if self.ultimateNodeActiveRecord ~= nil then
      self.ui.ultimateNode.gameObject:SetActive(self.ultimateNodeActiveRecord)
      self.ultimateNodeActiveRecord = nil
    else
      self.ui.ultimateNode.gameObject:SetActive(true)
    end
    if self.playerSkillNodeActiveRecord ~= nil then
      self.ui.playerSkillNode.gameObject:SetActive(self.playerSkillNodeActiveRecord)
      self.playerSkillNodeActiveRecord = nil
    else
      self.ui.playerSkillNode.gameObject:SetActive(true)
    end
  end
end

function UIBattleSkillModule:OnPlayHeroUltrSkillAction(caster)
  UIManager:ShowWindowAsync(UIWindowTypeID.UltimateSkillShow, function(win)
    if win == nil then
      return
    end
    win:InitUltrSkillHeroShow(caster)
  end)
end

function UIBattleSkillModule:OnPlayHeroUltrSkillVideo()
  local win = UIManager:GetWindow(UIWindowTypeID.UltimateSkillShow)
  if win ~= nil then
    win:Delete()
  end
end

function UIBattleSkillModule:OnRefreshSideHeadHpUI(hero2hpDic)
  self.ultSkillNode:ShowSideHeadHpBar(hero2hpDic)
end

function UIBattleSkillModule:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnUltSkillRoleActionStart, self.__OnPlayHeroUltrSkillAction)
  MsgCenter:RemoveListener(eMsgEventId.OnUltSkillVideoStart, self.__OnPlayHeroUltrSkillVideo)
  self:__ClearFadeTween()
  self.resloader:Put2Pool()
  self.resloader = nil
  self.ui.ultSkillVideo:SetParent(self.transform)
  if self.inputModeMaskUI ~= nil then
    self.inputModeMaskUI:Delete()
    self.inputModeMaskUI = nil
  end
  self.hudNode:Delete()
  self.ultSkillNode:Delete()
  self.playerSkillNode:Delete()
  if self.__hideAllUISequence ~= nil then
    self.__hideAllUISequence:Rewind()
    self.__hideAllUISequence:Kill()
    self.__hideAllUISequence = nil
  end
  base.OnDelete(self)
end

return UIBattleSkillModule
