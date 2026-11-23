local this = {vm = nil}

local isFirst = true
local currentArea = nil
local progressList = {}
local dungeonGroupList = {}
local progressListRect = nil
local groupListRect = nil
local middleRect = nil
local rewardTipsRect = nil
local rewareTipsBottomRect = nil
local rewardTipsBgRect = nil
local rewardTipsListRect = nil
local allChestList = {}
local allProgressRect = {}

local offset = Vector2(0, -45)
local bgPosDefault = Vector2.zero
local offsetX = 0

local str_zhuxian
local str_zhixian
local str_changzhu
local str_diaocha
local str_juqing
local str_youji
local str_yincang


local data = {
    areaName = "",
    areaEpisode = "",
    isShowRewardTips = false,
    rewardTipsList = { {} },
    rewardTipsPos = Vector2.one,
    rewardTipsArrowScale = Vector3.one,
    rewardTipsBgPos = Vector2.one,
    rewardTipsBgSizeDelta = Vector2.one,

    totalProgress = 0.0,
    totalProgressStr = "",
    isShowTotalReward1 = false, totalRewardIcon1 = DefaultSprite, totalRewardCondition1 = "", showEffect1 = false,
    isShowTotalReward2 = false, totalRewardIcon2 = DefaultSprite, totalRewardCondition2 = "", showEffect2 = false,
    isShowTotalReward3 = false, totalRewardIcon3 = DefaultSprite, totalRewardCondition3 = "", showEffect3 = false,
    TipsMask = false,

    animName = "",
    
    contentAnchoredPosition = Vector2.zero,

    progressList = {
        {
            title = "", icon = DefaultSprite, progress = "", progressValue = 0.0, current = 0, total = 0, redIconId = "",
            subProgressList = {textProgress = "" },
            isShowReward1 = false, rewardIcon1 = DefaultSprite, rewardCondition1 = "", showEffect1 = false,
            isShowReward2 = false, rewardIcon2 = DefaultSprite, rewardCondition2 = "", showEffect2 = false,
            isShowReward3 = false, rewardIcon3 = DefaultSprite, rewardCondition3 = "", showEffect3 = false,
        }
    },
    dungeonGroupList = {
        {
            title = "", progress = "", dungeonList = { title = "", icon = DefaultSprite, showText = false, showAvgIcon = true,
                                                       isLock = false, showchallenge = false,showtextDes2=false,showtextDes=false, textDes = "", challengeList = { icon = DefaultSprite } }
        }
    }
}

local command = {
    progressRewardCommand_1 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickRewardChest(param + 1, 1)
        end
    },
    progressRewardCommand_2 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickRewardChest(param + 1, 2)
        end
    },
    progressRewardCommand_3 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickRewardChest(param + 1, 3)
        end
    },
    progressTotalRewardCommand_1 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickTotalRewardChest(1)
        end
    },
    progressTotalRewardCommand_2 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickTotalRewardChest(2)
        end
    },
    progressTotalRewardCommand_3 = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickTotalRewardChest(3)
        end
    },
    tipsMaskCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.TipsMask = false
            this.vm.data.isShowRewardTips = false
        end
    }
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        middleRect = vm.behaviour.transform:Find('root/Middle'):GetComponent('RectTransform')
        progressListRect = middleRect:Find("Bg/Progress/ScrollView/Viewport/Content"):GetComponent("RectTransform")
        groupListRect = middleRect:Find("Bg/ScrollView/Viewport/DungeonGroupList"):GetComponent("RectTransform")
        rewardTipsRect = middleRect:Find('Tips'):GetComponent('RectTransform')
        rewareTipsBottomRect = rewardTipsRect:Find('Bottom'):GetComponent('RectTransform')
        rewardTipsBgRect = rewareTipsBottomRect:Find('Bg'):GetComponent('RectTransform')
        rewardTipsListRect = rewareTipsBottomRect:Find('RewardList'):GetComponent('RectTransform')
        
        offsetX = rewareTipsBottomRect.anchoredPosition.x
        bgPosDefault = rewareTipsBottomRect.anchoredPosition
        this.InitStr()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then return end
        vm.behaviour:UpdateTopBar("", this.Back);
        currentArea = vm.behaviour.Params[0]
        if currentArea == nil or currentArea == "" then
            currentArea = DataMgr.Player.areaMapStatus.currentArea;
        end
        isFirst = true
        this.RefreshView()
    end,
    before_deactive = function(vm)
        isFirst = true
    end,
}

