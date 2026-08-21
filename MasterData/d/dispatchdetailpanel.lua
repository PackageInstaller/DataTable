---@class DispatchDetailPanel : DispatchDetailPanel_Generate
---##################### 【DispatchDetailPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【DispatchDetailPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local DispatchDetailPanel = require "DispatchDetailPanel_Generate"
local sel = require("client.Main.Assets.Content.Lua.UI.Common.TechTreeNode").sel
local new = require("common.script.Battle.Manager.BattleRoleManager").new

function DispatchDetailPanel:InitLogic(data)
    ---@type DispatchTaskInfo
    self.dispatchTaskInfo = nil  --派遣中的任务数据
    self.inDispatch = false --是否在派遣中
    ---@type HeroInfo[]
    self.heroInfoList = nil --可以派遣的角色列表
    self.shipPosIndex = 0 --船只位置索引
end

--function DispatchDetailPanel:StartCreating(time)
--
--end

--function DispatchDetailPanel:StartEnter(time)
--
--end

--function DispatchDetailPanel:StartRemoving(time)
--
--end

--function DispatchDetailPanel:StartExit(time)
--
--end

function DispatchDetailPanel:OnOpen(data, initiative)
    self.main.canvasGroup.interactable = false
    self.main.canvasGroup.alpha = 0
    self.main.transform.localScale = Vector3.New(1.1, 1.1, 1)
    self.shipPosIndex = 0
    self.dispatchId = data.id
    self:initData()
    if initiative then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.DispatchPanel, self)
        -- self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        --     UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
        --     UIMgr:closeSpecificUI(self)
        --     self.customBackPanel.customBackPanel:ClearBackFunc()
        --     --end)
        -- end)
        self:bindRoleIconList()
    end
    self:refreshUI()
    self:doOpenAni()
end

function DispatchDetailPanel:doOpenAni()
    local seq = DG.Tweening.DOTween.Sequence()
    seq:Append(self.main.canvasGroup:DOFade(1, 0.3):SetEase(DG.Tweening.Ease.InQuad):OnComplete(function()
        self.main.canvasGroup.interactable = true
        GuideMgr:StartGuideTrigger("DispatchDetailPanel")
    end))
    seq:Join(self.main.transform:DOScale(1, 0.5):SetEase(DG.Tweening.Ease.InQuad))
end

function DispatchDetailPanel:initData()
    self.chapterData = Config.GetDispatchInfo(self.dispatchId)
    self.dispatchTaskInfo = Me:getDispatchTaskDataById(self.dispatchId)
    if not self.dispatchTaskInfo then
        self.inDispatch = false
    else
        self.inDispatch = true
    end
    self.page2PointList = {}
    --飞行动效
    self.flyEfObjList = {}
    --timer
    self.timerList = {}

    self.tweenList = {}

    self.rewardList = {}
end

function DispatchDetailPanel:refreshUI()
    if self.inDispatch then
        self.page1:SetActive(false)
        self.page2:SetActive(true)
        self:showRewardEmpey()
        self:refreshPage2()
        self:refreshPage2Map()
    else
        self.page1:SetActive(true)
        self.page2:SetActive(false)

        self.page1TabIndex = 1
        self.waitDispatchRoleList = {} --等待派遣的角色列表
        self:refreshPage1()
    end
end

function DispatchDetailPanel:refreshPage1()
    self.page1.detailBg:SetActive(false)
    self.pointBoxHideBtn:SetActive(false)
    if not self.chapterData then
        return
    end
    self:FillTemplateContent(self.routeNode, self.routeList, tablex.size(self.chapterData.lineGroup), function (index, itemObj)
        itemObj.sel:SetActive(self.page1TabIndex == index)
        itemObj.index.text.text = index
        itemObj.mark:SetActive(Me:dispatchRouteIsFinish(self.chapterData.lineGroup[index]))

        if self.page1TabIndex == index then
            local costTimeList = self.chapterData.costTime[index] or {}
            local useTime = 0
            for _, t in ipairs(costTimeList) do
                useTime = useTime + t
            end
            local function formatNum(num)
                -- 第一步：先格式化为保留两位小数的字符串（处理核心精度）
                local formatted = string.format("%.2f", num)
                -- 第二步：去除末尾的0（正则匹配末尾的0并替换为空）
                formatted = string.gsub(formatted, "0+$", "")
                -- 第三步：如果末尾是小数点，去除小数点
                formatted = string.gsub(formatted, "%.$", "")
                return formatted
            end
            self.costTime.text.text = string.format("耗时：%s小时", formatNum(useTime / 3600))
            
        end
        itemObj.scaleButton.onClick:RemoveAllListeners()
        itemObj.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            if self.page1TabIndex ~= index then
                self.page1TabIndex = index
                self.waitDispatchRoleList = {} --等待派遣的角色列表
                self:refreshPage1()
            end
        end)
    end)
    
    self.curline = self.chapterData.lineGroup[self.page1TabIndex]
    self.curPoint = self.chapterData.pointGroup[self.page1TabIndex]
    self.lineCfg = Config.GetDispatchLineByGroup(self.curline)
    self.pointCfg = Config.GetDispatchPointByGroup(self.curPoint)
    self.heroInfoList = Me:getCanDispatchRoleList()
    self:sortHeroInfoList(self.heroInfoList)
    self.fightRecommendNum.text.text = self.lineCfg[1].recommendPower 
    self:refreshPage1Map()
    self:refreshRoleIconList()
    self:refreshWaitRoleList()
    self:refreshBtnState()
    self:refreshFightNum(self.waitDispatchRoleList)
    self:refreshLineReward()
    self:refreshAddCondition()
end

