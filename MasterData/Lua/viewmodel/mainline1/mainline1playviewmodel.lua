local this =
{
    rewardList       = {},
    gravity          = -9.8,
    jumpForce        = 10,
    vVelocity        = 0,
    maxVVelocity     = 7,
    minVVelocity     = 2,
    minScaleDeltaY   = 200,
    hVelocity        = 5,
    hInterval        = 1,
    cacheVelocity    = 0,
    lastScannedIndex = 0,
    activityKey      = nil,
    UnityDeltaTime   = UnityEngine.Time.deltaTime,
    targetSizeDelta  = nil,
    isPress          = false,
    canPress         = false,
    screenWidth      = UnityEngine.Screen.width,
    halfScreenWidth  = UnityEngine.Screen.width / 2,
    objectPool       = {},
    activeBlocks     = {},
    blockData        = {},
    lastDataIndex    = 0,
    lastXPos         = 0,
    softTargetPos    = nil,
    isStop           = false,
    maxLength        = 0,
    jumpGameConfig   = ConfigMgr.Config.JumpGameConstants,
    canGetReward     = false,
    finishReward     = false,
    npcPos           = 0,
    curAnimation     = nil,
    curVoice         = nil,
    curBlood         = nil,
};

local objs = {
    rewardItemObj = { path = "template/RewardItem", type = "GameObject" },
    imgObstacle = { path = "root/Middle/ObstacleBox/ImgObstacle", type = "RectTransform" },
    stopBtn = { path = "root/Left/StopBtn", type = "Button" },
    textBlood = { path = "root/Left/Image/TextBlood", type = "Text" },
    textMax = { path = "root/Right/Image/TextMax", type = "Text" },
    textCur = { path = "root/Right/Image2/TextCur", type = "Text" },
    sliderCount = { path = "root/Middle/SliderCount", type = "Slider" },
    imgSpeed = { path = "root/Middle/SliderCount/HandleSlideArea/Handle/imgSpeed", type = "GameObject" },
    contentRewardRec = { path = "root/Middle/SliderCount/ImgRewardBg/ScrollView/Viewport/ContentReward", type = "RectTransform" },
    textMaxLength = { path = "root/Middle/SliderCount/ImgRewardBg/TextMaxLength", type = "Text" },
    continuBtn = { path = "root/Middle/RewardResultBg/Bg/Bg/ContinuBtn", type = "Button" },
    getBtn = { path = "root/Middle/RewardResultBg/Bg/Bg/GetBtn", type = "Button" },
    backBtn = { path = "root/Middle/RewardResultBg/Bg/Bg/BackBtn", type = "Button" },

    RewardResultBg = { path = "root/Middle/RewardResultBg", type = "GameObject" },
    closeBtn = { path = "root/Middle/RewardResultBg/Bg/CloseBtn", type = "Button" },
    textRewardCur = { path = "root/Middle/RewardResultBg/Bg/TextRewardCur", type = "Text" },
    textRewardMax = { path = "root/Middle/RewardResultBg/Bg/TextRewardMax", type = "Text" },
    contentRec = { path = "root/Middle/RewardResultBg/Bg/ScrollViewReward/Viewport/Content", type = "RectTransform" },

    bg1H = { path = "root/BgBox/Bg1H", type = "RectTransform" },
    bg2H = { path = "root/BgBox/Bg2H", type = "RectTransform" },
    bg1HM = { path = "root/BgBox/Bg1HM", type = "RectTransform" },
    bg2HM = { path = "root/BgBox/Bg2HM", type = "RectTransform" },
    bg1M = { path = "root/BgBox/Bg1M", type = "RectTransform" },
    bg2M = { path = "root/BgBox/Bg2M", type = "RectTransform" },
    bg1L = { path = "root/BgBox/Bg1L", type = "RectTransform" },
    bg2L = { path = "root/BgBox/Bg2L", type = "RectTransform" },
    bg1R = { path = "root/BgBox/Bg1R", type = "RectTransform" },
    bg2R = { path = "root/BgBox/Bg2R", type = "RectTransform" },


    imgNpc = { path = "root/Middle/ImgNpc", type = "RectTransform" },
    characterNpc = { path = "root/Middle/ImgNpc", type = "UISpineCharacter" },
    textTalk = { path = "root/Middle/ImgNpc/Image/ScrollView/Viewport/Content/TextTalk", type = "Text" },
    truthPosObj = { path = "root/Middle/truthPos", type = "RectTransform" },
    obstacleBox = { path = "root/Middle/ObstacleBox", type = "Transform" },
    imgTarget = { path = "root/Middle/ImgTarget", type = "RectTransform" },
    character = { path = "root/Middle/ImgTarget/Character", type = "UISpineCharacter" },
    characterRec = { path = "root/Middle/ImgTarget/Character", type = "RectTransform" },
    imagePressBtn = { path = "root/ImagePressBtn", type = "ClickPressButton" },
};


