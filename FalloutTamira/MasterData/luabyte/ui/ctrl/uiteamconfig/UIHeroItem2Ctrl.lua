local UIHeroItem2Ctrl = BaseClass("UIHeroItem2Ctrl")
local M = UIHeroItem2Ctrl
local EQuality = EnumConst.EQuality

function M:__init(view)
    self._view = view
    self._view.btn:SetOnClick(self, self._OnBtnClick)
    self._nationIconPath = {
        "UI/SpritePics/employee/ui_employee_nation_01", 
        "UI/SpritePics/employee/ui_employee_nation_02", 
        "UI/SpritePics/employee/ui_employee_nation_03", 
        "UI/SpritePics/employee/ui_employee_nation_04", 
        "UI/SpritePics/employee/ui_employee_nation_05", 
        "UI/SpritePics/employee/ui_employee_nation_01", 
        "UI/SpritePics/employee/ui_employee_nation_01", 
        "UI/SpritePics/employee/ui_employee_nation_01"
    }
end

function M:UpdateItem(data)
    self._data = data
    self._heroId = data.heroId

    if not data.isFri then
        local lockLvs = ConfigHelper.GetSystemParams(4)
        local lockLv = 1
        if data.index - 1 < lockLvs.Length then
            lockLv = lockLvs[data.index - 1] 
        end
        local lv = IPlayerData.level
        self.lock = lv < lockLv

        if self.lock then
            local lockTips = ConfigHelper.GetLocalString(5147)
            lockTips = string.format("<size=26>LV.</size><size=28>%s</size><size=26>%s</size>", lockLv, lockTips)
            self._view.labLock:SetText(lockTips)
            self._view.uiState:SetState(3)
            return
        end
    else -- 好友助战
        self.lock = not JumpMgr:GetInstance():CheckUnlockByFunctionOpenId(29)

        if self.lock then
            self._view.labLock:SetActive(false)
            self._view.uiState:SetState(3)
            return
        end
    end

    if not self._heroId then
        self._view.tfNomal.parent.name = "****"
        self._view.uiState:SetState(2)
        return
    else
        self._view.uiState:SetState(1)
    end

    self._view.tfNomal.parent.name = tostring(self._heroId)
    self._heroData = IHeroDataMgr:GetMyHeroDataById(self._heroId)
    self._heroConf = ConfigHelper.GetCfgByLua("hero", self._heroId)
    self._roleConf = ConfigHelper.GetCfgByLua("role", self._heroId)
    self:_UpdataHeroData()
end

function M:_UpdataHeroData()
    if self._data.fashion ~= nil and self._data.fashion > 0 then
        self._view.imgHero:SetPic(self._data.skinCfg.role:ResCfg().imageHalf)
    else
        if self:_IsAwake() then
            self._view.imgHero:SetImageHalf(self._heroId, RoleType.ERT_Hero, 3)
        else
            self._view.imgHero:SetImageHalf(self._heroId, RoleType.ERT_Hero, 1)
        end
    end

    -- 觉醒特效效果
    if self:_IsAwake() then
        if self._heroConf.rare == EQuality.SR then
            self._view.EffectPanel:SetState(2)
        elseif self._heroConf.rare == EQuality.SSR then
            self._view.EffectPanel:SetState(3)
        end
    else
        self._view.EffectPanel:SetState(1)
    end

    self._view.imgJob:SetProfessional(self._heroId)
    self._view.labName:SetAvatarName(self._heroId, RoleType.ERT_Hero)

    self._view.labLv:SetText("LV." .. self._data.level)
    self._view.imgNation:SetPic(self._nationIconPath[self._roleConf.faction])
    self._view.stateRarity:SetState(self._heroConf.rare)
    self._view.stateStar:Updata(self._data.star or 0, true)
    self._view.stateBreak:Updata(self._data.rare, self._data.grade)
end

function M:_IsAwake()
    if self._heroConf.rare < EQuality.SR then
        return
    end

    if self._heroConf.rare == EQuality.SR then
        return not IsNull(self._data.awake) and self._data.awake >= 3
    elseif self._heroConf.rare == EQuality.SSR then
        return not IsNull(self._data.awake) and self._data.awake >= 6
    end
end

function M:_OnBtnClick()
    if self.lock then
        if not self._data.isFri then
            return
        end
    end

    if self._data.isTeach then
        return
    end

    if not self._data.isFri then
        EventMgr:Broadcast(UIMessageNames.TEAMHEROITEMCLICK, self._heroId)
    else
        EventMgr:Broadcast(UIMessageNames.TEAMHEROITEMFRICLICK, self._heroId)
    end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end

    self._view = nil
end

return UIHeroItem2Ctrl