function DispatchDetailPanel:sortHeroInfoList(list)
    if not self.chapterData then
        return
    end
    local suggestHp = Me:getDispatchSuggestHp(self.dispatchId, self.curline)
    local condition = self.chapterData.extraCondition[self.page1TabIndex] or {}
    table.sort(list, function(aHeroData, bHeroData)
        local aAboveSuggest = aHeroData.energy > suggestHp
        local bAboveSuggest = bHeroData.energy > suggestHp
        if aAboveSuggest ~= bAboveSuggest then
            return aAboveSuggest
        end

        local aRoleConfig = Config.GetCharacterInfo(aHeroData.id)
        local bRoleConfig = Config.GetCharacterInfo(bHeroData.id)
        local aMul = 1
        local bMul = 1
        if aRoleConfig then
            local aShipType = math.floor(aRoleConfig.attribute / 10)
            for _, cType in pairs(condition) do
                if cType == aShipType then
                    aMul = Config.GetConfigInfo("DispatchMagnification")
                end
            end
        end
        if bRoleConfig then
            local bShipType = math.floor(bRoleConfig.attribute / 10)
            for _, cType in pairs(condition) do
                if cType == bShipType then
                    bMul = Config.GetConfigInfo("DispatchMagnification")
                end
            end
        end
        if aHeroData.allDmg * aMul ~= bHeroData.allDmg * bMul then
            return aHeroData.allDmg * aMul > bHeroData.allDmg * bMul
        end
        return aHeroData.id < bHeroData.id
    end)
end

function DispatchDetailPanel:refreshPage1Map()
    if not self.lineCfg or not self.pointCfg then
        return
    end
    local isFinish = Me:dispatchRouteIsFinish(self.curline)
    local pointCount = tablex.size(self.pointCfg)
    self:FillTemplateContent(self.pointNode, self.page1.map.pointRoot, pointCount, function (index, itemObj)
        local curCfg = self.pointCfg[index]
        local isEnd = index == pointCount
        itemObj.normal:SetActive(not isEnd)
        itemObj.endLabel:SetActive(isEnd)
        itemObj.start:SetActive(index == 1)
        itemObj.clear:SetActive(false)
        itemObj.fail:SetActive(false)
        itemObj.indexName.text.text = string.char(index - 1 + 64)
        itemObj.indexName.transform.localPosition = Vector3.New(curCfg.letterLocation[1], curCfg.letterLocation[2], 0)
        itemObj.indexName:SetActive(index ~= 1)
        itemObj.transform.localPosition = Vector3.New(curCfg.coordinate[1], curCfg.coordinate[2], 0)
        itemObj.scaleButton.onClick:RemoveAllListeners()
        itemObj.scaleButton.onClick:AddListener(function()
            if index == 1 then
                return
            end
            self.pointBoxHideBtn:SetActive(true)
            self:showPointBox(curCfg, isFinish, itemObj)
        end)
    end)
    local typeCount = self.lineNode.transform.childCount
    self:FillTemplateContent(self.lineNode, self.page1.map.lineRoot, tablex.size(self.lineCfg), function (index, itemObj)
        local curCfg = self.lineCfg[index]
        local line = nil
        for i = 1, typeCount do
            if i == curCfg.type then
                line = itemObj["line" .. i]
                itemObj["line" .. i].gameObject:SetActive(true)
            else
                itemObj["line" .. i].gameObject:SetActive(false)
            end
        end
        line.transform.localPosition = Vector3.New(curCfg.coordinate[1], curCfg.coordinate[2], 0)
        line.transform.localRotation = Quaternion.Euler(0, 0, curCfg.angle)
    end)
end