this.SetData = function()
    local curType = ConfigMainLineMgr.CheckCanSwitch() and 1 or 2;
    if (curType == 1) then
        this.activityKey = ActivityKey.MainLine1
    else
        this.activityKey = ActivityKey.MainLine2
    end
    this.activeBlocks                 = {}
    this.blockData                    = {}
    this.lastDataIndex                = 0
    this.lastXPos                     = 0
    this.truthPosObj.anchoredPosition = Vector2.zero
    this.imgNpc.anchoredPosition      = Vector2.zero
    this.targetSizeDelta              = this.characterRec.sizeDelta;
    this.imgTarget.anchoredPosition   = this.softTargetPos
    this.cacheVelocity                = 0;
    this.vVelocity                    = 0;
    this.textMax.text                 = DataMgr.Player.JumpGame.max;
    this.maxLength                    = 0
    this.npcPos                       = 0
    this.textCur.text                 = 0
    this.sliderCount.value            = 0
    this.lastScannedIndex             = 1
    this.isStop                       = false
    this.maxVVelocity                 = this.jumpGameConfig.Speed[1]
    this.hVelocity                    = this.jumpGameConfig.Speed[2]
    this.hInterval                    = this.jumpGameConfig.Speed[3]
    this.minVVelocity                 = this.jumpGameConfig.Speed[4]
    this.curBlood                     = this.jumpGameConfig.Speed[5]
    this.finishReward                 = false
    this.curVoice                     = nil
    this.curAnimation                 = nil
    this.CheckGetReward()
    this.textTalk.text = this.GetNpcText(1)
    this.SetSmallReward()
    this.textBlood.text = this.curBlood
    this.character:SetBattle("ED90301", "ED90301", "-1", 0, this.OnCharacter);
    this.characterNpc:SetBattle("ED90401", "ED90401", "-1", 0, this.OnCharacterNpc)
end

this.PlayCharacterAnimation = function(animName, loop, onComplete)
    if this.curAnimation ~= animName then
        this.character:Play(animName, loop, onComplete)
        this.curAnimation = animName
    end
end

this.PlayVoice = function(_curVoice, _except)
    if this.curVoice ~= _curVoice then
        if (_except ~= true) then
            AudioMgr.Singleton:StopVoice(false);
        end
        AudioMgr.Singleton:PlayVoice(Path.audio_PATH .. _curVoice);
        this.curVoice = _curVoice
    end
end

this.OnCharacter = function()
    this.PlayCharacterAnimation("idle", true, nil);
end

this.OnCharacterNpc = function()
    this.characterNpc:Play("idle", true, nil);
end


