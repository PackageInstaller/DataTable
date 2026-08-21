---@class LevelMapPanel : LevelMapPanel_Generate
---##################### 【LevelMapPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LevelMapPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class LevelMapPanel : LevelMapPanel_Generate
---##################### 【LevelMapPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LevelMapPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
---@class LevelMapPanel : LevelMapPanel_Generate
---##################### 【LevelMapPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LevelMapPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local LevelMapPanel = require "LevelMapPanel_Generate"
--SeaMapMgr = require "SeaMapMgr"
local DOTween = DG.Tweening.DOTween

function LevelMapPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
            self:refresh()
        end},
        {GameMsgType.FunctionOpenMapUpdate, self.setDifficultView},

        {GameMsgType.RefreshMaterilalLevelPanel, function()
            self:RefreshLevelCount()
        end},

        {GameMsgType.ChapterRewardGet, function()
            local chapterId = self.nowMode == 2 and self.nowDifficultLevelId or self.nowLevelId
            if chapterId and chapterId ~= 0 then
                self:changeView(chapterId)
            end
        end},

    }
    self.selectLevelId = 0
    self.needStrenigthNum = 0  --进入关卡需要的体力
    -- self:InitSeaMap()

    self.hardCanOpen = true
    self.nowMode = 1           --1:普通模式 2:困难模式

    self.nowLevelId = ClientData:GetNowSelectChatperId()
    self.nowDifficultLevelId = 0
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
end

--function LevelMapPanel:StartCreating(time)
--
--end

--function LevelMapPanel:StartEnter(time)
--
--end

--function LevelMapPanel:StartRemoving(time)
--
--end

--function LevelMapPanel:StartExit(time)
--
--end

function LevelMapPanel:OnOpen(data, initiative)
    self:InitSeaMap()
    --导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.LevelMapPanel, self)
    --接管返回方法
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        UIMgr:closeSpecificUI(self)
        SeaMapMgr:resetLastMode()
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)
    self:SetView()
end

function LevelMapPanel:SetView()
    self.nowLevelId = ClientData:GetNowSelectChatperId()
    local chapterData = Config.GetChapterInfo(self.nowLevelId)
    if chapterData == nil then
        LuaLogger.es("传入的章节id有误，配置未找到：", self.nowLevelId)
        return
    end

    self:setDifficultView()

    self:changeView(self.nowLevelId)
    --跳转默认显示的关卡
    local isJumped = self:__CheckJumpInfo()
    if not isJumped then
        --self:FristInfo()
    end
    --设置切换难度按钮----TODO: 这里可能需要追加对应难度的显示效果
    if chapterData.Type == GE.ChapterType.MainStory then
        self.storyBtn:SetActive(true)
        self.difficultBtn:SetActive(false)
        self:changeDifficultFunc(1)
    elseif chapterData.Type == GE.ChapterType.MainDifficult then
        self.storyBtn:SetActive(false)
        self.difficultBtn:SetActive(true)
        self:changeDifficultFunc(2)
        self.nowDifficultLevelId = self.nowLevelId
    end

    self:resetSortingOrder()
end

--设置困难显示
function LevelMapPanel:setDifficultView()
    self.nowLevelId = ClientData:GetNowSelectChatperId()
    local chapterData = Config.GetChapterInfo(self.nowLevelId)
    if chapterData == nil then
        return
    end

    --确认困难模式是否已经解锁
    self.hardCanOpen = true --困难模式是否可以进入
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.DifficultyMode)
    self.isNew:SetActive(state == GE.FunctionOpenState.Open)
    --再确认对于章节而言，该章节自身的困难模式是否已经解锁
    if state ~= GE.FunctionOpenState.Lock then --困难功能已解锁
        if chapterData.DeepType ~= 0 then   --确认自身拥有困难模式
            local deepChapterData = Config.GetChapterInfo(chapterData.DeepType)
            if deepChapterData then
                self.nowDifficultLevelId = deepChapterData.id
                   for _, value in pairs(deepChapterData.Condition) do
                    if value[1] == GE.CommonLockJudgeType.Level then           --通关某关卡
                        local levelData = Me:getLevelDataByid(value[2])
                        if levelData == nil or levelData.state ~= GE.LevelStateType.Finish then
                            self.hardCanOpen = false
                            break
                        end
                    end
                end
            end
        end
    else
        self.nowDifficultLevelId = 0
        self.hardCanOpen = false
    end
    self.changeBtnState:SetActive(self.hardCanOpen)