function DispatchDetailPanel:showPointBox(pointCfg, isFinish, target)
    local UICamera = UIMgr.uiCamera
    local screenPos = UICamera:WorldToScreenPoint(target.transform.position)
    local localPos = UICommonUtils.ScreenToUILocalPos(self.pointBoxHideBtn.transform, UICamera, screenPos)
    localPos.y = localPos.y - self.pointBoxRoot.rectTransform.sizeDelta.y / 3 * 2
    self.pointBoxRoot.transform.localPosition = localPos
    if not isFinish then
        self.pointBoxRoot.type1:SetActive(true)
        self.pointBoxRoot.type2:SetActive(false)
        self.pointBoxRoot.enemyBox1.isHas:SetActive(false)
        self.pointBoxRoot.enemyBox1.isNo:SetActive(true)
        self.pointBoxRoot.enemyBox2.isHas:SetActive(false)
        self.pointBoxRoot.enemyBox2.isNo:SetActive(true)
    else
        self.pointBoxRoot.type1:SetActive(false)
        self.pointBoxRoot.type2:SetActive(true)
        self.pointBoxRoot.enemyBox1.isHas:SetActive(true)
        self.pointBoxRoot.enemyBox1.isNo:SetActive(false)
        self.pointBoxRoot.enemyBox2.isHas:SetActive(true)
        self.pointBoxRoot.enemyBox2.isNo:SetActive(false)

        self.pointBoxRoot.enemyBox1.isSelect:SetActive(false)
        self.pointBoxRoot.enemyBox2.isSelect:SetActive(false)
        local monsterCfg = Config.GetMonsterInfo(pointCfg.monster)
        if not monsterCfg then
            LuaLogger.e("DispatchBattlePanel:initUI monsterCfg is nil")
            return
        end
        local skinConfig = Config.GetCharacterSkinInfo(monsterCfg.baseSkinID) or {}
        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end
        self:LoadSpriteAsync(string.format(Config.SpritePath.EnemyFrameIconPath, monsterCfg.rank), function (s)
            self.pointBoxRoot.enemyBox1.frameImg.image.sprite = s
            self.pointBoxRoot.enemyBox1.frameImg:SetActive(true)
            self.pointBoxRoot.enemyBox2.frameImg.image.sprite = s
            self.pointBoxRoot.enemyBox2.frameImg:SetActive(true)
        end)
        local headIconPath = string.format(Config.SpritePath.IconRolePath, resourceFolder, skinConfig.driverKey)
        self:LoadSpriteAsync(headIconPath, function (s)
            self.pointBoxRoot.enemyBox1.enemyIconImg.image.sprite = s
            self.pointBoxRoot.enemyBox1.enemyIconImg:SetActive(true)
            self.pointBoxRoot.enemyBox2.enemyIconImg.image.sprite = s
            self.pointBoxRoot.enemyBox2.enemyIconImg:SetActive(true)
        end)
        self:LoadSpriteAsync(string.format(Config.SpritePath.RoleTypeIconPath, monsterCfg.attribute), function (s)
            self.pointBoxRoot.enemyBox1.typeIcon.image.sprite = s
            self.pointBoxRoot.enemyBox1.typeIcon:SetActive(true)
            self.pointBoxRoot.enemyBox2.typeIcon.image.sprite = s
            self.pointBoxRoot.enemyBox2.typeIcon:SetActive(true)
        end)
        self.pointBoxRoot.enemyBox1.titleBgRed:SetActive(monsterCfg.rank == 3)
        self.pointBoxRoot.enemyBox1.titleBgOrange:SetActive(monsterCfg.rank == 2)
        self.pointBoxRoot.enemyBox1.titleNameTxt:SetActive(monsterCfg.rank ~= 1)

        self.pointBoxRoot.enemyBox2.titleBgRed:SetActive(monsterCfg.rank == 3)
        self.pointBoxRoot.enemyBox2.titleBgOrange:SetActive(monsterCfg.rank == 2)
        self.pointBoxRoot.enemyBox2.titleNameTxt:SetActive(monsterCfg.rank ~= 1)
        if monsterCfg.rank == 2 then
            self.pointBoxRoot.enemyBox1.titleNameTxt.text.text = "精英"
            self.pointBoxRoot.enemyBox2.titleNameTxt.text.text = "精英"
        elseif monsterCfg.rank == 3 then
            self.pointBoxRoot.enemyBox1.titleNameTxt.text.text = "首领"
            self.pointBoxRoot.enemyBox2.titleNameTxt.text.text = "首领"
        end
        self.pointBoxRoot.type2.num.text.text = pointCfg.powerPoint

        self:FillTemplateContent(self.customBox, self.pointBoxRoot.type2.root, tablex.size(pointCfg.awardPreview), function (index, itemObj)
            itemObj.transform.localScale = Vector3.New(0.55,0.55,1)
            local rewardData = pointCfg.awardPreview[index]
            if not rewardData then
                return
            end
            --[[local data = {
                id = rewardData[2],
                itemType = GE.ItemTypeIndex.item,
                itemNum = rewardData[3],
				navType = GE.NavigationType.DispatchPanel,
            }]]
            itemObj.customBox:setMono(self)
            itemObj.customBox:SetUIData(rewardData, {navType = GE.NavigationType.DispatchPanel})
        end)
    end
end

function DispatchDetailPanel:bindRoleIconList()
    self.roleIconList.loopListView2:InitListView(tablex.size(self.heroInfoList), function(listView, index)
        local loopListViewItem2 = listView:GetShownItemByItemIndex(index)
        if loopListViewItem2 == nil then
            loopListViewItem2 = listView:NewListViewItem("RoleHeadBox")
        end
        local itemObj = loopListViewItem2.gameObject
        EngineUtil.FillPeer(self.roleHeadBox, itemObj)
        local heroInfo = self.heroInfoList[index + 1]
        local isFull = self:waitDisaptchIsFull()
        local isInWaitList = self:roleInWaitList(heroInfo.id)
        local condition = self.chapterData.extraCondition[self.page1TabIndex] or {}
        local roleConfig = Config.GetCharacterInfo(heroInfo.id)
        local shipType = math.floor(roleConfig.attribute / 10)
        local mul = 1
        for _, cType in pairs(condition) do
            if cType == shipType then
                mul = Config.GetConfigInfo("DispatchMagnification")
            end
        end
        ---@type RoleHeadBoxData
        local temp = {
            roleId = heroInfo.id,
            showEnergy = true, --体力显示
            showBattlePoint = true, --战斗力显示
            battlePointMul = mul, --战斗力加成倍率
            isDeployed = isInWaitList, --是否在派遣列表中
            isGray = isFull and not isInWaitList, --满员状态下，非列表中的角色灰色
            existSingnalUp = Me:getDispatchSignal(heroInfo.id) ~= nil,

            clickFunc = function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                --未满员状态，点击上，点击下
                --满员状态下，不在列表的（黑色遮罩）无法点击
                if isInWaitList then
                    --在列表中，点击下
                    self:removeRoleFromWaitList(heroInfo.id)
                    self:refreshRoleIconList()
                    self:refreshWaitRoleList()
                    self:refreshBtnState()
                    self:refreshAddCondition()
                else
                    --不在列表中，点击上
                    if not self:waitDisaptchIsFull() then
                        table.insert(self.waitDispatchRoleList, heroInfo.id)
                        self:refreshRoleIconList()
                        self:refreshWaitRoleList()
                        self:refreshBtnState()
                        self:refreshAddCondition()
                    end
                end
                self:refreshFightNum(self.waitDispatchRoleList)
            end
        }
        ---@type RoleHeadBox
        local roleHeadBox = itemObj.roleHeadBox
        roleHeadBox:setMono(self)
        roleHeadBox:refreshUI(temp)
        return loopListViewItem2
    end)
end

--刷新下方角色头像列表
function DispatchDetailPanel:refreshRoleIconList()
    self.roleIconList.loopListView2:SetListItemCount(tablex.size(self.heroInfoList))
    self.roleIconList.loopListView2:RefreshAllShownItem2()
end

--刷新小组战斗力
function DispatchDetailPanel:refreshFightNum(roleIdList)
    if not self.chapterData then
        return
    end
    local condition = self.chapterData.extraCondition[self.page1TabIndex] or {}
    local num = 0
    for _, v in pairs(roleIdList) do
        local roleData = Me:getPlayerHero(v)
        local roleConfig = Config.GetCharacterInfo(v)
        if roleData and roleConfig then
            local shipType = math.floor(roleConfig.attribute / 10)
            local mul = 1
            for _, cType in pairs(condition) do
                if cType == shipType then
                    mul = Config.GetConfigInfo("DispatchMagnification")
                end
            end
            num = num + roleData.allDmg * mul
        end
    end
    self.isFightEnough = num >= self.lineCfg[1].recommendPower / 2 and true or false
    self.fightNum.text.text = math.floor(num)
