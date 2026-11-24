

local objs = {
    bgBtn = {path = "root/BG", type = UITool.Button},
    taskBtn = {path = "root/Right/TaskBtn", type = UITool.Button},
    downTimeText = {path = "root/Middle/DownTime/DownTimeText", type = UITool.Text},
    collectText = {path = "root/Left/CollectBtn/CollectText", type = UITool.Text},
    passBtn = {path = "root/Left/PassBtn", type = UITool.Button},
    shopBtn = {path = "root/Left/ShopBtn", type = UITool.Button},
    dungeonBtn = {path = "root/Right/DungeonBtn", type = UITool.Button},
    novelBtn = {path = "root/Right/NovelBtn", type = UITool.Button},
    gameBtn = {path = "root/Right/GameBtn", type = UITool.Button},
    introAnimGroup = {path = "root/IntroAnimGroup", type = UITool.GameObject}
}
local this = {}

this.before_awake = function()
    RedMgr.Singleton:RegisterViewModel(UIName.JYCSHomePanel)
end

this.before_active = function()
    JYCSData.CheckActivityRunning()
    this.downTimeText.text = JYCSData.GetRemainTimeStr()
    SetActive(this.introAnimGroup, false)
    SetActive(this.taskScrollView, false)
    this.OnUpdateMedalCollect()
    JYCSData.CheckRedPoint()
end



this.OnClickBGBtn = function()
    SetActive(this.taskScrollView, false)
end

this.OnClickPassBtn = function()
    if JYCSData.CheckActivityRunning() == false then
        return
    end
    JYCSData.SetIsChildPanel(true)
    local data = {}
    data.medalActivityID = JYCSConst.MedalActivityID
    data.medalColor = "#3d6053"
    data.medalImgKey = "ui_hd_ty_dtyl_bt_jycs"
    data.bgmPath = "Assets/_BundleResources/Audio/Bgm/jiyechangsheng.mp3"
    LuaMgr.ShowLuaPanel(UIName.PassesMain2ViewModel, data)
    SetActive(this.taskScrollView, false)
end

this.OnClickShopBtn = function()
    if JYCSData.CheckActivityRunning() == false then
        return
    end
    SetActive(this.taskScrollView, false)
    JYCSData.SetIsChildPanel(true)
    LuaMgr.ShowLuaPanel(UIName.JYCSShopPanel)
end

this.OnClickDungeonBtn = function()
    SetActive(this.taskScrollView, false)
    LuaMgr.ShowLuaPanel(UIName.JYCSDungeonPanel)
end

this.OnClickNovelBtn = function()
    SetActive(this.taskScrollView, false)
    LuaMgr.ShowLuaPanel(UIName.JYCSNovelPanel)
end

this.OnClickGameBtn = function()
    SetActive(this.taskScrollView, false)
    local callBack = function()
        LuaMgr.ShowLuaPanel(UIName.JYCSGamePanel)
    end
    this.SetIntroAnim(callBack)
end





this.OnClickTaskBtn = function()
    LuaMgr.ShowLuaPanel(UIName.JYCSTaskPopup)
end




this.OnUpdateMedalCollect = function()
    local medalActivityID = JYCSConst.MedalActivityID
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




this.StopIntroAnim = function()
    if this.introAnimTween ~= nil then
        this.introAnimTween:Kill(false)
        this.introAnimTween = nil
    end
    if this.topBarComp ~= nil and IsObjectNull(this.topBarComp) == false then
        SetActive(this.topBarComp, true)
    end
end

this.SetIntroAnim = function(callBack)
    this.StopIntroAnim()
    SetActive(this.introAnimGroup, true)
    SetActive(this.topBarComp, false)
    this.introAnimTween = DOTWeen:Sequence()
    local tweenCallback = function()
        this.introAnimTween = nil
        if this.isViewReady ~= true or LuaMgr.IsPanelOpen(UIName.JYCSHomePanel) == false then
            return
        end
        SetActive(this.introAnimGroup, false)
        SetActive(this.topBarComp, true)
        if callBack ~= nil then
            callBack()
        end
    end
    this.introAnimTween:AppendInterval(JYCSConst.IntroAnimTime):OnComplete(tweenCallback)
end



local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.bgBtn, this.OnClickBGBtn)
        LuaMgr.AddClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.AddClick(this.shopBtn, this.OnClickShopBtn)
        LuaMgr.AddClick(this.dungeonBtn, this.OnClickDungeonBtn)
        LuaMgr.AddClick(this.novelBtn, this.OnClickNovelBtn)
        LuaMgr.AddClick(this.gameBtn, this.OnClickGameBtn)
        LuaMgr.AddClick(this.taskBtn, this.OnClickTaskBtn)
        this.before_awake()
        this.isViewReady = true
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
        this.StopIntroAnim()
    end,
    before_destroy = function()
        this.isViewReady = false
        this.StopIntroAnim()
        LuaMgr.RemoveClick(this.bgBtn, this.OnClickBGBtn)
        LuaMgr.RemoveClick(this.passBtn, this.OnClickPassBtn)
        LuaMgr.RemoveClick(this.shopBtn, this.OnClickShopBtn)
        LuaMgr.RemoveClick(this.dungeonBtn, this.OnClickDungeonBtn)
        LuaMgr.RemoveClick(this.novelBtn, this.OnClickNovelBtn)
        LuaMgr.RemoveClick(this.gameBtn, this.OnClickGameBtn)
        LuaMgr.RemoveClick(this.taskBtn, this.OnClickTaskBtn)
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