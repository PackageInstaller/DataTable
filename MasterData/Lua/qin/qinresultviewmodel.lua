local this = {

};

local objs = {
    aniRoot = { path = "root", type = "Animator" },
    maskBtn = { path = "root/Mask", type = "Button" },
    result1 = { path = "root/Middle/Result1", type = "GameObject" },
    result1Name = { path = "root/Middle/Result1/Name", type = "Text" },
    result1Msg = { path = "root/Middle/Result1/Msg", type = "Text" },
    result2 = { path = "root/Middle/Result2", type = "GameObject" },
    result2Text = { path = "root/Middle/Result2/Text", type = "Text" },
    result3 = { path = "root/Middle/Result3", type = "GameObject" },
    dissolve = { path = "root/Middle/Result1", type = "UIDissolveController" },
    finish = { path = "root/Middle/Result1/Finish", type = "GameObject" },
};


this.SetData = function()    
    SetActive(this.result3, false)
    SetActive(this.finish,true)
    local cache = this.data[1]
    this.result2Text.text =LuaMgr.GetLangText(cache.tipslan);
    this.result1Msg.text = LuaMgr.GetLangText(cache.descriptionlan);
    this.result1Name.text = LuaMgr.GetLangText(cache.tipslan);
    if this.startDelay ~= nil then
        coroutine_runner.stop(this.startDelay)
    end
    this.canClose = true
    this.startDelay = coroutine_runner.start(function()
        AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DaQin/DQ_YP_03.mp3");
        this.aniRoot.enabled = true 
        this.aniRoot:Rebind();
        this.aniRoot:Play("ani_QinResultPanel_root");
        this.canClose = false
        SetActive(this.result1, false)
        SetActive(this.result2, true)       
        coroutine_runner.wait(2)        
        SetActive(this.result2, false)
        SetActive(this.result1, true)
        coroutine_runner.wait(3)
        this.canClose = true
    end)
end


this.SetData2 = function()   
    this.aniRoot.enabled = false 
    this.dissolve.DissolveStep = 1
    SetActive(this.finish,false)
    SetActive(this.result3, false)
    SetActive(this.result2, false)
    SetActive(this.result1, true)
    local cache = this.data   
    this.result1Msg.text = cache.descriptionlan;
    this.result1Name.text = cache.tipslan;   
    this.canClose = true
end


this.OnClickMask = function()
    if (not this.canClose) then
        return
    end
    local index = PlayerPrefs.GetInt(DataMgr.Player.uid .. "qinUnity", 0);
    PlayerQinMgr.SetPlayDissolve(true)
    if (index == 1) then
        this.startDelay = coroutine_runner.start(function()
            AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. "DaQin/DQ_YP_04.mp3");
            PlayerPrefs.SetInt(DataMgr.Player.uid .. "qinUnity", 2);
            SetActive(this.result1, false)
            SetActive(this.result3, true)
            this.aniRoot:Rebind();
            this.aniRoot:Play("ani_QinResultPanel_root_02");
            SetActive(this.maskBtn.gameObject,false)     
            coroutine_runner.wait(1)           
            SetActive(this.maskBtn.gameObject,true)
            SetActive(this.result3, false)
            LuaMgr.HidePanel(UIName.QinResultViewModel);
            LuaMgr.InvokeUIEventListeners(UIEventConst.QinSurveyMapRefresh);
        end)
        return
    end    
    LuaMgr.InvokeUIEventListeners(UIEventConst.QinSurveyMapRefresh);
    LuaMgr.HidePanel(UIName.QinResultViewModel);
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end           
        if(vm.behaviour.Params.Length == 1)then
            this.data = vm.behaviour.Params[0];
            this.SetData();
        else
            this.data = vm.behaviour.Params[0];
            this.SetData2();
        end  
    end,
    before_deactive = function(vm)
        if this.startDelay ~= nil then
            coroutine_runner.stop(this.startDelay)
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})