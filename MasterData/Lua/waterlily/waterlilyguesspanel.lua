local this = {
    rewardList = {},
    curData = nil,
    curConfig = nil,
    curSelected = 0,
    guessBoxList = {},
    isFinish = false,
};

local objs = {
    animator = { path = "root", type = "Animator" },
    characterObj = { path = "root/Middle/Character", type = "GameObject" },
    characterDrawing = { path = "root/Middle/Character/Body", type = "DrawingAdjustTool" },
    spineCharacter = { path = "root/Middle/Character/Body", type = "UISpineCharacter" },
    ImgMaskBg = { path = "root/Middle/ImgMaskBg", type = "GameObject" },
    ImgMaskIcon = { path = "root/Middle/ImgMaskBg/ImgMaskIcon", type = "Image" },
    TextNum = { path = "root/Middle/TextNum", type = "Text" },
    RewardPanel = { path = "root/Middle/RewardPanel", type = "GameObject" },
    TextName = { path = "root/Middle/RewardPanel/TextName", type = "Text" },
    ScrollViewReward = { path = "root/Middle/RewardPanel/ScrollViewReward", type = "GameObject" },
    Content = { path = "root/Middle/RewardPanel/ScrollViewReward/Viewport/Content", type = "RectTransform" },
    BtnComfirm = { path = "root/Middle/RewardPanel/BtnComfirm", type = "Button" },
    GuessPanel = { path = "root/Middle/GuessPanel", type = "GameObject" },
    GuessBtnBox = { path = "root/Middle/GuessPanel/GuessBtnBox", type = "Transform" },
    BtnGuessComfirm = { path = "root/Middle/GuessPanel/BtnGuessComfirm", type = "Button" },
    ImgComfirm = { path = "root/Middle/GuessPanel/BtnGuessComfirm/ImgComfirm", type = "GameObject" },
    ImgAnwser = { path = "root/Middle/GuessPanel/BtnGuessComfirm/ImgAnwser", type = "GameObject" },
    LosePanel = { path = "root/Middle/LosePanel", type = "GameObject" },
    BtnGuessAgain = { path = "root/Middle/LosePanel/BtnGuessAgain", type = "Button" },
    successEffect = {path = "root/Middle/Eff_boom", type = "GameObject"}
};




this.SetData = function(_data)
    if (_data == nil) then return; end
    this.curData = _data;
    this.curConfig = ConfigMgr.Config.ColorQuestionMap[_data.eventParam];
    local characterId = this.curConfig and this.curConfig.CharacterId or "W0168"
    local path = HeroManager.SetCharacterDrawing(this.spineCharacter, characterId, characterId .. "001")
    if (path ~= "" and this.characterDrawing ~= nil) then
        this.characterDrawing.Sprite = path
    end
    this.ImgMaskIcon.sprite = LuaMgr.GetSprite("Waterlily", this.curConfig.Title);
    this.isFinish = PlayerWaterlilyMgr.CheckFinish(_data)
    SetActive(this.ScrollViewReward, not this.isFinish)
    SetActive(this.ImgComfirm, not this.isFinish)
    SetActive(this.ImgAnwser, this.isFinish)
    if (this.isFinish) then
        this.OnClickGuessBtn(tonumber(this.curConfig.RightAnswer))
    end
    this.SwitchPanel(1)
end



this.SwitchPanel = function(_type)
    SetActive(this.ImgMaskBg.gameObject, _type == 1 or _type == 3)
    SetActive(this.GuessPanel.gameObject, _type == 1)
    SetActive(this.characterObj.gameObject, _type == 2)
    SetActive(this.RewardPanel.gameObject, _type == 2)
    SetActive(this.LosePanel.gameObject, _type == 3)
    if (_type == 1) then
        this.SetGuessBtnBox()
    elseif (_type == 2) then
        this.SetReward();
    else
        this.SetLosePanel();
    end
    local num = DataMgr.Player.AnswerQuestion.AnswerCount[this.curData.eventParam]
    if (num == nil) then
        num = 0
    end
    this.TextNum.text = LuaMgr.GetLangText("WaterlilyGuessPanel_0") .. num
end


this.InitGuessBtnBox = function()
    this.guessBoxList = {}
    for i = 0, this.GuessBtnBox.childCount - 1 do
        local cache = {}
        cache.obj = this.GuessBtnBox:GetChild(i)
        cache.btn = cache.obj:GetComponent("Button");
        cache.btn.onClick:RemoveAllListeners();
        cache.btn.onClick:AddListener(function()
            this.OnClickGuessBtn(i + 1)
        end)
        cache.btnName = cache.obj:Find("BtnName"):GetComponent("Text");
        cache.imgSelected = cache.obj:Find("ImgSelected").gameObject;
        SetActive(cache.imgSelected, false);
        table.insert(this.guessBoxList, cache);
    end
end



this.OnClickGuessBtn = function(_index)
    if (this.curSelected == _index) then
        return;
    end
    this.curSelected = _index;
    for i = 1, #this.guessBoxList do
        this.guessBoxList[i].imgSelected:SetActive(i == this.curSelected);
    end
end


this.SetGuessBtnBox = function()
    if not this.curConfig then return end
    this.curSelected = 0
    for i, v in ipairs(this.guessBoxList) do
        SetActive(v.imgSelected, false);
        local answerKey = "Answer" .. i .. "Lan"
        if this.curConfig[answerKey] then
            v.btnName.text = LuaMgr.GetLangText(this.curConfig[answerKey])
        else
            v.btnName.text = ""
        end
    end
