local LotteryResultHeroItem = BaseClass("LotteryResultHeroItem")
local M = LotteryResultHeroItem

function M:__init(view)
    self._view = view 
    self._effect = nil 
end

function M:SetHero( heroId , chipId , chipNum, effectCtrl )
    self._view.rimg_roleIcon:SetShowHalf(heroId,RoleType.ERT_Hero,1)
    -- self._view.img_quality:SetHeroQuality(heroId)
    local cfg = ConfigHelper.GetCfgByLua("hero",heroId)
    if self._view.img_quality then 
        self._view.img_quality:SetPic("UI/SpritePics/lottery/ui_lottery_cardbg0" .. cfg.rare )
    end
    if chipId > 0 then 
        self._view.New:SetActive(false)
        self._view.iconItem_Item:SetActive(true)
        self._view.iconItem_Item:SetInfo(chipId,ItemNumberType.TOTLE,chipNum)
    else
        self._view.New:SetActive(true)
        self._view.iconItem_Item:SetActive(false)
    end
    
    self:_SetStar(cfg.showStar)
    self._view.img_proIcon:SetProfessional(heroId)
    if self._effect == nil then 
        self._effect = effectCtrl:Instantiate()
        self._effect:SetActive(true)
        self._effect:SetParent(self._view.EffectPanel)
        self._effect:SetLocalPos(0,0,0)
    end
    for i = 1 , 4 do 
        self._effect["quality"..i]:SetActive(cfg.rare == i)
    end
end

function M:_SetStar(star)
    for i = 0 , 4 do 
        self._view["trans_star"..i]:SetActive(star>i)
    end
end

function M:SetActive(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return M 