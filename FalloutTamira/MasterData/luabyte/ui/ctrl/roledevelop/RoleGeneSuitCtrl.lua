local RoleGeneSuitCtrl = BaseClass("RoleGeneSuitCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = RoleGeneSuitCtrl

function M:Init()
    self.m_Stars = {}
    self:ShowPanel()
    self._view.detailBtn:onClick(Bind(self, self._OnOpenTipsClick))
    self._view.activeBtn:onClick(Bind(self, self._OnActiveClick))

    self.m_LevelCfg = {}
    local systemCfg = ConfigHelper.GetSystemParams(318)
    local index = systemCfg.Length / 3
    for i = 0, index - 1 do
        local parme1 = i * 3
        local parme2 = i * 3 + 2

        local cfg = {}
        cfg.level = systemCfg[parme1]
        cfg.geneLevel = systemCfg[parme2]
        self.m_LevelCfg[i + 1] = cfg
    end
end

function M:SetActive(state)
    self._view:SetActive(state)
end

function M:UpStar()
    self.m_Star = self.m_Star + 1
    self._view.nextNum:SetText("0")
    self:_RefreshPanel()
end

function M:UpGeneStar(star)
    self._view.nextNum:SetText(tostring(star))
end

function M:Update(heroId, star, cfg)
    self.heroId = heroId
    self.m_HeroEffects = cfg
    self.m_Star = star
    self:_RefreshPanel()
end

function M:_RefreshPanel()
    self:_SetEffects()
    self:_SetNextCostStar()
    self:_SetOther()
end

-- 设置套装属性
function M:_SetEffects()
    for i, v in ipairs(self.m_HeroEffects) do
        if self.m_Star == 0 and v.needStar == 1 then
            self._view.curList:Update({}, true, self.m_Star)
            self._view.nextList:Update(v.haloDesc, false, self.m_Star + 1)
        end

        if self.m_Star == v.needStar then
            self._view.curList:Update(v.haloDesc, true, self.m_Star)
            self._view.nextList:Update(v.haloNextDesc, false, self.m_Star + 1)
        end
    end
end

-- 设置其他内容
function M:_SetOther()
    if self.m_Star <= 0 then
        self._view.nameText:SetText(self.m_HeroEffects[1].name)
    else
        self._view.nameText:SetText(self.m_HeroEffects[self.m_Star].name)
    end

    local heroLevel = (IHeroDataMgr:GetMyHeroDataById(self.heroId)):GetLevel()
    local geneLevel = 0
    for i, v in ipairs(self.m_LevelCfg) do
        if heroLevel <= v.level then
            geneLevel = v.geneLevel
            break
        end
    end

    local isShowTip = self.m_Star < geneLevel
    self._view.lvTips:SetActive(isShowTip)
    self._view.lvTipNum:SetText(tostring(geneLevel))
end

-- 设置星星
function M:_SetNextCostStar()
    local nextStar = self.m_Star + 1
    for i = 1, nextStar do
        local star = self.m_Stars[i]

        if not star then
            star = self._view.dot:Instantiate()
            self.m_Stars[#self.m_Stars + 1] = star
        end

        star:SetActive(true)
    end

    if #self.m_Stars > nextStar then
        local num = #self.m_Stars - nextStar

        for i = 1, num do
            local index = nextStar + i
            self.m_Stars[index]:SetActive(false)
        end
    end
end

-- 打开基因详细面板
function M:_OnOpenTipsClick()
    UIContextMgr:GetInstance():Show("GeneTips", self.heroId)
end

function M:OpenGeneUpTipsPanel()
    UIContextMgr:GetInstance():Show("RoleGeneUpTips", 2, self.heroId, self.m_Star)
end

function M:_OnActiveClick()
    if self.activeCallBack then
        self.activeCallBack()
    end
end

function M:SetOnActiveCallBack(func)
    self.activeCallBack = func
end

return RoleGeneSuitCtrl