end


this.SetReward = function()
    local index = 1;
    local item;
    local itemData;
    local scale = Vector3(0.8, 0.8, 0.8);
    for k, v in pairs(this.curConfig.Reward) do
        item = this.rewardList[index];
        if (item == nil) then
            item = GoodsDataItem.New(this.Content);
            this.rewardList[index] = item;
        end
        itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemData.count0 = v.count;
        item:SetData(index, itemData, 1, false, scale, false, false);
        index = index + 1;
    end
    local len = #this.rewardList;
    for i = index, len do
        this.rewardList[i]:Hide();
    end
    local heroConfig = ConfigCharacterMgr.GetCharacter(this.curConfig.CharacterId)
    this.TextName.text = LuaMgr.GetLangText(heroConfig.namelan)
end



this.ClearReward = function()
    if (this.rewardList ~= nil) then
        for k, v in pairs(this.rewardList) do
            v:Clear();
        end
        this.rewardList = {};
    end    
end


this.SetLosePanel = function()

end


this.AnswerCallback = function(params)
    if params.Length > 0 and type(params[0]) =="table" then
        this.rewardItems = params[0]
    else
        this.rewardItems = nil
    end
    local finish = PlayerWaterlilyMgr.CheckFinish(this.curData)
    if (finish) then
        this.PlaySuccessAnim()        
    else
        this.SwitchPanel(3)
        this.animator:Play(WaterlilyConst.GuessAnimName.Faild)
    end
end

this.PlaySuccessAnim = function()
    if this.tweenSquence ~= nil then
            this.tweenSquence:Kill()
            this.tweenSquence = nil
    end
    if this.tweenSquence1 ~= nil then
        this.tweenSquence1:Kill()
        this.tweenSquence1 = nil
    end
    local callBack = function()
        this.tweenSquence = nil    
        SetActive(this.successEffect, false)
    end
    this.tweenSquence = DOTWeen:Sequence()
    this.tweenSquence:AppendInterval(1):OnComplete(callBack)

    local callBack1 = function()
        this.SwitchPanel(2)
        this.animator:Play(WaterlilyConst.GuessAnimName.Success)
        this.tweenSquence1 = nil
    end
    this.tweenSquence1 = DOTWeen:Sequence()
    this.tweenSquence1:AppendInterval(0.8):OnComplete(callBack1)
    SetActive(this.successEffect, true)
    local path = string.format("%sUI/newUI/%s.mp3", Path.audio_PATH, "travel_Camera")
    AudioMgr.Singleton:PlayUISFX(path)
end



this.OnBack = function()
    LuaMgr.Back()
    if this.rewardItems ~= nil then
        local callback = function()
            local reward = this.rewardItems
            if reward == nil then
                return
            end
            for key, value in pairs(this.rewardItems) do
                table.insert(reward, {ID = value.id, Count = value.count})
            end
            if #reward > 0 then
                LuaMgr.ShowItemGetPanel(reward)
            end
            this.rewardItems = nil
        end
        LuaMgr.NextFrame(callback)
    end
end



this.OnClickComfirm = function()
    this.OnBack();
end



this.OnClickGuessComfirm = function()
    if(this.isFinish)then
        this.SwitchPanel(2)
        return
    end
    if type(this.curSelected) ~= "number" or this.curSelected <= 0 then
        local tipsContent = LuaMgr.GetLangText("LangGlobalLan_LangGlobal_name_2421")
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, tipsContent)
        return
    end
    if this.CheckActivityRunning() then
        PlayerWaterlilyMgr.Answer(this.curData.id, this.curSelected)
    end
end



this.OnClickGuessAgain = function()
    if this.CheckActivityRunning() then
        this.SwitchPanel(1)
    end
end



this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(ActivityKey.Waterlily) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end

local data = {}

local command = {}

local hook = {

    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.BtnComfirm, this.OnClickComfirm);
        LuaMgr.AddClick(this.BtnGuessComfirm, this.OnClickGuessComfirm);
        LuaMgr.AddClick(this.BtnGuessAgain, this.OnClickGuessAgain);
        LuaMgr.AddUIEventListener(UIEventConst.ZGCXMsgShow, this.AnswerCallback);
        RedMgr.Singleton:RegisterViewModel(UIName.WaterlilyGuessPanel);
        this.InitGuessBtnBox()
    end,

    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnBack);
        local data = vm.behaviour.Params[0];
        this.SetData(data);
    end,

    before_deactive = function(vm)
        if this.tweenSquence ~= nil then
            this.tweenSquence:Kill()
            this.tweenSquence = nil
        end

        if this.tweenSquence1 ~= nil then
            this.tweenSquence1:Kill()
            this.tweenSquence1 = nil
        end
        SetActive(this.successEffect, false)
    end,

    before_destroy = function()
        LuaMgr.RemoveClick(this.BtnComfirm, this.OnClickComfirm);
        LuaMgr.RemoveClick(this.BtnGuessComfirm, this.OnClickGuessComfirm);
        LuaMgr.RemoveClick(this.BtnGuessAgain, this.OnClickGuessAgain);
        LuaMgr.RemoveUIEventListener(UIEventConst.ZGCXMsgShow, this.AnswerCallback);
        RedMgr.Singleton:RemoveViewModel(UIName.WaterlilyGuessPanel);
        this.guessBoxList = nil
        this.ClearReward()
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})