this.RefreshView = function()
    this.SetProgressList()
    this.SetDungeonGroupList()
    this.SetTotalProgress()
    
    this.vm.data.TipsMask = false
    this.vm.data.isShowRewardTips = false
    this.vm.data.progressList = progressList
    this.vm.data.contentAnchoredPosition = Vector2.zero

    if isFirst then
        this.vm.data.dungeonGroupList = dungeonGroupList

        LuaMgr.NextFrame(function()
            allProgressRect = {}
            for i = 1, progressListRect.childCount do
                local child = progressListRect:GetChild(i - 1)
                table.insert(allProgressRect, child)
                table.insert(allProgressRect, child:GetChild(1))
            end
        end)
    end

    LuaMgr.NextFrame(function()
        LuaMgr.NextFrame(function()
            for i, v in ipairs(allProgressRect) do
                RectTool.RebuildLayoutImmediate(v)
            end
            RectTool.RebuildLayoutImmediate(progressListRect)
            LuaMgr.NextFrame(function()
                if isFirst then
                    isFirst = false
                    RectTool.RebuildLayoutImmediate(groupListRect)
                    if this.vm.data.animName == "" then
                        this.vm.data.animName = "UI_AreaMapCollectPanel_01"
                    end
                    this.SetItemEventTrigger()
                end
            end)
        end)
    end)
end

this.SetProgressList = function()
    progressList = {}
    
    local areaMap = ConfigMgr.Config.areas[currentArea];
    this.vm.data.areaName =LuaMgr.GetLangText(areaMap.mapTitlelan)
    this.vm.data.areaEpisode = LuaMgr.GetLangText(areaMap.episodelan)
    this.SetMainProgress()
    this.SetBranchProgress()
    this.SetResProgress()
    this.SetExploreProgress()
    this.SetChestList()
end

this.SetDungeonGroupList = function()
    if not isFirst then 
        return
    end
    dungeonGroupList = {}
    
    this.SetMainDungeon()
    this.SetBranchDungeon()
    this.SetResDungeon()
    this.SetExploreDungeon()
end


this.SetMainProgress = function()
    local subProgressList = {}
    local mainCompleteCount = 0
    local mainTotalCount = 0
    local completeCount = 0
    local totalCount = 0
    local str = ""


    completeCount, totalCount = this.GetEvaluate(AreaEventType.AVG, AreaEventCategory.Main)
    if totalCount > 0 then
        mainCompleteCount = mainCompleteCount + completeCount
        mainTotalCount = mainTotalCount + totalCount
        if completeCount == totalCount then
            str = " <color=#00770e>%s</color><color=#262429>/%s</color>"
        else
            str =" <color=#c9201c>%s</color><color=#262429>/%s</color>"
        end
        table.insert(subProgressList, {textProgress =str_juqing .. string.format(str, completeCount, totalCount)})
    end


    completeCount, totalCount = this.GetEvaluate(AreaEventType.Battle, AreaEventCategory.Main)
    if totalCount > 0 then
        mainCompleteCount = mainCompleteCount + completeCount
        mainTotalCount = mainTotalCount + totalCount
        if completeCount == totalCount then
            str = " <color=#00770e>%s</color><color=#262429>/%s</color>"
        else
            str =" <color=#c9201c>%s</color><color=#262429>/%s</color>"
        end
        table.insert(subProgressList, {textProgress =str_youji .. string.format(str, completeCount, totalCount)})
    end


    completeCount, totalCount = this.GetAchievement(AreaEventCategory.Main)
    if totalCount > 0 then
        mainCompleteCount = mainCompleteCount + completeCount
        mainTotalCount = mainTotalCount + totalCount
        if completeCount == totalCount then
            str = " <color=#00770e>%s</color><color=#262429>/%s</color>"
        else
            str =" <color=#c9201c>%s</color><color=#262429>/%s</color>"
        end
        table.insert(subProgressList, {textProgress =str_yincang .. string.format(str, completeCount, totalCount)})
    end

    if mainTotalCount > 0 then
        local progressValue = mainTotalCount == 0 and 0.0 or (mainCompleteCount / mainTotalCount) * 100
        local progressSrt = math.floor(progressValue) .. "%"
        local progressInfo = {
            title = str_zhuxian, icon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_xtb_zx"), progress = progressSrt, progressValue = progressValue,
            completeCount = completeCount, totalCount = totalCount, redIconId = "1012_1", subProgressList = subProgressList
        }
        table.insert(progressList, progressInfo)
    end
