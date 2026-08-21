---@class GmPanel : GmPanel_Generate
---##################### 【GmPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【GmPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local GmPanel = require "GmPanel_Generate"

local GmCfg = {
    [1] = {
        name = "常用",
        funcList = {
            [1] = {
                name = "增加体力",
                str = 'gmAddTicket 10',
            },
            [2] = {
                name = "扣除体力",
                str = 'gmSubTicket 10',
            },
            [3] = {
                name = "增加道具",
                str = 'gmAddItem 100003 1000',
            },
            [4] = {
                name = "扣除道具",
                str = 'gmSubItem 100003 1000',
            },
            [5] = {
                name = "增加角色",
                str = 'gmAddHero 10017',
            },
            [6] = {
                name = "增加装备",
                str = 'gmAddEquip 300001',
            },
            [7] = {
                name = "增加武器",
                str = 'gmAddWeapon 450701',
            },
            [8] = {
                name = "增加指挥官经验",
                str = 'gmAddPlayerExp 1000',
            },
            [9] = {
                name = "完成指定任务",
                str = 'gmFinishTask taskId',
            },
            [10] = {
                name = "触发指定好感度事件",
                str = 'gmTriggerAffectionEvent eventId',
            },
            [11] = {
                name = "账号清除",
                str = 'CharDelReq account',
            },
            [12] = {
                name = "一键满级",
                str = 'gmOneKeyMaxLevel',
            },
            [13] = {
                name = "一键中级",
                str = 'gmOneKeyMidLevel',
            },
            [14] = {
                name = "测试",
                str = 'Test',
            },
            [15] = {
                name = "解锁指定关卡 (格式：关卡ID 是否通关(0或1) 是否三星通关(0或1))",
                str = 'gmUnlockLevel 10204 1 1',
            },
            [16] = {
                name = "解锁指定章节 (格式：章节ID 是否通关(0或1) 是否三星通关(0或1))",
                str = 'gmUnlockChapter 1002 1 1',
            },
            [17] = {
                name = "增加家园1小时产出",
                str = 'gmAddHomelandRewardHour 1',
            },
            [18] = {
                name = "一键解锁",
                str = 'gmOneKeyUnlock',
            },
        }
    },
    [2] = {
        name = "派遣",
        funcList = {
            [1] = {
                name = "生成派遣随机任务",
                str = 'GenDispatchRandomTask 10001',
            },
            [2] = {
                name = "完成派遣",
                str = 'gmFinishDispatchTask 10001',
            },
        },
    },
    --   [2] = {
    --     name = "科技树",
    --     funcList = {
    --         [1] = {
    --             name = "开启界面",
    --             str = 'OpenTechnologyTree',
    --         },
    --     },
    -- },
}

function GmPanel:InitLogic(data)
    self.commands = {}

    self:registerCommand("gmAddTicket", function(num)
        Me:gmCommandReq({content = string.format("//gmAddTicket %d", num)}, function(status)
        end)
    end)
    self:registerCommand("gmSubTicket", function(num)
        Me:gmCommandReq({content = string.format("//gmSubTicket %d", num)}, function(status)
        end)
    end)
    self:registerCommand("gmAddItem", function(id, num)
        Me:gmCommandReq({content = string.format("//gmAddItem %d %d", id, num)}, function(status)
        end)
    end)
    self:registerCommand("gmSubItem", function(id, num)
        Me:gmCommandReq({content = string.format("//gmSubItem %d %d", id, num)}, function(status)
        end)
    end)
    self:registerCommand("gmAddHero", function(id)
        Me:gmCommandReq({content = string.format("//gmAddHero %d", id)}, function(status)
        end)
    end)
    self:registerCommand("gmAddEquip", function(id)
        Me:gmCommandReq({content = string.format("//gmAddEquip %d", id)}, function(status)
        end)
    end)
    self:registerCommand("gmAddWeapon", function(id)
        Me:gmCommandReq({content = string.format("//gmAddWeapon %d", id)}, function(status)
        end)
    end)
    self:registerCommand("gmAddPlayerExp", function(id)
        Me:gmCommandReq({content = string.format("//gmAddPlayerExp %d", id)}, function(status)
        end)
    end)
    self:registerCommand("gmFinishTask", function(id)
        Me:gmCommandReq({content = string.format("//gmFinishTask %d", id)}, function(status)
        end)
    end)
    self:registerCommand("gmOneKeyMaxLevel", function(id)
        Me:gmCommandReq({content = string.format("//gmOneKeyMaxLevel")}, function(status)
        end)
    end)
    self:registerCommand("gmOneKeyUnlock", function(id)
        Me:gmCommandReq({content = string.format("//gmOneKeyUnlock")}, function(status)
        end)
    end)
    self:registerCommand("GenDispatchRandomTask", function(id)
        Me:gmCommandReq({content = string.format("//GenDispatchRandomTask %d", id)}, function(status)
        end)
    end)
    self:registerCommand("gmFinishDispatchTask", function(id)
        Me:gmCommandReq({content = string.format("//gmFinishDispatchTask %d", id)}, function(status)
        end)
    end)
    
    self:registerCommand("gmOneKeyMidLevel", function(id)
        Me:gmCommandReq({content = string.format("//gmOneKeyMidLevel")}, function(status)
        end)
    end)
    self:registerCommand("gmTriggerAffectionEvent", function(id)
        Me:gmCommandReq({content = string.format("//gmTriggerAffectionEvent %d", id)}, function(status)
        end)
    end)
    self:registerCommand("gmUnlockLevel", function(levelId, isPass, isFullStar)
        Me:gmCommandReq({content = string.format("//gmUnlockLevel %d %d %d", levelId, isPass or 0, isFullStar or 0)}, function(status)
        end)
    end)
    self:registerCommand("gmUnlockChapter", function(chapterId, isPass, isFullStar)
        Me:gmCommandReq({content = string.format("//gmUnlockChapter %d %d %d", chapterId, isPass or 0, isFullStar or 0)}, function(status)
        end)
    end)

    self:registerCommand("gmAddHomelandRewardHour", function(hour)
        Me:gmCommandReq({content = string.format("//gmAddHomelandRewardHour %d", hour)}, function(status)
        end)
    end)

    self:registerCommand("CharDelReq", function(status)
        Me:charDelReq(function()
        end)
        g_GameMain:Restart()
    end)

    self:registerCommand("Test", function(status)
        -- local serverTime = EngineUtil.ServerTime_Seconds()
        -- local str = "SignPop"..os.date("%Y%m%d", serverTime)
        -- LuaLogger.e(str)
        
        UICommonUtils.PopPromptOkCancelBox("位置未放满，是否继续")
    end)

    self:registerCommand("CloseDispatchChapterCondition", function(status)
        PlayerPrefs.SetInt("CloseDispatchChapterCondition", 1)
	    PlayerPrefs.Save()
    end)

    self:registerCommand("OpenTechnologyTree", function(status)
        UIMgr:popUI("TechnologyTreePagePanel")
    end)

    self.homelandStoryTxt.text.text = "家园剧情"
    
