local objs = {
    eventGroup = {path = "root/Middle/EventGroup", type = UITool.GameObject},
    passName = {path = "root/Middle/EventGroup/PassName", type = UITool.Text},
    eventName = {path = "root/Middle/EventGroup/EventName", type = UITool.Text},
    bgIcon = {path = "root/Middle/EventGroup/BGIcon", type = UITool.Image},
    desc = {path = "root/Middle/EventGroup/Desc", type = UITool.Text},
    optionBtn1 = {path = "root/Middle/EventGroup/OptionBtn1", type = UITool.Button},
    optionBtn2 = {path = "root/Middle/EventGroup/OptionBtn2", type = UITool.Button},
    optionText1 = {path = "root/Middle/EventGroup/OptionBtn1/Text", type = UITool.Text},
    optionText2 = {path = "root/Middle/EventGroup/OptionBtn2/Text", type = UITool.Text},
    rollGroup = {path = "root/Middle/RollGroup", type = UITool.GameObject},
    rollImg = {path = "root/Middle/RollGroup/RollImg", type = UITool.Image},
    lateastCalGroup = {path = "root/Middle/LateastCalGroup", type = UITool.GameObject},
    cancelBtn = {path = "root/Middle/LateastCalGroup/CancelBtn", type = UITool.Button},
    confirmBtn = {path = "root/Middle/LateastCalGroup/ConfirmBtn", type = UITool.Button},
    content = {path = "root/Middle/LateastCalGroup/_Content", type = UITool.Text},
}

local this = {}

this.before_awake = function()
end

this.before_active = function()
    SetActive(this.eventGroup, this.data.Type == JYCSConst.GameCommonPopupType.Event)
    SetActive(this.rollGroup, this.data.Type == JYCSConst.GameCommonPopupType.Roll)
    SetActive(this.lateastCalGroup, this.data.Type == JYCSConst.GameCommonPopupType.LatestCal or this.data.Type == JYCSConst.GameCommonPopupType.ExistBattle)
    if this.data.Type == JYCSConst.GameCommonPopupType.Event then
        this.RefreshEventUI()
    elseif this.data.Type == JYCSConst.GameCommonPopupType.Roll then
        this.RefreshRollUI()
    elseif this.data.Type == JYCSConst.GameCommonPopupType.LatestCal then
        this.content.text = LuaMgr.GetLangText("JYCSGameCommonPopup_0")
    elseif this.data.Type == JYCSConst.GameCommonPopupType.ExistBattle then
        this.content.text = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_33106")
    end
end


this.RefreshEventUI = function()
    local eventData = this.data.EventData or JYCSData.GetEventConfigByRoll(this.data.RollNum)
    if eventData == nil then
        LuaDebug.error("this.RefreshEventUI 骰子事件数据为空")
        return
    end
    local optionLans = type(eventData.OptionsLan) == "table" and eventData.OptionsLan or {}
    local options = type(eventData.Options) == "table" and eventData.Options or {}
    if #optionLans < 2 and #options < 2 then
        LuaDebug.error("this.RefreshEventUI 骰子事件参数配置错误" .. eventData.Id)
        return
    end
    if eventData.Image ~= nil and eventData.Image ~= "" then
        this.bgIcon.sprite = LuaMgr.GetSprite(JYCSConst.AtlasName, eventData.Image)
    end
    this.optionText1.text = LuaMgr.GetLangText(optionLans[1])
    this.optionText2.text = LuaMgr.GetLangText(optionLans[2])
    this.eventName.text = LuaMgr.GetLangText(eventData.NameLan)
    local mapData = JYCSData.GetMapData()
    if mapData ~= nil then
        this.passName.text = LuaMgr.GetLangText(mapData.Config.NameLan)
    end
    this.desc.text = LuaMgr.GetLangText(eventData.StoryLan)
    this.eventData = eventData
end

this.OnClickOptionBtn1 = function()
    this.OnClickOptionBtn(1)
end

this.OnClickOptionBtn2 = function()
    this.OnClickOptionBtn(2)
end

this.OnClickOptionBtn = function(index)
    this.selectIndex = index
    local data = this.data
    data.EventData = this.eventData
    data.SelectIndex = index
    LuaMgr.InvokeUIEventListeners(UIEventConst.JYCSCloseCommonPopup, data)
    LuaMgr.HidePanel(UIName.JYCSGameCommonPopup)
end

this.OnClickCancelBtn = function()
    LuaMgr.HidePanel(UIName.JYCSGameCommonPopup)
end

this.OnClickConfirmBtn = function()
    if this.data.Callback ~= nil then
        this.data.Callback(this.data)
    end
    if this.data.Callback1 ~= nil then
        this.data.Callback1()
    end
    LuaMgr.HidePanel(UIName.JYCSGameCommonPopup)
end




this.RefreshRollUI = function()
    local rollNum = this.data.RollNum
    this.rollImg.sprite = LuaMgr.GetSprite(JYCSConst.AtlasName, "ui_hd_jycs_xyx_tz_ds_" .. rollNum)
    if this.rollTween ~= nil then
        this.rollTween:Kill(true)
        this.rollTween = nil
    end
    this.rollTween = DOTWeen:Sequence()
    this.rollTween:AppendInterval(JYCSConst.OperateRollTime):OnComplete(this.OnRollAnimEnd)
end

this.OnRollAnimEnd = function()
    this.rollTween:Kill(true)
    this.rollTween = nil
    local data = this.data
    LuaMgr.HidePanel(UIName.JYCSGameCommonPopup)
    LuaMgr.InvokeUIEventListeners(UIEventConst.JYCSCloseCommonPopup, data)
end


local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.optionBtn1, this.OnClickOptionBtn1)
        LuaMgr.AddClick(this.optionBtn2, this.OnClickOptionBtn2)
        LuaMgr.AddClick(this.cancelBtn, this.OnClickCancelBtn)
        LuaMgr.AddClick(this.confirmBtn, this.OnClickConfirmBtn)
        this.before_awake()
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length == 0 then
            return
        end
        this.data = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
        if this.rollTween ~= nil then
            this.rollTween:Kill(false)
            this.rollTween = nil
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.optionBtn1, this.OnClickOptionBtn1)
        LuaMgr.RemoveClick(this.optionBtn2, this.OnClickOptionBtn2)
        LuaMgr.RemoveClick(this.cancelBtn, this.OnClickCancelBtn)
        LuaMgr.RemoveClick(this.confirmBtn, this.OnClickConfirmBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)