end
this.SetMainDungeon = function()
    local list = this.GetEventList(AreaEventCategory.Main)
    if #list <= 0 then
        return
    end
    table.insert(dungeonGroupList, { 
        title = str_zhuxian,
        progress = progressList[1].progress,
        dungeonList = list
    })
end


this.SetBranchProgress = function()
    local subProgressList = {}
    local mainCompleteCount = 0
    local mainTotalCount = 0
    local completeCount = 0
    local totalCount = 0
    local str = ""


    completeCount, totalCount = this.GetEvaluate(BranchEventType.AVG, AreaEventCategory.Branch)
    if totalCount > 0 then
        mainCompleteCount = mainCompleteCount + completeCount
        mainTotalCount = mainTotalCount + totalCount
        if completeCount == totalCount then
            str = " <color=#00770e>%s</color><color=#262429>/%s</color>"
        else
            str =" <color=#c9201c>%s</color><color=#262429>/%s</color>"
        end
        table.insert(subProgressList, {textProgress =str_juqing .. string.format(str, completeCount, totalCount)})
    end


    completeCount, totalCount = this.GetEvaluate(BranchEventType.Battle, AreaEventCategory.Branch)
    local branchWeaponTypeCompleteCount, branchWeaponTypeTotalCount = this.GetEvaluate(BranchEventType.Weapon, AreaEventCategory.Branch)
    completeCount = completeCount + branchWeaponTypeCompleteCount
    totalCount = totalCount + branchWeaponTypeTotalCount
    if totalCount > 0 then
        mainCompleteCount = mainCompleteCount + completeCount
        mainTotalCount = mainTotalCount + totalCount
        if completeCount == totalCount then
            str = " <color=#00770e>%s</color><color=#262429>/%s</color>"
        else
            str =" <color=#c9201c>%s</color><color=#262429>/%s</color>"
        end
        table.insert(subProgressList, {textProgress =str_youji .. string.format(str, completeCount, totalCount)})
    end


    completeCount, totalCount = this.GetAchievement(AreaEventCategory.Branch)
    if totalCount > 0 then
        mainCompleteCount = mainCompleteCount + completeCount
        mainTotalCount = mainTotalCount + totalCount
        if completeCount == totalCount then
            str = " <color=#00770e>%s</color><color=#262429>/%s</color>"
        else
            str =" <color=#c9201c>%s</color><color=#262429>/%s</color>"
        end
        table.insert(subProgressList, {textProgress =str_yincang .. string.format(str, completeCount, totalCount)})
    end

    if mainTotalCount > 0 then
        local progressValue = mainTotalCount == 0 and 0.0 or (mainCompleteCount / mainTotalCount) * 100
        local progressSrt = math.floor(progressValue) .. "%"
        local progressInfo = {
            title = str_zhixian, icon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_xtb_zhix"), progress = progressSrt, progressValue = progressValue,
            completeCount = completeCount, totalCount = totalCount, redIconId = "1012_2", subProgressList = subProgressList
        }
        table.insert(progressList, progressInfo)
    end
end
this.SetBranchDungeon = function()
    local list = this.GetEventList(AreaEventCategory.Branch)
    if #list <= 0 then
        return
    end
    table.insert(dungeonGroupList, {
        title = str_zhixian,
        progress = progressList[2].progress,
        dungeonList = list
    })
end


this.SetResProgress = function()

    if currentArea == "saibei" or currentArea == "fusang" then
        return
    end
    local subProgressList = {}
    local mainCompleteCount = 0
    local mainTotalCount = 0
    local completeCount = 0
    local totalCount = 0
    local str = ""


    completeCount, totalCount = this.GetEvaluate(AreaEventType.AVG, AreaEventCategory.Resource)
    if totalCount > 0 then
        mainCompleteCount = mainCompleteCount + completeCount
        mainTotalCount = mainTotalCount + totalCount
        if completeCount == totalCount then
            str = " <color=#00770e>%s</color><color=#262429>/%s</color>"
        else
            str =" <color=#c9201c>%s</color><color=#262429>/%s</color>"
        end
        table.insert(subProgressList, {textProgress =str_juqing .. string.format(str, completeCount, totalCount)})
    end

    completeCount, totalCount = this.GetEvaluate(AreaEventType.Battle, AreaEventCategory.Resource)
    if totalCount > 0 then
        mainCompleteCount = mainCompleteCount + completeCount
        mainTotalCount = mainTotalCount + totalCount
        if completeCount == totalCount then
            str = " <color=#00770e>%s</color><color=#262429>/%s</color>"
        else
            str =" <color=#c9201c>%s</color><color=#262429>/%s</color>"
        end
        table.insert(subProgressList, {textProgress =str_youji .. string.format(str, completeCount, totalCount)})
    end

    if mainTotalCount > 0 then
        local progressValue = mainTotalCount == 0 and 0.0 or (mainCompleteCount / mainTotalCount) * 100
        local progressSrt = math.floor(progressValue) .. "%"
        local progressInfo = {
            title = str_changzhu, icon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_xtb_cz"), progress = progressSrt, progressValue = progressValue,
            completeCount = completeCount, totalCount = totalCount, redIconId = "1012_3", subProgressList = subProgressList
        }
        table.insert(progressList, progressInfo)
    end
