---@class LevelUpPanel : LevelUpPanel_Generate
---##################### 【LevelUpPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【LevelUpPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local LevelUpPanel = require "LevelUpPanel_Generate"

function LevelUpPanel:InitLogic(data)
    self.roleId = nil
    self.roleSeverData = {}
    self.nowViewLevel = nil     -- 当前显示等级
    self.isRuning = false       -- 是否在动画中
    self.maxLevel = 60          --TODO: 动态获取最大等级
    self.levelBoxList = {}      --等级列表
    self.pos = {}               -- 每个等级预制体的位置
    self.distance = 0           -- 每个等级之间的距离
    self.scroll_pos = 0         -- 滚动条位置
    self.startLevel = nil       -- 开始等级
    self.effectTimer = nil      -- 特效计时器
    self.laterTimer = nil       -- 递增等级文本延迟计时器
    self.isBreak = false        -- 是否中断升级特效
    self.isDrag = false         -- 是否拖拽
    self.userLevel = Me:getUserLevel()  -- 用户等级
    self.levelTween = nil -- 等级递增动画
    self.effectLevelUpTimer_2 = nil -- 升级特效第2段计时器
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.isRebuilding = false -- 是否正在重建UI列表（防止scroll_pos被意外覆盖）
    self.canBlankClose = true  -- 是否允许点击空白处关闭
    self.isPlayingLevelUpEffect = false -- 是否正在播放升级演出
    self.isBurstPlaying = false -- 是否正在播放第二段爆炸特效
    self.isEffectFinishing = false -- 是否正在收尾（循环特效/遮罩淡出）
    self.isClosingPanel = false -- 是否已进入关闭流程
    self._breakEffectFrame = -1 -- 防止同帧重复触发中断
    self.burstEffectDuration = 0.85 -- 跳过时爆炸完整展示时长，兼顾看清与关界面速度
    self.burstSkipProtectDuration = 0.15 -- 跳过后最短可见时间，此期间再点也不会中断爆炸
    self.burstSkipCanForceClose = true -- 最短可见时间结束后，允许再点立刻关界面
    self.levelUpAnimSpeed = 3 -- 点击后 LevelUp 动画倍速
    self.isLevelUpAnimSpeedUp = false -- LevelUp 动画是否已进入倍速
    self.beforeLevelUpAttrs = nil -- 升级前六维快照
    self.hasLevelUpInThisPanel = false -- 本次打开是否发生过升级
end

--function LevelUpPanel:StartCreating(time)
--
--end

--function LevelUpPanel:StartEnter(time)
--
--end

--function LevelUpPanel:StartRemoving(time)
--
--end

--function LevelUpPanel:StartExit(time)
--
--end

