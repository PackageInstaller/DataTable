return {
	PopActivityShareBaseLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityShareBaseLayer:create(...))
		end,
		checktextures = function(self)
			if not self then
				return {}
			end

			return self.activityId and {
				"ActivityShare_" .. self.activityId
			} or {}
		end
	},
	PopPhoneNumberLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopPhoneNumberLayer:create(...))
		end,
		textures = {
			"PopPhoneNumberLayer"
		}
	},
	PopReturnBackPacksLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopReturnBackPacksLayer:create(...))
		end,
		textures = {
			"PopReturnBackPacksLayer"
		}
	},
	PopNewRulePacksLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopNewRulePacksLayer:create(...))
		end,
		textures = {
			"PopReturnBackPacksLayer"
		}
	},
	PopRechargeDailyPrizeLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopRechargeDailyPrizeLayer:create(...))
		end
	},
	PopRechargeIconLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopRechargeIconLayer:create(...))
		end,
		textures = {
			"recharge",
			"MarketLayer"
		}
	},
	PopTGVRechargeInfoLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTGVRechargeInfoLayer:create(...))
		end,
		textures = {
			"recharge",
			"MarketLayer"
		}
	},
	PopActivityFeedBackLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityFeedBackLayer:create(...))
		end,
		textures = {
			"recharge",
			"MarketLayer"
		}
	},
	ActivityTimeSignTemplateLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.ActivityNew.BaseLayer.ActivityTimeSignTemplateLayer")

			return (ActivityTimeSignTemplateLayer:create(...))
		end
	},
	SkinCollectLayer = {
		hideUI = true,
		createLayer = function(...)
			require("view.Layer.SkinCollectLayer")

			return (SkinCollectLayer:create(...))
		end,
		textures = {
			"DropItemDisplay"
		}
	},
	PopRechargePreviewLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopRechargePreviewLayer:create(...))
		end,
		textures = {
			"PopRechargePreviewLayer"
		}
	},
	PopOpenBagInfoLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopOpenBagInfoLayer:create(...))
		end,
		textures = {
			"MarketLayer"
		}
	},
	MarketLayer = {
		hideUI = true,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.MarketLayer")

			local var_14_0 = MarketLayer:create(...)

			var_14_0.panelBottom:setPositionY(var_14_0.panelBottom:getPositionY() - GameDisplay.fix_y)

			return var_14_0
		end,
		textures = {
			"MarketLayer",
			"CostumeRoomLayer"
		}
	},
	PopActivityDropInfoLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityDropInfoLayer:create(...))
		end
	},
	ActivityNoviceTaskLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (ActivityNoviceTaskLayer:create(...))
		end,
		textures = {
			"ActivityNoviceTaskLayer",
			"TaskLayer"
		}
	},
	PopTwistEggCostTicketLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopTwistEggCostTicketLayer:create(...))
		end
	},
	PopActivityItemGainLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityItemGainLayer:create(...))
		end,
		textures = {
			"ActivityRoulette_231"
		}
	},
	PopBasicGoGainLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBasicGoGainLayer:create(...))
		end
	},
	PopBuyBagWeight = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopBuyBagWeight:create(...))
		end
	},
	BagSellItemPopLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (BagSellItemPopLayer:create(...))
		end
	},
	PopComponentReinforceLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopComponentReinforceLayer:create(...))
		end,
		textures = {
			"PopComponentReinforceLayer",
			"pop_component_strengthen_layer"
		}
	},
	PopQuickEntranceLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopQuickEntranceLayer:create(...))
		end,
		textures = {
			"PopQuickEntranceLayer"
		}
	},
	PopFoolActionLayter = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopFoolActionLayter:create(...))
		end,
		textures = {
			"PopFoolActionLayter"
		}
	},
	PopFoolHeadCollectLayter = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopFoolHeadCollectLayter:create(...))
		end,
		textures = {
			"PopFoolHeadCollectLayter"
		}
	},
	PopFoolTwistJumpLayter = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopFoolTwistJumpLayter:create(...))
		end,
		textures = {
			"PopFoolTwistJumpLayter"
		}
	},
	PopOpenRandomGiftLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopOpenRandomGiftLayer:create(...))
		end
	},
	PopMarketBuyOnekeyLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopMarketBuyOnekeyLayer")

			return (PopMarketBuyOnekeyLayer:create(...))
		end,
		textures = {
			"PopMarketBuyOnekeyLayer"
		}
	},
	DormRoomPopLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.DormitoryLayer")
			require("view.Layer.DormRoomLayer")
			require("view.Layer.DormRoomPopLayer")

			return (DormRoomPopLayer:create(...))
		end,
		textures = {
			"Dormitory",
			"room_widget"
		}
	},
	PopSupermarketLayer = {
		hideUI = true,
		bg = TASK_BG,
		createLayer = function(...)
			require("view.Layer.SupermarketLayer.SupermarketLayer")

			return (PopSupermarketLayer:create(...))
		end,
		textures = {
			"SupermarketLayer",
			"recharge"
		}
	},
	PopActStoryBookLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActStoryBookLayer:create(...))
		end,
		textures = {
			"PopActStoryBookLayer"
		}
	},
	PopActStoryInfoLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActStoryInfoLayer:create(...))
		end,
		textures = {
			"PopActStoryInfoLayer"
		}
	},
	PopActivityCalendar = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityCalendar:create(...))
		end,
		textures = {
			"PopActivityCalendar"
		}
	},
	PopStudyTaskLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopStudyTaskLayer:create(...))
		end,
		textures = {
			"PopStudyTaskLayer"
		}
	},
	PopActivityEntranceLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityEntranceLayer:create(...))
		end
	},
	CostumeRoomRewardLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.CostumeRoom.CostumeRoomRewardLayer")

			return (CostumeRoomRewardLayer:create(...))
		end,
		textures = {
			"CostumeRoomRewardLayer"
		}
	},
	PopBindMobileLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBindMobileLayer")

			return (PopBindMobileLayer:create(...))
		end,
		textures = {
			"PopBindMobileLayer"
		}
	},
	ActivityStoryLayer_230 = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity230.ActivityStoryLayer_230")

			return (ActivityStoryLayer_230:create(...))
		end,
		textures = {
			"ActivityStoryLayer_230"
		}
	},
	ActivityStoryTalkLayer_230 = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.ActivityNew.activity230.ActivityStoryTalkLayer_230")

			return (ActivityStoryTalkLayer_230:create(...))
		end,
		textures = {
			"ActivityStoryLayer_230"
		}
	},
	PopWeixinActivityLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopWeixinActivityLayer")

			return (PopWeixinActivityLayer:create(...))
		end,
		textures = {
			"PopWeixinActivityLayer"
		}
	},
	PopAutoDownloadLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopAutoDownloadLayer")

			return (PopAutoDownloadLayer:create(...))
		end,
		textures = {
			"AutoDownloadLayer"
		}
	},
	NoviceMonthCardPopLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.NoviceMonthCardPopLayer")

			return (NoviceMonthCardPopLayer:create(...))
		end,
		textures = {
			"NoviceMonthCardPopLayer"
		}
	},
	ReturnBackCardPopLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.ReturnBackCardPopLayer")

			return (ReturnBackCardPopLayer:create(...))
		end,
		textures = {
			"ReturnBackCardPopLayer"
		}
	},
	TestFightLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.TestFightLayer")

			return (TestFightLayer:create(...))
		end,
		textures = {
			"TestFightLayer"
		}
	},
	FastSoulStrengthSettingLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.FastSoulStrengthSettingLayer")

			return (FastSoulStrengthSettingLayer:create(...))
		end,
		textures = {
			"FastSoulStrengthSettingLayer"
		}
	},
	FastStrengthConfirmLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.FastStrengthConfirmLayer")

			return (FastStrengthConfirmLayer:create(...))
		end,
		textures = {
			"FastStrengthConfirmLayer"
		}
	},
	PrivilegePurchaseConfirmationLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.PrivilegePurchaseConfirmationLayer")

			return (PrivilegePurchaseConfirmationLayer:create(...))
		end,
		textures = {}
	},
	MonopolyBuffLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolyBuffLayer"):create(...))
		end
	},
	MonopolySandcastleLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolySandcastleLayer"):create(...))
		end
	},
	MonopolyRewardLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolyRewardLayer"):create(...))
		end
	},
	MonopolyDiceSelectLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolyDiceSelectLayer"):create(...))
		end
	},
	MonopolyPlayerWinLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolyPlayerWinLayer"):create(...))
		end
	},
	MonopolyTalkLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolyTalkLayer"):create(...))
		end
	},
	MonopolyTipsLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolyTipsLayer"):create(...))
		end
	},
	MonopolyEventHistoryLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolyEventHistoryLayer"):create(...))
		end
	},
	MonopolyAutoDiceSettingLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolyAutoDiceSettingLayer"):create(...))
		end
	},
	MonopolyBuildInfoLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Monopoly.MonopolyBuildInfoLayer"):create(...))
		end
	},
	HelpBattleFormationLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.HelpBattle.HelpBattleFormationLayer"):create(...))
		end,
		textures = {
			"HelpBattleFormationLayer"
		}
	},
	RewardPreviewLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.RewardPreviewLayer"):create(...))
		end,
		textures = {
			"RewardPreviewLayer"
		}
	},
	UrbanDefenseAchievementLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.UrbanDefenseAchievementLayer"):create(...))
		end
	},
	PopOnlineRewardLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopOnlineRewardLayer:create(...))
		end,
		textures = {
			"PopOnlineRewardLayer"
		}
	},
	ActivityGarrisonSelectLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.ActivityGarrison.ActivityGarrisonSelectLayer"):create(...))
		end
	},
	ActivityGarrisonTaskLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.ActivityGarrison.ActivityGarrisonTaskLayer"):create(...))
		end
	},
	WeaponBreakAnimationLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.WeaponBreakAnimationLayer"):create(...))
		end
	},
	HorcruxDevourLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.HorcruxDevour.HorcruxDevourLayer"):create(...))
		end,
		textures = {
			"HorcruxDevourLayer"
		}
	},
	HorcruxDevourSelectLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.HorcruxDevour.HorcruxDevourSelectLayer"):create(...))
		end,
		textures = {
			"HorcruxDevourSelectLayer"
		}
	},
	ActivityBuffLayer_505 = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.ActivityNew.activity505.ActivityBuffLayer_505"):create(...))
		end,
		textures = {
			"ActivityBuffLayer_505"
		}
	},
	PopActivityReturnDetailLayer = {
		hideUI = false,
		createLayer = function(...)
			require("view.Layer.Pops.PopBaseLayer")

			return (PopActivityReturnDetailLayer:create(...))
		end,
		textures = {
			"PopActivityReturnDetailLayer"
		}
	},
	flyChessDiceSelectLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.flyChess.flyChessDiceSelectLayer"):create(...))
		end
	},
	flyChessBuildSelectLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.flyChess.flyChessBuildSelectLayer"):create(...))
		end
	},
	flyChessLevelRewardLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.flyChess.flyChessLevelRewardLayer"):create(...))
		end
	},
	ActivityBakeryGameEndLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.ActivityBakery.ActivityBakeryGameEndLayer"):create(...))
		end,
		textures = {
			"ActivityBakeryGameEndLayer"
		}
	},
	ActivityBakeryHelpLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.ActivityBakery.ActivityBakeryHelpLayer"):create(...))
		end,
		textures = {
			"ActivityBakeryHelpLayer"
		}
	},
	ActivityBakeryLevelUpLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.ActivityBakery.ActivityBakeryLevelUpLayer"):create(...))
		end,
		textures = {
			"ActivityBakeryLevelUpLayer"
		}
	},
	PopActivityComboResultLayer = {
		hideUI = false,
		createLayer = function(...)
			return (require("view.Layer.Pops.PopActivityComboResultLayer"):create(...))
		end,
		checktextures = function(self)
			if not self then
				return {}
			end

			return self.activityId and {
				"PopActivityComboResultLayer_" .. self.activityId
			} or {}
		end
	}
}
