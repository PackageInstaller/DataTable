local table = _ENV.table
local GameRequest, Super = System.NewClass("GameRequest", ProtoBase)

function GameRequest:Startup()
  Super.Startup(self)
end

function GameRequest:Shutdown()
  Super.Shutdown(self)
end

function GameRequest:ClearData()
  Super.ClearData(self)
end

function GameRequest:OnShowTalentList(group)
  Logger.Proto("Talent.OnShowTalentList: copiesTid=%s", group)
  do return NetworkMgr.Instance.Talent.OnShowTalentList, NetworkMgr.Instance.Talent end
  return NetworkMgr.Instance.Talent.OnShowTalentList, NetworkMgr.Instance.Talent, group
end

function GameRequest:OnTalentList(group)
  Logger.Proto("Talent.OnTalentList: copiesTid=%s", group)
  do return NetworkMgr.Instance.Talent.OnTalentList, NetworkMgr.Instance.Talent end
  return NetworkMgr.Instance.Talent.OnTalentList, NetworkMgr.Instance.Talent, group
end

function GameRequest:OnUpgradeTalent(tid)
  Logger.Proto("Talent.OnUpgradeTalent: talentId=%s", tid)
  do return NetworkMgr.Instance.Talent.OnUpgradeTalent, NetworkMgr.Instance.Talent end
  return NetworkMgr.Instance.Talent.OnUpgradeTalent, NetworkMgr.Instance.Talent, tid
end

function GameRequest:OnTalentReset(group)
  Logger.Proto("Talent.Reset: talentId=%s", group)
  do return NetworkMgr.Instance.Talent.Reset, NetworkMgr.Instance.Talent end
  return NetworkMgr.Instance.Talent.Reset, NetworkMgr.Instance.Talent, group
end

function GameRequest:TutorialOnOpen()
  Logger.Proto("Tutorial.TutorialOnOpen:")
  do return NetworkMgr.Instance.Tutorial.OnOpen end
  return NetworkMgr.Instance.Tutorial.OnOpen, NetworkMgr.Instance.Tutorial
end

function GameRequest:TutorialOnFinishRead(tid)
  Logger.Proto("Tutorial.TutorialOnFinishRead: tid=%s", tid)
  do return NetworkMgr.Instance.Tutorial.OnFinishRead, NetworkMgr.Instance.Tutorial end
  return NetworkMgr.Instance.Tutorial.OnFinishRead, NetworkMgr.Instance.Tutorial, tid
end

function GameRequest:TutorialOnFinishAllRead()
  Logger.Proto("Tutorial.TutorialOnFinishAllRead")
  do return NetworkMgr.Instance.Tutorial.OnFinishAllRead end
  return NetworkMgr.Instance.Tutorial.OnFinishAllRead, NetworkMgr.Instance.Tutorial
end

function GameRequest:TutorialOnClickBoardGirl()
  Logger.Proto("Tutorial.TutorialOnClickBoardGirl")
  do return NetworkMgr.Instance.Tutorial.OnClickBoardGirl end
  return NetworkMgr.Instance.Tutorial.OnClickBoardGirl, NetworkMgr.Instance.Tutorial
end

