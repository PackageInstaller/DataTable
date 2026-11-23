local this = {
    camera = nil,
    aniName = "ani_VoyageOpenCardPanel_root",
    isDrag = false,
    dragTime = 0,
    downPos = nil,
    dragPos = nil,
    isBack = false,
    isForward = false,
    normalizedTime = 0.0,
    normalizedFrame = 0.0,
    forwardTime = 0.0,
    rect = {},
    isShowCard = false,
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    openCard = { path = "root/Middle/OpenCard", type = "GameObject" },
    animator2 = { path = "root/Middle/OpenCard", type = "Animator" },
    dragRectGO = { path = "root/Middle/OpenCard/DragRect", type = "GameObject" },
    dragRectTF = { path = "root/Middle/OpenCard/DragRect", type = "RectTransform" },
    openCardEff = { path = "root/Middle/OpenCard/eff_group", type = "GameObject" },
};


this.InitRect = function()
    local sizeDelta = this.dragRectTF.sizeDelta;
    local halfWidth = sizeDelta.x / 2;
    local halfHeight = sizeDelta.y / 2;
    this.rect.x = -halfWidth - 5;
    this.rect.mx = halfWidth + 5;
    this.rect.rx = -halfWidth;
    this.rect.y = -halfHeight;
    this.rect.my = halfHeight;
    this.rect.time = 0.6;
    this.rect.len = sizeDelta.x;
end


this.SetData = function()
    SetActive(this.openCard, true);
    SetActive(this.dragRectGO, true);
    SetActive(this.openCardEff, false);



    this.isShowCard = false;
end


this.SetShowCard = function()
    PlayerVoyageMgr.UnlockCard(this.UnlockCardResponse);
end


this.UnlockCardResponse = function(result)
    local data = json.decode(result);
    if (data ~= nil and data.result ~= nil) then
        SetActive(this.openCard, false);
        local goods = ConfigMgr.Config.SailingGoodsMap[data.result.GoodsId];
        if (goods ~= nil) then
            LuaMgr.ShowLuaPanel(UIName.VoyageCardInfoViewModel, goods);
        end
        LuaMgr.HidePanel(UIName.VoyageOpenCardViewModel);
        PlayerVoyageMgr.CheckRedDot();
        RedMgr.Singleton:RefreshOtherViewModel(UIName.VoyageViewModel);
        LuaMgr.InvokeUIEventListeners(UIEventConst.VoyageCardsUnlock);
    end
end


this.OnShowComplete = function()
    LuaMgr.RemoveTimer(TimerConst.VoyageCardsShowComplete);
    this.animator2.enabled = true;
end


this.OnOpenComplete = function()
    LuaMgr.RemoveTimer(TimerConst.VoyageCardsOpenComplete);
    this.SetShowCard();
end


this.OnUpdate2 = function()
    if (this.isShowCard) then return end
    
    if (RaycastTool.GetMouseButtonDown(0)) then
        this.isDrag = true;
        this.dragTime = CS.UnityEngine.Time.realtimeSinceStartup;
        this.downPos = RaycastTool.GetMousePosition();
    elseif (RaycastTool.GetMouseButtonUp(0)) then
        this.isDrag = false;
        if (this.dragPos ~= nil) then
            local realtimeSinceStartup = CS.UnityEngine.Time.realtimeSinceStartup;
            if (realtimeSinceStartup - this.dragTime > 0.2) then
                local dist = this.dragPos.x - this.downPos.x;
                if (dist > 30) then
                    this.isShowCard = true;
                    SetActive(this.dragRectGO, false);
                    this.animator.AnimationName = "ani_VoyageOpenCardPanel_root_open";
                    SetActive(this.openCardEff, true);
                    LuaMgr.AddTimer(TimerConst.VoyageCardsOpenComplete, this.OnOpenComplete, 2.5, 1, false);
                end
            end
        end
    end
    if (this.isDrag) then
        this.dragPos = RaycastTool.GetMousePosition();
    end
end


this.OnUpdate = function()
    if (this.isShowCard) then return end
    
    if (this.isBack) then
        if (this.normalizedFrame > 0) then
            if (this.normalizedFrame >= 0.1) then
                this.normalizedFrame = this.normalizedFrame - 0.1;
            else
                this.normalizedFrame = 0;
            end
            local time = this.normalizedTime * this.normalizedFrame;
            this.animator:PlayFrame(this.aniName, time);
        else
            this.isBack = false;
        end
        return;
    end
    if (this.isForward) then
        if (this.normalizedFrame < 1) then
            this.normalizedFrame = this.normalizedFrame + 0.1;
            local time = this.forwardTime * this.normalizedFrame;
            this.animator:PlayFrame(this.aniName, this.normalizedTime + time);
        else
            this.isForward = false;
            this.SetShowCard();
        end
        return;
    end
    if (RaycastTool.GetMouseButtonDown(0)) then
        this.isDrag = true;
        this.dragTime = CS.UnityEngine.Time.realtimeSinceStartup;
    elseif (RaycastTool.GetMouseButtonUp(0)) then
        this.isDrag = false;
        if (this.dragPos ~= nil) then
            local realtimeSinceStartup = CS.UnityEngine.Time.realtimeSinceStartup;
            if (realtimeSinceStartup - this.dragTime > 0.2) then
                local p = RectTransformTool.ScreenToLocal(this.dragPos, this.dragRectTF, this.camera);
                local len = p.x - this.rect.rx;
                this.normalizedTime = len / this.rect.len;
                if (this.normalizedTime > this.rect.time) then
                    if (this.normalizedTime >= 1) then
                        this.SetShowCard();
                    else
                        this.normalizedFrame = 0.0;
                        this.forwardTime = 1.0 - this.normalizedTime;
                        this.isForward = true;
                    end
                else
                    this.normalizedFrame = 1.0;
                    this.isBack = true;
                end
            else
                this.normalizedFrame = 1.0;
                this.isBack = true;
            end
        end
    end
    if (this.isDrag) then
        this.dragPos = RaycastTool.GetMousePosition();
        local p = RectTransformTool.ScreenToLocal(this.dragPos, this.dragRectTF, this.camera);
        if (p.x >= this.rect.rx or (p.x >= this.rect.x and p.x <= this.rect.mx and p.y >= this.rect.y and p.y <= this.rect.my)) then
            local len = p.x - this.rect.rx;
            local time = len / this.rect.len;
            this.animator:PlayFrame(this.aniName, time);
        else
            this.dragPos = nil;
        end
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.InitRect();
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.SetData();
        this.animator.AnimationName = this.aniName;
        this.animator2.enabled = false;
        LuaMgr.AddTimer(TimerConst.VoyageCardsShowComplete, this.OnShowComplete, 1, 1, false);
        this.camera = LuaMgr.UICamera();


        LuaMgr.AddUpdate(this.OnUpdate2);
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUpdate(this.OnUpdate2);
        LuaMgr.RemoveTimer(TimerConst.VoyageCardsShowComplete);
        this.camera = nil;
        this.downPos = nil;
        this.dragPos = nil;
    end,
    before_destroy = function()
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})