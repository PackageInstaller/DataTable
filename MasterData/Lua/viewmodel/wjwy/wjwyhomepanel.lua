
require("ViewModel/WJWY/ViewItem/WJWYGameTaskItem")

local objs = {
    downTimeText = { path = "root/Middle/DownTime/DownTimeText", type = UITool.Text },
    collectText = { path = "root/Left/CollectBtn/CollectText", type = UITool.Text },
    passBtn = { path = "root/Left/PassBtn", type = UITool.Button },
    shopBtn = { path = "root/Left/ShopBtn", type = UITool.Button },
    dungeonBtn = { path = "root/Right/DungeonBtn", type = UITool.Button },
    novelBtn = { path = "root/Right/NovelBtn", type = UITool.Button },
    gameBtn = { path = "root/Right/GameBtn", type = UITool.Button },
}
local this = {}

this.before_awake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.WJWYHomePanel)
end

this.before_active = function()
    WJWYData.CheckActivityRunning()
    this.downTimeText.text = WJWYData.GetRemainTimeStr()
    this.OnUpdateMedalCollect()
    WJWYData.CheckRedPoint()
    RedMgr.Singleton:Refresh()
end


this.OnClickPassBtn = function()
    if WJWYData.CheckActivityRunning() == false then
        return
    end
    WJWYData.SetIsChildPanel(true)
    local data = {}
    data.medalActivityID = WJWYConst.MedalActivityID
    data.medalColor = "#3d6053"
    data.medalImgKey = "ui_hd_ty_dtyl_bt_wjwy"
    data.bgmPath = "Assets/_BundleResources/Audio/Bgm/WJWY.mp3"
    LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data)
end

this.OnClickShopBtn = function()
    if WJWYData.CheckActivityRunning() == false then
        return
    end
    WJWYData.SetIsChildPanel(true)
    LuaMgr.ShowLuaPanel(UIName.WJWYShopPanel)
end

this.OnClickDungeonBtn = function()
    LuaMgr.ShowLuaPanel(UIName.WJWYDungeonPanel)
end

this.OnClickNovelBtn = function()
    LuaMgr.ShowLuaPanel(UIName.WJWYNovelPanel)
end

this.OnClickGameBtn = function()
    local callBack = function()
        LuaMgr.ShowLuaPanel(UIName.WJWYLevelPanel)
    end
    LuaMgr.ShowLuaPanel(UIName.WJWYLevelPanel)

end




this.OnUpdateMedalCollect = function()
    local medalActivityID = WJWYConst.MedalActivityID
    local finishMedalCount = DataExHelper.GetMedalFinishCount(medalActivityID)
    local medalList = DataExHelper.GetMedalList(medalActivityID)

    local totalFinishMedalCount = finishMedalCount
    this.medalList = {}
    this.AddMedalList(medalList)
    this.collectText.text = string.format(LuaMgr.GetLangText("CrisisContract2MainViewModel_0"), totalFinishMedalCount,
        #this.medalList)
    PlayerMedalMgr.CheckMedalPopup(medalActivityID)
end

this.AddMedalList = function(list)
    for key, value in pairs(list) do
        table.insert(this.medalList, value)
    end
end




this.SetIntroAnim = function(callBack)
    SetActive(this.topBarComp, false)
    if this.introAnimTween ~= nil then
        this.introAnimTween:Kill(true)
    end
    this.introAnimTween = DOTWeen:Sequence()
    local tweenCallback = function()
        SetActive(this.topBarComp, true)
        if callBack ~= nil then
            callBack()
        end
    end
    this.introAnimTween:AppendInterval(WJWYConst.IntroAnimTime):OnComplete(tweenCallback)
end



local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.AddClick(this.shopBtn, this.OnClickShopBtn)
        LuaMgr.AddClick(this.dungeonBtn, this.OnClickDungeonBtn)
        LuaMgr.AddClick(this.novelBtn, this.OnClickNovelBtn)
        LuaMgr.AddClick(this.gameBtn, this.OnClickGameBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        if this.topBarComp == nil then
            local topBarObj = UnityEngine.GameObject.Find("UIRoot(Clone)/Fixed")
            this.topBarComp = topBarObj
        end
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShopBtn)
        LuaMgr.RemoveClick(this.dungeonBtn, this.OnClickDungeonBtn)
        LuaMgr.RemoveClick(this.novelBtn, this.OnClickNovelBtn)
        LuaMgr.RemoveClick(this.gameBtn, this.OnClickGameBtn)
        UIScrollView.ClearItem("WJWYGameTaskItem")
        RedMgr.Singleton:RemoveViewModel(UIName.WJWYHomePanel);
    end
}

local command = {}
local data = {}
return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)