local RoleGeneCtrl = BaseClass("RoleGeneCtrl", BaseUICtrl)
local M = RoleGeneCtrl
local MessageId = Proto.MessageId
local MAX_GENE_LINE_LEVEL = 6
local GeneOpenId = EnumConst.GeneOpenId
local sfmt = string.format

function M:Init()
    self.m_PanelType = {Main=1, Detail=2}
    self._view.suitPanel:SetOnActiveCallBack(Bind(self, self._ActiveCallBack))
end

function M:OnEnter(heroData)
    UIContextMgr:GetInstance():GetContext(UIDefine.RoleDevelopMain):SetChildPanelIndex(1)
    self:_RefreshEvent()
    self._view.detailPanel:SetActive(false)
    self._view.suitPanel:SetActive(true)
    self:Refresh(heroData)
end

function M:GeneUpStar(slot)
    local lv = self.m_GeneStars[slot]
    self.m_GeneStars[slot] = lv + 1
    self._view["gene" .. slot]:UpStar()
    self:_SetState()

    if self:_GetCurMinStar() == self.geneLv + 1 then
        self._view.detailPanel:SetGotoState(Bind(self, self.OnClose))
    end

    local curNum = self:_GetCurUpStarNum()
    self._view.suitPanel:UpGeneStar(curNum)
    self:_RefreshGeneList()

    local minPos = self:_GetMinStartPos(lv)
    if minPos then
        self:_OnItemClick(self.m_GeneInfo[minPos], lv)
    end
end

-- 激活成功后默认选中下一个
function M:_GetMinStartPos(lv)
    for k, v in pairs(self.m_GeneStars) do
        if v <= lv then
            local heroAi = self.m_GeneInfo[k]
            local heroAiStars = ConfigHelper.GetCfgsByLua("heroAiStar", {aiType=heroAi.aiType, star=lv})
            if #heroAiStars <= 0 then
                Logger.LogError("配置表错误")
                return
            end
            local heroAiStar = heroAiStars[1]
            local isEnough = true
            for idx, costItem in pairs(heroAiStar.costItems) do
                local haveNums = ItemDataMgr:GetInstance():GetItemNumById(costItem)
                if haveNums < heroAiStar.costNum[idx] then
                    isEnough = false
                    break
                end
            end
            if isEnough then
                return k
            end
        end
    end
    for k, v in pairs(self.m_GeneStars) do
        if v <= lv then
            return k
        end
    end
end

function M:OnVisible()
    if self.m_CurPanel == self.m_PanelType.Detail then
        self._view.detailPanel:RefreshPanel()
    end
end

function M:Refresh(heroData)
    self._heroData = heroData
    self.heroId = heroData:GetHeroId()
    self.rare = heroData:GetHeroCfg().rare

    self.geneLv = self._heroData:GetGeneStar()
    self.m_GeneInfo = ConfigHelper.GetCfgsByLua("heroAi", {heroId=self.heroId})
    self.m_HeroEffects = ConfigHelper.GetCfgsByLua("heroAiEffect", {heroId=self.heroId})
    self.m_GeneStars = {0, 0, 0, 0, 0}
    self:_StarsAndLvs()
    self:_SetGeneList()
    self:_CheckOpen()
    self:_SetState()
    self._view.suitPanel:Update(self.heroId, self.geneLv, self.m_HeroEffects)

    local curNum = self:_GetCurUpStarNum()
    self._view.suitPanel:UpGeneStar(curNum)

    self._view.redpoint:SetParam(0, self.heroId)
    self._view.redpoint:Check()
end

function M:_CheckOpen()
    self.lockTips = nil
    self.upTips = nil
    do -- 检查基因是否开放
        local showCondition = ConfigHelper.GetCfgPropByLua("functionOpen", GeneOpenId[self.rare], "showCondition")
        for _, conditionId in pairs(showCondition) do
            local isOpen = GameHelper.CheckLockByOpenConditionId(conditionId, self.heroId)
            if not isOpen then
                local openCondition = ConfigHelper.GetCfg("openCondition", conditionId)
                self.lockTips = ConfigHelper.GetLocalString(openCondition.tips)
                local heroName = ConfigHelper.GetHeroName(self.heroId)
                self.lockTips = sfmt(self.lockTips, heroName, openCondition.unlockParam2)
                break
            end
        end
    end
    if self.lockTips then
        return
    end
    -- 检查能否升级基因链
    if not self.lockTips then
        local heroAiEffects = ConfigHelper.GetCfgsByLua("heroAiEffect", {heroId=self.heroId, needStar=self.geneLv + 1})
        if #heroAiEffects <= 0 then
        else
            local conditionId = heroAiEffects[1].openCondition
            local isOpen = GameHelper.CheckLockByOpenConditionId(conditionId, self.heroId)
            if not isOpen then
                self.lockBtn = true
                local openCondition = ConfigHelper.GetCfg("openCondition", conditionId)
                -- 基因链升级提示
                self.upTips = ConfigHelper.GetLocalString(openCondition.tips)
                local heroName = ConfigHelper.GetHeroName(self.heroId)
                self.upTips = sfmt(self.upTips, heroName, openCondition.unlockParam2)
            end
        end
    end
