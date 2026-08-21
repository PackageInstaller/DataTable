-- chunkname: @IQIGame\\Net\\net.lua

msgIdMethodName = "{\"100102\":\"net_centerChat.sendChat\",\"100103\":\"net_centerChat.switchRoom\",\"100104\":\"net_centerChat.sendChatResult\",\"100105\":\"net_centerChat.switchRoomResult\",\"100106\":\"net_centerChat.notifyChat\",\"100107\":\"net_centerChat.notifyChatRoom\",\"100202\":\"net_centerRank.getRank\",\"100203\":\"net_centerRank.getRankUserData\",\"100204\":\"net_centerRank.getRankGoalie\",\"100205\":\"net_centerRank.getRankResult\",\"100206\":\"net_centerRank.getRankUserDataResult\",\"100207\":\"net_centerRank.getRankGoalieResult\",\"100302\":\"net_centerFriend.removeFriends\",\"100303\":\"net_centerFriend.applyFriends\",\"100304\":\"net_centerFriend.dealWithApply\",\"100305\":\"net_centerFriend.addBlacklist\",\"100306\":\"net_centerFriend.removeBlacklist\",\"100307\":\"net_centerFriend.searchPlayer\",\"100308\":\"net_centerFriend.setRemark\",\"100309\":\"net_centerFriend.recommend\",\"100310\":\"net_centerFriend.recommendHelpHeros\",\"100311\":\"net_centerFriend.removeFriendsResult\",\"100312\":\"net_centerFriend.applyFriendsResult\",\"100313\":\"net_centerFriend.dealWithApplyResult\",\"100314\":\"net_centerFriend.addBlacklistResult\",\"100315\":\"net_centerFriend.removeBlacklistResult\",\"100316\":\"net_centerFriend.searchPlayerResult\",\"100317\":\"net_centerFriend.setRemarkResult\",\"100318\":\"net_centerFriend.recommendResult\",\"100319\":\"net_centerFriend.recommendHelpHerosResult\",\"100320\":\"net_centerFriend.notifyAddFriend\",\"100321\":\"net_centerFriend.notifyDeleteFriend\",\"100322\":\"net_centerFriend.notifyUpdateFriend\",\"10102\":\"net_activityRecharge.getRewards\",\"10103\":\"net_activityRecharge.getRewardsResult\",\"102\":\"net_gameToCenter.registerSimplePlayer\",\"103\":\"net_gameToCenter.changePlayerData\",\"104\":\"net_gameToCenter.loadPlayer\",\"105\":\"net_gameToCenter.reloadPlayer\",\"106\":\"net_gameToCenter.offline\",\"107\":\"net_gameToCenter.heartbeat\",\"108\":\"net_gameToCenter.uploadSimplePlayer\",\"109\":\"net_gameToCenter.registerSimplePlayerResult\",\"110\":\"net_gameToCenter.changePlayerDataResult\",\"111\":\"net_gameToCenter.loadPlayerResult\",\"112\":\"net_gameToCenter.reloadPlayerResult\",\"113\":\"net_gameToCenter.heartbeatResult\",\"114\":\"net_gameToCenter.notifyCentralStart\",\"115\":\"net_gameToCenter.notifyCentralStop\",\"116\":\"net_gameToCenter.notifyExecCmd\",\"117\":\"net_gameToCenter.notifyTopicChat\",\"118\":\"net_gameToCenter.notifyGmMail\",\"119\":\"net_gameToCenter.uploadRankScore\",\"120\":\"net_gameToCenter.notifyRankRewards\",\"121\":\"net_gameToCenter.notifyActivitys\",\"202\":\"net_gameToGame.openHomeBox\",\"203\":\"net_gameToGame.helpHome\",\"3802\":\"net_user.validateUUID\",\"3803\":\"net_user.chooseRole\",\"3804\":\"net_user.createRole\",\"3805\":\"net_user.ping\",\"3806\":\"net_user.logout\",\"3807\":\"net_user.receiveRebate\",\"3808\":\"net_user.validateUUIDResult\",\"3809\":\"net_user.chooseRoleResult\",\"3810\":\"net_user.createRoleResult\",\"3811\":\"net_user.pang\",\"3812\":\"net_user.logoutResult\",\"3813\":\"net_user.notifyServerStatus\",\"3814\":\"net_user.notifyError\",\"3815\":\"net_user.notifyMessage\",\"3816\":\"net_user.notifyOffline\",\"3817\":\"net_user.receiveRebateResult\",\"3902\":\"net_player.loadPlayer\",\"3903\":\"net_player.reloadPlayer\",\"3904\":\"net_player.disbindRole\",\"3905\":\"net_player.changeData\",\"3906\":\"net_player.getPlayerInfo\",\"3907\":\"net_player.sendGiftCode\",\"3908\":\"net_player.changeShowHero\",\"3909\":\"net_player.setHelpHero\",\"3910\":\"net_player.getHeroInfo\",\"3911\":\"net_player.triggerGuide\",\"3912\":\"net_player.saveLittleInfomation\",\"3913\":\"net_player.achieveShow\",\"3914\":\"net_player.activeTalent\",\"3915\":\"net_player.resetTalent\",\"3916\":\"net_player.triggerEvent\",\"3917\":\"net_player.setKanBan\",\"3918\":\"net_player.setKanBanPool\",\"3919\":\"net_player.setRandomKanBan\",\"3920\":\"net_player.loadPlayerResult\",\"3921\":\"net_player.reloadPlayerResult\",\"3922\":\"net_player.disbindRoleResult\",\"3923\":\"net_player.changeDataResult\",\"3924\":\"net_player.getPlayerInfoResult\",\"3925\":\"net_player.sendGiftCodeResult\",\"3926\":\"net_player.notifyUnlockFunc\",\"3927\":\"net_player.changeShowHeroResult\",\"3928\":\"net_player.setHelpHeroResult\",\"3929\":\"net_player.getHeroInfoResult\",\"3930\":\"net_player.notifyPlayerDataChange\",\"3931\":\"net_player.notifyPlayerLevelChange\",\"3932\":\"net_player.triggerGuideResult\",\"3933\":\"net_player.saveLittleInfomationResult\",\"3934\":\"net_player.achieveShowResult\",\"3935\":\"net_player.notifyQuestionnaires\",\"3936\":\"net_player.activeTalentResult\",\"3937\":\"net_player.resetTalentResult\",\"3938\":\"net_player.triggerEventResult\",\"3939\":\"net_player.setKanBanResult\",\"3940\":\"net_player.setKanBanPoolResult\",\"3941\":\"net_player.setRandomKanBanResult\",\"3942\":\"net_player.notifyServerParamChange\",\"3943\":\"net_player.notifyLimitedTimePkg\",\"3944\":\"net_player.notifyCommodityBuyRecords\",\"3945\":\"net_player.notifyChangeKanBanPOD\",\"3946\":\"net_player.notifyGlobalBuffPOD\",\"3947\":\"net_player.saveData\",\"3948\":\"net_player.saveDataResult\",\"3949\":\"net_player.notifyMonthCard\",\"4002\":\"net_item.sellItem\",\"4003\":\"net_item.useItem\",\"4004\":\"net_item.compositeItem\",\"4005\":\"net_item.destroyItem\",\"4006\":\"net_item.readItemFlag\",\"4007\":\"net_item.disItem\",\"4008\":\"net_item.sellItemResult\",\"4009\":\"net_item.useItemResult\",\"4010\":\"net_item.compositeItemResult\",\"4011\":\"net_item.destroyItemResult\",\"4012\":\"net_item.readItemFlagResult\",\"4013\":\"net_item.notifyAddItems\",\"4014\":\"net_item.notifyRetrunItems\",\"4015\":\"net_item.notifyConverterHero\",\"4016\":\"net_item.disItemResult\",\"4102\":\"net_hero.useSoulExpItem\",\"4103\":\"net_hero.breakThrough\",\"4104\":\"net_hero.unlockPersonality\",\"4105\":\"net_hero.favorabilityExpItem\",\"4106\":\"net_hero.changeSkin\",\"4107\":\"net_hero.ascendingStart\",\"4108\":\"net_hero.breakPrize\",\"4109\":\"net_hero.previewHeroMax\",\"4110\":\"net_hero.useSoulExpItemResult\",\"4111\":\"net_hero.breakThroughResult\",\"4112\":\"net_hero.unlockPersonalityResult\",\"4113\":\"net_hero.favorabilityExpItemResult\",\"4114\":\"net_hero.changeSkinResult\",\"4115\":\"net_hero.ascendingStartResult\",\"4116\":\"net_hero.notifyHeros\",\"4117\":\"net_hero.breakPrizeResult\",\"4118\":\"net_hero.previewHeroMaxResult\",\"4202\":\"net_mail.getMails\",\"4203\":\"net_mail.readMail\",\"4204\":\"net_mail.pickUp\",\"4205\":\"net_mail.delMail\",\"4206\":\"net_mail.getMailsResult\",\"4207\":\"net_mail.readMailResult\",\"4208\":\"net_mail.pickUpResult\",\"4209\":\"net_mail.delMailResult\",\"4210\":\"net_mail.notifyNewMail\",\"4211\":\"net_mail.notifyDeleteMail\",\"4302\":\"net_formation.changeFormationName\",\"4303\":\"net_formation.saveFormation\",\"4304\":\"net_formation.chooseHelpHero\",\"4305\":\"net_formation.clearHelpHero\",\"4306\":\"net_formation.presetFormation\",\"4307\":\"net_formation.canclePresetFormation\",\"4308\":\"net_formation.getFormation\",\"4309\":\"net_formation.syncPresetFormation\",\"4310\":\"net_formation.changeFormationNameResult\",\"4311\":\"net_formation.saveFormationResult\",\"4312\":\"net_formation.notifyFomationUpdate\",\"4313\":\"net_formation.chooseHelpHeroResult\",\"4314\":\"net_formation.clearHelpHeroResult\",\"4315\":\"net_formation.presetFormationResult\",\"4316\":\"net_formation.canclePresetFormationResult\",\"4317\":\"net_formation.getFormationResult\",\"4318\":\"net_formation.syncPresetFormationResult\",\"4402\":\"net_task.submit\",\"4403\":\"net_task.submitType\",\"4404\":\"net_task.obtainTask\",\"4405\":\"net_task.repairTask\",\"4406\":\"net_task.trackTask\",\"4407\":\"net_task.submitResult\",\"4408\":\"net_task.submitTypeResult\",\"4409\":\"net_task.obtainTaskResult\",\"4410\":\"net_task.notifyTask\",\"4411\":\"net_task.notifyRemove\",\"4412\":\"net_task.notifyFinish\",\"4413\":\"net_task.notifyRemoveFinish\",\"4414\":\"net_task.notifyRemoveTaskCompleteTime\",\"4415\":\"net_task.repairTaskResult\",\"4416\":\"net_task.trackTaskResult\",\"4502\":\"net_skill.wearSkill\",\"4503\":\"net_skill.unloadSkill\",\"4504\":\"net_skill.upgradeSkill\",\"4505\":\"net_skill.strengSkill\",\"4506\":\"net_skill.lockSkill\",\"4507\":\"net_skill.purifySkill\",\"4508\":\"net_skill.wearSkillResult\",\"4509\":\"net_skill.unloadSkillResult\",\"4510\":\"net_skill.upgradeSkillResult\",\"4511\":\"net_skill.strengSkillResult\",\"4512\":\"net_skill.lockSkillResult\",\"4513\":\"net_skill.purifySkillResult\",\"4602\":\"net_equip.wearEquip\",\"4603\":\"net_equip.unloadEquip\",\"4604\":\"net_equip.upgradeEquip\",\"4605\":\"net_equip.lockEquip\",\"4606\":\"net_equip.decomposeEquip\",\"4607\":\"net_equip.succinctAttr\",\"4608\":\"net_equip.applySuccinctAttr\",\"4609\":\"net_equip.wearEquipResult\",\"4610\":\"net_equip.unloadEquipResult\",\"4611\":\"net_equip.upgradeEquipResult\",\"4612\":\"net_equip.lockEquipResult\",\"4613\":\"net_equip.decomposeEquipResult\",\"4614\":\"net_equip.succinctAttrResult\",\"4615\":\"net_equip.applySuccinctAttrResult\",\"4702\":\"net_warehouse.notifyItemChange\",\"4902\":\"net_fight.fightOver\",\"4903\":\"net_fight.fightFrame\",\"4904\":\"net_fight.recoverFight\",\"4905\":\"net_fight.refreshRandomSeed\",\"4906\":\"net_fight.notifyStartFight\",\"4907\":\"net_fight.fightFrameResult\",\"4908\":\"net_fight.recoverFightResult\",\"4909\":\"net_fight.notifyFightOver\",\"4910\":\"net_fight.refreshRandomSeedResult\",\"5002\":\"net_shop.buy\",\"5003\":\"net_shop.buyResult\",\"5102\":\"net_draw.draw\",\"5103\":\"net_draw.drawRecord\",\"5104\":\"net_draw.history\",\"5105\":\"net_draw.cancel\",\"5106\":\"net_draw.confirm\",\"5107\":\"net_draw.drawResult\",\"5108\":\"net_draw.drawRecordResult\",\"5109\":\"net_draw.historyResult\",\"5110\":\"net_draw.cancelResult\",\"5111\":\"net_draw.confirmResult\",\"5112\":\"net_draw.notifyUpdateDraw\",\"5113\":\"net_draw.notifyAddDraw\",\"5114\":\"net_draw.notifyRemoveDraw\",\"5115\":\"net_draw.chooseShowGroup\",\"5116\":\"net_draw.chooseShowGroupResult\",\"5202\":\"net_sign.sign\",\"5203\":\"net_sign.signResult\",\"5204\":\"net_sign.notifySign\",\"5302\":\"net_generalDup.enterDup\",\"5303\":\"net_generalDup.enterDupResult\",\"5304\":\"net_generalDup.notifyDup\",\"5305\":\"net_generalDup.notifyFinishDup\",\"5306\":\"net_generalDup.enterMingleDup\",\"5307\":\"net_generalDup.enterMingleDupResult\",\"5402\":\"net_redDot.notifyRedDot\",\"5502\":\"net_dailyDup.enterDup\",\"5503\":\"net_dailyDup.enterDupResult\",\"5504\":\"net_dailyDup.notifyDup\",\"5505\":\"net_dailyDup.notifyFinishDup\",\"5506\":\"net_dailyDup.sweepDup\",\"5507\":\"net_dailyDup.sweepDupResult\",\"5602\":\"net_equipDup.enterDup\",\"5603\":\"net_equipDup.enterDupResult\",\"5604\":\"net_equipDup.notifyDup\",\"5605\":\"net_equipDup.notifyFinishDup\",\"5606\":\"net_equipDup.sweepDup\",\"5607\":\"net_equipDup.sweepDupResult\",\"5702\":\"net_monthCard.receiveMonthCardAward\",\"5703\":\"net_monthCard.receiveMonthCardAwardResult\",\"5704\":\"net_monthCard.notifyMonthCard\",\"5705\":\"net_monthCard.notifyMonthCardAward\",\"5802\":\"net_bossDup.enterDup\",\"5803\":\"net_bossDup.enterDupResult\",\"5804\":\"net_bossDup.notifyDup\",\"5805\":\"net_bossDup.notifyFinishDup\",\"5902\":\"net_pass.notifyPass\",\"6002\":\"net_home.upgradeHome\",\"6003\":\"net_home.refreshDispTask\",\"6004\":\"net_home.executeDispTask\",\"6005\":\"net_home.submitDispTask\",\"6006\":\"net_home.upgradeHomeResult\",\"6007\":\"net_home.refreshDispTaskResult\",\"6008\":\"net_home.executeDispTaskResult\",\"6009\":\"net_home.submitDispTaskResult\",\"6010\":\"net_home.notifyHome\",\"6011\":\"net_home.notifyUpdateTask\",\"6012\":\"net_home.notifyRemoveTask\",\"6102\":\"net_sceneMap.enterArea\",\"6103\":\"net_sceneMap.enterRoom\",\"6104\":\"net_sceneMap.moveComp\",\"6105\":\"net_sceneMap.triggerAction\",\"6106\":\"net_sceneMap.enterAreaResult\",\"6107\":\"net_sceneMap.enterRoomResult\",\"6108\":\"net_sceneMap.moveCompResult\",\"6109\":\"net_sceneMap.triggerActionResult\",\"6110\":\"net_sceneMap.notifyAreas\",\"6111\":\"net_sceneMap.notifyRooms\",\"6112\":\"net_sceneMap.notifyComps\",\"6113\":\"net_sceneMap.notifyActions\",\"6114\":\"net_sceneMap.notifyFinishActions\",\"6115\":\"net_sceneMap.notifyEnterRooms\",\"6116\":\"net_sceneMap.changeMapTimeSpan\",\"6117\":\"net_sceneMap.changeMapTimeSpanResult\",\"6118\":\"net_sceneMap.notifyMapTimeSpan\",\"6119\":\"net_sceneMap.notifySceneMapInfo\",\"6202\":\"net_favor.triggerMessage\",\"6203\":\"net_favor.entryComplete\",\"6204\":\"net_favor.entryOption\",\"6205\":\"net_favor.triggerMessageResult\",\"6206\":\"net_favor.entryCompleteResult\",\"6207\":\"net_favor.entryOptionResult\",\"6208\":\"net_favor.notifyEntry\",\"6209\":\"net_favor.notifyMessageFinish\",\"6302\":\"net_worldBossDup.enterDup\",\"6303\":\"net_worldBossDup.enterDupResult\",\"6304\":\"net_worldBossDup.notifyDup\",\"6305\":\"net_worldBossDup.notifyFinishDup\",\"6402\":\"net_crusadeDup.receiveCrusade\",\"6403\":\"net_crusadeDup.enterDup\",\"6404\":\"net_crusadeDup.receiveCrusadeResult\",\"6405\":\"net_crusadeDup.enterDupResult\",\"6406\":\"net_crusadeDup.notifyAddDup\",\"6407\":\"net_crusadeDup.notifyUpdateDup\",\"7002\":\"net_activity.receiveSupply\",\"7003\":\"net_activity.startGhostGame\",\"7004\":\"net_activity.endGhostGame\",\"7005\":\"net_activity.raffle\",\"7006\":\"net_activity.receiveSupplyResult\",\"7007\":\"net_activity.notifyActivity\",\"7008\":\"net_activity.notifyRemove\",\"7009\":\"net_activity.startGhostGameResult\",\"7010\":\"net_activity.endGhostGameResult\",\"7011\":\"net_activity.raffleResult\",\"8002\":\"net_plotStage.saveLevel\",\"8003\":\"net_plotStage.enterFight\",\"8004\":\"net_plotStage.completeLevel\",\"8005\":\"net_plotStage.saveLevelResult\",\"8006\":\"net_plotStage.enterFightResult\",\"8007\":\"net_plotStage.completeLevelResult\",\"8008\":\"net_plotStage.notifyStartPlot\",\"8009\":\"net_plotStage.triggerAction\",\"8010\":\"net_plotStage.setExtension\",\"8011\":\"net_plotStage.removeExtension\",\"8012\":\"net_plotStage.triggerActionResult\",\"8013\":\"net_plotStage.setExtensionResult\",\"8014\":\"net_plotStage.removeExtensionResult\",\"8015\":\"net_plotStage.notifyTempWarehouse\",\"8016\":\"net_plotStage.enterStaticFight\",\"8017\":\"net_plotStage.enterStaticFightResult\",\"8018\":\"net_plotStage.enterStaticStage\",\"8019\":\"net_plotStage.enterStaticStageResult\",\"9101\":\"net_climbTowerDup.enterDup\",\"9102\":\"net_climbTowerDup.dailyPrize\",\"9103\":\"net_climbTowerDup.enterDupResult\",\"9104\":\"net_climbTowerDup.dailyPrizeResult\",\"9105\":\"net_climbTowerDup.notifyDup\",\"9106\":\"net_climbTowerDup.notifyFinishDup\",\"9202\":\"net_mapData.enterMap\",\"9203\":\"net_mapData.exitMap\",\"9204\":\"net_mapData.takeNotesEffectId\",\"9205\":\"net_mapData.enterMapResult\",\"9206\":\"net_mapData.exitMapResult\",\"9207\":\"net_mapData.takeNotesEffectIdResult\",\"9208\":\"net_mapData.notifyUpdateMapSmall\",\"9209\":\"net_mapData.notifyUpdateMapItem\",\"9302\":\"net_randomDup.enterDup\",\"9303\":\"net_randomDup.enterDupResult\",\"9304\":\"net_randomDup.notifyDup\",\"9305\":\"net_randomDup.notifyFinishDup\",\"9402\":\"net_favorable.enterDup\",\"9403\":\"net_favorable.playSound\",\"9404\":\"net_favorable.viewDeed\",\"9405\":\"net_favorable.enterDupResult\",\"9406\":\"net_favorable.playSoundResult\",\"9407\":\"net_favorable.viewDeedResult\",\"9408\":\"net_favorable.notifyFinishDup\",\"9502\":\"net_mazeDup.wearGemstone\",\"9503\":\"net_mazeDup.takeOffGemstone\",\"9504\":\"net_mazeDup.upgradeOrbment\",\"9505\":\"net_mazeDup.selectSeatEffect\",\"9506\":\"net_mazeDup.cancelSeatEffect\",\"9507\":\"net_mazeDup.unlockSeat\",\"9508\":\"net_mazeDup.enterMazeDup\",\"9509\":\"net_mazeDup.claimProgressAward\",\"9510\":\"net_mazeDup.gainHeroPOD\",\"9511\":\"net_mazeDup.chageFormationPOD\",\"9512\":\"net_mazeDup.finishMazeStage\",\"9513\":\"net_mazeDup.wearGemstoneResult\",\"9514\":\"net_mazeDup.takeOffGemstoneResult\",\"9515\":\"net_mazeDup.upgradeOrbmentResult\",\"9516\":\"net_mazeDup.selectSeatEffectResult\",\"9517\":\"net_mazeDup.cancelSeatEffectResult\",\"9518\":\"net_mazeDup.unlockSeatResult\",\"9519\":\"net_mazeDup.enterMazeDupResult\",\"9520\":\"net_mazeDup.claimProgressAwardResult\",\"9521\":\"net_mazeDup.gainHeroPODResult\",\"9522\":\"net_mazeDup.chageFormationPODResult\",\"9523\":\"net_mazeDup.finishMazeStageResult\",\"9524\":\"net_mazeDup.notifyOrbmentPOD\",\"9525\":\"net_mazeDup.notifyMazeDup\",\"9526\":\"net_mazeDup.notifyFinishMazeDup\",\"9527\":\"net_mazeDup.notifyExitMazePlot\",\"9602\":\"net_labyrinth.setFormation\",\"9603\":\"net_labyrinth.chageFormationPOD\",\"9604\":\"net_labyrinth.enterStage\",\"9605\":\"net_labyrinth.exitStage\",\"9606\":\"net_labyrinth.startEnterRoom\",\"9607\":\"net_labyrinth.enterRoomFinish\",\"9608\":\"net_labyrinth.freshEvent\",\"9609\":\"net_labyrinth.freshBuff\",\"9610\":\"net_labyrinth.holdEvent\",\"9611\":\"net_labyrinth.submitEvent\",\"9612\":\"net_labyrinth.upgradeSenro\",\"9613\":\"net_labyrinth.resetSenro\",\"9614\":\"net_labyrinth.blackMarketUpgrade\",\"9615\":\"net_labyrinth.activeSenroTalent\",\"9616\":\"net_labyrinth.upgradeSenroTalent\",\"9617\":\"net_labyrinth.useLabyrinthItem\",\"9618\":\"net_labyrinth.freshStage\",\"9619\":\"net_labyrinth.setFormationResult\",\"9620\":\"net_labyrinth.chageFormationPODResult\",\"9621\":\"net_labyrinth.enterStageResult\",\"9622\":\"net_labyrinth.exitStageResult\",\"9623\":\"net_labyrinth.startEnterRoomResult\",\"9624\":\"net_labyrinth.enterRoomFinishResult\",\"9625\":\"net_labyrinth.freshEventResult\",\"9626\":\"net_labyrinth.freshBuffResult\",\"9627\":\"net_labyrinth.holdEventResult\",\"9628\":\"net_labyrinth.submitEventResult\",\"9629\":\"net_labyrinth.upgradeSenroResult\",\"9630\":\"net_labyrinth.resetSenroResult\",\"9631\":\"net_labyrinth.blackMarketUpgradeResult\",\"9632\":\"net_labyrinth.activeSenroTalentResult\",\"9633\":\"net_labyrinth.upgradeSenroTalentResult\",\"9634\":\"net_labyrinth.useLabyrinthItemResult\",\"9635\":\"net_labyrinth.freshStageResult\",\"9636\":\"net_labyrinth.notifySeasonOver\",\"9637\":\"net_labyrinth.notifyStageExit\",\"9638\":\"net_labyrinth.updateLabyrinthDataPOD\",\"9639\":\"net_labyrinth.updateStageMapPOD\",\"9640\":\"net_labyrinth.updateLabyrinthStagePOD\",\"9641\":\"net_labyrinth.updateLabyrinthWarehouse\",\"9642\":\"net_labyrinth.addLabyrinthWarehouse\",\"9643\":\"net_labyrinth.removeLabyrinthWarehouse\",\"9644\":\"net_labyrinth.updateStageWarehouse\",\"9645\":\"net_labyrinth.notifyFinishEvent\",\"9646\":\"net_labyrinth.updateLabyrinthHerosAndFormation\",\"9647\":\"net_labyrinth.updateLabyrinthBuff\",\"9648\":\"net_labyrinth.notifyTranslateItem\",\"9649\":\"net_labyrinth.notifyTranslateRoom\",\"9650\":\"net_labyrinth.updateStageEventLink\",\"9702\":\"net_activityDup.enterDup\",\"9703\":\"net_activityDup.receiveReward\",\"9704\":\"net_activityDup.enterDupResult\",\"9705\":\"net_activityDup.receiveRewardResult\",\"9706\":\"net_activityDup.notifyDup\",\"9707\":\"net_activityDup.notifyRemoveDup\",\"9708\":\"net_activityDup.notifyFinishDup\",\"9802\":\"net_richMan.richMan\",\"9803\":\"net_richMan.richManResult\",\"9804\":\"net_richMan.notityRichMan\",\"9805\":\"net_richMan.notityRemoveRichMan\",\"9902\":\"net_challengeDup.enterDup\",\"9903\":\"net_challengeDup.enterDupResult\",\"9904\":\"net_challengeDup.notifyFinishDup\"}"
msgIdMethodTypes = "{\"100102\":[\"CChatPOD\"],\"100103\":[\"int\"],\"100104\":[\"int\"],\"100105\":[\"int\",\"int\"],\"100106\":[\"SChatPOD\"],\"100107\":[\"int\"],\"100202\":[\"int\",\"int\",\"bool\"],\"100203\":[\"int\",\"bool\",\"int\"],\"100204\":[\"int\",\"int\",\"int\"],\"100205\":[\"int\",\"int\",\"bool\",\"list<RankingPOD>\",\"list<RankingPOD>\",\"int\",\"long\",\"string\",\"int\"],\"100206\":[\"int\",\"int\",\"string\"],\"100207\":[\"int\",\"int\",\"RankingPOD\",\"int\",\"int\"],\"100302\":[\"list<long>\"],\"100303\":[\"list<string>\"],\"100304\":[\"list<long>\",\"bool\"],\"100305\":[\"string\"],\"100306\":[\"list<long>\"],\"100307\":[\"string\"],\"100308\":[\"long\",\"string\"],\"100309\":[],\"100310\":[\"int\"],\"100311\":[\"int\"],\"100312\":[\"int\"],\"100313\":[\"int\"],\"100314\":[\"int\"],\"100315\":[\"int\"],\"100316\":[\"int\",\"FriendPOD\"],\"100317\":[\"int\",\"FriendPOD\"],\"100318\":[\"int\",\"list<FriendPOD>\"],\"100319\":[\"int\",\"list<HelpHeroPOD>\"],\"100320\":[\"list<FriendPOD>\"],\"100321\":[\"list<long>\"],\"100322\":[\"list<FriendPOD>\"],\"10102\":[\"int\",\"int\"],\"10103\":[\"int\",\"int\",\"int\",\"list<ItemShowPOD>\"],\"102\":[\"long\",\"SimplePlayerPOD\",\"PlayerPlatformDataPOD\"],\"103\":[\"string\",\"map<int|string>\"],\"104\":[\"string\",\"PlayerPlatformDataPOD\"],\"105\":[\"string\"],\"106\":[\"string\"],\"107\":[\"string\"],\"108\":[\"SimplePlayerPOD\",\"int\"],\"109\":[\"int\",\"long\",\"SimplePlayerPOD\"],\"110\":[\"int\",\"string\",\"map<int|string>\"],\"111\":[\"int\",\"string\",\"CenterLoadPlayerPOD\"],\"112\":[\"int\",\"string\",\"CenterLoadPlayerPOD\"],\"113\":[\"int\",\"bool\"],\"114\":[],\"115\":[],\"116\":[\"string\",\"string\"],\"117\":[\"SChatPOD\",\"list<string>\",\"bool\"],\"118\":[\"GmMailPOD\"],\"119\":[\"int\",\"string\",\"long\",\"string\",\"string\"],\"120\":[\"int\",\"list<string>\",\"list<RankSubsectionItemPOD>\"],\"121\":[\"map<int|ActivityPOD>\"],\"202\":[\"string\",\"string\",\"int\"],\"203\":[\"string\",\"string\",\"list<int>\"],\"3802\":[\"string\",\"string\",\"string\"],\"3803\":[\"string\"],\"3804\":[\"int\",\"string\"],\"3805\":[],\"3806\":[],\"3807\":[\"long\"],\"3808\":[\"int\",\"list<RoleInfoPOD>\",\"int\"],\"3809\":[\"int\"],\"3810\":[\"int\",\"RoleInfoPOD\"],\"3811\":[\"int\"],\"3812\":[\"int\"],\"3813\":[\"int\",\"int\"],\"3814\":[\"int\",\"string\"],\"3815\":[\"string\",\"bool\"],\"3816\":[\"int\"],\"3817\":[\"int\",\"list<ItemShowPOD>\"],\"3902\":[],\"3903\":[\"string\",\"int\",\"string\",\"string\"],\"3904\":[\"string\"],\"3905\":[\"map<int|string>\"],\"3906\":[\"string\",\"string\"],\"3907\":[\"string\"],\"3908\":[\"int\"],\"3909\":[\"int\",\"int\"],\"3910\":[\"string\",\"string\",\"int\"],\"3911\":[\"int\",\"int\",\"int\"],\"3912\":[\"LittleInformationPOD\"],\"3913\":[\"list<AchieveShowPOD>\"],\"3914\":[\"int\"],\"3915\":[],\"3916\":[\"int\"],\"3917\":[\"int\"],\"3918\":[\"list<int>\"],\"3919\":[\"bool\"],\"3920\":[\"int\",\"PlayerPOD\",\"string\"],\"3921\":[\"int\",\"int\",\"string\"],\"3922\":[\"int\"],\"3923\":[\"int\",\"PlayerBaseInfoPOD\"],\"3924\":[\"int\",\"PlayerBaseInfoPOD\"],\"3925\":[\"int\",\"list<ItemShowPOD>\"],\"3926\":[\"map<int|ModleStatePOD>\"],\"3927\":[\"int\",\"PlayerBaseInfoPOD\"],\"3928\":[\"int\",\"PlayerBaseInfoPOD\"],\"3929\":[\"int\",\"HeroPOD\"],\"3930\":[\"PlayerBaseInfoPOD\"],\"3931\":[\"int\",\"list<ItemShowPOD>\"],\"3932\":[\"int\",\"int\",\"int\",\"int\"],\"3933\":[\"int\"],\"3934\":[\"int\"],\"3935\":[\"map<int|int>\"],\"3936\":[\"int\",\"map<int|int>\"],\"3937\":[\"int\",\"TalentPOD\",\"list<ItemShowPOD>\"],\"3938\":[\"int\"],\"3939\":[\"int\",\"PlayerBaseInfoPOD\"],\"3940\":[\"int\"],\"3941\":[\"int\"],\"3942\":[\"map<string|string>\"],\"3943\":[\"map<int|int>\"],\"3944\":[\"map<int|int>\"],\"3945\":[\"KanBanPOD\"],\"3946\":[\"map<int|GlobalBuffPOD>\"],\"3947\":[\"string\",\"string\"],\"3948\":[\"int\"],\"3949\":[\"map<int|long>\"],\"4002\":[\"long\",\"int\"],\"4003\":[\"list<UseItemPOD>\"],\"4004\":[\"map<int|int>\"],\"4005\":[\"long\"],\"4006\":[\"long\"],\"4007\":[\"map<long|int>\"],\"4008\":[\"int\"],\"4009\":[\"int\",\"list<ItemShowPOD>\"],\"4010\":[\"int\",\"list<ItemShowPOD>\"],\"4011\":[\"int\"],\"4012\":[\"int\",\"ItemPOD\"],\"4013\":[\"list<ItemShowPOD>\"],\"4014\":[\"list<ItemShowPOD>\",\"int\"],\"4015\":[\"list<HeroConverterPOD>\"],\"4016\":[\"int\",\"list<ItemShowPOD>\"],\"4102\":[\"int\",\"map<int|int>\",\"bool\"],\"4103\":[\"int\",\"bool\"],\"4104\":[\"int\",\"int\"],\"4105\":[\"int\",\"map<int|int>\"],\"4106\":[\"int\",\"long\"],\"4107\":[\"int\"],\"4108\":[\"int\",\"int\"],\"4109\":[\"int\",\"int\",\"int\"],\"4110\":[\"int\",\"float\",\"bool\",\"HeroPOD\"],\"4111\":[\"int\",\"bool\",\"HeroPOD\"],\"4112\":[\"int\",\"int\"],\"4113\":[\"int\",\"bool\"],\"4114\":[\"int\"],\"4115\":[\"int\"],\"4116\":[\"map<int|HeroPOD>\"],\"4117\":[\"int\",\"HeroPOD\",\"list<ItemShowPOD>\"],\"4118\":[\"int\",\"HeroPOD\"],\"4202\":[\"int\"],\"4203\":[\"long\"],\"4204\":[\"list<long>\",\"bool\"],\"4205\":[\"list<long>\",\"bool\"],\"4206\":[\"int\",\"int\",\"list<MailPOD>\"],\"4207\":[\"int\",\"long\"],\"4208\":[\"int\",\"list<MailPOD>\",\"list<ItemShowPOD>\"],\"4209\":[\"int\",\"list<long>\"],\"4210\":[\"int\"],\"4211\":[\"list<long>\"],\"4302\":[\"int\",\"string\"],\"4303\":[\"int\",\"map<int|int>\",\"map<int|int>\",\"map<long|int>\"],\"4304\":[\"int\",\"int\",\"HelpHeroPOD\"],\"4305\":[\"int\"],\"4306\":[\"int\",\"map<int|int>\",\"bool\"],\"4307\":[\"int\",\"int\"],\"4308\":[\"int\"],\"4309\":[\"int\",\"bool\"],\"4310\":[\"int\",\"string\"],\"4311\":[\"int\"],\"4312\":[\"FormationPOD\"],\"4313\":[\"int\",\"FormationPOD\"],\"4314\":[\"int\",\"FormationPOD\"],\"4315\":[\"int\"],\"4316\":[\"int\"],\"4317\":[\"int\"],\"4318\":[\"int\"],\"4402\":[\"list<int>\"],\"4403\":[\"list<string>\"],\"4404\":[\"int\"],\"4405\":[\"int\"],\"4406\":[\"int\"],\"4407\":[\"int\",\"list<int>\",\"list<ItemShowPOD>\"],\"4408\":[\"int\",\"list<ItemShowPOD>\"],\"4409\":[\"int\"],\"4410\":[\"map<int|TaskPOD>\"],\"4411\":[\"list<int>\"],\"4412\":[\"list<int>\"],\"4413\":[\"list<int>\"],\"4414\":[\"map<int|long>\"],\"4415\":[\"int\"],\"4416\":[\"int\"],\"4502\":[\"int\",\"int\",\"long\"],\"4503\":[\"int\",\"int\"],\"4504\":[\"long\",\"map<int|int>\"],\"4505\":[\"long\"],\"4506\":[\"list<long>\"],\"4507\":[\"long\",\"map<long|int>\"],\"4508\":[\"int\"],\"4509\":[\"int\"],\"4510\":[\"int\",\"SkillPOD\",\"SkillPOD\",\"bool\"],\"4511\":[\"int\",\"SkillPOD\"],\"4512\":[\"int\"],\"4513\":[\"int\",\"SkillPOD\",\"SkillPOD\"],\"4602\":[\"int\",\"long\"],\"4603\":[\"int\",\"long\"],\"4604\":[\"long\",\"map<long|int>\"],\"4605\":[\"list<long>\"],\"4606\":[\"list<long>\"],\"4607\":[\"long\",\"int\",\"int\"],\"4608\":[\"long\",\"int\"],\"4609\":[\"int\"],\"4610\":[\"int\"],\"4611\":[\"int\",\"float\",\"EquipPOD\",\"EquipPOD\"],\"4612\":[\"int\"],\"4613\":[\"int\"],\"4614\":[\"int\",\"long\",\"int\",\"int\",\"map<int|int>\",\"map<int|double>\"],\"4615\":[\"int\"],\"4702\":[\"list<ItemPOD>\"],\"4902\":[\"int\",\"int\",\"int\",\"map<int|int>\",\"FightTroopPOD\",\"FightTroopPOD\",\"string\",\"string\",\"long\"],\"4903\":[\"string\",\"string\"],\"4904\":[\"string\"],\"4905\":[],\"4906\":[\"bool\",\"FightPOD\",\"string\",\"list<string>\"],\"4907\":[\"int\"],\"4908\":[\"int\"],\"4909\":[\"FightOverPOD\"],\"4910\":[\"int\",\"long\"],\"5002\":[\"int\",\"int\"],\"5003\":[\"int\",\"list<ItemShowPOD>\",\"map<int|int>\"],\"5102\":[\"int\",\"int\",\"bool\"],\"5103\":[\"int\"],\"5104\":[\"int\"],\"5105\":[\"int\"],\"5106\":[\"int\",\"bool\"],\"5107\":[\"int\",\"DrawResultListPOD\"],\"5108\":[\"int\",\"list<DrawRecordPOD>\"],\"5109\":[\"int\"],\"5110\":[\"int\"],\"5111\":[\"int\"],\"5112\":[\"list<DrawPOD>\"],\"5113\":[\"list<DrawPOD>\"],\"5114\":[\"list<DrawPOD>\"],\"5115\":[\"int\",\"int\"],\"5116\":[\"int\",\"int\",\"int\"],\"5202\":[\"int\"],\"5203\":[\"int\",\"SignPOD\",\"list<ItemShowPOD>\"],\"5204\":[\"SignPOD\"],\"5302\":[\"int\",\"bool\"],\"5303\":[\"int\"],\"5304\":[\"map<int|int>\"],\"5305\":[\"FightOverPOD\",\"int\"],\"5306\":[\"int\",\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"5307\":[\"int\"],\"5402\":[\"map<int|int>\"],\"5502\":[\"int\",\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"5503\":[\"int\"],\"5504\":[\"list<DailyDupPOD>\"],\"5505\":[\"FightOverPOD\"],\"5506\":[\"int\",\"int\"],\"5507\":[\"int\",\"list<ItemShowPOD>\"],\"5602\":[\"int\",\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"5603\":[\"int\"],\"5604\":[\"list<EquipDupPOD>\"],\"5605\":[\"FightOverPOD\"],\"5606\":[\"int\",\"int\"],\"5607\":[\"int\",\"list<ItemShowPOD>\"],\"5702\":[],\"5703\":[\"int\",\"list<ItemShowPOD>\"],\"5704\":[\"MonthCardPOD\"],\"5705\":[\"list<ItemShowPOD>\"],\"5802\":[\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"5803\":[\"int\"],\"5804\":[\"list<BossDupPOD>\"],\"5805\":[\"FightOverPOD\"],\"5902\":[\"PassPOD\"],\"6002\":[],\"6003\":[],\"6004\":[\"int\",\"list<int>\"],\"6005\":[\"int\"],\"6006\":[\"int\",\"HomePOD\"],\"6007\":[\"int\"],\"6008\":[\"int\"],\"6009\":[\"int\",\"list<ItemShowPOD>\"],\"6010\":[\"HomePOD\"],\"6011\":[\"map<int|DispTaskPOD>\"],\"6012\":[\"list<int>\"],\"6102\":[\"int\",\"bool\"],\"6103\":[\"int\",\"bool\",\"string\"],\"6104\":[\"int\",\"int\"],\"6105\":[\"int\",\"int\",\"string\"],\"6106\":[\"int\",\"int\",\"int\",\"bool\"],\"6107\":[\"int\",\"int\",\"int\",\"bool\",\"string\"],\"6108\":[\"int\"],\"6109\":[\"int\",\"int\",\"int\",\"TriggerActionPOD\"],\"6110\":[\"map<int|SceneMapAreaPOD>\"],\"6111\":[\"map<int|SceneMapRoomPOD>\"],\"6112\":[\"map<int|SceneMapCompPOD>\"],\"6113\":[\"map<int|SceneMapActionPOD>\"],\"6114\":[\"map<int|int>\"],\"6115\":[\"int\",\"int\"],\"6116\":[\"int\"],\"6117\":[\"int\"],\"6118\":[\"int\"],\"6119\":[\"SceneMapInfoPOD\"],\"6202\":[\"int\"],\"6203\":[\"int\"],\"6204\":[\"int\",\"int\"],\"6205\":[\"int\"],\"6206\":[\"int\",\"list<ItemShowPOD>\"],\"6207\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"6208\":[\"int\",\"int\",\"int\"],\"6209\":[\"map<int|int>\"],\"6302\":[\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"6303\":[\"int\"],\"6304\":[\"list<WorldBossDupPOD>\"],\"6305\":[\"FightOverPOD\"],\"6402\":[\"int\"],\"6403\":[\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"6404\":[\"int\"],\"6405\":[\"int\"],\"6406\":[\"map<int|CrusadeDupPOD>\"],\"6407\":[\"CrusadeDupPOD\"],\"7002\":[\"int\",\"int\"],\"7003\":[\"int\"],\"7004\":[\"int\",\"map<int|int>\"],\"7005\":[\"int\"],\"7006\":[\"int\",\"list<ItemShowPOD>\"],\"7007\":[\"map<int|ActivityPOD>\"],\"7008\":[\"list<int>\"],\"7009\":[\"int\"],\"7010\":[\"int\",\"list<ItemShowPOD>\"],\"7011\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"8002\":[\"PlotStageDupPOD\"],\"8003\":[\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"8004\":[\"int\"],\"8005\":[\"int\",\"PlotStageDupPOD\"],\"8006\":[\"int\"],\"8007\":[\"int\",\"bool\"],\"8008\":[\"PlotStageDupPOD\"],\"8009\":[\"int\",\"int\"],\"8010\":[\"bool\",\"map<string|ExtensionPOD>\"],\"8011\":[\"list<string>\"],\"8012\":[\"int\",\"list<ItemShowPOD>\"],\"8013\":[\"int\",\"bool\",\"map<string|ExtensionPOD>\"],\"8014\":[\"int\",\"list<string>\"],\"8015\":[\"map<long|TempItemPOD>\",\"bool\"],\"8016\":[\"int\"],\"8017\":[\"int\"],\"8018\":[\"int\"],\"8019\":[\"int\"],\"9101\":[\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"9102\":[\"int\"],\"9103\":[\"int\"],\"9104\":[\"int\",\"map<int|long>\",\"list<ItemShowPOD>\"],\"9105\":[\"list<ClimbTowerDupPOD>\"],\"9106\":[\"FightOverPOD\"],\"9202\":[\"int\",\"bool\",\"int\"],\"9203\":[],\"9204\":[\"int\"],\"9205\":[\"int\",\"list<MapSmallPOD>\"],\"9206\":[\"int\"],\"9207\":[\"int\"],\"9208\":[\"list<MapSmallPOD>\"],\"9209\":[\"list<MapItemPOD>\"],\"9302\":[\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"9303\":[\"int\"],\"9304\":[\"list<RandomDupPOD>\"],\"9305\":[\"RandomDupPOD\"],\"9402\":[\"int\",\"int\"],\"9403\":[\"int\",\"int\"],\"9404\":[\"int\",\"int\"],\"9405\":[\"int\"],\"9406\":[\"int\"],\"9407\":[\"int\"],\"9408\":[\"FightOverPOD\"],\"9502\":[\"long\",\"int\"],\"9503\":[\"int\"],\"9504\":[\"int\"],\"9505\":[\"int\",\"int\"],\"9506\":[\"int\"],\"9507\":[\"int\"],\"9508\":[\"int\",\"int\"],\"9509\":[\"int\",\"int\"],\"9510\":[\"list<int>\"],\"9511\":[\"FormationPOD\"],\"9512\":[\"int\"],\"9513\":[\"int\",\"int\"],\"9514\":[\"int\",\"int\"],\"9515\":[\"int\"],\"9516\":[\"int\",\"int\"],\"9517\":[\"int\",\"int\"],\"9518\":[\"int\",\"int\"],\"9519\":[\"int\",\"MazeStagePOD\",\"StorySaveDataPOD\"],\"9520\":[\"int\",\"list<ItemShowPOD>\"],\"9521\":[\"int\"],\"9522\":[\"int\"],\"9523\":[\"int\"],\"9524\":[\"OrbmentPOD\"],\"9525\":[\"MazeStagePOD\"],\"9526\":[\"FightOverPOD\"],\"9527\":[],\"9602\":[\"map<int|int>\",\"list<int>\"],\"9603\":[\"int\",\"FormationPOD\"],\"9604\":[\"int\"],\"9605\":[\"int\",\"int\"],\"9606\":[\"int\",\"int\",\"bool\",\"int\"],\"9607\":[\"int\",\"int\",\"bool\",\"int\"],\"9608\":[\"int\",\"int\"],\"9609\":[\"int\",\"int\"],\"9610\":[\"int\",\"int\"],\"9611\":[\"int\",\"int\",\"int\",\"int\",\"int\",\"int\",\"map<int|ClientDataPOD>\"],\"9612\":[],\"9613\":[],\"9614\":[],\"9615\":[\"int\"],\"9616\":[\"int\"],\"9617\":[\"int\",\"map<int|int>\"],\"9618\":[],\"9619\":[\"int\",\"LabyrinthDataPOD\"],\"9620\":[\"int\"],\"9621\":[\"int\",\"LabyrinthStagePOD\"],\"9622\":[\"int\",\"int\",\"list<ItemShowPOD>\"],\"9623\":[\"int\",\"StageMapPOD\"],\"9624\":[\"int\",\"StageMapPOD\",\"bool\"],\"9625\":[\"int\"],\"9626\":[\"int\",\"int\",\"list<int>\"],\"9627\":[\"int\",\"StageEventPOD\"],\"9628\":[\"int\",\"list<ItemShowPOD>\"],\"9629\":[\"int\",\"SenroPOD\",\"list<ItemShowPOD>\"],\"9630\":[\"int\",\"SenroPOD\",\"list<ItemShowPOD>\"],\"9631\":[\"int\",\"int\"],\"9632\":[\"int\",\"SenroPOD\"],\"9633\":[\"int\",\"SenroTalentPOD\"],\"9634\":[\"int\",\"list<ItemShowPOD>\"],\"9635\":[\"int\",\"LabyrinthDataPOD\"],\"9636\":[\"int\",\"list<ItemShowPOD>\"],\"9637\":[\"int\"],\"9638\":[\"LabyrinthDataPOD\"],\"9639\":[\"StageMapPOD\"],\"9640\":[\"LabyrinthStagePOD\"],\"9641\":[\"map<int|int>\"],\"9642\":[\"map<int|int>\"],\"9643\":[\"list<int>\"],\"9644\":[\"map<int|int>\"],\"9645\":[\"StageEventPOD\",\"list<ItemShowPOD>\"],\"9646\":[\"list<UpdateLabyrinthHeroPOD>\",\"FormationPOD\"],\"9647\":[\"map<int|BuffPOD>\"],\"9648\":[\"list<ItemShowPOD>\"],\"9649\":[\"int\",\"int\"],\"9650\":[\"StageEventLinkPOD\"],\"9702\":[\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"9703\":[\"int\",\"int\"],\"9704\":[\"int\"],\"9705\":[\"int\",\"list<ItemShowPOD>\"],\"9706\":[\"list<ActivityChapterPOD>\"],\"9707\":[\"ActivityChapterPOD\"],\"9708\":[\"FightOverPOD\"],\"9802\":[\"int\"],\"9803\":[\"int\",\"map<int|int>\",\"list<ItemShowPOD>\"],\"9804\":[\"RichManPOD\"],\"9805\":[\"RichManPOD\"],\"9902\":[\"int\",\"list<AttackUnitPOD>\",\"map<long|int>\"],\"9903\":[\"int\"],\"9904\":[\"ChallengeDupPOD\"]}"
namePodSerialId = "{\"AchieveShowPOD\":{\"cid\":1,\"layerId\":2,\"x\":3,\"y\":4,\"z\":5},\"ActivityChapterPOD\":{\"chapterId\":1,\"endTime\":3,\"passStar\":4,\"starState\":5,\"startTime\":2},\"ActivityPOD\":{\"activityRecharge\":11,\"cid\":1,\"closeDateTime\":5,\"dupDropPOD\":8,\"ghostPOD\":10,\"openCount\":6,\"openDateTime\":3,\"stage\":2,\"stageDateTime\":4,\"supplyPOD\":9,\"treasureHuntPOD\":12,\"version\":7},\"ActivityRechargePOD\":{\"getRewardsList\":2,\"totalRecharge\":1},\"AttackUnitPOD\":{\"UUID\":12,\"addFavorExp\":13,\"addFavorLv\":14,\"heroLv\":11,\"iconSkin\":10,\"injury\":8,\"order\":6,\"pid\":2,\"pos\":5,\"record\":7,\"remedy\":9,\"serverId\":3,\"type\":1,\"val\":4},\"AttrColonePOD\":{\"attr\":1},\"BlackMarketPOD\":{\"level\":1},\"BossDupPOD\":{\"cid\":1,\"optimalIntegral\":5,\"passStatus\":2,\"powerTime\":4,\"prizeTime\":3,\"totalIntegral\":6},\"BuffPOD\":{\"buffs\":1},\"CChatPOD\":{\"channel\":1,\"content\":4,\"target\":3,\"type\":2},\"CenterLoadPlayerPOD\":{\"chatRoomId\":1,\"friends\":2},\"ChallengeDupPOD\":{\"cid\":1,\"state\":2},\"ChooseListPOD\":{\"eventIds\":1},\"CleanItemPOD\":{\"cleanTime\":2,\"id\":1},\"ClientDataPOD\":{\"clientData\":1},\"ClimbTowerDupPOD\":{\"cid\":1,\"dailyStatus\":3,\"passStatus\":2},\"CluePOD\":{\"clueId\":1,\"completeState\":3,\"porgress\":2},\"ConditionFinishPOD\":{\"conditionIds\":1},\"CrusadeDupPOD\":{\"crusadeCid\":2,\"endTime\":4,\"index\":1,\"state\":3},\"DailyDupPOD\":{\"cid\":1,\"costFree\":3,\"extraReward\":2,\"passStatus\":4},\"DispTaskPOD\":{\"cid\":1,\"executeTime\":3,\"heroCids\":4,\"status\":2},\"DrawData\":{\"activityId\":3,\"confirmTime\":14,\"currentItems\":8,\"dayFreeTime\":10,\"drawGroup\":6,\"drawTime\":2,\"endTime\":13,\"historyItems\":7,\"id\":1,\"isFree\":9,\"lastGuaranteed\":5,\"mustDrawTime\":4,\"startTime\":12,\"sumFreeTime\":11},\"DrawDataPOD\":{\"cid\":2,\"num\":3,\"order\":4,\"srcId\":1},\"DrawItemPOD\":{\"cardCid\":4,\"drawStarTime\":7,\"drawUpTime\":8,\"group\":1,\"id\":5,\"itemId\":2,\"itemNum\":3,\"type\":6,\"upFlag\":9},\"DrawLotsPOD\":{\"cid\":1},\"DrawPOD\":{\"activityId\":4,\"confirmTime\":13,\"currentItems\":9,\"dayFreeTime\":11,\"drawTime\":2,\"endTime\":6,\"historyItems\":8,\"id\":1,\"isFree\":10,\"mustDrawTime\":3,\"mustGuarantee\":7,\"openTime\":5,\"sumFreeTime\":12},\"DrawRecordPOD\":{\"id\":1,\"itemId\":2,\"order\":4,\"rollTime\":3},\"DrawResultListPOD\":{\"drawResults\":1,\"sumTokens\":2},\"DrawResultPOD\":{\"drawStarTime\":2,\"drawUpTime\":3,\"itemShowPODs\":4,\"srcId\":1,\"tokens\":5},\"DupDropPOD\":{\"dayNum\":2,\"sumNum\":1},\"EntryPOD\":{\"map\":1},\"EquipDupPOD\":{\"cid\":1,\"passStatus\":2},\"EquipPOD\":{\"equipCid\":3,\"exp\":4,\"heroCid\":5,\"id\":1,\"itemCid\":2,\"lock\":9,\"lv\":6,\"masterAttrs\":7,\"slaverAttrs\":8},\"EventPOD\":{\"eventId\":3,\"id\":1,\"type\":2},\"ExtensionPOD\":{\"clear\":1,\"eventIds\":3,\"value\":2},\"FavorMsgGroupPOD\":{\"cid\":1,\"entrys\":2},\"FavorPOD\":{\"favorMsgGroups\":1},\"FightOverPOD\":{\"allConditionIds\":8,\"awards\":4,\"everyTimeAwards\":5,\"fightIntegral\":9,\"fightResult\":2,\"finishConditionIds\":7,\"returnExpend\":6,\"triggerBuffs\":10,\"type\":1,\"units\":3},\"FightPOD\":{\"Attacker\":5,\"BattleParams\":9,\"BattleType\":2,\"CurrentBigRound\":11,\"Defender\":6,\"ID\":1,\"MapID\":3,\"MaxBigRound\":12,\"MaxRound\":10,\"MonsterTeamID\":8,\"Players\":7,\"RandomSeed\":4},\"FightSkillPOD\":{\"PurifyLv\":4,\"SkillId\":1,\"SkillLv\":2,\"SkinId\":3,\"StrengLv\":5},\"FightTroopPOD\":{\"ArrFightUnitPOD\":6,\"Buffs\":2,\"Pid\":1,\"SkillStrengthens\":5,\"Skills\":4,\"Terrains\":3},\"FightUnitPOD\":{\"AIType\":18,\"Attributes\":6,\"BaseAttrs\":5,\"BattlePos\":8,\"HeroCid\":13,\"HeroSkinId\":16,\"InitBuff\":15,\"IsHelper\":12,\"Level\":4,\"MonsterCfgId\":3,\"Order\":17,\"Pid\":2,\"Power\":14,\"SPStatus\":11,\"SkillStrengthens\":10,\"Skills\":9,\"TroopType\":7,\"UUID\":1},\"FormationPOD\":{\"agentSkill\":8,\"attackOrder\":7,\"cid\":1,\"helpHeros\":5,\"heros\":4,\"name\":2,\"presetHcid\":6,\"sync\":3},\"FriendPOD\":{\"createTime\":10,\"guid\":2,\"helpHeros\":13,\"heroSkin\":14,\"id\":1,\"lastLoginTime\":11,\"online\":7,\"pId\":3,\"pLv\":6,\"pName\":4,\"remark\":8,\"serverId\":12,\"showHeroCid\":5,\"type\":9},\"GhostPOD\":{\"todayCount\":1},\"GlobalBuffPOD\":{\"StackCount\":4,\"buffCid\":1,\"createTime\":3,\"status\":5,\"triggerCount\":2},\"GmMailPOD\":{\"channelIds\":15,\"content\":3,\"createTime\":5,\"effectiveTime\":12,\"expireTime\":6,\"extJson\":11,\"id\":1,\"isAllPlayer\":8,\"isAllTime\":9,\"itemList\":7,\"levelLimit\":14,\"registerTime\":13,\"sender\":4,\"target\":10,\"title\":2},\"GroupDrawPOD\":{\"drawDatas\":7,\"drawRecords\":6,\"drawUp\":4,\"groupId\":1,\"guaranteedTime\":2,\"orderId\":5,\"tenTime\":3},\"HelpHeroPOD\":{\"hero\":4,\"pid\":1,\"pname\":3,\"serverId\":2},\"HeroConverterPOD\":{\"srcId\":1,\"targetId\":2},\"HeroPOD\":{\"aiType\":24,\"attr\":6,\"baseAttr\":17,\"breakLv\":5,\"breakPrize\":25,\"buffs\":22,\"cid\":2,\"curCartoon\":15,\"curSpine\":16,\"equip\":8,\"exp\":4,\"favor\":27,\"favorabilityExp\":11,\"favorabilityLevel\":10,\"favorableDups\":21,\"flag\":20,\"globalBuffs\":28,\"heroSkin\":26,\"id\":1,\"lv\":3,\"personality\":9,\"proportion\":14,\"showXPos\":12,\"showYPos\":13,\"skill\":7,\"starLevel\":18,\"starTime\":19,\"strengthens\":23},\"HeroSkinPOD\":{\"heroCid\":4,\"id\":1,\"itemCid\":2,\"skinCid\":3},\"HomePOD\":{\"dispRefreshTaskCount\":2,\"lv\":1,\"task\":3,\"workHeros\":4},\"ItemPOD\":{\"cid\":2,\"createTime\":5,\"equip\":8,\"flag\":6,\"heroSkin\":9,\"id\":1,\"num\":3,\"sceneMapRoomSkinPOD\":10,\"skill\":7,\"usedNum\":4},\"ItemShowPOD\":{\"cid\":2,\"id\":1,\"num\":3,\"srcId\":5,\"tag\":4},\"ItemShowPODS\":{\"awards\":1},\"ItemUseRecordPOD\":{\"itemCid\":1,\"useTime\":2},\"KanBanPOD\":{\"kanBanId\":1,\"kanbanPool\":3,\"randomKanban\":2},\"LabyrinthDataPOD\":{\"animation\":15,\"blackMarketPOD\":9,\"curDifficulty\":10,\"diffcultyTime\":13,\"endTime\":4,\"eventLinkTimes\":22,\"eventTypes\":23,\"exploreTime\":11,\"firstTalent\":16,\"guaranteedTime\":18,\"killMonsterTime\":12,\"labyrinthStagePODs\":6,\"labyrinthWarehouse\":7,\"lastPoolId\":17,\"memoryEvent\":21,\"nextRestoreTime\":5,\"preHeros\":19,\"replaceHeros\":20,\"seasonId\":1,\"senroPOD\":8,\"startTime\":3,\"state\":2,\"useItemMap\":14},\"LabyrinthStagePOD\":{\"buffFreshTime\":19,\"buffs\":17,\"curMainRoomId\":18,\"curRoomId\":6,\"difficulty\":1,\"endTime\":10,\"eventLinkTimes\":8,\"eventTypes\":14,\"exploreFlg\":7,\"formationPOD\":2,\"heroAttrClone\":4,\"heros\":3,\"mapBuffs\":11,\"monsterTypes\":13,\"poolId\":16,\"settlementFlg\":15,\"stageMapPODs\":5,\"stageWarehouse\":12,\"startTime\":9},\"LittleInformationPOD\":{\"state\":4,\"x\":1,\"y\":2,\"z\":3},\"MailPOD\":{\"cid\":2,\"content\":4,\"createTime\":8,\"expireTime\":9,\"id\":1,\"isHasItem\":7,\"isRead\":6,\"itemList\":10,\"sender\":5,\"title\":3},\"MapItemDataPOD\":{\"stageId\":1},\"MapItemPOD\":{\"mapItemDataPod\":3,\"mapItemId\":2,\"mapSmallId\":1},\"MapSmallPOD\":{\"mapItems\":1},\"MazeDupPOD\":{\"mazeStages\":2,\"orbmentPOD\":1},\"MazeStagePOD\":{\"baseAttrClone\":5,\"beforeProgress\":12,\"endTime\":8,\"fightExtraReward\":11,\"formationPOD\":3,\"heros\":4,\"mazeId\":1,\"orbmentPOD\":2,\"progress\":13,\"progressIds\":6,\"startTime\":7,\"state\":9,\"teamBuff\":10},\"MemoryEventPOD\":{\"events\":1},\"ModleStatePOD\":{\"endTime\":3,\"funcType\":1,\"reason\":2,\"state\":4},\"MonthCardPOD\":{\"endTime\":2,\"monthPrzieState\":3,\"startTime\":1},\"OrbmentPOD\":{\"attr\":6,\"dropRate\":2,\"fightBuffId\":5,\"gemstoneLimit\":1,\"ids\":4,\"seats\":3},\"PassPOD\":{\"openTime\":5,\"passExp\":2,\"passLevel\":1,\"state\":3,\"vipExp\":4},\"PlayerBaseInfoPOD\":{\"achieveShow\":23,\"birthday\":25,\"changeNameCount\":24,\"changeNameTime\":17,\"createTime\":11,\"currentTrackTaskCid\":32,\"effectIds\":22,\"exp\":10,\"guid\":3,\"helpHeros\":13,\"heroSkin\":19,\"intro\":5,\"kanBanPOD\":31,\"littleInformationPOD\":18,\"loginFlag\":21,\"monthResetTime\":29,\"openId\":4,\"pLv\":9,\"pName\":6,\"pid\":2,\"questionnaires\":20,\"rebate\":30,\"restoreTime\":14,\"sdkName\":8,\"serverId\":7,\"sex\":26,\"showHeroCid\":12,\"todayResetTime\":27,\"totalLoginDay\":15,\"uid\":1,\"unlockOpera\":16,\"weekResetTime\":28},\"PlayerPKGPOD\":{\"achieveShow\":23,\"activeRecord\":10,\"antiAddictionAccTime\":6,\"changeNameCount\":31,\"changeNameTime\":19,\"cleanItems\":45,\"combination\":32,\"commodityBuyRecords\":39,\"crusadeTime\":46,\"currentGuide\":16,\"currentTrackTaskCid\":43,\"dailyMonthCardReceive\":49,\"dailyResetTime\":7,\"drawCount\":18,\"drawShowGroupRecords\":47,\"effectIds\":26,\"eventFreshTime\":29,\"finishFavorMsgGroups\":42,\"finishGuide\":17,\"finishRechargeOrder\":35,\"finishTasks\":11,\"generalDup\":27,\"globalBuffs\":44,\"helpHeros\":13,\"isDouble\":34,\"isFirst\":33,\"itemAddCounts\":36,\"itemDropGetCnts\":8,\"itemTakeCounts\":37,\"kanBanPOD\":40,\"limitedTimePkg\":38,\"littleInfomation\":21,\"loginFlag\":25,\"lucky\":41,\"monthCard\":48,\"onlineTime\":5,\"questionnaires\":24,\"receiveGmMails\":9,\"resetTalentCount\":30,\"restoreTime\":14,\"robotVersion\":1,\"saveData\":50,\"talents\":28,\"taskCompleteTime\":22,\"times\":20,\"total_login_cnt\":2,\"total_login_day\":3,\"total_online_time\":4,\"unlockFunc\":12,\"unlockOperaID\":15},\"PlayerPOD\":{\"activityDups\":32,\"activitys\":17,\"baseInfo\":1,\"bossDups\":20,\"challengeDups\":37,\"chatRoomId\":2,\"climbTowerDups\":21,\"commodityBuyRecords\":36,\"crusadeDupPODs\":42,\"currentGuide\":14,\"dailyDups\":19,\"drawPODs\":12,\"drawShowGroupRecords\":43,\"equipDups\":18,\"finishGuide\":15,\"finishMsgGroups\":39,\"finishTasks\":7,\"formations\":8,\"friends\":3,\"generalDups\":26,\"globalBuffPODs\":41,\"heros\":5,\"home\":31,\"labyrinthStagePOD\":30,\"limitedTimePkg\":35,\"mazeDupPOD\":29,\"monthCard\":44,\"monthCardPOD\":23,\"newMailCount\":11,\"passPOD\":22,\"plotStageDupPOD\":24,\"randomDups\":28,\"redDot\":16,\"richManPOD\":34,\"saveData\":45,\"sceneMapPOD\":38,\"serverParams\":33,\"signPOD\":13,\"talentPOD\":27,\"taskCompleteTime\":25,\"tasks\":6,\"unlockFuncs\":9,\"unlockTasks\":10,\"warehouse\":4,\"worldBossDups\":40},\"PlayerPlatformDataPOD\":{\"attMap\":2,\"platformName\":1},\"PlayerSimplePOD\":{\"guid\":8,\"headIcon\":4,\"leaderCid\":3,\"pLv\":6,\"pName\":2,\"pid\":1,\"serverId\":7,\"vip\":5},\"PlotStageDupPOD\":{\"complete\":3,\"plotCid\":2,\"stageId\":1,\"storySaveData\":4},\"RandomDupPOD\":{\"cid\":2,\"dropId\":4,\"monsterTeamId\":5,\"smallId\":1,\"state\":3},\"RankSubsectionItemPOD\":{\"guildId\":4,\"percentRank\":2,\"pids\":3,\"score\":1},\"RankingPOD\":{\"avatarFrame\":11,\"customData\":9,\"guid\":5,\"headIcon\":6,\"heroSkin\":14,\"name\":2,\"pLv\":8,\"pid\":1,\"serverId\":12,\"title\":13,\"updateTime\":4,\"userData\":10,\"value\":3,\"vip\":7},\"RebatePOD\":{\"id\":1,\"items\":3,\"rebateMoney\":2},\"RechargeOrderPOD\":{\"amout\":1,\"isDouble\":3,\"isFirst\":2,\"productId\":4,\"time\":5},\"RichManPOD\":{\"richTime\":1},\"RoleInfoPOD\":{\"createTime\":5,\"guid\":4,\"lv\":3,\"pid\":1,\"pname\":2},\"SChatPOD\":{\"channel\":2,\"content\":5,\"sender\":1,\"target\":4,\"time\":6,\"type\":3},\"SceneMapActionPOD\":{\"cid\":1,\"compCid\":2,\"openCount\":5,\"schedule\":4,\"status\":3},\"SceneMapAreaPOD\":{\"cid\":1,\"currentRoomCid\":3,\"lastResetTime\":4,\"openCount\":5,\"status\":2},\"SceneMapCompPOD\":{\"cid\":1,\"openCount\":5,\"roomCid\":2,\"status\":3,\"vectorPOD\":4},\"SceneMapInfoPOD\":{\"todayAloneCount\":2,\"todayShoppingCount\":1},\"SceneMapPOD\":{\"actions\":5,\"areas\":2,\"comps\":4,\"currentAreaCid\":1,\"finishActions\":6,\"info\":8,\"rooms\":3,\"timeSpan\":7},\"SceneMapRoomPOD\":{\"areaCid\":2,\"cid\":1,\"currentPlot\":5,\"openCount\":6,\"skin\":4,\"status\":3},\"SceneMapRoomSkinPOD\":{\"id\":1,\"itemCid\":2,\"roomCid\":4,\"skinCid\":3},\"SeatPOD\":{\"effectId\":2,\"id\":3,\"seatId\":1,\"state\":4},\"SenroPOD\":{\"level\":1,\"senroTalents\":2},\"SenroTalentPOD\":{\"id\":1,\"level\":2},\"ShopItemPOD\":{\"buyLimit\":9,\"buyNum\":3,\"buyTime\":4,\"configId\":2,\"endTime\":8,\"isPop\":10,\"itemFreshTime\":5,\"position\":1,\"startTime\":7,\"useDouble\":6},\"ShopPOD\":{\"configId\":1,\"endTime\":4,\"itemList\":2,\"level\":5,\"openTime\":3},\"SignPOD\":{\"day\":1,\"state\":2},\"SimplePlayerPOD\":{\"areaId\":12,\"banSpeakEndTime\":14,\"createTime\":10,\"expendData\":19,\"frozenEndTime\":22,\"guid\":13,\"helpHeros\":17,\"heroSkin\":21,\"isOnline\":6,\"isRobot\":7,\"lastLoginTime\":8,\"lastLogoutTime\":9,\"lv\":3,\"maxHeroLv\":16,\"pid\":2,\"pname\":4,\"registerIp\":15,\"sdkName\":18,\"serverId\":11,\"showHeroCid\":5,\"transactionId\":20,\"uid\":1},\"SkillPOD\":{\"exp\":4,\"extLv\":11,\"heroCid\":5,\"heroPos\":6,\"id\":1,\"itemCid\":2,\"lock\":9,\"lv\":7,\"purifyLv\":10,\"skillCid\":3,\"strengLv\":8},\"StageEventLinkPOD\":{\"buffs\":7,\"buyGoodsNum\":8,\"chooseEvent\":5,\"clientData\":10,\"curEventId\":6,\"eventLinkId\":1,\"eventLinkState\":3,\"eventLinkType\":14,\"freeFreshTime\":15,\"freshTime\":11,\"initEventId\":12,\"isMainPlot\":2,\"lastRoomId\":13,\"randomGoodsIds\":9,\"stageEvents\":4},\"StageEventPOD\":{\"eventId\":1,\"eventState\":2,\"storyBattleId\":3},\"StageMapPOD\":{\"entrance\":3,\"eventLinkPod\":5,\"roomId\":1,\"roomType\":7,\"roomids\":4,\"sceneId\":2,\"state\":6},\"StorySaveDataPOD\":{\"clueIds\":3,\"completedStoryBattleIds\":5,\"currentSceneID\":1,\"extension\":7,\"npcVariables\":4,\"position\":2,\"tempWarehouse\":6},\"StoryVariablePOD\":{\"varibaleValues\":1},\"SubAttrPOD\":{\"attrId\":1,\"attrType\":3,\"attrValue\":4,\"equipLevel\":2},\"SupplyPOD\":{\"map\":1},\"TalentPOD\":{\"resetTalentCount\":1,\"resetTimeCd\":2,\"talents\":3},\"TaskPOD\":{\"cid\":1,\"completeTime\":5,\"count\":6,\"schedule\":3,\"status\":4,\"type\":2},\"TempItemPOD\":{\"cid\":2,\"id\":1,\"num\":3,\"tag\":4},\"TreasureHuntPOD\":{\"awards\":1},\"TriggerActionPOD\":{\"drawLots\":2,\"shows\":1},\"UpdateLabyrinthHeroPOD\":{\"attr\":2,\"hcid\":1},\"UseItemPOD\":{\"id\":1,\"num\":2,\"selectIndex\":3},\"VectorPOD\":{\"x\":1,\"y\":2,\"z\":3},\"WorldBossDupPOD\":{\"cid\":1,\"passStatus\":2}}"
namePodTypes = "{\"AchieveShowPOD\":{\"cid\":\"int\",\"layerId\":\"int\",\"x\":\"float\",\"y\":\"float\",\"z\":\"float\"},\"ActivityChapterPOD\":{\"chapterId\":\"int\",\"endTime\":\"long\",\"passStar\":\"map<int|ConditionFinishPOD>\",\"starState\":\"map<int|bool>\",\"startTime\":\"long\"},\"ActivityPOD\":{\"activityRecharge\":\"ActivityRechargePOD\",\"cid\":\"int\",\"closeDateTime\":\"long\",\"dupDropPOD\":\"DupDropPOD\",\"ghostPOD\":\"GhostPOD\",\"openCount\":\"int\",\"openDateTime\":\"long\",\"stage\":\"int\",\"stageDateTime\":\"long\",\"supplyPOD\":\"SupplyPOD\",\"treasureHuntPOD\":\"TreasureHuntPOD\",\"version\":\"int\"},\"ActivityRechargePOD\":{\"getRewardsList\":\"list<int>\",\"totalRecharge\":\"int\"},\"AttackUnitPOD\":{\"UUID\":\"string\",\"addFavorExp\":\"int\",\"addFavorLv\":\"int\",\"heroLv\":\"int\",\"iconSkin\":\"int\",\"injury\":\"int\",\"order\":\"int\",\"pid\":\"string\",\"pos\":\"int\",\"record\":\"int\",\"remedy\":\"int\",\"serverId\":\"string\",\"type\":\"int\",\"val\":\"int\"},\"AttrColonePOD\":{\"attr\":\"list<double>\"},\"BlackMarketPOD\":{\"level\":\"int\"},\"BossDupPOD\":{\"cid\":\"int\",\"optimalIntegral\":\"int\",\"passStatus\":\"map<int|int>\",\"powerTime\":\"int\",\"prizeTime\":\"int\",\"totalIntegral\":\"int\"},\"BuffPOD\":{\"buffs\":\"list<int>\"},\"CChatPOD\":{\"channel\":\"int\",\"content\":\"string\",\"target\":\"string\",\"type\":\"int\"},\"CenterLoadPlayerPOD\":{\"chatRoomId\":\"int\",\"friends\":\"list<FriendPOD>\"},\"ChallengeDupPOD\":{\"cid\":\"int\",\"state\":\"bool\"},\"ChooseListPOD\":{\"eventIds\":\"list<int>\"},\"CleanItemPOD\":{\"cleanTime\":\"long\",\"id\":\"int\"},\"ClientDataPOD\":{\"clientData\":\"map<int|int>\"},\"ClimbTowerDupPOD\":{\"cid\":\"int\",\"dailyStatus\":\"map<int|long>\",\"passStatus\":\"map<int|int>\"},\"CluePOD\":{\"clueId\":\"int\",\"completeState\":\"bool\",\"porgress\":\"list<int>\"},\"ConditionFinishPOD\":{\"conditionIds\":\"list<int>\"},\"CrusadeDupPOD\":{\"crusadeCid\":\"int\",\"endTime\":\"int\",\"index\":\"int\",\"state\":\"int\"},\"DailyDupPOD\":{\"cid\":\"int\",\"costFree\":\"int\",\"extraReward\":\"int\",\"passStatus\":\"map<int|int>\"},\"DispTaskPOD\":{\"cid\":\"int\",\"executeTime\":\"int\",\"heroCids\":\"list<int>\",\"status\":\"int\"},\"DrawData\":{\"activityId\":\"int\",\"confirmTime\":\"long\",\"currentItems\":\"list<DrawDataPOD>\",\"dayFreeTime\":\"int\",\"drawGroup\":\"list<int>\",\"drawTime\":\"int\",\"endTime\":\"long\",\"historyItems\":\"list<DrawDataPOD>\",\"id\":\"int\",\"isFree\":\"bool\",\"lastGuaranteed\":\"bool\",\"mustDrawTime\":\"int\",\"startTime\":\"long\",\"sumFreeTime\":\"int\"},\"DrawDataPOD\":{\"cid\":\"int\",\"num\":\"int\",\"order\":\"int\",\"srcId\":\"int\"},\"DrawItemPOD\":{\"cardCid\":\"int\",\"drawStarTime\":\"int\",\"drawUpTime\":\"int\",\"group\":\"int\",\"id\":\"long\",\"itemId\":\"int\",\"itemNum\":\"int\",\"type\":\"int\",\"upFlag\":\"bool\"},\"DrawLotsPOD\":{\"cid\":\"int\"},\"DrawPOD\":{\"activityId\":\"int\",\"confirmTime\":\"long\",\"currentItems\":\"list<DrawResultPOD>\",\"dayFreeTime\":\"int\",\"drawTime\":\"int\",\"endTime\":\"long\",\"historyItems\":\"list<DrawResultPOD>\",\"id\":\"int\",\"isFree\":\"bool\",\"mustDrawTime\":\"int\",\"mustGuarantee\":\"int\",\"openTime\":\"long\",\"sumFreeTime\":\"int\"},\"DrawRecordPOD\":{\"id\":\"long\",\"itemId\":\"int\",\"order\":\"int\",\"rollTime\":\"long\"},\"DrawResultListPOD\":{\"drawResults\":\"list<DrawResultPOD>\",\"sumTokens\":\"list<ItemShowPOD>\"},\"DrawResultPOD\":{\"drawStarTime\":\"int\",\"drawUpTime\":\"int\",\"itemShowPODs\":\"list<ItemShowPOD>\",\"srcId\":\"int\",\"tokens\":\"list<ItemShowPOD>\"},\"DupDropPOD\":{\"dayNum\":\"int\",\"sumNum\":\"int\"},\"EntryPOD\":{\"map\":\"map<int|int>\"},\"EquipDupPOD\":{\"cid\":\"int\",\"passStatus\":\"map<int|int>\"},\"EquipPOD\":{\"equipCid\":\"int\",\"exp\":\"int\",\"heroCid\":\"int\",\"id\":\"long\",\"itemCid\":\"int\",\"lock\":\"bool\",\"lv\":\"int\",\"masterAttrs\":\"map<int|double>\",\"slaverAttrs\":\"list<SubAttrPOD>\"},\"EventPOD\":{\"eventId\":\"int\",\"id\":\"int\",\"type\":\"int\"},\"ExtensionPOD\":{\"clear\":\"bool\",\"eventIds\":\"list<EventPOD>\",\"value\":\"int\"},\"FavorMsgGroupPOD\":{\"cid\":\"int\",\"entrys\":\"list<int>\"},\"FavorPOD\":{\"favorMsgGroups\":\"map<int|FavorMsgGroupPOD>\"},\"FightOverPOD\":{\"allConditionIds\":\"list<int>\",\"awards\":\"list<ItemShowPOD>\",\"everyTimeAwards\":\"list<ItemShowPODS>\",\"fightIntegral\":\"int\",\"fightResult\":\"int\",\"finishConditionIds\":\"list<int>\",\"returnExpend\":\"map<int|int>\",\"triggerBuffs\":\"map<int|GlobalBuffPOD>\",\"type\":\"int\",\"units\":\"list<AttackUnitPOD>\"},\"FightPOD\":{\"Attacker\":\"FightTroopPOD\",\"BattleParams\":\"map<int|int>\",\"BattleType\":\"int\",\"CurrentBigRound\":\"int\",\"Defender\":\"FightTroopPOD\",\"ID\":\"string\",\"MapID\":\"int\",\"MaxBigRound\":\"int\",\"MaxRound\":\"int\",\"MonsterTeamID\":\"int\",\"Players\":\"list<string>\",\"RandomSeed\":\"long\"},\"FightSkillPOD\":{\"PurifyLv\":\"int\",\"SkillId\":\"int\",\"SkillLv\":\"int\",\"SkinId\":\"int\",\"StrengLv\":\"int\"},\"FightTroopPOD\":{\"ArrFightUnitPOD\":\"list<FightUnitPOD>\",\"Buffs\":\"list<int>\",\"Pid\":\"string\",\"SkillStrengthens\":\"list<int>\",\"Skills\":\"list<FightSkillPOD>\",\"Terrains\":\"list<int>\"},\"FightUnitPOD\":{\"AIType\":\"int\",\"Attributes\":\"list<double>\",\"BaseAttrs\":\"list<double>\",\"BattlePos\":\"int\",\"HeroCid\":\"int\",\"HeroSkinId\":\"int\",\"InitBuff\":\"list<int>\",\"IsHelper\":\"bool\",\"Level\":\"int\",\"MonsterCfgId\":\"int\",\"Order\":\"int\",\"Pid\":\"string\",\"Power\":\"int\",\"SPStatus\":\"list<bool>\",\"SkillStrengthens\":\"list<int>\",\"Skills\":\"list<FightSkillPOD>\",\"TroopType\":\"int\",\"UUID\":\"string\"},\"FormationPOD\":{\"agentSkill\":\"map<long|int>\",\"attackOrder\":\"map<int|int>\",\"cid\":\"int\",\"helpHeros\":\"map<int|HelpHeroPOD>\",\"heros\":\"map<int|int>\",\"name\":\"string\",\"presetHcid\":\"map<int|int>\",\"sync\":\"bool\"},\"FriendPOD\":{\"createTime\":\"int\",\"guid\":\"int\",\"helpHeros\":\"map<int|HelpHeroPOD>\",\"heroSkin\":\"HeroSkinPOD\",\"id\":\"long\",\"lastLoginTime\":\"int\",\"online\":\"bool\",\"pId\":\"string\",\"pLv\":\"int\",\"pName\":\"string\",\"remark\":\"string\",\"serverId\":\"string\",\"showHeroCid\":\"int\",\"type\":\"int\"},\"GhostPOD\":{\"todayCount\":\"int\"},\"GlobalBuffPOD\":{\"StackCount\":\"int\",\"buffCid\":\"int\",\"createTime\":\"long\",\"status\":\"int\",\"triggerCount\":\"int\"},\"GmMailPOD\":{\"channelIds\":\"string\",\"content\":\"string\",\"createTime\":\"long\",\"effectiveTime\":\"long\",\"expireTime\":\"long\",\"extJson\":\"string\",\"id\":\"string\",\"isAllPlayer\":\"bool\",\"isAllTime\":\"bool\",\"itemList\":\"list<int>\",\"levelLimit\":\"int\",\"registerTime\":\"long\",\"sender\":\"string\",\"target\":\"list<string>\",\"title\":\"string\"},\"GroupDrawPOD\":{\"drawDatas\":\"list<DrawData>\",\"drawRecords\":\"list<DrawRecordPOD>\",\"drawUp\":\"int\",\"groupId\":\"int\",\"guaranteedTime\":\"int\",\"orderId\":\"long\",\"tenTime\":\"int\"},\"HelpHeroPOD\":{\"hero\":\"HeroPOD\",\"pid\":\"string\",\"pname\":\"string\",\"serverId\":\"string\"},\"HeroConverterPOD\":{\"srcId\":\"int\",\"targetId\":\"int\"},\"HeroPOD\":{\"aiType\":\"int\",\"attr\":\"list<double>\",\"baseAttr\":\"map<int|double>\",\"breakLv\":\"int\",\"breakPrize\":\"list<int>\",\"buffs\":\"list<int>\",\"cid\":\"int\",\"curCartoon\":\"string\",\"curSpine\":\"string\",\"equip\":\"map<int|EquipPOD>\",\"exp\":\"int\",\"favor\":\"FavorPOD\",\"favorabilityExp\":\"int\",\"favorabilityLevel\":\"int\",\"favorableDups\":\"map<int|int>\",\"flag\":\"bool\",\"globalBuffs\":\"map<int|GlobalBuffPOD>\",\"heroSkin\":\"HeroSkinPOD\",\"id\":\"long\",\"lv\":\"int\",\"personality\":\"list<int>\",\"proportion\":\"float\",\"showXPos\":\"int\",\"showYPos\":\"int\",\"skill\":\"map<int|SkillPOD>\",\"starLevel\":\"int\",\"starTime\":\"int\",\"strengthens\":\"list<int>\"},\"HeroSkinPOD\":{\"heroCid\":\"int\",\"id\":\"long\",\"itemCid\":\"int\",\"skinCid\":\"int\"},\"HomePOD\":{\"dispRefreshTaskCount\":\"int\",\"lv\":\"int\",\"task\":\"map<int|DispTaskPOD>\",\"workHeros\":\"map<int|int>\"},\"ItemPOD\":{\"cid\":\"int\",\"createTime\":\"int\",\"equip\":\"EquipPOD\",\"flag\":\"bool\",\"heroSkin\":\"HeroSkinPOD\",\"id\":\"long\",\"num\":\"int\",\"sceneMapRoomSkinPOD\":\"SceneMapRoomSkinPOD\",\"skill\":\"SkillPOD\",\"usedNum\":\"int\"},\"ItemShowPOD\":{\"cid\":\"int\",\"id\":\"long\",\"num\":\"int\",\"srcId\":\"int\",\"tag\":\"int\"},\"ItemShowPODS\":{\"awards\":\"list<ItemShowPOD>\"},\"ItemUseRecordPOD\":{\"itemCid\":\"int\",\"useTime\":\"int\"},\"KanBanPOD\":{\"kanBanId\":\"int\",\"kanbanPool\":\"list<int>\",\"randomKanban\":\"bool\"},\"LabyrinthDataPOD\":{\"animation\":\"bool\",\"blackMarketPOD\":\"BlackMarketPOD\",\"curDifficulty\":\"int\",\"diffcultyTime\":\"map<int|int>\",\"endTime\":\"long\",\"eventLinkTimes\":\"map<int|int>\",\"eventTypes\":\"map<int|int>\",\"exploreTime\":\"int\",\"firstTalent\":\"bool\",\"guaranteedTime\":\"map<int|int>\",\"killMonsterTime\":\"map<int|int>\",\"labyrinthStagePODs\":\"map<int|LabyrinthStagePOD>\",\"labyrinthWarehouse\":\"map<int|int>\",\"lastPoolId\":\"map<int|int>\",\"memoryEvent\":\"map<int|MemoryEventPOD>\",\"nextRestoreTime\":\"long\",\"preHeros\":\"map<int|int>\",\"replaceHeros\":\"list<int>\",\"seasonId\":\"int\",\"senroPOD\":\"SenroPOD\",\"startTime\":\"long\",\"state\":\"bool\",\"useItemMap\":\"map<int|int>\"},\"LabyrinthStagePOD\":{\"buffFreshTime\":\"int\",\"buffs\":\"list<int>\",\"curMainRoomId\":\"int\",\"curRoomId\":\"int\",\"difficulty\":\"int\",\"endTime\":\"long\",\"eventLinkTimes\":\"map<int|int>\",\"eventTypes\":\"map<int|int>\",\"exploreFlg\":\"int\",\"formationPOD\":\"FormationPOD\",\"heroAttrClone\":\"map<int|AttrColonePOD>\",\"heros\":\"map<int|HeroPOD>\",\"mapBuffs\":\"map<int|BuffPOD>\",\"monsterTypes\":\"list<int>\",\"poolId\":\"int\",\"settlementFlg\":\"bool\",\"stageMapPODs\":\"map<int|StageMapPOD>\",\"stageWarehouse\":\"map<int|int>\",\"startTime\":\"long\"},\"LittleInformationPOD\":{\"state\":\"int\",\"x\":\"float\",\"y\":\"float\",\"z\":\"float\"},\"MailPOD\":{\"cid\":\"int\",\"content\":\"string\",\"createTime\":\"int\",\"expireTime\":\"int\",\"id\":\"long\",\"isHasItem\":\"bool\",\"isRead\":\"bool\",\"itemList\":\"list<ItemShowPOD>\",\"sender\":\"string\",\"title\":\"string\"},\"MapItemDataPOD\":{\"stageId\":\"int\"},\"MapItemPOD\":{\"mapItemDataPod\":\"MapItemDataPOD\",\"mapItemId\":\"int\",\"mapSmallId\":\"int\"},\"MapSmallPOD\":{\"mapItems\":\"list<MapItemPOD>\"},\"MazeDupPOD\":{\"mazeStages\":\"map<int|MazeStagePOD>\",\"orbmentPOD\":\"OrbmentPOD\"},\"MazeStagePOD\":{\"baseAttrClone\":\"map<int|AttrColonePOD>\",\"beforeProgress\":\"int\",\"endTime\":\"long\",\"fightExtraReward\":\"map<int|int>\",\"formationPOD\":\"FormationPOD\",\"heros\":\"map<int|HeroPOD>\",\"mazeId\":\"int\",\"orbmentPOD\":\"OrbmentPOD\",\"progress\":\"int\",\"progressIds\":\"list<int>\",\"startTime\":\"long\",\"state\":\"int\",\"teamBuff\":\"list<int>\"},\"MemoryEventPOD\":{\"events\":\"list<int>\"},\"ModleStatePOD\":{\"endTime\":\"long\",\"funcType\":\"int\",\"reason\":\"string\",\"state\":\"int\"},\"MonthCardPOD\":{\"endTime\":\"long\",\"monthPrzieState\":\"bool\",\"startTime\":\"long\"},\"OrbmentPOD\":{\"attr\":\"map<int|double>\",\"dropRate\":\"int\",\"fightBuffId\":\"list<int>\",\"gemstoneLimit\":\"int\",\"ids\":\"list<int>\",\"seats\":\"map<int|SeatPOD>\"},\"PassPOD\":{\"openTime\":\"long\",\"passExp\":\"int\",\"passLevel\":\"int\",\"state\":\"bool\",\"vipExp\":\"int\"},\"PlayerBaseInfoPOD\":{\"achieveShow\":\"list<AchieveShowPOD>\",\"birthday\":\"string\",\"changeNameCount\":\"int\",\"changeNameTime\":\"int\",\"createTime\":\"int\",\"currentTrackTaskCid\":\"int\",\"effectIds\":\"list<int>\",\"exp\":\"int\",\"guid\":\"int\",\"helpHeros\":\"map<int|HelpHeroPOD>\",\"heroSkin\":\"HeroSkinPOD\",\"intro\":\"string\",\"kanBanPOD\":\"KanBanPOD\",\"littleInformationPOD\":\"LittleInformationPOD\",\"loginFlag\":\"bool\",\"monthResetTime\":\"long\",\"openId\":\"string\",\"pLv\":\"int\",\"pName\":\"string\",\"pid\":\"string\",\"questionnaires\":\"map<int|int>\",\"rebate\":\"RebatePOD\",\"restoreTime\":\"int\",\"sdkName\":\"string\",\"serverId\":\"string\",\"sex\":\"int\",\"showHeroCid\":\"int\",\"todayResetTime\":\"long\",\"totalLoginDay\":\"int\",\"uid\":\"string\",\"unlockOpera\":\"list<int>\",\"weekResetTime\":\"long\"},\"PlayerPKGPOD\":{\"achieveShow\":\"list<AchieveShowPOD>\",\"activeRecord\":\"map<long|string>\",\"antiAddictionAccTime\":\"int\",\"changeNameCount\":\"int\",\"changeNameTime\":\"long\",\"cleanItems\":\"map<int|CleanItemPOD>\",\"combination\":\"map<int|int>\",\"commodityBuyRecords\":\"map<int|int>\",\"crusadeTime\":\"int\",\"currentGuide\":\"map<int|int>\",\"currentTrackTaskCid\":\"int\",\"dailyMonthCardReceive\":\"list<int>\",\"dailyResetTime\":\"long\",\"drawCount\":\"int\",\"drawShowGroupRecords\":\"map<int|int>\",\"effectIds\":\"list<int>\",\"eventFreshTime\":\"long\",\"finishFavorMsgGroups\":\"map<int|int>\",\"finishGuide\":\"map<int|int>\",\"finishRechargeOrder\":\"map<string|RechargeOrderPOD>\",\"finishTasks\":\"map<int|int>\",\"generalDup\":\"map<int|int>\",\"globalBuffs\":\"map<int|GlobalBuffPOD>\",\"helpHeros\":\"map<int|int>\",\"isDouble\":\"bool\",\"isFirst\":\"bool\",\"itemAddCounts\":\"map<int|int>\",\"itemDropGetCnts\":\"map<int|int>\",\"itemTakeCounts\":\"map<int|int>\",\"kanBanPOD\":\"KanBanPOD\",\"limitedTimePkg\":\"map<int|int>\",\"littleInfomation\":\"LittleInformationPOD\",\"loginFlag\":\"bool\",\"lucky\":\"int\",\"monthCard\":\"map<int|long>\",\"onlineTime\":\"int\",\"questionnaires\":\"map<int|int>\",\"receiveGmMails\":\"list<string>\",\"resetTalentCount\":\"int\",\"restoreTime\":\"int\",\"robotVersion\":\"int\",\"saveData\":\"map<string|string>\",\"talents\":\"map<int|int>\",\"taskCompleteTime\":\"map<int|long>\",\"times\":\"map<int|long>\",\"total_login_cnt\":\"int\",\"total_login_day\":\"int\",\"total_online_time\":\"long\",\"unlockFunc\":\"map<int|ModleStatePOD>\",\"unlockOperaID\":\"list<int>\"},\"PlayerPOD\":{\"activityDups\":\"map<int|ActivityChapterPOD>\",\"activitys\":\"map<int|ActivityPOD>\",\"baseInfo\":\"PlayerBaseInfoPOD\",\"bossDups\":\"map<int|BossDupPOD>\",\"challengeDups\":\"map<int|ChallengeDupPOD>\",\"chatRoomId\":\"int\",\"climbTowerDups\":\"map<int|ClimbTowerDupPOD>\",\"commodityBuyRecords\":\"map<int|int>\",\"crusadeDupPODs\":\"map<int|CrusadeDupPOD>\",\"currentGuide\":\"map<int|int>\",\"dailyDups\":\"map<int|DailyDupPOD>\",\"drawPODs\":\"map<int|DrawPOD>\",\"drawShowGroupRecords\":\"map<int|int>\",\"equipDups\":\"map<int|EquipDupPOD>\",\"finishGuide\":\"map<int|int>\",\"finishMsgGroups\":\"map<int|int>\",\"finishTasks\":\"map<int|int>\",\"formations\":\"map<int|FormationPOD>\",\"friends\":\"list<FriendPOD>\",\"generalDups\":\"map<int|int>\",\"globalBuffPODs\":\"map<int|GlobalBuffPOD>\",\"heros\":\"map<int|HeroPOD>\",\"home\":\"HomePOD\",\"labyrinthStagePOD\":\"LabyrinthDataPOD\",\"limitedTimePkg\":\"map<int|int>\",\"mazeDupPOD\":\"MazeDupPOD\",\"monthCard\":\"map<int|long>\",\"monthCardPOD\":\"MonthCardPOD\",\"newMailCount\":\"int\",\"passPOD\":\"PassPOD\",\"plotStageDupPOD\":\"map<int|PlotStageDupPOD>\",\"randomDups\":\"map<int|RandomDupPOD>\",\"redDot\":\"map<int|int>\",\"richManPOD\":\"RichManPOD\",\"saveData\":\"map<string|string>\",\"sceneMapPOD\":\"SceneMapPOD\",\"serverParams\":\"map<string|string>\",\"signPOD\":\"SignPOD\",\"talentPOD\":\"TalentPOD\",\"taskCompleteTime\":\"map<int|long>\",\"tasks\":\"map<int|TaskPOD>\",\"unlockFuncs\":\"map<int|ModleStatePOD>\",\"unlockTasks\":\"map<int|int>\",\"warehouse\":\"list<ItemPOD>\",\"worldBossDups\":\"map<int|WorldBossDupPOD>\"},\"PlayerPlatformDataPOD\":{\"attMap\":\"map<string|string>\",\"platformName\":\"string\"},\"PlayerSimplePOD\":{\"guid\":\"int\",\"headIcon\":\"int\",\"leaderCid\":\"int\",\"pLv\":\"int\",\"pName\":\"string\",\"pid\":\"string\",\"serverId\":\"string\",\"vip\":\"int\"},\"PlotStageDupPOD\":{\"complete\":\"int\",\"plotCid\":\"int\",\"stageId\":\"int\",\"storySaveData\":\"StorySaveDataPOD\"},\"RandomDupPOD\":{\"cid\":\"int\",\"dropId\":\"int\",\"monsterTeamId\":\"int\",\"smallId\":\"int\",\"state\":\"bool\"},\"RankSubsectionItemPOD\":{\"guildId\":\"string\",\"percentRank\":\"int\",\"pids\":\"list<string>\",\"score\":\"long\"},\"RankingPOD\":{\"avatarFrame\":\"int\",\"customData\":\"string\",\"guid\":\"int\",\"headIcon\":\"int\",\"heroSkin\":\"HeroSkinPOD\",\"name\":\"string\",\"pLv\":\"int\",\"pid\":\"string\",\"serverId\":\"string\",\"title\":\"int\",\"updateTime\":\"int\",\"userData\":\"string\",\"value\":\"long\",\"vip\":\"int\"},\"RebatePOD\":{\"id\":\"long\",\"items\":\"map<int|int>\",\"rebateMoney\":\"string\"},\"RechargeOrderPOD\":{\"amout\":\"int\",\"isDouble\":\"bool\",\"isFirst\":\"bool\",\"productId\":\"int\",\"time\":\"int\"},\"RichManPOD\":{\"richTime\":\"int\"},\"RoleInfoPOD\":{\"createTime\":\"int\",\"guid\":\"int\",\"lv\":\"int\",\"pid\":\"string\",\"pname\":\"string\"},\"SChatPOD\":{\"channel\":\"int\",\"content\":\"string\",\"sender\":\"PlayerSimplePOD\",\"target\":\"string\",\"time\":\"int\",\"type\":\"int\"},\"SceneMapActionPOD\":{\"cid\":\"int\",\"compCid\":\"int\",\"openCount\":\"int\",\"schedule\":\"int\",\"status\":\"int\"},\"SceneMapAreaPOD\":{\"cid\":\"int\",\"currentRoomCid\":\"int\",\"lastResetTime\":\"int\",\"openCount\":\"int\",\"status\":\"int\"},\"SceneMapCompPOD\":{\"cid\":\"int\",\"openCount\":\"int\",\"roomCid\":\"int\",\"status\":\"int\",\"vectorPOD\":\"VectorPOD\"},\"SceneMapInfoPOD\":{\"todayAloneCount\":\"int\",\"todayShoppingCount\":\"int\"},\"SceneMapPOD\":{\"actions\":\"map<int|SceneMapActionPOD>\",\"areas\":\"map<int|SceneMapAreaPOD>\",\"comps\":\"map<int|SceneMapCompPOD>\",\"currentAreaCid\":\"int\",\"finishActions\":\"map<int|int>\",\"info\":\"SceneMapInfoPOD\",\"rooms\":\"map<int|SceneMapRoomPOD>\",\"timeSpan\":\"int\"},\"SceneMapRoomPOD\":{\"areaCid\":\"int\",\"cid\":\"int\",\"currentPlot\":\"int\",\"openCount\":\"int\",\"skin\":\"SceneMapRoomSkinPOD\",\"status\":\"int\"},\"SceneMapRoomSkinPOD\":{\"id\":\"long\",\"itemCid\":\"int\",\"roomCid\":\"int\",\"skinCid\":\"int\"},\"SeatPOD\":{\"effectId\":\"int\",\"id\":\"long\",\"seatId\":\"int\",\"state\":\"bool\"},\"SenroPOD\":{\"level\":\"int\",\"senroTalents\":\"map<int|SenroTalentPOD>\"},\"SenroTalentPOD\":{\"id\":\"int\",\"level\":\"int\"},\"ShopItemPOD\":{\"buyLimit\":\"int\",\"buyNum\":\"int\",\"buyTime\":\"long\",\"configId\":\"int\",\"endTime\":\"long\",\"isPop\":\"bool\",\"itemFreshTime\":\"long\",\"position\":\"int\",\"startTime\":\"long\",\"useDouble\":\"bool\"},\"ShopPOD\":{\"configId\":\"int\",\"endTime\":\"long\",\"itemList\":\"list<ShopItemPOD>\",\"level\":\"int\",\"openTime\":\"long\"},\"SignPOD\":{\"day\":\"int\",\"state\":\"bool\"},\"SimplePlayerPOD\":{\"areaId\":\"string\",\"banSpeakEndTime\":\"long\",\"createTime\":\"long\",\"expendData\":\"map<string|string>\",\"frozenEndTime\":\"long\",\"guid\":\"int\",\"helpHeros\":\"map<int|HelpHeroPOD>\",\"heroSkin\":\"HeroSkinPOD\",\"isOnline\":\"bool\",\"isRobot\":\"bool\",\"lastLoginTime\":\"long\",\"lastLogoutTime\":\"long\",\"lv\":\"int\",\"maxHeroLv\":\"int\",\"pid\":\"string\",\"pname\":\"string\",\"registerIp\":\"string\",\"sdkName\":\"string\",\"serverId\":\"string\",\"showHeroCid\":\"int\",\"transactionId\":\"string\",\"uid\":\"string\"},\"SkillPOD\":{\"exp\":\"int\",\"extLv\":\"int\",\"heroCid\":\"int\",\"heroPos\":\"int\",\"id\":\"long\",\"itemCid\":\"int\",\"lock\":\"bool\",\"lv\":\"int\",\"purifyLv\":\"int\",\"skillCid\":\"int\",\"strengLv\":\"int\"},\"StageEventLinkPOD\":{\"buffs\":\"list<int>\",\"buyGoodsNum\":\"map<int|int>\",\"chooseEvent\":\"map<int|ChooseListPOD>\",\"clientData\":\"map<int|ClientDataPOD>\",\"curEventId\":\"int\",\"eventLinkId\":\"int\",\"eventLinkState\":\"bool\",\"eventLinkType\":\"int\",\"freeFreshTime\":\"int\",\"freshTime\":\"int\",\"initEventId\":\"int\",\"isMainPlot\":\"bool\",\"lastRoomId\":\"int\",\"randomGoodsIds\":\"list<int>\",\"stageEvents\":\"map<int|StageEventPOD>\"},\"StageEventPOD\":{\"eventId\":\"int\",\"eventState\":\"bool\",\"storyBattleId\":\"int\"},\"StageMapPOD\":{\"entrance\":\"int\",\"eventLinkPod\":\"StageEventLinkPOD\",\"roomId\":\"int\",\"roomType\":\"int\",\"roomids\":\"map<int|int>\",\"sceneId\":\"int\",\"state\":\"bool\"},\"StorySaveDataPOD\":{\"clueIds\":\"list<int>\",\"completedStoryBattleIds\":\"list<int>\",\"currentSceneID\":\"int\",\"extension\":\"map<string|ExtensionPOD>\",\"npcVariables\":\"map<int|StoryVariablePOD>\",\"position\":\"VectorPOD\",\"tempWarehouse\":\"map<long|TempItemPOD>\"},\"StoryVariablePOD\":{\"varibaleValues\":\"map<string|string>\"},\"SubAttrPOD\":{\"attrId\":\"int\",\"attrType\":\"int\",\"attrValue\":\"double\",\"equipLevel\":\"int\"},\"SupplyPOD\":{\"map\":\"map<int|int>\"},\"TalentPOD\":{\"resetTalentCount\":\"int\",\"resetTimeCd\":\"int\",\"talents\":\"map<int|int>\"},\"TaskPOD\":{\"cid\":\"int\",\"completeTime\":\"long\",\"count\":\"int\",\"schedule\":\"int\",\"status\":\"int\",\"type\":\"int\"},\"TempItemPOD\":{\"cid\":\"int\",\"id\":\"long\",\"num\":\"int\",\"tag\":\"int\"},\"TreasureHuntPOD\":{\"awards\":\"list<int>\"},\"TriggerActionPOD\":{\"drawLots\":\"DrawLotsPOD\",\"shows\":\"list<ItemShowPOD>\"},\"UpdateLabyrinthHeroPOD\":{\"attr\":\"map<int|int>\",\"hcid\":\"int\"},\"UseItemPOD\":{\"id\":\"long\",\"num\":\"int\",\"selectIndex\":\"int\"},\"VectorPOD\":{\"x\":\"float\",\"y\":\"float\",\"z\":\"float\"},\"WorldBossDupPOD\":{\"cid\":\"int\",\"passStatus\":\"map<int|int>\"}}"

