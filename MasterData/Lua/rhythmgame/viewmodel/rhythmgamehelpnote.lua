local this = {};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    backBtn = {
        path = "root/Mask",
        type = "Button"
    },

    leftMask = {
        path = "root/Middle/LeftMask",
        type = "Button"
    },

    rightMask = {
        path = "root/Middle/RightMask",
        type = "Button"
    },
    finishBtn = {
        path = "root/Middle/FinishBtn",
        type = "GameObject"
    },
    btnText = {
        path = "root/Middle/FinishBtn/Text",
        type = "Text"
    },
    aniImage = {
        path = "root/Middle/AniImage",
        type = "GameObject"
    },

    rImage = {
        path = "root/Middle/AniImage/rImage",
        type = "GameObject"
    },

    leftImage = {
        path = "root/Middle/AniImage/Left",
        type = "RectTransform"
    },
    rightImage = {
        path = "root/Middle/AniImage/Right",
        type = "RectTransform"
    },

    fingerLeftText = {
        path = "root/Middle/FingerLeftBtn/Text",
        type = "Text"
    },
    fingerRightText = {
        path = "root/Middle/FingerRightBtn/Text",
        type = "Text"
    },

    fingerLeftBtn = {
        path = "root/Middle/FingerLeftBtn",
        type = "GameObject"
    },
    fingerRightBtn = {
        path = "root/Middle/FingerRightBtn",
        type = "GameObject"
    },
    guide = {
        path = "root/Middle/Guide",
        type = "GameObject"
    },
    guideMiddle = {
        path = "root/Middle/GuideMiddle",
        type = "GameObject"
    },
    guide2 = {
        path = "root/Middle/Guide/fx_Guide_02",
        type = "GameObject"
    },
    guideTip = {
        path = "root/Middle/GuideTip",
        type = "GameObject"
    },
    middle = {
        path = "root/Middle",
        type = "RectTransform"
    },
};


this.SetData = function()
    this.isAreadyClick = false
    this.cutDown = false
    this.cutDownFinish = false
    this.isOnClick = false
    SetActive(this.fingerLeftBtn, false)
    SetActive(this.fingerRightBtn, false)

    SetActive(this.leftMask.gameObject, false)
    SetActive(this.rightMask.gameObject, false)
    SetActive(this.aniImage,false)
    SetActive(this.guide, false)
    SetActive(this.guideMiddle, false)
    SetActive(this.finishBtn, false)
    SetActive(this.rImage, false)
    SetActive(this.guideTip, false)

    this.controlConfig = ConfigRhythmGameMgr.GetGuideControl(RhythmGameMgr.NoteTypeKey[this.curEvent.NoteType])
    if not this.controlConfig then
        RhythmGameMgr.Play();
        LuaMgr.HidePanel(UIName.RhythmGameHelpNote);
        LuaDebug.error("no this.controlConfig" .. RhythmGameMgr.NoteTypeKey[this.curEvent.NoteType])
        return
    end

    this.animator.AnimationName = "ani_RhythmGameHelpNotePanel_root01"
end

this.OnFirstShow = function()
    this.isFirst = this.curEvent.FirstShow
    SetActive(this.finishBtn, true)
    if this.isFirst then
        SetActive(this.aniImage,true)
        this.SetGuide(true)
this.btnText.text = LuaMgr.GetLangText(this.controlConfig.TeachTextLan)
        this.OnCutDown()
    end
end

this.OnCutDown = function()
    this.cutDown = true
    if this.cutDown and not this.curEvent.OnClickBtn then
        this.itemSize.x = this.oldSizeX

        this.speed = this.itemSize.x / 1;
        this.aniLen = this.itemSize.x

        LuaMgr.RemoveUpdate(this.OnUpdate)
        LuaMgr.AddUpdate(this.OnUpdate)
    end
end

this.OnClickBtn = function()
    this.isOnClick = this.curEvent.OnClickBtn
    if this.isOnClick then
        SetActive(this.guideTip, true)
        SetActive(this.aniImage,false)
        this.SetGuide(true)
        LuaMgr.RemoveUpdate(this.OnUpdate)
        LuaMgr.AddUpdate(this.OnUpdate)

        if this.curEvent.isDoubleClick then
            SetActive(this.fingerLeftBtn, true)
            SetActive(this.fingerRightBtn, true)


        elseif this.curEvent.isReverse then
            SetActive(this.fingerLeftBtn, not this.curEvent.isLeft )
            SetActive(this.fingerRightBtn,  this.curEvent.isLeft )



        else
            SetActive(this.fingerLeftBtn, this.curEvent.isLeft )
            SetActive(this.fingerRightBtn, not this.curEvent.isLeft )



        end

        this.fingerLeftText.text = LuaMgr.GetLangText(this.controlConfig.FingerTextLan)
        this.fingerRightText.text = LuaMgr.GetLangText(this.controlConfig.FingerTextLan)

        this.btnText.text = LuaMgr.GetLangText(this.controlConfig.ClickTextLan)
    end