end

-- 分段线性映射：使用策划给定的星级刻度位置计算 fillAmount
-- 当前 3 档星级对应刻度：1星=0.205，2星=0.576，3星=1
function LevelMapPanel:CalcSliderFillAmount(nowStar, starCfgList)
    local count = tablex.size(starCfgList)
    if count == 0 then return 0 end

    -- 固定星级刻度位置，避免 rewardBox 节点中心与视觉刻度不重合导致偏差
    local fixedRatios = {0.205, 0.576, 1}
    local fillRatios = {}
    local prevRatio = 0
    for i = 1, count do
        local ratio = fixedRatios[i] or (i / count)
        ratio = math.max(0, math.min(1, ratio))
        ratio = math.max(prevRatio, ratio) -- 保障刻度递增，避免异常配置导致回退
        fillRatios[i] = ratio
        prevRatio = ratio
    end

    -- 分段线性插值：每段从上一档位 fill 插值到当前档位 fill
    local prevFill = 0
    local prevStar = 0
    for i = 1, count do
        local needStar = starCfgList[i].complete[2]
        local segEnd = fillRatios[i]
        if nowStar <= needStar then
            local range = needStar - prevStar
            local t = range > 0 and ((nowStar - prevStar) / range) or 1
            return prevFill + t * (segEnd - prevFill)
        end
        prevFill = segEnd
        prevStar = needStar
    end
    return 1
end

--根据章节id，改变界面信息显示
---@param chapterId number 章节id
function LevelMapPanel:changeView(chapterId)
    local chapterData = Config.GetChapterInfo(chapterId)
    if chapterData == nil then
        LuaLogger.es("传入的章节id有误，配置未找到：", chapterId)
        return
    end

    local nowStar = 0
    for _, level in pairs(chapterData.PveLevel) do
        local levelConfig = Config.GetPveLevelInfo(level[1])
        if levelConfig == nil then
            LuaLogger.es("配置的关卡id有误，配置未找到：", level[1])
            return
        end
        if levelConfig.type == GE.LevelType.Battle then
            local levelData = Me:getLevelDataByid(level[1])
            if levelData then
                nowStar = nowStar + levelData.star
            end
        end
    end
    local starCfgList = Config.GetChapterStarInfoByChapterId(chapterId)
    if starCfgList ~= nil and next(starCfgList) then
        self.allScheduleTxt.text.text = "/"..starCfgList[tablex.size(starCfgList)].complete[2]
        self.nowScheduleTxt.text.text = nowStar
        self.pointSlider:SetActive(true)
        self.chapterRewardList:SetActive(true)
        for i = 1, 3 do
            local starConfig = starCfgList[i]
            if starConfig then
                self["rewardBox"..i]:SetActive(true)
                --self["pointSliderBg"..i]:SetActive(true)    --TODO: 进度显示不需要再分3段了
                local needStar = starConfig.complete[2]
                local isGet = Me:getChapterAwardDataById(starCfgList[i].id) and true or false
                self["rewardBox"..i].starTxt.text.text = needStar
                --self["rewardBox"..i].isNot:SetActive((nowStar < needStar) and not isGet)
                local canGetReward = (nowStar >= needStar) and not isGet
                self["rewardBox"..i].canGet:SetActive(canGetReward)
                self["rewardBox"..i].isGet:SetActive(isGet)
                self["rewardBox"..i].red:SetActive(canGetReward)
                --local lastNeedStar = starCfgList[i - 1] and starCfgList[i - 1].complete[2] or 0
                --self["pointSlider"..i].image.fillAmount = 1 - ((needStar - nowStar) / (needStar - lastNeedStar))
            else
                --self["pointSliderBg"..i]:SetActive(false)
                self["rewardBox"..i]:SetActive(false)
            end
        end

        self.pointSliderImg.image.fillAmount = self:CalcSliderFillAmount(nowStar, starCfgList)
    else
        self.allScheduleTxt.text.text = "/".."-"
        self.nowScheduleTxt.text.text = "-"
        self.pointSlider:SetActive(false)
        self.chapterRewardList:SetActive(false)
    end
end

--检测是否有跳转默认显示的关卡id
--- func description
---@return boolean  是否是跳转
function LevelMapPanel:__CheckJumpInfo()
    local targetLevelId = ClientData:GetNowSelectLevelId()
    if targetLevelId and Me:getLevelIsUnLock(targetLevelId) then
        self:SetDetailsByType(targetLevelId)
        return true
    end
    return false
