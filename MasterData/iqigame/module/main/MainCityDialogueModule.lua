-- chunkname: @IQIGame\\Module\\Main\\MainCityDialogueModule.lua

MainCityDialogueModule = {}

function MainCityDialogueModule.GetDialogueList(eventID)
	local dialogueList = {}
	local roleStoryCfg = CfgRoleStoryTable[eventID]

	repeat
		table.insert(dialogueList, roleStoryCfg.Id)

		if roleStoryCfg.NextID == nil or roleStoryCfg.NextID == 0 then
			roleStoryCfg.NextID = 0
		else
			roleStoryCfg = CfgRoleStoryTable[roleStoryCfg.NextID]
		end
	until roleStoryCfg.NextID == 0

	table.insert(dialogueList, roleStoryCfg.Id)

	return dialogueList
end

function MainCityDialogueModule.GetAnimationNameList(cfgAnimationList)
	local animationList = {}

	for i = 1, #cfgAnimationList do
		if cfgAnimationList[i] ~= "" then
			table.insert(animationList, cfgAnimationList[i])
		end
	end

	return animationList
end
