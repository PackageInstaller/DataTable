local GeneTipsCtrl = BaseClass("GeneTipsCtrl", BaseUICtrl)
local M = GeneTipsCtrl
local MAXSTAR = 6
local mCeil = math.ceil
local tSort = table.sort

function M:Init()
    self._view.Mask:onClick(Bind(self, self._OnClickClose))
end

function M:OnEnter(heroId)
    self.heroId = heroId
    self.heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    self._star = self:_CalculateLevel()
    self:_InitData()
    self:_Init()
end

function M:_InitData()
    self.heroAiEffects = ConfigHelper.GetCfgsByLua("heroAiEffect", {heroId=self.heroId})
    tSort(self.heroAiEffects, self._Sort)
    self.heroAiEffect = self.heroAiEffects[self._star] or self.heroAiEffects[1]
end

function M:_Init()
    self._view.imgStar.unity_uiimage.fillAmount = self._star / MAXSTAR
    self._view.Name:SetText(self.heroAiEffect.name)
    self._view.imgProfession:SetProfessional(self.heroId)
    for i = 1, MAXSTAR do
        local state = self._star >= i
        local alpha = state and 255 or 51
        self._view["title" .. i]:SetColor(255, 255, 255, alpha)
        self._view["Detail" .. i]:Update(state, self.heroAiEffects[i].detailDesc)
    end
end

function M._Sort(heroAiEffect1, heroAiEffect2)
    return heroAiEffect1.needStar < heroAiEffect2.needStar
end

function M:_OnClickClose()
    self:Close()
end

function M:_CalculateLevel()
    local Stars = self.heroData:GetGeneStar()
    return Stars
end

-- 点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return GeneTipsCtrl