end

function LevelMapPanel:FristInfo()
    local nowChatperId = ClientData:GetNowSelectChatperId()
    local ChapterConfig = Config.GetChapterInfo(nowChatperId)
    local levelList = ChapterConfig.PveLevel
    local nowOpen = nil
    for i = tablex.size(levelList), 1, -1 do
        if Me:getLevelIsUnLock(levelList[i][1]) then
            nowOpen = levelList[i][1]
            break
        end
    end
    self:SetDetailsByType(nowOpen)
end

--根据关卡类型来区分打开的详情界面
function LevelMapPanel:SetDetailsByType(levelId)
    local levelConfig = Config.GetPveLevelInfo(levelId)
    local levelData = Me:getLevelDataByid(levelId)
    LuaLogger.ds("levelData", tablex.dump(levelData))
    if levelConfig then
        LuaLogger.ds("levelConfig.type = ",levelConfig.type)
        self.levelDetails:SetActive(false)
        self.storyDetails:SetActive(false)
        if levelConfig.type == GE.LevelType.Story then
            self:SetStoryDetails(levelId)
        elseif levelConfig.type == GE.LevelType.Battle or levelConfig.type == GE.LevelType.Once then
            self:setLevelDetails(levelId)
        elseif levelConfig.type == GE.LevelType.Res then
            local levelData = Me:getLevelDataByid(levelConfig.id)
            if levelData and levelData.completeNum > 0 then
                UIMgr:popUI("MsgBox", {
                    title = levelConfig.nameKey,
                    content = "该资源点已通关",
                    type = MsgBoxType.OKCancel,
                    okCallback = function()
                    end,
                })
            else
                self:setLevelDetails(levelId)
            end
        end
    end
end

function LevelMapPanel:SetStoryDetails(levelId)
    local levelConfig = Config.GetPveLevelInfo(levelId)
    self.selectLevelId = levelConfig.id
    self.storyLevelText.text.text = levelConfig.title
    self.storyNameText.text.text = levelConfig.nameKey
    self.storyDesc.text.text = levelConfig.desKey
    self.closeDetailBtn:SetActive(true)
    self.storyDetails:SetActive(true)
end