this.OnClickStop = function()
    this.isStop = true
    this.textRewardCur.text = -math.floor(this.maxLength / 100)
    this.textRewardMax.text = DataMgr.Player.JumpGame.max;
    this.SetReward()
    local finishLength = this.finishReward and this.canGetReward
    SetActive(this.getBtn.gameObject, finishLength)
    SetActive(this.backBtn.gameObject, not finishLength)
    SetActive(this.continuBtn.gameObject, this.curBlood > 0)
    SetActive(this.RewardResultBg, true)
end

this.OnClickContinue = function()
    this.isStop = false
    SetActive(this.RewardResultBg, false)
end

this.OnClickBack = function()
    if (this.GetShowPos() >= this.jumpGameConfig.DailyRewardRequirement) then
        ApiMgr.Request("jumpGame/getRewards", { Score = this.GetShowPos() }, true, function()
            SetActive(this.RewardResultBg, false)
            LuaMgr.Back()
        end, nil, true, true);
    else
        SetActive(this.RewardResultBg, false)
        LuaMgr.Back()
    end
end

this.OnClickGet = function()
    if (this.GetShowPos() >= this.jumpGameConfig.DailyRewardRequirement) then
        ApiMgr.Request("jumpGame/getRewards", { Score = this.GetShowPos() }, true, function(result)
            local re = json.decode(result);
            local data = json.encode(re.result.Rewards);
            LuaMgr.ShowItemRewared(data);
            SetActive(this.RewardResultBg, false)
            LuaMgr.Back()
        end, nil, true, true);
    else
        SetActive(this.RewardResultBg, false)
        LuaMgr.Back()
    end
end

this.OnClickClose = function()
    if (this.curBlood > 0) then
        this.isStop = false
        SetActive(this.RewardResultBg, false)
    else
        if (this.canGetReward) then
            this.OnClickGet()
        else
            this.OnClickBack()
        end
    end
end

