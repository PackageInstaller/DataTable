local UIHeroItemNewCtrl = BaseClass("UIHeroItemNewCtrl")
local M = UIHeroItemNewCtrl

function M:__init(view)
    self._view = view
    -- self._view.btn:SetOnClick(self, self._OnBtnClick)
    self._view.btnLvUp:SetOnClick(self, self._OnBtnLvUpClick)
    self._raritySps = "UI/SpritePics/employee/ui_employee_quality_0"
    self._selectIndexPath = "UI/SpritePics/formation/ui_formation_text_0"
    self._nationIconPath = { "UI/SpritePics/employee/ui_employee_nation_01",
                             "UI/SpritePics/employee/ui_employee_nation_02",
                             "UI/SpritePics/employee/ui_employee_nation_03",
                             "UI/SpritePics/employee/ui_employee_nation_04",
                             "UI/SpritePics/employee/ui_employee_nation_05",
                             "UI/SpritePics/employee/ui_employee_nation_01",
                             "UI/SpritePics/employee/ui_employee_nation_01",
                             "UI/SpritePics/employee/ui_employee_nation_01",  }
end

function M:UpdateItem(data)
    self._heroId = data.heroId
    self._selectIndex = data.selectIndex
    self._heroData = IHeroDataMgr:GetMyHeroDataById(self._heroId)
    self._heroConf = ConfigHelper.GetCfgByLua("hero", self._heroId)
    self._roleConf = ConfigHelper.GetCfgByLua("role", self._heroId)
    self:_UpdataHeroData()
end

function M:_UpdataHeroData()
    self._view.imgHero:SetShowHalf(self._heroId, RoleType.ERT_Hero)
    self._view.imgJob:SetProfessional(self._heroId)
    self._view.labName:SetAvatarName(self._heroId, RoleType.ERT_Hero)
    self._view.labLv:SetText("<size=35>LV.</size>" .. self._heroData:GetLevel())
    self._view.imgRarity:SetPic(self._raritySps .. self._heroConf.rare)
    self._view.imgNation:SetPic(self._nationIconPath[self._roleConf.faction])
    self._view.tfEffect.gameObject:SetActive(self._heroConf.rare == 4)
    
    if self._selectIndex > 0 then
        --正常选中状态
        self._view.tfSelect.gameObject:SetActive(true)
        self._view.tfSelectBG.gameObject:SetActive(true)
        self._view.imgSelectNum:SetPic(self._selectIndexPath .. self._selectIndex)
    elseif self._selectIndex == 0 then
        --未选中状态
        self._view.tfSelect.gameObject:SetActive(false)
    else
        --编队选中状态
        self._view.tfSelect.gameObject:SetActive(true)
        self._view.tfSelectBG.gameObject:SetActive(false)
    end
end

function M:_OnBtnLvUpClick()    
end

function M:SetActive(b)
    self._view:SetActive(b)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return UIHeroItemNewCtrl
