






require("ViewModel/KingDeer/KingDeerZoneItem")
local objs = {
    shopBtn = {path = "root/Left/ShopBtn", type = UITool.Button},
    passBtn = {path = "root/Left/PassBtn", type = UITool.Button},
    pictureBookBtn = {path = "root/Right/PictureBookBtn", type = UITool.Button},
    novelBtn = {path = "root/Right/NovelBtn", type = UITool.Button},
    downTimeTxt = {path = "root/Left/Title/DownTimeTxt", type = UITool.Text}
}

local this = {
    areaCount = 4,
merchantBtnCount = 4,
randomIndex = 1,
    merchantBtns = {},
    merchantBtnTexts = {},

    zoneUIItems = {}
}


local merchantBubbleText = {
    "LangGlobalLan_LangGlobal_name_7327",
    "LangGlobalLan_LangGlobal_name_7328",
    "LangGlobalLan_LangGlobal_name_7329",
    "LangGlobalLan_LangGlobal_name_7330"
}

this.before_awake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.KingDeerMainViewModel)
    KingDeerData.Init()
    local novelID = KingDeerData.GetNovelID(1)
    if KingDeerData.GetNovelIsLook(novelID) == false then
        local playNovelCallback = function()
            LuaMgr.ShowLuaPanel(UIName.KingDeerMainViewModel)
        end
        LuaMgr.PlayNovel(novelID, playNovelCallback)
    end
end

this.OnTimer = function()
    local activityData = DataExHelper.GetDataExByTag(ActivityKey.KingDeerActivity)
    if activityData == nil then
        this.downTimeTxt.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_18344")
        return
    end
    local remainTime = activityData.expireTime - LuaMgr.Timestamp()
    local d, h, m = GetTimeDHM2(remainTime)
    this.downTimeTxt.text = string.format(ConfigMgr.LangGlobal("15506"), d, h, m)
end

this.before_active = function()
    KingDeerData.CheckRedDot(true)
    for key, value in pairs(this.zoneUIItems) do
        value:RefreshItem()
    end
    this.SetMerchantVisible()
    this.OnTimer()
    LuaMgr.AddTimer(TimerConst.KingDeerAfterBattleDelay, this.OnAfterBattle, 0.3, 1, false)
end

this.OnAfterBattle = function()
    if this.CheckActIsEnd() then
        return
    end
    local lastZoneIndex = KingDeerData.GetlastZoneIndex()
    if lastZoneIndex ~= nil then
        LuaMgr.ShowLuaPanel(UIName.KingDeerPassPopup, lastZoneIndex)
    end
end

this.OnOpenShop = function()
    if this.CheckActIsEnd() then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.KingDeerShopViewModel)
end

this.OnOpenPass = function()
    if this.CheckActIsEnd() then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel)
end

this.OnOpenPictureBook = function()
    if this.CheckActIsEnd() then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.KingDeerPictureBookPopup)
end

this.OnOpenMerchant = function()
    if this.CheckActIsEnd() then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.KingDeerMerchantPopup)
end

this.OpenNovel = function()
    if this.CheckActIsEnd() then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.KingDeerNovelPopup)
end

this.CheckActIsEnd = function(key)
    if key == nil then
        key = ActivityKey.KingDeerActivity
    end
    if ActivityMgr.ActivityRuning(key) then
        return false
    end
    local tips = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_15901")
    LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tips)
    return true
end

this.SetMerchantVisible = function()
    this.randomIndex = math.random(1, #this.merchantBtns)
    for i = 1, #this.merchantBtns do
        local obj = this.merchantBtns[i].gameObject
        if this.randomIndex == i then
            SetActive(obj, true)
            this.merchantBtnTexts[this.randomIndex].text = ""
            LuaMgr.AddTimer(TimerConst.KingMerchantDOText, this.DelayMerchantDOText, 0.5, 1, false)
        else
            SetActive(obj, false)
        end
    end
end

this.DelayMerchantDOText = function()
    local text = LuaMgr.GetLangText(merchantBubbleText[this.randomIndex])
    this.merchantBtnTexts[this.randomIndex]:DOText(text, 1)
end

this.RefreshZoneItem = function(param)
    if param == nil or param.Length < 1 then
        return
    end
    local index = param[0].zoneIndex
    this.zoneUIItems[index]:RefreshItem()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        for i = 1, this.areaCount do
            local tempData = {}
            tempData.path = "root/Middle/MapGroup/ZoneBtn" .. i
            tempData.type = UITool.GameObject
            objs["zoneBtn" .. i] = tempData
        end
        for i = 1, this.merchantBtnCount do
            local tempData = {}
            tempData.path = "root/Middle/MerchantGroup/MerchantBtn" .. i
            tempData.type = UITool.Button
            objs["merchantBtn" .. i] = tempData
        end
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.zoneUIItems = {}
        this.merchantBtns = {}
        this.merchantBtnTexts = {}
        for i = 1, this.areaCount do
            local zoneUIItem = KingDeerZoneItem.New(this["zoneBtn" .. i], i)
            table.insert(this.zoneUIItems, zoneUIItem)
        end
        for i = 1, this.merchantBtnCount do
            local merchantBtn = this["merchantBtn" .. i]
            table.insert(this.merchantBtns, merchantBtn)
            local text = merchantBtn.transform:Find("RefreshTips/_Text"):GetComponent(UITool.Text)
            table.insert(this.merchantBtnTexts, text)
            LuaMgr.AddClick(merchantBtn, this.OnOpenMerchant)
        end
        LuaMgr.AddClick(this.shopBtn, this.OnOpenShop)
        LuaMgr.AddClick(this.passBtn, this.OnOpenPass)
        LuaMgr.AddClick(this.pictureBookBtn, this.OnOpenPictureBook)
        LuaMgr.AddClick(this.novelBtn, this.OpenNovel)
        LuaMgr.AddTimer(TimerConst.KingDeerActivity, this.OnTimer, 30, -1, false)
        this.before_awake()
    end,
    before_active = function(vm)
        LuaMgr.AddUIEventListener(UIEventConst.KingDeerMainViewRefresh, this.RefreshZoneItem)
        this.before_active()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.KingDeerMainViewRefresh, this.RefreshZoneItem)
        LuaMgr.RemoveTimer(TimerConst.KingMerchantDOText)
        LuaMgr.RemoveTimer(TimerConst.KingDeerAfterBattleDelay)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.shopBtn, this.OnOpenShop)
        LuaMgr.RemoveClick(this.passBtn, this.OnOpenPass)
        LuaMgr.RemoveClick(this.pictureBookBtn, this.OnOpenPictureBook)
        LuaMgr.RemoveClick(this.novelBtn, this.OpenNovel)
        for key, value in pairs(this.merchantBtns) do
            LuaMgr.RemoveClick(value, this.OnOpenMerchant)
        end
        LuaMgr.RemoveTimer(TimerConst.KingDeerActivity)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)