function LevelUpPanel:OnOpen(data, initiative)
    self.hasLevelUpInThisPanel = false
    if data then
        self.roleId = data
        self.roleSeverData = Me:getPlayerHero(self.roleId)
        self:SetViewInfo()
        local nowCanUpLevel = self:FindNowCanUpLevel()
        
        -- 验证初始等级索引并修正
        if not self:ValidateLevelIndex(nowCanUpLevel) then
            nowCanUpLevel = math.max(1, math.min(nowCanUpLevel, #self.pos))
        end
        
        self.scroll_pos = self.pos[nowCanUpLevel]
        self.bar.scrollbar.value = self.pos[nowCanUpLevel]
        self.tipsBg:SetActive(false)
    end
    if not initiative then
        self.nowViewLevel = nil
        self:RefreshViewInfo()
    else
        self:SetUpdateInterval(0)
    end
    GuideMgr:StartGuideTrigger("LevelUpPanel")
end

function LevelUpPanel:Update()
    if self.isPlayingLevelUpEffect and not self.isClosingPanel and Input.GetMouseButtonDown(0) then
        self:BreakLevelUpEffect()
        return
    end
    self:SelectList()
end

function LevelUpPanel:SelectList()
    if not self.canRun then
        return
    end

    for i = 1, #self.levelBoxList do
        if Input.GetMouseButtonDown(0) then
            self.isDrag = true
        end
        
        if Input.GetMouseButtonUp(0) then
            DLuaTimer:DoAfter(0.25, function ()
                self.isDrag = false
                self.scroll_pos = self.bar.scrollbar.value
            end)
        end

        if Input.GetMouseButton(0) then
            -- 拖拽时实时同步位置，但如果正在重建UI则跳过，避免覆盖预设的scroll_pos
            if not self.isRebuilding then
                self.scroll_pos = self.bar.scrollbar.value
            end
        else
            if not self.isDrag then
                for j = 1, #self.levelBoxList do
                    if self.pos[j] then
                        if self.scroll_pos < self.pos[j] + (self.distance / 2) and self.scroll_pos > self.pos[j] - (self.distance / 2) then
                            self.bar.scrollbar.value = Mathf.Lerp(self.bar.scrollbar.value, self.pos[j], 0.01)
                        end
                    end
                end
            end
        end
    end

    -- 始终刷新等级列表显示（包括拖拽时）
    self:RefreshLevelObjList()
end

--刷新等级列表
function LevelUpPanel:RefreshLevelObjList()
    local selectedLevel = nil
    for x = 1, #self.levelBoxList do
        local levelBox = self.levelBoxList[x]
        local isSelect = levelBox.transform:Find("IsSelect").gameObject
        local levelNumTxt = levelBox.transform:Find("LevelNumTxt").gameObject
    
        if self.scroll_pos < self.pos[x] + (self.distance / 2) and self.scroll_pos > self.pos[x] - (self.distance / 2) then
            selectedLevel = x
            isSelect:SetActive(true)
            levelNumTxt:SetActive(false)
            self:UpdateLevelView(x)
    
            for a = 1, #self.levelBoxList do
                if a ~= x then
                    local otherLevelBox = self.levelBoxList[a]
                    local otherIsSelect = otherLevelBox.transform:Find("IsSelect").gameObject
                    local otherLevelNumTxt = otherLevelBox.transform:Find("LevelNumTxt").gameObject
                    
                    otherIsSelect:SetActive(false)
                    otherLevelNumTxt:SetActive(true)
                end
            end
        else
            isSelect:SetActive(false)
            levelNumTxt:SetActive(true)
        end
    end
end

--设置等级列表
function LevelUpPanel:SetLevelUpList()
    self.isRebuilding = true -- 标记开始重建
    self.canRun = false

    if next(self.levelBoxList) then
        for i = 1, #self.levelBoxList do
            GameObject.Destroy(self.levelBoxList[i].gameObject)
        end
    end
    self.levelBoxList = {}

    for i = 1, self.maxLevel do
        local obj = GameObject.Instantiate(self.levelBox)
        obj.gameObject.transform:SetParent(self.content.transform)
        obj.gameObject.transform.localScale = Vector3(1,1,1)
        obj.gameObject.transform.localPosition = Vector3(1,1,0)

        if i < self.roleSeverData.level + 1 then
            obj.transform:Find("LevelNumTxt"):GetComponent(TypeInfo.TextMeshProUGUI).color = Color.New(163/255,163/255,163/255)
        else
            obj.transform:Find("LevelNumTxt"):GetComponent(TypeInfo.TextMeshProUGUI).color = Color.New(73/255,73/255,73/255)
        end

        obj.transform:Find("IsMax").gameObject:SetActive(self.userLevel == i)
        obj.transform:Find("IsNow").gameObject:SetActive(self.roleSeverData.level == i)
        obj.transform:Find("LevelNumTxt"):GetComponent(TypeInfo.TextMeshProUGUI).text = i
        obj.transform:GetComponent(TypeInfo.ScaleButton).onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self.scroll_pos = self.pos[i]
            self.isDrag = false
        end)
        obj.transform:Find("IsSelect").transform:Find("SelectShadowTxt"):GetComponent(TypeInfo.TextMeshProUGUI).text = i
        obj.transform:Find("IsSelect").transform:Find("SelectLevelNumTxt"):GetComponent(TypeInfo.TextMeshProUGUI).text = i
        obj:SetActive(true)
        table.insert(self.levelBoxList, obj)
    end
    
    self.distance = 1 / (#self.levelBoxList - 1)
    for i = 1, #self.levelBoxList do
        self.pos[i] = self.distance * (i - 1)
    end

    DLuaTimer:DoAfter(0.1, function ()
        self.isRebuilding = false -- 重建完成
        self.canRun = true
        
        -- 如果有待设置的目标等级，在UI重建完成后设置
        if self.targetLevelAfterRebuild then
            local targetLevel = self.targetLevelAfterRebuild
            self.targetLevelAfterRebuild = nil -- 清除标记
            
            -- 验证索引并修正
            if not self:ValidateLevelIndex(targetLevel) then
                targetLevel = math.max(1, math.min(targetLevel, #self.pos))
            end
            
            -- 检查pos[targetLevel]是否存在
            if not self.pos[targetLevel] then
                targetLevel = math.min(targetLevel, #self.pos)
            end
            
            self.scroll_pos = self.pos[targetLevel]
            self.bar.scrollbar.value = self.pos[targetLevel]
        end
    end)
end

--更新等级显示
--@param nowViewLevel 当前显示等级
--@param isRefresh 是否刷新
function LevelUpPanel:UpdateLevelView(nowViewLevel, isRefresh)
    if nowViewLevel == self.nowViewLevel and not isRefresh then
        return
    end
    self.nowViewLevel = nowViewLevel

    local nowLevel = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.role, self.nowViewLevel)
    --TODO: 计算到当前等级需要的经验值
    self.needExp = nowLevel.exp_sum - self.roleSeverData.exp
    self.needResBg:SetActive(self.needExp > 0)
    if self.hasExp < self.needExp then
        self.needResTxt.text.color = Color.red
    else
        self.needResTxt.text.color = Color.New(27/255, 138/255, 230/255)
    end

    self.needResTxt.text.text = "x"..self.needExp
    if self.nowViewLevel <= self.minLevel or self.nowViewLevel > self.userLevel then
        self.okBtn.scaleButton.interactable = false
    else
        self.okBtn.scaleButton.interactable = true
    end
    if self.nowViewLevel > self.userLevel then
        self.tipsBg:SetActive(true)
    else
        self.tipsBg:SetActive(false)
    end
end

-- 获取角色六维快照
function LevelUpPanel:GetAttrSnapshot(roleData)
    roleData = roleData or {}
    return {
        hp = tonumber(roleData.hp) or 0,
        bombard = tonumber(roleData.bombard) or 0,
        torpedo = tonumber(roleData.torpedo) or 0,
        armor = tonumber(roleData.armor) or 0,
        evade = tonumber(roleData.evade) or 0,
        airdefense = tonumber(roleData.airdefense) or 0,
        lucky = tonumber(roleData.lucky) or 0,
    }
end

-- 刷新六维显示（基础值 + 提升值）
function LevelUpPanel:RefreshAttrPanel(beforeAttrs, afterAttrs)
    local attrMap = {
        {key = "hp", txt = self.hpTxt, upTxt = self.hpUpTxt, upImg = self.hpImg and self.hpImg.upImg},
        {key = "bombard", txt = self.bombardTxt, upTxt = self.bombardUpTxt, upImg = self.bombardImg and self.bombardImg.upImg},
        {key = "torpedo", txt = self.torpedoTxt, upTxt = self.torpedoUpTxt, upImg = self.torpedoImg and self.torpedoImg.upImg},
        {key = "armor", txt = self.armorTxt, upTxt = self.armorUpTxt, upImg = self.armorImg and self.armorImg.upImg},
        {key = "evade", txt = self.evadeTxt, upTxt = self.evadeUpTxt, upImg = self.evadeImg and self.evadeImg.upImg},
        {key = "airdefense", txt = self.airdefenseTxt, upTxt = self.airdefenseUpTxt, upImg = self.airdefenseImg and self.airdefenseImg.upImg},
        {key = "lucky", txt = self.luckyTxt, upTxt = self.luckyUpTxt, upImg = self.luckyImg and self.luckyImg.upImg},
    }

    local beforeData = beforeAttrs or afterAttrs or {}
    local afterData = afterAttrs or beforeData
    local canShowUp = beforeAttrs ~= nil and afterAttrs ~= nil

    for i = 1, #attrMap do
        local item = attrMap[i]
        local beforeVal = tonumber(beforeData[item.key]) or 0
        local afterVal = tonumber(afterData[item.key]) or 0
        local delta = afterVal - beforeVal
        local isUp = canShowUp and delta > 0

        if item.txt and item.txt.text then
            item.txt.text.text = tostring(beforeVal)
        end
        if item.upTxt and item.upTxt.text then
            item.upTxt.text.text = isUp and ("+" .. tostring(delta)) or ""
        end
        if item.upTxt then
            item.upTxt:SetActive(isUp)
        end
        if item.upImg then
            item.upImg:SetActive(isUp)
        end
    end
end

--初始化显示
function LevelUpPanel:SetViewInfo()
    self.minLevel = self.roleSeverData.level
    self.canRun = false
    self:SetLevelUpList()
    self.levelTxt.text.text = self.roleSeverData.level
    self.levelShadowTxt.text.text = self.roleSeverData.level

    local expItem = Me:getItemById(110011)
    self.hasExp = expItem and expItem.num or 0
    self.resCount.text.text = self.hasExp
    local curAttrs = self:GetAttrSnapshot(self.roleSeverData)
    self:RefreshAttrPanel(curAttrs, nil)
    self:SetPostProcessing()
end

--设置相机的后处理
function LevelUpPanel:SetPostProcessing()
    --特效相关
    --local UICamera = UIMgr.uiCamera
    --
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true                      --后处理
    --    cameraData.volumeTrigger = self.uiVolume.transform          --特效触发器
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    --end
end

--递增等级文本
---@param targetLevel integer 目标等级
function LevelUpPanel:IncrementLevelText(targetLevel)
    local startLevel = tonumber(self.startLevel) or 0  -- 确保 startLevel 有一个默认值
    local endLevel = targetLevel
    local totalAnimTime = 1.8  -- effectLevelUp_2点亮的固定时刻（从调用起算），数字动画在此刻同步结束
    local startDelay = 0.85     -- 数字动画开始前的延迟
    local laterTime = 0
    if endLevel - startLevel == 1 then
        laterTime = 1.0
    end
    -- 反推tween时长，确保数字动画恰好在totalAnimTime时结束
    local tweenDuration = math.max(0.1, totalAnimTime - startDelay - laterTime)

    -- 数字动画结束后立即衔接第二段爆炸特效
    local function onNumberAnimComplete()
        if self.isBreak then
            return
        end
        self:PlayLevelUpBurstEffect()
    end

    if laterTime > 0 then
        if self.laterTimer then
            DLuaTimer:RemoveTimer(self.laterTimer)
        end
        self.laterTimer = DLuaTimer:DoAfter(startDelay + laterTime, function()
            if self.isBreak then
                return
            end
            if self.levelTween then
                self.levelTween:Kill()
            end
            self.levelTween = DOVirtual.Float(startLevel, endLevel, tweenDuration, function(value)
                if self.isBreak then
                    return
                end
                self.levelTxt.text.text = tostring(math.ceil(value))
                self.levelShadowTxt.text.text = tostring(math.ceil(value))
            end):SetEase(DG.Tweening.Ease.OutQuad):OnComplete(onNumberAnimComplete)
        end)
    else
        if self.levelTween then
            self.levelTween:Kill()
        end
        if self.laterTimer then
            DLuaTimer:RemoveTimer(self.laterTimer)
        end
        self.laterTimer = DLuaTimer:DoAfter(startDelay, function()
            if self.isBreak then
                return
            end
            self.levelTween = DOVirtual.Float(startLevel, endLevel, tweenDuration, function(value)
                if self.isBreak then
                    return
                end
                self.levelTxt.text.text = tostring(math.ceil(value))
                self.levelShadowTxt.text.text = tostring(math.ceil(value))
            end):SetEase(DG.Tweening.Ease.OutQuad):OnComplete(onNumberAnimComplete)
        end)
    end

    if self.effectTimer then
        DLuaTimer:RemoveTimer(self.effectTimer)
        self.effectTimer = nil
    end
end

-- 验证指定等级的索引是否有效
function LevelUpPanel:ValidateLevelIndex(level)
    if not level then
        return false
    end
    
    if level < 1 or level > #self.pos then
        return false
    end
    
    if not self.pos[level] then
        return false
    end
    
    return true
end

-- 查找当前可以升级的等级
function LevelUpPanel:FindNowCanUpLevel()
    local curLevel = self.roleSeverData.level
    local maxLevel = math.min(self.maxLevel, self.userLevel) -- 不能超过userLevel
    local curExp = self.roleSeverData.exp
    local hasExp = self.hasExp or 0

    -- 从当前等级+1开始尝试升级
    local targetLevel = curLevel + 1
    local lastCanUpLevel = curLevel

    while targetLevel <= maxLevel do
        local levelCfg = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.role, targetLevel)
        if not levelCfg then
            break
        end
        local needExp = levelCfg.exp_sum - curExp
        if hasExp < needExp then
            break
        end
        lastCanUpLevel = targetLevel
        targetLevel = targetLevel + 1
    end

    -- 如果没有可以升的，返回 curLevel+1（但不超过最大等级和userLevel）
    if lastCanUpLevel == curLevel then
        if curLevel + 1 > maxLevel then
            return maxLevel
        else
            return curLevel + 1
        end
    end

    return lastCanUpLevel
end

-- 刷新界面信息 
function LevelUpPanel:RefreshViewInfo(isEffect)
    self.roleSeverData = Me:getPlayerHero(self.roleId)
    local newLevel = self.roleSeverData.level
    local duration = 4.3  -- 递增效果的持续时间（秒）
    self.minLevel = self.roleSeverData.level
    self.isBreak = false
    local afterAttrs = self:GetAttrSnapshot(self.roleSeverData)
    --播放特效
    if isEffect then
        self.hasLevelUpInThisPanel = true
        self:RefreshAttrPanel(self.beforeLevelUpAttrs, afterAttrs)
        local btnSoundPath = string.format(Config.AudioPath.SE, "chara_levelup")
        self:play2DSound(btnSoundPath)
        self.canBlankClose = false
        self.isPlayingLevelUpEffect = true
        self.isBurstPlaying = false
        self.isEffectFinishing = false
        self.isClosingPanel = false
        self.burstSkipCanForceClose = false
        self.isLevelUpAnimSpeedUp = false
        self._breakEffectFrame = -1
        self.imgMask.button.interactable = true
        self.effectMask.button.interactable = true
        self.effectLoop:SetActive(false)
        self.effectLevelUp_1:SetActive(true)
        self.effectMask:SetActive(true)
        self.effectMask.canvasGroup:DOFade(1, 1)
        self.effectMask.canvasGroup.blocksRaycasts = true
        self:PlayUpMsgAnim()
        self:IncrementLevelText(newLevel, duration)
        
        -- 【关键修复】先保存目标等级，等UI重建完成后再设置位置
        self.targetLevelAfterRebuild = newLevel
    else
        self:RefreshAttrPanel(afterAttrs, nil)
        self.canBlankClose = true
        self.imgMask.button.interactable = true
    end
    self.beforeLevelUpAttrs = nil

    self:SetLevelUpList()
    
    -- 升级后的位置设置移到SetLevelUpList完成后执行（在DLuaTimer回调中）
    
    self:RefreshLevelObjList()
    if self.nowViewLevel then
        self:UpdateLevelView(self.nowViewLevel, true)
    else
        self:UpdateLevelView(newLevel, true)
    end

    local expItem = Me:getItemById(110011)
    self.hasExp = expItem and expItem.num or 0
    self.resCount.text.text = self.hasExp
end

--播放升级六维显示动画
function LevelUpPanel:PlayUpMsgAnim()
    self:ResetLevelUpAnimSpeed()
    self.animator:SetTrigger("LevelUp")
    self.animOverCallBack:SetCallBackOfName(function(name)
        if name ~= "UpMsg" then
            return
        end
        if self.isBreak then
            return
        end
        self:ResetLevelUpAnimSpeed()
        self.canBlankClose = true
        self.imgMask.button.interactable = true
    end)
end

-- 将 LevelUp 动画切到倍速
function LevelUpPanel:SpeedUpLevelUpAnim()
    if not self.animator or self.isLevelUpAnimSpeedUp then
        return
    end
    local speed = tonumber(self.levelUpAnimSpeed) or 3
    if speed < 1 then
        speed = 1
    end
    self.animator.speed = speed
    self.isLevelUpAnimSpeedUp = true
end

-- 恢复 LevelUp 动画正常速度
function LevelUpPanel:ResetLevelUpAnimSpeed()
    if self.animator then
        self.animator.speed = 1
    end
    self.isLevelUpAnimSpeedUp = false
end

-- 重播第二段爆炸特效（EffectLevelUp_2 预制体）
---@param onReady function|nil 真正点亮后的回调
function LevelUpPanel:ReplayEffectLevelUp2(onReady)
    self.effectLevelUp_1:SetActive(false)
    local effectObj = self.effectLevelUp_2
    if not effectObj then
        if onReady then
            onReady()
        end
        return
    end
    effectObj:SetActive(false)
    -- 等一帧再点亮，确保 ParticleSystem 重新 Play，且不占用可见时长
    DLuaTimer:DoAfter(0.01, function()
        if not UICommonUtils.Checkobj(effectObj) then
            return
        end
        effectObj:SetActive(true)
        local particles = effectObj:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem), true)
        for i = 1, particles.Length do
            local particle = particles[i - 1]
            particle:Clear(true)
            particle:Simulate(0, true, true)
            particle:Play(true)
        end
        if onReady then
            onReady()
        end
    end)
end

-- 播放第二段爆炸特效（EffectLevelUp_2），播完后自动收尾并关界面
---@param autoClose boolean 是否在爆炸后自动进入关闭流程
function LevelUpPanel:PlayLevelUpBurstEffect(autoClose)
    self.levelTxt.gameObject.transform:DOPunchScale(Vector3(0.1, 0.1, 0), 0.35, 1, 0.3)
    self.levelShadowTxt.gameObject.transform:DOPunchScale(Vector3(0.1, 0.1, 0), 0.35, 1, 0.3)
    self.isBurstPlaying = true
    self.burstSkipCanForceClose = false
    if self.effectLevelUpTimer_2 then
        DLuaTimer:RemoveTimer(self.effectLevelUpTimer_2)
        self.effectLevelUpTimer_2 = nil
    end
    if self.burstProtectTimer then
        DLuaTimer:RemoveTimer(self.burstProtectTimer)
        self.burstProtectTimer = nil
    end

    -- 跳过：可见窗口够长、又能再点加速关；正常播完：稍长
    local burstDuration = autoClose and (tonumber(self.burstEffectDuration) or 0.85) or 1.2
    local protectDuration = tonumber(self.burstSkipProtectDuration) or 0.4
    if protectDuration > burstDuration then
        protectDuration = burstDuration
    end

    self:ReplayEffectLevelUp2(function()
        if autoClose then
            -- 保护期内保证能看清爆炸，到期才允许再点抢先关界面
            self.burstProtectTimer = DLuaTimer:DoAfter(protectDuration, function()
                self.burstProtectTimer = nil
                self.burstSkipCanForceClose = true
            end)
        else
            self.burstSkipCanForceClose = true
        end
        self.effectLevelUpTimer_2 = DLuaTimer:DoAfter(burstDuration, function()
            self:FinishLevelUpEffect(autoClose == true)
        end)
    end)
end

-- 演出收尾：爆炸播完后切循环特效并收起遮罩
---@param autoClose boolean|nil 为 true 时收尾后立刻进入关界面流程
function LevelUpPanel:FinishLevelUpEffect(autoClose)
    if self.isEffectFinishing and not autoClose then
        return
    end
    self.isEffectFinishing = true
    self.isBreak = true
    self.isBurstPlaying = false
    self.burstSkipCanForceClose = false
    if self.effectLevelUpTimer_2 then
        DLuaTimer:RemoveTimer(self.effectLevelUpTimer_2)
        self.effectLevelUpTimer_2 = nil
    end
    if self.burstProtectTimer then
        DLuaTimer:RemoveTimer(self.burstProtectTimer)
        self.burstProtectTimer = nil
    end
    if self.effectLevelUp_2 then
        self.effectLevelUp_2:SetActive(false)
    end
    self.effectLoop:SetActive(true)
    self.effectMask.canvasGroup:DOKill()
    self.effectMask.canvasGroup.blocksRaycasts = false
    self.effectMask.canvasGroup:DOFade(0, 0.1):OnComplete(function()
        self.effectMask:SetActive(false)
        self.isPlayingLevelUpEffect = false
        self.isEffectFinishing = false
        self.canBlankClose = true
        self.imgMask.button.interactable = true
        if autoClose then
            self:closePanelFunc()
        end
    end)
end

-- 定格到最终详情（等级数字 + 六维），并展示第二段爆炸
function LevelUpPanel:SettleLevelUpResult()
    if self.levelTween then
        self.levelTween:Kill()
        self.levelTween = nil
    end
    if self.laterTimer then
        DLuaTimer:RemoveTimer(self.laterTimer)
        self.laterTimer = nil
    end
    if self.effectTimer then
        DLuaTimer:RemoveTimer(self.effectTimer)
        self.effectTimer = nil
    end

    self.levelTxt.gameObject.transform:DOKill()
    self.levelShadowTxt.gameObject.transform:DOKill()

    local finalLevel = self.roleSeverData and self.roleSeverData.level
    if finalLevel then
        self.levelTxt.text.text = tostring(finalLevel)
        self.levelShadowTxt.text.text = tostring(finalLevel)
    end

    self.effectLoop:SetActive(false)
    self.effectMask:SetActive(true)
    self.effectMask.canvasGroup:DOKill()
    self.effectMask.canvasGroup.alpha = 1
    self.effectMask.canvasGroup.blocksRaycasts = true

    if self.nowViewLevel then
        self:UpdateLevelView(self.nowViewLevel, true)
    end
end

-- 中断升级演出：马上爆一下 + 定格详情，随后自动进入关界面
function LevelUpPanel:BreakLevelUpEffect()
    if not self.isPlayingLevelUpEffect or self.isClosingPanel then
        return
    end

    local frame = Time.frameCount
    if self._breakEffectFrame == frame then
        return
    end
    self._breakEffectFrame = frame

    -- 已在爆炸中：保护期内吞掉点击，保证看清；保护期后再点可立刻关
    if self.isBurstPlaying then
        if self.burstSkipCanForceClose then
            self:play2DSound(self.btnSoundPath)
            self:FinishLevelUpEffect(true)
        end
        return
    end
    if self.isEffectFinishing then
        if self.burstSkipCanForceClose then
            self:play2DSound(self.btnSoundPath)
            self:closePanelFunc()
        end
        return
    end
    if self.isBreak then
        return
    end

    self:play2DSound(self.btnSoundPath)
    self.isBreak = true
    self.canBlankClose = false
    -- 点击后 LevelUp（六维展开）按倍速播完，同时定格详情并接爆炸
    self:SpeedUpLevelUpAnim()
    self:SettleLevelUpResult()
    self:PlayLevelUpBurstEffect(true)
end

--界面关闭
function LevelUpPanel:closePanelFunc()
    if self.isClosingPanel then
        return
    end
    self.isClosingPanel = true
    self.isPlayingLevelUpEffect = false
    self:ResetLevelUpAnimSpeed()
    self.cancelBtn.scaleButton.interactable = false
    self.imgMask.button.interactable = false
    local outAnimName = self.hasLevelUpInThisPanel and "OutMsg" or "Out"
    self.animator:SetTrigger(outAnimName)
    self.animOverCallBack:SetCallBackOfName(function(name)
        if name ~= outAnimName then
            return
        end
        UIMgr:closeCurrentUI(self)
        self.imgMask.button.interactable = true
        self.cancelBtn.scaleButton.interactable = true
        GuideMgr:StartGuideTrigger()
    end)
end

--function LevelUpPanel:OnClose(initiative)
--
--end

function LevelUpPanel:OnDestroy()
    self:ResetLevelUpAnimSpeed()
    if self.effectTimer then
        DLuaTimer:RemoveTimer(self.effectTimer)
    end
    if self.laterTimer then
        DLuaTimer:RemoveTimer(self.laterTimer)
    end
    if self.effectLevelUpTimer_2 then
        DLuaTimer:RemoveTimer(self.effectLevelUpTimer_2)
    end
    if self.burstProtectTimer then
        DLuaTimer:RemoveTimer(self.burstProtectTimer)
    end
    self.super:OnDestroy(self)
end

--function LevelUpPanel:OnRefresh(data)
--
--end

--[[ 
/ImgBg/OkBtn onClick 
--]]
function LevelUpPanel:okBtn_ScaleButton_onClick(okBtn)
    self:play2DSound(self.btnSoundPath)
    
    if self.nowViewLevel == nil then
        return
    end

    if self.nowViewLevel <= self.minLevel then
        UICommonUtils.PopToast("角色已达到该等级")
        return
    end
    
    if self.nowViewLevel > self.userLevel then
        UICommonUtils.PopToast("超过指挥官等级")
        return
    end

    if self.hasExp < self.needExp then
        UICommonUtils.PopToast("经验值不足")
        return
    end

    -- 检测是否正在拖拽，强制结束拖拽状态
    if self.isDrag then
        self.isDrag = false
    end
    
    -- 验证目标等级索引是否有效
    if not self:ValidateLevelIndex(self.nowViewLevel) then
        UICommonUtils.PopToast("系统错误，请重试")
        return
    end

    self.isDrag = false
    self.scroll_pos = self.pos[self.nowViewLevel]
    self.bar.scrollbar.value = self.pos[self.nowViewLevel]

    self.beforeLevelUpAttrs = self:GetAttrSnapshot(self.roleSeverData)
    self.startLevel = self.roleSeverData.level
    Me:roleLevelUpReq({id = self.roleId, upLevel = self.nowViewLevel}, function()
        self:RefreshViewInfo(true)
        GameMsgMgr:sendEvent(GameMsgType.HeroLevelUp)
    end)
end

--[[
/ImgBg/CancelBtn onClick 
--]]
function LevelUpPanel:cancelBtn_ScaleButton_onClick(cancelBtn)
    self:play2DSound(self.btnSoundPath)
    if self.isPlayingLevelUpEffect then
        self:BreakLevelUpEffect()
        return
    end
    self:closePanelFunc()
end

--[[
/ImgBg/Scroll View/bar onValueChanged 
--]]
function LevelUpPanel:bar_Scrollbar_onValueChanged(bar,value)
    self:play2DSound(self.btnSoundPath)
end

--[[
/LevelBox onClick 
--]]
function LevelUpPanel:levelBox_ScaleButton_onClick(levelBox)
    self:play2DSound(self.btnSoundPath)
end

--[[
/ImgMask onClick 
--]]
function LevelUpPanel:imgMask_Button_onClick(imgMask)
    if self.isPlayingLevelUpEffect then
        self:BreakLevelUpEffect()
        return
    end
    if not self.canBlankClose or self.isClosingPanel then
        return
    end
    self:play2DSound(self.btnSoundPath)
    self:closePanelFunc()
end

--[[
/ImgBg/EffectPanel/EffectMask onClick 
--]]
function LevelUpPanel:effectMask_Button_onClick(effectMask)
    self:BreakLevelUpEffect()
end

return LevelUpPanel
