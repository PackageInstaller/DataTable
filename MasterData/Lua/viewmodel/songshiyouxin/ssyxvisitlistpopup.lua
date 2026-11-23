require("ViewModel/SongShiYouXin/ViewItem/SSYXPlayerItem")
require("ViewModel/SongShiYouXin/ViewItem/SSYXWaterRecordItem")
local objs = {
    waterRecordItem = {path = "template/WaterRecordItem", type = UITool.GameObject},
    playerItem = {path = "template/PlayerItem", type = UITool.GameObject},
    maskBtn = {path = "root/Mask", type = UITool.Button},
    clseBtn = {path = "root/Middle/CloseBtn", type = UITool.Button},
    playerListObj = {path = "root/Middle/PlayerList", type = UITool.GameObject},
    waterRecordListObj = {path = "root/Middle/WaterRecordList", type = UITool.GameObject}
}

local this = {}

this.before_awake = function()
    this.playerListUI = UIScrollView.New(this.playerListObj)
    this.waterRecordListUI = UIScrollView.New(this.waterRecordListObj)
end

this.before_active = function()
    this.RefreshPlayerList()
    this.RefreshWaterList()
end

this.RefreshWaterList = function()
    local allDatas = SSYXData.GetAllVisitRecordList()
    this.waterRecordListUI:Clear()
    local scrollDatas = {}
    local itemWidth = 516
    for i = 1, #allDatas do
        local data = allDatas[i]
        local scrollData = UIScrollData.GetData(this.waterRecordItem, "SSYXWaterRecordItem", itemWidth, 70, data)
        table.insert(scrollDatas, scrollData)
    end
    this.waterRecordListUI:SetParams(itemWidth, 344)
    this.waterRecordListUI:SetData(scrollDatas, true)
end

this.RefreshPlayerList = function()
    local allDatas = SSYXData.GetAllVisitList()
    this.playerListUI:Clear()
    local scrollDatas = {}
    local itemWidth = 367.8
    for i = 1, #allDatas do
        local data = allDatas[i]
        data.OnClickVisitPlayer = this.OnClickVisitPlayer
        local scrollData = UIScrollData.GetData(this.playerItem, "SSYXPlayerItem", itemWidth, 90, data)
        table.insert(scrollDatas, scrollData)
    end
    this.playerListUI:SetParams(itemWidth, 350)
    this.playerListUI:SetData(scrollDatas, true)
end



this.OnClickVisitPlayer = function(item)
    local targetUid = item.data.Uid
    local onSucc = function(result)
        local res = json.decode(result)
        if res.code ~= nil and res.code ~= 0 then
            return
        end
        local visitorData = res.result.Visitor
        if this.VisitPlayerCallback ~= nil then
            this.VisitPlayerCallback(targetUid, visitorData)
        end
        this.OnClickClseBtn()
    end
    local data = {}
    data.Uid = targetUid
    ApiMgr.Request("operateBuild/visit", data, true, onSucc, nil, true)
end

this.OnClickClseBtn = function()
    LuaMgr.HidePanel(UIName.SSYXVisitListPopup)
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        this.before_awake()
        LuaMgr.AddClick(this.maskBtn, this.OnClickClseBtn)
        LuaMgr.AddClick(this.clseBtn, this.OnClickClseBtn)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil or vm.behaviour.Params.Length <= 0 then
            return
        end
        this.VisitPlayerCallback = vm.behaviour.Params[0]
        this.before_active()
    end,
    before_deactive = function(vm)
    end,
    before_destroy = function(vm)
        LuaMgr.AddClick(this.maskBtn, this.OnClickClseBtn)
        LuaMgr.AddClick(this.clseBtn, this.OnClickClseBtn)
        UIScrollView.ClearItem("SSYXWaterRecordItem")
        UIScrollView.ClearItem("SSYXPlayerItem")
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)