NFCMgr = {}

NFCMgr.CurNfcRecordContent = {
    card_id = "",
    card_type = "",
    card_targets = "",
    expire_time = 0,
    sign = "",
}

NFCMgr.StartNfcBehaviour = function()
    LuaMgr.StartNFCBehaviour();
end

NFCMgr.StopNfcBehaviour = function()
    LuaMgr.StopNFCBehaviour();
end

NFCMgr.DisposeData = function(data)
    local effectiveData = false
    local tempData = json.decode(data)
    for i in ipairs(tempData) do
if(tempData[i].Content ~= nil and tempData[i].Type == "TEXT") then
            local textContent = tempData[i].Content
            local success, recordContent = pcall(json.decode, textContent)

if(success and NFCMgr.IsValidNfcRecord(recordContent)) then
                effectiveData = true
                NFCMgr.CurNfcRecordContent = recordContent
                break
            end
        end
    end


    if not effectiveData or NFCMgr.switch_cardEvent[NFCMgr.CurNfcRecordContent.card_type] == nil then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("2037"))
        NFCMgr.CurNfcRecordContent = nil
        return
    end


    if not NFCMgr.CanTriggerCardEvent() then
        NFCMgr.CurNfcRecordContent = nil
        return
    end


    if NFCMgr.switch_cardEvent[NFCMgr.CurNfcRecordContent.card_type] == nil then
        NFCMgr.CurNfcRecordContent = nil
        return
    end


    ApiMgr.Request("get_nfc_reward", NFCMgr.CurNfcRecordContent, true, function(result)
        local re = json.decode(result)
        local serverData = json.encode(re.result.Rewards)
        NFCMgr.switch_cardEvent[NFCMgr.CurNfcRecordContent.card_type](serverData)
        NFCMgr.CurNfcRecordContent = nil
    end, function()
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("2037"))
    end, false)
end

NFCMgr.PageCardEvent = function(data)
    local targetPage = NFCMgr.CurNfcRecordContent.card_targets
    local canGoToPageList = ConfigMgr.Config.constants.NFCJump

    for key, value in pairs(canGoToPageList) do
        if value == targetPage then
            FeatureManager.GotoPanel(targetPage)
            return
        end
    end

    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("2037"))
end

NFCMgr.CDKCardEvent = function(data)
FeatureManager.GotoPanel("1037");
    LuaMgr.ShowLuaPanel(UIName.CharageCDKeyViewModel, "NFC", NFCMgr.CurNfcRecordContent.card_targets)
end

NFCMgr.RewardCardEvent = function(data)
    if data == "null" then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("2037"))
    else
        LuaMgr.ShowItemRewared(data)
    end
end

NFCMgr.switch_cardEvent = {
    CDK = NFCMgr.CDKCardEvent,
    Reward = NFCMgr.RewardCardEvent,
    Page = NFCMgr.PageCardEvent,
}

NFCMgr.CanTriggerCardEvent = function()

return (LuaMgr.IsPanelOpen(UIName.MainPageViewModel) or
LuaMgr.IsPanelOpen(UIName.AreaDailyMainViewModel) or
LuaMgr.IsPanelOpen(UIName.AreaDailyViewModel) or
LuaMgr.IsPanelOpen(UIName.HeroPackageViewModel) or
LuaMgr.IsPanelOpen(UIName.HeroManagerViewModel) or
LuaMgr.IsPanelOpen(UIName.ActivityOnViewModel) or
LuaMgr.IsPanelOpen(UIName.MainShopViewModel) or
LuaMgr.IsPanelOpen(UIName.BackpackViewModel) or
LuaMgr.IsPanelOpen(UIName.MissionPageViewModel) or
LuaMgr.IsPanelOpen(UIName.CollectorPracticeSelectMapViewModel) or
LuaMgr.IsPanelOpen(UIName.MailViewModel) or
LuaMgr.IsPanelOpen(UIName.TerminalViewModel) or
LuaMgr.IsPanelOpen(UIName.CollectionMapViewModel) or
LuaMgr.IsPanelOpen(UIName.GroupPhotoViewModel) or
LuaMgr.IsPanelOpen(UIName.JournalFileViewModel) or
LuaMgr.IsPanelOpen(UIName.SystemSettingViewModel) or
LuaMgr.IsPanelOpen(UIName.SelectCharacterViewModel) or
LuaMgr.IsPanelOpen(UIName.MarketViewModel) or
LuaMgr.IsPanelOpen(UIName.FriendChatViewModel)
    )and not(
LuaMgr.IsPanelOpen(UIName.NovelViewModel) or
LuaMgr.IsPanelOpen(UIName.PreloadViewModel) or
LuaMgr.IsPanelOpen(UIName.NFCReadWriteViewModel))
end




NFCMgr.IsValidNfcRecord = function(data)

    if type(data) ~= "table" then
        return false, "Data is not a table"
    end


    local requiredFields = {
        card_id = "string",
        card_type = "string",
        card_targets = "string",
        expire_time = "number",
        sign = "string"
    }

    for field, expectedType in pairs(requiredFields) do

        if data[field] == nil then
            return false, string.format("Missing required field: %s", field)
        end


        local actualType = type(data[field])
        if actualType ~= expectedType then
            return false, string.format(
                    "Field %s has wrong type. Expected %s, got %s",
                    field, expectedType, actualType
            )
        end
    end


    if #data.card_id < 0 or #data.card_id > 100 then
        return false
    end

    if #data.card_type < 0 or #data.card_type > 100 then
        return false
    end

    if #data.card_targets < 0 or #data.card_targets > 100 then
        return false
    end

    if #data.sign ~= 32 then
        return false
    end


    if NFCMgr.switch_cardEvent[data.card_type] == nil then
        return false
    end
    

    local current_time = os.time()
    local date_table = os.date("*t", current_time)
    local card_time =  os.date("%Y%m%d",data.expire_time)

    local year = card_time // 10000
    local month = (card_time % 10000) // 100
    local day = card_time % 100

    if(month < 0) or (month > 12) or (day < 0) then
        return false
    end

    if year < date_table.year then
        return false
    elseif year == date_table.year then
        if month < date_table.month then
            return false
        elseif month == date_table.month then
            if day < date_table.day then
                return false
            end
        end
    end


    return true
end

return NFCMgr;