function LevelMapPanel:setLevelDetails(levelId)
    local levelConfig = Config.GetPveLevelInfo(levelId)
    self.selectLevelId = levelConfig.id
    self.typeIconImg:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.LevelTypeIconPath, levelConfig.type), self.typeIconImg.image)

    self.levelNameBg:SetActive(true)
    self:LoadSpriteAsync(string.format(Config.SpritePath.MaterialLevelBanner, levelConfig.MaterialLevelBanner), self.levelNameBg.image)

    self.levelNameText.text.text = levelConfig.nameKey
    self.levelNameShadowText.text.text = levelConfig.nameKey

    self.starList:SetActive(levelConfig.type == GE.LevelType.Battle)
    self.typeNameTxt:SetActive(levelConfig.type == GE.LevelType.Res or levelConfig.type == GE.LevelType.Once)
    self.levelNameEng:SetActive(levelConfig.type == GE.LevelType.Battle)
    self.levelCountTxt.text.text = levelConfig.title
    self.typeNameTxt.text.text = levelConfig.title
    self.recLevelText.text.text = levelConfig.recommendLevel

    local monsterShow = tablex.size(levelConfig.monsterShow)
    self.enemyBtn:SetActive(monsterShow > 0)
    if levelConfig.type == GE.LevelType.Once then
        self.recLevelText.rectTransform.anchoredPosition = Vector2.New(65, self.recLevelText.rectTransform.anchoredPosition.y)
    else
        self.recLevelText.rectTransform.anchoredPosition = Vector2.New(48, self.recLevelText.rectTransform.anchoredPosition.y)
    end

    self.starBg:SetActive(levelConfig.type ~= GE.LevelType.Once)
    self.msgBg:SetActive(tablex.size(levelConfig.achieve) ~= 0)
    local levelData = Me:getLevelDataByid(levelConfig.id)
    if levelData then
        local finishTask = levelData.achieveList
        self.nowProgressTxt.text.text = tablex.size(finishTask)
        self.allProgressTxt.text.text = "/"..tablex.size(levelConfig.achieve)
    else
        self.nowProgressTxt.text.text = "0"
        self.allProgressTxt.text.text = "/"..tablex.size(levelConfig.achieve)
    end
    self.closeDetailBtn:SetActive(true)
    --if levelData.type then
    --    
    --end
    self.levelDetails:SetActive(true)

    self.winCondition.conditionTxt.text.text = levelConfig.victoryDesKey
    self.defCondition.conditionTxt.text.text = levelConfig.failDesKey
    self.conditionBox_1.conditionTxt.text.text = levelConfig.starDesKey1
    self.conditionBox_2.conditionTxt.text.text = levelConfig.starDesKey2
    

    local rewardList = {}
    for i = 1, 3 do
        self.starList["star"..i]:SetActive(levelData and i <= levelData.star)
    end

    local fristClear = false
    --首通奖励 第一次且配置有第一次配置才会显示首通奖励
    if (levelData == nil or levelData.completeNum == 0) and levelConfig.firstDrop ~= nil and #levelConfig.firstDrop > 0 then
        fristClear = true
    end

    if fristClear then
        local fristDrop = clone(levelConfig.firstDrop)
        for _, reward in pairs(fristDrop) do
            reward.isFrist = true
            table.insert(rewardList, reward)
        end
    else
        for _, reward in pairs(levelConfig.nomalDropShow) do
            table.insert(rewardList, reward)
        end
    end

    self:FillTemplateContent(self.customBox, self.rewardList, tablex.size(rewardList), function (index, itemObj)
        local rewardData = rewardList[index]
        local customBox = itemObj.customBox
        local data = {
            isFrist = rewardData.isFrist
        }
        if rewardData[1] == GE.RewardType.ItemProp then
            local itemConfig = Config.GetItemInfo(rewardData[2])
            data.isFrist = rewardData.isFrist
        elseif rewardData[1] == GE.RewardType.Equipment then
            data.isFrist = rewardData.isFrist
            data.CanLock = false
        elseif rewardData[1] == GE.RewardType.Weapon then
            data.CanLock = false
        end
        -- if rewardData[3] ~= 0 then
        --     data.itemNum = rewardData[3]
        -- end
        customBox:setMono(self)
        customBox:SetUIData(rewardData, data)
    end)
    if levelConfig.type ~= GE.LevelType.Story then
        self.needStrenigthNum = levelConfig.enterCost[2] + levelConfig.victoryCost[2]

        local isEnough = Me:checkNormalTicket(self.needStrenigthNum)
        if isEnough then
            self.goStrengthText.text.text = "x"..self.needStrenigthNum
        else
            self.goStrengthText.text.text = "<color=#FF3131>x"..self.needStrenigthNum.."</color>"
        end
        self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, "ItemIcon_"..GE.ResourceType.Strength), self.strengthIcon.image)
    end
    self.autoBattle:SetActive(levelData and levelData.state == GE.LevelStateType.Finish)
    self.needStrengthBg:SetActive(levelConfig.type ~= GE.LevelType.Story)

    self.levelDetails.isHard:SetActive(self.nowMode == 2)
    self:RefreshLevelCount()
end

function LevelMapPanel:refresh()
    local isEnough = Me:checkNormalTicket(self.needStrenigthNum)
    if isEnough then
        self.goStrengthText.text.text = "x"..self.needStrenigthNum
    else
        self.goStrengthText.text.text = "<color=#FF3131>x"..self.needStrenigthNum.."</color>"
    end
end

---@param data CustomMsgData
function LevelMapPanel:OpenCustomMsgPanel(data)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

function LevelMapPanel:ShowOrHideView(isShow)
    if isShow then
        UIMgr:showUI(self)
    else
        UIMgr:hideUI(self)
    end
end

--检查是否有未观看的关卡开启提示
function LevelMapPanel:CheckTips(callback)
    --LuaLogger.ds(" LevelMapPanel:CheckTips", debug.traceback())
    local unWatchList = UICommonUtils.GetUnwatchedLevelList()
    if tablex.size(unWatchList) > 0 then
        local FunctionOpenTips = UIMgr:GetUI("FunctionOpenTips")
        if FunctionOpenTips then
            FunctionOpenTips:SetFinishCallback(callback)
        else
            UIMgr:popUICover("FunctionOpenTips", {
                type = {1},
                finishCallback = function()
                    if callback then
                        callback()
                    end
                end,
            })
        end
    else
        if callback then
            callback()
        end
    end
