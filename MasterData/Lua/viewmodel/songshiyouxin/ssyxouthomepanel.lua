local objs = {
    remainTime = {path = "root/Middle/RemainTimeBG/RemainTime", type = UITool.Text},
    collectText = {path = "root/Middle/CollectBtn/CollectText", type = UITool.Text},
    collectBtn = {path = "root/Middle/CollectBtn", type = UITool.Button},
    novelBtn = {path = "root/Left/Group/NovelBtn", type = UITool.Button},
    drongeonBtn = {path = "root/Left/Group/DrongeonBtn", type = UITool.Button},
    shopBtn = {path = "root/Left/Group/ShopBtn", type = UITool.Button},
    passBtn = {path = "root/Left/Group/PassBtn", type = UITool.Button},
    towerBtn = {path = "root/Right/Group/TowerBtn", type = UITool.Button},
    gameBtn = {path = "root/Right/Group/GameBtn", type = UITool.Button},
    leftObj = {path = "root/Left/Group", type = UITool.Transform},
    rightObj = {path = "root/Right/Group", type = UITool.Transform},
    testObj = {path = "root/TestObj", type = UITool.GameObject},
    gmBtn1 = {path = "root/TestObj/GMButton1", type = UITool.Button},
    gmBtn2 = {path = "root/TestObj/GMButton2", type = UITool.Button},
    gmBtn3 = {path = "root/TestObj/GMButton3", type = UITool.Button},
    gmBtn4 = {path = "root/TestObj/GMButton4", type = UITool.Button},
    gmBtn5 = {path = "root/TestObj/GMButton4", type = UITool.Button}
}

local this = {}

this.before_awake = function()
    this.IsDebug = LuaMgr.IsDebug()
    SetActive(this.testObj, this.IsDebug)
    RedMgr.Singleton:RegisterViewModel(UIName.SSYXOutHomePanel)
end

this.before_active = function()
    this.remainTime.text = SSYXData.GetRemainTimeStr()
    this.OnUpdateMedalCollect()
    SSYXData.CheckRed()
end

this.OnClickCollectBtn = function()
    if SSYXData.CheckActivityRunning() then
        local medalDatas = SSYXConst.MedalActivityID
        LuaMgr.ShowLuaPanel(UIName.ActivityCollectPanel, medalDatas, "#CF54AE")
    end
end

this.OnClickNovelBtn = function()
    if SSYXData.CheckActivityRunning() == false then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.SSYXOutNovelPanel)
end

this.OnClickDrongeonBtn = function()
    if SSYXData.CheckActivityRunning() == false then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.SSYXOutDungeonPanel)
end

this.OnClickShopBtn = function()
    if SSYXData.CheckActivityRunning() == false then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.SSYXOutShopPanel)
end

this.OnClickPassBtn = function()
    if SSYXData.CheckActivityRunning() == false then
        return
    end
    local data = {}
    data.medalActivityID = "30101"
    data.medalColor = "#3d6053"
    data.medalImgKey = "ui_hd_ty_dtyl_bt_ssyx"
    data.bgmPath = "Assets/_BundleResources/Audio/Bgm/songshiyouxin.mp3"
    LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data)
end

this.OnClickTowerBtn = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.TeamTower) then
        LuaMgr.ShowPanel("Laigu.ViewModel.MessageTipsViewModel", LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_29762"))
        return
    end
    LuaMgr.ShowLuaPanel(UIName.TeamTowerMainViewModel)
end

this.OnClickGameBtn = function()
    if SSYXData.CheckActivityRunning() == false then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.SSYXGameHomePanel)
end


this.OnUpdateMedalCollect = function()
    local medalActivityID = SSYXConst.MedalActivityID
    local finishMedalCount = DataExHelper.GetMedalFinishCount(medalActivityID)
    local medalList = DataExHelper.GetMedalList(medalActivityID)

    local totalFinishMedalCount = finishMedalCount
    this.medalList = {}
    this.AddMedalList(medalList)
    this.collectText.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), totalFinishMedalCount, #this.medalList)
    PlayerMedalMgr.CheckMedalPopup(medalActivityID)
end

this.AddMedalList = function(list)
    for key, value in pairs(list) do
        table.insert(this.medalList, value)
    end
end



this.OnClickGMBtn1 = function()
    local data = {}
    data.AllBuild = false
    data.AllEmployee = true
    data.AllTechTree = false
    this.RequstGM(data)
end
this.OnClickGMBtn2 = function()
    local data = {}
    data.AllBuild = false
    data.AllEmployee = false
    data.AllTechTree = true
    this.RequstGM(data)
end
this.OnClickGMBtn3 = function()
    local data = {}
    data.AllBuild = true
    data.AllEmployee = false
    data.AllTechTree = false
    this.RequstGM(data)
end
this.OnClickGMBtn4 = function()
    local data = {}
    data.AllBuild = true
    data.AllEmployee = true
    data.AllTechTree = true
    this.RequstGM(data)
end

this.OnClickGMBtn5 = function()
    local data = {}
    data.AllBuild = false
    data.AllEmployee = false
    data.AllTechTree = false
    this.RequstGM(data)
end

this.RequstGM = function(data)
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            LuaDebug.error("SSYXData.UseItem 请求错误:" .. res.code)
            return
        end
        SSYXData.CheckRed()
    end
    ApiMgr.Request("operateBuild/gm", data, true, onSucc, nil, true)
end


local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.collectBtn, this.OnClickCollectBtn)
        LuaMgr.AddClick(this.novelBtn, this.OnClickNovelBtn)
        LuaMgr.AddClick(this.drongeonBtn, this.OnClickDrongeonBtn)
        LuaMgr.AddClick(this.shopBtn, this.OnClickShopBtn)
        LuaMgr.AddClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.AddClick(this.towerBtn, this.OnClickTowerBtn)
        LuaMgr.AddClick(this.gameBtn, this.OnClickGameBtn)
        if this.IsDebug == true then
            LuaMgr.AddClick(this.gmBtn1, this.OnClickGMBtn1)
            LuaMgr.AddClick(this.gmBtn2, this.OnClickGMBtn2)
            LuaMgr.AddClick(this.gmBtn3, this.OnClickGMBtn3)
            LuaMgr.AddClick(this.gmBtn4, this.OnClickGMBtn4)
            LuaMgr.AddClick(this.gmBtn5, this.OnClickGMBtn5)
        end
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.collectBtn, this.OnClickCollectBtn)
        LuaMgr.RemoveClick(this.novelBtn, this.OnClickNovelBtn)
        LuaMgr.RemoveClick(this.drongeonBtn, this.OnClickDrongeonBtn)
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShopBtn)
        LuaMgr.RemoveClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.RemoveClick(this.towerBtn, this.OnClickTowerBtn)
        LuaMgr.RemoveClick(this.gameBtn, this.OnClickGameBtn)
        if this.IsDebug == true then
            LuaMgr.RemoveClick(this.gmBtn1, this.OnClickGMBtn1)
            LuaMgr.RemoveClick(this.gmBtn2, this.OnClickGMBtn2)
            LuaMgr.RemoveClick(this.gmBtn3, this.OnClickGMBtn3)
            LuaMgr.RemoveClick(this.gmBtn4, this.OnClickGMBtn4)
            LuaMgr.RemoveClick(this.gmBtn5, this.OnClickGMBtn5)
        end
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)