---@class As06LevelPanel : As06LevelPanel_Generate
---##################### 【As06LevelPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【As06LevelPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local As06LevelPanel = require "As06LevelPanel_Generate"

function As06LevelPanel:InitLogic(data)
  self.msgEventHandler = {
        -- {GameMsgType.RefreshTopResource, function()
        --     self.customBackPanel.customBackPanel:RefreshTopResource()
        -- end},
        {GameMsgType.RefreshMaterilalLevelPanel, function()
            self:setLevelData(self.chapterId)
        end}, 
	}
    self.chapterId = nil --当前章节id
    self.selectLevelId = nil --当前选中关卡id
    self.nowSelectLevelBox = nil --当前选中关卡格子
    self.needStrenigthNum = 0  --进入关卡需要的体力
    self.newClearLevelBox = nil --最新通关的关卡格子
end

--function As06LevelPanel:StartCreating(time)
--
--end

--function As06LevelPanel:StartEnter(time)
--
--end

--function As06LevelPanel:StartRemoving(time)
--
--end

--function As06LevelPanel:StartExit(time)
--
--end

function As06LevelPanel:OnOpen(data, initiative)
    self:initData(data)
    self:setLevelData(self.chapterId, self.selLevelIndex)
    LoadingMgr:SetLoadingOver(function()
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
    end, nil, "As06LevelPanel")
end

function As06LevelPanel:initData(data)
    if not data then
        LuaLogger.e("As06LevelPanel:initData data is nil")
        return
    end
    self.chapterId = data.chapterId
    self.selLevelIndex = data.selLevelIndex or nil
    self.openFinishFunc = data.openFinishFunc or nil
end

