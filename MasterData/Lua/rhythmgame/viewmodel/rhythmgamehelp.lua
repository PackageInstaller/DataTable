
local this = {
    bannerScrollCenter = nil,
    bannerIndex = 0
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    finishBtn = { path = "root/Middle/Group/FinishBtn", type = "Button" },
    leftBtn = { path = "root/Middle/Group/LeftBtn", type = "Button" },
    rightBtn = { path = "root/Middle/Group/RightBtn", type = "Button" },
    title = { path = "root/Middle/Group/Title", type = "Text" },

    desc1 = { path = "root/Middle/Group/Desc1", type = "Text" },

    itemsTF = { path = "root/Middle/Group/DotList", type = "Transform" },
    item = { path = "template/DotItem", type = "GameObject" },
};

local data = {
    bannerItemDatas = {{buildTexture = DefaultTexture}},
}


this.SetData = function()
    this.animator.AnimationName = "ani_ui_RhythmGameHelpPanel";
    this.isInitBanner = false
    this.finish = false
    SetActive(this.finishBtn.gameObject, false)

    SetActive(this.leftBtn.gameObject, true)
    SetActive(this.rightBtn.gameObject, true)
    SetActive(this.title.gameObject, true)

    local musicConfig = PlayerRhythmGameMgr.GetMusicConfig()
    local id = musicConfig.id
    this.picConfig = ConfigRhythmGameMgr.GetGuidePic(id)
    if not this.picConfig or #this.picConfig <= 0 then
        this.OnFinishBtn()
        LuaDebug.error("no picConfig" .. id)
        return
    end

    this.dotItems = {}
    for i = 1, #this.picConfig, 1 do        
        local obj = LuaMgr.InstantiateGO(this.item);
        if (obj ~= nil) then
            local objTF = obj:GetComponent("RectTransform");
            objTF:SetParent(this.itemsTF, false);
            local temp = {objTF = obj.transform, id = i}
            temp.root = obj
            temp.lightObj = objTF:Find("Light").gameObject
            if i == 1 then
                SetActive(temp.lightObj, true)
            else 
                SetActive(temp.lightObj, false)
            end
            table.insert(this.dotItems, temp)
        end
    end
    this.SetPics()
end

this.OnLeftBtn = function()
    this.bannerScrollCenter:ToLeft();
end

this.OnRightBtn = function()
    if (this.bannerScrollCenter.GetCurrentPage + 1 >= this.bannerScrollCenter.GetAllPage) then
        this.OnScrollEndCallback();
    else
        this.bannerScrollCenter:ToRight();
    end
end

this.OnFinishBtn = function()
    if this.finish then
        return
    end
    this.finish = true
    this.animator.AnimationName = "ani_ui_RhythmGameHelpPanel_root_02";
end

this.SetPics = function()
    local tempList = {}
    local path,texture = nil,nil
    for i, v in ipairs(this.picConfig) do
path = Path.Image.."RhythmGame/" .. v.Picture[1]
        texture = LuaMgr.GetTexture(path)
        table.insert(tempList,{buildTexture = texture})
    end
    this.vm.data.bannerItemDatas = tempList
    this.bannerScrollCenter.scrollEndCallback = this.OnScrollEndCallback;
    this.bannerScrollCenter:InitPageArray(#tempList, false)
    this.bannerScrollCenter:SetCurrentPage(0);
    this.SelectBanner(0);
    this.isInitBanner = true;
end

this.OnScrollEndCallback = function()
    this.SelectBanner(this.bannerScrollCenter.GetCurrentPage);
end

this.SelectBanner = function(index)
    if this.bannerIndex == index and this.isInitBanner then
        return
    end

    this.bannerIndex = index;

    this.title.text = LuaMgr.GetLangText(this.picConfig[this.bannerIndex + 1].NameLan)
    this.desc1.text = LuaMgr.GetLangText(this.picConfig[this.bannerIndex + 1].PictureTextLan)
    local c = this.desc1.color
    c.a = 0
    this.desc1.color = c
    c.a = 1
    if this.colorT then
        this.colorT:Kill()
        this.colorT = nil
    end

    this.colorT = this.desc1:DOColor(c, 1)

    if this.bannerIndex < #this.dotItems then
        for i, v in ipairs(this.dotItems) do            
            if i == this.bannerIndex + 1 then
                SetActive(v.lightObj, true)
            else 
                SetActive(v.lightObj, false)
            end
        end
    end
    
    if this.bannerIndex + 1 >= #this.dotItems then
        SetActive(this.finishBtn.gameObject, true)

        SetActive(this.leftBtn.gameObject, true)
        SetActive(this.rightBtn.gameObject, false)
    else
        SetActive(this.finishBtn.gameObject, false)
        
        SetActive(this.leftBtn.gameObject, this.bannerIndex ~= 0)
        SetActive(this.rightBtn.gameObject, true)
    end

    if #this.dotItems == 1 then
        SetActive(this.leftBtn.gameObject, false)
        SetActive(this.rightBtn.gameObject, false)
    end
end

this.OnAniPlayFinish = function(args)
    if args[0] == "ani_ui_RhythmGameHelpPanel_root_02" then
        RhythmGameMgr.Play()
        LuaMgr.HidePanel(UIName.RhythmGameHelp)
    end
end

local command = {}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        
        LuaMgr.AddClick(this.finishBtn, this.OnFinishBtn);
        LuaMgr.AddClick(this.leftBtn, this.OnLeftBtn);
        LuaMgr.AddClick(this.rightBtn, this.OnRightBtn);

        local transform = vm.behaviour.transform;
        this.bannerScrollCenter = transform:Find("root/Middle/Group/blackbroad/ScrollView"):GetComponent("ScrollChildrenCenter");
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        this.SetData()
    end,

    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        for i, v in ipairs(this.dotItems) do
            LuaMgr.DestroyImmediateGO(v.root); 
        end
        this.dotItems = {}
        vm.data.bannerItemDatas = {}
    end,

    before_destroy = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        LuaMgr.RemoveClick(this.finishBtn, this.OnFinishBtn);
        LuaMgr.RemoveClick(this.leftBtn, this.OnLeftBtn);
        LuaMgr.RemoveClick(this.rightBtn, this.OnRightBtn);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})