end

--刷新路线奖励预览
function DispatchDetailPanel:refreshLineReward()
    if not self.pointCfg then
        return
    end
    local showReward = {}
    for _, cfg in pairs(self.pointCfg) do
        local awardPreview = cfg.awardPreview or {}
        for _, reward in pairs(awardPreview) do
            local exists = false
            for _, show in pairs(showReward) do
                if show[2] == reward[2] then
                    exists = true
                    break
                end
            end
            if not exists then
                table.insert(showReward, reward)
            end
        end
    end
    self:FillTemplateContent(self.customBox, self.selectList, tablex.size(showReward), function (index, itemObj)
        itemObj.transform.localScale = Vector3.New(0.5,0.5,1)
        local rewardData = showReward[index]
        if not rewardData then
            return
        end
        itemObj.customBox:setMono(self)
        itemObj.customBox:SetUIData(rewardData, {navType = GE.NavigationType.DispatchPanel})
    end)
end

--刷新附加条件加成
function DispatchDetailPanel:refreshAddCondition()
    local addConditionData = self:getAddConditionData(self.waitDispatchRoleList)
    if not addConditionData then
        return
    end
    local count = 0
    for i = 1, 3 do
        if addConditionData[i] then
            self.addCondition["c" .. i]:SetActive(true)
            self.addCondition["c" .. i].text1.text.text = addConditionData[i].desc
            self.addCondition["c" .. i].text2.text.text = addConditionData[i].desc
            --self.addCondition["c" .. i].text2:SetActive(addConditionData[i].isMeet)
            self.addCondition["c" .. i].text2:SetActive(true)
            count = count + 1
        else
            self.addCondition["c" .. i]:SetActive(false)
        end
    end
    local x, length = 0, 0
    if count == 3 then
        x = -21
        length = 574
    elseif count == 2 then
        x = -80
        length = 455
    else
        x = -132
        length = 352
    end
    self.addCondition.bg.rectTransform.sizeDelta = Vector2.New(length, self.addCondition.bg.rectTransform.sizeDelta.y)
    self.addCondition.bg.transform.localPosition = Vector3.New(x, self.addCondition.bg.transform.localPosition.y, 0)
end

--刷新等待派遣的角色列表
function DispatchDetailPanel:refreshWaitRoleList()
    if not self.chapterData then
        return
    end
    self.roleHpEnough = true
    self:FillTemplateContent(self.roleNode, self.page1.waitRoleList, 5, function (index, itemObj)
        itemObj.scaleButton.onClick:RemoveAllListeners()
        if index > self.chapterData.characterNum then
            itemObj.icon:SetActive(false)
            itemObj.empty:SetActive(false)
            return
        end
        local roleId = self.waitDispatchRoleList[index]
        if not roleId then
            itemObj.icon:SetActive(false)
            itemObj.empty:SetActive(true)
            return
        end
        local roleData = Me:getPlayerHero(roleId)
        if not roleData then
            return
        end
        itemObj.icon:SetActive(true)
        itemObj.empty:SetActive(false)
        local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)

        local roleConfig = Config.GetCharacterInfo(roleId)
        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end

        local iconPath = string.format(Config.SpritePath.BannerRolePath, resourceFolder, skinConfig.driverKey)
        self:LoadSpriteAsync(iconPath, itemObj.icon.image)
        local typeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
        self:LoadSpriteAsync(typeIconPath, itemObj.type.image)

        local index, color = Me:getDispatchEnergyIndexAndColor(roleData.energy)
        for i = 1, 3 do
            if i == index then
                itemObj["hpIcon"..i].gameObject:SetActive(true)
            else
                itemObj["hpIcon"..i].gameObject:SetActive(false)
            end
        end
        if roleData.energy < 50 then
            self.roleHpEnough = false
        end
        itemObj.hpText.text.text = string.format("<color=#%s>%s</color>/100", color, roleData.energy)
        itemObj.hpProgress.image.fillAmount = roleData.energy / 100
        itemObj.hpProgress.image.color = Color.NewFromStr(color)
        local signalList = Me:getDispatchSignal(roleId)
        if not signalList then
            itemObj.signal:SetActive(false)
        else
            itemObj.signal:SetActive(true)
            if signalList[1].effect[1] == GE.TagEffectType.dispatchBattlePointUp then
                itemObj.signal.s1:SetActive(false)
                itemObj.signal.s2:SetActive(true)
            elseif signalList[1].effect[1] == GE.TagEffectType.dispatchHpReduce then
                itemObj.signal.s1:SetActive(true)
                itemObj.signal.s2:SetActive(false)
            end
        end

        itemObj.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            --点击下，移除角色
            self:removeRoleFromWaitList(roleId)
            self:refreshRoleIconList()
            self:refreshWaitRoleList()
            self:refreshBtnState()
            self:refreshAddCondition()
            self:refreshFightNum(self.waitDispatchRoleList)
        end)
    end)
end

function DispatchDetailPanel:refreshBtnState()
    if not self.waitDispatchRoleList or tablex.size(self.waitDispatchRoleList) <= 0 then
        self.dispatchBtn.gray:SetActive(true)
        self.autoBtn.normal:SetActive(true)
        self.autoBtn.gray:SetActive(false)
    else
        self.dispatchBtn.gray:SetActive(false)
        if tablex.size(self.waitDispatchRoleList) < self.chapterData.characterNum then
            self.autoBtn.normal:SetActive(true)
            self.autoBtn.gray:SetActive(false)
        else
            self.autoBtn.normal:SetActive(false)
            self.autoBtn.gray:SetActive(true)
        end
    end
