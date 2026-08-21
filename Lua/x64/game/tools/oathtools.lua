local var_0_0 = require("game.config.WeddingCfg")
local var_0_1 = {}

var_0_1.OathRingAssetPath = "Char/OathRing_F"
var_0_1.OathRingAttachPoint = "auto_wedding_ring"

function var_0_1.IsOath(arg_1_0)
	if arg_1_0 == 6148 then
		arg_1_0 = 1054
	end

	return var_0_1.GetIsOpenOath() and OathCollectionContentData:GetOathState(arg_1_0)
end

function var_0_1.CheckNickNameCanRename(arg_2_0)
	local var_2_0 = OathCollectionContentData:GetNextRenameAvailableTime(arg_2_0)

	return var_2_0 <= manager.time:GetServerTime(), var_2_0
end

function var_0_1.GetFormatRenameCooldownTips()
	local var_3_0 = GameSetting.wedding_rename_time.value
	local var_3_1 = var_3_0[1]
	local var_3_2 = var_3_0[2]
	local var_3_3 = TimeMgr.DaySecs * var_3_1
	local var_3_4 = manager.time:GetServerTime() + var_3_3

	return manager.time:GetLostTimeStr(var_3_4, true, true), var_3_2
end

function var_0_1.GetOathEquityList(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = WeddingRightCfg.get_id_list_by_hero_id[arg_4_0]
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_2 = WeddingRightCfg[iter_4_1]

		if var_4_2.level == arg_4_1 and (var_4_2.is_show == arg_4_2 or var_4_2.is_show == OathConst.OATH_EQUITY_SHOW_TYPE.ALL) then
			table.insert(var_4_1, iter_4_1)
		end
	end

	return var_4_1
end

function var_0_1.IsHeroUseSpecialOathRing(arg_5_0)
	return var_0_0[arg_5_0].ring_id ~= ItemConst.OATH_RING
end

function var_0_1.GetOathAvailableHeroCnt()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(var_0_0.all) do
		local var_6_1 = var_0_1.IsHeroUseSpecialOathRing(iter_6_1)
		local var_6_2 = HeroData:GetHeroData(iter_6_1).unlock == 1

		if not var_6_1 and var_6_2 and not var_0_1.IsOath(iter_6_1) then
			var_6_0 = var_6_0 + 1
		end
	end

	return var_6_0
end

function var_0_1.GetIsCanOathHero(arg_7_0)
	if not table.indexof(var_0_0.all, arg_7_0) then
		return false
	else
		return true
	end
end

function var_0_1.GetIsOpenOath()
	local var_8_0 = var_0_1.CheckOpenOathCondition() and true or false

	return not JumpTools.IsSystemOperationStoped(ViewConst.SYSTEM_ID.OATH_SYSTEM) and not var_8_0
end

function var_0_1.CheckOpenOathCondition()
	return JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.OATH_SYSTEM)
end

function var_0_1.GetOathCharacterSprite(arg_10_0)
	local var_10_0 = var_0_0[arg_10_0]

	return getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. var_10_0.skin_id)
end

function var_0_1.GetOathCharacterPopSprite(arg_11_0)
	local var_11_0 = var_0_0[arg_11_0]

	return pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. var_11_0.skin_id)
end

function var_0_1.GetOathCharacterEnterSprite(arg_12_0)
	local var_12_0 = var_0_0[arg_12_0]

	return getSpriteWithoutAtlas("TextureConfig/Hero_Oath/EnterRole/" .. var_12_0.skin_id)
end

function var_0_1.GetOathHeadSprite(arg_13_0)
	return pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. arg_13_0)
end

function var_0_1.GetOathBookPrefab(arg_14_0)
	return "Widget/System/Hero_Oath/Engagement/EngagementPopUI_" .. arg_14_0
end

function var_0_1.GetOathLvShowTips(arg_15_0)
	if OathConst.OATH_LV_NAME_KEY[arg_15_0] then
		return GetTips(OathConst.OATH_LV_NAME_KEY[arg_15_0])
	else
		return nil
	end
end

local function var_0_2(arg_16_0)
	local var_16_0 = HeroTools.GetShopIdBySkinId(arg_16_0)

	if var_16_0 then
		local var_16_1 = getShopCfg(var_16_0)
		local var_16_2 = nullable(var_16_1, "give_back_list")

		if var_16_2 then
			for iter_16_0, iter_16_1 in ipairs(var_16_2) do
				local var_16_3 = iter_16_1.id

				if var_16_3 == ItemConst.OATH_RING_COUPON or ItemTools.GetTemplateItemID(var_16_3) == ItemConst.OATH_RING_COUPON then
					return true
				end
			end
		end
	end

	return false
