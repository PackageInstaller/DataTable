local objs = {
    directBuyBtn = {path = "root/Middle/Group/DirectBuyBtn", type = UITool.Button},
    passBtn = {path = "root/Middle/Group/PassBtn", type = UITool.Button},
    turnOverBtn = {path = "root/Middle/Group/TurnOverBtn", type = UITool.Button},
    lineBtn = {path = "root/Middle/Group/LineBtn", type = UITool.Button},
    shopFeedBtn = {path = "root/Middle/Group/ShopFeedBtn", type = UITool.Button},
    downTimeTxt = {path = "root/Middle/Group/DownTimeBG/DownTimeTxt", type = UITool.Text}
}

local this = {}


this.OnClickdirectBuyBtn = function()
    if XingHaiData.CheckActivityRunning() == false then
        return
    end
    RedMgr.Singleton:FrushRedCondition(XingHaiData.RedType.TongXingZhiYuan)
    LuaMgr.ShowLuaPanel(UIName.TongXingZhiYuanPanel)
end


this.OnClickpassBtn = function()
    if XingHaiData.CheckActivityRunning() == false then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.ShiJianShaLouPanel)
end


this.OnClickturnOverBtn = function()
    if XingHaiData.CheckActivityRunning() == false then
        return
    end
    RedMgr.Singleton:FrushRedCondition(XingHaiData.RedType.XingZhiCeHui_Home)
    LuaMgr.ShowLuaPanel(UIName.XingZhiCeHuiPanel)
end


this.OnClicklineBtn = function()
    if XingHaiData.CheckActivityRunning() == false then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.TurnOverGridViewModel)
end


this.OnClickshopFeedBtn = function()
    if XingHaiData.CheckActivityRunning() == false then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.ShangTingHuiKuiPanel)
end

this.OnRefreshTime = function ()
    this.downTimeTxt.text = XingHaiData.GetRemainTimeStr()
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs)
        LuaMgr.AddClick(this.directBuyBtn, this.OnClickdirectBuyBtn)
        LuaMgr.AddClick(this.passBtn, this.OnClickpassBtn)
        LuaMgr.AddClick(this.turnOverBtn, this.OnClickturnOverBtn)
        LuaMgr.AddClick(this.lineBtn, this.OnClicklineBtn)
        LuaMgr.AddClick(this.shopFeedBtn, this.OnClickshopFeedBtn)
        RedMgr.Singleton:RegisterViewModel(UIName.XingHaiXuYuHomePanel);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        LuaMgr.AddTimer(TimerConst.XingZhiCeHuiTimer, this.OnRefreshTime, 60, -1, true)
        XingHaiData.CheckRed()
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.XingZhiCeHuiTimer)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.directBuyBtn, this.OnClickdirectBuyBtn)
        LuaMgr.RemoveClick(this.passBtn, this.OnClickpassBtn)
        LuaMgr.RemoveClick(this.turnOverBtn, this.OnClickturnOverBtn)
        LuaMgr.RemoveClick(this.lineBtn, this.OnClicklineBtn)
        LuaMgr.RemoveClick(this.shopFeedBtn, this.OnClickshopFeedBtn)
    end
}

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)