end

--待派遣列表是否已满
---@return boolean
function DispatchDetailPanel:waitDisaptchIsFull()
    if not self.chapterData then
        return false
    end
    return tablex.size(self.waitDispatchRoleList) >= self.chapterData.characterNum
end

---角色是否在等待派遣列表中
---@param roleId number
---@return boolean
function DispatchDetailPanel:roleInWaitList(roleId)
    if not self.waitDispatchRoleList then
        return false
    end
    for _, id in ipairs(self.waitDispatchRoleList) do
        if id == roleId then
            return true
        end
    end
    return false
end

function DispatchDetailPanel:removeRoleFromWaitList(roleId)
    if not self.waitDispatchRoleList then
        return
    end
    for i, id in ipairs(self.waitDispatchRoleList) do
        if id == roleId then
            table.remove(self.waitDispatchRoleList, i)
            return true
        end
    end
    return false
end

function DispatchDetailPanel:refreshPage2()
    local remainTime = self.dispatchTaskInfo.finishTime - EngineUtil.ServerTime_Seconds()
    self.curline = self.dispatchTaskInfo.lineId
    self.lineCfg = Config.GetDispatchLineByGroup(self.curline)
    self.pointCfg = Me:getDispatchPointCfgList(self.dispatchId,self.curline)
    if not self.lineCfg or not self.pointCfg then
        return
    end
    self.fightRecommendNum.text.text = self.lineCfg[1].recommendPower
    self:refreshFightNum(self.dispatchTaskInfo.roleIdList)
    self:setCountDownText(remainTime)
    self.page2.inprogressLab:SetActive(true)
    self.page2.endLab:SetActive(false)
    
    if remainTime <= 0 then
        self.page2.inprogressLab:SetActive(false)
        self.page2.endLab:SetActive(true)
        self.page2.disposeLable:SetActive(false)
        self.page2.settleBtn:SetActive(true)
        self.page2.endLab.fail:SetActive(not Me:getDispatchIsWin(self.dispatchId))
        self.page2.endLab.sec:SetActive(Me:getDispatchIsWin(self.dispatchId))
        self:bindSettleBtn()
    else
        self.page2.disposeLable:SetActive(true)
        self.page2.settleBtn:SetActive(false)
        if self.countDownTimer then
            DLuaTimer:RemoveTimer(self.countDownTimer)
        end
        self.countDownTimer = DLuaTimer:DoRepeatForever(1, function()
            remainTime = self.dispatchTaskInfo.finishTime - EngineUtil.ServerTime_Seconds()
            self:setCountDownText(remainTime)
            if remainTime <= 0 then
                if self.countDownTimer then
                    DLuaTimer:RemoveTimer(self.countDownTimer)
                end
                self.countDownTimer = nil
                self:refreshPage2()
            end
        end)
    end
end
function DispatchDetailPanel:refreshPage2Map()
    if not self.lineCfg or not self.pointCfg then
        return
    end
    local pointInfo = self.dispatchTaskInfo.pointInfo
    if not pointInfo then
        LuaLogger.e("DispatchDetailPanel:refreshPage2Map pointInfo is nil")
        return
    end

    if self.mapRefreshTimer then
        DLuaTimer:RemoveTimer(self.mapRefreshTimer)
        self.mapRefreshTimer = nil
    end

    local function getReachedPointIndex(curTime)
        for i = tablex.size(pointInfo), 1, -1 do
            if pointInfo[i] and pointInfo[i].showTime <= curTime then
                return i
            end
        end
        return 1
    end

    local function refreshMapShow(showIndex)
        self:updateShip(showIndex)
        self:refreshSendRoleList(showIndex)
        self:updatePointAndLine(showIndex)
    end

    local function startMapRefreshTimer(showIndex)
        if self.mapRefreshTimer then
            DLuaTimer:RemoveTimer(self.mapRefreshTimer)
        end
        self.mapRefreshTimer = DLuaTimer:DoRepeatForever(1, function()
            local reachedIndex = getReachedPointIndex(EngineUtil.ServerTime_Seconds())
            if reachedIndex > self.shipPosIndex then
                self.shipPosIndex = reachedIndex
                showIndex = showIndex + 1
                refreshMapShow(showIndex)
            end
        end)
    end

    self.shipPosIndex = getReachedPointIndex(EngineUtil.ServerTime_Seconds())
    local showIndex = 1
    refreshMapShow(showIndex)
    if self.shipPosIndex <= 1 then
        startMapRefreshTimer(showIndex)
        return
    end

    local timer = DLuaTimer:DoRepeat(1.5, self.shipPosIndex - 1, function()
        showIndex = showIndex + 1
        refreshMapShow(showIndex)
        if showIndex >= self.shipPosIndex then
            startMapRefreshTimer(showIndex)
        end
    end)
    table.insert(self.timerList, timer)
end

-- function DispatchDetailPanel:startMapFresh()
    
-- end