end

function M:_RefreshEvent()
    if self.m_RefreshDataHandler then
        EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, self.m_RefreshDataHandler)
        self.m_RefreshDataHandler = nil
    end

    if self.m_GeneUpgradeHandler then
        EventMgr:RemoveListener(UIMessageNames.ROLE_GENE_UPGRADE, self.m_GeneUpgradeHandler)
        self.m_GeneUpgradeHandler = nil
    end

    self.m_RefreshDataHandler = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, Bind(self, self._OnRereshPanel))
    self.m_GeneUpgradeHandler = EventMgr:AddListener(UIMessageNames.ROLE_GENE_UPGRADE, Bind(self, self._GeneUpgradeRefresh))
end

-- 整理基因等级
function M:_StarsAndLvs()
    local Stars = self._heroData:GetGenesStars()
    if Stars then
        for i = 0, Stars.Length - 1 do
            self.m_GeneStars[i + 1] = Stars[i]
        end
    end
end

-- 设置基因
function M:_SetGeneList()
    local unlockNum = 0
    for i, v in ipairs(self.m_GeneInfo) do
        local RoleGeneItemCtrl = self._view["gene" .. v.slot]
        local star = self.m_GeneStars[v.slot]
        local isActive = self.geneLv + 1 == star
        RoleGeneItemCtrl:Update(self.heroId, v, star, isActive, Bind(self, self._OnItemClick))
        if isActive then
            unlockNum = unlockNum + 1
        end
    end
    self:_UpdateGeneSpin(self.geneLv == MAX_GENE_LINE_LEVEL and 5 or unlockNum)
end

function M:_RefreshGeneList()
    local unlockNum = 0
    for i, v in ipairs(self.m_GeneInfo) do
        local star = self.m_GeneStars[v.slot]
        local isActive = self.geneLv + 1 == star
        if isActive then
            unlockNum = unlockNum + 1
        end
    end
    self:_UpdateGeneSpin(self.geneLv == MAX_GENE_LINE_LEVEL and 5 or unlockNum)
end

-- 设置状态
function M:_SetState()
    local state = 1
    if self.lockTips then
        state = 1
    elseif self.geneLv == 0 and self:_GetCurMinStar() == self.geneLv then
        state = 2
    elseif self.geneLv == 0 and self:_GetCurMinStar() == self.geneLv + 1 then
        state = 3
    elseif self.geneLv == #self.m_HeroEffects then
        state = 6
    elseif self:_GetCurMinStar() == self.geneLv then
        state = 4
    elseif self:_GetCurMinStar() == self.geneLv + 1 then
        state = 5
    end
    -- 已经解锁但是不可以升级基因链
    if (state == 3 or state == 5) and self.upTips then
        state = 1
    end
    self._view.panelState:SetState(state)
    if state == 1 then
        if self.lockTips then
            self._view.labLock:SetText(self.lockTips)
            return
        end
        if self.upTips then
            self._view.labLock:SetText(self.upTips)
            return
        end
    end

end

---获取基因的最低等级
function M:_GetCurMinStar()
    local min = 99
    for _, v in ipairs(self.m_GeneStars) do
        if v < min then
            min = v
        end
    end
    return min
end

function M:_GetCurUpStarNum()
    local level = self.geneLv + 1
    local num = 0
    for _, v in ipairs(self.m_GeneStars) do
        if v == level then
            num = num + 1
        end
    end
    return num
end

function M:_OnRereshPanel(heroId)
    if self.heroId == heroId then
        return
    end

    local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    self:Refresh(heroData)
end

function M:_GeneUpgradeRefresh(heroId)
    local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    self:Refresh(heroData)
end

-- 升级套装
function M:_OnGeneLineUpStar()
    self._view.suitPanel:UpStar()
    self._view.suitPanel:OpenGeneUpTipsPanel()
    self:_SetState()

    for i = 1, 5 do
        self._view["gene" .. i]:UpdateActive()
    end

    -- 升级套装之后，要重置基因模型
    self:_UpdateGeneSpin(self.geneLv == MAX_GENE_LINE_LEVEL and 5 or 0)