this.CheckGetReward = function()
    local nextTime = DataMgr.Player.JumpGame.today
    local curTime = LuaMgr.Timestamp()
    local interval = curTime - nextTime
    local day = math.floor(interval // 86400);
    local nextDate = os.date("*t", nextTime);
    local curDate = os.date("*t", curTime);
    LuaDebug.error(string.format("nextDate.month = %s   nextDate.day = %s  nextDate.hour = %s", nextDate.month,
        nextDate.day, nextDate.hour))
    LuaDebug.error(string.format("curDate.month = %s   curDate.day = %s   curDate.hour = %s", curDate.month, curDate.day,
        curDate.hour))
    this.canGetReward = false
    if (day >= 1) then
        this.canGetReward = true;
    else
        if (nextDate.hour < 4 and curDate.hour >= 4) then
            this.canGetReward = true;
        else
            this.canGetReward = false;
        end
    end
end

this.CheckGetReward = function()
    local nextTime = DataMgr.Player.JumpGame.today
    local curTime = LuaMgr.Timestamp()
    local interval = curTime - nextTime
    local day = math.floor(interval // 86400);
    this.canGetReward = false
    if (day >= 1) then
        this.canGetReward = true;
    else
        local nextDate = os.date("*t", nextTime);
        local curDate = os.date("*t", curTime);




        local nextDayTimeStamp = os.time({ year = nextDate.year, month = nextDate.month, day = nextDate.day, hour = 0, min = 0, sec = 00 });
        local curDayTimeStamp = os.time({ year = curDate.year, month = curDate.month, day = curDate.day, hour = 0, min = 0, sec = 00 });
        if (curDayTimeStamp == nextDayTimeStamp) then
            if (nextDate.hour < 4 and curDate.hour >= 4) then
                this.canGetReward = true;
            else
                this.canGetReward = false;
            end
        else
            if (curDate.hour < 4) then
                this.canGetReward = false;
            else
                this.canGetReward = true;
            end
        end
    end
end

this.SetSmallReward = function()
    this.textMaxLength.text = this.jumpGameConfig.DailyRewardRequirement ..
        LuaMgr.GetLangText("MainLine1PlayViewModel_0");
    if (this.rewardItems ~= nil) then
        for k, v in pairs(this.rewardItems) do
            v.rewardObj:Hide();
            SetActive(v.go, false)
        end
    end
    for i, v in pairs(this.jumpGameConfig.DailyReward) do
        if (this.rewardItems == nil) then
            this.rewardItems = {}
        end
        if (this.rewardItems[i] == nil) then
            local go = GameObject.Instantiate(this.rewardItemObj)
            local cache = {}
            cache.go = go
            cache.box = go.transform:Find("reward"):GetComponent("Transform");
            cache.get = go.transform:Find("get").gameObject;
            cache.rewardObj = GoodsDataItem.New(cache.box);
            this.rewardItems[i] = cache
        end
        local obj = this.rewardItems[i]
        obj.go.transform:SetParent(this.contentRewardRec, false);
        local itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
        itemData.count0 = v.count;
        obj.rewardObj:SetData(1, itemData, 1, false, Vector3(0.4, 0.4, 0.4), false, true);
        SetActive(obj.get, not this.canGetReward)
        SetActive(obj.go, true)
    end
end


this.SetReward = function()
    local index = 1;
    local item;
    local itemData;
    local scale = Vector3(0.8, 0.8, 0.8);
    if (this.canGetReward and this.finishReward) then
        for k, v in pairs(this.jumpGameConfig.DailyReward) do
            item = this.rewardList[index];
            if (item == nil) then
                item = GoodsDataItem.New(this.contentRec);
                this.rewardList[index] = item;
            end
            itemData = table.Copy(ConfigMgr.Config.itemMap[v.id]);
            itemData.count0 = v.count;
            item:SetData(index, itemData, 1, false, scale, false, false);
            index = index + 1;
        end
    end
    local len = #this.rewardList;
    for i = index, len do
        this.rewardList[i]:Hide();
    end
end


this.ClearReward = function()
    if (this.rewardList ~= nil) then
        for k, v in pairs(this.rewardList) do
            v:Clear();
        end
        this.rewardList = {};
    end

    if (this.rewardItems ~= nil) then
        for k, v in pairs(this.rewardItems) do
            v.rewardObj:Clear();
            if (v.go ~= nil) then
                LuaMgr.DestroyGO(v.go)
            end
        end
        this.rewardItems = {};
    end
end

local data = {}

local command = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        this.softTargetPos = this.imgTarget.anchoredPosition
        LuaMgr.AddClick(this.stopBtn, this.OnClickStop);
        LuaMgr.AddClick(this.continuBtn, this.OnClickContinue);
        LuaMgr.AddClick(this.backBtn, this.OnClickBack);
        LuaMgr.AddClick(this.getBtn, this.OnClickGet);
        LuaMgr.AddClick(this.closeBtn, this.OnClickClose);


        this.imagePressBtn.OnClick:AddListener(function()
            if (not this.canPress) then
                return
            end
            this.vVelocity = 0
            this.isPress = false
            this.PlayCharacterAnimation("move", true, function()
                this.PlayCharacterAnimation("idle", true, nil);
            end);
            this.UpdataPos(10)
            this.UpdateSlider()
        end)
        this.imagePressBtn.OnPress:AddListener(function()
            if (not this.canPress) then
                return
            end
            this.PlayVoice("BattleSFX/V0006_ExSkill_New_5.mp3")
            this.isPress = true
            if (this.cacheVelocity ~= 0) then
                this.cacheVelocity = 0
            end
        end)
        this.imagePressBtn.OnLiftUp:AddListener(function()
            if (not this.canPress) then
                return
            end
            this.isPress = false
            this.vVelocity = this.cacheVelocity
            if (this.hVelocity < 0) then
                this.hVelocity = this.hVelocity * -1
            end
            if (this.targetSizeDelta ~= nil) then
                this.characterRec.sizeDelta = this.targetSizeDelta
            end
        end)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        RedMgr.Singleton:Refresh()
        vm.behaviour:UpdateTopBar("", this.OnClickStop);
        LuaMgr.AddUpdate(this.Update)
        this.SetData();
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUpdate(this.Update)
        for k, v in pairs(this.activeBlocks) do
            v.gameObject:SetActive(false)
            table.insert(this.objectPool, v)
        end
        this.activeBlocks = {}
        if this.character then
            this.character:Clear();
        end
        if (this.characterNpc) then
            this.characterNpc:Clear();
        end
    end,
    before_destroy = function()
        LuaMgr.RemoveClick(this.stopBtn, this.OnClickStop);
        LuaMgr.RemoveClick(this.continuBtn, this.OnClickContinue);
        LuaMgr.RemoveClick(this.backBtn, this.OnClickBack);
        LuaMgr.RemoveClick(this.getBtn, this.OnClickGet);
        LuaMgr.RemoveClick(this.closeBtn, this.OnClickClose);
        this.imagePressBtn.OnClick:RemoveAllListeners()
        this.imagePressBtn.OnPress:RemoveAllListeners()
        this.imagePressBtn.OnLiftUp:RemoveAllListeners()
        for k, v in pairs(this.objectPool) do
            LuaMgr.DestroyGO(v.gameObject)
        end
        this.objectPool = {}
        this.ClearReward()
    end
}

this.GetShowPos = function()
    return -math.floor(this.truthPosObj.anchoredPosition.x / 100)
end

this.Update = function()
    if (this.isStop) then
        return
    end
    local targetPos = this.imgTarget.anchoredPosition
    if (this.isPress) then
        local interval = this.jumpForce * this.UnityDeltaTime
        this.cacheVelocity = this.cacheVelocity + interval
        this.maxVVelocity = this.jumpGameConfig.Speed[1]
        if (this.maxVVelocity < this.cacheVelocity) then
            this.cacheVelocity = this.maxVVelocity
        else
            if (this.targetSizeDelta ~= nil and this.characterRec.sizeDelta.y >= this.minScaleDeltaY) then
                this.characterRec.sizeDelta = Vector2(this.targetSizeDelta.x,
                    this.characterRec.sizeDelta.y - interval * 5)
            end
        end
        return
    end
    if (targetPos.y == this.softTargetPos.y and this.vVelocity == 0 and not this.canPress) then
        this.PlayVoice("JumpGame/jump_03.mp3")
        this.PlayCharacterAnimation("jump03", true, function()
            this.PlayCharacterAnimation("idle", true, nil);
        end);
        this.canPress = true
        this.cacheVelocity = 0
        return
    end
    local length = 0
    if (targetPos.y > this.softTargetPos.y or this.vVelocity > 0) then
        this.canPress = false
        local dt = this.UnityDeltaTime
        local avgVelocity = this.vVelocity + (this.gravity * dt) / 2
        local high = avgVelocity * dt * 100
        if (high > 0) then
            this.PlayCharacterAnimation("jump01", true, nil)
            this.PlayVoice("JumpGame/jump_02.mp3")
        else
            this.PlayCharacterAnimation("jump02", true, nil)
        end
        targetPos.y = targetPos.y + high
        this.imgTarget.anchoredPosition = targetPos
        this.vVelocity = this.vVelocity + this.gravity * dt

        length = this.hVelocity * this.UnityDeltaTime * 100
    else
        SetActive(this.imgSpeed, false)
        targetPos.y = this.softTargetPos.y
        this.imgTarget.anchoredPosition = targetPos
        this.vVelocity = 0
        local check = false
        for dataIndex, block in pairs(this.activeBlocks) do
            check = this.CheckCollision(this.imgTarget, block)
            if (check) then
                this.PlayCharacterAnimation("back01", true, function()
                    this.PlayCharacterAnimation("back02", true, function()
                        this.PlayCharacterAnimation("idle", true, nil)
                    end)
                end);
                break
            end
        end
        if (check) then
            if (this.minVVelocity < this.maxVVelocity) then
                this.maxVVelocity = this.maxVVelocity - this.hInterval
            else
                this.maxVVelocity = this.minVVelocity
            end
            this.vVelocity = this.maxVVelocity
            if (this.hVelocity > 0) then
                this.hVelocity = this.hVelocity * -1
            end
            this.curBlood = this.curBlood - 1
            this.textBlood.text = this.curBlood
            if (this.curBlood <= 0) then
                this.isStop = true
                this.OnClickStop()
            end
            this.PlayVoice("JumpGame/jump_04.mp3", true)
        end
    end
    if (length ~= 0) then
        this.UpdataPos(length)
        this.UpdateSlider()
    end
    this.UpdateVisibleBlocks()
end

this.UpdataPos = function(_length)
    local truthPos = this.truthPosObj.anchoredPosition
    truthPos.x = truthPos.x - _length
    this.truthPosObj.anchoredPosition = truthPos
    if (this.maxLength > truthPos.x) then
        this.maxLength = truthPos.x
    end
    this.UpdataSingleBgPos(this.bg1H, _length * 0.7)
    this.UpdataSingleBgPos(this.bg2H, _length * 0.7)
    this.UpdataSingleBgPos(this.bg1HM, _length * 0.8)
    this.UpdataSingleBgPos(this.bg2HM, _length * 0.8)
    this.UpdataSingleBgPos(this.bg1M, _length * 0.85)
    this.UpdataSingleBgPos(this.bg2M, _length * 0.85)
    this.UpdataSingleBgPos(this.bg1L, _length * 0.95)
    this.UpdataSingleBgPos(this.bg2L, _length * 0.95)
    this.UpdataSingleBgPos(this.bg1R, _length)
    this.UpdataSingleBgPos(this.bg2R, _length)
    this.UpdataNpcPos(this.imgNpc, _length)
end

this.UpdataSingleBgPos = function(_bgRect, _length)
    local pos = _bgRect.anchoredPosition
    pos.x = pos.x - _length
    local interval = 0
    if (pos.x <= -_bgRect.sizeDelta.x) then
        interval = pos.x + _bgRect.sizeDelta.x
        pos.x = _bgRect.sizeDelta.x + interval
    elseif (pos.x >= _bgRect.sizeDelta.x) then
        interval = pos.x - _bgRect.sizeDelta.x
        pos.x = -_bgRect.sizeDelta.x + interval
    end
    _bgRect.anchoredPosition = pos
end

this.UpdataNpcPos = function(_bgRect, _length)
    local truthPos = this.GetShowPos()
    local pos = _bgRect.anchoredPosition
    pos.x = pos.x - _length
    if (truthPos >= this.npcPos + this.jumpGameConfig.Tips and this.npcPos >= 0) then
        this.npcPos = truthPos
        pos.x = this.screenWidth
        this.textTalk.text = this.GetNpcText(this.npcPos // this.jumpGameConfig.Tips)
    elseif (truthPos <= this.npcPos - this.jumpGameConfig.Tips) then
        this.npcPos = truthPos
        pos.x = -this.screenWidth
        this.textTalk.text = this.GetNpcText(this.npcPos // this.jumpGameConfig.Tips)
    end
    _bgRect.anchoredPosition = pos
end

this.GetNpcText = function(_numIndex)
    if (this.jumpGameConfig.TipsContent == nil) then
        return "TipsContent is nil"
    end
    local showNpc = _numIndex <= #this.jumpGameConfig.TipsContent
    SetActive(this.imgNpc.gameObject, showNpc)
    if (not showNpc) then
        return ""
    end
    for i, v in ipairs(this.jumpGameConfig.TipsContent) do
        if (i == _numIndex) then
            local rand = math.random(1, #v)
            return ConfigMgr.LangGlobal(v[rand])
        end
    end
end

this.UpdateSlider = function()
    local showPos = this.GetShowPos()
    this.textCur.text = showPos
    if (this.finishReward) then
        return
    end
    local ratio = showPos / this.jumpGameConfig.DailyRewardRequirement
    this.sliderCount.value = ratio
    SetActive(this.imgSpeed, true)
    if (ratio >= 1 and this.rewardItems ~= nil) then
        this.finishReward = true
        for k, v in pairs(this.rewardItems) do
            SetActive(v.get, true)
        end
    end
end

this.UpdateVisibleBlocks = function()
    local viewLeft = -this.truthPosObj.anchoredPosition.x - this.halfScreenWidth
    local viewRight = -this.truthPosObj.anchoredPosition.x + this.halfScreenWidth
    local buffer = this.halfScreenWidth

    while (this.lastXPos < viewRight + buffer) do
        this.GenerateNewBlockData()
    end

    for dataIndex, block in pairs(this.activeBlocks) do
        local blockData = this.blockData[dataIndex]
        if blockData then
            local screenX = blockData.xPos + this.truthPosObj.anchoredPosition.x
            block.anchoredPosition = Vector2(screenX, block.anchoredPosition.y)
        end
    end

    local blocksToRecycle = {}
    for dataIndex, block in pairs(this.activeBlocks) do
        local blockData = this.blockData[dataIndex]
        if blockData then
            local blockStart = blockData.xPos
            local blockEnd = blockData.xPos + blockData.widthLength
            if (blockEnd < viewLeft - buffer) or (blockStart > viewRight + buffer) then
                table.insert(blocksToRecycle, dataIndex)
            end
        end
    end
    for _, dataIndex in ipairs(blocksToRecycle) do
        this.RecycleBlock(dataIndex)
    end

    for i = this.lastScannedIndex, 1, -1 do
        local blockData = this.blockData[i]
        if not blockData then break end

        local blockStart = blockData.xPos
        local blockEnd = blockData.xPos + blockData.widthLength

        if blockEnd < viewLeft - buffer then
            break
        end

        if blockStart < viewRight + buffer and not this.activeBlocks[i] then
            this.SpawnBlock(i)
        end
    end


    for i = this.lastScannedIndex + 1, #this.blockData do
        local blockData = this.blockData[i]
        if not blockData then break end

        local blockStart = blockData.xPos
        local blockEnd = blockData.xPos + blockData.widthLength

        if blockStart > viewRight + buffer then
            break
        end

        if blockEnd > viewLeft - buffer and not this.activeBlocks[i] then
            this.SpawnBlock(i)
        end
    end

    local centerWorldPos = -this.truthPosObj.anchoredPosition.x
    this.lastScannedIndex = this.BinarySearchForClosestIndex(centerWorldPos)
end

this.BinarySearchForClosestIndex = function(targetPos)
    if not this.blockData or #this.blockData == 0 then
        return 1
    end

    local low = 1
    local high = #this.blockData
    local mid = 0
    local closestIndex = 1
    local minDiff = -1

    while low <= high do
        mid = low + math.floor((high - low) / 2)
        local blockData = this.blockData[mid]

        if not blockData then
            break
        end

        local currentDiff = math.abs(blockData.xPos - targetPos)
        if minDiff == -1 or currentDiff < minDiff then
            minDiff = currentDiff
            closestIndex = mid
        end

        if blockData.xPos < targetPos then
            low = mid + 1
        elseif blockData.xPos > targetPos then
            high = mid - 1
        else
            return mid
        end
    end

    return closestIndex
end

this.GenerateNewBlockData = function()
    local newIndex = this.lastDataIndex + 1
    local schId = this.GetSchedule()
    if (schId == nil) then
        this.isStop = true

        return nil
    end

    local newWidth = this.GetBlockWidth(schId)
    local interval = this.GetInterval(schId)
    local newXPos = this.lastXPos
    local newData = {
        index = newIndex,
        width = newWidth,
        widthLength = newWidth * 36,
        xPos = newXPos,
    }
    table.insert(this.blockData, newData)
    this.lastDataIndex = newIndex
    this.lastXPos = newXPos + interval + (newWidth * 36)
    return newData
end

this.GetSchedule = function()
    for i, v in ipairs(this.jumpGameConfig.Schedule) do
        local pos = this.GetShowPos()
        if (v[1] <= pos and pos <= v[2]) then
            return i
        end
    end
end

this.GetBlockWidth = function(_id)
    local cache = this.jumpGameConfig["ScheduleWeight0" .. _id]
    if (cache == nil) then

        return 0
    end
    local maxNum = 0
    for i, v in ipairs(cache) do
        maxNum = maxNum + v[2]
    end
    local randomNum = math.random(1, maxNum)
    local startNum = 0
    for i, v in ipairs(cache) do
        if (startNum < randomNum and randomNum <= startNum + v[2]) then
            return v[1]
        end
        startNum = startNum + v[2]
    end
    return 0
end

this.GetInterval = function(_id)
    local cache = this.jumpGameConfig["ScheduleDistance0" .. _id]
    if (cache == nil) then

        return 0
    end
    local interval = math.random(cache[1], cache[2])
    return interval * 100
end

this.SpawnBlock = function(dataIndex)
    if this.activeBlocks[dataIndex] then
        return
    end
    local data = this.blockData[dataIndex]
    if not data then return end
    local block = this.GetObject()
    for i = 0, block.transform.childCount - 1 do
        block.transform:GetChild(i).gameObject:SetActive(i < data.width)
    end
    block.gameObject:SetActive(true)
    block.name = "obstacle" .. dataIndex
    local screenX = data.xPos - this.truthPosObj.anchoredPosition.x
    block.anchoredPosition = Vector2(screenX, block.anchoredPosition.y)
    this.activeBlocks[dataIndex] = block
end

this.RecycleBlock = function(dataIndex)
    local block = this.activeBlocks[dataIndex]
    if block then
        block.gameObject:SetActive(false)
        table.insert(this.objectPool, block)
        this.activeBlocks[dataIndex] = nil
    end
end

this.GetObject = function()
    if #this.objectPool > 0 then
        return table.remove(this.objectPool)
    else
        local newObj = GameObject.Instantiate(this.imgObstacle.gameObject, this.obstacleBox, false)
        local rect = newObj:GetComponent("RectTransform")
        return rect
    end
end

this.CheckCollision = function(rect1, rect2)
    local pos1, size1 = rect1.anchoredPosition, rect1.sizeDelta
    local pos2, size2 = rect2.anchoredPosition, rect2.sizeDelta
    local rect1_left = pos1.x - size1.x * rect1.pivot.x
    local rect1_right = pos1.x + size1.x * (1 - rect1.pivot.x)
    local rect1_bottom = pos1.y - size1.y * rect1.pivot.y
    local rect1_top = pos1.y + size1.y * (1 - rect1.pivot.y)
    local rect2_left = pos2.x - size2.x * rect2.pivot.x
    local rect2_right = pos2.x + size2.x * (1 - rect2.pivot.x)
    local rect2_bottom = pos2.y - size2.y * rect2.pivot.y
    local rect2_top = pos2.y + size2.y * (1 - rect2.pivot.y)
    if rect1_right < rect2_left or rect1_left > rect2_right then
        return false
    end
    if rect1_top < rect2_bottom or rect1_bottom > rect2_top then
        return false
    end
    return true
end


this.CheckActivityRunning = function()
    if not DataExHelper.CommonActivityCheck(this.activityKey) then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("15901"))
        return false;
    end
    return true;
end


return vm({
    data = data,
    command = command,
    hook = hook
})