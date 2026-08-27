local UINActivityDivergentMainNode = class("UINActivityDivergentMainNode", UIBaseNode)
local base = UIBaseNode
local UINActivityDivergentRewardItem = require("Game.ActivityDivergent.UI.Reward.UINActivityDivergentRewardItem")
local UINActivityDivergentRewardStepItem = require("Game.ActivityDivergent.UI.Reward.UINActivityDivergentRewardStepItem")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local CS_MessageCommon = CS.MessageCommon

function UINActivityDivergentMainNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.obj_RewardItem:SetActive(false)
  self._stepRewardItem = UINActivityDivergentRewardStepItem.New()
  self._stepRewardItem:Init(self.ui.obj_StepReward)
  self._ItemDic = {}
  self.ui.scroll_Reward.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.scroll_Reward.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.isPlayed = false
  UIUtil.AddButtonListener(self.ui.btn_Story, self, self.__PlayDivergentAvg)
  UIUtil.AddButtonListener(self.ui.btn_RewardDetail, self, self.__OnClickShowDivergentRewardBtn)
  UIUtil.AddButtonListener(self.ui.btn_SpJump, self, self.__OnClickJumpToGetSpSkinBtn)
end

function UINActivityDivergentMainNode:InitDivergentMainNode(divergentData, showRewardFrameCallback)
  self._data = divergentData
  self._showRewardFrameCallback = showRewardFrameCallback
end

function UINActivityDivergentMainNode:RefreshDivergentMainNode(divergentHeroId, ani_center)
  self._divergentHeroId = divergentHeroId
  local canShow = self._data:GetDivergentCurrentHeroId() == divergentHeroId
  if not canShow then
    self:Hide()
    return
  end
  self:Show()
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._data:GetDivergentUiCfg(divergentHeroId).hero_name)
  self:RefreshJumpToGetSpSkinBtnState()
  if self._data:GetDivergentHeroFragAllGet(divergentHeroId) then
    self.ui.obj_RewardNode:SetActive(false)
    return
  end
  local progressData = self._data:GetDivergentHeroData(divergentHeroId)
  local stepGoodDatas = self._data:GetDivergentHeroRewardGroupCfg(divergentHeroId)[progressData.rewardStage]
  local stepGoodData = stepGoodDatas[#stepGoodDatas]
  self._stepRewardItem:InitDivergentRewardItem(self._data, stepGoodData, divergentHeroId)
  if self._prefHeroId ~= divergentHeroId then
    self._prefHeroId = divergentHeroId
    local allRewardCount = 0
    local rankData = self._data:GetDivergentHeroRewardGroupCfg(divergentHeroId)[1]
    self.ui.scroll_Reward.totalCount = #rankData
    self.ui.scroll_Reward:RefillCells()
  else
    self.ui.scroll_Reward:RefreshCells()
  end
  local currentLevelGoodData = self._data:GetDivergentHeroRewardLevelInStage(divergentHeroId, progressData.rewardStage)
  self.ui.tex_Count:SetIndex(0, tostring(progressData.rewardExp), tostring(currentLevelGoodData.reward_experience))
  if self.ui.exTex_Count ~= nil and self.ui.exTex_Count.text ~= "" then
    local fromTex = self.ui.tex_Count.text.text
    self:PlayTextTween(self.ui.exTex_Count, self.ui.texTween_Count, fromTex, self.ui.exTex_Count.text)
  end
  if self.isPlayed == false then
    ani_center:Play("UI_AnotherHero_UnLockStateIntro")
    self.isPlayed = true
  end
end

function UINActivityDivergentMainNode:__OnNewItem(go)
  local goodItem = UINActivityDivergentRewardItem.New()
  goodItem:Init(go)
  self._ItemDic[go] = goodItem
end

function UINActivityDivergentMainNode:__OnChangeItem(go, index)
  local goodItem = self._ItemDic[go]
  if goodItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  local goodData = self:__GetRewardDataByIndex(index)
  if goodData == nil then
    error("Can't find goodData by index, index = " .. tostring(index))
  end
  goodItem:InitDivergentRewardItem(self._data, goodData, self._divergentHeroId)
end

function UINActivityDivergentMainNode:__GetRewardDataByIndex(index)
  local luaIndex = index + 1
  local rankData = self._data:GetDivergentHeroRewardGroupCfg(self._divergentHeroId)[1]
  return rankData[luaIndex]
end

function UINActivityDivergentMainNode:SetDivergentScrollBar(step, offset)
  offset = offset or 0
  local stepGoodDatas = self._data:GetDivergentHeroRewardGroupCfg(self._divergentHeroId)[1]
  local stepCount = math.max(#stepGoodDatas, 1)
  local stepIndex = math.clamp(step + offset, 1, stepCount)
  self.ui.scroll_Reward.horizontalScrollbar.value = stepIndex / stepCount
  self.ui.scroll_Reward:RefreshCells()
end

function UINActivityDivergentMainNode:PlayTextTween(textComp, textDtanim, fromStr, toStr)
  textComp.text = fromStr
  textDtanim:DOKill()
  textDtanim:CreateTween()
  local textSpeed = 25
  textDtanim.tween:ChangeEndValue(toStr, textSpeed, false)
  textDtanim:DOPlayForward()
end

function UINActivityDivergentMainNode:__PlayDivergentAvg()
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  local heroCfg = self._data:GetDivergentHeroCfg(self._divergentHeroId)
  avgCtrl:StartAvg(nil, heroCfg.avg_id)
end

function UINActivityDivergentMainNode:__OnClickShowDivergentRewardBtn()
  if self._showRewardFrameCallback == nil then
    return
  end
  self._showRewardFrameCallback()
end

function UINActivityDivergentMainNode:RefreshJumpToGetSpSkinBtnState()
  local skinId = self._data:GetDivergentMainCfg().skin_id
  local isGetSpSkin = PlayerDataCenter.skinData:IsHaveSkin(skinId)
  self.ui.btn_SpJump.gameObject:SetActive(not isGetSpSkin)
end

function UINActivityDivergentMainNode:__OnClickJumpToGetSpSkinBtn()
  local sectorStageId = self._data:GetDivergentMainCfg().sector_id
  local stageCfg = ConfigData.sector_stage[sectorStageId]
  local sectorId = stageCfg.sector
  local isUnlock = PlayerDataCenter.sectorStage:IsSectorUnlock(sectorId)
  if not isUnlock then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(59026))
    return
  end
  local chapterId = self._data:GetDivergentMainCfg().chapter_id
  if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
    return
  end
  local anni24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  if anni24Ctrl ~= nil then
    UIManager:HideWindow(UIWindowTypeID.ActivityDivergentMain)
    local sectorLevelChapterCtrl = ControllerManager:GetController(ControllerTypeId.SectorLevelChapter, true)
    sectorLevelChapterCtrl.chapterData:SetChapterBaseInfo(sectorId, false, nil, chapterId)
    local eActInteract = require("Game.ActivityLobby.Activity.2024Activity.2024Anniversary.eActInteract")
    anni24Ctrl:EnterAnniversary24MainEp(sectorId, false, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.SectorEntrance)
    end, chapterId, false, eActInteract, sectorStageId)
    return
  end
  local JumpManager = require("Game.Jump.JumpManager")
  JumpManager:Jump(JumpManager.eJumpTarget.DynSectorLevel, nil, nil, {
    sectorId,
    nil,
    nil,
    nil,
    sectorStageId
  })
end

return UINActivityDivergentMainNode