function DispatchDetailPanel:updatePointAndLine(showIndex, immediate)
    --LuaLogger.e("DispatchDetailPanel:updatePointAndLine ".. "showIndex ".. tostring(showIndex))
    self.page2PointList = {}
    local pointCount = tablex.size(self.pointCfg)
    self:FillTemplateContent(self.pointNode, self.page2.map.pointRoot, pointCount, function (index, itemObj)
        local curCfg = self.pointCfg[index]
        local isEnd = index == pointCount
        self.page2PointList[index] = itemObj
        itemObj.indexName.text.text = string.char(index - 1 + 64)
        itemObj.indexName.transform.localPosition = Vector3.New(curCfg.letterLocation[1], curCfg.letterLocation[2], 0)
        itemObj.indexName:SetActive(index ~= 1)
        itemObj.transform.localPosition = Vector3.New(curCfg.coordinate[1], curCfg.coordinate[2], 0)
        itemObj.scaleButton.onClick:RemoveAllListeners()
        itemObj.normal:SetActive(not isEnd)
        itemObj.endLabel:SetActive(isEnd)
        itemObj.ef:SetActive(false)

        if index == 1 then
            itemObj.start:SetActive(true)
            itemObj.clear:SetActive(false)
            itemObj.fail:SetActive(false)
        else    
            itemObj.start:SetActive(false)
            if index <= showIndex then
                --已经到达的点
                itemObj.fail:SetActive(false)
                local curPointInfo = self.dispatchTaskInfo.pointInfo[index]
                if curPointInfo and curPointInfo.endEnergy then
                    local endEnergy = curPointInfo.endEnergy
                    local isClear = false
                    for _, energy in ipairs(endEnergy) do
                        if energy > 0 then
                            isClear = true
                            break
                        end
                    end
                    itemObj.clear:SetActive(isClear)
                    itemObj.fail:SetActive(not isClear)
                    if isClear or index == showIndex then
                        self:refreshRewardList(showIndex, immediate)
                    end
                else
                    itemObj.clear:SetActive(false)
                    itemObj.fail:SetActive(false)
                end
            else
                --未到达的点
                itemObj.clear:SetActive(false)
                itemObj.fail:SetActive(false)
            end
            itemObj.scaleButton.onClick:AddListener(function()
                self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
                if self.dispatchTaskInfo.pointInfo[index] and index <= showIndex then
                    --如果当前点有数据，并且小于等于展示索引，说明可以查看
                    local pointData = self.dispatchTaskInfo.pointInfo[index]
                    if not pointData then
                        return
                    end
                    UIMgr:popUICover("DispatchBattlePanel", {pointData = pointData, pointCfg = curCfg, roleIdList = self.dispatchTaskInfo.roleIdList})
                end
            end)
        end
    end)
    local typeCount = self.lineNode.transform.childCount
    self:FillTemplateContent(self.lineNode, self.page2.map.lineRoot, tablex.size(self.lineCfg), function (index, itemObj)
        local curCfg = self.lineCfg[index]
        local line = nil
        for i = 1, typeCount do
            local tempLine = itemObj["line" .. i]
            if i == curCfg.type then
                line = tempLine
                tempLine:SetActive(true)
            else
                tempLine:SetActive(false)
            end
        end
        line.transform.localPosition = Vector3.New(curCfg.coordinate[1], curCfg.coordinate[2], 0)
        line.transform.localRotation = Quaternion.Euler(0, 0, curCfg.angle)
        line.clear:SetActive(index <= showIndex - 1)
    end)
end

--刷新船只位置
function DispatchDetailPanel:updateShip(showIndex, immediate)
    local curPos = Vector3.New(self.pointCfg[showIndex].coordinate[1], self.pointCfg[showIndex].coordinate[2], 0)
    if immediate or showIndex == 1 then
        self.page2.map.ship.transform.localPosition = curPos
        return
    end
    local tween = self.page2.map.ship.transform:DOLocalMove(curPos, 0.5):SetEase(DG.Tweening.Ease.InQuad):OnComplete(function()
        --到达后，播放点位特效
        local timer = DLuaTimer:DoAfter(0.1, function()
            --到达后，播放点位特效
            local pointObj = self.page2PointList[showIndex]
            if pointObj then
                if pointObj.ef.activeSelf == true then
                    pointObj.ef:SetActive(false)
                end
                pointObj.ef:SetActive(true)
            end
        end)
        table.insert(self.timerList, timer)
    end)
    table.insert(self.tweenList, tween)
end

function DispatchDetailPanel:refreshSendRoleList(showIndex)
      self:FillTemplateContent(self.sendRoleNode, self.page2.sendRoleList, 5, function (index, itemObj)
        if index > tablex.size(self.dispatchTaskInfo.roleIdList) then
            itemObj.icon:SetActive(false)
            return
        end
        local roleId = self.dispatchTaskInfo.roleIdList[index]
        if not roleId then
            itemObj.icon:SetActive(false)
            return
        end
        local roleData = Me:getPlayerHero(roleId)
        if not roleData then
            return
        end
        itemObj.icon:SetActive(true)
        local skinConfig = Config.GetCharacterSkinInfo(roleData.equipSkin)
        local roleConfig = Config.GetCharacterInfo(roleId)
        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end
        local iconPath = string.format(Config.SpritePath.BannerRolePath, resourceFolder, skinConfig.driverKey)
        self:LoadSpriteAsync(iconPath, itemObj.icon.image)
        local typeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
        self:LoadSpriteAsync(typeIconPath, itemObj.type.image)
        local curPointInfo = nil
        local curEnergy = 0
        curPointInfo = self.dispatchTaskInfo.pointInfo[2]
        if curPointInfo and curPointInfo.beginEnergy and curPointInfo.beginEnergy[index] then
            curEnergy = curPointInfo.beginEnergy[index]
        end
        if showIndex > 1 then
            curPointInfo = self.dispatchTaskInfo.pointInfo[showIndex]
            if curPointInfo and curPointInfo.endEnergy and curPointInfo.endEnergy[index] then
                curEnergy = curPointInfo.endEnergy[index]
            end
        end
        local index, color = Me:getDispatchEnergyIndexAndColor(curEnergy)
        for i = 1, 3 do
            if i == index then
                itemObj["hpIcon"..i].gameObject:SetActive(true)
            else
                itemObj["hpIcon"..i].gameObject:SetActive(false)
            end
        end
        itemObj.hpText.text.text = string.format("<color=#%s>%s</color>/100", color, curEnergy)
        itemObj.hpProgress.image.fillAmount = curEnergy / 100
        itemObj.hpProgress.image.color = Color.NewFromStr(color)
    end)
end