function GameRequest:OnIncreaseLimitLevel(awakerTid)
  Logger.Proto("Awaker.OnIncreaseLimitLevel: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnIncreaseLimitLevel, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnIncreaseLimitLevel, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:OnLikeBreak(awakerTid)
  Logger.Proto("Awaker.OnLikeBreak: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnLikeBreak, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnLikeBreak, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:OnReqAwakerList()
  Logger.Proto("Awaker.OnReqAwakerList:")
  do return NetworkMgr.Instance.Awaker.GetClientProfile end
  return NetworkMgr.Instance.Awaker.GetClientProfile, NetworkMgr.Instance.Awaker
end

function GameRequest:OnReqAwakerDetailInfo(awakerTid)
  Logger.Proto("Awaker.OnReqAwakerDetailInfo: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.GetClientRoleDetailProfile end
  return NetworkMgr.Instance.Awaker.GetClientRoleDetailProfile, awakerTid, awakerTid
end

function GameRequest:OnAwakerLevelUpgrade(awakerTid, items)
  Logger.Proto("OnLevelUpgrade: awakerTid=%s, items=%s", awakerTid, items)
  do return NetworkMgr.Instance.Awaker.OnLevelUpgrade, NetworkMgr.Instance.Awaker, awakerTid end
  return NetworkMgr.Instance.Awaker.OnLevelUpgrade, NetworkMgr.Instance.Awaker, awakerTid, items
end

function GameRequest:OnAwakerAdvance(awakerTid)
  Logger.Proto("OnLevelUpgrade: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnAdvanced, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnAdvanced, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:OnChooseSkill(awakerTid, skillTid)
  Logger.Proto("OnChooseSkill: awakerTid=%s, skillTid=%s", awakerTid, skillTid)
  do return NetworkMgr.Instance.Awaker.OnChooseSkill, NetworkMgr.Instance.Awaker, awakerTid end
  return NetworkMgr.Instance.Awaker.OnChooseSkill, NetworkMgr.Instance.Awaker, awakerTid, skillTid
end

function GameRequest:OnSkillUpgrade(awakerTid, skillTid)
  Logger.Proto("OnSkillUpgrade: awakerTid=%s, skillTid=%s", awakerTid, skillTid)
  do return NetworkMgr.Instance.Awaker.OnSkillUpgrade, NetworkMgr.Instance.Awaker, awakerTid end
  return NetworkMgr.Instance.Awaker.OnSkillUpgrade, NetworkMgr.Instance.Awaker, awakerTid, skillTid
end

function GameRequest:OnPotentiaUpgrade(awakerTid)
  Logger.Proto("OnPotentiaUpgrade: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnPotentiaUpgrade, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnPotentiaUpgrade, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:OnCollection(tid, state)
  Logger.Proto("Awaker.OnCollection: awakerTid=%s card=", tid, state)
  do return NetworkMgr.Instance.Awaker.OnCollection, NetworkMgr.Instance.Awaker, tid end
  return NetworkMgr.Instance.Awaker.OnCollection, NetworkMgr.Instance.Awaker, tid, state
end

function GameRequest:OnChangeSkin(awakerTid, skinTid)
  Logger.Proto("OnChangeSkin: awakerTid=%s, skinTid=%s", awakerTid, skinTid)
  do return NetworkMgr.Instance.Awaker.OnChangeSkin, NetworkMgr.Instance.Awaker, awakerTid end
  return NetworkMgr.Instance.Awaker.OnChangeSkin, NetworkMgr.Instance.Awaker, awakerTid, skinTid
end

function GameRequest:OnOpenTurntable(turntableTid)
  Logger.Proto("OnOpenTurntable: turntableTid=%s", turntableTid)
  do return NetworkMgr.Instance.Turntable.OnOpenTurntable, NetworkMgr.Instance.Turntable end
  return NetworkMgr.Instance.Turntable.OnOpenTurntable, NetworkMgr.Instance.Turntable, turntableTid
end

function GameRequest:OnExchangeTurntableCost(turntableTid, num)
  Logger.Proto("OnExchangeTurntableCost: turntableTid=%s, num=%s", turntableTid, num)
  do return NetworkMgr.Instance.Turntable.OnExchangeTurntableCost, NetworkMgr.Instance.Turntable, turntableTid end
  return NetworkMgr.Instance.Turntable.OnExchangeTurntableCost, NetworkMgr.Instance.Turntable, turntableTid, num
end

function GameRequest:OnTurntable(turntableTid)
  Logger.Proto("OnTurntable: turntableTid=%s", turntableTid)
  do return NetworkMgr.Instance.Turntable.OnTurntable, NetworkMgr.Instance.Turntable end
  return NetworkMgr.Instance.Turntable.OnTurntable, NetworkMgr.Instance.Turntable, turntableTid
end

function GameRequest:OnFastPromotion(itemTid, awakerTid)
  Logger.Proto("GameRequest:OnFastPromotion itemTid:%s awakerTid:%s", itemTid, awakerTid)
  do return NetworkMgr.Instance.Awaker.OnFastPromotion, NetworkMgr.Instance.Awaker, itemTid end
  return NetworkMgr.Instance.Awaker.OnFastPromotion, NetworkMgr.Instance.Awaker, itemTid, awakerTid
end

function GameRequest:OnReadStory(awakerTid, storyList)
  Logger.Proto("GameRequest:OnReadStory awakerTid:%s", awakerTid, table.tostring(storyList))
  NetworkMgr.Instance.Awaker.OnReadStory(awakerTid, storyList)
end

function GameRequest:OnHearVoice(awakerTid, voiceList)
  Logger.Proto("GameRequest:OnHearVoice awakerTid:%s voiceList:%s", awakerTid, table.tostring(voiceList))
  NetworkMgr.Instance.Awaker.OnHearVoice(awakerTid, voiceList)
end

function GameRequest:ActiveAwakerBreakSkill(awakerTid, breakLevel)
  Logger.Proto("ActiveAwakerBreakSkill: awakerTid=%s, breakLevel=%s", awakerTid, breakLevel)
  do return NetworkMgr.Instance.Awaker.ActiveAwakerBreakSkill, NetworkMgr.Instance.Awaker, awakerTid end
  return NetworkMgr.Instance.Awaker.ActiveAwakerBreakSkill, NetworkMgr.Instance.Awaker, awakerTid, breakLevel
end

function GameRequest:UpgradeTalent(awakerTid, talentTid, level)
  Logger.Proto("UpgradeTalent: awakerTid=%s, talentTid=%s, level=%s", awakerTid, talentTid, level)
  do return NetworkMgr.Instance.Awaker.UpgradeTalent, NetworkMgr.Instance.Awaker, awakerTid, talentTid end
  return NetworkMgr.Instance.Awaker.UpgradeTalent, NetworkMgr.Instance.Awaker, awakerTid, talentTid, level
end

function GameRequest:OnReqRestoreEnergyByItem(items)
  Logger.Proto("Player.OnReqRestoreEnergyByItem: items=%s", items)
  do return NetworkMgr.Instance.Role.OnRestoreEnergyByItem, NetworkMgr.Instance.Role end
  return NetworkMgr.Instance.Role.OnRestoreEnergyByItem, NetworkMgr.Instance.Role, items
end

function GameRequest:OnGetBattleStatistics()
  do return NetworkMgr.Instance.Role.GetBattleStatistics end
  return NetworkMgr.Instance.Role.GetBattleStatistics, NetworkMgr.Instance.Role
end

function GameRequest:OnBuyEnergy()
  do return NetworkMgr.Instance.Role.OnBuyEnergy end
  return NetworkMgr.Instance.Role.OnBuyEnergy, NetworkMgr.Instance.Role
end

function GameRequest:OnBuyTicket()
  do return NetworkMgr.Instance.Role.OnBuyTicket end
  return NetworkMgr.Instance.Role.OnBuyTicket, NetworkMgr.Instance.Role
end

function GameRequest:SetBoardAwaker(awakerTid)
  Logger.Proto("Player.OnSetBoardAwaker: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Role.SetBoardAwaker, NetworkMgr.Instance.Role end
  return NetworkMgr.Instance.Role.SetBoardAwaker, NetworkMgr.Instance.Role, awakerTid
end

function GameRequest:OnSetState(state)
  Logger.Proto("GameRequest.OnSetState: %s", state)
  do return NetworkMgr.Instance.Role.SetState, NetworkMgr.Instance.Role end
  return NetworkMgr.Instance.Role.SetState, NetworkMgr.Instance.Role, state
end

function GameRequest:OnRoleOpen(state)
  Logger.Proto("GameRequest.OnRoleOpen: %s", state)
  do return NetworkMgr.Instance.Role.OnOpen, NetworkMgr.Instance.Role end
  return NetworkMgr.Instance.Role.OnOpen, NetworkMgr.Instance.Role, state
end

function GameRequest:OnChangePlayerGender(gender)
  Logger.Proto("GameRequest.ChangePlayerGender: %s", gender)
  do return NetworkMgr.Instance.Role.ChangePlayerGender, NetworkMgr.Instance.Role end
  return NetworkMgr.Instance.Role.ChangePlayerGender, NetworkMgr.Instance.Role, gender
end

function GameRequest:ChangeSetting(id, value)
  do return NetworkMgr.Instance.Setting.ChangeSetting, NetworkMgr.Instance.Setting, id end
  return NetworkMgr.Instance.Setting.ChangeSetting, NetworkMgr.Instance.Setting, id, value
end

function GameRequest:Exchange(changeNum)
  do return NetworkMgr.Instance.Recharge.Exchange, NetworkMgr.Instance.Recharge end
  return NetworkMgr.Instance.Recharge.Exchange, NetworkMgr.Instance.Recharge, changeNum
end

function GameRequest:ExchangeGainReward(group, index)
  do return NetworkMgr.Instance.Recharge.ExchangeGainReward, NetworkMgr.Instance.Recharge, group end
  return NetworkMgr.Instance.Recharge.ExchangeGainReward, NetworkMgr.Instance.Recharge, group, index
end

function GameRequest:ExchangeGainRewardBatch(group, indexList)
  do return NetworkMgr.Instance.Recharge.ExchangeGainRewardBatch, NetworkMgr.Instance.Recharge, group end
  return NetworkMgr.Instance.Recharge.ExchangeGainRewardBatch, NetworkMgr.Instance.Recharge, group, indexList
end

function GameRequest:ChargeByItem(chargeTid)
  Logger.Proto("Recharge:", chargeTid)
  do return NetworkMgr.Instance.Recharge.ChargeByItem, NetworkMgr.Instance.Recharge end
  return NetworkMgr.Instance.Recharge.ChargeByItem, NetworkMgr.Instance.Recharge, chargeTid
end

function GameRequest:UseActiveCode(code)
  do return NetworkMgr.Instance.Setting.UseActiveCode, NetworkMgr.Instance.Setting end
  return NetworkMgr.Instance.Setting.UseActiveCode, NetworkMgr.Instance.Setting, code
end

function GameRequest:ShowTeam(teamType)
  Logger.Proto("ShowTeam:teamType=%s", teamType)
  do return NetworkMgr.Instance.Teams.ShowTeam, NetworkMgr.Instance.Teams end
  return NetworkMgr.Instance.Teams.ShowTeam, NetworkMgr.Instance.Teams, teamType
end

function GameRequest:UnlockTeam(teamType, index)
  Logger.Proto("UnlockTeamTeam:UnlockTeam=", teamType or "nil", index or "nil")
  do return NetworkMgr.Instance.Teams.UnlockTeam, NetworkMgr.Instance.Teams, teamType end
  return NetworkMgr.Instance.Teams.UnlockTeam, NetworkMgr.Instance.Teams, teamType, index
end

function GameRequest:UpdateTeam(teamType, awakerEquipData, idx, name, keeperSkillItem, awakerTids)
  local awakers = DBGTeamDataUtils.DealCfgNegativeAwakers(awakerTids)
  Logger.Proto("UpdateTeam: teamType = %s, awakerTids = %s, idx = %s, name = %s, keeperSkillTid = %s, awakerEquipData = %s", teamType, table.tostring(awakers), idx, name, keeperSkillItem, table.tostring(awakerEquipData))
  do return NetworkMgr.Instance.Teams.UpdateTeam, NetworkMgr.Instance.Teams, teamType, awakerEquipData, idx, name, keeperSkillItem end
  return NetworkMgr.Instance.Teams.UpdateTeam, NetworkMgr.Instance.Teams, teamType, awakerEquipData, idx, name, keeperSkillItem, awakers, table.tostring(awakerEquipData)
end

function GameRequest:UpdateTeam2(teamType, awakerTids, idx, name, keeperSkillTid, weaponSlots)
  Logger.Proto("UpdateTeam2: teamType = %s, awakerTids = %s, idx = %s, name = %s, keeperSkillTid = %s, weapons = %s", teamType, table.tostring(awakerTids), idx, name, keeperSkillTid, table.tostring(weaponSlots))
  do return NetworkMgr.Instance.Teams.UpdateTeam2, NetworkMgr.Instance.Teams, teamType, awakerTids, idx, name, keeperSkillTid end
  return NetworkMgr.Instance.Teams.UpdateTeam2, NetworkMgr.Instance.Teams, teamType, awakerTids, idx, name, keeperSkillTid, weaponSlots, table.tostring(weaponSlots)
end

function GameRequest:OnMove(x, y, z, player_statue)
  do return NetworkMgr.Instance.Postion.OnMove, x, y, z end
  return NetworkMgr.Instance.Postion.OnMove, x, y, z, player_statue
end

function GameRequest:OnRemoveRedPoint(redType, tid, keyType)
  Logger.Proto("OnRemoveRedPoint:", redType, tid, keyType)
  NetworkMgr.Instance.Redpoint.OnRemove(redType, tid, keyType)
end

function GameRequest:OnUseItem(tid, num)
  Logger.Proto("OnUseItem:tid=%s num=%s", tid, num)
  do return NetworkMgr.Instance.Item.OnUseItem, NetworkMgr.Instance.Item, tid end
  return NetworkMgr.Instance.Item.OnUseItem, NetworkMgr.Instance.Item, tid, num
end

function GameRequest:OnItemOpen()
  Logger.Proto("OnItemOpen")
  do return NetworkMgr.Instance.Item.OnOpen end
  return NetworkMgr.Instance.Item.OnOpen, NetworkMgr.Instance.Item
end

function GameRequest:OnCheckExpiryItem()
  Logger.Proto("Item:OnCheckExpiryItem")
  do return NetworkMgr.Instance.Item.OnCheckExpiryItem end
  return NetworkMgr.Instance.Item.OnCheckExpiryItem, NetworkMgr.Instance.Item
end

function GameRequest:OnLockItem(uid)
  AudioManager.Instance:PostSoundEvent("UI_CM_BTN_LOCK_ON")
  do return NetworkMgr.Instance.Item.OnLockItem, NetworkMgr.Instance.Item end
  return NetworkMgr.Instance.Item.OnLockItem, NetworkMgr.Instance.Item, uid
end

function GameRequest:OnUnlockItem(uid)
  AudioManager.Instance:PostSoundEvent("UI_CM_BTN_LOCK_OFF")
  do return NetworkMgr.Instance.Item.OnUnlockItem, NetworkMgr.Instance.Item end
  return NetworkMgr.Instance.Item.OnUnlockItem, NetworkMgr.Instance.Item, uid
end

function GameRequest:OnPutOnWeapon(awakerTid, slotType, uid)
  do return NetworkMgr.Instance.Item.OnPutOnWeapon, NetworkMgr.Instance.Item, awakerTid end
  return NetworkMgr.Instance.Item.OnPutOnWeapon, NetworkMgr.Instance.Item, awakerTid, {
    [slotType] = uid
  }
end

function GameRequest:OnTakeOffWeapon(awakerTid, slotType)
  do return NetworkMgr.Instance.Item.OnPutOnWeapon, NetworkMgr.Instance.Item, awakerTid end
  return NetworkMgr.Instance.Item.OnPutOnWeapon, NetworkMgr.Instance.Item, awakerTid, {
    [slotType] = 0
  }
end

function GameRequest:OnTakeOffAllWeapons(awakerTid, slotTypes)
  local params = {}
  for _, slotType in ipairs(slotTypes) do
    params[slotType] = 0
  end
  do return NetworkMgr.Instance.Item.OnPutOnWeapon, NetworkMgr.Instance.Item, awakerTid end
  return NetworkMgr.Instance.Item.OnPutOnWeapon, NetworkMgr.Instance.Item, awakerTid, params, nil, nil, nil
end

function GameRequest:OnAdvanceWeapon(uid, materialUid)
  local sendParam2 = materialUid
  if type(materialUid) == "number" then
    sendParam2 = {
      [materialUid] = 1
    }
  end
  do return NetworkMgr.Instance.Item.OnAdvanceWeapon, NetworkMgr.Instance.Item, uid end
  return NetworkMgr.Instance.Item.OnAdvanceWeapon, NetworkMgr.Instance.Item, uid, sendParam2
end

function GameRequest:OnMoneyExchange(num)
  do return NetworkMgr.Instance.Item.OnMoneyExchange, NetworkMgr.Instance.Item end
  return NetworkMgr.Instance.Item.OnMoneyExchange, NetworkMgr.Instance.Item, num
end

function GameRequest:OnShowWeapon()
  Logger.Proto("GameRequest:OnShowWeapon")
  do return NetworkMgr.Instance.Item.OnShowWeapon end
  return NetworkMgr.Instance.Item.OnShowWeapon, NetworkMgr.Instance.Item
end

function GameRequest:OnGetItemDetails(uid)
  do return NetworkMgr.Instance.Item.GetItemDetails, NetworkMgr.Instance.Item end
  return NetworkMgr.Instance.Item.GetItemDetails, NetworkMgr.Instance.Item, uid
end

function GameRequest:OnEnhanceWeapon(uid, materials)
  do return NetworkMgr.Instance.Item.OnEnhanceWeapon, NetworkMgr.Instance.Item, uid end
  return NetworkMgr.Instance.Item.OnEnhanceWeapon, NetworkMgr.Instance.Item, uid, materials
end

function GameRequest:OnBreakWeapon(uid)
  do return NetworkMgr.Instance.Item.OnBreakWeapon, NetworkMgr.Instance.Item end
  return NetworkMgr.Instance.Item.OnBreakWeapon, NetworkMgr.Instance.Item, uid
end

function GameRequest:OnItemExchange(num, exType)
  do return NetworkMgr.Instance.Item.OnItemExchange, NetworkMgr.Instance.Item, num end
  return NetworkMgr.Instance.Item.OnItemExchange, NetworkMgr.Instance.Item, num, exType
end

function GameRequest:OnUseChooseItem(tid, chooseItemTid, num)
  Logger.Proto("OnUseChooseItem:tid=%s chooseItemTid=%s num=%s", tid, chooseItemTid, num)
  do return NetworkMgr.Instance.Item.OnUseChooseItem, NetworkMgr.Instance.Item, tid, chooseItemTid end
  return NetworkMgr.Instance.Item.OnUseChooseItem, NetworkMgr.Instance.Item, tid, chooseItemTid, num
end

function GameRequest:QueryMyRecentReview(page)
  Logger.Proto("QueryMyRecentReview:page=%s", page)
  do return NetworkMgr.Instance.CopyReview.QueryMyRecentReview, NetworkMgr.Instance.CopyReview end
  return NetworkMgr.Instance.CopyReview.QueryMyRecentReview, NetworkMgr.Instance.CopyReview, page
end

function GameRequest:QueryStageReview(stageTid, page, sort)
  Logger.Proto("QueryStageReview:stageTid=%s, page=%s, sort=%s", stageTid, page, sort)
  do return NetworkMgr.Instance.CopyReview.QueryStageReview, NetworkMgr.Instance.CopyReview, stageTid, page end
  return NetworkMgr.Instance.CopyReview.QueryStageReview, NetworkMgr.Instance.CopyReview, stageTid, page, sort
end

function GameRequest:QueryStageReviewByAwaker(stageTid, page, sort, awakerMap)
  Logger.Proto("QueryStageReviewByAwaker:stageTid=%s, page=%s, sort=%s, awakerMap=%s", stageTid, page, sort, table.tostring(awakerMap))
  do return NetworkMgr.Instance.CopyReview.QueryStageReviewByAwaker, NetworkMgr.Instance.CopyReview, stageTid, page, sort end
  return NetworkMgr.Instance.CopyReview.QueryStageReviewByAwaker, NetworkMgr.Instance.CopyReview, stageTid, page, sort, awakerMap, table.tostring(awakerMap)
end

function GameRequest:QueryReviewDetail(stageTid, wid)
  Logger.Proto("QueryReviewDetail:stageTid=%s, wid=%s", stageTid, wid)
  do return NetworkMgr.Instance.CopyReview.QueryReviewDetail, NetworkMgr.Instance.CopyReview, stageTid end
  return NetworkMgr.Instance.CopyReview.QueryReviewDetail, NetworkMgr.Instance.CopyReview, stageTid, wid
end

function GameRequest:GetOSSHeader(battleUuid)
  Logger.Proto("GetOSSHeader:battleUuid=%s", battleUuid)
  do return NetworkMgr.Instance.CopyReview.GetOSSHeader, NetworkMgr.Instance.CopyReview end
  return NetworkMgr.Instance.CopyReview.GetOSSHeader, NetworkMgr.Instance.CopyReview, battleUuid
end

function GameRequest:SetHideReview(boolval)
  Logger.Proto("GameRequest:SetHideReview = %s", boolval)
  do return NetworkMgr.Instance.CopyReview.SetHideReview, NetworkMgr.Instance.CopyReview end
  return NetworkMgr.Instance.CopyReview.SetHideReview, NetworkMgr.Instance.CopyReview, boolval
end

function GameRequest:QueryOthersRecentReview(uid, widList)
  Logger.Proto("GameRequest:QueryOthersRecentReview: uid=%s, widList=%s", uid, table.tostring(widList))
  do return NetworkMgr.Instance.CopyReview.QueryOthersRecentReview, NetworkMgr.Instance.CopyReview, uid end
  return NetworkMgr.Instance.CopyReview.QueryOthersRecentReview, NetworkMgr.Instance.CopyReview, uid, widList, table.tostring(widList)
end

function GameRequest:QueryReviewDetail2(battleUuid)
  Logger.Proto("QueryReviewDetail2:battleUuid=%s", battleUuid)
  do return NetworkMgr.Instance.CopyReview.QueryReviewDetail2, NetworkMgr.Instance.CopyReview end
  return NetworkMgr.Instance.CopyReview.QueryReviewDetail2, NetworkMgr.Instance.CopyReview, battleUuid
end

function GameRequest:OnShowMainCopyAward(chapterTid)
  Logger.Proto("OnShowMainCopyAward:chapterTid=%s", chapterTid)
  do return NetworkMgr.Instance.MainCopy.OnShowMainCopyAward, NetworkMgr.Instance.MainCopy end
  return NetworkMgr.Instance.MainCopy.OnShowMainCopyAward, NetworkMgr.Instance.MainCopy, chapterTid
end

function GameRequest:OnGainMainCopyAward(copyTid, storyLineTid)
  Logger.Proto("OnGainMainCopyAward:copyTid=%s storyLineTid=%s", copyTid, storyLineTid)
  do return NetworkMgr.Instance.MainCopy.OnGainMainCopyAward, NetworkMgr.Instance.MainCopy, copyTid end
  return NetworkMgr.Instance.MainCopy.OnGainMainCopyAward, NetworkMgr.Instance.MainCopy, copyTid, storyLineTid
end

function GameRequest:OnGetMainCopyScore()
  Logger.Proto("OnGetMainCopyScore")
  do return NetworkMgr.Instance.MainCopy.OnGetMainCopyScore end
  return NetworkMgr.Instance.MainCopy.OnGetMainCopyScore, NetworkMgr.Instance.MainCopy
end

function GameRequest:GetAdvanceTaskAward(plot, challengeTid)
  Logger.Proto("GetAdvanceTaskAward:chapterTid=%s challengeTid=%s", plot, challengeTid)
  do return NetworkMgr.Instance.PlotChallenge.GetAdvanceTaskAward, NetworkMgr.Instance.PlotChallenge, plot end
  return NetworkMgr.Instance.PlotChallenge.GetAdvanceTaskAward, NetworkMgr.Instance.PlotChallenge, plot, challengeTid
end

function GameRequest:GainStageAchievementRw(stageTid, achieveId)
  do return NetworkMgr.Instance.Stage.GainStageAchievementRw, NetworkMgr.Instance.Stage, stageTid end
  return NetworkMgr.Instance.Stage.GainStageAchievementRw, NetworkMgr.Instance.Stage, stageTid, achieveId
end

function GameRequest:GainAllStageGroupStarRw(stageGroupTid)
  Logger.Proto("GainAllStageGroupStarRw:stageGroupTid=%s", stageGroupTid)
  do return NetworkMgr.Instance.Stage.GainAllStageGroupStarRw, NetworkMgr.Instance.Stage end
  return NetworkMgr.Instance.Stage.GainAllStageGroupStarRw, NetworkMgr.Instance.Stage, stageGroupTid
end

function GameRequest:GainStageGroupAchievementRw(stageGroupTid)
  Logger.Proto("GainStageGroupAchievementRw:stageGroupTid=%s", stageGroupTid)
  do return NetworkMgr.Instance.Stage.GainStageGroupAchievementRw, NetworkMgr.Instance.Stage end
  return NetworkMgr.Instance.Stage.GainStageGroupAchievementRw, NetworkMgr.Instance.Stage, stageGroupTid
end

function GameRequest:OnGetDailyCopyInfos()
  do return NetworkMgr.Instance.DailyCopy.OnGetDailyCopyInfos end
  return NetworkMgr.Instance.DailyCopy.OnGetDailyCopyInfos, NetworkMgr.Instance.DailyCopy
end

function GameRequest:OnGetDailyLevelInfo(dungeonType)
  do return NetworkMgr.Instance.DailyCopy.OnGetDailyLevelInfo, NetworkMgr.Instance.DailyCopy end
  return NetworkMgr.Instance.DailyCopy.OnGetDailyLevelInfo, NetworkMgr.Instance.DailyCopy, dungeonType
end

function GameRequest:OnEnterDailyCopy(levelId)
  Logger.Proto("GameRequest:OnEnterDailyCopy", levelId)
  do return NetworkMgr.Instance.DailyCopy.OnEnterDailyCopy, NetworkMgr.Instance.DailyCopy end
  return NetworkMgr.Instance.DailyCopy.OnEnterDailyCopy, NetworkMgr.Instance.DailyCopy, levelId
end

function GameRequest:OnSummon(tid, times, type)
  Logger.Proto("GameRequest:OnSummon:tid=%d times=%d type=%s", tid, times, type)
  do return NetworkMgr.Instance.Summon.OnSummon, NetworkMgr.Instance.Summon, tid, times end
  return NetworkMgr.Instance.Summon.OnSummon, NetworkMgr.Instance.Summon, tid, times, type
end

function GameRequest:OnOpenSummon()
  Logger.Proto("GameRequest:OnOpenSummon")
  do return NetworkMgr.Instance.Summon.OnOpen end
  return NetworkMgr.Instance.Summon.OnOpen, NetworkMgr.Instance.Summon
end

function GameRequest:OnChooseUpSSR(poolType, weaponTid)
  Logger.Proto("GameRequest:OnChooseUpSSR: poolType = %s, weaponTid=%s", weaponTid)
  do return NetworkMgr.Instance.Summon.ChooseUpSSR, NetworkMgr.Instance.Summon, poolType end
  return NetworkMgr.Instance.Summon.ChooseUpSSR, NetworkMgr.Instance.Summon, poolType, weaponTid
end

function GameRequest:OnResummon(summonId, times, type)
  do return NetworkMgr.Instance.Summon.OnResummon, NetworkMgr.Instance.Summon, summonId, times end
  return NetworkMgr.Instance.Summon.OnResummon, NetworkMgr.Instance.Summon, summonId, times, type
end

function GameRequest:ConfirmResummon(summonId)
  do return NetworkMgr.Instance.Summon.ConfirmResummon, NetworkMgr.Instance.Summon end
  return NetworkMgr.Instance.Summon.ConfirmResummon, NetworkMgr.Instance.Summon, summonId
end

function GameRequest:OnChooseCareer(summonId)
  do return NetworkMgr.Instance.Summon.OnChooseCareer, NetworkMgr.Instance.Summon end
  return NetworkMgr.Instance.Summon.OnChooseCareer, NetworkMgr.Instance.Summon, summonId
end

function GameRequest:OnQuerySummonHistory(type, page)
  do return NetworkMgr.Instance.Summon.QuerySummonHistory, NetworkMgr.Instance.Summon, type end
  return NetworkMgr.Instance.Summon.QuerySummonHistory, NetworkMgr.Instance.Summon, type, page
end

function GameRequest:OnChooseUpAwaker(type, summonPoolTid, itemTid)
  do return NetworkMgr.Instance.Summon.ChooseUpAwaker, NetworkMgr.Instance.Summon, type, summonPoolTid end
  return NetworkMgr.Instance.Summon.ChooseUpAwaker, NetworkMgr.Instance.Summon, type, summonPoolTid, itemTid
end

function GameRequest:ChooseMultiAwakerTargets(summonId, awakerTidList)
  Logger.Proto("GameRequest:ChooseMultiAwakerTargets: summonId = %s, awakerTidList = %s", summonId, table.tostring(awakerTidList))
  do return NetworkMgr.Instance.Summon.ChooseMultiAwakerTargets, NetworkMgr.Instance.Summon, summonId end
  return NetworkMgr.Instance.Summon.ChooseMultiAwakerTargets, NetworkMgr.Instance.Summon, summonId, awakerTidList, table.tostring(awakerTidList)
end

function GameRequest:ChooseMultiCategoryAwakerTargets(summonId, awakerItemTids)
  Logger.Proto("GameRequest:ChooseMultiCategoryAwakerTargets: summonId = %s, awakerItemTids = %s", summonId, table.tostring(awakerItemTids))
  do return NetworkMgr.Instance.Summon.ChooseMultiCategoryAwakerTargets, NetworkMgr.Instance.Summon, summonId end
  return NetworkMgr.Instance.Summon.ChooseMultiCategoryAwakerTargets, NetworkMgr.Instance.Summon, summonId, awakerItemTids, table.tostring(awakerItemTids)
end

function GameRequest:OnOpenRpgChallenge(level)
  Logger.Info("GameRequest:OnEnterRpgChallenge: ", level)
  do return NetworkMgr.Instance.GameChallenge.OpenRpgChallenge, NetworkMgr.Instance.GameChallenge end
  return NetworkMgr.Instance.GameChallenge.OpenRpgChallenge, NetworkMgr.Instance.GameChallenge, level
end

function GameRequest:OnEnterRpgChallenge(battleTid, awakers)
  Logger.Info("GameRequest:OnEnterRpgChallenge: ", battleTid, table.tostring(awakers))
  do return NetworkMgr.Instance.GameChallenge.EnterRpgChallenge, NetworkMgr.Instance.GameChallenge, battleTid end
  return NetworkMgr.Instance.GameChallenge.EnterRpgChallenge, NetworkMgr.Instance.GameChallenge, battleTid, awakers, table.tostring(awakers)
end

function GameRequest:OnOpenMoneyChallenge()
  Logger.Info("GameRequest:OnOpenMoneyChallenge")
  do return NetworkMgr.Instance.GameChallenge.OpenMoneyChallenge end
  return NetworkMgr.Instance.GameChallenge.OpenMoneyChallenge, NetworkMgr.Instance.GameChallenge
end

function GameRequest:OnEnterMoneyChallenge(tid, awakers)
  Logger.Info("GameRequest:OnEnterMoneyChallenge: ", tid, table.tostring(awakers))
  do return NetworkMgr.Instance.GameChallenge.EnterMoneyChallenge, NetworkMgr.Instance.GameChallenge, tid end
  return NetworkMgr.Instance.GameChallenge.EnterMoneyChallenge, NetworkMgr.Instance.GameChallenge, tid, awakers, table.tostring(awakers)
end

function GameRequest:OnCollectMoneyChallenge()
  Logger.Info("GameRequest:OnCollectMoneyChallenge: ")
  do return NetworkMgr.Instance.GameChallenge.CollectMoneyChallenge end
  return NetworkMgr.Instance.GameChallenge.CollectMoneyChallenge, NetworkMgr.Instance.GameChallenge
end

function GameRequest:OnWorldRecover(worldTid)
  Logger.Proto("GameRequest:OnWorldRecover worldTid ", worldTid)
  do return NetworkMgr.Instance.World.OnRecover, NetworkMgr.Instance.World end
  return NetworkMgr.Instance.World.OnRecover, NetworkMgr.Instance.World, worldTid
end

function GameRequest:OnWorldEnterSuccess()
  Logger.Proto("GameRequest:OnWorldEnterSuccess worldTid ")
  do return end
  return NetworkMgr.Instance.World.EnterWorldSuccess, "GameRequest:OnWorldEnterSuccess worldTid "
end

function GameRequest:OnOpenShop()
  do return NetworkMgr.Instance.Shop.Open end
  return NetworkMgr.Instance.Shop.Open, NetworkMgr.Instance.Shop
end

function GameRequest:OnShopBuyGoods(uid, shopType, buyNum)
  Logger.Proto("GameRequest:OnShopBuyGoods: param = ", uid, shopType, buyNum)
  do return NetworkMgr.Instance.Shop.Buy, NetworkMgr.Instance.Shop, uid, shopType end
  return NetworkMgr.Instance.Shop.Buy, NetworkMgr.Instance.Shop, uid, shopType, buyNum
end

function GameRequest:OnShopBatchBuyGoods(uids, shopType)
  Logger.Proto("GameRequest:OnShopBuyGoods: param = ", table.tostring(uids, "", ""), shopType)
  do return NetworkMgr.Instance.Shop.BatchBuy, NetworkMgr.Instance.Shop, uids end
  return NetworkMgr.Instance.Shop.BatchBuy, NetworkMgr.Instance.Shop, uids, shopType, "", ""
end

function GameRequest:OnShopRefresh(shopType)
  Logger.Proto("GameRequest:OnShopRefresh: param = ", shopType)
  do return NetworkMgr.Instance.Shop.Refresh, NetworkMgr.Instance.Shop end
  return NetworkMgr.Instance.Shop.Refresh, NetworkMgr.Instance.Shop, shopType
end

function GameRequest:OnShopOneKeyBuy(shopType, tbl)
  Logger.Proto("GameRequest:OnShopOneKeyBuy: param = ", shopType, table.tostring(tbl))
  do return NetworkMgr.Instance.Shop.OneKeyBuy, NetworkMgr.Instance.Shop, shopType end
  return NetworkMgr.Instance.Shop.OneKeyBuy, NetworkMgr.Instance.Shop, shopType, tbl, table.tostring(tbl)
end

function GameRequest:OnChooseBuy(goodTid, chooseTids)
  Logger.Proto("GameRequest:OnChooseBuy: param = ", goodTid, table.tostring(chooseTids))
  do return NetworkMgr.Instance.Shop.OnChooseBuy, NetworkMgr.Instance.Shop, goodTid end
  return NetworkMgr.Instance.Shop.OnChooseBuy, NetworkMgr.Instance.Shop, goodTid, chooseTids, table.tostring(chooseTids)
end

function GameRequest:OnBuyMultipleChooseItem(shopItemId, params)
  Logger.Proto("GameRequest:OnBuyMultipleChooseItem: param = ", shopItemId, table.tostring(params))
  do return NetworkMgr.Instance.Shop.OnBuyMultipleChooseItem, NetworkMgr.Instance.Shop, shopItemId end
  return NetworkMgr.Instance.Shop.OnBuyMultipleChooseItem, NetworkMgr.Instance.Shop, shopItemId, params, table.tostring(params)
end

function GameRequest:OnOpenRecharge()
  Logger.Proto("GameRequest:OnOpenRecharge: ")
  do return NetworkMgr.Instance.Recharge.OnOpen end
  return NetworkMgr.Instance.Recharge.OnOpen, NetworkMgr.Instance.Recharge
end

function GameRequest:OnRecharge(tid)
  Logger.Proto("GameRequest:OnRecharge: ")
  do return NetworkMgr.Instance.Recharge.OnRecharge, NetworkMgr.Instance.Recharge end
  return NetworkMgr.Instance.Recharge.OnRecharge, NetworkMgr.Instance.Recharge, tid
end

function GameRequest:SyncMonthCard(monthCardType)
  Logger.Info("GameRequest:SyncMonthCard: param = ", monthCardType)
  do return NetworkMgr.Instance.MonthCard.SyncMonthCard, NetworkMgr.Instance.MonthCard end
  return NetworkMgr.Instance.MonthCard.SyncMonthCard, NetworkMgr.Instance.MonthCard, monthCardType
end

function GameRequest:PurchaseMonthCard(monthCardType)
  Logger.Info("GameRequest:Purchase: param = ", monthCardType)
  do return NetworkMgr.Instance.MonthCard.Purchase, NetworkMgr.Instance.MonthCard end
  return NetworkMgr.Instance.MonthCard.Purchase, NetworkMgr.Instance.MonthCard, monthCardType
end

function GameRequest:GainTodayReward()
  Logger.Info("GameRequest:GainTodayReward")
  do return NetworkMgr.Instance.MonthCard.GainTodayReward end
  return NetworkMgr.Instance.MonthCard.GainTodayReward, NetworkMgr.Instance.MonthCard
end

function GameRequest:OnHomeOpen()
  Logger.Proto("%s:OnHomeOpen: ", self.__name)
  do return NetworkMgr.Instance.Home.OnOpen end
  return NetworkMgr.Instance.Home.OnOpen, NetworkMgr.Instance.Home, self.__name
end

function GameRequest:OnHomeGainBuildPrize(uid)
  Logger.Proto("%s:OnHomeBuildGainPrize: param=%s", self.__name, uid)
  do return NetworkMgr.Instance.Home.OnGainBuildPrize, NetworkMgr.Instance.Home end
  return NetworkMgr.Instance.Home.OnGainBuildPrize, NetworkMgr.Instance.Home, uid, uid
end

function GameRequest:OnHomeOpenTechnology()
  Logger.Proto("%s:OnHomeOpenTechnology: ", self.__name)
  do return NetworkMgr.Instance.Home.OnOpenTechnology end
  return NetworkMgr.Instance.Home.OnOpenTechnology, NetworkMgr.Instance.Home, self.__name
end

function GameRequest:OnHomeStudyTechnology(tid)
  Logger.Proto("%s:OnHomeStudyTechnology: param=%s", self.__name, tid)
  do return NetworkMgr.Instance.Home.OnStudyTechnology, NetworkMgr.Instance.Home end
  return NetworkMgr.Instance.Home.OnStudyTechnology, NetworkMgr.Instance.Home, tid, tid
end

function GameRequest:OnHomeCancelStudyTechnology(tid)
  Logger.Proto("%s:OnHomeCancelStudyTechnology: param=%s", self.__name, tid)
  do return NetworkMgr.Instance.Home.OnCancelStudyTechnology, NetworkMgr.Instance.Home end
  return NetworkMgr.Instance.Home.OnCancelStudyTechnology, NetworkMgr.Instance.Home, tid, tid
end

function GameRequest:OnHomeStudyTechnologyFinish(tid)
  Logger.Proto("%s:OnHomeStudyTechnologyFinish: param=%s", self.__name, tid)
  do return NetworkMgr.Instance.Home.OnStudyTechnologyFinish, NetworkMgr.Instance.Home end
  return NetworkMgr.Instance.Home.OnStudyTechnologyFinish, NetworkMgr.Instance.Home, tid, tid
end

function GameRequest:OnHomeQuickenTechnology(tid)
  Logger.Proto("%s:OnHomeQuickenTechnology: param=%s", self.__name, tid)
  do return NetworkMgr.Instance.Home.OnQuickenTechnology, NetworkMgr.Instance.Home end
  return NetworkMgr.Instance.Home.OnQuickenTechnology, NetworkMgr.Instance.Home, tid, tid
end

function GameRequest:OnOpenDailyChallenge()
  Logger.Proto("%s:OnOpenDailyChallenge:", self.__name)
  do return NetworkMgr.Instance.DailyChallenge.OnOpen end
  return NetworkMgr.Instance.DailyChallenge.OnOpen, NetworkMgr.Instance.DailyChallenge, self.__name
end

function GameRequest:OnCutClass()
  Logger.Proto("%s:OnCutClass:", self.__name)
  do return NetworkMgr.Instance.DailyChallenge.OnCutClass end
  return NetworkMgr.Instance.DailyChallenge.OnCutClass, NetworkMgr.Instance.DailyChallenge, self.__name
end

function GameRequest:OnDailyChallenge(chooseTalentList)
  Logger.Proto("%s:OnDailyChallenge: chooseTalentList=%s", self.__name, table.tostring(chooseTalentList, "", ""))
  do return NetworkMgr.Instance.DailyChallenge.OnChallenge, NetworkMgr.Instance.DailyChallenge end
  return NetworkMgr.Instance.DailyChallenge.OnChallenge, NetworkMgr.Instance.DailyChallenge, chooseTalentList, table.tostring(chooseTalentList, "", "")
end

function GameRequest:OnDailyChallengeChooseTalent(tid)
  Logger.Proto("%s:OnDailyChallengeChooseTalent: param=%s", self.__name, tid)
  do return NetworkMgr.Instance.DailyChallenge.OnChooseTalent, NetworkMgr.Instance.DailyChallenge end
  return NetworkMgr.Instance.DailyChallenge.OnChooseTalent, NetworkMgr.Instance.DailyChallenge, tid, tid
end

function GameRequest:OnDailyChallengeGainPrize(index)
  Logger.Proto("%s:OnDailyChallengeGainPrize: param=%s", self.__name, index)
  do return NetworkMgr.Instance.DailyChallenge.OnGainPrize, NetworkMgr.Instance.DailyChallenge end
  return NetworkMgr.Instance.DailyChallenge.OnGainPrize, NetworkMgr.Instance.DailyChallenge, index, index
end

function GameRequest:OnDailyChallengeGainAchievePrize(index)
  Logger.Proto("%s:OnDailyChallengeGainAchievePrize: param=%s", self.__name, index)
  do return NetworkMgr.Instance.DailyChallenge.OnGainLifePrize, NetworkMgr.Instance.DailyChallenge end
  return NetworkMgr.Instance.DailyChallenge.OnGainLifePrize, NetworkMgr.Instance.DailyChallenge, index, index
end

function GameRequest:OnDailyChallengeGainAllPrize()
  Logger.Proto("DailyChallenge:OnGainAllPrize")
  do return NetworkMgr.Instance.DailyChallenge.OnGainAllPrize end
  return NetworkMgr.Instance.DailyChallenge.OnGainAllPrize, NetworkMgr.Instance.DailyChallenge
end

function GameRequest:OnDailyChallengeGainAllLifePrize()
  Logger.Proto("DailyChallenge:OnGainAllLifePrize")
  do return NetworkMgr.Instance.DailyChallenge.OnGainAllLifePrize end
  return NetworkMgr.Instance.DailyChallenge.OnGainAllLifePrize, NetworkMgr.Instance.DailyChallenge
end

function GameRequest:OnOpenWeekChallenge()
  Logger.Proto("%s:OnOpenWeekChallenge:", self.__name)
  do return NetworkMgr.Instance.WeekChallenge.OnOpen end
  return NetworkMgr.Instance.WeekChallenge.OnOpen, NetworkMgr.Instance.WeekChallenge, self.__name
end

function GameRequest:OnWeekChallenge(stageTid, awakerList)
  Logger.Proto("%s:OnWeekChallenge: stageTid=%s awakerList=%s chooseTalentList=%s", self.__name, stageTid, table.tostring(awakerList, "", ""))
  do return NetworkMgr.Instance.WeekChallenge.OnChallenge, NetworkMgr.Instance.WeekChallenge, stageTid end
  return NetworkMgr.Instance.WeekChallenge.OnChallenge, NetworkMgr.Instance.WeekChallenge, stageTid, awakerList, table.tostring(awakerList, "", "")
end

function GameRequest:OnChooseWeekChallengeStageGroup(stageGroupTid)
  Logger.Proto("%s:OnChooseWeekChallengeStageGroup: param=%s", self.__name, stageGroupTid)
  do return NetworkMgr.Instance.WeekChallenge.OnChooseStageGroup, NetworkMgr.Instance.WeekChallenge end
  return NetworkMgr.Instance.WeekChallenge.OnChooseStageGroup, NetworkMgr.Instance.WeekChallenge, stageGroupTid, stageGroupTid
end

function GameRequest:OnWeekChallengeRefresh(stageGroupTid)
  Logger.Proto("%s:OnWeekChallengeRefresh: param=%s", self.__name, stageGroupTid)
  do return NetworkMgr.Instance.WeekChallenge.OnRefresh, NetworkMgr.Instance.WeekChallenge end
  return NetworkMgr.Instance.WeekChallenge.OnRefresh, NetworkMgr.Instance.WeekChallenge, stageGroupTid, stageGroupTid
end

function GameRequest:OnOpenSchoolTower()
  Logger.Proto("%s:OnOpenSchoolTower", self.__name)
  do return NetworkMgr.Instance.SchoolTowerMgr.OnOpenSchoolTower end
  return NetworkMgr.Instance.SchoolTowerMgr.OnOpenSchoolTower, NetworkMgr.Instance.SchoolTowerMgr, self.__name
end

function GameRequest:OnMaterialExchange(tid, exchangeGroup, notShow)
  notShow = notShow or false
  Logger.Proto("%s:OnMaterialEchange: param=%s-%s-%s", self.__name, tid, table.tostring(exchangeGroup), notShow)
  do return NetworkMgr.Instance.HomeConversion.OnMaterialExchange, NetworkMgr.Instance.HomeConversion, tid, exchangeGroup end
  return NetworkMgr.Instance.HomeConversion.OnMaterialExchange, NetworkMgr.Instance.HomeConversion, tid, exchangeGroup, notShow, notShow
end

function GameRequest:OnConversionRemainCountGet()
  Logger.Proto("%s:OnConversionRemainCountGet: param=%s", self.__name)
  do return NetworkMgr.Instance.HomeConversion.OnOpen, NetworkMgr.Instance.HomeConversion end
  return NetworkMgr.Instance.HomeConversion.OnOpen, NetworkMgr.Instance.HomeConversion, "overflowComposeRemainCount"
end

function GameRequest:OnExchangePlanGet()
  Logger.Proto("%s:OnExchangePlanGet: param=%s", self.__name)
  do return NetworkMgr.Instance.HomeConversion.OnOpen, NetworkMgr.Instance.HomeConversion end
  return NetworkMgr.Instance.HomeConversion.OnOpen, NetworkMgr.Instance.HomeConversion, "trinketExchangePreference"
end

function GameRequest:OnExchangePlanSet(exchangePlan)
  Logger.Proto("%s:OnExchangePlanSet: param=%s", self.__name, table.tostring(exchangePlan))
  do return NetworkMgr.Instance.HomeConversion.OnSet, NetworkMgr.Instance.HomeConversion, "trinketExchangePreference" end
  return NetworkMgr.Instance.HomeConversion.OnSet, NetworkMgr.Instance.HomeConversion, "trinketExchangePreference", exchangePlan, table.tostring(exchangePlan)
end

function GameRequest:OnItemDecompose(itemUidGroup, num)
  Logger.Proto("%s:OnItemDecompose: param=%s-%s", self.__name, table.tostring(itemUidGroup))
  do return NetworkMgr.Instance.HomeConversion.OnDecompose, NetworkMgr.Instance.HomeConversion, itemUidGroup end
  return NetworkMgr.Instance.HomeConversion.OnDecompose, NetworkMgr.Instance.HomeConversion, itemUidGroup, num, table.tostring(itemUidGroup)
end

function GameRequest:OnDecomposeList(uid2NumDict)
  Logger.Proto("%s:OnDecomposeList: param=%s", self.__name, table.tostring(uid2NumDict))
  do return NetworkMgr.Instance.HomeConversion.OnDecomposeList, NetworkMgr.Instance.HomeConversion end
  return NetworkMgr.Instance.HomeConversion.OnDecomposeList, NetworkMgr.Instance.HomeConversion, uid2NumDict, table.tostring(uid2NumDict)
end

function GameRequest:OnItemCompose(tid, composeNum)
  Logger.Proto("%s:OnItemCompose: param=%s-%s", self.__name, tid, composeNum)
  do return NetworkMgr.Instance.HomeConversion.OnCompose, NetworkMgr.Instance.HomeConversion, tid end
  return NetworkMgr.Instance.HomeConversion.OnCompose, NetworkMgr.Instance.HomeConversion, tid, composeNum, composeNum
end

function GameRequest:OnItemRecasting(tid, costItemUids)
  Logger.Proto("%s:OnItemRecasting: param=%s-%s", self.__name, tid, table.tostring(costItemUids, "", ""))
  do return NetworkMgr.Instance.HomeConversion.OnRecasting, NetworkMgr.Instance.HomeConversion, tid end
  return NetworkMgr.Instance.HomeConversion.OnRecasting, NetworkMgr.Instance.HomeConversion, tid, costItemUids, table.tostring(costItemUids, "", "")
end

function GameRequest:OnOpenItemConversion(tp)
  Logger.Proto("%s:OnItemRecasting: param=%s-%s", self.__name, tp)
  do return NetworkMgr.Instance.HomeConversion.OnOpen, NetworkMgr.Instance.HomeConversion end
  return NetworkMgr.Instance.HomeConversion.OnOpen, NetworkMgr.Instance.HomeConversion, tp, tp
end

function GameRequest:OnImportAccountJson(data, isFinish)
  Logger.Proto("%s:OnImportAccountJson: param=%s-%s", self.__name, string.len(data), isFinish)
  do return NetworkMgr.Instance.Gm.OnImportAccountJson, NetworkMgr.Instance.Gm, data end
  return NetworkMgr.Instance.Gm.OnImportAccountJson, NetworkMgr.Instance.Gm, data, isFinish, isFinish
end

function GameRequest:OnOpenEmail()
  Logger.Proto("%s:OnOpenEmail", self.__name)
  do return NetworkMgr.Instance.Email.OnOpen end
  return NetworkMgr.Instance.Email.OnOpen, NetworkMgr.Instance.Email, self.__name
end

function GameRequest:OnOpenCollectionEmail()
  Logger.Proto("%s:OnOpenCollectionEmail", self.__name)
  do return NetworkMgr.Instance.Email.OnOpenCollection end
  return NetworkMgr.Instance.Email.OnOpenCollection, NetworkMgr.Instance.Email, self.__name
end

function GameRequest:OnOpenEmailDetails(mailUid)
  Logger.Proto("%s:OnOpenEmailDetails: param=%s", self.__name, mailUid)
  do return NetworkMgr.Instance.Email.OnOpenDetails, NetworkMgr.Instance.Email end
  return NetworkMgr.Instance.Email.OnOpenDetails, NetworkMgr.Instance.Email, mailUid, mailUid
end

function GameRequest:OnEmailSign(mailUid)
  Logger.Proto("%s:OnEmailSign: param=%s", self.__name, mailUid)
  do return NetworkMgr.Instance.Email.OnSign, NetworkMgr.Instance.Email end
  return NetworkMgr.Instance.Email.OnSign, NetworkMgr.Instance.Email, mailUid, mailUid
end

function GameRequest:OnEmailDelete(mailUid)
  Logger.Proto("%s:OnEmailDelete: param=%s", self.__name, mailUid)
  do return NetworkMgr.Instance.Email.OnDelete, NetworkMgr.Instance.Email end
  return NetworkMgr.Instance.Email.OnDelete, NetworkMgr.Instance.Email, mailUid, mailUid
end

function GameRequest:OnEmailDeleteAll(tp)
  Logger.Proto("%s:OnEmailDeleteAll: param=%s", self.__name, tp)
  do return NetworkMgr.Instance.Email.OnDeleteAll, NetworkMgr.Instance.Email end
  return NetworkMgr.Instance.Email.OnDeleteAll, NetworkMgr.Instance.Email, tp, tp
end

function GameRequest:OnEmailGainItem(mailUid)
  Logger.Proto("%s:OnGainItem: param=%s", self.__name, mailUid)
  do return NetworkMgr.Instance.Email.OnGainItem, NetworkMgr.Instance.Email end
  return NetworkMgr.Instance.Email.OnGainItem, NetworkMgr.Instance.Email, mailUid, mailUid
end

function GameRequest:OnAllEmailGainItem()
  Logger.Proto("%s:OnAllEmailGainItem", self.__name)
  do return NetworkMgr.Instance.Email.OnAllGainItem end
  return NetworkMgr.Instance.Email.OnAllGainItem, NetworkMgr.Instance.Email, self.__name
end

function GameRequest:OnQueryAllGainEnergyItemCount()
  Logger.Proto("%s:OnQeuryAllGainEnergyItemCount", self.__name)
  do return NetworkMgr.Instance.Email.OnQueryAllGainEnergyItemCount end
  return NetworkMgr.Instance.Email.OnQueryAllGainEnergyItemCount, NetworkMgr.Instance.Email, self.__name
end

function GameRequest:OnGainQuestionnairePrize(id, items)
  Logger.Proto("%s:OnGainQuestionnairePrize , id, items", self.__name, id, table.tostring(items))
  do return NetworkMgr.Instance.Email.OnGainQuestionnairePrize, NetworkMgr.Instance.Email, id end
  return NetworkMgr.Instance.Email.OnGainQuestionnairePrize, NetworkMgr.Instance.Email, id, items, table.tostring(items)
end

function GameRequest:SetIntroductionStep()
  Logger.Proto("%s:SetIntroductionStep", self.__name)
  do return NetworkMgr.Instance.Intro.SetIntroductionStep end
  return NetworkMgr.Instance.Intro.SetIntroductionStep, NetworkMgr.Instance.Intro, self.__name
end

function GameRequest:SetPlayerNameAndGender(name, gender)
  Logger.Proto("%s:SetPlayerNameAndGender, name = %s, gender = %s", self.__name, name, gender)
  do return NetworkMgr.Instance.Role.SetPlayerNameAndGender, NetworkMgr.Instance.Role, name end
  return NetworkMgr.Instance.Role.SetPlayerNameAndGender, NetworkMgr.Instance.Role, name, gender, gender
end

function GameRequest:OnChangeNameTime()
  Logger.Proto("%s:OnChangeNameTime", self.__name)
  do return NetworkMgr.Instance.Role.OnChangeNameTime end
  return NetworkMgr.Instance.Role.OnChangeNameTime, NetworkMgr.Instance.Role, self.__name
end

function GameRequest:OnChangeName(name)
  Logger.Proto("%s:OnChangeName, name = %s", self.__name, name)
  do return NetworkMgr.Instance.Role.OnChangeName, NetworkMgr.Instance.Role end
  return NetworkMgr.Instance.Role.OnChangeName, NetworkMgr.Instance.Role, name, name
end

function GameRequest:OnBreak(awakerTid)
  Logger.Proto("OnBreak: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnBreak, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnBreak, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:OnAutoComposeList(itemList)
  Logger.Proto("OnAutoComposeList: itemList=%s", table.tostring(itemList))
  do return NetworkMgr.Instance.HomeConversion.OnAutoComposeList, NetworkMgr.Instance.HomeConversion end
  return NetworkMgr.Instance.HomeConversion.OnAutoComposeList, NetworkMgr.Instance.HomeConversion, itemList, table.tostring(itemList)
end

function GameRequest:OnSwitchAwakerShape(awakerTid)
  Logger.Proto("OnSwitchAwakerShape: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnSwitchAwakerShape, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnSwitchAwakerShape, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:OnUnlockOriginShape(awakerTid)
  Logger.Proto("OnUnlockOriginShape: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnUnlockOriginShape, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnUnlockOriginShape, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:PreviewAwakerBacktrackItems(awakerTid)
  Logger.Proto("PreviewAwakerBacktrackItems: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnGetAwakerBacktrackItems, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnGetAwakerBacktrackItems, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:OnBacktrackPotency(awakerTid)
  Logger.Proto("OnBacktrackPotency: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnBacktrackPotency, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnBacktrackPotency, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:OnBacktrackLevel(awakerTid)
  Logger.Proto("OnBacktrackLevel: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnBacktrackLevel, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnBacktrackLevel, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:OnBacktrackAll(awakerTid)
  Logger.Proto("OnBacktrackAll: awakerTid=%s", awakerTid)
  do return NetworkMgr.Instance.Awaker.OnBacktrackAll, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnBacktrackAll, NetworkMgr.Instance.Awaker, awakerTid
end

function GameRequest:MarkPvpOpeningVoiceRead(pvpVoiceTidList)
  Logger.Proto("MarkPvpOpeningVoiceRead: pvpVoiceTidList = %s", table.tostring(pvpVoiceTidList))
  do return NetworkMgr.Instance.Awaker.MarkPvpOpeningVoiceRead, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.MarkPvpOpeningVoiceRead, NetworkMgr.Instance.Awaker, pvpVoiceTidList, table.tostring(pvpVoiceTidList)
end

function GameRequest:UnlockPvpOpeningVoice(pvpVoiceTid)
  Logger.Proto("UnlockPvpOpeningVoice: pvpVoiceTid = %s", pvpVoiceTid)
  do return NetworkMgr.Instance.Awaker.UnlockPvpOpeningVoice, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.UnlockPvpOpeningVoice, NetworkMgr.Instance.Awaker, pvpVoiceTid
end

function GameRequest:GetPvpOpeningVoices()
  Logger.Proto("GetPvpOpeningVoices")
  do return NetworkMgr.Instance.Awaker.GetPvpOpeningVoices end
  return NetworkMgr.Instance.Awaker.GetPvpOpeningVoices, NetworkMgr.Instance.Awaker
end

function GameRequest:PreviewWeaponBacktrackItems(uid)
  Logger.Proto("PreviewWeaponBacktrackItems: uid=%s", uid)
  do return NetworkMgr.Instance.Weapon.OnGetWeaponBacktrackItems, NetworkMgr.Instance.Weapon end
  return NetworkMgr.Instance.Weapon.OnGetWeaponBacktrackItems, NetworkMgr.Instance.Weapon, uid
end

function GameRequest:OnWeaponBacktrackAdvance(uid)
  Logger.Proto("OnWeaponBacktrackAdvance: uid=%s", uid)
  do return NetworkMgr.Instance.Weapon.OnBacktrackAdvance, NetworkMgr.Instance.Weapon end
  return NetworkMgr.Instance.Weapon.OnBacktrackAdvance, NetworkMgr.Instance.Weapon, uid
end

function GameRequest:OnWeaponBacktrackAll(uid)
  Logger.Proto("OnWeaponBacktrackAll: uid=%s", uid)
  do return NetworkMgr.Instance.Weapon.OnBacktrackAll, NetworkMgr.Instance.Weapon end
  return NetworkMgr.Instance.Weapon.OnBacktrackAll, NetworkMgr.Instance.Weapon, uid
end

function GameRequest:OnUseBacktrackItem(tid, chooseId)
  Logger.Proto("OnUseBacktrackItem: tid=%s, chooseId", tid, chooseId)
  do return NetworkMgr.Instance.Item.OnUseBacktrackItem, NetworkMgr.Instance.Item, tid end
  return NetworkMgr.Instance.Item.OnUseBacktrackItem, NetworkMgr.Instance.Item, tid, chooseId
end

function GameRequest:GainLikeReward(tid, lv)
  Logger.Proto("%s:GainLikeReward: param=%s-%s", self.__name, tid, table.tostring(lv))
  do return NetworkMgr.Instance.Awaker.GainLikeReward, NetworkMgr.Instance.Awaker, tid end
  return NetworkMgr.Instance.Awaker.GainLikeReward, NetworkMgr.Instance.Awaker, tid, lv, table.tostring(lv)
end

function GameRequest:GainBreakReward(awakerTid, breakLevel)
  Logger.Proto("GainBreakReward: awakerTid=%s, breakLevel=%s", awakerTid, breakLevel)
  do return NetworkMgr.Instance.Awaker.GainBreakReward, NetworkMgr.Instance.Awaker, awakerTid end
  return NetworkMgr.Instance.Awaker.GainBreakReward, NetworkMgr.Instance.Awaker, awakerTid, breakLevel
end

function GameRequest:OnGetPvpCollection()
  Logger.Proto("Pvp:OnGetPVPCollection")
  do return NetworkMgr.Instance.PvpCollect.GetClientProfile end
  return NetworkMgr.Instance.PvpCollect.GetClientProfile, NetworkMgr.Instance.PvpCollect
end

function GameRequest:OnOpenPvp()
  Logger.Proto("Pvp:OnOpen")
  do return NetworkMgr.Instance.Pvp.OnOpen end
  return NetworkMgr.Instance.Pvp.OnOpen, NetworkMgr.Instance.Pvp
end

function GameRequest:GainRankReward(season, rankTid)
  Logger.Proto("GainRankReward: season=%s, rankTid=%s", season, rankTid)
  do return NetworkMgr.Instance.Pvp.GainRankReward, NetworkMgr.Instance.Pvp, season end
  return NetworkMgr.Instance.Pvp.GainRankReward, NetworkMgr.Instance.Pvp, season, rankTid
end

function GameRequest:OnHandleMoreGameInvite(isAccept)
  Logger.Proto("OnHandleMoreGameInvite:  isAccept=%s", isAccept)
  do return NetworkMgr.Instance.Pvp.OnHandleMoreGameInvite, NetworkMgr.Instance.Pvp end
  return NetworkMgr.Instance.Pvp.OnHandleMoreGameInvite, NetworkMgr.Instance.Pvp, isAccept
end

function GameRequest:OnLaunchMoreGame(uid)
  Logger.Proto("OnLaunchMoreGame:  uid=%s", uid)
  do return NetworkMgr.Instance.Pvp.OnLaunchMoreGame, NetworkMgr.Instance.Pvp end
  return NetworkMgr.Instance.Pvp.OnLaunchMoreGame, NetworkMgr.Instance.Pvp, uid
end

function GameRequest:OnCancelMoreGame()
  Logger.Proto("OnCancelMoreGame")
  do return NetworkMgr.Instance.Pvp.OnCancelMoreGame end
  return NetworkMgr.Instance.Pvp.OnCancelMoreGame, NetworkMgr.Instance.Pvp
end

function GameRequest:OnCancelLaunchMoreGame()
  Logger.Proto("OnCancelLaunchMoreGame")
  do return NetworkMgr.Instance.Pvp.OnCancelLaunchMoreGame end
  return NetworkMgr.Instance.Pvp.OnCancelLaunchMoreGame, NetworkMgr.Instance.Pvp
end

function GameRequest:GetGameDetailsListByUid(uid, page)
  Logger.Proto("GameRequest.GetGameDetailsListByUid:  uid=%s, page=%s", uid, page)
  do return NetworkMgr.Instance.Social.GetGameDetailsListByUid, NetworkMgr.Instance.Social, uid end
  return NetworkMgr.Instance.Social.GetGameDetailsListByUid, NetworkMgr.Instance.Social, uid, page
end

function GameRequest:GetInviteCode()
  Logger.Proto("GameRequest.GetInviteCode")
  do return NetworkMgr.Instance.Social.GetInviteCode end
  return NetworkMgr.Instance.Social.GetInviteCode, NetworkMgr.Instance.Social
end

function GameRequest:GetReplayDetail(battleUuid, playerUid)
  Logger.Proto("GameRequest.OnGetBattleDetail: battleUuid = %s, playerUid = %s", battleUuid, playerUid)
  do return NetworkMgr.Instance.Pvp.OnGetBattleDetail, NetworkMgr.Instance.Pvp, battleUuid end
  return NetworkMgr.Instance.Pvp.OnGetBattleDetail, NetworkMgr.Instance.Pvp, battleUuid, playerUid
end

function GameRequest:UseInviteCode(code)
  Logger.Proto("GameRequest.UseInviteCode:" .. code)
  do return NetworkMgr.Instance.Social.UseInviteCode, NetworkMgr.Instance.Social end
  return NetworkMgr.Instance.Social.UseInviteCode, NetworkMgr.Instance.Social, code
end

function GameRequest:GetInviteTaskList()
  Logger.Proto("GameRequest.GetInviteTaskList")
  do return NetworkMgr.Instance.Social.GetInviteTaskList end
  return NetworkMgr.Instance.Social.GetInviteTaskList, NetworkMgr.Instance.Social
end

function GameRequest:TakeInviteReward(inviteeUid, taskId)
  Logger.Proto("GameRequest.TakeInviteReward")
  do return NetworkMgr.Instance.Social.TakeInviteReward, NetworkMgr.Instance.Social, inviteeUid end
  return NetworkMgr.Instance.Social.TakeInviteReward, NetworkMgr.Instance.Social, inviteeUid, taskId
end

function GameRequest:StartPasswordGame(uid, pvpType)
  Logger.Proto("GameRequest.StartPasswordGame: uid = %s, pvpType = %s", uid, pvpType)
  do return NetworkMgr.Instance.Pvp.StartPasswordGame, NetworkMgr.Instance.Pvp, uid end
  return NetworkMgr.Instance.Pvp.StartPasswordGame, NetworkMgr.Instance.Pvp, uid, pvpType
end

function GameRequest:CancelPasswordMatching()
  Logger.Proto("GameRequest:CancelPasswordMatching")
  do return NetworkMgr.Instance.Pvp.CancelPasswordMatching end
  return NetworkMgr.Instance.Pvp.CancelPasswordMatching, NetworkMgr.Instance.Pvp
end

function GameRequest:JoinPasswordGame(uid, password)
  Logger.Proto("GameRequest.JoinPasswordGame: uid = %s, password = %s", uid, password)
  do return NetworkMgr.Instance.Pvp.JoinPasswordGame, NetworkMgr.Instance.Pvp, uid end
  return NetworkMgr.Instance.Pvp.JoinPasswordGame, NetworkMgr.Instance.Pvp, uid, password
end

function GameRequest:RejectPasswordGame(uid)
  Logger.Proto("GameRequest.RejectPasswordGame: uid = %s", uid)
  do return NetworkMgr.Instance.Pvp.RejectPasswordGame, NetworkMgr.Instance.Pvp end
  return NetworkMgr.Instance.Pvp.RejectPasswordGame, NetworkMgr.Instance.Pvp, uid
end

function GameRequest:ReadyPasswordGame(uid)
  Logger.Proto("GameRequest.ReadyPasswordGame: uid = %s", uid)
  do return NetworkMgr.Instance.Pvp.ReadyPasswordGame, NetworkMgr.Instance.Pvp, uid end
  return NetworkMgr.Instance.Pvp.ReadyPasswordGame, NetworkMgr.Instance.Pvp, uid, true
end

function GameRequest:OnOpenPvpTeam()
  Logger.Proto("OnOpenPvpTeam")
  do return NetworkMgr.Instance.PvpTeam.OnOpenPvpTeam end
  return NetworkMgr.Instance.PvpTeam.OnOpenPvpTeam, NetworkMgr.Instance.PvpTeam
end

function GameRequest:OnUpdatePvpTeam(teamIdx, teamData)
  Logger.Proto("OnUpdatePvpTeam: teamIdx=%s, teamData=%s", teamIdx, table.tostring(teamData))
  do return NetworkMgr.Instance.PvpTeam.OnUpdatePvpTeam, NetworkMgr.Instance.PvpTeam, teamIdx end
  return NetworkMgr.Instance.PvpTeam.OnUpdatePvpTeam, NetworkMgr.Instance.PvpTeam, teamIdx, teamData, table.tostring(teamData)
end

function GameRequest:OnRenamePvpTeam(teamIdx, newName)
  Logger.Proto("OnRenamePvpTeam: teamIdx=%s, newName=%s", teamIdx, newName)
  do return NetworkMgr.Instance.PvpTeam.OnRenamePvpTeam, NetworkMgr.Instance.PvpTeam, teamIdx end
  return NetworkMgr.Instance.PvpTeam.OnRenamePvpTeam, NetworkMgr.Instance.PvpTeam, teamIdx, newName
end

function GameRequest:OnChooseTeam(teamIdx)
  Logger.Proto("OnChooseTeam: teamIdx=%s", teamIdx)
  do return NetworkMgr.Instance.PvpTeam.OnChooseTeam, NetworkMgr.Instance.PvpTeam end
  return NetworkMgr.Instance.PvpTeam.OnChooseTeam, NetworkMgr.Instance.PvpTeam, teamIdx
end

function GameRequest:OnGetReward(level, privType, tid, chooseTid)
  Logger.Proto("OnGetReward: level=%s, privType=%s, tid=%s, chooseTid=%s", level, privType, tid, chooseTid)
  do return NetworkMgr.Instance.BattlePass.OnGetReward, NetworkMgr.Instance.BattlePass, level, privType, tid end
  return NetworkMgr.Instance.BattlePass.OnGetReward, NetworkMgr.Instance.BattlePass, level, privType, tid, chooseTid
end

function GameRequest:OnGetRewardAll(chooseList)
  Logger.Proto("OnGetRewardAll: chooseList=%s", table.tostring(chooseList))
  do return NetworkMgr.Instance.BattlePass.OnGetRewardAll, NetworkMgr.Instance.BattlePass end
  return NetworkMgr.Instance.BattlePass.OnGetRewardAll, NetworkMgr.Instance.BattlePass, chooseList, table.tostring(chooseList)
end

function GameRequest:OnBuyBpLevel(level)
  Logger.Proto("OnBuyBpLevel: level=%s", level)
  do return NetworkMgr.Instance.BattlePass.OnBuyLevel, NetworkMgr.Instance.BattlePass end
  return NetworkMgr.Instance.BattlePass.OnBuyLevel, NetworkMgr.Instance.BattlePass, level
end

function GameRequest:UnlockAwakerTalent(talentCfgId, awakerCfgId)
  Logger.Proto("UnlockAwakerTalent: talentCfgId = %s, awakerCfgId = %s", talentCfgId, awakerCfgId)
  do return NetworkMgr.Instance.Awaker.UnlockAwakerTalent, NetworkMgr.Instance.Awaker, talentCfgId end
  return NetworkMgr.Instance.Awaker.UnlockAwakerTalent, NetworkMgr.Instance.Awaker, talentCfgId, awakerCfgId
end

function GameRequest:OneKeyGainTaskPrize()
  Logger.Proto("OneKeyGainTaskPrize")
  do return NetworkMgr.Instance.BattlePass.OneKeyGainTaskPrize end
  return NetworkMgr.Instance.BattlePass.OneKeyGainTaskPrize, NetworkMgr.Instance.BattlePass
end

function GameRequest:OnBuyBp(key)
  Logger.Proto("OnBuyBp: key=%s", key)
  do return NetworkMgr.Instance.BattlePass.OnBuyBp, NetworkMgr.Instance.BattlePass end
  return NetworkMgr.Instance.BattlePass.OnBuyBp, NetworkMgr.Instance.BattlePass, key
end

function GameRequest:OnGetExtraAward()
  Logger.Proto("OnGetExtraAward")
  do return NetworkMgr.Instance.BattlePass.OnGetExtraAward end
  return NetworkMgr.Instance.BattlePass.OnGetExtraAward, NetworkMgr.Instance.BattlePass
end

function GameRequest:OnOpenGuideNote()
  Logger.Proto("GuideNote.OnOpenGuideNote")
  do return NetworkMgr.Instance.GuideNote.OnOpenGuideNote end
  return NetworkMgr.Instance.GuideNote.OnOpenGuideNote, NetworkMgr.Instance.GuideNote
end

function GameRequest:OnGetGuideNoteReward(levelType, level)
  Logger.Proto("GuideNote.OnGetReward: levelType=%s, level=%s", levelType, level)
  do return NetworkMgr.Instance.GuideNote.OnGetReward, NetworkMgr.Instance.GuideNote, levelType end
  return NetworkMgr.Instance.GuideNote.OnGetReward, NetworkMgr.Instance.GuideNote, levelType, level
end

function GameRequest:GetActivityData()
  Logger.Proto("GetActivityData")
  do return NetworkMgr.Instance.ActivityMgr.GetClientProfile end
  return NetworkMgr.Instance.ActivityMgr.GetClientProfile, NetworkMgr.Instance.ActivityMgr
end

function GameRequest:GainActivityPrize(activityTid, prizeTid, pickItems)
  Logger.Proto("GainActivityPrize: ", activityTid, prizeTid, table.tostring(pickItems))
  do return NetworkMgr.Instance.ActivityMgr.OnGainPrize, NetworkMgr.Instance.ActivityMgr, activityTid, prizeTid end
  return NetworkMgr.Instance.ActivityMgr.OnGainPrize, NetworkMgr.Instance.ActivityMgr, activityTid, prizeTid, pickItems, table.tostring(pickItems)
end

function GameRequest:OnMultiGainPrize(activityTid, taskTidList)
  Logger.Proto("OnMultiGainPrize: ", activityTid, table.tostring(taskTidList))
  do return NetworkMgr.Instance.ActivityMgr.OnMultiGainPrize, NetworkMgr.Instance.ActivityMgr, activityTid end
  return NetworkMgr.Instance.ActivityMgr.OnMultiGainPrize, NetworkMgr.Instance.ActivityMgr, activityTid, taskTidList, table.tostring(taskTidList)
end

function GameRequest:OnTrialStage(activityTid, stageID, tAwakerTids)
  Logger.Info("GameRequest.OnTrialStage", activityTid, stageID, table.tostring(tAwakerTids))
  do return NetworkMgr.Instance.ActivityMgr.OnTrialStage, NetworkMgr.Instance.ActivityMgr, activityTid, stageID end
  return NetworkMgr.Instance.ActivityMgr.OnTrialStage, NetworkMgr.Instance.ActivityMgr, activityTid, stageID, tAwakerTids, table.tostring(tAwakerTids)
end

function GameRequest:OnGainAllPrize(activityTid)
  Logger.Proto("GainActivityPrize: ", activityTid)
  do return NetworkMgr.Instance.ActivityMgr.OnGainAllPrize, NetworkMgr.Instance.ActivityMgr end
  return NetworkMgr.Instance.ActivityMgr.OnGainAllPrize, NetworkMgr.Instance.ActivityMgr, activityTid
end

function GameRequest:ActivityClientJoinRequest(activityTid)
  Logger.Proto("ActivityClientJoinRequest: activityTid=%s", activityTid)
  do return NetworkMgr.Instance.ActivityMgr.ActivityClientJoinRequest, NetworkMgr.Instance.ActivityMgr end
  return NetworkMgr.Instance.ActivityMgr.ActivityClientJoinRequest, NetworkMgr.Instance.ActivityMgr, activityTid
end

function GameRequest:GetActivityWorldBossKillCount(activityTid)
  Logger.Proto("GetActivityWorldBossKillCount: activityTid=%s", activityTid)
  do return NetworkMgr.Instance.ActivityMgr.GetActivityWorldBossKillCount, NetworkMgr.Instance.ActivityMgr end
  return NetworkMgr.Instance.ActivityMgr.GetActivityWorldBossKillCount, NetworkMgr.Instance.ActivityMgr, activityTid
end

function GameRequest:OnOpenRank(type, extraId)
  extraId = extraId or 0
  Logger.Info("GameRequest.OnOpenRank", type, extraId)
  do return NetworkMgr.Instance.Rank.OnOpen, NetworkMgr.Instance.Rank, type end
  return NetworkMgr.Instance.Rank.OnOpen, NetworkMgr.Instance.Rank, type, extraId
end

function GameRequest:OnQueryRank(type, starts, ends, extraId)
  extraId = extraId or 0
  Logger.Info("GameRequest.OnQueryRank", type, starts, ends, extraId)
  do return NetworkMgr.Instance.Rank.QueryRank, NetworkMgr.Instance.Rank, type, starts, ends end
  return NetworkMgr.Instance.Rank.QueryRank, NetworkMgr.Instance.Rank, type, starts, ends, extraId
end

function GameRequest:QueryRankFilter(type, starts, ends, extraId, awakerMap)
  extraId = extraId or 0
  Logger.Info("GameRequest.QueryRankFilter", type, starts, ends, extraId, table.tostring(awakerMap))
  do return NetworkMgr.Instance.Rank.QueryRankFilter, NetworkMgr.Instance.Rank, type, starts, ends, extraId end
  return NetworkMgr.Instance.Rank.QueryRankFilter, NetworkMgr.Instance.Rank, type, starts, ends, extraId, awakerMap, table.tostring(awakerMap)
end

function GameRequest:QueryRankInfo(reqParamList)
  Logger.Info("GameRequest.QueryRankInfo", table.tostring(reqParamList))
  do return NetworkMgr.Instance.Rank.QueryRankInfo, NetworkMgr.Instance.Rank end
  return NetworkMgr.Instance.Rank.QueryRankInfo, NetworkMgr.Instance.Rank, reqParamList, table.tostring(reqParamList)
end

function GameRequest:OpenRankPrizeData(type)
  Logger.Info("GameRequest.OpenRankPrizeData", type)
  do return NetworkMgr.Instance.Rank.OpenRankPrizeData, NetworkMgr.Instance.Rank end
  return NetworkMgr.Instance.Rank.OpenRankPrizeData, NetworkMgr.Instance.Rank, type
end

function GameRequest:OnSocialQueryList(listType, s, e, noCache, queryCliParam)
  Logger.Proto("GameRequest.OnSocialQueryList: %s, %s, %s, %s, %s", listType, s, e, noCache, table.tostring(queryCliParam))
  queryCliParam = queryCliParam or {}
  do return NetworkMgr.Instance.Social.QueryList, NetworkMgr.Instance.Social, listType, s, e, noCache end
  return NetworkMgr.Instance.Social.QueryList, NetworkMgr.Instance.Social, listType, s, e, noCache, queryCliParam, table.tostring(queryCliParam)
end

function GameRequest:OnSocialVisit(targetUid)
  Logger.Proto("GameRequest.OnVisit: %s", targetUid)
  do return NetworkMgr.Instance.Social.Visit, NetworkMgr.Instance.Social end
  return NetworkMgr.Instance.Social.Visit, NetworkMgr.Instance.Social, targetUid
end

function GameRequest:OnGetSocialBasicInfo()
  Logger.Proto("GameRequest.OnGetSocialBasicInfo")
  do return NetworkMgr.Instance.Social.OnOpen end
  return NetworkMgr.Instance.Social.OnOpen, NetworkMgr.Instance.Social
end

function GameRequest:OnSocialGood(targetUid, num, reason)
  Logger.Proto("GameRequest.OnSocialGood: %s, %s, %s", targetUid, num, reason)
  do return NetworkMgr.Instance.Social.Good, NetworkMgr.Instance.Social, targetUid, num end
  return NetworkMgr.Instance.Social.Good, NetworkMgr.Instance.Social, targetUid, num, reason
end

function GameRequest:OnSocialAttention(targetUid)
  Logger.Proto("GameRequest.OnSocialAttention: %s", targetUid)
  do return NetworkMgr.Instance.Social.Attention, NetworkMgr.Instance.Social end
  return NetworkMgr.Instance.Social.Attention, NetworkMgr.Instance.Social, targetUid
end

function GameRequest:OnSocialBatchAttention(targetUidList)
  Logger.Proto("GameRequest.OnSocialBatchAttention: %s", table.tostring(targetUidList))
  do return NetworkMgr.Instance.Social.BatchAttention, NetworkMgr.Instance.Social end
  return NetworkMgr.Instance.Social.BatchAttention, NetworkMgr.Instance.Social, targetUidList, table.tostring(targetUidList)
end

function GameRequest:OnSocialCancelAttention(targetUidList)
  Logger.Proto("GameRequest.OnSocialCancelAttention: %s", table.tostring(targetUidList))
  do return NetworkMgr.Instance.Social.CancelAttention, NetworkMgr.Instance.Social end
  return NetworkMgr.Instance.Social.CancelAttention, NetworkMgr.Instance.Social, targetUidList, table.tostring(targetUidList)
end

function GameRequest:OnSocialBan(targetUid)
  Logger.Proto("GameRequest.OnSocialBan: %s", targetUid)
  do return NetworkMgr.Instance.Social.Ban, NetworkMgr.Instance.Social end
  return NetworkMgr.Instance.Social.Ban, NetworkMgr.Instance.Social, targetUid
end

function GameRequest:OnCancelSocialBan(targetUid)
  Logger.Proto("GameRequest.OnCancelSocialBan: %s", targetUid)
  do return NetworkMgr.Instance.Social.CancelBan, NetworkMgr.Instance.Social end
  return NetworkMgr.Instance.Social.CancelBan, NetworkMgr.Instance.Social, targetUid
end

function GameRequest:OnSocialNote(targetUid, nickName)
  Logger.Proto("GameRequest.OnSocialNote: %s, %s", targetUid, nickName)
  do return NetworkMgr.Instance.Social.Note, NetworkMgr.Instance.Social, targetUid end
  return NetworkMgr.Instance.Social.Note, NetworkMgr.Instance.Social, targetUid, nickName
end

function GameRequest:OnQueryStranger(num, refresh)
  Logger.Proto("GameRequest.OnQueryStranger: %s, %s", num, refresh)
  do return NetworkMgr.Instance.Social.QueryStranger, NetworkMgr.Instance.Social, num end
  return NetworkMgr.Instance.Social.QueryStranger, NetworkMgr.Instance.Social, num, refresh
end

function GameRequest:OnQueryAwaker(uid, tid)
  Logger.Proto("GameRequest.QueryAwaker: %s, %s", uid, tid)
  do return NetworkMgr.Instance.Facade.QueryAwaker, NetworkMgr.Instance.Facade, uid end
  return NetworkMgr.Instance.Facade.QueryAwaker, NetworkMgr.Instance.Facade, uid, tid
end

function GameRequest:QueryFacadeDetail(uid)
  Logger.Proto("GameRequest.QueryFacadeDetail: %s", uid)
  do return NetworkMgr.Instance.Facade.QueryFacadeDetail, NetworkMgr.Instance.Facade end
  return NetworkMgr.Instance.Facade.QueryFacadeDetail, NetworkMgr.Instance.Facade, uid
end

function GameRequest:OnQueryFacadeFields(uid, params)
  Logger.Proto("GameRequest.QueryFacadeFields: %s, %s", uid, table.tostring(params))
  do return NetworkMgr.Instance.Facade.QueryFacadeFields, NetworkMgr.Instance.Facade, uid end
  return NetworkMgr.Instance.Facade.QueryFacadeFields, NetworkMgr.Instance.Facade, uid, params, table.tostring(params)
end

function GameRequest:OnCancelNote(targetUid)
  Logger.Proto("GameRequest.CancelNote: %s", targetUid)
  do return NetworkMgr.Instance.Social.CancelNote, NetworkMgr.Instance.Social end
  return NetworkMgr.Instance.Social.CancelNote, NetworkMgr.Instance.Social, targetUid
end

function GameRequest:QueryAssistAwaker(refresh, startIdx, endIdx, params)
  Logger.Proto("GameRequest.QueryAssistAwaker: %s, %s, %s, %s", refresh, startIdx, endIdx, table.tostring(params))
  do return NetworkMgr.Instance.Social.QueryAssistAwaker, NetworkMgr.Instance.Social, refresh, startIdx, endIdx end
  return NetworkMgr.Instance.Social.QueryAssistAwaker, NetworkMgr.Instance.Social, refresh, startIdx, endIdx, params, table.tostring(params)
end

function GameRequest:OnAssistFilter(stateList)
  Logger.Proto("GameRequest.OnAssistFilter: %s", table.tostring(stateList))
  do return NetworkMgr.Instance.Awaker.OnAssistFilter, NetworkMgr.Instance.Awaker end
  return NetworkMgr.Instance.Awaker.OnAssistFilter, NetworkMgr.Instance.Awaker, stateList, table.tostring(stateList)
end

function GameRequest:OnClearNewFanNum()
  Logger.Proto("GameRequest.OnClearNewFanNum")
  do return NetworkMgr.Instance.Social.ClearNewFanNum end
  return NetworkMgr.Instance.Social.ClearNewFanNum, NetworkMgr.Instance.Social
end

function GameRequest:SetStarAssist(targetUid, set)
  Logger.Proto("GameRequest.SetStarAssist: %s", targetUid, set)
  do return NetworkMgr.Instance.Social.SetStarAssist, NetworkMgr.Instance.Social, targetUid end
  return NetworkMgr.Instance.Social.SetStarAssist, NetworkMgr.Instance.Social, targetUid, set
end

function GameRequest:OnSetAge(year, month)
  Logger.Proto("Player.OnSetAge: year = %s, month = %s", year, month)
  do return NetworkMgr.Instance.Role.SetAge, NetworkMgr.Instance.Role, year end
  return NetworkMgr.Instance.Role.SetAge, NetworkMgr.Instance.Role, year, month
end

function GameRequest:OnSetBirthday(month, day)
  Logger.Proto("GameRequest.SetBirthday: %s, %s", month, day)
  do return NetworkMgr.Instance.Role.SetBirthday, NetworkMgr.Instance.Role, month end
  return NetworkMgr.Instance.Role.SetBirthday, NetworkMgr.Instance.Role, month, day
end

function GameRequest:OnSetNote(note)
  Logger.Proto("GameRequest.SetNote: %s", note)
  do return NetworkMgr.Instance.Role.SetNote, NetworkMgr.Instance.Role end
  return NetworkMgr.Instance.Role.SetNote, NetworkMgr.Instance.Role, note
end

function GameRequest:OnSetAvatarFrame(frameItemTid)
  Logger.Proto("GameRequest.OnSetAvatarFrame: %s", frameItemTid)
  do return NetworkMgr.Instance.Role.SetAvatarFrame, NetworkMgr.Instance.Role end
  return NetworkMgr.Instance.Role.SetAvatarFrame, NetworkMgr.Instance.Role, frameItemTid
end

function GameRequest:OnSetAvatar(avatar)
  Logger.Proto("GameRequest.SetIcon: %s", avatar)
  do return NetworkMgr.Instance.Role.SetIcon, NetworkMgr.Instance.Role end
  return NetworkMgr.Instance.Role.SetIcon, NetworkMgr.Instance.Role, avatar
end

function GameRequest:OnChangeAssistAwaker(tbl)
  Logger.Proto("GameRequest.ChangeAssistAwaker: %s", table.tostring(tbl))
  do return NetworkMgr.Instance.Social.ChangeAssistAwaker, NetworkMgr.Instance.Social end
  return NetworkMgr.Instance.Social.ChangeAssistAwaker, NetworkMgr.Instance.Social, tbl, table.tostring(tbl)
end

function GameRequest:OnGainAssistReward()
  Logger.Proto("GameRequest.GainAssistReward")
  do return NetworkMgr.Instance.Social.GainAssistReward end
  return NetworkMgr.Instance.Social.GainAssistReward, NetworkMgr.Instance.Social
end

function GameRequest:OnClearNewGood()
  Logger.Proto("GameRequest.ClearNewGood")
  do return NetworkMgr.Instance.Social.ClearNewGood end
  return NetworkMgr.Instance.Social.ClearNewGood, NetworkMgr.Instance.Social
end

function GameRequest:SetEmoji(list)
  Logger.Proto("GameRequest.SetEmoji")
  do return NetworkMgr.Instance.Role.SetEmoji, NetworkMgr.Instance.Role end
  return NetworkMgr.Instance.Role.SetEmoji, NetworkMgr.Instance.Role, list
end

function GameRequest:SendEmoji(iconId, msgId, msgData)
  Logger.Proto("GameRequest.SendEmoji")
  do return NetworkMgr.Instance.Role.SendEmoji, NetworkMgr.Instance.Role, iconId, msgId end
  return NetworkMgr.Instance.Role.SendEmoji, NetworkMgr.Instance.Role, iconId, msgId, msgData
end

function GameRequest:OnArtCollectionOpen()
  Logger.Proto("GameRequest.OnArtCollectionOpen")
  do return NetworkMgr.Instance.Collection.OnOpen end
  return NetworkMgr.Instance.Collection.OnOpen, NetworkMgr.Instance.Collection
end

function GameRequest:OnCollectionItemUnlock(collectId)
  Logger.Proto("GameRequest.OnCollectionItemUnlock", collectId)
  do return NetworkMgr.Instance.Collection.OnItemUnlock, NetworkMgr.Instance.Collection end
  return NetworkMgr.Instance.Collection.OnItemUnlock, NetworkMgr.Instance.Collection, collectId
end

function GameRequest:CollecAvgTrigger(avgId)
  Logger.Proto("GameRequest.CollecAvgTrigger")
  do return NetworkMgr.Instance.Collection.OnAvgTrigger, NetworkMgr.Instance.Collection end
  return NetworkMgr.Instance.Collection.OnAvgTrigger, NetworkMgr.Instance.Collection, avgId
end

function GameRequest:OnOpenAbyss()
  Logger.Proto("GameRequest.OnOpen")
  do return NetworkMgr.Instance.AbyssChallenge.OnOpen end
  return NetworkMgr.Instance.AbyssChallenge.OnOpen, NetworkMgr.Instance.AbyssChallenge
end

function GameRequest:OnOpenAbyssTeamDetail(stageGroupTid, isExtra)
  Logger.Proto("GameRequest.OnOpenTeamDetail: %s %s", stageGroupTid, isExtra)
  do return NetworkMgr.Instance.AbyssChallenge.OnOpenTeamDetail, NetworkMgr.Instance.AbyssChallenge, stageGroupTid end
  return NetworkMgr.Instance.AbyssChallenge.OnOpenTeamDetail, NetworkMgr.Instance.AbyssChallenge, stageGroupTid, isExtra or false
end

function GameRequest:OnResetAbyssStageGroup(stageGroupTid, resetType)
  Logger.Proto("GameRequest.ResetStageGroup: %s %s", stageGroupTid, resetType)
  do return NetworkMgr.Instance.AbyssChallenge.ResetStageGroup, NetworkMgr.Instance.AbyssChallenge, stageGroupTid end
  return NetworkMgr.Instance.AbyssChallenge.ResetStageGroup, NetworkMgr.Instance.AbyssChallenge, stageGroupTid, resetType
end

function GameRequest:OnGainAbyssPrize(index)
  Logger.Proto("GameRequest.OnGainAbyssPrize: %s", index)
  do return NetworkMgr.Instance.AbyssChallenge.OnGainPrize, NetworkMgr.Instance.AbyssChallenge end
  return NetworkMgr.Instance.AbyssChallenge.OnGainPrize, NetworkMgr.Instance.AbyssChallenge, index
end

function GameRequest:OnGainAbyssPrizeAll(indexList)
  Logger.Proto("AbyssChallenge.OnGainPrizeAll: %s", table.tostring(indexList))
  do return NetworkMgr.Instance.AbyssChallenge.OnGainPrizeAll, NetworkMgr.Instance.AbyssChallenge end
  return NetworkMgr.Instance.AbyssChallenge.OnGainPrizeAll, NetworkMgr.Instance.AbyssChallenge, indexList, table.tostring(indexList)
end

function GameRequest:OnOpenDonationBox()
  Logger.Proto("GameRequest.OnOpenDonationBox")
  do return NetworkMgr.Instance.Produce.OnOpen end
  return NetworkMgr.Instance.Produce.OnOpen, NetworkMgr.Instance.Produce
end

function GameRequest:OnGainBoxReward(produceTid)
  Logger.Proto("GameRequest.OnGainBoxReward: %s", produceTid)
  do return NetworkMgr.Instance.Produce.OnGainBoxReward, NetworkMgr.Instance.Produce end
  return NetworkMgr.Instance.Produce.OnGainBoxReward, NetworkMgr.Instance.Produce, produceTid
end

function GameRequest:OnLottery(lotteryTid, times)
  Logger.Proto("GameRequest.OnLottery: %s, %s", lotteryTid, times)
  do return NetworkMgr.Instance.Lottery.OnLottery, NetworkMgr.Instance.Lottery, lotteryTid end
  return NetworkMgr.Instance.Lottery.OnLottery, NetworkMgr.Instance.Lottery, lotteryTid, times
end

function GameRequest:OnOpenLottery()
  Logger.Proto("GameRequest.OnOpenLottery")
  do return NetworkMgr.Instance.Lottery.OnOpen end
  return NetworkMgr.Instance.Lottery.OnOpen, NetworkMgr.Instance.Lottery
end

function GameRequest:OnResetLottery(lotteryTid)
  Logger.Proto("GameRequest.OnOpenLottery: %s", lotteryTid)
  do return NetworkMgr.Instance.Lottery.ResetLottery, NetworkMgr.Instance.Lottery end
  return NetworkMgr.Instance.Lottery.ResetLottery, NetworkMgr.Instance.Lottery, lotteryTid
end

function GameRequest:OnGetAllLotteryMultipleDrawTimes(lotteryTid)
  Logger.Proto("GameRequest.OnGetAllLotteryMultipleDrawTimes: %s", lotteryTid)
  do return NetworkMgr.Instance.Lottery.OnGetAllLotteryMultipleDrawTimes, NetworkMgr.Instance.Lottery end
  return NetworkMgr.Instance.Lottery.OnGetAllLotteryMultipleDrawTimes, NetworkMgr.Instance.Lottery, lotteryTid
end

function GameRequest:OnAllLottery(lotteryTid)
  Logger.Proto("GameRequest.OnAllLottery: %s", lotteryTid)
  do return NetworkMgr.Instance.Lottery.OnAllLottery, NetworkMgr.Instance.Lottery end
  return NetworkMgr.Instance.Lottery.OnAllLottery, NetworkMgr.Instance.Lottery, lotteryTid
end

function GameRequest:OnCalWeaponAttr(tid, level)
  Logger.Proto("GameRequest.CalWeaponAttr: %s, %s", tid, level)
  do return NetworkMgr.Instance.Weapon.CalWeaponAttr, NetworkMgr.Instance.Weapon, tid end
  return NetworkMgr.Instance.Weapon.CalWeaponAttr, NetworkMgr.Instance.Weapon, tid, level
end

function GameRequest:OnOpenClientData()
  Logger.Proto("GameRequest.OnOpenClientData")
  do return NetworkMgr.Instance.Role.OpenClientData end
  return NetworkMgr.Instance.Role.OpenClientData, NetworkMgr.Instance.Role
end

function GameRequest:OnSaveClientData(mainKey, kvTbl)
  Logger.Proto("GameRequest.OnSaveClientData: %s, %s", mainKey, table.tostring(kvTbl))
  do return NetworkMgr.Instance.Role.SaveClientData, NetworkMgr.Instance.Role, mainKey end
  return NetworkMgr.Instance.Role.SaveClientData, NetworkMgr.Instance.Role, mainKey, kvTbl, table.tostring(kvTbl)
end

function GameRequest:OnDelClientData(mainKey, in_keys, del_main)
  do return NetworkMgr.Instance.Role.DelClientData, NetworkMgr.Instance.Role, mainKey, in_keys end
  return NetworkMgr.Instance.Role.DelClientData, NetworkMgr.Instance.Role, mainKey, in_keys, del_main
end

function GameRequest:CreateOrder(data)
  Logger.Proto("GameRequest.CreateOrder %s", table.tostring(data))
  do return NetworkMgr.Instance.Steam.CreateOrder, NetworkMgr.Instance.Steam end
  return NetworkMgr.Instance.Steam.CreateOrder, NetworkMgr.Instance.Steam, data, table.tostring(data)
end

function GameRequest:OrderReward(data)
  Logger.Proto("GameRequest.OrderReward %s", table.tostring(data))
  do return NetworkMgr.Instance.Steam.OrderReward, NetworkMgr.Instance.Steam end
  return NetworkMgr.Instance.Steam.OrderReward, NetworkMgr.Instance.Steam, data, table.tostring(data)
end

function GameRequest:GetBoardAwakerLikeGained()
  Logger.Proto("GameRequest.GetBoardAwakerLikeGained")
  local data, ret = NetworkMgr.Instance.Role:GetBoardAwakerLikeGained()
  Logger.Proto("GameRequest.GetBoardAwakerLikeGained return : ", table.tostring(data), table.tostring(ret))
  return data, ret
end

function GameRequest:SetMainInterfaceCG(tid)
  Logger.Proto("GameRequest.SetMainInterfaceCG ", tid)
  do return NetworkMgr.Instance.Role.SetMainInterfaceCG end
  return NetworkMgr.Instance.Role.SetMainInterfaceCG, NetworkMgr.Instance.Role, tid
end

return GameRequest
