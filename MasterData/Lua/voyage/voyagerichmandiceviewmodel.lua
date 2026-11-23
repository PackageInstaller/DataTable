local this = {
diceType = 0,
selectNum = 0,
    squareAniName = "ani_VoyageRichManDicePanel_root_Square";
    triangleAniName = "ani_VoyageRichManDicePanel_root_Triangle";
    selectDiceAniName = "ani_VoyageRichManDicePanel_root_SelectDice";
    selectDiceDotAniName = "ani_VoyageRichManDicePanel_root_SelectDice_dot";
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    maskBtn = { path = "root/Mask", type = "Button" },
    squareGO = { path = "root/Middle/Square", type = "GameObject" },
    squareNum = { path = "root/Middle/Square/Glow/Num", type = "Image" },
    triangleGO = { path = "root/Middle/Triangle", type = "GameObject" },
    triangleNum = { path = "root/Middle/Triangle/Glow/Num", type = "Image" },
    selectDiceGO = { path = "root/Middle/SelectDice", type = "GameObject" },
    selectDice1SelectGO = { path = "root/Middle/SelectDice/Dice1/Select", type = "GameObject" },
    selectDice1NumBtn = { path = "root/Middle/SelectDice/Dice1/Num", type = "Button" },
    selectDice2SelectGO = { path = "root/Middle/SelectDice/Dice2/Select", type = "GameObject" },
    selectDice2NumBtn = { path = "root/Middle/SelectDice/Dice2/Num", type = "Button" },
    selectDice3SelectGO = { path = "root/Middle/SelectDice/Dice3/Select", type = "GameObject" },
    selectDice3NumBtn = { path = "root/Middle/SelectDice/Dice3/Num", type = "Button" },
};


this.SetData = function(vm)
    if (vm.behaviour.Params == nil) then return end

    VoyageRichManSceneMgr.SetDrag(false);
    LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
    LuaMgr.AddUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
    SetActive(this.squareGO, false);
    SetActive(this.triangleGO, false);
    SetActive(this.selectDiceGO, false);
    this.diceType = vm.behaviour.Params[0];
    if (this.diceType == VoyageRichManDiceType.Square) then
        local num = vm.behaviour.Params[1];
        this.squareNum.sprite = LuaMgr.GetSprite("VoyageRichMan", "ui_hd_hh_hx_dice1_" .. num);
        SetActive(this.squareGO, true);
        this.animator.Loop = false;
        this.animator.AnimationName = this.squareAniName;
    elseif (this.diceType == VoyageRichManDiceType.Triangle) then
        local num = vm.behaviour.Params[1];
        this.triangleNum.sprite = LuaMgr.GetSprite("VoyageRichMan", "ui_hd_hh_hx_dice2_" .. num);
        SetActive(this.triangleGO, true);
        this.animator.Loop = false;
        this.animator.AnimationName = this.triangleAniName;
    elseif (this.diceType == VoyageRichManDiceType.SelectDice) then
        SetActive(this.selectDice1SelectGO, false);
        SetActive(this.selectDice2SelectGO, false);
        SetActive(this.selectDice3SelectGO, false);
        SetActive(this.selectDiceGO, true);
        this.animator.Loop = false;
        this.animator.AnimationName = this.selectDiceAniName;
        if (VoyageRichManMgr.IsAutoDice()) then
            LuaMgr.AddTimer(TimerConst.VoyageRichManAutoSelectDiceTime, this.OnAutoSelectDiceTime, 1, -1, false);
        end
    end
end


this.OnAutoSelectDiceTime = function()
    LuaMgr.RemoveTimer(TimerConst.VoyageRichManAutoSelectDiceTime);
    local num = math.random(1, 3);
    this.SetSelectDiceNum(num);
end


this.OnClickMask = function()
    if (VoyageRichManMgr.IsAutoDice()) then return end
    
    if (this.diceType == VoyageRichManDiceType.SelectDice and this.selectNum == 0) then
        LuaMgr.HidePanel(UIName.VoyageRichManDiceViewModel);
    end
end


this.OnSelectDiceNum = function()
    LuaMgr.RemoveTimer(TimerConst.VoyageRichManDiceTime);
    local selectDiceId = PlayerVoyageMgr.GetSpecialDiceId();
    PlayerVoyageMgr.RollDice(selectDiceId, this.selectNum);
    LuaMgr.HidePanel(UIName.VoyageRichManDiceViewModel);
end


this.SetSelectDiceNum = function(num)
    if (this.selectNum == 0) then
        if (num == 1) then
            SetActive(this.selectDice1SelectGO, true);
        elseif (num == 2) then
            SetActive(this.selectDice2SelectGO, true);
        elseif (num == 3) then
            SetActive(this.selectDice3SelectGO, true);
        end
        this.selectNum = num;
        LuaMgr.AddTimer(TimerConst.VoyageRichManDiceTime, this.OnSelectDiceNum, 1, 1, false);
    end
end


this.OnClickSelectDice1Num = function()
    if (VoyageRichManMgr.IsAutoDice()) then return end
    
    this.SetSelectDiceNum(1);
end


this.OnClickSelectDice2Num = function()
    if (VoyageRichManMgr.IsAutoDice()) then return end
    
    this.SetSelectDiceNum(2);
end


this.OnClickSelectDice3Num = function()
    if (VoyageRichManMgr.IsAutoDice()) then return end
    
    this.SetSelectDiceNum(3);
end


this.OnPlayFinish = function(args)
    if (args.Length > 0) then
        local aniName = args[0];
        if (aniName == this.squareAniName or aniName == this.triangleAniName) then
            VoyageRichManMgr.RollDice();
            LuaMgr.HidePanel(UIName.VoyageRichManDiceViewModel);
        elseif (aniName == this.selectDiceAniName) then
            this.animator.Loop = true;
            this.animator.AnimationName = this.selectDiceDotAniName;
        end
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.maskBtn, this.OnClickMask);
        LuaMgr.AddClick(this.selectDice1NumBtn, this.OnClickSelectDice1Num);
        LuaMgr.AddClick(this.selectDice2NumBtn, this.OnClickSelectDice2Num);
        LuaMgr.AddClick(this.selectDice3NumBtn, this.OnClickSelectDice3Num);
    end,
    before_active = this.SetData,
    before_deactive = function(vm)
        LuaMgr.RemoveTimer(TimerConst.VoyageRichManDiceTime);
        LuaMgr.RemoveTimer(TimerConst.VoyageRichManAutoSelectDiceTime);
        LuaMgr.RemoveUIEventListener(UIEventConst.AnimatorPlayFinish, this.OnPlayFinish);
        this.selectNum = 0;
        VoyageRichManSceneMgr.SetDrag(true);
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.maskBtn, this.OnClickMask);
        LuaMgr.RemoveClick(this.selectDice1NumBtn, this.OnClickSelectDice1Num);
        LuaMgr.RemoveClick(this.selectDice2NumBtn, this.OnClickSelectDice2Num);
        LuaMgr.RemoveClick(this.selectDice3NumBtn, this.OnClickSelectDice3Num);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})