end

--todo 加载海图资源
function LevelMapPanel:InitSeaMap()
    local seaMapRoot = GameObject.Find("SeaMapRoot")
    if not seaMapRoot then
        self:ShowOrHideView(false)
        self:LoadGameObjectAsync(Config.PrefabPath.SeaMapRoot, function(seaMapRoot)
            -- local seaMapRoot = Instantiate(obj)
            seaMapRoot.name = "SeaMapRoot"
            seaMapRoot.transform.localPosition = (Vector3(1000,0,0))
            SeaMapMgr:InitUiPos()
            --结束loading
            LoadingMgr:SetLoadingOver(function()
                if CoveManager.instance() then
                    CoveManager.instance():SetHomelandShowOrHide(false)
                end
                self:ShowOrHideView(true)
                local lastMode = SeaMapMgr:getLastMode()
                if lastMode ~= nil then
                    self:changeDifficultFunc(lastMode)
                end
                -- loading 结束后延迟播放新解锁节点的连接线动画
                DLuaTimer:DoAfter(1, function()
                    SeaMapMgr:PlayNewUnlockedLevelAnims()
                end)
                self:CheckTips()
            end, nil, "LevelMapPanel")
        end)
    else
        self:CheckTips()
    end
end

--领取章节奖励
function LevelMapPanel:getChapterReward(index)
    local rewardBox = self["rewardBox"..index]
    local nowChatperId = 0
    if self.nowMode == 1 then
        nowChatperId = self.nowLevelId
    elseif self.nowMode == 2 then
        nowChatperId = self.nowDifficultLevelId
    end
    local starCfgList = Config.GetChapterStarInfoByChapterId(nowChatperId)
    local starCfg = starCfgList[index]
    if rewardBox.canGet.activeSelf ~= true then
        self.boxHideBtn:SetActive(true)
        local UICamera = UIMgr.uiCamera
        local screenPos = UICamera:WorldToScreenPoint(rewardBox.transform.position)
        local localPos = UICommonUtils.ScreenToUILocalPos(self.boxHideBtn.transform, UICamera, screenPos)
        localPos.y = localPos.y + self.boxReviewRoot.rectTransform.sizeDelta.y / 3 * 2
        self.boxReviewRoot.transform.localPosition = localPos

        local chapterStarConfig = Config.GetChapterStarInfo(starCfg.id)
        if chapterStarConfig == nil then
            LuaLogger.e("传入的章节id有误，配置未找到：", starCfg.id)
            return
        end
        for i = 1, 3 do
            local box = self["box"..i]
            local rewardData = chapterStarConfig.starAward[i]
            if rewardData then
                box:SetActive(true)
                local customBox = box.customBox
                --[[local data = {
                    id = rewardData[2],
                    itemType = GE.ItemTypeIndex.item,
                    itemNum = rewardData[3],
                }]]
                customBox:setMono(self)
                customBox:SetUIData(rewardData)
            else
                box:SetActive(false)
            end
        end
        return
    end
    Me:GetChapterRewardReq({chapterAwardId = starCfg.id}, function(data)
        self:SetView()
        --发送章节奖励领取消息，通知SeaMapPanel刷新红点
        GameMsgMgr:sendEvent(GameMsgType.ChapterRewardGet)
    end)
end

function LevelMapPanel:resetSortingOrder()
    local nowOrder = self.transform:GetComponent("Canvas").sortingOrder
    local effects = {self.effect_UI_HardMod, self.effect_UI_Fire}
    for _, effect in ipairs(effects) do
        local effectTransform = effect.transform
        for j = 1, effectTransform.childCount do
            local particleSystemRenderer = effectTransform:GetChild(j - 1):GetComponent("ParticleSystemRenderer")
            particleSystemRenderer.sortingOrder = nowOrder + 1
        end
    end
end

--function LevelMapPanel:Update()
--    LuaLogger.ds("LevelMapPanel:update")
--end
--function LevelMapPanel:OnClose(initiative)
--
--end

