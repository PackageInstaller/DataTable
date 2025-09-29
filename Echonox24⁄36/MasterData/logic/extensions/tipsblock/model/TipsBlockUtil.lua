-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tipsblock/model/TipsBlockUtil.lua

module("logic.extensions.tipsblock.model.TipsBlockUtil", package.seeall)

local TipsBlockUtil = {}

TipsBlockUtil.LogTag = "[BlockTips]"
TipsBlockUtil.BlockMark = {
	Default = "DefaultMark",
	EchoUpgrade = "EchoUpgrade"
}
TipsBlockUtil.view = {
	[ViewName.OpenFunctionsHintTips] = {
		BlockWhileGuide = true,
		BlockBattle = true,
		priority = 0,
		id = 1,
		BlockStory = true,
		SceneType = {
			SceneType.Room,
			SceneType.House
		},
		MutexView = {
			ViewName.MultiFuntionView,
			ViewName.PlayerUpgradeShowView2,
			ViewName.GainItemView,
			ViewName.ItemConvert
		}
	},
	[ViewName.MonumentUpgrade] = {
		BlockWhileGuide = true,
		BlockBattle = true,
		priority = 0,
		id = 2,
		BlockStory = true,
		SceneType = {
			SceneType.Room,
			SceneType.House
		},
		MutexView = {
			ViewName.PlayerUpgradeShowView2,
			ViewName.MultiFuntionView,
			ViewName.OpenFunctionsHintTips,
			ViewName.GainItemView,
			ViewName.ItemConvert,
			ViewName.AchievementSkillUpgrade,
			ViewName.EquipTimingReviewTest
		}
	},
	[ViewName.HealthGetActionTimeTipsView] = {
		BlockWhileGuide = true,
		BlockBattle = true,
		priority = 0,
		id = 3,
		BlockStory = true,
		SceneType = {
			SceneType.Room,
			SceneType.House
		},
		MutexView = {
			ViewName.PlayerUpgradeShowView2,
			ViewName.MultiFuntionView,
			ViewName.OpenFunctionsHintTips,
			ViewName.GainItemView,
			ViewName.ItemConvert
		}
	},
	[ViewName.PlayerUpgradeShowView2] = {
		priority = 0,
		BlockWhileGuide = true,
		id = 4,
		BlockStory = true,
		MutexView = {
			ViewName.GainItemView,
			ViewName.ItemConvert
		}
	},
	[ViewName.GainItemView] = {
		priority = 0,
		BlockWhileGuide = true,
		id = 4,
		BlockStory = true,
		MutexView = {
			ViewName.PlayerUpgradeShowView2,
			ViewName.MultiFuntionView,
			ViewName.OpenFunctionsHintTips,
			ViewName.ItemConvert
		}
	}
}

function TipsBlockUtil.print(msgStr, debugTrack)
	if enableLog then
		if debugTrack then
			printWarn(string.format("%s %s", TipsBlockUtil.LogTag, msgStr), debug.traceback())
		else
			printWarn(string.format("%s %s", TipsBlockUtil.LogTag, msgStr))
		end
	end
end

function TipsBlockUtil.printError(msgStr)
	printError(string.format("%s %s", TipsBlockUtil.LogTag, msgStr))
end

function TipsBlockUtil.getInfo(viewName)
	return TipsBlockUtil.view[viewName]
end

function TipsBlockUtil.getPriority(viewName)
	local priority = 0
	local data = TipsBlockUtil.view[viewName]

	if data then
		priority = data.priority or 0
	end

	return priority
end

function TipsBlockUtil.canOpen(viewName)
	local canOpen = true
	local data = TipsBlockUtil.view[viewName]

	if data then
		if canOpen and not TipsBlockUtil.checkScene(data.SceneType) then
			if enableLog then
				TipsBlockUtil.print(string.format("block view[%s] by sceneType:%s", viewName, SceneMgr.instance:getCurSceneType()))
			end

			canOpen = false
		end

		if canOpen and not TipsBlockUtil.checkGuide(data.BlockWhileGuide) then
			if enableLog then
				TipsBlockUtil.print(string.format("block view[%s] by guide", viewName))
			end

			canOpen = false
		end

		if canOpen and not TipsBlockUtil.checkStory(data.BlockStory) then
			if enableLog then
				TipsBlockUtil.print(string.format("block view[%s] by story", viewName))
			end

			canOpen = false
		end

		if canOpen and not TipsBlockUtil.checkBattle(data.BlockBattle) then
			if enableLog then
				TipsBlockUtil.print(string.format("block view[%s] by battle", viewName))
			end

			canOpen = false
		end

		if canOpen and not TipsBlockUtil.checkMutexView(data.MutexView) then
			if enableLog then
				TipsBlockUtil.print(string.format("block view[%s] by MutexView", viewName))
			end

			canOpen = false
		end

		if canOpen and not TipsBlockUtil.checkLoading() then
			if enableLog then
				TipsBlockUtil.print(string.format("block view[%s] by Loading", viewName))
			end

			canOpen = false
		end

		if canOpen then
			local sceneType = SceneMgr.instance:getCurSceneType()

			canOpen = SystemJumpController.instance:getCrossSceneJumpInfo(sceneType) == nil

			if not canOpen and enableLog then
				TipsBlockUtil.print(string.format("block view[%s] by CrossSceneJumpInfo,scene:%s", viewName, sceneType))
			end
		end

		if canOpen then
			local hasPopUpData = MainPopController.instance:hasPopUpData()

			if hasPopUpData and MainPopController.instance:getIsPopShowing() then
				canOpen = false

				if enableLog then
					TipsBlockUtil.print(string.format("block view[%s] by main popup is showing", viewName))
				end
			elseif hasPopUpData and ViewMgr.instance:isOpen(ViewName.MainUIView) then
				canOpen = false

				if enableLog then
					TipsBlockUtil.print(string.format("block view[%s] by MainUI Open also has main popup", viewName))
				end
			end
		end
	end

	return canOpen
end

function TipsBlockUtil.checkScene(sceneTypeLst)
	local scenePass = true
	local len = sceneTypeLst and #sceneTypeLst or 0

	if len > 0 then
		scenePass = false

		local sceneType = SceneMgr.instance:getCurSceneType()

		if table.indexof(sceneTypeLst, sceneType) then
			scenePass = true
		end
	end

	return scenePass
end

function TipsBlockUtil.checkBattle(blockWhileBattle)
	if blockWhileBattle then
		if DungeonModel.instance:getIsInBattle() then
			return false
		end

		if BattleMgr.instance:isInBattle() then
			return false
		end
	end

	return true
end

function TipsBlockUtil.checkGuide(blockWhileGuide)
	if blockWhileGuide then
		return not GuideController.instance:isGuiding()
	end

	return true
end

function TipsBlockUtil.checkStory(blockWhileStory)
	if blockWhileStory then
		return not StoryController.instance:isInStory()
	end

	return true
end

function TipsBlockUtil.checkMutexView(mutexViewLst)
	local viewPass = true
	local len = mutexViewLst and #mutexViewLst or 0

	if len > 0 then
		for _, viewName in ipairs(mutexViewLst) do
			local isOpen = ViewMgr.instance:isOpen(viewName)

			if viewPass and isOpen then
				viewPass = false
			end
		end
	end

	return viewPass
end

function TipsBlockUtil.checkLoading()
	local isLoading = ViewMgr.instance:isOpen(ViewName.LoadingView) or ViewMgr.instance:isOpen(ViewName.LoadingBlackView)

	return not isLoading
end

return TipsBlockUtil