LuaCodeInterface.InitSnet(msgIdMethodName, msgIdMethodTypes, namePodSerialId, namePodTypes)

net_structs = {}
net_gameToCenter = {}

function net_gameToCenter.registerSimplePlayer(sessionId, simplePlayerPOD, platformData)
	local success = LuaCodeInterface.Send(102, sessionId, simplePlayerPOD, platformData)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_gameToCenter.changePlayerData(pid, data)
	local success = LuaCodeInterface.Send(103, pid, data)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_gameToCenter.loadPlayer(pid, platformData)
	local success = LuaCodeInterface.Send(104, pid, platformData)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_gameToCenter.reloadPlayer(pid)
	local success = LuaCodeInterface.Send(105, pid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_gameToCenter.offline(pid)
	local success = LuaCodeInterface.Send(106, pid)
end

function net_gameToCenter.heartbeat(serverId)
	local success = LuaCodeInterface.Send(107, serverId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_gameToCenter.uploadSimplePlayer(simplePlayerPOD, notityType)
	local success = LuaCodeInterface.Send(108, simplePlayerPOD, notityType)
end

function net_gameToCenter.registerSimplePlayerResult(code, sessionId, simplePlayerPOD)
	warning("please override this function -> net_gameToCenter.registerSimplePlayerResult!")
end

function net_gameToCenter.registerSimplePlayerResult_delegate(code, sessionId, simplePlayerPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_gameToCenter.registerSimplePlayerResult(code, sessionId, simplePlayerPOD)
end

function net_gameToCenter.changePlayerDataResult(code, pid, data)
	warning("please override this function -> net_gameToCenter.changePlayerDataResult!")
end

function net_gameToCenter.changePlayerDataResult_delegate(code, pid, data)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_gameToCenter.changePlayerDataResult(code, pid, data)
end

function net_gameToCenter.loadPlayerResult(code, pid, centerLoadPlayerPOD)
	warning("please override this function -> net_gameToCenter.loadPlayerResult!")
end

function net_gameToCenter.loadPlayerResult_delegate(code, pid, centerLoadPlayerPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_gameToCenter.loadPlayerResult(code, pid, centerLoadPlayerPOD)
end

function net_gameToCenter.reloadPlayerResult(code, pid, centerLoadPlayerPOD)
	warning("please override this function -> net_gameToCenter.reloadPlayerResult!")
end

function net_gameToCenter.reloadPlayerResult_delegate(code, pid, centerLoadPlayerPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_gameToCenter.reloadPlayerResult(code, pid, centerLoadPlayerPOD)
end

function net_gameToCenter.heartbeatResult(code, needReconnect)
	warning("please override this function -> net_gameToCenter.heartbeatResult!")
end

function net_gameToCenter.heartbeatResult_delegate(code, needReconnect)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_gameToCenter.heartbeatResult(code, needReconnect)
end

function net_gameToCenter.notifyCentralStart()
	warning("please override this function -> net_gameToCenter.notifyCentralStart!")
end

function net_gameToCenter.notifyCentralStart_delegate()
	net_gameToCenter.notifyCentralStart()
end

function net_gameToCenter.notifyCentralStop()
	warning("please override this function -> net_gameToCenter.notifyCentralStop!")
end

function net_gameToCenter.notifyCentralStop_delegate()
	net_gameToCenter.notifyCentralStop()
end

function net_gameToCenter.notifyExecCmd(pid, cmd)
	warning("please override this function -> net_gameToCenter.notifyExecCmd!")
end

function net_gameToCenter.notifyExecCmd_delegate(pid, cmd)
	net_gameToCenter.notifyExecCmd(pid, cmd)
end

function net_gameToCenter.notifyTopicChat(chat, pids, all)
	warning("please override this function -> net_gameToCenter.notifyTopicChat!")
end

function net_gameToCenter.notifyTopicChat_delegate(chat, pids, all)
	net_gameToCenter.notifyTopicChat(chat, pids, all)
end

function net_gameToCenter.notifyGmMail(gmMail)
	warning("please override this function -> net_gameToCenter.notifyGmMail!")
end

function net_gameToCenter.notifyGmMail_delegate(gmMail)
	net_gameToCenter.notifyGmMail(gmMail)
end

function net_gameToCenter.uploadRankScore(rankId, pid, score, customData, userData)
	local success = LuaCodeInterface.Send(119, rankId, pid, score, customData, userData)
end

function net_gameToCenter.notifyRankRewards(rankId, fixRankPids, rankSubsectionItems)
	warning("please override this function -> net_gameToCenter.notifyRankRewards!")
end

function net_gameToCenter.notifyRankRewards_delegate(rankId, fixRankPids, rankSubsectionItems)
	net_gameToCenter.notifyRankRewards(rankId, fixRankPids, rankSubsectionItems)
end

function net_gameToCenter.notifyActivitys(activitys)
	warning("please override this function -> net_gameToCenter.notifyActivitys!")
end

function net_gameToCenter.notifyActivitys_delegate(activitys)
	net_gameToCenter.notifyActivitys(activitys)
end

net_gameToGame = {}

function net_gameToGame.openHomeBox(name, pid, boxCid)
	local success = LuaCodeInterface.Send(202, name, pid, boxCid)
end

function net_gameToGame.helpHome(name, pid, target)
	local success = LuaCodeInterface.Send(203, name, pid, target)
end

net_user = {}

function net_user.validateUUID(uuid, serverId, accountServerId)
	local success = LuaCodeInterface.Send(3802, uuid, serverId, accountServerId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.chooseRole(pid)
	local success = LuaCodeInterface.Send(3803, pid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.createRole(leaderCid, name)
	local success = LuaCodeInterface.Send(3804, leaderCid, name)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.ping()
	local success = LuaCodeInterface.Send(3805)
end

function net_user.logout()
	local success = LuaCodeInterface.Send(3806)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.receiveRebate(id)
	local success = LuaCodeInterface.Send(3807, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_user.validateUUIDResult(code, roles, recommandJobId)
	warning("please override this function -> net_user.validateUUIDResult!")
end

function net_user.validateUUIDResult_delegate(code, roles, recommandJobId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.validateUUIDResult(code, roles, recommandJobId)
end

function net_user.chooseRoleResult(code)
	warning("please override this function -> net_user.chooseRoleResult!")
end

function net_user.chooseRoleResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.chooseRoleResult(code)
end

function net_user.createRoleResult(code, role)
	warning("please override this function -> net_user.createRoleResult!")
end

function net_user.createRoleResult_delegate(code, role)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.createRoleResult(code, role)
end

function net_user.pang(serverTime)
	warning("please override this function -> net_user.pang!")
end

function net_user.pang_delegate(serverTime)
	net_user.pang(serverTime)
end

function net_user.logoutResult(code)
	warning("please override this function -> net_user.logoutResult!")
end

function net_user.logoutResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.logoutResult(code)
end

function net_user.notifyServerStatus(time, rawOffset)
	warning("please override this function -> net_user.notifyServerStatus!")
end

function net_user.notifyServerStatus_delegate(time, rawOffset)
	net_user.notifyServerStatus(time, rawOffset)
end

function net_user.notifyError(code, msg)
	warning("please override this function -> net_user.notifyError!")
end

function net_user.notifyError_delegate(code, msg)
	net_user.notifyError(code, msg)
end

function net_user.notifyMessage(msg, disconnect)
	warning("please override this function -> net_user.notifyMessage!")
end

function net_user.notifyMessage_delegate(msg, disconnect)
	net_user.notifyMessage(msg, disconnect)
end

function net_user.notifyOffline(type)
	warning("please override this function -> net_user.notifyOffline!")
end

function net_user.notifyOffline_delegate(type)
	net_user.notifyOffline(type)
end

function net_user.receiveRebateResult(code, items)
	warning("please override this function -> net_user.receiveRebateResult!")
end

function net_user.receiveRebateResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_user.receiveRebateResult(code, items)
end

net_player = {}

function net_player.loadPlayer()
	local success = LuaCodeInterface.Send(3902)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.reloadPlayer(token, readMsgLength, pid, serverId)
	local success = LuaCodeInterface.Send(3903, token, readMsgLength, pid, serverId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.disbindRole(pid)
	local success = LuaCodeInterface.Send(3904, pid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.changeData(data)
	local success = LuaCodeInterface.Send(3905, data)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.getPlayerInfo(pid, serverId)
	local success = LuaCodeInterface.Send(3906, pid, serverId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.sendGiftCode(code)
	local success = LuaCodeInterface.Send(3907, code)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.changeShowHero(heroCid)
	local success = LuaCodeInterface.Send(3908, heroCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.setHelpHero(pos, heroCid)
	local success = LuaCodeInterface.Send(3909, pos, heroCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.getHeroInfo(pid, serverId, hcid)
	local success = LuaCodeInterface.Send(3910, pid, serverId, hcid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.triggerGuide(id, step, type)
	local success = LuaCodeInterface.Send(3911, id, step, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.saveLittleInfomation(littleInformationPOD)
	local success = LuaCodeInterface.Send(3912, littleInformationPOD)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.achieveShow(achieveShows)
	local success = LuaCodeInterface.Send(3913, achieveShows)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.activeTalent(cid)
	local success = LuaCodeInterface.Send(3914, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.resetTalent()
	local success = LuaCodeInterface.Send(3915)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.triggerEvent(type)
	local success = LuaCodeInterface.Send(3916, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.setKanBan(skinConfigId)
	local success = LuaCodeInterface.Send(3917, skinConfigId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.setKanBanPool(skinConfigIds)
	local success = LuaCodeInterface.Send(3918, skinConfigIds)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.setRandomKanBan(random)
	local success = LuaCodeInterface.Send(3919, random)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.loadPlayerResult(code, player, reconnectToken)
	warning("please override this function -> net_player.loadPlayerResult!")
end

function net_player.loadPlayerResult_delegate(code, player, reconnectToken)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.loadPlayerResult(code, player, reconnectToken)
end

function net_player.reloadPlayerResult(code, lastMsgOrder, reconnectToken)
	warning("please override this function -> net_player.reloadPlayerResult!")
end

function net_player.reloadPlayerResult_delegate(code, lastMsgOrder, reconnectToken)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.reloadPlayerResult(code, lastMsgOrder, reconnectToken)
end

function net_player.disbindRoleResult(code)
	warning("please override this function -> net_player.disbindRoleResult!")
end

function net_player.disbindRoleResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.disbindRoleResult(code)
end

function net_player.changeDataResult(code, baseInfo)
	warning("please override this function -> net_player.changeDataResult!")
end

function net_player.changeDataResult_delegate(code, baseInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.changeDataResult(code, baseInfo)
end

function net_player.getPlayerInfoResult(code, baseInfo)
	warning("please override this function -> net_player.getPlayerInfoResult!")
end

function net_player.getPlayerInfoResult_delegate(code, baseInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.getPlayerInfoResult(code, baseInfo)
end

function net_player.sendGiftCodeResult(code, items)
	warning("please override this function -> net_player.sendGiftCodeResult!")
end

function net_player.sendGiftCodeResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.sendGiftCodeResult(code, items)
end

function net_player.notifyUnlockFunc(funcTypes)
	warning("please override this function -> net_player.notifyUnlockFunc!")
end

function net_player.notifyUnlockFunc_delegate(funcTypes)
	net_player.notifyUnlockFunc(funcTypes)
end

function net_player.changeShowHeroResult(code, baseInfo)
	warning("please override this function -> net_player.changeShowHeroResult!")
end

function net_player.changeShowHeroResult_delegate(code, baseInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.changeShowHeroResult(code, baseInfo)
end

function net_player.setHelpHeroResult(code, baseInfo)
	warning("please override this function -> net_player.setHelpHeroResult!")
end

function net_player.setHelpHeroResult_delegate(code, baseInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.setHelpHeroResult(code, baseInfo)
end

function net_player.getHeroInfoResult(code, heroPOD)
	warning("please override this function -> net_player.getHeroInfoResult!")
end

function net_player.getHeroInfoResult_delegate(code, heroPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.getHeroInfoResult(code, heroPOD)
end

function net_player.notifyPlayerDataChange(baseInfo)
	warning("please override this function -> net_player.notifyPlayerDataChange!")
end

function net_player.notifyPlayerDataChange_delegate(baseInfo)
	net_player.notifyPlayerDataChange(baseInfo)
end

function net_player.notifyPlayerLevelChange(level, items)
	warning("please override this function -> net_player.notifyPlayerLevelChange!")
end

function net_player.notifyPlayerLevelChange_delegate(level, items)
	net_player.notifyPlayerLevelChange(level, items)
end

function net_player.triggerGuideResult(code, id, step, type)
	warning("please override this function -> net_player.triggerGuideResult!")
end

function net_player.triggerGuideResult_delegate(code, id, step, type)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.triggerGuideResult(code, id, step, type)
end

function net_player.saveLittleInfomationResult(code)
	warning("please override this function -> net_player.saveLittleInfomationResult!")
end

function net_player.saveLittleInfomationResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.saveLittleInfomationResult(code)
end

function net_player.achieveShowResult(code)
	warning("please override this function -> net_player.achieveShowResult!")
end

function net_player.achieveShowResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.achieveShowResult(code)
end

function net_player.notifyQuestionnaires(questionnaires)
	warning("please override this function -> net_player.notifyQuestionnaires!")
end

function net_player.notifyQuestionnaires_delegate(questionnaires)
	net_player.notifyQuestionnaires(questionnaires)
end

function net_player.activeTalentResult(code, talents)
	warning("please override this function -> net_player.activeTalentResult!")
end

function net_player.activeTalentResult_delegate(code, talents)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.activeTalentResult(code, talents)
end

function net_player.resetTalentResult(code, talentPOD, items)
	warning("please override this function -> net_player.resetTalentResult!")
end

function net_player.resetTalentResult_delegate(code, talentPOD, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.resetTalentResult(code, talentPOD, items)
end

function net_player.triggerEventResult(code)
	warning("please override this function -> net_player.triggerEventResult!")
end

function net_player.triggerEventResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.triggerEventResult(code)
end

function net_player.setKanBanResult(code, baseInfo)
	warning("please override this function -> net_player.setKanBanResult!")
end

function net_player.setKanBanResult_delegate(code, baseInfo)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.setKanBanResult(code, baseInfo)
end

function net_player.setKanBanPoolResult(code)
	warning("please override this function -> net_player.setKanBanPoolResult!")
end

function net_player.setKanBanPoolResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.setKanBanPoolResult(code)
end

function net_player.setRandomKanBanResult(code)
	warning("please override this function -> net_player.setRandomKanBanResult!")
end

function net_player.setRandomKanBanResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.setRandomKanBanResult(code)
end

function net_player.notifyServerParamChange(serverParams)
	warning("please override this function -> net_player.notifyServerParamChange!")
end

function net_player.notifyServerParamChange_delegate(serverParams)
	net_player.notifyServerParamChange(serverParams)
end

function net_player.notifyLimitedTimePkg(limitedTimePkg)
	warning("please override this function -> net_player.notifyLimitedTimePkg!")
end

function net_player.notifyLimitedTimePkg_delegate(limitedTimePkg)
	net_player.notifyLimitedTimePkg(limitedTimePkg)
end

function net_player.notifyCommodityBuyRecords(serverParams)
	warning("please override this function -> net_player.notifyCommodityBuyRecords!")
end

function net_player.notifyCommodityBuyRecords_delegate(serverParams)
	net_player.notifyCommodityBuyRecords(serverParams)
end

function net_player.notifyChangeKanBanPOD(kanBanPOD)
	warning("please override this function -> net_player.notifyChangeKanBanPOD!")
end

function net_player.notifyChangeKanBanPOD_delegate(kanBanPOD)
	net_player.notifyChangeKanBanPOD(kanBanPOD)
end

function net_player.notifyGlobalBuffPOD(globalBuffs)
	warning("please override this function -> net_player.notifyGlobalBuffPOD!")
end

function net_player.notifyGlobalBuffPOD_delegate(globalBuffs)
	net_player.notifyGlobalBuffPOD(globalBuffs)
end

function net_player.saveData(key, value)
	local success = LuaCodeInterface.Send(3947, key, value)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_player.saveDataResult(code)
	warning("please override this function -> net_player.saveDataResult!")
end

function net_player.saveDataResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_player.saveDataResult(code)
end

function net_player.notifyMonthCard(monthCard)
	warning("please override this function -> net_player.notifyMonthCard!")
end

function net_player.notifyMonthCard_delegate(monthCard)
	net_player.notifyMonthCard(monthCard)
end

net_item = {}

function net_item.sellItem(itemId, num)
	local success = LuaCodeInterface.Send(4002, itemId, num)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.useItem(items)
	local success = LuaCodeInterface.Send(4003, items)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.compositeItem(composite)
	local success = LuaCodeInterface.Send(4004, composite)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.destroyItem(itemId)
	local success = LuaCodeInterface.Send(4005, itemId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.readItemFlag(itemId)
	local success = LuaCodeInterface.Send(4006, itemId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.disItem(items)
	local success = LuaCodeInterface.Send(4007, items)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_item.sellItemResult(code)
	warning("please override this function -> net_item.sellItemResult!")
end

function net_item.sellItemResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.sellItemResult(code)
end

function net_item.useItemResult(code, addItems)
	warning("please override this function -> net_item.useItemResult!")
end

function net_item.useItemResult_delegate(code, addItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.useItemResult(code, addItems)
end

function net_item.compositeItemResult(code, items)
	warning("please override this function -> net_item.compositeItemResult!")
end

function net_item.compositeItemResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.compositeItemResult(code, items)
end

function net_item.destroyItemResult(code)
	warning("please override this function -> net_item.destroyItemResult!")
end

function net_item.destroyItemResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.destroyItemResult(code)
end

function net_item.readItemFlagResult(code, itemPOD)
	warning("please override this function -> net_item.readItemFlagResult!")
end

function net_item.readItemFlagResult_delegate(code, itemPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.readItemFlagResult(code, itemPOD)
end

function net_item.notifyAddItems(itemShowPODS)
	warning("please override this function -> net_item.notifyAddItems!")
end

function net_item.notifyAddItems_delegate(itemShowPODS)
	net_item.notifyAddItems(itemShowPODS)
end

function net_item.notifyRetrunItems(itemShowPODS, returnType)
	warning("please override this function -> net_item.notifyRetrunItems!")
end

function net_item.notifyRetrunItems_delegate(itemShowPODS, returnType)
	net_item.notifyRetrunItems(itemShowPODS, returnType)
end

function net_item.notifyConverterHero(heroConverterPOD)
	warning("please override this function -> net_item.notifyConverterHero!")
end

function net_item.notifyConverterHero_delegate(heroConverterPOD)
	net_item.notifyConverterHero(heroConverterPOD)
end

function net_item.disItemResult(code, items)
	warning("please override this function -> net_item.disItemResult!")
end

function net_item.disItemResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_item.disItemResult(code, items)
end

net_hero = {}

function net_hero.useSoulExpItem(heroCid, items, preview)
	local success = LuaCodeInterface.Send(4102, heroCid, items, preview)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_hero.breakThrough(heroCid, preview)
	local success = LuaCodeInterface.Send(4103, heroCid, preview)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_hero.unlockPersonality(heroCid, personalityId)
	local success = LuaCodeInterface.Send(4104, heroCid, personalityId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_hero.favorabilityExpItem(heroCid, items)
	local success = LuaCodeInterface.Send(4105, heroCid, items)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_hero.changeSkin(heroCid, id)
	local success = LuaCodeInterface.Send(4106, heroCid, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_hero.ascendingStart(heroCid)
	local success = LuaCodeInterface.Send(4107, heroCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_hero.breakPrize(heroCid, breakLv)
	local success = LuaCodeInterface.Send(4108, heroCid, breakLv)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_hero.previewHeroMax(heroCid, level, breakLv)
	local success = LuaCodeInterface.Send(4109, heroCid, level, breakLv)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_hero.useSoulExpItemResult(code, cri, preview, hero)
	warning("please override this function -> net_hero.useSoulExpItemResult!")
end

function net_hero.useSoulExpItemResult_delegate(code, cri, preview, hero)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_hero.useSoulExpItemResult(code, cri, preview, hero)
end

function net_hero.breakThroughResult(code, preview, hero)
	warning("please override this function -> net_hero.breakThroughResult!")
end

function net_hero.breakThroughResult_delegate(code, preview, hero)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_hero.breakThroughResult(code, preview, hero)
end

function net_hero.unlockPersonalityResult(code, personalityId)
	warning("please override this function -> net_hero.unlockPersonalityResult!")
end

function net_hero.unlockPersonalityResult_delegate(code, personalityId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_hero.unlockPersonalityResult(code, personalityId)
end

function net_hero.favorabilityExpItemResult(code, up)
	warning("please override this function -> net_hero.favorabilityExpItemResult!")
end

function net_hero.favorabilityExpItemResult_delegate(code, up)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_hero.favorabilityExpItemResult(code, up)
end

function net_hero.changeSkinResult(code)
	warning("please override this function -> net_hero.changeSkinResult!")
end

function net_hero.changeSkinResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_hero.changeSkinResult(code)
end

function net_hero.ascendingStartResult(code)
	warning("please override this function -> net_hero.ascendingStartResult!")
end

function net_hero.ascendingStartResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_hero.ascendingStartResult(code)
end

function net_hero.notifyHeros(heros)
	warning("please override this function -> net_hero.notifyHeros!")
end

function net_hero.notifyHeros_delegate(heros)
	net_hero.notifyHeros(heros)
end

function net_hero.breakPrizeResult(code, heroPOD, prizes)
	warning("please override this function -> net_hero.breakPrizeResult!")
end

function net_hero.breakPrizeResult_delegate(code, heroPOD, prizes)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_hero.breakPrizeResult(code, heroPOD, prizes)
end

function net_hero.previewHeroMaxResult(code, heroPOD)
	warning("please override this function -> net_hero.previewHeroMaxResult!")
end

function net_hero.previewHeroMaxResult_delegate(code, heroPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_hero.previewHeroMaxResult(code, heroPOD)
end

net_mail = {}

function net_mail.getMails(mailType)
	local success = LuaCodeInterface.Send(4202, mailType)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mail.readMail(mailId)
	local success = LuaCodeInterface.Send(4203, mailId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mail.pickUp(mailIdList, isAll)
	local success = LuaCodeInterface.Send(4204, mailIdList, isAll)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mail.delMail(mailIdList, isAll)
	local success = LuaCodeInterface.Send(4205, mailIdList, isAll)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mail.getMailsResult(code, mailType, mails)
	warning("please override this function -> net_mail.getMailsResult!")
end

function net_mail.getMailsResult_delegate(code, mailType, mails)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mail.getMailsResult(code, mailType, mails)
end

function net_mail.readMailResult(code, mailId)
	warning("please override this function -> net_mail.readMailResult!")
end

function net_mail.readMailResult_delegate(code, mailId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mail.readMailResult(code, mailId)
end

function net_mail.pickUpResult(code, mails, getItems)
	warning("please override this function -> net_mail.pickUpResult!")
end

function net_mail.pickUpResult_delegate(code, mails, getItems)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mail.pickUpResult(code, mails, getItems)
end

function net_mail.delMailResult(code, mails)
	warning("please override this function -> net_mail.delMailResult!")
end

function net_mail.delMailResult_delegate(code, mails)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mail.delMailResult(code, mails)
end

function net_mail.notifyNewMail(newMailCount)
	warning("please override this function -> net_mail.notifyNewMail!")
end

function net_mail.notifyNewMail_delegate(newMailCount)
	net_mail.notifyNewMail(newMailCount)
end

function net_mail.notifyDeleteMail(mails)
	warning("please override this function -> net_mail.notifyDeleteMail!")
end

function net_mail.notifyDeleteMail_delegate(mails)
	net_mail.notifyDeleteMail(mails)
end

net_formation = {}

function net_formation.changeFormationName(cid, name)
	local success = LuaCodeInterface.Send(4302, cid, name)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.saveFormation(cid, heros, attackOrder, agentSkill)
	local success = LuaCodeInterface.Send(4303, cid, heros, attackOrder, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.chooseHelpHero(cid, pos, helpHeroPOD)
	local success = LuaCodeInterface.Send(4304, cid, pos, helpHeroPOD)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.clearHelpHero(cid)
	local success = LuaCodeInterface.Send(4305, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.presetFormation(cid, heros, op)
	local success = LuaCodeInterface.Send(4306, cid, heros, op)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.canclePresetFormation(cid, presetPos)
	local success = LuaCodeInterface.Send(4307, cid, presetPos)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.getFormation(cid)
	local success = LuaCodeInterface.Send(4308, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.syncPresetFormation(cid, sync)
	local success = LuaCodeInterface.Send(4309, cid, sync)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_formation.changeFormationNameResult(code, name)
	warning("please override this function -> net_formation.changeFormationNameResult!")
end

function net_formation.changeFormationNameResult_delegate(code, name)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.changeFormationNameResult(code, name)
end

function net_formation.saveFormationResult(code)
	warning("please override this function -> net_formation.saveFormationResult!")
end

function net_formation.saveFormationResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.saveFormationResult(code)
end

function net_formation.notifyFomationUpdate(formation)
	warning("please override this function -> net_formation.notifyFomationUpdate!")
end

function net_formation.notifyFomationUpdate_delegate(formation)
	net_formation.notifyFomationUpdate(formation)
end

function net_formation.chooseHelpHeroResult(code, formation)
	warning("please override this function -> net_formation.chooseHelpHeroResult!")
end

function net_formation.chooseHelpHeroResult_delegate(code, formation)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.chooseHelpHeroResult(code, formation)
end

function net_formation.clearHelpHeroResult(code, formation)
	warning("please override this function -> net_formation.clearHelpHeroResult!")
end

function net_formation.clearHelpHeroResult_delegate(code, formation)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.clearHelpHeroResult(code, formation)
end

function net_formation.presetFormationResult(code)
	warning("please override this function -> net_formation.presetFormationResult!")
end

function net_formation.presetFormationResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.presetFormationResult(code)
end

function net_formation.canclePresetFormationResult(code)
	warning("please override this function -> net_formation.canclePresetFormationResult!")
end

function net_formation.canclePresetFormationResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.canclePresetFormationResult(code)
end

function net_formation.getFormationResult(code)
	warning("please override this function -> net_formation.getFormationResult!")
end

function net_formation.getFormationResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.getFormationResult(code)
end

function net_formation.syncPresetFormationResult(code)
	warning("please override this function -> net_formation.syncPresetFormationResult!")
end

function net_formation.syncPresetFormationResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_formation.syncPresetFormationResult(code)
end

net_task = {}

function net_task.submit(cids)
	local success = LuaCodeInterface.Send(4402, cids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_task.submitType(types)
	local success = LuaCodeInterface.Send(4403, types)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_task.obtainTask(cid)
	local success = LuaCodeInterface.Send(4404, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_task.repairTask(cid)
	local success = LuaCodeInterface.Send(4405, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_task.trackTask(cid)
	local success = LuaCodeInterface.Send(4406, cid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_task.submitResult(code, cids, shows)
	warning("please override this function -> net_task.submitResult!")
end

function net_task.submitResult_delegate(code, cids, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_task.submitResult(code, cids, shows)
end

function net_task.submitTypeResult(code, shows)
	warning("please override this function -> net_task.submitTypeResult!")
end

function net_task.submitTypeResult_delegate(code, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_task.submitTypeResult(code, shows)
end

function net_task.obtainTaskResult(code)
	warning("please override this function -> net_task.obtainTaskResult!")
end

function net_task.obtainTaskResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_task.obtainTaskResult(code)
end

function net_task.notifyTask(tasks)
	warning("please override this function -> net_task.notifyTask!")
end

function net_task.notifyTask_delegate(tasks)
	net_task.notifyTask(tasks)
end

function net_task.notifyRemove(tasks)
	warning("please override this function -> net_task.notifyRemove!")
end

function net_task.notifyRemove_delegate(tasks)
	net_task.notifyRemove(tasks)
end

function net_task.notifyFinish(tasks)
	warning("please override this function -> net_task.notifyFinish!")
end

function net_task.notifyFinish_delegate(tasks)
	net_task.notifyFinish(tasks)
end

function net_task.notifyRemoveFinish(tasks)
	warning("please override this function -> net_task.notifyRemoveFinish!")
end

function net_task.notifyRemoveFinish_delegate(tasks)
	net_task.notifyRemoveFinish(tasks)
end

function net_task.notifyRemoveTaskCompleteTime(tasks)
	warning("please override this function -> net_task.notifyRemoveTaskCompleteTime!")
end

function net_task.notifyRemoveTaskCompleteTime_delegate(tasks)
	net_task.notifyRemoveTaskCompleteTime(tasks)
end

function net_task.repairTaskResult(code)
	warning("please override this function -> net_task.repairTaskResult!")
end

function net_task.repairTaskResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_task.repairTaskResult(code)
end

function net_task.trackTaskResult(code)
	warning("please override this function -> net_task.trackTaskResult!")
end

function net_task.trackTaskResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_task.trackTaskResult(code)
end

net_skill = {}

function net_skill.wearSkill(heroCid, pos, id)
	local success = LuaCodeInterface.Send(4502, heroCid, pos, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_skill.unloadSkill(heroCid, pos)
	local success = LuaCodeInterface.Send(4503, heroCid, pos)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_skill.upgradeSkill(id, items)
	local success = LuaCodeInterface.Send(4504, id, items)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_skill.strengSkill(id)
	local success = LuaCodeInterface.Send(4505, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_skill.lockSkill(ids)
	local success = LuaCodeInterface.Send(4506, ids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_skill.purifySkill(id, items)
	local success = LuaCodeInterface.Send(4507, id, items)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_skill.wearSkillResult(code)
	warning("please override this function -> net_skill.wearSkillResult!")
end

function net_skill.wearSkillResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_skill.wearSkillResult(code)
end

function net_skill.unloadSkillResult(code)
	warning("please override this function -> net_skill.unloadSkillResult!")
end

function net_skill.unloadSkillResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_skill.unloadSkillResult(code)
end

function net_skill.upgradeSkillResult(code, oldSkill, skillpod, isUp)
	warning("please override this function -> net_skill.upgradeSkillResult!")
end

function net_skill.upgradeSkillResult_delegate(code, oldSkill, skillpod, isUp)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_skill.upgradeSkillResult(code, oldSkill, skillpod, isUp)
end

function net_skill.strengSkillResult(code, skillpod)
	warning("please override this function -> net_skill.strengSkillResult!")
end

function net_skill.strengSkillResult_delegate(code, skillpod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_skill.strengSkillResult(code, skillpod)
end

function net_skill.lockSkillResult(code)
	warning("please override this function -> net_skill.lockSkillResult!")
end

function net_skill.lockSkillResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_skill.lockSkillResult(code)
end

function net_skill.purifySkillResult(code, oldSkillpod, skillpod)
	warning("please override this function -> net_skill.purifySkillResult!")
end

function net_skill.purifySkillResult_delegate(code, oldSkillpod, skillpod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_skill.purifySkillResult(code, oldSkillpod, skillpod)
end

net_equip = {}

function net_equip.wearEquip(heroCid, id)
	local success = LuaCodeInterface.Send(4602, heroCid, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_equip.unloadEquip(heroCid, id)
	local success = LuaCodeInterface.Send(4603, heroCid, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_equip.upgradeEquip(id, items)
	local success = LuaCodeInterface.Send(4604, id, items)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_equip.lockEquip(ids)
	local success = LuaCodeInterface.Send(4605, ids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_equip.decomposeEquip(items)
	local success = LuaCodeInterface.Send(4606, items)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_equip.succinctAttr(id, attrCid, type)
	local success = LuaCodeInterface.Send(4607, id, attrCid, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_equip.applySuccinctAttr(id, index)
	local success = LuaCodeInterface.Send(4608, id, index)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_equip.wearEquipResult(code)
	warning("please override this function -> net_equip.wearEquipResult!")
end

function net_equip.wearEquipResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_equip.wearEquipResult(code)
end

function net_equip.unloadEquipResult(code)
	warning("please override this function -> net_equip.unloadEquipResult!")
end

function net_equip.unloadEquipResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_equip.unloadEquipResult(code)
end

function net_equip.upgradeEquipResult(code, cri, oldEquipPOD, equipPOD)
	warning("please override this function -> net_equip.upgradeEquipResult!")
end

function net_equip.upgradeEquipResult_delegate(code, cri, oldEquipPOD, equipPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_equip.upgradeEquipResult(code, cri, oldEquipPOD, equipPOD)
end

function net_equip.lockEquipResult(code)
	warning("please override this function -> net_equip.lockEquipResult!")
end

function net_equip.lockEquipResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_equip.lockEquipResult(code)
end

function net_equip.decomposeEquipResult(code)
	warning("please override this function -> net_equip.decomposeEquipResult!")
end

function net_equip.decomposeEquipResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_equip.decomposeEquipResult(code)
end

function net_equip.succinctAttrResult(code, id, attrCid, type, attr, attrValue)
	warning("please override this function -> net_equip.succinctAttrResult!")
end

function net_equip.succinctAttrResult_delegate(code, id, attrCid, type, attr, attrValue)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_equip.succinctAttrResult(code, id, attrCid, type, attr, attrValue)
end

function net_equip.applySuccinctAttrResult(code)
	warning("please override this function -> net_equip.applySuccinctAttrResult!")
end

function net_equip.applySuccinctAttrResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_equip.applySuccinctAttrResult(code)
end

net_warehouse = {}

function net_warehouse.notifyItemChange(datas)
	warning("please override this function -> net_warehouse.notifyItemChange!")
end

function net_warehouse.notifyItemChange_delegate(datas)
	net_warehouse.notifyItemChange(datas)
end

net_fight = {}

function net_fight.fightOver(storyBattleId, type, fightResult, dmgRecords, attacker, defender, fightData, userData, totalDmg)
	local success = LuaCodeInterface.Send(4902, storyBattleId, type, fightResult, dmgRecords, attacker, defender, fightData, userData, totalDmg)
end

function net_fight.fightFrame(fightId, order)
	local success = LuaCodeInterface.Send(4903, fightId, order)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fight.recoverFight(fightId)
	local success = LuaCodeInterface.Send(4904, fightId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fight.refreshRandomSeed()
	local success = LuaCodeInterface.Send(4905)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_fight.notifyStartFight(isLocalFight, fightPOD, userData, orders)
	warning("please override this function -> net_fight.notifyStartFight!")
end

function net_fight.notifyStartFight_delegate(isLocalFight, fightPOD, userData, orders)
	net_fight.notifyStartFight(isLocalFight, fightPOD, userData, orders)
end

function net_fight.fightFrameResult(code)
	warning("please override this function -> net_fight.fightFrameResult!")
end

function net_fight.fightFrameResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fight.fightFrameResult(code)
end

function net_fight.recoverFightResult(code)
	warning("please override this function -> net_fight.recoverFightResult!")
end

function net_fight.recoverFightResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fight.recoverFightResult(code)
end

function net_fight.notifyFightOver(fightInfo)
	warning("please override this function -> net_fight.notifyFightOver!")
end

function net_fight.notifyFightOver_delegate(fightInfo)
	net_fight.notifyFightOver(fightInfo)
end

function net_fight.refreshRandomSeedResult(code, randomSeed)
	warning("please override this function -> net_fight.refreshRandomSeedResult!")
end

function net_fight.refreshRandomSeedResult_delegate(code, randomSeed)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_fight.refreshRandomSeedResult(code, randomSeed)
end

net_shop = {}

function net_shop.buy(commodityCid, count)
	local success = LuaCodeInterface.Send(5002, commodityCid, count)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_shop.buyResult(code, shows, commodityBuyRecords)
	warning("please override this function -> net_shop.buyResult!")
end

function net_shop.buyResult_delegate(code, shows, commodityBuyRecords)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_shop.buyResult(code, shows, commodityBuyRecords)
end

net_draw = {}

function net_draw.draw(id, count, isGuild)
	local success = LuaCodeInterface.Send(5102, id, count, isGuild)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_draw.drawRecord(id)
	local success = LuaCodeInterface.Send(5103, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_draw.history(id)
	local success = LuaCodeInterface.Send(5104, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_draw.cancel(id)
	local success = LuaCodeInterface.Send(5105, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_draw.confirm(id, result)
	local success = LuaCodeInterface.Send(5106, id, result)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_draw.drawResult(code, drawResultPODS)
	warning("please override this function -> net_draw.drawResult!")
end

function net_draw.drawResult_delegate(code, drawResultPODS)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_draw.drawResult(code, drawResultPODS)
end

function net_draw.drawRecordResult(code, drawRecordPODS)
	warning("please override this function -> net_draw.drawRecordResult!")
end

function net_draw.drawRecordResult_delegate(code, drawRecordPODS)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_draw.drawRecordResult(code, drawRecordPODS)
end

function net_draw.historyResult(code)
	warning("please override this function -> net_draw.historyResult!")
end

function net_draw.historyResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_draw.historyResult(code)
end

function net_draw.cancelResult(code)
	warning("please override this function -> net_draw.cancelResult!")
end

function net_draw.cancelResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_draw.cancelResult(code)
end

function net_draw.confirmResult(code)
	warning("please override this function -> net_draw.confirmResult!")
end

function net_draw.confirmResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_draw.confirmResult(code)
end

function net_draw.notifyUpdateDraw(DrawPODs)
	warning("please override this function -> net_draw.notifyUpdateDraw!")
end

function net_draw.notifyUpdateDraw_delegate(DrawPODs)
	net_draw.notifyUpdateDraw(DrawPODs)
end

function net_draw.notifyAddDraw(DrawPODs)
	warning("please override this function -> net_draw.notifyAddDraw!")
end

function net_draw.notifyAddDraw_delegate(DrawPODs)
	net_draw.notifyAddDraw(DrawPODs)
end

function net_draw.notifyRemoveDraw(DrawPODs)
	warning("please override this function -> net_draw.notifyRemoveDraw!")
end

function net_draw.notifyRemoveDraw_delegate(DrawPODs)
	net_draw.notifyRemoveDraw(DrawPODs)
end

function net_draw.chooseShowGroup(showGroupId, cardId)
	local success = LuaCodeInterface.Send(5115, showGroupId, cardId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_draw.chooseShowGroupResult(code, showGroupId, cardId)
	warning("please override this function -> net_draw.chooseShowGroupResult!")
end

function net_draw.chooseShowGroupResult_delegate(code, showGroupId, cardId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_draw.chooseShowGroupResult(code, showGroupId, cardId)
end

net_sign = {}

function net_sign.sign(day)
	local success = LuaCodeInterface.Send(5202, day)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_sign.signResult(code, signPOD, itemShowPODS)
	warning("please override this function -> net_sign.signResult!")
end

function net_sign.signResult_delegate(code, signPOD, itemShowPODS)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_sign.signResult(code, signPOD, itemShowPODS)
end

function net_sign.notifySign(signPOD)
	warning("please override this function -> net_sign.notifySign!")
end

function net_sign.notifySign_delegate(signPOD)
	net_sign.notifySign(signPOD)
end

net_generalDup = {}

function net_generalDup.enterDup(dupId, review)
	local success = LuaCodeInterface.Send(5302, dupId, review)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_generalDup.enterDupResult(code)
	warning("please override this function -> net_generalDup.enterDupResult!")
end

function net_generalDup.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_generalDup.enterDupResult(code)
end

function net_generalDup.notifyDup(dups)
	warning("please override this function -> net_generalDup.notifyDup!")
end

function net_generalDup.notifyDup_delegate(dups)
	net_generalDup.notifyDup(dups)
end

function net_generalDup.notifyFinishDup(fightOverPOD, stageCid)
	warning("please override this function -> net_generalDup.notifyFinishDup!")
end

function net_generalDup.notifyFinishDup_delegate(fightOverPOD, stageCid)
	net_generalDup.notifyFinishDup(fightOverPOD, stageCid)
end

function net_generalDup.enterMingleDup(passId, fightCount, units, agentSkill)
	local success = LuaCodeInterface.Send(5306, passId, fightCount, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_generalDup.enterMingleDupResult(code)
	warning("please override this function -> net_generalDup.enterMingleDupResult!")
end

function net_generalDup.enterMingleDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_generalDup.enterMingleDupResult(code)
end

net_redDot = {}

function net_redDot.notifyRedDot(redDots)
	warning("please override this function -> net_redDot.notifyRedDot!")
end

function net_redDot.notifyRedDot_delegate(redDots)
	net_redDot.notifyRedDot(redDots)
end

net_dailyDup = {}

function net_dailyDup.enterDup(passId, fightCount, units, agentSkill)
	local success = LuaCodeInterface.Send(5502, passId, fightCount, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dailyDup.enterDupResult(code)
	warning("please override this function -> net_dailyDup.enterDupResult!")
end

function net_dailyDup.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dailyDup.enterDupResult(code)
end

function net_dailyDup.notifyDup(dupPODs)
	warning("please override this function -> net_dailyDup.notifyDup!")
end

function net_dailyDup.notifyDup_delegate(dupPODs)
	net_dailyDup.notifyDup(dupPODs)
end

function net_dailyDup.notifyFinishDup(fightOverPOD)
	warning("please override this function -> net_dailyDup.notifyFinishDup!")
end

function net_dailyDup.notifyFinishDup_delegate(fightOverPOD)
	net_dailyDup.notifyFinishDup(fightOverPOD)
end

function net_dailyDup.sweepDup(passId, count)
	local success = LuaCodeInterface.Send(5506, passId, count)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_dailyDup.sweepDupResult(code, shows)
	warning("please override this function -> net_dailyDup.sweepDupResult!")
end

function net_dailyDup.sweepDupResult_delegate(code, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_dailyDup.sweepDupResult(code, shows)
end

net_equipDup = {}

function net_equipDup.enterDup(passId, fightFight, units, agentSkill)
	local success = LuaCodeInterface.Send(5602, passId, fightFight, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_equipDup.enterDupResult(code)
	warning("please override this function -> net_equipDup.enterDupResult!")
end

function net_equipDup.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_equipDup.enterDupResult(code)
end

function net_equipDup.notifyDup(dupPODs)
	warning("please override this function -> net_equipDup.notifyDup!")
end

function net_equipDup.notifyDup_delegate(dupPODs)
	net_equipDup.notifyDup(dupPODs)
end

function net_equipDup.notifyFinishDup(fightOverPOD)
	warning("please override this function -> net_equipDup.notifyFinishDup!")
end

function net_equipDup.notifyFinishDup_delegate(fightOverPOD)
	net_equipDup.notifyFinishDup(fightOverPOD)
end

function net_equipDup.sweepDup(passId, count)
	local success = LuaCodeInterface.Send(5606, passId, count)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_equipDup.sweepDupResult(code, shows)
	warning("please override this function -> net_equipDup.sweepDupResult!")
end

function net_equipDup.sweepDupResult_delegate(code, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_equipDup.sweepDupResult(code, shows)
end

net_monthCard = {}

function net_monthCard.receiveMonthCardAward()
	local success = LuaCodeInterface.Send(5702)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_monthCard.receiveMonthCardAwardResult(code, itemShowPODS)
	warning("please override this function -> net_monthCard.receiveMonthCardAwardResult!")
end

function net_monthCard.receiveMonthCardAwardResult_delegate(code, itemShowPODS)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_monthCard.receiveMonthCardAwardResult(code, itemShowPODS)
end

function net_monthCard.notifyMonthCard(monthCardPOD)
	warning("please override this function -> net_monthCard.notifyMonthCard!")
end

function net_monthCard.notifyMonthCard_delegate(monthCardPOD)
	net_monthCard.notifyMonthCard(monthCardPOD)
end

function net_monthCard.notifyMonthCardAward(itemShowPODS)
	warning("please override this function -> net_monthCard.notifyMonthCardAward!")
end

function net_monthCard.notifyMonthCardAward_delegate(itemShowPODS)
	net_monthCard.notifyMonthCardAward(itemShowPODS)
end

net_bossDup = {}

function net_bossDup.enterDup(passId, units, agentSkill)
	local success = LuaCodeInterface.Send(5802, passId, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_bossDup.enterDupResult(code)
	warning("please override this function -> net_bossDup.enterDupResult!")
end

function net_bossDup.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_bossDup.enterDupResult(code)
end

function net_bossDup.notifyDup(dupPODs)
	warning("please override this function -> net_bossDup.notifyDup!")
end

function net_bossDup.notifyDup_delegate(dupPODs)
	net_bossDup.notifyDup(dupPODs)
end

function net_bossDup.notifyFinishDup(fightOverPOD)
	warning("please override this function -> net_bossDup.notifyFinishDup!")
end

function net_bossDup.notifyFinishDup_delegate(fightOverPOD)
	net_bossDup.notifyFinishDup(fightOverPOD)
end

net_pass = {}

function net_pass.notifyPass(passPOD)
	warning("please override this function -> net_pass.notifyPass!")
end

function net_pass.notifyPass_delegate(passPOD)
	net_pass.notifyPass(passPOD)
end

net_home = {}

function net_home.upgradeHome()
	local success = LuaCodeInterface.Send(6002)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.refreshDispTask()
	local success = LuaCodeInterface.Send(6003)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.executeDispTask(taskCid, heroCids)
	local success = LuaCodeInterface.Send(6004, taskCid, heroCids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.submitDispTask(taskCid)
	local success = LuaCodeInterface.Send(6005, taskCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_home.upgradeHomeResult(code, home)
	warning("please override this function -> net_home.upgradeHomeResult!")
end

function net_home.upgradeHomeResult_delegate(code, home)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.upgradeHomeResult(code, home)
end

function net_home.refreshDispTaskResult(code)
	warning("please override this function -> net_home.refreshDispTaskResult!")
end

function net_home.refreshDispTaskResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.refreshDispTaskResult(code)
end

function net_home.executeDispTaskResult(code)
	warning("please override this function -> net_home.executeDispTaskResult!")
end

function net_home.executeDispTaskResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.executeDispTaskResult(code)
end

function net_home.submitDispTaskResult(code, shows)
	warning("please override this function -> net_home.submitDispTaskResult!")
end

function net_home.submitDispTaskResult_delegate(code, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_home.submitDispTaskResult(code, shows)
end

function net_home.notifyHome(home)
	warning("please override this function -> net_home.notifyHome!")
end

function net_home.notifyHome_delegate(home)
	net_home.notifyHome(home)
end

function net_home.notifyUpdateTask(tasks)
	warning("please override this function -> net_home.notifyUpdateTask!")
end

function net_home.notifyUpdateTask_delegate(tasks)
	net_home.notifyUpdateTask(tasks)
end

function net_home.notifyRemoveTask(tasks)
	warning("please override this function -> net_home.notifyRemoveTask!")
end

function net_home.notifyRemoveTask_delegate(tasks)
	net_home.notifyRemoveTask(tasks)
end

net_sceneMap = {}

function net_sceneMap.enterArea(areaCid, active)
	local success = LuaCodeInterface.Send(6102, areaCid, active)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_sceneMap.enterRoom(roomCid, active, data)
	local success = LuaCodeInterface.Send(6103, roomCid, active, data)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_sceneMap.moveComp(roomCid, compCid)
	local success = LuaCodeInterface.Send(6104, roomCid, compCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_sceneMap.triggerAction(actionCid, schedule, triggerParam)
	local success = LuaCodeInterface.Send(6105, actionCid, schedule, triggerParam)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_sceneMap.enterAreaResult(code, areaCid, roomCid, active)
	warning("please override this function -> net_sceneMap.enterAreaResult!")
end

function net_sceneMap.enterAreaResult_delegate(code, areaCid, roomCid, active)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_sceneMap.enterAreaResult(code, areaCid, roomCid, active)
end

function net_sceneMap.enterRoomResult(code, areaCid, roomCid, active, data)
	warning("please override this function -> net_sceneMap.enterRoomResult!")
end

function net_sceneMap.enterRoomResult_delegate(code, areaCid, roomCid, active, data)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_sceneMap.enterRoomResult(code, areaCid, roomCid, active, data)
end

function net_sceneMap.moveCompResult(code)
	warning("please override this function -> net_sceneMap.moveCompResult!")
end

function net_sceneMap.moveCompResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_sceneMap.moveCompResult(code)
end

function net_sceneMap.triggerActionResult(code, actionCid, schedule, pod)
	warning("please override this function -> net_sceneMap.triggerActionResult!")
end

function net_sceneMap.triggerActionResult_delegate(code, actionCid, schedule, pod)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_sceneMap.triggerActionResult(code, actionCid, schedule, pod)
end

function net_sceneMap.notifyAreas(areas)
	warning("please override this function -> net_sceneMap.notifyAreas!")
end

function net_sceneMap.notifyAreas_delegate(areas)
	net_sceneMap.notifyAreas(areas)
end

function net_sceneMap.notifyRooms(rooms)
	warning("please override this function -> net_sceneMap.notifyRooms!")
end

function net_sceneMap.notifyRooms_delegate(rooms)
	net_sceneMap.notifyRooms(rooms)
end

function net_sceneMap.notifyComps(comps)
	warning("please override this function -> net_sceneMap.notifyComps!")
end

function net_sceneMap.notifyComps_delegate(comps)
	net_sceneMap.notifyComps(comps)
end

function net_sceneMap.notifyActions(actions)
	warning("please override this function -> net_sceneMap.notifyActions!")
end

function net_sceneMap.notifyActions_delegate(actions)
	net_sceneMap.notifyActions(actions)
end

function net_sceneMap.notifyFinishActions(finishActions)
	warning("please override this function -> net_sceneMap.notifyFinishActions!")
end

function net_sceneMap.notifyFinishActions_delegate(finishActions)
	net_sceneMap.notifyFinishActions(finishActions)
end

function net_sceneMap.notifyEnterRooms(areaCid, roomCid)
	warning("please override this function -> net_sceneMap.notifyEnterRooms!")
end

function net_sceneMap.notifyEnterRooms_delegate(areaCid, roomCid)
	net_sceneMap.notifyEnterRooms(areaCid, roomCid)
end

function net_sceneMap.changeMapTimeSpan(timeSpan)
	local success = LuaCodeInterface.Send(6116, timeSpan)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_sceneMap.changeMapTimeSpanResult(code)
	warning("please override this function -> net_sceneMap.changeMapTimeSpanResult!")
end

function net_sceneMap.changeMapTimeSpanResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_sceneMap.changeMapTimeSpanResult(code)
end

function net_sceneMap.notifyMapTimeSpan(timeSpan)
	warning("please override this function -> net_sceneMap.notifyMapTimeSpan!")
end

function net_sceneMap.notifyMapTimeSpan_delegate(timeSpan)
	net_sceneMap.notifyMapTimeSpan(timeSpan)
end

function net_sceneMap.notifySceneMapInfo(info)
	warning("please override this function -> net_sceneMap.notifySceneMapInfo!")
end

function net_sceneMap.notifySceneMapInfo_delegate(info)
	net_sceneMap.notifySceneMapInfo(info)
end

net_favor = {}

function net_favor.triggerMessage(heroCid)
	local success = LuaCodeInterface.Send(6202, heroCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_favor.entryComplete(entryId)
	local success = LuaCodeInterface.Send(6203, entryId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_favor.entryOption(entryId, index)
	local success = LuaCodeInterface.Send(6204, entryId, index)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_favor.triggerMessageResult(code)
	warning("please override this function -> net_favor.triggerMessageResult!")
end

function net_favor.triggerMessageResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_favor.triggerMessageResult(code)
end

function net_favor.entryCompleteResult(code, shows)
	warning("please override this function -> net_favor.entryCompleteResult!")
end

function net_favor.entryCompleteResult_delegate(code, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_favor.entryCompleteResult(code, shows)
end

function net_favor.entryOptionResult(code, optionCid, shows)
	warning("please override this function -> net_favor.entryOptionResult!")
end

function net_favor.entryOptionResult_delegate(code, optionCid, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_favor.entryOptionResult(code, optionCid, shows)
end

function net_favor.notifyEntry(heroCid, groupId, entryId)
	warning("please override this function -> net_favor.notifyEntry!")
end

function net_favor.notifyEntry_delegate(heroCid, groupId, entryId)
	net_favor.notifyEntry(heroCid, groupId, entryId)
end

function net_favor.notifyMessageFinish(finishMsgGroups)
	warning("please override this function -> net_favor.notifyMessageFinish!")
end

function net_favor.notifyMessageFinish_delegate(finishMsgGroups)
	net_favor.notifyMessageFinish(finishMsgGroups)
end

net_worldBossDup = {}

function net_worldBossDup.enterDup(stageCid, units, agentSkill)
	local success = LuaCodeInterface.Send(6302, stageCid, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_worldBossDup.enterDupResult(code)
	warning("please override this function -> net_worldBossDup.enterDupResult!")
end

function net_worldBossDup.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_worldBossDup.enterDupResult(code)
end

function net_worldBossDup.notifyDup(dupPODs)
	warning("please override this function -> net_worldBossDup.notifyDup!")
end

function net_worldBossDup.notifyDup_delegate(dupPODs)
	net_worldBossDup.notifyDup(dupPODs)
end

function net_worldBossDup.notifyFinishDup(fightOverPOD)
	warning("please override this function -> net_worldBossDup.notifyFinishDup!")
end

function net_worldBossDup.notifyFinishDup_delegate(fightOverPOD)
	net_worldBossDup.notifyFinishDup(fightOverPOD)
end

net_crusadeDup = {}

function net_crusadeDup.receiveCrusade(stageCid)
	local success = LuaCodeInterface.Send(6402, stageCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_crusadeDup.enterDup(stageCid, units, agentSkill)
	local success = LuaCodeInterface.Send(6403, stageCid, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_crusadeDup.receiveCrusadeResult(code)
	warning("please override this function -> net_crusadeDup.receiveCrusadeResult!")
end

function net_crusadeDup.receiveCrusadeResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_crusadeDup.receiveCrusadeResult(code)
end

function net_crusadeDup.enterDupResult(code)
	warning("please override this function -> net_crusadeDup.enterDupResult!")
end

function net_crusadeDup.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_crusadeDup.enterDupResult(code)
end

function net_crusadeDup.notifyAddDup(dups)
	warning("please override this function -> net_crusadeDup.notifyAddDup!")
end

function net_crusadeDup.notifyAddDup_delegate(dups)
	net_crusadeDup.notifyAddDup(dups)
end

function net_crusadeDup.notifyUpdateDup(dup)
	warning("please override this function -> net_crusadeDup.notifyUpdateDup!")
end

function net_crusadeDup.notifyUpdateDup_delegate(dup)
	net_crusadeDup.notifyUpdateDup(dup)
end

net_activity = {}

function net_activity.receiveSupply(activityCid, idx)
	local success = LuaCodeInterface.Send(7002, activityCid, idx)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_activity.startGhostGame(activityCid)
	local success = LuaCodeInterface.Send(7003, activityCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_activity.endGhostGame(activityCid, award)
	local success = LuaCodeInterface.Send(7004, activityCid, award)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_activity.raffle(activityCid)
	local success = LuaCodeInterface.Send(7005, activityCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_activity.receiveSupplyResult(code, shows)
	warning("please override this function -> net_activity.receiveSupplyResult!")
end

function net_activity.receiveSupplyResult_delegate(code, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_activity.receiveSupplyResult(code, shows)
end

function net_activity.notifyActivity(activityStatus)
	warning("please override this function -> net_activity.notifyActivity!")
end

function net_activity.notifyActivity_delegate(activityStatus)
	net_activity.notifyActivity(activityStatus)
end

function net_activity.notifyRemove(ids)
	warning("please override this function -> net_activity.notifyRemove!")
end

function net_activity.notifyRemove_delegate(ids)
	net_activity.notifyRemove(ids)
end

function net_activity.startGhostGameResult(code)
	warning("please override this function -> net_activity.startGhostGameResult!")
end

function net_activity.startGhostGameResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_activity.startGhostGameResult(code)
end

function net_activity.endGhostGameResult(code, shows)
	warning("please override this function -> net_activity.endGhostGameResult!")
end

function net_activity.endGhostGameResult_delegate(code, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_activity.endGhostGameResult(code, shows)
end

function net_activity.raffleResult(code, awardCid, shows)
	warning("please override this function -> net_activity.raffleResult!")
end

function net_activity.raffleResult_delegate(code, awardCid, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_activity.raffleResult(code, awardCid, shows)
end

net_plotStage = {}

function net_plotStage.saveLevel(plotStageDupPOD)
	local success = LuaCodeInterface.Send(8002, plotStageDupPOD)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_plotStage.enterFight(fgihtId, units, agentSkill)
	local success = LuaCodeInterface.Send(8003, fgihtId, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_plotStage.completeLevel(levelResult)
	local success = LuaCodeInterface.Send(8004, levelResult)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_plotStage.saveLevelResult(code, plotStageDupPOD)
	warning("please override this function -> net_plotStage.saveLevelResult!")
end

function net_plotStage.saveLevelResult_delegate(code, plotStageDupPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_plotStage.saveLevelResult(code, plotStageDupPOD)
end

function net_plotStage.enterFightResult(code)
	warning("please override this function -> net_plotStage.enterFightResult!")
end

function net_plotStage.enterFightResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_plotStage.enterFightResult(code)
end

function net_plotStage.completeLevelResult(code, exit)
	warning("please override this function -> net_plotStage.completeLevelResult!")
end

function net_plotStage.completeLevelResult_delegate(code, exit)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_plotStage.completeLevelResult(code, exit)
end

function net_plotStage.notifyStartPlot(plotStageDupPOD)
	warning("please override this function -> net_plotStage.notifyStartPlot!")
end

function net_plotStage.notifyStartPlot_delegate(plotStageDupPOD)
	net_plotStage.notifyStartPlot(plotStageDupPOD)
end

function net_plotStage.triggerAction(actionId, target)
	local success = LuaCodeInterface.Send(8009, actionId, target)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_plotStage.setExtension(add, extension)
	local success = LuaCodeInterface.Send(8010, add, extension)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_plotStage.removeExtension(keys)
	local success = LuaCodeInterface.Send(8011, keys)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_plotStage.triggerActionResult(code, items)
	warning("please override this function -> net_plotStage.triggerActionResult!")
end

function net_plotStage.triggerActionResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_plotStage.triggerActionResult(code, items)
end

function net_plotStage.setExtensionResult(code, add, extension)
	warning("please override this function -> net_plotStage.setExtensionResult!")
end

function net_plotStage.setExtensionResult_delegate(code, add, extension)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_plotStage.setExtensionResult(code, add, extension)
end

function net_plotStage.removeExtensionResult(code, keys)
	warning("please override this function -> net_plotStage.removeExtensionResult!")
end

function net_plotStage.removeExtensionResult_delegate(code, keys)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_plotStage.removeExtensionResult(code, keys)
end

function net_plotStage.notifyTempWarehouse(items, notify)
	warning("please override this function -> net_plotStage.notifyTempWarehouse!")
end

function net_plotStage.notifyTempWarehouse_delegate(items, notify)
	net_plotStage.notifyTempWarehouse(items, notify)
end

function net_plotStage.enterStaticFight(fgihtId)
	local success = LuaCodeInterface.Send(8016, fgihtId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_plotStage.enterStaticFightResult(code)
	warning("please override this function -> net_plotStage.enterStaticFightResult!")
end

function net_plotStage.enterStaticFightResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_plotStage.enterStaticFightResult(code)
end

function net_plotStage.enterStaticStage(plotID)
	local success = LuaCodeInterface.Send(8018, plotID)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_plotStage.enterStaticStageResult(code)
	warning("please override this function -> net_plotStage.enterStaticStageResult!")
end

function net_plotStage.enterStaticStageResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_plotStage.enterStaticStageResult(code)
end

net_climbTowerDup = {}

function net_climbTowerDup.enterDup(passId, units, agentSkill)
	local success = LuaCodeInterface.Send(9101, passId, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_climbTowerDup.dailyPrize(passId)
	local success = LuaCodeInterface.Send(9102, passId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_climbTowerDup.enterDupResult(code)
	warning("please override this function -> net_climbTowerDup.enterDupResult!")
end

function net_climbTowerDup.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_climbTowerDup.enterDupResult(code)
end

function net_climbTowerDup.dailyPrizeResult(code, dailyStatus, items)
	warning("please override this function -> net_climbTowerDup.dailyPrizeResult!")
end

function net_climbTowerDup.dailyPrizeResult_delegate(code, dailyStatus, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_climbTowerDup.dailyPrizeResult(code, dailyStatus, items)
end

function net_climbTowerDup.notifyDup(dupPODs)
	warning("please override this function -> net_climbTowerDup.notifyDup!")
end

function net_climbTowerDup.notifyDup_delegate(dupPODs)
	net_climbTowerDup.notifyDup(dupPODs)
end

function net_climbTowerDup.notifyFinishDup(fightOverPOD)
	warning("please override this function -> net_climbTowerDup.notifyFinishDup!")
end

function net_climbTowerDup.notifyFinishDup_delegate(fightOverPOD)
	net_climbTowerDup.notifyFinishDup(fightOverPOD)
end

net_mapData = {}

function net_mapData.enterMap(mapSmallId, main, size)
	local success = LuaCodeInterface.Send(9202, mapSmallId, main, size)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mapData.exitMap()
	local success = LuaCodeInterface.Send(9203)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mapData.takeNotesEffectId(effectId)
	local success = LuaCodeInterface.Send(9204, effectId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mapData.enterMapResult(code, mapSmallPODs)
	warning("please override this function -> net_mapData.enterMapResult!")
end

function net_mapData.enterMapResult_delegate(code, mapSmallPODs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mapData.enterMapResult(code, mapSmallPODs)
end

function net_mapData.exitMapResult(code)
	warning("please override this function -> net_mapData.exitMapResult!")
end

function net_mapData.exitMapResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mapData.exitMapResult(code)
end

function net_mapData.takeNotesEffectIdResult(code)
	warning("please override this function -> net_mapData.takeNotesEffectIdResult!")
end

function net_mapData.takeNotesEffectIdResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mapData.takeNotesEffectIdResult(code)
end

function net_mapData.notifyUpdateMapSmall(mapSmallPODs)
	warning("please override this function -> net_mapData.notifyUpdateMapSmall!")
end

function net_mapData.notifyUpdateMapSmall_delegate(mapSmallPODs)
	net_mapData.notifyUpdateMapSmall(mapSmallPODs)
end

function net_mapData.notifyUpdateMapItem(mapItemPODPODs)
	warning("please override this function -> net_mapData.notifyUpdateMapItem!")
end

function net_mapData.notifyUpdateMapItem_delegate(mapItemPODPODs)
	net_mapData.notifyUpdateMapItem(mapItemPODPODs)
end

net_randomDup = {}

function net_randomDup.enterDup(passId, units, agentSkill)
	local success = LuaCodeInterface.Send(9302, passId, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_randomDup.enterDupResult(code)
	warning("please override this function -> net_randomDup.enterDupResult!")
end

function net_randomDup.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_randomDup.enterDupResult(code)
end

function net_randomDup.notifyDup(dupPODs)
	warning("please override this function -> net_randomDup.notifyDup!")
end

function net_randomDup.notifyDup_delegate(dupPODs)
	net_randomDup.notifyDup(dupPODs)
end

function net_randomDup.notifyFinishDup(randomDupPOD)
	warning("please override this function -> net_randomDup.notifyFinishDup!")
end

function net_randomDup.notifyFinishDup_delegate(randomDupPOD)
	net_randomDup.notifyFinishDup(randomDupPOD)
end

net_favorable = {}

function net_favorable.enterDup(dupId, hCid)
	local success = LuaCodeInterface.Send(9402, dupId, hCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_favorable.playSound(soundId, hCid)
	local success = LuaCodeInterface.Send(9403, soundId, hCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_favorable.viewDeed(deedId, hCid)
	local success = LuaCodeInterface.Send(9404, deedId, hCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_favorable.enterDupResult(code)
	warning("please override this function -> net_favorable.enterDupResult!")
end

function net_favorable.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_favorable.enterDupResult(code)
end

function net_favorable.playSoundResult(code)
	warning("please override this function -> net_favorable.playSoundResult!")
end

function net_favorable.playSoundResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_favorable.playSoundResult(code)
end

function net_favorable.viewDeedResult(code)
	warning("please override this function -> net_favorable.viewDeedResult!")
end

function net_favorable.viewDeedResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_favorable.viewDeedResult(code)
end

function net_favorable.notifyFinishDup(fightOverPOD)
	warning("please override this function -> net_favorable.notifyFinishDup!")
end

function net_favorable.notifyFinishDup_delegate(fightOverPOD)
	net_favorable.notifyFinishDup(fightOverPOD)
end

net_mazeDup = {}

function net_mazeDup.wearGemstone(id, seatId)
	local success = LuaCodeInterface.Send(9502, id, seatId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.takeOffGemstone(seatId)
	local success = LuaCodeInterface.Send(9503, seatId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.upgradeOrbment(id)
	local success = LuaCodeInterface.Send(9504, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.selectSeatEffect(seatId, effectId)
	local success = LuaCodeInterface.Send(9505, seatId, effectId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.cancelSeatEffect(seatId)
	local success = LuaCodeInterface.Send(9506, seatId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.unlockSeat(seatId)
	local success = LuaCodeInterface.Send(9507, seatId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.enterMazeDup(mazeDupId, formationId)
	local success = LuaCodeInterface.Send(9508, mazeDupId, formationId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.claimProgressAward(mazeDupId, progressId)
	local success = LuaCodeInterface.Send(9509, mazeDupId, progressId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.gainHeroPOD(hcids)
	local success = LuaCodeInterface.Send(9510, hcids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.chageFormationPOD(formationPOD)
	local success = LuaCodeInterface.Send(9511, formationPOD)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.finishMazeStage(mazeDupId)
	local success = LuaCodeInterface.Send(9512, mazeDupId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_mazeDup.wearGemstoneResult(code, seatId)
	warning("please override this function -> net_mazeDup.wearGemstoneResult!")
end

function net_mazeDup.wearGemstoneResult_delegate(code, seatId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.wearGemstoneResult(code, seatId)
end

function net_mazeDup.takeOffGemstoneResult(code, seatId)
	warning("please override this function -> net_mazeDup.takeOffGemstoneResult!")
end

function net_mazeDup.takeOffGemstoneResult_delegate(code, seatId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.takeOffGemstoneResult(code, seatId)
end

function net_mazeDup.upgradeOrbmentResult(code)
	warning("please override this function -> net_mazeDup.upgradeOrbmentResult!")
end

function net_mazeDup.upgradeOrbmentResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.upgradeOrbmentResult(code)
end

function net_mazeDup.selectSeatEffectResult(code, seatId)
	warning("please override this function -> net_mazeDup.selectSeatEffectResult!")
end

function net_mazeDup.selectSeatEffectResult_delegate(code, seatId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.selectSeatEffectResult(code, seatId)
end

function net_mazeDup.cancelSeatEffectResult(code, seatId)
	warning("please override this function -> net_mazeDup.cancelSeatEffectResult!")
end

function net_mazeDup.cancelSeatEffectResult_delegate(code, seatId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.cancelSeatEffectResult(code, seatId)
end

function net_mazeDup.unlockSeatResult(code, seatId)
	warning("please override this function -> net_mazeDup.unlockSeatResult!")
end

function net_mazeDup.unlockSeatResult_delegate(code, seatId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.unlockSeatResult(code, seatId)
end

function net_mazeDup.enterMazeDupResult(code, mazeStagePOD, storySaveData)
	warning("please override this function -> net_mazeDup.enterMazeDupResult!")
end

function net_mazeDup.enterMazeDupResult_delegate(code, mazeStagePOD, storySaveData)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.enterMazeDupResult(code, mazeStagePOD, storySaveData)
end

function net_mazeDup.claimProgressAwardResult(code, items)
	warning("please override this function -> net_mazeDup.claimProgressAwardResult!")
end

function net_mazeDup.claimProgressAwardResult_delegate(code, items)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.claimProgressAwardResult(code, items)
end

function net_mazeDup.gainHeroPODResult(code)
	warning("please override this function -> net_mazeDup.gainHeroPODResult!")
end

function net_mazeDup.gainHeroPODResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.gainHeroPODResult(code)
end

function net_mazeDup.chageFormationPODResult(code)
	warning("please override this function -> net_mazeDup.chageFormationPODResult!")
end

function net_mazeDup.chageFormationPODResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.chageFormationPODResult(code)
end

function net_mazeDup.finishMazeStageResult(code)
	warning("please override this function -> net_mazeDup.finishMazeStageResult!")
end

function net_mazeDup.finishMazeStageResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_mazeDup.finishMazeStageResult(code)
end

function net_mazeDup.notifyOrbmentPOD(orbmentPOD)
	warning("please override this function -> net_mazeDup.notifyOrbmentPOD!")
end

function net_mazeDup.notifyOrbmentPOD_delegate(orbmentPOD)
	net_mazeDup.notifyOrbmentPOD(orbmentPOD)
end

function net_mazeDup.notifyMazeDup(mazeStagePOD)
	warning("please override this function -> net_mazeDup.notifyMazeDup!")
end

function net_mazeDup.notifyMazeDup_delegate(mazeStagePOD)
	net_mazeDup.notifyMazeDup(mazeStagePOD)
end

function net_mazeDup.notifyFinishMazeDup(fightOverPOD)
	warning("please override this function -> net_mazeDup.notifyFinishMazeDup!")
end

function net_mazeDup.notifyFinishMazeDup_delegate(fightOverPOD)
	net_mazeDup.notifyFinishMazeDup(fightOverPOD)
end

function net_mazeDup.notifyExitMazePlot()
	warning("please override this function -> net_mazeDup.notifyExitMazePlot!")
end

function net_mazeDup.notifyExitMazePlot_delegate()
	net_mazeDup.notifyExitMazePlot()
end

net_labyrinth = {}

function net_labyrinth.setFormation(formationHeros, replaceHeros)
	local success = LuaCodeInterface.Send(9602, formationHeros, replaceHeros)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.chageFormationPOD(difficulty, formationPOD)
	local success = LuaCodeInterface.Send(9603, difficulty, formationPOD)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.enterStage(difficulty)
	local success = LuaCodeInterface.Send(9604, difficulty)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.exitStage(difficulty, type)
	local success = LuaCodeInterface.Send(9605, difficulty, type)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.startEnterRoom(difficulty, roomId, jump, jumpCount)
	local success = LuaCodeInterface.Send(9606, difficulty, roomId, jump, jumpCount)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.enterRoomFinish(difficulty, roomId, jump, jumpCount)
	local success = LuaCodeInterface.Send(9607, difficulty, roomId, jump, jumpCount)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.freshEvent(difficulty, roomId)
	local success = LuaCodeInterface.Send(9608, difficulty, roomId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.freshBuff(difficulty, roomId)
	local success = LuaCodeInterface.Send(9609, difficulty, roomId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.holdEvent(difficulty, roomId)
	local success = LuaCodeInterface.Send(9610, difficulty, roomId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.submitEvent(difficulty, roomId, curEventId, curOptionId, merchantId, num, clientData)
	local success = LuaCodeInterface.Send(9611, difficulty, roomId, curEventId, curOptionId, merchantId, num, clientData)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.upgradeSenro()
	local success = LuaCodeInterface.Send(9612)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.resetSenro()
	local success = LuaCodeInterface.Send(9613)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.blackMarketUpgrade()
	local success = LuaCodeInterface.Send(9614)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.activeSenroTalent(id)
	local success = LuaCodeInterface.Send(9615, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.upgradeSenroTalent(id)
	local success = LuaCodeInterface.Send(9616, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.useLabyrinthItem(difficulty, itemMap)
	local success = LuaCodeInterface.Send(9617, difficulty, itemMap)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.freshStage()
	local success = LuaCodeInterface.Send(9618)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_labyrinth.setFormationResult(code, labyrinthDataPOD)
	warning("please override this function -> net_labyrinth.setFormationResult!")
end

function net_labyrinth.setFormationResult_delegate(code, labyrinthDataPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.setFormationResult(code, labyrinthDataPOD)
end

function net_labyrinth.chageFormationPODResult(code)
	warning("please override this function -> net_labyrinth.chageFormationPODResult!")
end

function net_labyrinth.chageFormationPODResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.chageFormationPODResult(code)
end

function net_labyrinth.enterStageResult(code, labyrinthStagePOD)
	warning("please override this function -> net_labyrinth.enterStageResult!")
end

function net_labyrinth.enterStageResult_delegate(code, labyrinthStagePOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.enterStageResult(code, labyrinthStagePOD)
end

function net_labyrinth.exitStageResult(code, difficulty, itemShows)
	warning("please override this function -> net_labyrinth.exitStageResult!")
end

function net_labyrinth.exitStageResult_delegate(code, difficulty, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.exitStageResult(code, difficulty, itemShows)
end

function net_labyrinth.startEnterRoomResult(code, stageMapPOD)
	warning("please override this function -> net_labyrinth.startEnterRoomResult!")
end

function net_labyrinth.startEnterRoomResult_delegate(code, stageMapPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.startEnterRoomResult(code, stageMapPOD)
end

function net_labyrinth.enterRoomFinishResult(code, stageMapPOD, animation)
	warning("please override this function -> net_labyrinth.enterRoomFinishResult!")
end

function net_labyrinth.enterRoomFinishResult_delegate(code, stageMapPOD, animation)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.enterRoomFinishResult(code, stageMapPOD, animation)
end

function net_labyrinth.freshEventResult(code)
	warning("please override this function -> net_labyrinth.freshEventResult!")
end

function net_labyrinth.freshEventResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.freshEventResult(code)
end

function net_labyrinth.freshBuffResult(code, buffFreshTime, buffs)
	warning("please override this function -> net_labyrinth.freshBuffResult!")
end

function net_labyrinth.freshBuffResult_delegate(code, buffFreshTime, buffs)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.freshBuffResult(code, buffFreshTime, buffs)
end

function net_labyrinth.holdEventResult(code, stageEventPOD)
	warning("please override this function -> net_labyrinth.holdEventResult!")
end

function net_labyrinth.holdEventResult_delegate(code, stageEventPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.holdEventResult(code, stageEventPOD)
end

function net_labyrinth.submitEventResult(code, itemShows)
	warning("please override this function -> net_labyrinth.submitEventResult!")
end

function net_labyrinth.submitEventResult_delegate(code, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.submitEventResult(code, itemShows)
end

function net_labyrinth.upgradeSenroResult(code, senroPOD, itemShows)
	warning("please override this function -> net_labyrinth.upgradeSenroResult!")
end

function net_labyrinth.upgradeSenroResult_delegate(code, senroPOD, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.upgradeSenroResult(code, senroPOD, itemShows)
end

function net_labyrinth.resetSenroResult(code, senroPOD, itemShows)
	warning("please override this function -> net_labyrinth.resetSenroResult!")
end

function net_labyrinth.resetSenroResult_delegate(code, senroPOD, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.resetSenroResult(code, senroPOD, itemShows)
end

function net_labyrinth.blackMarketUpgradeResult(code, level)
	warning("please override this function -> net_labyrinth.blackMarketUpgradeResult!")
end

function net_labyrinth.blackMarketUpgradeResult_delegate(code, level)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.blackMarketUpgradeResult(code, level)
end

function net_labyrinth.activeSenroTalentResult(code, senroPOD)
	warning("please override this function -> net_labyrinth.activeSenroTalentResult!")
end

function net_labyrinth.activeSenroTalentResult_delegate(code, senroPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.activeSenroTalentResult(code, senroPOD)
end

function net_labyrinth.upgradeSenroTalentResult(code, SenroTalentPOD)
	warning("please override this function -> net_labyrinth.upgradeSenroTalentResult!")
end

function net_labyrinth.upgradeSenroTalentResult_delegate(code, SenroTalentPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.upgradeSenroTalentResult(code, SenroTalentPOD)
end

function net_labyrinth.useLabyrinthItemResult(code, itemShows)
	warning("please override this function -> net_labyrinth.useLabyrinthItemResult!")
end

function net_labyrinth.useLabyrinthItemResult_delegate(code, itemShows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.useLabyrinthItemResult(code, itemShows)
end

function net_labyrinth.freshStageResult(code, labyrinthDataPOD)
	warning("please override this function -> net_labyrinth.freshStageResult!")
end

function net_labyrinth.freshStageResult_delegate(code, labyrinthDataPOD)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_labyrinth.freshStageResult(code, labyrinthDataPOD)
end

function net_labyrinth.notifySeasonOver(seasonId, itemShows)
	warning("please override this function -> net_labyrinth.notifySeasonOver!")
end

function net_labyrinth.notifySeasonOver_delegate(seasonId, itemShows)
	net_labyrinth.notifySeasonOver(seasonId, itemShows)
end

function net_labyrinth.notifyStageExit(difficulty)
	warning("please override this function -> net_labyrinth.notifyStageExit!")
end

function net_labyrinth.notifyStageExit_delegate(difficulty)
	net_labyrinth.notifyStageExit(difficulty)
end

function net_labyrinth.updateLabyrinthDataPOD(labyrinthDataPOD)
	warning("please override this function -> net_labyrinth.updateLabyrinthDataPOD!")
end

function net_labyrinth.updateLabyrinthDataPOD_delegate(labyrinthDataPOD)
	net_labyrinth.updateLabyrinthDataPOD(labyrinthDataPOD)
end

function net_labyrinth.updateStageMapPOD(stageMapPOD)
	warning("please override this function -> net_labyrinth.updateStageMapPOD!")
end

function net_labyrinth.updateStageMapPOD_delegate(stageMapPOD)
	net_labyrinth.updateStageMapPOD(stageMapPOD)
end

function net_labyrinth.updateLabyrinthStagePOD(labyrinthStagePOD)
	warning("please override this function -> net_labyrinth.updateLabyrinthStagePOD!")
end

function net_labyrinth.updateLabyrinthStagePOD_delegate(labyrinthStagePOD)
	net_labyrinth.updateLabyrinthStagePOD(labyrinthStagePOD)
end

function net_labyrinth.updateLabyrinthWarehouse(updateItems)
	warning("please override this function -> net_labyrinth.updateLabyrinthWarehouse!")
end

function net_labyrinth.updateLabyrinthWarehouse_delegate(updateItems)
	net_labyrinth.updateLabyrinthWarehouse(updateItems)
end

function net_labyrinth.addLabyrinthWarehouse(updateItems)
	warning("please override this function -> net_labyrinth.addLabyrinthWarehouse!")
end

function net_labyrinth.addLabyrinthWarehouse_delegate(updateItems)
	net_labyrinth.addLabyrinthWarehouse(updateItems)
end

function net_labyrinth.removeLabyrinthWarehouse(cids)
	warning("please override this function -> net_labyrinth.removeLabyrinthWarehouse!")
end

function net_labyrinth.removeLabyrinthWarehouse_delegate(cids)
	net_labyrinth.removeLabyrinthWarehouse(cids)
end

function net_labyrinth.updateStageWarehouse(updateItems)
	warning("please override this function -> net_labyrinth.updateStageWarehouse!")
end

function net_labyrinth.updateStageWarehouse_delegate(updateItems)
	net_labyrinth.updateStageWarehouse(updateItems)
end

function net_labyrinth.notifyFinishEvent(stageEventPOD, itemShows)
	warning("please override this function -> net_labyrinth.notifyFinishEvent!")
end

function net_labyrinth.notifyFinishEvent_delegate(stageEventPOD, itemShows)
	net_labyrinth.notifyFinishEvent(stageEventPOD, itemShows)
end

function net_labyrinth.updateLabyrinthHerosAndFormation(heroPods, formationPOD)
	warning("please override this function -> net_labyrinth.updateLabyrinthHerosAndFormation!")
end

function net_labyrinth.updateLabyrinthHerosAndFormation_delegate(heroPods, formationPOD)
	net_labyrinth.updateLabyrinthHerosAndFormation(heroPods, formationPOD)
end

function net_labyrinth.updateLabyrinthBuff(mapBuffs)
	warning("please override this function -> net_labyrinth.updateLabyrinthBuff!")
end

function net_labyrinth.updateLabyrinthBuff_delegate(mapBuffs)
	net_labyrinth.updateLabyrinthBuff(mapBuffs)
end

function net_labyrinth.notifyTranslateItem(itemShows)
	warning("please override this function -> net_labyrinth.notifyTranslateItem!")
end

function net_labyrinth.notifyTranslateItem_delegate(itemShows)
	net_labyrinth.notifyTranslateItem(itemShows)
end

function net_labyrinth.notifyTranslateRoom(curRoomId, nextRoomId)
	warning("please override this function -> net_labyrinth.notifyTranslateRoom!")
end

function net_labyrinth.notifyTranslateRoom_delegate(curRoomId, nextRoomId)
	net_labyrinth.notifyTranslateRoom(curRoomId, nextRoomId)
end

function net_labyrinth.updateStageEventLink(stageEventLinkPOD)
	warning("please override this function -> net_labyrinth.updateStageEventLink!")
end

function net_labyrinth.updateStageEventLink_delegate(stageEventLinkPOD)
	net_labyrinth.updateStageEventLink(stageEventLinkPOD)
end

net_activityDup = {}

function net_activityDup.enterDup(passId, units, agentSkill)
	local success = LuaCodeInterface.Send(9702, passId, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_activityDup.receiveReward(chapterId, star)
	local success = LuaCodeInterface.Send(9703, chapterId, star)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_activityDup.enterDupResult(code)
	warning("please override this function -> net_activityDup.enterDupResult!")
end

function net_activityDup.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_activityDup.enterDupResult(code)
end

function net_activityDup.receiveRewardResult(code, itemShowPODS)
	warning("please override this function -> net_activityDup.receiveRewardResult!")
end

function net_activityDup.receiveRewardResult_delegate(code, itemShowPODS)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_activityDup.receiveRewardResult(code, itemShowPODS)
end

function net_activityDup.notifyDup(dupPODs)
	warning("please override this function -> net_activityDup.notifyDup!")
end

function net_activityDup.notifyDup_delegate(dupPODs)
	net_activityDup.notifyDup(dupPODs)
end

function net_activityDup.notifyRemoveDup(dupPOD)
	warning("please override this function -> net_activityDup.notifyRemoveDup!")
end

function net_activityDup.notifyRemoveDup_delegate(dupPOD)
	net_activityDup.notifyRemoveDup(dupPOD)
end

function net_activityDup.notifyFinishDup(fightOverPOD)
	warning("please override this function -> net_activityDup.notifyFinishDup!")
end

function net_activityDup.notifyFinishDup_delegate(fightOverPOD)
	net_activityDup.notifyFinishDup(fightOverPOD)
end

net_richMan = {}

function net_richMan.richMan(activityCid)
	local success = LuaCodeInterface.Send(9802, activityCid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_richMan.richManResult(code, randSum, shows)
	warning("please override this function -> net_richMan.richManResult!")
end

function net_richMan.richManResult_delegate(code, randSum, shows)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_richMan.richManResult(code, randSum, shows)
end

function net_richMan.notityRichMan(richManPOD)
	warning("please override this function -> net_richMan.notityRichMan!")
end

function net_richMan.notityRichMan_delegate(richManPOD)
	net_richMan.notityRichMan(richManPOD)
end

function net_richMan.notityRemoveRichMan(richManPOD)
	warning("please override this function -> net_richMan.notityRemoveRichMan!")
end

function net_richMan.notityRemoveRichMan_delegate(richManPOD)
	net_richMan.notityRemoveRichMan(richManPOD)
end

net_challengeDup = {}

function net_challengeDup.enterDup(passId, units, agentSkill)
	local success = LuaCodeInterface.Send(9902, passId, units, agentSkill)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_challengeDup.enterDupResult(code)
	warning("please override this function -> net_challengeDup.enterDupResult!")
end

function net_challengeDup.enterDupResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_challengeDup.enterDupResult(code)
end

function net_challengeDup.notifyFinishDup(challengeDupPOD)
	warning("please override this function -> net_challengeDup.notifyFinishDup!")
end

function net_challengeDup.notifyFinishDup_delegate(challengeDupPOD)
	net_challengeDup.notifyFinishDup(challengeDupPOD)
end

net_activityRecharge = {}

function net_activityRecharge.getRewards(activityCid, id)
	local success = LuaCodeInterface.Send(10102, activityCid, id)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_activityRecharge.getRewardsResult(code, activityCid, id, rewards)
	warning("please override this function -> net_activityRecharge.getRewardsResult!")
end

function net_activityRecharge.getRewardsResult_delegate(code, activityCid, id, rewards)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_activityRecharge.getRewardsResult(code, activityCid, id, rewards)
end

net_centerChat = {}

function net_centerChat.sendChat(chat)
	local success = LuaCodeInterface.Send(100102, chat)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerChat.switchRoom(roomId)
	local success = LuaCodeInterface.Send(100103, roomId)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerChat.sendChatResult(code)
	warning("please override this function -> net_centerChat.sendChatResult!")
end

function net_centerChat.sendChatResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerChat.sendChatResult(code)
end

function net_centerChat.switchRoomResult(code, chatRoomId)
	warning("please override this function -> net_centerChat.switchRoomResult!")
end

function net_centerChat.switchRoomResult_delegate(code, chatRoomId)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerChat.switchRoomResult(code, chatRoomId)
end

function net_centerChat.notifyChat(chat)
	warning("please override this function -> net_centerChat.notifyChat!")
end

function net_centerChat.notifyChat_delegate(chat)
	net_centerChat.notifyChat(chat)
end

function net_centerChat.notifyChatRoom(chatRoomId)
	warning("please override this function -> net_centerChat.notifyChatRoom!")
end

function net_centerChat.notifyChatRoom_delegate(chatRoomId)
	net_centerChat.notifyChatRoom(chatRoomId)
end

net_centerRank = {}

function net_centerRank.getRank(rankId, count, needUserData)
	local success = LuaCodeInterface.Send(100202, rankId, count, needUserData)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerRank.getRankUserData(rankId, lastRanking, rank)
	local success = LuaCodeInterface.Send(100203, rankId, lastRanking, rank)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerRank.getRankGoalie(rankId, rankType, ranking)
	local success = LuaCodeInterface.Send(100204, rankId, rankType, ranking)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerRank.getRankResult(code, rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	warning("please override this function -> net_centerRank.getRankResult!")
end

function net_centerRank.getRankResult_delegate(code, rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerRank.getRankResult(code, rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
end

function net_centerRank.getRankUserDataResult(code, rankId, userData)
	warning("please override this function -> net_centerRank.getRankUserDataResult!")
end

function net_centerRank.getRankUserDataResult_delegate(code, rankId, userData)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerRank.getRankUserDataResult(code, rankId, userData)
end

function net_centerRank.getRankGoalieResult(code, rankId, rankingPOD, ranking, rankType)
	warning("please override this function -> net_centerRank.getRankGoalieResult!")
end

function net_centerRank.getRankGoalieResult_delegate(code, rankId, rankingPOD, ranking, rankType)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerRank.getRankGoalieResult(code, rankId, rankingPOD, ranking, rankType)
end

net_centerFriend = {}

function net_centerFriend.removeFriends(ids)
	local success = LuaCodeInterface.Send(100302, ids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.applyFriends(ids)
	local success = LuaCodeInterface.Send(100303, ids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.dealWithApply(ids, allow)
	local success = LuaCodeInterface.Send(100304, ids, allow)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.addBlacklist(pid)
	local success = LuaCodeInterface.Send(100305, pid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.removeBlacklist(ids)
	local success = LuaCodeInterface.Send(100306, ids)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.searchPlayer(guid)
	local success = LuaCodeInterface.Send(100307, guid)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.setRemark(friendId, remark)
	local success = LuaCodeInterface.Send(100308, friendId, remark)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.recommend()
	local success = LuaCodeInterface.Send(100309)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.recommendHelpHeros(maxHeroLv)
	local success = LuaCodeInterface.Send(100310, maxHeroLv)

	if success then
		NetCommController.Sending()
	end

	return success
end

function net_centerFriend.removeFriendsResult(code)
	warning("please override this function -> net_centerFriend.removeFriendsResult!")
end

function net_centerFriend.removeFriendsResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.removeFriendsResult(code)
end

function net_centerFriend.applyFriendsResult(code)
	warning("please override this function -> net_centerFriend.applyFriendsResult!")
end

function net_centerFriend.applyFriendsResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.applyFriendsResult(code)
end

function net_centerFriend.dealWithApplyResult(code)
	warning("please override this function -> net_centerFriend.dealWithApplyResult!")
end

function net_centerFriend.dealWithApplyResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.dealWithApplyResult(code)
end

function net_centerFriend.addBlacklistResult(code)
	warning("please override this function -> net_centerFriend.addBlacklistResult!")
end

function net_centerFriend.addBlacklistResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.addBlacklistResult(code)
end

function net_centerFriend.removeBlacklistResult(code)
	warning("please override this function -> net_centerFriend.removeBlacklistResult!")
end

function net_centerFriend.removeBlacklistResult_delegate(code)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.removeBlacklistResult(code)
end

function net_centerFriend.searchPlayerResult(code, friend)
	warning("please override this function -> net_centerFriend.searchPlayerResult!")
end

function net_centerFriend.searchPlayerResult_delegate(code, friend)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.searchPlayerResult(code, friend)
end

function net_centerFriend.setRemarkResult(code, friend)
	warning("please override this function -> net_centerFriend.setRemarkResult!")
end

function net_centerFriend.setRemarkResult_delegate(code, friend)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.setRemarkResult(code, friend)
end

function net_centerFriend.recommendResult(code, friends)
	warning("please override this function -> net_centerFriend.recommendResult!")
end

function net_centerFriend.recommendResult_delegate(code, friends)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.recommendResult(code, friends)
end

function net_centerFriend.recommendHelpHerosResult(code, helpHeros)
	warning("please override this function -> net_centerFriend.recommendHelpHerosResult!")
end

function net_centerFriend.recommendHelpHerosResult_delegate(code, helpHeros)
	NetCommController.Responded()

	if code ~= 0 then
		NoticeModule.ShowServerError(code)

		return
	end

	net_centerFriend.recommendHelpHerosResult(code, helpHeros)
end

function net_centerFriend.notifyAddFriend(friends)
	warning("please override this function -> net_centerFriend.notifyAddFriend!")
end

function net_centerFriend.notifyAddFriend_delegate(friends)
	net_centerFriend.notifyAddFriend(friends)
end

function net_centerFriend.notifyDeleteFriend(ids)
	warning("please override this function -> net_centerFriend.notifyDeleteFriend!")
end

function net_centerFriend.notifyDeleteFriend_delegate(ids)
	net_centerFriend.notifyDeleteFriend(ids)
end

function net_centerFriend.notifyUpdateFriend(friends)
	warning("please override this function -> net_centerFriend.notifyUpdateFriend!")
end

function net_centerFriend.notifyUpdateFriend_delegate(friends)
	net_centerFriend.notifyUpdateFriend(friends)
end