end

-- 注册新指令
function GmPanel:registerCommand(name, func)
    self.commands[name] = func
end

-- 执行指令
function GmPanel:execute(input)
    -- 先检查是否是注册的指令
    local parts = {}
    for part in input:gmatch("%S+") do
        table.insert(parts, part)
    end
    
    if #parts > 0 and self.commands[parts[1]] then
        local args = {table.unpack(parts, 2)}
        pcall(self.commands[parts[1]], table.unpack(args))
    end
end

--function GmPanel:StartCreating(time)
--
--end

--function GmPanel:StartEnter(time)
--
--end

--function GmPanel:StartRemoving(time)
--
--end

--function GmPanel:StartExit(time)
--
--end

function GmPanel:OnOpen(data, initiative)
    self.curGmType = 1
    self:bindTypeList()
    self:bindGmDetail()
end

function GmPanel:bindTypeList()
    self:FillTemplateContent(self.gMBox, self.typeList, #GmCfg, function (index, itemObj)
        itemObj.mailTitleText.text:SetText(GmCfg[index].name)
        itemObj.scaleButton.onClick:RemoveAllListeners()
        itemObj.scaleButton.onClick:AddListener(function ()
            self.curGmType = index
            self:bindGmDetail()
        end)

    end)
end

function GmPanel:bindGmDetail()
    self:FillTemplateContent(self.gMDetailItem, self.strList, #GmCfg[self.curGmType].funcList, function (index, itemObj)
        local cfg = GmCfg[self.curGmType].funcList[index]
        itemObj.gmTex.text:SetText(cfg.name)
        itemObj.scaleButton.onClick:RemoveAllListeners()
        itemObj.scaleButton.onClick:AddListener(function ()
            self.inputField.tMP_InputField:SetTextWithoutNotify(cfg.str)
        end)
    end)
end

--function GmPanel:OnClose(initiative)
--
--end

--function GmPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function GmPanel:OnRefresh(data)
--
--end

--[[
/BoxBg/GMBox onClick 
--]]
function GmPanel:gMBox_ScaleButton_onClick(gMBox)

end

--[[
/CustomBackPanel/Bg/BackBg/BackBtn onClick 
--]]
function GmPanel:backBtn_ScaleButton_onClick(backBtn)
    UIMgr:closeCurrentUI()
end

--[[
/CustomBackPanel/Bg/BackMainBtn onClick 
--]]
function GmPanel:backMainBtn_ScaleButton_onClick(backMainBtn)

end

--[[
/CustomBackPanel/Bg/HelpBtn onClick 
--]]
function GmPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/BoxBg/GMDetailItem onClick 
--]]
function GmPanel:gMDetailItem_ScaleButton_onClick(gMDetailItem)

end

function GmPanel:btStart_ScaleButton_onClick(btStart)
    local code = self.inputField.tMP_InputField.text
    --LuaMgr.Instance.lua:DoString(code)
    LuaLogger.e("Executing GM command: " .. code)
    self:execute(code)
    -- UIMgr:closeUI(self)
end

--[[
/EnterLevelBtn onClick 
--]]
function GmPanel:enterLevelBtn_ScaleButton_onClick(enterLevelBtn)
    local str = self.levelField.tMP_InputField.text
    local levelId = tonumber(str)
    if levelId > 0 then
        Me:setNowSelectLevel(levelId)
        UIMgr:closeCurrentUI()
        LoadingMgr:SetLoadingStart(function()
            StateMgr:ChangeToState(GameFlowState.BattleState)
        end, nil, nil, "GmPanel")
    elseif levelId == -1 then
        UIMgr:popUI("BombGamePanel")
    else
        UICommonUtils.PopToast("关卡id不合法")
    end
end

--[[
/HomelandStoryBtn onClick 
--]]
function GmPanel:homelandStoryBtn_ScaleButton_onClick(homelandStoryBtn)
    local str = self.hStoryIDField.tMP_InputField.text
    local storyArraryId = tonumber(str)
    if storyArraryId > 0 then
        UIMgr:closeCurrentUI()
        DLuaTimer:DoAfter(0.1, function()
            StoryMgr:playHomeStory(storyArraryId)
        end)
    else
        UICommonUtils.PopToast("家园剧情id不合法")
    end
end

return GmPanel
