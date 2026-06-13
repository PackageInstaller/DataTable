local RoleGeneDetailCtrl = BaseClass("RoleGeneDetailCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = RoleGeneDetailCtrl
local MessageId = Proto.MessageId
local sfmt = string.format

function M:Init()
    self:ShowPanel()
    self.m_CostItems = {}
    self._view.upStarBtn:onClick(Bind(self, self._OnClickUpStar))
    self._view.activeBtn:onClick(Bind(self, self._OnClickUpStar))
    self._view.detailBtn:onClick(Bind(self, self._OnOpenTipsClick))
    self._view.goBtn:onClick(Bind(self, self._OnGotoMain))
end

function M:SetActive(state)
    self._view:SetActive(state)
end

function M:SetGotoState(callback)
    self.m_CallBack = callback
    self._view.state:SetState(6)
end

function M:Update(cfg, star, heroData, roleGeneCtrl)
    self.m_Cfg = cfg
    self.m_HeroData = heroData
    self.heroId = heroData:GetHeroId()
    self._star = star
    self.geneLv = heroData:GetGeneStar() -- 基因链等级
    self.RoleGeneCtrl = roleGeneCtrl
    self.m_StarCfg = ConfigHelper.GetCfgsByLua("heroAiStar", {aiType=self.m_Cfg.aiType})

    self._view.icon:SetPic(self.m_Cfg.icon)
    self._view.nameText:SetText(self.m_Cfg.nameId)
    self:RefreshPanel()
end

function M:RefreshPanel()
    self:_SetStar()
    self:_SetCostInfo()
    self:_SetState()
    self:_SetEffectList()
end

function M:_SetStar()
    for i = 1, 6 do
        local name = "star" .. i
        self._view[name]:SetActive(i <= self._star)
    end
end

function M:_SetEffectList()
    self.m_NextAttr = self:_AccountAttr(self._star + 1)
    self.m_CurAttr = self:_AccountAttr(self._star)

    for i = 1, 5 do
        local name = "effect" .. i
        self._view[name]:SetActive(false)
    end

    local index = 0
    for k, v in pairs(self.m_CurAttr) do
        index = index + 1
        local state = self._state == 5 and 3 or 2
        local name = "effect" .. index
        self._view[name]:Update(k, v, self.m_NextAttr[k])
        self._view[name]:SetActive(true)
        self._view[name]:SetState(state)
    end
end

-- 获取升星配置
function M:_AccountAttr(star)
    local AttrTab = {}
    for key, value in pairs(self.m_StarCfg) do
        if value.star == star then
            for index, v in ipairs(value.attributeType) do
                -- 不用累加，直接取值
                AttrTab[v] = value.attributeValue[index]
            end
            break
        end
    end
    return AttrTab
end

-- 设置消耗
function M:_SetCostInfo()
    if self._star > self.geneLv then
        return
    end
    local NUMTYPE = CS.GameX.ItemPfbUI.NUMTYPE
    local items = self.m_StarCfg[self._star + 1].costItems
    local nums = self.m_StarCfg[self._star + 1].costNum
    local length = #items
    self._view.comCost:SetItemById(items[1], nums[1])

    for i, item in ipairs(self.m_CostItems) do
        item:SetActive(false)
    end

    self.m_IsEnough = GameHelper.CheckItem(items[1], nums[1])
    for i = 2, length do
        local costId = items[i]
        local costNum = nums[i]

        local costItem = self.m_CostItems[i]
        if not costItem then
            costItem = self._view.costItem:Instantiate()
            table.insert(self.m_CostItems, costItem)
        end

        costItem:SetActive(true)
        costItem.item:SetInfo(costId, NUMTYPE.BALANCE, costNum)
        costItem.item:EnablePopItem(true)

        self.m_IsEnough = self.m_IsEnough and GameHelper.CheckItem(costId, costNum)
    end
end

function M:_SetState()
    self._state = 4
    if self._star == 0 and not self.m_IsEnough then
        self._state = 1
    elseif self._star == 0 and self.m_IsEnough then
        self._state = 2
    elseif self._star >= #self.m_StarCfg - 1 then
        self._state = 7
    elseif self.geneLv + 1 == self._star then
        self._state = 5
    elseif not self.m_IsEnough then
        self._state = 3
    end
    self._view.state:SetState(self._state)
    if self._state == 5 then
        self:_InitBtnState()
    end
end

function M:_InitBtnState()
    local heroAiEffects = ConfigHelper.GetCfgsByLua("heroAiEffect", {heroId=self.heroId, needStar=self.geneLv + 1})
    local tips = nil
    if #heroAiEffects <= 0 then
        tips = 5667
    else
        local conditionId = heroAiEffects[1].openCondition
        local isOpen = GameHelper.CheckLockByOpenConditionId(conditionId, self.heroId)
        if not isOpen then
            self.lockBtn = true
            local openCondition = ConfigHelper.GetCfg("openCondition", conditionId)
            tips = ConfigHelper.GetLocalString(openCondition.tips)
            local heroName = ConfigHelper.GetHeroName(self.heroId)
            tips = sfmt(tips, heroName, openCondition.unlockParam2)
        end
    end
    self._view.stateBtn:SetState(tips and 2 or 1)
    if tips then
        self._view.labLock:SetText(tips)
    end
end

-- 升星按钮事件
function M:_OnClickUpStar()
    if self.isClick then
        return
    end
    self.m_ResponseHeroGenesStarUp = NetPack:RegistResponse(MessageId.ResponseHeroGenesStarUp, Bind(self, self._OnUpStarCallBack))
    local request = {}
    request.HeroId = self.heroId
    request.Slot = self.m_Cfg.slot
    request.Star = self._star
    NetPack:SendMessage(MessageId.RequestHeroGenesStarUp, request)
    self.isClick = true
end

-- 回调
function M:_OnUpStarCallBack(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseHeroGenesStarUp, self.m_ResponseHeroGenesStarUp)
    self.m_ResponseHeroGenesStarUp = nil
    self.isClick = nil
    if result ~= 0 then
        return
    end
    self.m_HeroData:UpdateGenesStar(msg.Slot, msg.Star)
    self:_OnOpenUpTipsPanel()
    self._star = msg.Star
    self.m_IsActive = true
    self:RefreshPanel()
    self.RoleGeneCtrl:GeneUpStar(self.m_Cfg.slot)

    for i = 1, 5 do
        self._view["effect" .. i]:SetState(3)
    end

    IRedPointMgr:ForceCheck(RedPointConst.HeroGeneAllRedPointChecker)
    IRedPointMgr:ForceCheck(RedPointConst.HeroGeneLevelRedPointChecker)
    -- 红点 45是所有基因 46是位置1的基因
    IRedPointMgr:ForceCheck(RedPointConst.HeroGeneAllRedPointChecker + msg.Slot)
    -- 埋点
    local heroCfg = self.m_HeroData:GetHeroCfg()
    local profession = ConfigHelper.GetCfgPropByLua("role", self.heroId, "profession")
    -- local dataKey = {"hero_type", "hero_quality", "hero_id", "gene_id", "gene_level"}
    local dataValues = {tostring(profession), tostring(heroCfg.rare), tostring(self.heroId), tostring(msg.Slot), tostring(msg.Star)}
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.HeroGeneup, dataValues)
end

-- 打开基因详细面板
function M:_OnOpenTipsClick()
    UIContextMgr:GetInstance():Show("GeneTips", self.heroId)
end

function M:_OnOpenUpTipsPanel()
    UIContextMgr:GetInstance():Show("RoleGeneUpTips", 1, self.m_CurAttr, self.m_NextAttr, self.m_Cfg.icon)
end

function M:OnDispose()
    M.super.OnDispose(self)
end

function M:_OnGotoMain()
    if self.m_CallBack then
        self.m_CallBack()
        self.m_CallBack = nil
    end
end

return RoleGeneDetailCtrl