end

this.OnClose = function()
    if this.isOnClick then
        return
    end

    if not this.cutDownFinish then
        return
    end
    this.HidePanel()
end

this.UpdateClick = function()
    if not this.isOnClick and this.cutDownFinish then
        if RhythmGameMgr.onClickLeft or RhythmGameMgr.onClickRight then
            this.HidePanel()
        end
    end

    if this.isOnClick then
        if this.curEvent.isDoubleClick then







            if RhythmGameMgr.onClickLeft and RhythmGameMgr.onClickRight then 
                RhythmGameMgr.onClickLeft = false
                RhythmGameMgr.onClickRight = false
                RhythmGameMgr.OnClickLeftBtn()
                RhythmGameMgr.OnClickRightBtn()
                this.HidePanel()
            end

            if RhythmGameMgr.onClickLeftUP then
                RhythmGameMgr.onClickLeft = false
                RhythmGameMgr.onClickLeftUP = false
            end
            if RhythmGameMgr.onClickRightUP then
                RhythmGameMgr.onClickRight = false
                RhythmGameMgr.onClickRightUP = false
            end
            return
        elseif this.curEvent.isReverse then
            if this.curEvent.isLeft and RhythmGameMgr.onClickRight then
                RhythmGameMgr.OnClickRightBtn()
                RhythmGameMgr.onClickRight = false
                this.HidePanel()
            elseif not this.curEvent.isLeft and RhythmGameMgr.onClickLeft then
                RhythmGameMgr.OnClickLeftBtn()
                RhythmGameMgr.onClickLeft = false
                this.HidePanel()
            end
        else
            if this.curEvent.isLeft and RhythmGameMgr.onClickLeft then
                RhythmGameMgr.OnClickLeftBtn()
                RhythmGameMgr.onClickLeft = false
                this.HidePanel()
            elseif not this.curEvent.isLeft and RhythmGameMgr.onClickRight then
                RhythmGameMgr.OnClickRightBtn()
                RhythmGameMgr.onClickRight = false
                this.HidePanel()
            end
        end
    end
end

this.HidePanel = function()
    this.isFirst = this.curEvent.FirstShow
    this.SetGuide(false)
    RhythmGameMgr.Play();
    LuaMgr.RemoveUpdate(this.OnUpdate)
    LuaMgr.HidePanel(UIName.RhythmGameHelpNote);
end

this.SetGuide = function(vis)
    local data = this.curEvent.data
    if data then
        SetActive(this.guide, vis and this.isFirst)
        if vis then
            local pos = RectTransformTool.ToContainer(data.transform, this.middle, LuaMgr.UICamera());
            this.guide.transform.localPosition = UnityEngine.Vector3(pos.x, pos.y, 0);
        end

        local leftTarget = data.leftTarget
        if leftTarget then
            SetActive(this.guideMiddle, vis and this.isOnClick)
            if vis then
                local pos = RectTransformTool.ToContainer(leftTarget, this.middle, LuaMgr.UICamera());
                this.guideMiddle.transform.localPosition = UnityEngine.Vector3(pos.x, pos.y, 0);
            end
        end
    end
    
end

this.OnUpdate = function()
    if this.isOnClick or this.cutDownFinish then
        RhythmGameMgr.UpdateBtnCtrl()
        this.UpdateClick()
        return
    end

    if not this.cutDown then
        return
    end

    this.itemSize.x = this.itemSize.x - this.speed * UnityEngine.Time.deltaTime

    if this.itemSize.x <= 0 then
        this.itemSize.x = 0
    end
    this.leftImage.sizeDelta = this.itemSize
    this.rightImage.sizeDelta = this.itemSize
    if this.itemSize.x <= 0 then
        SetActive(this.rImage, true)
        this.cutDownFinish = true
    end
end

this.OnAniPlayFinish = function(args)
    if args[0] == "ani_RhythmGameHelpNotePanel_root01" then
        this.OnFirstShow()
        this.OnClickBtn()
    end
end

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.backBtn, this.OnClose)
        this.itemSize = this.rightImage.sizeDelta;
        this.oldSizeX = this.itemSize.x


    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        this.curEvent = vm.behaviour.Params[0]
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        LuaMgr.RemoveUpdate(this.OnUpdate)
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnAniPlayFinish);
        LuaMgr.RemoveClick(this.backBtn, this.OnClose)


        this.curEvent = nil
        LuaMgr.RemoveUpdate(this.OnUpdate)
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})