function LevelMapPanel:OnDestroy()
	--self.super:OnDestroy(self)
    --local MainPanel = UIMgr:GetUI("MainPanel")
    --if MainPanel then
    --    MainPanel:RefreshNowMode()
    --end
    -- if CoveManager.instance() then
    --     CoveManager.instance():SetHomelandShowOrHide(true)
    --     CoveManager.instance():setFocusState(true)
    -- end

    -- 先将 rewardList 中的池化奖励预制体归还到对象池，避免随面板销毁绕过池
    self:FillTemplateContent(self.customBox, self.rewardList, 0, function() end)

    -- 先将 SeaMapMgr 管理的池化对象归还到对象池，再销毁 SeaMapRoot
    -- 顺序不可颠倒：Destroy 之后对象已失效，无法再做 PoolMgr.Free
    SeaMapMgr:FreeAllPooledObjects()

    local seaMapRoot = GameObject.Find("SeaMapRoot")
    if seaMapRoot then
        GameObject.Destroy(seaMapRoot)
    end
    SeaMapMgr:Clear()

    self.super:OnDestroy(self)
end

--function LevelMapPanel:OnRefresh(data)
--
--end

--[[
/LevelList/LevelBox onClick 
--]]
function LevelMapPanel:levelBox_ScaleButton_onClick(levelBox)
    --不使用的方法
end

--[[
/LevelDetailsCloseBtn onClick 
--]]
function LevelMapPanel:levelDetailsCloseBtn_Button_onClick(levelDetailsCloseBtn)
    self:play2DSound(self.btnSoundPath)
    self.levelDetails:SetActive(false)
end

--[[
/LevelDetailsCloseBtn/LevelDetailsBg/LevelInfo/DetailsBtn onClick 
--]]
function LevelMapPanel:detailsBtn_ScaleButton_onClick(detailsBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("LevelDetailPanel", {levelId = self.selectLevelId})
end

--[[
/LevelDetailsCloseBtn/LevelDetailsBg/AutoBattle onClick 
--]]
function LevelMapPanel:autoBattle_ScaleButton_onClick(autoBattle)
    self:play2DSound(self.btnSoundPath)
    local levelData = Me:getLevelDataByid(self.selectLevelId)

    local lastCount = self:GetPveLevelLastCount()
    if lastCount == 0 then
        UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_CleanNumNotEnough)
        return
    end

    if levelData and levelData.state == GE.LevelStateType.Finish then
        UIMgr:popUICover("BattleRepeatPanel",{levelId = self.selectLevelId})
    else
        UICommonUtils.PopToast("扫荡战斗未解锁，请三星通关关卡！")
    end
end

--[[
/LevelDetailsCloseBtn/LevelDetailsBg/GoBattle onClick 
--]]
function LevelMapPanel:goBattle_ScaleButton_onClick(goBattle)
    self:play2DSound(self.btnSoundPath)
    Me:setNowSelectLevel(self.selectLevelId)
    --UIMgr:closeUI(self)
    --判断体力是否充足
    local isEnough = Me:checkNormalTicket(self.needStrenigthNum)
    if not isEnough then
        UIMgr:popUICover("BuyTicketPanel", {})
        return
    end

    local levelId =  self.selectLevelId
    local levelConfig = Config.GetPveLevelInfo(levelId)
    if levelConfig.cleanNum ~= -1 then
        local levelInfo = Me:getLevelDataByid(levelId)
        local curCount = (levelInfo and levelInfo.dailyBattleNum) or 0
        local lastCount = levelConfig.cleanNum - (curCount)
        if lastCount <= 0 then
            UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_CleanNumNotEnough)
            return
        end
    end

    --TODO: 这里记录上次的模式和章节id  来了看这里
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "LevelMapPanel2")
end

--[[
/CustomBackPanel/HelpBtn onClick 
--]]
function LevelMapPanel:helpBtn_ScaleButton_onClick(helpBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/CloseDetailBtn onClick 
--]]
function LevelMapPanel:closeDetailBtn_Button_onClick(closeDetailBtn)
    self:play2DSound(self.btnSoundPath)
    self.closeDetailBtn:SetActive(false)
    self.levelDetails:SetActive(false)
    -- SeaMapMgr:ClearSelect()
    SeaMapMgr:resetLastMode()
    self.storyDetails:SetActive(false)
end

