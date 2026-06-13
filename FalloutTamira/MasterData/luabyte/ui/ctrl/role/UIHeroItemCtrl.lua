local UIHeroItemCtrl = BaseClass("UIHeroItemCtrl")
local M = UIHeroItemCtrl

--通用组件
function M:__init(view)
    self._view = view
    self:Init()
end

function M:Init()
    self.qualityBg = "UI/SpritePics/common/ui_common_head_hero_quality_0"
    if self._view.btn.SetOnClick then
        self._view.btn:SetOnClick(Bind(self, self.OnClick))
    else
        self._view.btn:onClick(Bind(self, self.OnClick))
    end
end

function M:UpdateItem(data)
    self.data = data
    if not data then
        return
    end
    self.clickFunc = data.clickFunc
    self._heroData = IHeroDataMgr:GetMyHeroDataById(data.heroId)
    self._heroConf = ConfigHelper.GetCfgByLua("hero", data.heroId)
    self._view.HeadIcon:SetAvatarIcon(data.heroId, RoleType.ERT_Hero)
    self._view.Name:SetText(self._heroConf.name)
    self._view.labLevel:SetText(tostring(self._heroData:GetLevel()))
    self._view.Quality:SetPic(self.qualityBg .. self._heroConf.rare)
    self._view.Quality:SetActive(true)
    self._view.imgProfession:SetProfessional(data.heroId)
end

function M:OnClick()
    if not self.clickFunc then
        return
    end
    self:clickFunc()
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UIHeroItemCtrl