function As06LevelPanel:setLevelData(chapterId, selLvIndex)
    local chapterConfig = Config.GetChapterInfo(chapterId)
    if not chapterConfig then
        LuaLogger.e("As06LevelPanel:setLevelData chapterConfig is nil, chapterId = "..chapterId)
        return
    end
    local levelList = chapterConfig.PveLevel
    self.m_chapterConfig = chapterConfig

    self.levelBoxList = {}
    self.newClearLevelBox = nil

    self:FillTemplateContent(self.levelBox, self.levelBoxGroup, #levelList, function (index,levelBox)
        local levelConfig = Config.GetPveLevelInfo(levelList[index][1])
        if not levelConfig then
            LuaLogger.e("As06LevelPanel:setLevelData levelConfig is nil, levelId = "..levelList[index][1])
            return
        end
        --设置关卡位置
        local boxPos = levelList[index][2]
        levelBox.rectTransform.anchoredPosition = Vector2.New(boxPos[1], boxPos[2])
        --判断关卡是否解锁
        local isLocked = UICommonUtils.CommonLockJudge(levelConfig.unlock) == false and true or false
        levelBox.line.image.color = isLocked and Color.NewFromStr("4D4D4D") or Color.NewFromStr("FFFFFF")
        levelBox.levelName.text.text = levelConfig.nameKey
        local levelData = Me:getLevelDataByid(levelConfig.id)
        if levelData and levelData.state == GE.LevelStateType.Finish then
            self.newClearLevelBox = levelBox
        end
        levelBox.isClear:SetActive(levelData and levelData.state == GE.LevelStateType.Finish)
        levelBox.btn.scaleButton.onClick:RemoveAllListeners()
        levelBox.btn.scaleButton.onClick:AddListener(function ()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if isLocked then
                UICommonUtils.PopToast(LocalStrEnum.PassPreLevelUnlock)
            else
                self:selectLevelBox(levelBox)
                self:setLevelInfo(levelConfig)
            end
        end)
        --如果有指定选中关卡，则选中指定关卡
        if selLvIndex and selLvIndex == index then
            DLuaTimer:DoAfter(0.5, function()
                self:selectLevelBox(levelBox)
                self:setLevelInfo(levelConfig)
            end)
        end
        table.insert(self.levelBoxList, levelBox)
        if index == tablex.size(levelList) then
            self:setBoxLine()
            if self.openFinishFunc then
                self.openFinishFunc()
            end
            --设置拖动框长度
            local beginPosX = levelList[1][2][1]
            local endPosX = levelList[#levelList][2][1]
            local length = endPosX + beginPosX + (self.levelInfo.rectTransform.sizeDelta.x / 2)
            self.levelBoxGroup.rectTransform.sizeDelta = Vector2.New(length, self.levelBoxGroup.rectTransform.sizeDelta.y)
            --根据最新通关id设置初始位置
            if selLvIndex and selLvIndex > 2 then
                --如果是从其他页面跳转过来，且选择的关卡在第三个之后，则自动将关卡格子移动到屏幕中心
                self:autoMoveBoxToCenter(self.levelBoxList[selLvIndex])
            elseif self.newClearLevelBox then
                self:autoMoveBoxToCenter(self.newClearLevelBox)
            else
                self:autoMoveBoxToCenter(self.levelBoxList[1])
            end
        end
    end)
end

--选中关卡格子逻辑
function As06LevelPanel:selectLevelBox(levelBox)
    if self.nowSelectLevelBox then
        self.nowSelectLevelBox.isSelect:SetActive(false)
    end
    if levelBox then
        self.nowSelectLevelBox = levelBox
        self.nowSelectLevelBox.isSelect.image.color = Color.New(1, 1, 1, 0)
        self.nowSelectLevelBox.isSelect:SetActive(true)
        --TODO detail show
        self.closeDetailBtn:SetActive(true)
        self.levelDetails.rectTransform:DOAnchorPos(Vector2.New(37, 0),0.5)
        -- if self.levelDetails.canvasGroup.alpha == 0 then
        --     self.animator:SetTrigger("ShowDetails")
        -- end
    else
        self.nowSelectLevelBox = nil
    end
end

--设置格子连线
function As06LevelPanel:setBoxLine()
    for i = 1, #self.levelBoxList do
        local nowBox = self.levelBoxList[i]
        local nextBox = self.levelBoxList[i + 1]
        if nextBox then
            local nowBoxPos = nowBox.startPoint.transform.position
            local nextBoxPos = nextBox.endPoint.transform.position
            local dir = nextBoxPos - nowBoxPos  -- 计算方向向量
            local angle = math.deg(math.atan2(dir.y, dir.x))  -- 计算角度，转成度数
            nowBox.line.transform.rotation = Quaternion.Euler(0, 0, angle)  -- 设置旋转角度

            local UICamera = UIMgr.uiCamera
            local nowScreenPoint = UICamera:WorldToScreenPoint(nowBoxPos)
            local _,nowScreenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(
            self.levelBoxGroup.rectTransform, Vector2.New(nowScreenPoint.x, nowScreenPoint.y), UICamera, nil)
            local nextScreenPos = UICamera:WorldToScreenPoint(nextBoxPos)
            local _,nextScreenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(
            self.levelBoxGroup.rectTransform, Vector2.New(nextScreenPos.x, nextScreenPos.y), UICamera, nil)
            local distance = Vector2.Distance(nowScreenPos, nextScreenPos)  -- 计算屏幕坐标下的距离
            nowBox.line.rectTransform.sizeDelta = Vector2.New(distance, 4)  -- 设置长度
        end
        nowBox.line:SetActive(nextBox ~= nil)
    end
end

--设置关卡详情面板信息
---@param levelConfig PveLevelTable
function As06LevelPanel:setLevelInfo(levelConfig)
    self.selectLevelId = levelConfig.id
    self.levelNameText.text.text = levelConfig.nameKey
    self.levelNameShadowText.text.text = levelConfig.nameKey
    self.levelCountTxt.text.text = levelConfig.title
    self.winCondition.conditionTxt.text.text = levelConfig.victoryDesKey
    self.defCondition.conditionTxt.text.text = levelConfig.failDesKey
    local rewardList = {}
    --材料关卡没有首通奖励
    for _, reward in pairs(levelConfig.nomalDropShow) do
        table.insert(rewardList, reward)
    end
    self:FillTemplateContent(self.customBox, self.rewardList, #rewardList, function (index, itemObj)
        local customBox = itemObj.customBox
        local rewardData = rewardList[index]
        customBox:setMono(self)
        customBox:SetUIData(rewardData)
    end)

    self:LoadSpriteAsync(string.format(Config.SpritePath.MaterialLevelBanner, levelConfig.MaterialLevelBanner), self.levelNameBg.image)
    self.needStrenigthNum = levelConfig.enterCost[2] + levelConfig.victoryCost[2]
    self.goStrengthText.text.text = "x"..self.needStrenigthNum
end

--边缘格子位置归正
function As06LevelPanel:autoMoveBoxToCenter(needLevelBox, needDoTween)
    local UICamera = UIMgr.uiCamera
    local nowBoxScreenPos = UICamera:WorldToScreenPoint(needLevelBox.transform.position)
    local nowBaseScreenPos = UICamera:WorldToScreenPoint(self.levelInfo.transform.position)
    local checkScreenPosX = nowBaseScreenPos.x - nowBoxScreenPos.x
    local moveX = 0
    local nowBoxGroupPos = nil
    if checkScreenPosX > 620 then --向右移动
        moveX = checkScreenPosX - 620
        nowBoxGroupPos = self.levelBoxGroup.rectTransform.anchoredPosition
    elseif checkScreenPosX < -170 then --向左移动
        moveX = checkScreenPosX - 170
        nowBoxGroupPos = self.levelBoxGroup.rectTransform.anchoredPosition
    end
    if not nowBoxGroupPos then
        return
    end
    local newPosX = math.min(nowBoxGroupPos.x + moveX, 0)
    newPosX = math.max(newPosX, self.scrollView.transform.sizeDelta.x - self.levelBoxGroup.transform.sizeDelta.x)
    if needDoTween then
        self.levelBoxGroup.rectTransform:DOAnchorPos(Vector2.New(newPosX, 0), 0.3)
    else
        self.levelBoxGroup.rectTransform.anchoredPosition = Vector2.New(newPosX, 0)
    end
end

--function As06LevelPanel:OnClose(initiative)
--
--end

--function As06LevelPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function As06LevelPanel:OnRefresh(data)
--
--end

--[[
/Main/LevelInfo/ScrollView/Viewport/LevelBoxGroup/LevelBox/Btn onClick 
--]]
function As06LevelPanel:btn_ScaleButton_onClick(btn)

end

--[[
/Main/Bottom/TaskBtn onClick 
--]]
function As06LevelPanel:taskBtn_ScaleButton_onClick(taskBtn)

end

--[[
/Main/Bottom/ShopBtn onClick 
--]]
function As06LevelPanel:shopBtn_ScaleButton_onClick(shopBtn)

end

--[[
/Main/CloseDetailBtn onClick 
--]]
function As06LevelPanel:closeDetailBtn_Button_onClick(closeDetailBtn)
    self.closeDetailBtn:SetActive(false)
    self.levelDetails.rectTransform:DOAnchorPos(Vector2.New(1002, 0),0.5)
end

--[[
/Main/LevelDetails/EnemyBtn onClick 
--]]
function As06LevelPanel:enemyBtn_ScaleButton_onClick(enemyBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUICover("LevelMapMsgPanel", {id = self.chapterId, levelId = self.selectLevelId, mode = 1})
end

--[[
/Main/LevelDetails/AutoBattle onClick 
--]]
function As06LevelPanel:autoBattle_ScaleButton_onClick(autoBattle)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local levelData = Me:getLevelDataByid(self.selectLevelId)
    if levelData and levelData.state == GE.LevelStateType.Finish then
        UIMgr:popUICover("BattleRepeatPanel",{levelId = self.selectLevelId})
    else
        UICommonUtils.PopToast("扫荡战斗未解锁，请三星通关关卡！")
    end
end

--[[
/Main/LevelDetails/GoBattle onClick 
--]]
function As06LevelPanel:goBattle_ScaleButton_onClick(goBattle)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local isEnough = Me:checkNormalTicket(self.needStrenigthNum)
    if not isEnough then
        UIMgr:popUICover("BuyTicketPanel", {})
        return
    end
    Me:setNowSelectLevel(self.selectLevelId)
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "As06LevelPanel2")
end

return As06LevelPanel
