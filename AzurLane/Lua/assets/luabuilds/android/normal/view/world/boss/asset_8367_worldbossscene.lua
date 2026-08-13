class = var_0_10000

local var_0_0 = "WorldBossScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

var_0_1.PAGE_ENTRANCE = 0
var_0_1.PAGE_CHALLENGE = 1
var_0_1.PAGE_CURRENT = 2
var_0_1.PAGE_ARCHIVES_CHALLENGE = 3
var_0_1.PAGE_ARCHIVES = 4
var_0_1.PAGE_ARCHIVES_LIST = 5
var_0_1.ON_SWITCH = "WorldBossScene:ON_SWITCH"
var_0_1.ON_QUIT_ARCHIVES_LIST = "WorldBossScene:ON_QUIT_ARCHIVES_LIST"
var_0_1.Listeners = {
	onBossUpdated = "OnBossUpdated"
}

function var_0_1.getUIName(arg_1_0)
	return "WorldBossUI"
end

function var_0_1.SetBossProxy(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.bossProxy then
		return
	end

	arg_2_0.bossProxy = arg_2_1
	arg_2_0.metaCharacterProxy = arg_2_2

	local var_2_0 = arg_2_0.bossProxy

	arg_2_0.boss = var_3.GetBoss(var_2_0)
	WorldBossEntrancePage = var_3
	arg_2_0.entrancePage = var_3.New(arg_2_0.pagesTF, arg_2_0.event, arg_2_0.contextData)

	local var_2_1 = arg_2_0.entrancePage

	var_3.Setup(var_2_1, arg_2_0.bossProxy)

	CurrentWorldBossChallengePage = var_3
	arg_2_0.challengeCurrentBossPage = var_3.New(arg_2_0.pagesTF, arg_2_0.event, arg_2_0.contextData)

	local var_2_2 = arg_2_0.challengeCurrentBossPage

	var_3.Setup(var_2_2, arg_2_0.bossProxy)

	CurrentWorldBossEmptyPage = var_3
	arg_2_0.currentEmptyPage = var_3.New(arg_2_0.pagesTF, arg_2_0.event)

	local var_2_3 = arg_2_0.currentEmptyPage

	var_3.Setup(var_2_3, arg_2_0.bossProxy)

	CurrentWorldBossDetailPage = var_3
	arg_2_0.currentBossDetailPage = var_3.New(arg_2_0.pagesTF, arg_2_0.event)

	local var_2_4 = arg_2_0.currentBossDetailPage

	var_3.Setup(var_2_4, arg_2_0.bossProxy)

	ArchivesWorldBossChallengePage = var_3
	arg_2_0.challengeArchivesBossPage = var_3.New(arg_2_0.pagesTF, arg_2_0.event, arg_2_0.contextData)

	local var_2_5 = arg_2_0.challengeArchivesBossPage

	var_3.Setup(var_2_5, arg_2_0.bossProxy)

	ArchivesWorldBossListPage = var_3
	arg_2_0.archivesListPage = var_3.New(arg_2_0.pagesTF, arg_2_0.event)

	local var_2_6 = arg_2_0.archivesListPage

	var_3.Setup(var_2_6, arg_2_0.bossProxy)

	ArchivesWorldBossEmptyPage = var_3
	arg_2_0.archivesEmptyPage = var_3.New(arg_2_0.pagesTF, arg_2_0.event)

	local var_2_7 = arg_2_0.archivesEmptyPage

	var_3.Setup(var_2_7, arg_2_0.bossProxy)

	ArchivesWorldBossDetailPage = var_3
	arg_2_0.archivesDetailPage = var_3.New(arg_2_0.pagesTF, arg_2_0.event)

	local var_2_8 = arg_2_0.archivesDetailPage

	var_3.Setup(var_2_8, arg_2_0.bossProxy)

	WorldBossFormationPreViewPage = var_3
	arg_2_0.formationPreviewPage = var_3.New(arg_2_0.pagesTF, arg_2_0.event)

	local var_2_9 = arg_2_0.bossProxy
	local var_2_10 = var_3.AddListener

	WorldBossProxy = var_5

	var_2_10(var_2_9, var_5.EventBossUpdated, arg_2_0.onBossUpdated)

	return
end

function var_0_1.AddListeners(arg_3_0)
	arg_3_0:bind(var_0_1.ON_SWITCH, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0

		var_2.SwitchPage(var_4_0, arg_4_1)

		return
	end)
	arg_3_0:bind(var_0_1.ON_QUIT_ARCHIVES_LIST, function()
		local var_5_0 = arg_3_0

		var_0.OnBack(var_5_0)

		return
	end)

	return
end

function var_0_1.RemoveListeners(arg_6_0)
	local var_6_0 = arg_6_0.bossProxy
	local var_6_1 = var_1.RemoveListener

	WorldBossProxy = var_1_10003

	var_6_1(var_6_0, var_1_10003.EventBossUpdated, arg_6_0.onBossUpdated)

	return
end

function var_0_1.OnBossUpdated(arg_7_0)
	local var_7_0 = arg_7_0.bossProxy

	arg_7_0.boss = var_1.GetBoss(var_7_0)

	if arg_7_0.page == arg_7_0.currentBossDetailPage or arg_7_0.page == arg_7_0.archivesDetailPage or arg_7_0.page == arg_7_0.currentEmptyPage or arg_7_0.page == arg_7_0.archivesEmptyPage then
		arg_7_0:SwitchPage(var_0_1.PAGE_ENTRANCE)
	end

	return
end

function var_0_1.OnShowFormationPreview(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.formationPreviewPage

	var_2.ExecuteAction(var_8_0, "Show", arg_8_1)

	return
end

function var_0_1.OnRemoveLayers(arg_9_0)
	if arg_9_0.currentBossDetailPage then
		local var_9_0 = arg_9_0.currentBossDetailPage

		if var_1.GetLoaded(var_9_0) then
			local var_9_1 = arg_9_0.currentBossDetailPage

			if var_1.isShowing(var_9_1) then
				local var_9_2 = arg_9_0.currentBossDetailPage

				var_1.TryPlayGuide(var_9_2)
			end
		end
	end

	return
end

function var_0_1.OnAutoBattleResult(arg_10_0, arg_10_1)
	if arg_10_0.archivesDetailPage then
		local var_10_0 = arg_10_0.archivesDetailPage

		if var_2.isShowing(var_10_0) then
			local var_10_1 = arg_10_0.archivesDetailPage

			var_2.OnAutoBattleResult(var_10_1, arg_10_1)
		end
	end

	return
end

function var_0_1.OnAutoBattleStart(arg_11_0, arg_11_1)
	if arg_11_0.archivesDetailPage then
		local var_11_0 = arg_11_0.archivesDetailPage

		if var_2.isShowing(var_11_0) then
			local var_11_1 = arg_11_0.archivesDetailPage

			var_2.OnAutoBattleStart(var_11_1, arg_11_1)
		end
	end

	return
end

function var_0_1.OnSwitchArchives(arg_12_0)
	if arg_12_0.archivesListPage then
		local var_12_0 = arg_12_0.archivesListPage

		if var_1.GetLoaded(var_12_0) then
			local var_12_1 = arg_12_0.archivesListPage

			if var_1.isShowing(var_12_1) then
				local var_12_2 = arg_12_0.archivesListPage

				var_1.OnSwitchArchives(var_12_2)
			end
		end
	end

	return
end

function var_0_1.OnGetMetaAwards(arg_13_0)
	if arg_13_0.archivesListPage then
		local var_13_0 = arg_13_0.archivesListPage

		if var_1.GetLoaded(var_13_0) then
			local var_13_1 = arg_13_0.archivesListPage

			if var_1.isShowing(var_13_1) then
				local var_13_2 = arg_13_0.archivesListPage

				var_1.OnGetMetaAwards(var_13_2)
			end
		end
	end

	return
end

function var_0_1.getAwardDone(arg_14_0)
	if arg_14_0.page == arg_14_0.challengeCurrentBossPage then
		local var_14_0 = arg_14_0.challengeCurrentBossPage

		var_1.ExecuteAction(var_14_0, "CloseGetPage")
	end

	if arg_14_0.page == arg_14_0.currentEmptyPage or arg_14_0.page == arg_14_0.currentBossDetailPage then
		local var_14_1 = arg_14_0.page

		if var_1.GetLoaded(var_14_1) then
			local var_14_2 = arg_14_0.page.metaWorldbossBtn

			var_1.Update(var_14_2)
		end
	end

	return
end

function var_0_1.init(arg_15_0)
	pairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(var_0_1.Listeners) do
		arg_15_0[iter_15_0] = function(...)
			var_0_1[iter_15_1](arg_15_0, ...)

			return
		end
	end

	local var_15_0 = arg_15_0._tf

	arg_15_0.backBtn = var_1.Find(var_15_0, "back_btn")

	local var_15_1 = arg_15_0._tf

	arg_15_0.pagesTF = var_1.Find(var_15_1, "pages")

	arg_15_0:AddListeners()

	return
end

function var_0_1.didEnter(arg_17_0)
	arg_17_0.pageStack = {}
	onButton = var_1

	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.backBtn

	local function var_17_2()
		local var_18_0 = arg_17_0

		var_0.OnBack(var_18_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_17_0, var_17_1, var_17_2, var_1_10005)

	local var_17_3 = arg_17_0
	local var_17_4 = arg_17_0.emit

	WorldBossMediator = var_17_1

	var_17_4(var_17_3, var_17_1.ON_FETCH_BOSS)

	return
end

function var_0_1.OnBack(arg_19_0)
	if #arg_19_0.pageStack <= 1 then
		arg_19_0:emit(var_0_1.ON_BACK)

		return
	end

	table = var_1

	var_1.remove(arg_19_0.pageStack, #arg_19_0.pageStack)

	local var_19_0 = arg_19_0.pageStack[#arg_19_0.pageStack]

	arg_19_0:_SwitchPage(var_19_0)

	return
end

function var_0_1.SwitchPage(arg_20_0, arg_20_1)
	arg_20_0:_SwitchPage(arg_20_1)

	if #arg_20_0.pageStack > 1 and arg_20_0.pageStack[#arg_20_0.pageStack - 1] == arg_20_1 then
		table = var_2

		var_2.remove(arg_20_0.pageStack, #arg_20_0.pageStack)
	else
		table = var_2

		var_2.insert(arg_20_0.pageStack, arg_20_1)
	end

	return
end

function var_0_1.GetTargetPageType(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 == var_0_1.PAGE_CHALLENGE then
		return arg_21_0.challengeCurrentBossPage
	elseif arg_21_1 == var_0_1.PAGE_ARCHIVES_CHALLENGE then
		return arg_21_0.challengeArchivesBossPage
	elseif arg_21_1 == var_0_1.PAGE_ENTRANCE then
		return arg_21_0.entrancePage
	elseif arg_21_1 == var_0_1.PAGE_CURRENT then
		if arg_21_0.boss and arg_21_2 then
			return arg_21_0.currentBossDetailPage
		else
			return arg_21_0.currentEmptyPage
		end
	elseif arg_21_1 == var_0_1.PAGE_ARCHIVES then
		if arg_21_0.boss and not arg_21_2 then
			return arg_21_0.archivesDetailPage
		else
			return arg_21_0.archivesEmptyPage
		end
	elseif arg_21_1 == var_0_1.PAGE_ARCHIVES_LIST then
		return arg_21_0.archivesListPage
	end

	return
end

function var_0_1._SwitchPage(arg_22_0, arg_22_1)
	if arg_22_0.page then
		local var_22_0 = arg_22_0.page

		var_2.ExecuteAction(var_22_0, "Hide")
	end

	local var_22_1 = false

	if arg_22_0.boss then
		WorldBossConst = var_3
		var_22_1 = var_3._IsCurrBoss(arg_22_0.boss)
	end

	if arg_22_1 == var_0_1.PAGE_ENTRANCE and arg_22_0.boss then
		arg_22_1 = var_22_1 and var_0_1.PAGE_CURRENT or var_0_1.PAGE_ARCHIVES
	end

	LOCK_WORLDBOSS_ARCHIVES = var_3

	if var_3 and (arg_22_1 == var_0_1.PAGE_ENTRANCE or arg_22_1 > var_0_1.PAGE_CURRENT) then
		arg_22_1 = var_0_1.PAGE_CURRENT
	end

	arg_22_0.page = arg_22_0:GetTargetPageType(arg_22_1, var_22_1)

	local var_22_2 = arg_22_0.page

	var_3.ExecuteAction(var_22_2, "Update")

	arg_22_0.pageType = arg_22_1
	setActive = var_3

	var_3(arg_22_0.backBtn, arg_22_0.pageType ~= var_0_1.PAGE_ENTRANCE and arg_22_0.pageType ~= var_0_1.PAGE_ARCHIVES_LIST)
	arg_22_0:LoadEffect(arg_22_1)

	return
end

function var_0_1.LoadEffect(arg_23_0, arg_23_1)
	if arg_23_1 ~= var_0_1.PAGE_CURRENT or not arg_23_0.boss then
		local var_23_1

		if arg_23_1 == var_0_1.PAGE_CHALLENGE then
			local var_23_0 = arg_23_0.bossProxy

			var_23_1 = var_2.ExistCacheBoss(var_23_0)
		else
			var_23_1 = false
		end
	end

	if false then
		var_23_1 = true
	end

	if var_23_1 and not arg_23_0.fireEffect then
		pg = var_3

		local var_23_2 = var_3.UIMgr.GetInstance()

		var_3.LoadingOn(var_23_2)

		PoolMgr = var_3

		local var_23_3 = var_3.GetInstance()

		var_3.GetUI(var_23_3, "gondouBoss_huoxing", true, function(arg_24_0)
			pg = var_2_10001

			local var_24_0 = var_2_10001.UIMgr.GetInstance()

			var_1.LoadingOff(var_24_0)

			local var_24_1 = arg_23_0

			var_24_1.fireEffect = arg_24_0
			setParent = var_24_1

			var_24_1(arg_23_0.fireEffect, arg_23_0._tf)

			setActive = var_24_1

			var_24_1(arg_23_0.fireEffect, true)

			return
		end)
	elseif arg_23_0.fireEffect then
		setActive = var_3

		var_3(arg_23_0.fireEffect, var_23_1)
	end

	return
end

function var_0_1.willExit(arg_25_0)
	if arg_25_0.fireEffect then
		PoolMgr = var_1

		local var_25_0 = var_1.GetInstance()

		var_1.ReturnUI(var_25_0, "gondouBoss_huoxing", arg_25_0.fireEffect)
	end

	if arg_25_0.bossProxy then
		arg_25_0:RemoveListeners()
	end

	if arg_25_0.challengeCurrentBossPage then
		local var_25_1 = arg_25_0.challengeCurrentBossPage

		var_1.Destroy(var_25_1)

		arg_25_0.challengeCurrentBossPage = nil
	end

	if arg_25_0.currentEmptyPage then
		local var_25_2 = arg_25_0.currentEmptyPage

		var_1.Destroy(var_25_2)

		arg_25_0.currentEmptyPage = nil
	end

	if arg_25_0.currentBossDetailPage then
		local var_25_3 = arg_25_0.currentBossDetailPage

		var_1.Destroy(var_25_3)

		arg_25_0.currentBossDetailPage = nil
	end

	if arg_25_0.formationPreviewPage then
		local var_25_4 = arg_25_0.formationPreviewPage

		var_1.Destroy(var_25_4)

		arg_25_0.formationPreviewPage = nil
	end

	if arg_25_0.archivesListPage then
		local var_25_5 = arg_25_0.archivesListPage

		var_1.Destroy(var_25_5)

		arg_25_0.archivesListPage = nil
	end

	if arg_25_0.archivesDetailPage then
		local var_25_6 = arg_25_0.archivesDetailPage

		var_1.Destroy(var_25_6)

		arg_25_0.archivesDetailPage = nil
	end

	if arg_25_0.entrancePage then
		local var_25_7 = arg_25_0.entrancePage

		var_1.Destroy(var_25_7)

		arg_25_0.entrancePage = nil
	end

	if arg_25_0.archivesEmptyPage then
		local var_25_8 = arg_25_0.archivesEmptyPage

		var_1.Destroy(var_25_8)

		arg_25_0.archivesEmptyPage = nil
	end

	if arg_25_0.challengeArchivesBossPage then
		local var_25_9 = arg_25_0.challengeArchivesBossPage

		var_1.Destroy(var_25_9)

		arg_25_0.challengeArchivesBossPage = nil
	end

	return
end

return var_0_1