--[[
/LevelDetails/ResBg/AddBtn onClick 
--]]
function LevelMapPanel:addBtn_ScaleButton_onClick(addBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/LevelDetails/MsgBtn onClick 
--]]
function LevelMapPanel:msgBtn_ScaleButton_onClick(msgBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("LevelMapMsgPanel", {id = ClientData:GetNowSelectChatperId(), levelId = self.selectLevelId, mode = 2})
end

--[[
/StoryDetails/GoStory onClick 
--]]
function LevelMapPanel:goStory_ScaleButton_onClick(goStory)
    self:play2DSound(self.btnSoundPath)
    Me:setNowSelectLevel(self.selectLevelId)
    local levelConfig = Config.GetPveLevelInfo(self.selectLevelId)
    Me:battleStartReq(self.selectLevelId, {}, Me:getNowEnterMeans(), function (data)
        self:_enterStory(levelConfig, function()
            local orderReport = {
                initData = {level = self.selectLevelId, heroInfoList = {}},
            }
            Me:battleResultReq(orderReport, {}, {}, function (resultData)
                if (resultData.result) then
                    if levelConfig.storyEnd and levelConfig.storyEnd ~= 0 then
                        local storyConfig = Config.GetStoryArraryInfo(levelConfig.storyEnd)
                        if storyConfig.type == 2 then
                            UIMgr:popUI("StoryPanel", {storyName = storyConfig.storyArrary[1], callBack = function()
                                if resultData.fristDrop and next(resultData.fristDrop) then
                                    UIMgr:popUICover("ReceiveRewardPanel", {rewardList = resultData.fristDrop, closeFunc = function()
                                        self:CheckTips(function()
                                            GuideMgr:StartGuideTrigger("LevelMapPanel")
                                        end)
                                    end})
                                    SeaMapMgr:Refresh()
                                    self:SetView()
                                end
                            end})
                        end
                    else
                        if resultData.fristDrop and next(resultData.fristDrop) then
                            UIMgr:popUICover("ReceiveRewardPanel", {rewardList = resultData.fristDrop, closeFunc = function()
                                self:CheckTips(function()
                                    GuideMgr:StartGuideTrigger("LevelMapPanel")
                                end)
                            end})
                            SeaMapMgr:Refresh()
                            self:SetView()
                            GameMsgMgr:sendEvent(GameMsgType.RefreshTopResource)
                        end
                    end
                else
                    UIMgr:popUI("BattleLosePanel")
                end
                Time.timeScale = 1
            end)
        end)
    end)
    self.storyDetails:SetActive(false)
end

function LevelMapPanel:_enterStory(levelConfig, endCallback) 
    local storyConfig = Config.GetStoryArraryInfo(levelConfig.storyOpen)
    if storyConfig.type == 1 then--目前暂无演出类型的纯剧情
        -- self.battleMgr = BattleCore:getBattleMgr()
        -- self.battleMgr:setLevelConfig(levelConfig)
        -- self.battleMgr:storyStart(levelConfig.storyOpen, endCallback)
    elseif storyConfig.type == 2 then
        UIMgr:popUI("StoryPanel", {storyName = storyConfig.storyArrary[1], callBack = endCallback})
    end
end

--[[
/ChangeDifficult/StoryBtn onClick 
--]]
function LevelMapPanel:storyBtn_Button_onClick(storyBtn)
    self:play2DSound(self.btnSoundPath)
    self:changeDifficultFunc(2)
end

--[[
/ChangeDifficult/DifficultBtn onClick 
--]]
function LevelMapPanel:difficultBtn_Button_onClick(difficultBtn)
    self:play2DSound(self.btnSoundPath)
    self:changeDifficultFunc(1)
end

--根据难度索引切换难度  TODO: 需要屏蔽按钮，主动调用对应难度的显示
function LevelMapPanel:changeDifficultFunc(modeIndex)
    --此脚本是UI层，需要内部处理普通模式id和困难模式id的切换
    if modeIndex == 1 then
        --普通模式 
        self.nowMode = 1
        --普通模式显示
        self.isHard:SetActive(false)
        self:changeView(self.nowLevelId)
        self.storyBtn:SetActive(true)
        self.difficultBtn:SetActive(false)
    elseif modeIndex == 2 then
        -- local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.DifficultyMode)
        -- if state == GE.FunctionOpenState.Lock then
        --     UICommonUtils.PopToast(tips)
        --     return
        -- end
        --如果当前章节没有困难模式，则提示
        -- if self.nowDifficultLevelId == 0 or self.hardCanOpen == false then
        --     UICommonUtils.PopToast("当前章节困难模式未开放")
        --     self.nowMode = 1
        --     return 
        -- end
        self.nowMode = 2
        self.isHard:SetActive(true)
        self.storyBtn:SetActive(false)
        self.difficultBtn:SetActive(true)
        self:changeView(self.nowLevelId)
        local nowFunctionOpenState = Me:getFunctionOpenStateById(GE.FunctionOpenModule.DifficultyMode)
        if nowFunctionOpenState == GE.FunctionOpenState.Open then
            Me:readFunctionReq({functionId = GE.FunctionOpenModule.DifficultyMode})
        end
    end
    --通知场景层，使用seamapMgr的切换方法
    SeaMapMgr:ModeChange(self.nowMode)