end

function M:_UpdateGeneSpin(unlockNum)
    local module = ModuleMgr:GetInstance():GetCurrentModule()
    if module.ModifyGeneSpin then
        module:ModifyGeneSpin(unlockNum)
    else
        Logger.LogError("ModifyGeneSpin 不存在")
    end
end

-- 基因点击事件
function M:_OnItemClick(cfg, star)
    -- 没有开放基因
    if self.lockTips then
        return
    end
    if self._view.detailPanel.isClick then
        return
    end
    self._view.detailPanel:Update(cfg, star, self._heroData, self)
    if self:_GetCurMinStar() == self.geneLv + 1 then
        self._view.detailPanel:SetGotoState(Bind(self, self.OnClose))
    end

    DevelopHelper.CameraMove(DevelopCameraConfig.Type.GeneDetail)
    for i = 1, 5 do
        local RoleGeneItemCtrl = self._view["gene" .. i]
        RoleGeneItemCtrl:SetSelect(i == cfg.slot)
    end

    if self.m_CurPanel ~= self.m_PanelType.Detail then
        EventMgr:Broadcast(UIMessageNames.ROLE_DEVELOP_MAINUI_STATE, false)
        self._view.detailPanel:SetActive(true)
        self._view.suitPanel:SetActive(false)
        self._view.animator:Play("RoleGeneUI_Select")
        self.m_CurPanel = self.m_PanelType.Detail
    end
end

function M:_ActiveCallBack()
    self._ResponseHeroGenesActivate = NetPack:RegistResponse(MessageId.ResponseHeroGenesActivate, Bind(self, self.ResponseHeroGenesActivateCallback))
    local request = {}
    request.HeroId = self.heroId
    NetPack:SendMessage(MessageId.RequestHeroGenesActivate, request)
end

-- 基因链升级
function M:ResponseHeroGenesActivateCallback(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseHeroGenesActivate, self._ResponseHeroGenesActivate)
    self._ResponseHeroGenesActivate = nil
    -- 设置基因链等级
    self._heroData:SetGeneStar(msg.StarLevel)
    self.geneLv = msg.StarLevel
    self:_OnGeneLineUpStar()

    IRedPointMgr:ForceCheck(RedPointConst.HeroGeneAllRedPointChecker)
    IRedPointMgr:ForceCheck(RedPointConst.HeroGene1RedPointChecker)
    IRedPointMgr:ForceCheck(RedPointConst.HeroGene2RedPointChecker)
    IRedPointMgr:ForceCheck(RedPointConst.HeroGene3RedPointChecker)
    IRedPointMgr:ForceCheck(RedPointConst.HeroGene4RedPointChecker)
    IRedPointMgr:ForceCheck(RedPointConst.HeroGene5RedPointChecker)
    -- 埋点信息
    local profession = ConfigHelper.GetCfgPropByLua("role", self.heroId, "profession")
    -- local dataKey = { "hero_type", "hero_quality", "hero_id", "gene_id", "gene_level" }
    local dataValues = {tostring(profession), tostring(self.rare), tostring(self.heroId), "0", tostring(msg.StarLevel)}
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.HeroGeneup, dataValues)
end

function M:OnClose()
    if self.m_CurPanel == self.m_PanelType.Detail then
        for i = 1, 5 do
            self._view["gene" .. i]:SetSelect(false)
        end

        self._view.detailPanel:SetActive(false)
        self._view.suitPanel:SetActive(true)
        self._view.animator:Play("RoleGeneUI_ExitSelect")
        self.m_CurPanel = self.m_PanelType.Main
        EventMgr:Broadcast(UIMessageNames.ROLE_DEVELOP_MAINUI_STATE, true)
        DevelopHelper.CameraMove(DevelopCameraConfig.Type.Gene)
        self:_CheckOpen()
        self:_SetState()
        return
    end

    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, self.m_RefreshDataHandler)
    EventMgr:RemoveListener(UIMessageNames.ROLE_GENE_UPGRADE, self.m_GeneUpgradeHandler)
    self.m_RefreshDataHandler = nil
    self.m_GeneUpgradeHandler = nil
    M.super.OnClose(self)
end

function M:OnDispose()
    self._view.detailPanel:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_REFRESH_DATA, self.m_RefreshDataHandler)
    EventMgr:RemoveListener(UIMessageNames.ROLE_GENE_UPGRADE, self.m_GeneUpgradeHandler)
    self.m_RefreshDataHandler = nil
    self.m_GeneUpgradeHandler = nil
    M.super.OnDispose(self)
end

return RoleGeneCtrl