end

function var_0_1.CheckAnySkinGiveBackOathRingCoupon()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(var_0_0.all) do
		local var_17_1 = var_0_0[iter_17_1].skin_id

		if var_0_2(var_17_1) then
			table.insert(var_17_0, var_17_1)
		end
	end

	CommonTools.UniversalSortEx(var_17_0, {
		map = function(arg_18_0)
			local var_18_0 = ShopTools.GetGoodsIdBySkinId(arg_18_0)
			local var_18_1 = getShopCfg(var_18_0)

			return nullable(var_18_1, "shop_sort") or -1
		end
	})

	for iter_17_2, iter_17_3 in ipairs(var_17_0) do
		if not HeroTools.GetHasOwnedSkin(iter_17_3) then
			return iter_17_3
		end
	end

	return nil
end

function var_0_1.GetOathUnPlayOpenPoltID()
	local var_19_0
	local var_19_1 = OathTools.GetOathOpenPoltList()

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if not manager.story:IsStoryPlayed(iter_19_1) then
			var_19_0 = iter_19_1

			break
		end
	end

	return var_19_0
end

function var_0_1.GetOathOpenPoltList()
	return GameSetting.wedding_unlock_plot.value
end

function var_0_1.GetIsNeedPlayOathPlot()
	if not OathTools.GetIsOpenOath() then
		return false
	end

	local var_21_0 = OathTools.GetOathOpenPoltList()
	local var_21_1 = true

	for iter_21_0, iter_21_1 in pairs(var_21_0) do
		if not manager.story:IsStoryPlayed(iter_21_1) then
			var_21_1 = false
		end
	end

	return not var_21_1
end

function var_0_1.JumpToOathView(arg_22_0)
	if not OathTools.GetIsNeedPlayOathPlot() then
		JumpTools.OpenPageByJump("/oathMainView", {
			selectHeroID = arg_22_0
		})
	else
		JumpTools.GoToSystem("/adminHomePageView", nil, ViewConst.SYSTEM_ID.ADMIN_SYSTEM)
	end
end

local var_0_3 = "%s_%s_%s"

function var_0_1.GetOathContentRedKey(arg_23_0, arg_23_1)
	return string.format(var_0_3, RedPointConst.OATH_NEW_CONTENT, arg_23_0, arg_23_1)
end

function var_0_1.GetHeroSortList(arg_24_0)
	table.sort(arg_24_0, function(arg_25_0, arg_25_1)
		local var_25_0 = var_0_0[arg_25_0]
		local var_25_1 = var_0_0[arg_25_1]
		local var_25_2 = OathTools.IsOath(arg_25_0) and 1 or 0
		local var_25_3 = OathTools.IsOath(arg_25_1) and 1 or 0

		if var_25_2 ~= var_25_3 then
			return var_25_2 < var_25_3
		else
			return arg_25_1 < arg_25_0
		end
	end)

	return arg_24_0
end

function var_0_1.IsCharaSecretUnlocked(arg_26_0)
	local var_26_0 = nullable(WeddingNewsCfg, arg_26_0, "condition")

	if var_26_0 then
		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			if not IsConditionAchieved(iter_26_1) then
				return false
			end
		end
	end

	return true
end

function var_0_1.GetCaptureSwitchList(arg_27_0, arg_27_1)
	local var_27_0 = {}
	local var_27_1 = WeddingCaptureSwitchCfg.get_id_list_by_character[arg_27_0]

	for iter_27_0, iter_27_1 in pairs(var_27_1) do
		if WeddingCaptureSwitchCfg[iter_27_1].switchType == arg_27_1 then
			table.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function var_0_1.GetDefalutSetting(arg_28_0, arg_28_1)
	return var_0_1.GetCaptureSwitchList(arg_28_0, arg_28_1)[1]
end

function var_0_1.GetFilterImg(arg_29_0, arg_29_1)
	return (string.format("TextureConfig/Hero_Oath/lens/%s/%s", arg_29_0, arg_29_1))
end

function var_0_1.IsCanShowInHeroInfoView()
	if gameContext:IsOpenRoute("newHero") then
		return true
	else
		return false
	end
end

return var_0_1