--刷新奖励列表
function DispatchDetailPanel:refreshRewardList(showIndex, immediate)
    --LuaLogger.e("DispatchDetailPanel:refreshRewardList:"..showIndex)
    local oldRewardList = self.rewardList or {}
    self.rewardList = {}
    local curPointRewardList = {}
    for index, v in pairs(self.dispatchTaskInfo.pointInfo) do
        if index <= showIndex and v.reward then
            for _, reward in pairs(v.reward) do
                table.insert(self.rewardList, reward)
            end
            if index == showIndex then
                curPointRewardList = v.reward or {}
            end
        end
    end
    self.rewardList = Me:mergeRewardList(self.rewardList)

    local oldMarkList = {}
    for _, reward in pairs(oldRewardList) do
        oldMarkList[reward.id] = true
    end
    for _, reward in pairs(self.rewardList) do
        if not oldMarkList[reward.id] then
            table.insert(oldRewardList, reward)
        else
            for _, oldReward in pairs(oldRewardList) do
                if oldReward.id == reward.id then
                    oldReward.num = reward.num
                    break
                end
            end
        end
    end
    self.rewardList = oldRewardList
    if immediate then
        for index = 1, tablex.size(self.rewardList) do
            self.page2RewardObjList[index].customBox:setMono(self)
            self.page2RewardObjList[index].customBox:SetUIData(self.rewardList[index], {navType = GE.NavigationType.DispatchPanel})
        end
        return
    end
    if tablex.size(curPointRewardList) > 0 then
        --播放奖励飞行动画
        self:playRewardFlyAni(curPointRewardList, showIndex)
    end
end

function DispatchDetailPanel:showRewardEmpey()
    self.page2RewardObjList = {}
    self:FillTemplateContent(self.customBox, self.page2.rewardList, 10, function (index, itemObj)
        itemObj.transform.localScale = Vector3.New(0.76,0.76,1)
        self.page2RewardObjList[index] = itemObj
        local data = {
            nullDelItem = true,
        }
        itemObj.customBox:setMono(self)
        itemObj.customBox:SetUIData(nil, data)
    end)
end

--播放奖励飞行动画
function DispatchDetailPanel:playRewardFlyAni(curPointRewardList, showIndex)
    --LuaLogger.e("DispatchDetailPanel:playRewardFlyAni:"..showIndex)
    local pointObj = self.page2PointList[showIndex]
    if not pointObj then
        return
    end
    local UICamera = UIMgr.uiCamera
    local screenPos = UICamera:WorldToScreenPoint(pointObj.transform.position)
    local beginPos = UICommonUtils.ScreenToUILocalPos(self.efRoot.transform, UICamera, screenPos)
    local timer, tween, delayTime, endPos = nil, nil, 0.15, Vector3.New(0,0,0)
    for index = 1, tablex.size(self.rewardList) do
        local curDataIndex = nil
        for i = 1, tablex.size(curPointRewardList) do
            if self.rewardList[index].id == curPointRewardList[i].id then
                curDataIndex = i
                break
            end
        end
        --LuaLogger.e("curDataIndex:"..tostring(curDataIndex))
        if curDataIndex then
            local rewardData = curPointRewardList[curDataIndex]
            local flyObj = self.flyEfObjList[index]
            if not flyObj then
                flyObj = GameObject.Instantiate(self.flyEf)
                flyObj:SetParent(self.efRoot.transform)
                flyObj:SetActive(false)
                table.insert(self.flyEfObjList, flyObj)
            end
            flyObj.transform.localPosition = beginPos
            --getEndPos
            timer = DLuaTimer:DoAfter(delayTime, function()
                local endObj = self.page2RewardObjList[index]
                if endObj then
                    screenPos = UICamera:WorldToScreenPoint(endObj.transform.position)
                    endPos = UICommonUtils.ScreenToUILocalPos(self.efRoot.transform, UICamera, screenPos)
                end
                flyObj:SetActive(true)
                tween = flyObj.transform:DOLocalMove(endPos, 0.8):SetEase(DG.Tweening.Ease.InQuad):OnComplete(function()
                    flyObj:SetActive(false)
                    --更新奖励格子
                    for _, data in pairs(self.rewardList) do
                        if data.id == rewardData.id then
                            rewardData = data
                            break
                        end
                    end
                    endObj.customBox:setMono(self)
                    endObj.customBox:SetUIData(rewardData, {navType = GE.NavigationType.DispatchPanel})
                    if endObj.customBox.showEf.activeSelf == true then
                        endObj.customBox.showEf:SetActive(false)
                    end
                    endObj.customBox.showEf:SetActive(true)
                    DLuaTimer:DoAfter(0.2, function()
                        endObj.customBox.showEf:SetActive(false)
                    end)
                end)
                table.insert(self.tweenList, tween)
            end)
            table.insert(self.timerList, timer)
            delayTime = delayTime + 0.25
        else
            timer = DLuaTimer:DoAfter(delayTime, function()
                self.page2RewardObjList[index].customBox:setMono(self)
                self.page2RewardObjList[index].customBox:SetUIData(self.rewardList[index], {navType = GE.NavigationType.DispatchPanel})
            end)
            table.insert(self.timerList, timer)
            delayTime = delayTime + 0.25
        end
    end
end

-- 计算三次贝塞尔控制点（对称偏移）
---@param startPoint table {x=number, y=number}
---@param endPoint table {x=number, y=number}
---@param tension number 偏移强度（0~1，默认0.3）
---@return table 控制点1, 控制点2
function DispatchDetailPanel:calculateCubicControlPoints(startPoint, endPoint, tension)
    tension = tension or 0.3
    local midX = (startPoint.x + endPoint.x) / 2
    local midY = (startPoint.y + endPoint.y) / 2

    -- 计算起点到终点的方向向量
    local dirX = endPoint.x - startPoint.x
    local dirY = endPoint.y - startPoint.y

    -- 控制点偏移量
    local offset = (dirX^2 + dirY^2)^0.5 * tension

    -- 控制点1（上方）
    local cp1 = {
        x = midX - dirY * offset,
        y = midY + dirX * offset
    }

    -- 控制点2（下方）
    local cp2 = {
        x = midX + dirY * offset,
        y = midY - dirX * offset
    }

    return cp1, cp2