end
this.SetResDungeon = function()

    if currentArea == "saibei" or currentArea == "fusang" then
        return
    end
    local list = this.GetEventList(AreaEventCategory.Resource)
    if #list <= 0 then
        return
    end
    table.insert(dungeonGroupList, {
        title = str_changzhu,
        progress = progressList[3].progress,
        dungeonList = list
    })
end


this.SetExploreProgress = function()
    local exploreList = ConfigAreaMgr.GetAreaMapExplores(currentArea)
    if exploreList == nil then
        return
    end

    local totalCount = #exploreList
    local completeCount = 0
    local areaExplore = DataMgr.Player.areaExplores[currentArea]
    if areaExplore ~= nil and not IsNull(areaExplore.completedExplores) then
        for k, v in pairs(areaExplore.completedExplores) do
            completeCount = completeCount + 1
        end
    end

    if totalCount > 0 then
        local progressValue = (completeCount / totalCount) * 100
        local progressSrt = math.floor(progressValue) .. "%"
        local progressInfo = {
            title = str_diaocha, icon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_xtb_dc"), progress = progressSrt, progressValue = progressValue,
            completeCount = completeCount, totalCount = totalCount, redIconId = "1012_4"
        }
        table.insert(progressList, progressInfo)
    end
end
this.SetExploreDungeon = function()
end

this.SetTotalProgress = function()
    local totalProgressValue = 0
    for i, v in ipairs(progressList) do
        totalProgressValue = totalProgressValue + v.progressValue
    end
    totalProgressValue = totalProgressValue / #progressList
    this.vm.data.totalProgress = totalProgressValue
    this.vm.data.totalProgressStr = string.format(LuaMgr.GetLangText("AreaMapCollectViewModel_0"), math.floor(totalProgressValue))
end


this.GetEvaluate = function(eventType, eventCategory)
    local completeCount = 0
    local totalCount = 0
    if eventCategory == AreaEventCategory.Main or eventCategory == AreaEventCategory.Resource then
        local eventList = ConfigAreaMgr.GetAreaMapEvents(currentArea)
        for i, item in ipairs(eventList or {}) do
            if item.type == eventType and item.category == eventCategory then
                if eventType == AreaEventType.AVG then
                    totalCount = totalCount + 1
                    if DataMgr.Player.completedAreaEvents[item.eventParam] ~= nil then
                        completeCount = completeCount + 1
                    end
                elseif eventType == AreaEventType.Battle then
                    totalCount = totalCount + 1
                    local record = DataMgr.Player.dungeonRecords[item.eventParam]
                    if record ~= nil and record.historyRating == "S" then
                        completeCount = completeCount + 1
                    end
                end

            end
        end
    elseif eventCategory == AreaEventCategory.Branch then
        local eventList = ConfigAreaMgr.GetBranchEvents(currentArea)
        local branchDataList = DataMgr.Player.branch
        for i, item in ipairs(eventList or {}) do
            if tonumber(item.type) == eventType then
                local branchData = nil
                if next(branchDataList.children) then
                    local chapterData = branchDataList.children[item.chapterID]
                    if chapterData ~= nil and chapterData.children then
                        local storyData = chapterData.children[item.storyID]
                        if storyData ~= nil and storyData.children then
                            branchData = storyData.children[item.ID]
                        end
                    end
                end
                totalCount = totalCount + 1
                if branchData ~= nil and branchData.completed then
                    if eventType == BranchEventType.AVG then
                            completeCount = completeCount + 1
                    elseif eventType == BranchEventType.Battle or eventType == BranchEventType.Weapon then
                        local record = DataMgr.Player.dungeonRecords[item.param]
                        if record ~= nil and record.historyRating == "S" then
                            completeCount = completeCount + 1
                        end
                    end
                end
            end
        end
    end
    
    return completeCount, totalCount
