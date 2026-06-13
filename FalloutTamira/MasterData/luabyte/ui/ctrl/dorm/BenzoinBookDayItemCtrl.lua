local BenzoinBookDayItemCtrl = BaseClass("BenzoinBookDayItemCtrl")
local M = BenzoinBookDayItemCtrl

function M:__init(view)
    self._view = view
    self._view.ClickTarget.transform:onClick(Bind(self, self.OnClickItem))
end

function M:UpdateItem(data)
    if data == nil then
        self._view:SetActive(false)
        return 
    end
    
    self.data = data
    
    self._view.WeatherImage_1:SetPic(data.cfg.icon)
    self._view.WeatherImage_2:SetPic(data.cfg.icon)
    self._view.TitleText_1:SetText(data.cfg.title)
    self._view.TitleText_2:SetText(data.cfg.title)
    self._view.TitleEng_1:SetText(data.cfg.titleEU)
    self._view.TitleEng_2:SetText(data.cfg.titleEU)

    if data.lock then
        self._view.Locked.gameObject:SetActive(true)
        self._view.Select.gameObject:SetActive(false)
        self._view.Unselect.gameObject:SetActive(false)
        local lockReason = GameHelper.GetFirstLockReason(self.data.cfg.openCondition)
        if lockReason > 0 then
            local unOpenConditionCfg = ConfigHelper.GetCfgByLua("openCondition", lockReason)
            if unOpenConditionCfg ~= nil then
                self._view.LockText:SetText(unOpenConditionCfg.tips)
            else
                self._view.LockText:SetText(5629)
            end
        end
    else
        if data.isSelect then
            self._view.Locked.gameObject:SetActive(false)
            self._view.Select.gameObject:SetActive(true)
            self._view.Unselect.gameObject:SetActive(false)
        else
            self._view.Locked.gameObject:SetActive(false)
            self._view.Select.gameObject:SetActive(false)
            self._view.Unselect.gameObject:SetActive(true)
        end
    end


end

function M:OnClickItem(go)
    if self.data.lock == true then
        local lockReason = GameHelper.GetFirstLockReason(self.data.cfg.openCondition)
        if lockReason > 0 then
            local unOpenConditionCfg = ConfigHelper.GetCfgByLua("openCondition", lockReason)
            if unOpenConditionCfg ~= nil then
                GameHelper.TipsById(unOpenConditionCfg.tips)
            end
        end
        return 
    end
    
    if self.data.isSelect == true then
        return 
    end
    
    EventMgr:Broadcast(UIMessageNames.DORM_DIARY_SELECT, self.data.cfg.id)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return BenzoinBookDayItemCtrl