end

function DispatchDetailPanel:bindSettleBtn()
    self.page2.settleBtn.scaleButton.onClick:RemoveAllListeners()
    self.page2.settleBtn.scaleButton.onClick:AddListener(function()
        self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
        for _, obj in pairs(self.flyEfObjList) do
            GameObject.Destroy(obj)
        end
        for _, timer in pairs(self.timerList) do
            timer:Stop()
            DLuaTimer:RemoveTimer(timer)
        end
        for _, tween in pairs(self.tweenList) do
            tween:Kill()
        end
        local showIndex = tablex.size(self.pointCfg)
        self:updateShip(showIndex, true)
        self:refreshSendRoleList(showIndex)
        self:updatePointAndLine(showIndex, true)

        Me:dispatchEndReq({dispatchIdList = {self.dispatchTaskInfo.dispatchId}}, function(data)
            if data.ret == 0 then
                UIMgr:closeUI(self)
                if self.rewardList then
                    for _, reward in pairs(self.rewardList) do
                        reward.type = GE.RewardType.ItemProp
                    end
                    Me:ReceiveReward(self.rewardList)
                end
                CoveManager.instance()._roleMgr:disPatchEndRecover()
            end
        end)
        --Me:ReceiveReward(self.rewardList)
    end)
end

function DispatchDetailPanel:setCountDownText(remainTime)
    if remainTime <= 0 then
        self.page2.countDown.text.text = "00:00:00"
    else
        local hours = math.floor(remainTime / 3600)
        local minutes = math.floor((remainTime % 3600) / 60)
        local seconds = remainTime % 60
        self.page2.countDown.text.text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
    end
end

function DispatchDetailPanel:getAddConditionData(roleIdList)
    if not self.chapterData then
        return nil
    end

    local shipTypeList = {}
    for _, v in pairs(roleIdList) do
        local roleConfig = Config.GetCharacterInfo(v)
        if roleConfig then
            table.insert(shipTypeList, math.floor(roleConfig.attribute / 10))
        end
    end
    local data = {}
    local condition = self.chapterData.extraCondition[self.page1TabIndex] or {}
    for _, cType in pairs(condition) do
        --舰种
        local isMeet = false
        for _, v in pairs(shipTypeList) do
            if v == cType then
                isMeet = true
                break
            end
        end
        table.insert(data, {
            desc = LocalStrEnum["ShipType" .. cType],
            isMeet = isMeet,
        })
    end
    return data
end

function DispatchDetailPanel:OnClose(initiative)
    if self.countDownTimer then
        DLuaTimer:RemoveTimer(self.countDownTimer)
    end
    if self.mapRefreshTimer then
        DLuaTimer:RemoveTimer(self.mapRefreshTimer)
    end
    for _, obj in pairs(self.flyEfObjList) do
        GameObject.Destroy(obj)
    end
    for _, timer in pairs(self.timerList) do
        timer:Stop()
        DLuaTimer:RemoveTimer(timer)
    end
    for _, tween in pairs(self.tweenList) do
        tween:Kill()
    end
    if self.page2RewardObjList then
        for _, obj in pairs(self.page2RewardObjList) do
            GameObject.Destroy(obj)
        end
    end
end

-- function DispatchDetailPanel:OnDestroy()
--     self.super:OnDestroy(self)
-- end

--[[
/Page1/TypeTipBg onClick 
--]]
function DispatchDetailPanel:typeTipBg_Button_onClick(typeTipBg)
    self.typeTipBg:SetActive(false)
end

--[[
/Page1/AutoBtn onClick 
--]]
function DispatchDetailPanel:autoBtn_ScaleButton_onClick(autoBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    if not self.chapterData then
        return
    end
    for i = 1, self.chapterData.characterNum do
        if self.heroInfoList[i] then
            self.waitDispatchRoleList[i] = self.heroInfoList[i].id
        else
            self.waitDispatchRoleList[i] = nil
        end
    end
    self:refreshRoleIconList()
    self:refreshWaitRoleList()
    self:refreshBtnState()
    self:refreshAddCondition()
    self:refreshFightNum(self.waitDispatchRoleList)
end

--[[
/Page1/DispatchBtn onClick 
--]]
function DispatchDetailPanel:dispatchBtn_ScaleButton_onClick(dispatchBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
    if not self.waitDispatchRoleList or tablex.size(self.waitDispatchRoleList) <= 0 then
        return
    end
    local showType = 1
    if self.roleHpEnough == false then
        showType = 2
    elseif self.isFightEnough == false then
        showType = 3
    end
    UIMgr:popUI("MsgBox", {
        title = LocalStrEnum["dispatch_tips_1"],
        type = MsgBoxType.Dispatch,
        titleIcon = MsgTitleIconType.DisPatch,
        customData = {
            dispatchShowType = showType,
        },
        okCallback = function(nameText)
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            Me:dispatchStartReq({dispatchId = self.dispatchId, lineId = self.curline, roleIdList = self.waitDispatchRoleList}, function(data)
                if data.ret == 0 then
                    self.inDispatch = true
                    self.dispatchTaskInfo = Me:getDispatchTaskDataById(self.dispatchId)
                    --CoveManager.instance()._roleMgr:setRoleInDispatch(self.waitDispatchRoleList, true)
                    self:refreshUI()
                end
            end)
        end}
    )
end

--[[
/Page2/SettleBtn onClick 
--]]
function DispatchDetailPanel:settleBtn_ScaleButton_onClick(settleBtn)

end

--[[
/Page1/DetailBg onClick 
--]]
function DispatchDetailPanel:detailBg_Button_onClick(detailBg)

end

--[[
/PointBoxHideBtn onClick 
--]]
function DispatchDetailPanel:pointBoxHideBtn_Button_onClick(pointBoxHideBtn)
    self.pointBoxHideBtn:SetActive(false)
end

return DispatchDetailPanel
