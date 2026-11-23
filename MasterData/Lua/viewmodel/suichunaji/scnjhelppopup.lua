require("ViewModel/SuiChuNaJi/ViewItem/SCNJHelpPlayerItem")
local objs = {
    playerItem = {path = "template/PlayerItem", type = UITool.GameObject},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    closeBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    fastHelpBtn = {path = "root/Middle/FastHelpBtn", type = UITool.Button},
    scrollView = {path = "root/Middle/ScrollView", type = UITool.GameObject},
    helpCountLimit = {path = "root/Middle/HelpCount", type = UITool.Text},
    additionText1 = {path = "root/Middle/HelpAddition1/AdditionText", type = UITool.Text},
    additionText2 = {path = "root/Middle/HelpAddition2/AdditionText", type = UITool.Text},
    helpScoreCountText = {path = "root/Middle/HelpCountBG/HelpCountText", type = UITool.Text}
}

local this = {}

this.before_awake = function()
    this.scrollViewUI = UIScrollView.New(this.scrollView)
end

this.before_active = function(isInit)
    SCNJData.GetHelpList(this.RefreshPlayerList)
    local newHelpLevel, _, helpScore = SCNJData.GetCurHelpLevel()
    local additions = SCNJData.GetHelpAddition(newHelpLevel)
    local addition1, addition2 = additions[1], additions[2]
    local unlockAdditionText = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29538")
    this.additionText1.text = addition1 ~= nil and LuaMgr.GetLangText(addition1.DescLan) or unlockAdditionText
    this.additionText2.text = addition2 ~= nil and LuaMgr.GetLangText(addition2.DescLan) or unlockAdditionText
    this.helpScoreCountText.text = tostring(helpScore)
    if isInit == true then
        SCNJData.SetOldHelpScore()
    end
    this.RefreshHelpCount()
end

this.RefreshHelpCount = function()
    local countLimitLan = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29536")
    local dailyCount, maxCout = SCNJData.GetDailyHelpCount()
    this.helpCountLimit.text = string.format(countLimitLan, dailyCount, maxCout)
end

this.OnClickCloseBtn = function()
    LuaMgr.HidePanel(UIName.SCNJHelpPopup)
end

this.OnClickFastHelpBtn = function()
    if SCNJData.CheckActivityRunning() == false then
        return
    end
    local canHelpPlayer = {}
    local dailyCount, maxCout = SCNJData.GetDailyHelpCount()
    if dailyCount >= maxCout then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29611")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local remainHelpCount = maxCout - dailyCount
    local index = 1
    while #canHelpPlayer < remainHelpCount do
        local playerData = this.playerList[index]
        if playerData == nil then
            break
        end
        if playerData.IsBeHelp == false then
            table.insert(canHelpPlayer, playerData.Uid)
        end
        index = index + 1
    end
    if #canHelpPlayer == 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29539")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    this.HelpRequst(canHelpPlayer)
end

this.RefreshPlayerList = function(playerList)
    this.scrollViewUI:Clear()
    local allDatas = playerList
    this.playerList = playerList
    local scrollDatas = {}
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.helpCallback = this.OnHelpCallback
        local scrollData = UIScrollData.GetData(this.playerItem, "SCNJHelpPlayerItem", 849, 112, data)
        table.insert(scrollDatas, scrollData)
    end
    this.scrollViewUI:SetParams(849, 325)
    this.scrollViewUI:SetData(scrollDatas, true)
end



this.OnHelpCallback = function(item)
    local dailyCount, maxCout = SCNJData.GetDailyHelpCount()
    if dailyCount >= maxCout then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29611")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    local playerUIDs = {item.data.Uid}
    this.HelpRequst(playerUIDs)
    this.lastHelpPlayerItem = item
end

this.HelpRequst = function(playerUIDs)
    SCNJData.SetOldHelpLevel()
    local data = {}
    data.Uids = playerUIDs
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            return
        end
        if #playerUIDs == 1 and this.lastHelpPlayerItem ~= nil then
            this.lastHelpPlayerItem:RefreshHelpStatus(true)
        else
            SCNJData.GetHelpList(this.RefreshPlayerList)
        end
        LuaMgr.ShowLuaPanel(UIName.SCNJHelpSuccPopup)
        RedMgr.Singleton:FrushRedCondition(SCNJConst.RedPoint.Help)
        SCNJData.CheckRed()
        this.before_active()
        LuaMgr.InvokeUIEventListeners(UIEventConst.SCNJHelpSuccess)
    end
    ApiMgr.Request("bossRelay/help", data, true, onSucc, nil, true)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.maskBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.AddClick(this.fastHelpBtn, this.OnClickFastHelpBtn)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        this.before_active(true)
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickCloseBtn)
        LuaMgr.RemoveClick(this.fastHelpBtn, this.OnClickFastHelpBtn)
        UIScrollView.ClearItem("SCNJHelpPlayerItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)