end


this.GetAchievement = function(eventCategory)
    local completedCount = PlayerAreaMgr.GetChallengeCompleteCountByArea(currentArea, eventCategory)
    local totalCount = ConfigAreaMgr.GetChallengeCountByArea(currentArea, eventCategory)
    return completedCount, totalCount
end

this.GetEventList = function(eventCategory)
    local list = {}
    if eventCategory == AreaEventCategory.Main or eventCategory == AreaEventCategory.Resource then
        local eventList = ConfigAreaMgr.GetAreaMapEvents(currentArea)
        for i, item in ipairs(eventList or {}) do
            if item.category == eventCategory then
                local tempData = {
                    title = "",
                    icon = DefaultSprite,
                    showText = false,
                    showAvgIcon = false,
                    isLock = false,
                    showchallenge = false,
                    showtextDes2=false,
                    showtextDes=false,
                    challengeList = {},
                    textDes="",
                }

                local areaEventData = PlayerAreaMgr.GetAreaEvent(item.area, item.id)
                if areaEventData ~= nil then

                    tempData.groupId = item.groupId
                    if item.type == AreaEventType.AVG then
                        local dungeonData = ConfigMgr.Config.narrativeMap[item.eventParam]
                        tempData.title = LuaMgr.GetLangText(dungeonData.nameLan)
                        if DataMgr.Player.completedAreaEvents[item.eventParam] ~= nil then
                            tempData.showAvgIcon = true
                        else
                            tempData.showText = true
                        end
                    elseif item.type == AreaEventType.Battle then
                        local dungeonData = ConfigMgr.Config.dungeonMap[item.eventParam]
                        tempData.title = LuaMgr.GetLangText(dungeonData.NameLan)
                        
                        local dungeonRecord = DataMgr.Player.dungeonRecords[item.eventParam]
                        if dungeonRecord==nil or IsNullOrEmpty(dungeonRecord.historyRating) then
                            tempData.showText = true
                        else
                            tempData.icon = this.GetRatingIcon(dungeonRecord.historyRating)
                        end
                    end


                    if not tempData.showText and not tempData.showAvgIcon and not tempData.isLock then
                        local challengeList,challengeCount,completeChallengeCount=this.GetChallengeList(item.eventParam)
                        tempData.challengeList = challengeList;
                        tempData.showchallenge =  true
                        tempData.showtextDes2= (not (#tempData.challengeList > 0));
                        tempData.showtextDes=not tempData.showtextDes2;
                        if challengeCount<=0 then
                            tempData.textDes=LuaMgr.GetLangText("BattlePreparePanel_UI_15")
                        else
                            local text=LuaMgr.GetLangText("BattlePreparePanel_UI_14").."%s/%s"
                            tempData.textDes=string.format(text, completeChallengeCount, challengeCount)
                        end
                            
                        end
                else

                    tempData.isLock = true
                end
                table.insert(list, tempData)
            end
        end
    elseif eventCategory == AreaEventCategory.Branch then
        local eventList = ConfigAreaMgr.GetBranchEvents(currentArea)
        local branchDataList = DataMgr.Player.branch
        for i, item in ipairs(eventList or {}) do
            local tempData = {
                title = "",
                icon = DefaultSprite,
                showText = false,
                showAvgIcon = false,
                isLock = false,
                showchallenge = false,
                showtextDes2=false,
                showtextDes=false;
                challengeList = {},
                textDes="";
            }
            
            local dungeonData
            if tonumber(item.type) == BranchEventType.AVG then
                dungeonData = ConfigMgr.Config.narrativeMap[item.param]
                tempData.title = LuaMgr.GetLangText(dungeonData.nameLan)
            elseif tonumber(item.type) == BranchEventType.Battle or tonumber(item.type) == BranchEventType.Weapon then
                dungeonData = ConfigMgr.Config.dungeonMap[item.param]
                tempData.title = LuaMgr.GetLangText(dungeonData.NameLan)
            end
            local branchData = nil
            if next(branchDataList.children) then
                local chapterData = branchDataList.children[item.chapterID]
                if chapterData ~= nil and chapterData.children then
                    local storyData = chapterData.children[item.storyID]
                    if storyData ~= nil and storyData.children then
                        branchData = storyData.children[item.ID]
                    end
                end
            end

            for key, value in ipairs(ConfigMgr.Config.branchChapterList) do

                if item.chapterID == value.ID and value.uiType ~= 0 then
                    branchData = nil
                end

                local isBanned = FeatureManager.UnifyVerControls("branchChapter",value.ID)
                if not isBanned then
                    branchData = nil
                end
            end
            
            local branchIsLock = FeatureManager.IsLock("1040")
            if branchData ~= nil and branchData.unlocked and not branchIsLock then

                tempData.id = item.ID
                if branchData.completed then

                    if tonumber(item.type) == BranchEventType.AVG then
                        tempData.showAvgIcon = true
                    elseif tonumber(item.type) == BranchEventType.Battle or tonumber(item.type) == BranchEventType.Weapon then
                        local dungeonRecord = DataMgr.Player.dungeonRecords[item.param]

                        if dungeonRecord~=nil and not IsNullOrEmpty(dungeonRecord.historyRating) then
                            tempData.icon = this.GetRatingIcon(dungeonRecord.historyRating)
                        end
                    end
                else

                    tempData.showText = true
                end
            else

                tempData.isLock = true
            end


            if not tempData.showText and not tempData.showAvgIcon and not tempData.isLock then
                local challengeList,challengeCount,completeChallengeCount=this.GetChallengeList(item.ID)
                tempData.challengeList =challengeList;
                tempData.showchallenge = true
                tempData.showtextDes2= (not (#tempData.challengeList > 0));
                tempData.showtextDes=not tempData.showtextDes2;
                
                if challengeCount<=0 then
                    tempData.textDes=LuaMgr.GetLangText("BattlePreparePanel_UI_15")
                else
                    local text=LuaMgr.GetLangText("BattlePreparePanel_UI_14").."%s/%s"
                    tempData.textDes=string.format(text, completeChallengeCount, challengeCount)
                end
                
            end
            
            table.insert(list, tempData)
        end
    end
    return list
end

this.GetRatingIcon = function(historyRating)
    local icon = DefaultSprite
    if historyRating=="B" then
        icon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_pj_zhong")
    elseif historyRating=="A" then
        icon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_pj_liang")
    elseif historyRating=="S" then
        icon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_pj_you")
    end
    return icon
end

this.GetChallengeList = function(id)
    local challengeList = {}
    local challengeCount = ConfigAreaMgr.GetChallengeCountById(id)
    local completeChallengeCount = PlayerAreaMgr.GetChallengeCompleteCountById(id)
    if challengeCount > 0 then
        for i = 1, challengeCount do

            local _icon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sjdd_4")



            if completeChallengeCount >= challengeCount then
                _icon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sjdd_1")
            elseif (i<=completeChallengeCount) then
                _icon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sjdd_2")
            end

            table.insert(challengeList, {
                icon = _icon
            })
        end
    end
    
    return challengeList,challengeCount,completeChallengeCount;
end




this.SetChestList = function()
    allChestList = AreaMapCollectHelper.GetChestList(currentArea)
    for k, v in pairs(allChestList) do
        if k ~= "main" and progressList[k] ~= nil then
            local isShowRedIcon = 0
            for i = 1, 3 do
                local missionData = v[i]
                if missionData ~= nil then
                    local rewardIcon = DefaultSprite

                    local showEffect = false
                    if missionData.states == AreaMapCollectHelper.ChestState.Received then
                        rewardIcon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_xbx_03")
                    elseif missionData.states == AreaMapCollectHelper.ChestState.CanGet then
                        rewardIcon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_xbx_02")
                        isShowRedIcon = 1

                        showEffect = true
                    elseif missionData.states == AreaMapCollectHelper.ChestState.CanNotGet then
                        rewardIcon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_xbx_01")
                    end
                    progressList[k]["isShowReward" .. i] = true
                    progressList[k]["rewardIcon" .. i] = rewardIcon
                    progressList[k]["rewardCondition" .. i] = MissionHelper.GetTargetCount(missionData.id) .. "%"
                    progressList[k]["showEffect" .. i] = showEffect
                end
            end
            RedMgr.Singleton:UpdateClientRedData("1012_" .. k, isShowRedIcon);
        else
            for i = 1, 3 do
                local missionData = v[i]
                if missionData ~= nil then
                    local rewardIcon = DefaultSprite
                    local showEffect = false
                    if missionData.states == AreaMapCollectHelper.ChestState.Received then
                        rewardIcon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_dbx_03")
                        RedMgr.Singleton:UpdateClientRedData("1012_50" .. i, 0);
                    elseif missionData.states == AreaMapCollectHelper.ChestState.CanGet then
                        rewardIcon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_dbx_02")
                        RedMgr.Singleton:UpdateClientRedData("1012_50" .. i, 1);
                        showEffect = true
                    elseif missionData.states == AreaMapCollectHelper.ChestState.CanNotGet then
                        rewardIcon = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_dbx_01")
                        RedMgr.Singleton:UpdateClientRedData("1012_50" .. i, 0);
                    end
                    this.vm.data["isShowTotalReward" .. i] = true
                    this.vm.data["totalRewardIcon" .. i] = rewardIcon
                    this.vm.data["totalRewardCondition" .. i] = MissionHelper.GetTargetCount(missionData.id) .. "%"
                    this.vm.data["showEffect" .. i] = showEffect
                end
            end
        end
    end
end


this.OnClickRewardChest = function(groupIndex, chestIndex)
    local rewardChestData = allChestList[groupIndex][chestIndex]
    if rewardChestData.states == AreaMapCollectHelper.ChestState.CanGet then

        local data = {missionIds={},tab=currentArea}
        if groupIndex == "main" then
            local chestData = allChestList[groupIndex][chestIndex]
            table.insert(data.missionIds, chestData.id)
        else
            for i = 1, 3 do
                local chestData = allChestList[groupIndex][i]
                if chestData.current == MissionHelper.GetTargetCount(chestData.id) and not chestData.completed then
                    table.insert(data.missionIds, chestData.id)
                end
            end
        end
        
        ApiMgr.Request("complete_mission",data,true,function(result)
            local re = json.decode(result)
            local resultData = json.encode(re.result)
            LuaMgr.ShowItemRewared(resultData)

            this.SetProgressList()
            if groupIndex == "main" then
                this.vm.data["totalRewardIcon" .. chestIndex] = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_dbx_03")
                this.vm.data["showEffect" .. chestIndex] = false
                RedMgr.Singleton:UpdateClientRedData("1012_50" .. chestIndex, 0);
            else
                for i = 1, 3 do
                    local chestData = allChestList[groupIndex][i]
                    if chestData.current == MissionHelper.GetTargetCount(chestData.id) and chestData.completed then
                        this.vm.data.progressList[groupIndex]["rewardIcon" .. i] = LuaMgr.GetSprite("AreaMapRes", "ui_qydt_sj_xbx_03")
                        this.vm.data.progressList[groupIndex]["showEffect" .. i] = false
                    end
                end
            end
        end,nil,true)
    else

        local cfgMissions = ConfigMgr.Config.missionMap
        local rewardChestCfg = cfgMissions[rewardChestData.id]
        local rewardItemList = this.GetRewardItemList(rewardChestCfg.rewards)
        this.vm.data.rewardTipsList = rewardItemList
        this.vm.data.TipsMask = true
        this.vm.data.isShowRewardTips = true
        this.vm.data.rewardTipsPos = Vector2(2000, 0)
        
        LuaMgr.NextFrame(function()
            local rewardItemTr
            if groupIndex == "main" then
                rewardItemTr = middleRect:Find("Bg/TotalProgress/RewardList/RewardItem_" .. chestIndex)
            else
                rewardItemTr  = progressListRect:GetChild(tonumber(groupIndex) - 1):Find("RewardList/RewardItem_" .. chestIndex)
            end
            local screenWidth = UnityEngine.Screen.width / UnityEngine.Screen.height * 720
            if(screenWidth < 1280) then
                screenWidth = 1280
            end

            local scrPos=LuaMgr.World2Local(rewardItemTr.position,middleRect);
            local arrowScale = Vector3.one
            local result = bgPosDefault
            if (scrPos.y < -250) then
                result.y = 42
                scrPos = scrPos - offset
                arrowScale = Vector3(1, -1, 1)
            else
                result.y = -30
                scrPos = scrPos + offset
            end
            this.vm.data.rewardTipsPos = scrPos

            local bgWidth = rewardTipsBgRect.sizeDelta.x
            local minX = -(screenWidth / 2) + bgWidth / 2 - offsetX + 50
            local maxX = screenWidth / 2 - bgWidth / 2 - offsetX - 50
            local x = rewardTipsRect.anchoredPosition.x
            local y = rewardTipsRect.anchoredPosition.y
            local bgX = offsetX
            if (x > maxX) then
                bgX = maxX - x + offsetX
            end
            if (x < minX) then
                bgX = minX - x + offsetX
            end
            result.x = bgX

            RectTool.RebuildLayoutImmediate(rewardTipsListRect)
            this.vm.data.rewardTipsBgSizeDelta = Vector2(rewardTipsListRect.sizeDelta.x - 30, rewardTipsListRect.sizeDelta.y)
            this.vm.data.rewardTipsBgPos = result
            this.vm.data.rewardTipsArrowScale = arrowScale
        end)
    end
    
end


this.OnClickTotalRewardChest = function(chestIndex)
    this.OnClickRewardChest("main", chestIndex)
end

this.GetRewardItemList = function(rewards)
    local tempRewardLis = {}
    for i = 1, #rewards do
        local itemRare = ConfigMgr.Config.itemMap[rewards[i].itemId].rare
        local rewardItem = {
            id = rewards[i].itemId,count = LuaMgr.NumFormat(rewards[i].count),isCount = true,
            rare = ActivityMgr.GetRareSprite(itemRare),rareInt = itemRare,
            icon = ActivityMgr.GetItemTexture(rewards[i].itemId),
            scale = Vector3.one,
            sizeDelta=Vector2(128,128),
            isClick = true}
        table.insert(tempRewardLis, rewardItem)
    end
    table.sort(tempRewardLis, function(a, b)
        return a.rareInt < b.rareInt
    end)
    return tempRewardLis
end

this.InitStr = function()
    str_zhuxian = LuaMgr.GetLangText("AreaMapCollectViewModel_1")
    str_zhixian = LuaMgr.GetLangText("AreaMapCollectViewModel_2")
    str_changzhu = LuaMgr.GetLangText("AreaMapCollectViewModel_3")
    str_diaocha = LuaMgr.GetLangText("AreaMapCollectViewModel_4")
    str_juqing = LuaMgr.GetLangText("AreaMapCollectViewModel_5")
    str_youji = LuaMgr.GetLangText("AreaMapCollectViewModel_6")
    str_yincang = LuaMgr.GetLangText("AreaMapCollectViewModel_7")
end

this.SetItemEventTrigger = function()
    for i = 1, groupListRect.childCount do
        local child = groupListRect:GetChild(i - 1):Find("DungeonList")
        for j = 1, child.childCount do
            local dungeonItem = child:GetChild(j - 1)
            dungeonItem:GetComponent("EventTriggerListener").onClick = function(tr)
                this.OnClickDungeonItem(i, j)
            end
        end
    end
end

this.OnClickDungeonItem = function(groupIndex, index)
    local dungeonData = this.vm.data.dungeonGroupList[groupIndex].dungeonList[index]
    if dungeonData.groupId ~= nil then
    AreaMapSceneMgr.SetBuildingId(dungeonData.groupId)
        this.Back()
    elseif dungeonData.id ~= nil then
        local branchData = nil
        for i, v in ipairs(ConfigMgr.Config.branchEventList) do
            if v.ID == dungeonData.id then
                branchData = v
            end
        end
    
        if branchData then
            for i, v in ipairs(ConfigMgr.Config.branchChapterList) do
                if v.ID == branchData.chapterID then
                    ComData.branchData.pageindex = i
                    ComData.branchData.pageIds = branchData.chapterID
                    break
                end
            end
    
            local bookIndex = 0
            for i, v in ipairs(ConfigMgr.Config.branchStoryList) do
                if v.chapterID == branchData.chapterID then
                    bookIndex = bookIndex + 1
                    if v.ID == branchData.storyID then
                        ComData.branchData.bookindex = bookIndex
                        break
                    end
                end
                
            end
    
            if tonumber(branchData.type) == 1 then
                local novelIndex = 0
                for i, v in ipairs(ConfigMgr.Config.branchEventList) do
                    if v.storyID == branchData.storyID then
                        novelIndex = novelIndex + 1
                        if v.ID == dungeonData.id then
                            break
                        end
                    end
                end
                ComData.branchData.novelIndex = novelIndex
                ComData.branchData.BattleGoto = nil
                ComData.branchData.NorvelGoto = true
            elseif tonumber(branchData.type) == 2 then
                ComData.branchData.BattleGoto = true
                ComData.branchData.NorvelGoto = nil
            end
            LuaMgr.ShowLuaPanel("BranchMissionViewModel")
            isFirst = true
        end
    end
end

this.Back = function()
    LuaMgr.Back()
end

return vm({
data = data,
command = command,
hook = hook,
})