





local this = {
    vm = nil,medalConfig = nil,
}

local data = {
    medal = false,medalIcon = DefaultSprite,medalName = "",medalIntro = "",
    title = false,playerTitle = DefaultSprite,playerTitleText = "",titleTipStr = "",
    playerTitlePos = Vector2.zero
}

local command = {

}

local hook = {
    before_awake = function(vm)
        this.vm = vm
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.AddUIEvent()
        this.InitParameter()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.RemoveUIEvent()
    end,
    before_destroy = function(vm)
        this = nil
    end,
}

this.AddUIEvent = function()

end
this.RemoveUIEvent = function()

end


this.InitParameter = function()
    if this.vm.behaviour.Params.Length < 1 then return end
    if this.vm.behaviour.Params.Length == 1 then
        local tempParam = this.vm.behaviour.Params[0]
        if TableIsNull(tempParam) then
            return
         end
        this.medalConfig = this.GetMedalConfig(tempParam.Id)
        if TableIsNull(this.medalConfig) then
            return
        end
        this.vm.data.medalIcon = LuaMgr.GetSprite("ZhanXunIcon", this.medalConfig.Id)
        this.vm.data.medalName = LuaMgr.GetLangText(this.medalConfig.NameLan)
        this.vm.data.medalIntro = ConfigMgr.LangGlobal("24067")
    
        local tempData = {}
        tempData["MedalIds"] = {this.medalConfig.Id}
        ApiMgr.Request("update_medal_status", tempData,true,function(result)
            local re = json.decode(result)
            if re.code == 0 then
                LuaMgr.AddTimer(TimerConst.MedalPopupClose,function()
                    LuaMgr.HidePanel(UIName.MedalPopupViewModel)
                    LuaMgr.RemoveTimer(TimerConst.MedalPopupClose)
                end,3,1,false)
            end
        end,nil,true)
        this.vm.data.medal = true
        this.vm.data.title = false
    elseif this.vm.behaviour.Params.Length == 2 then
        this.vm.data.titleTipStr = ConfigMgr.LangGlobal("31208")
        local title = this.vm.behaviour.Params[1]
        if not TableIsNull(title) then
            this.vm.data.playerTitle = LuaMgr.GetSprite("PlayerTitle",title.img)
            this.vm.data.playerTitleText = LuaMgr.GetLangText(title.namelan)
            if title.img == "Title_40001" then
                this.vm.data.playerTitlePos =  Vector2(2,1)
            else
                this.vm.data.playerTitlePos =  Vector2(10,1)
            end
        end
        this.vm.data.medal = false
        this.vm.data.title = true
        LuaMgr.AddTimer(TimerConst.MedalPopupClose,function()
            LuaMgr.HidePanel(UIName.MedalPopupViewModel)
            LuaMgr.RemoveTimer(TimerConst.MedalPopupClose)
        end,3,1,false)
    end
end

this.GetMedalConfig = function(id)
    for i = 1, #ConfigMgr.Config.Medals do
        if ConfigMgr.Config.Medals[i].Id == id then
            return ConfigMgr.Config.Medals[i]
        end
    end
    return nil
end

return vm({
    data = data,
    command = command,
    hook = hook
})