end

--TODO: 修改为同按钮互相切换

--[[
/ChapterRewardBg/RewardList/RewardBox1/Btn1 onClick 
--]]
function LevelMapPanel:btn1_ScaleButton_onClick(btn1)
    self:play2DSound(self.btnSoundPath)
    self:getChapterReward(1)
end

--[[
/ChapterRewardBg/RewardList/RewardBox2/Btn2 onClick 
--]]
function LevelMapPanel:btn2_ScaleButton_onClick(btn2)
    self:play2DSound(self.btnSoundPath)
    self:getChapterReward(2)
end

--[[
/ChapterRewardBg/RewardList/RewardBox3/Btn3 onClick 
--]]
function LevelMapPanel:btn3_ScaleButton_onClick(btn3)
    self:play2DSound(self.btnSoundPath)
    self:getChapterReward(3)
end

--[[
/BoxHideBtn onClick 
--]]
function LevelMapPanel:boxHideBtn_Button_onClick(boxHideBtn)
    self:play2DSound(self.btnSoundPath)
    self.boxHideBtn:SetActive(false)
end

--[[
/ChangeDifficult/ChangeBtnState onClick 
--]]
function LevelMapPanel:changeBtnState_ScaleButton_onClick(changeBtnState)
    self:play2DSound(self.btnSoundPath)
    local state, tips, lockShowType = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.DifficultyMode)
    if state == GE.FunctionOpenState.Lock then
        UICommonUtils.PopToast(tips)
        return
    end

    if self.hardCanOpen then
        if self.nowMode == 1 then
            self:changeDifficultFunc(2)
        elseif self.nowMode == 2 then
            self:changeDifficultFunc(1)
        end
    else
        UICommonUtils.PopToast("当前章节困难模式未开放")
    end
end

--[[
/LevelDetails/EnemyBtn onClick 
--]]
function LevelMapPanel:GetPveLevelLastCount()
    if self.selectLevelId == nil then
        return -1
    end
    local levelConfig = Config.GetPveLevelInfo(self.selectLevelId)
    if levelConfig == nil then
        return -1
    end
    local showCount = levelConfig.cleanNum ~= -1
    self.lastCountInfo:SetActive(showCount)
    if showCount then
        local levelInfo = Me:getLevelDataByid(levelConfig.id)
        local curCount = (levelInfo and levelInfo.dailyBattleNum) or 0
        local addCount = Me:GetCycleCardPrivilegeAddCount(PrivilegeType["LevelMapCleanAddCount_" .. levelConfig.typemain])
        local lastCount = levelConfig.cleanNum + addCount - (curCount)
        lastCount = math.max(0, lastCount)
        return lastCount
    end
    return -1
end

function LevelMapPanel:RefreshLevelCount()
    local lastCount = self:GetPveLevelLastCount()
    self.lastCountInfo:SetActive(lastCount ~= -1)
    if lastCount == -1 then
        return
    end
    local str = lastCount
    if lastCount == 0 then
        str = "<color=red>" .. lastCount .. "</color>" 
    end
    self.lastCountText.text.text = string.format(LocalStrEnum.leveltips_001, str)
end

--[[
/AdjustRoot/LevelDetails/EnemyBtn onClick 
--]]
function LevelMapPanel:enemyBtn_ScaleButton_onClick(enemyBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("LevelMapMsgPanel", {id = ClientData:GetNowSelectChatperId(), levelId = self.selectLevelId, mode = 1})
end

--[[
/TestBtn onClick 
--]]
function LevelMapPanel:testBtn_Button_onClick(testBtn)
    -- SeaMapMgr:PlayNewLevelLineAnim(1020301, 0.8, function()
    --     LuaLogger.ds("动画播放结束")
    -- end)

    -- SeaMapMgr:PlayLevelLineAnimQueue({10203, 1020301, 10204}, 0.8, function()
    --     LuaLogger.ds("队列动画播放结束")
    -- end)
end





return LevelMapPanel
