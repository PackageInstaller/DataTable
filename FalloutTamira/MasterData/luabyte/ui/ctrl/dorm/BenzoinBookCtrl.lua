local BenzoinBookCtrl = BaseClass("BenzoinBookCtrl", BaseUICtrl)
local M = BenzoinBookCtrl

function M:Init()
    self._view.mask.transform:onClick(Bind(self, self._OnClickMask))
    self._selectItemCallback = EventMgr:AddListener(UIMessageNames.DORM_DIARY_SELECT, Bind(self, self._OnSelectItem))
end

function M:OnEnter(heroId)
    self.heroId = heroId
    local cfgs = ConfigHelper.GetCfgsByLua("note", { heroId = self.heroId })
    self.selectDiray = nil
    self.diary = {}
    local index = 0
    
    for i = 1, #cfgs do
        local data = {}
        data.cfg = cfgs[i]
        local isOpen = GameHelper.CheckAtLastOneOpenConditionUnLock(cfgs[i].openCondition)
        data.lock = not isOpen
        if isOpen then
            index = i
        end
        data.isSelect = false
        table.insert(self.diary, data)
    end
    
    if self.diary[index] then
        self.diary[index].isSelect = true
        self.selectDiray = self.diary[index]
        self:UpdateDiary()
    end

    self:UpdateItem()
end

function M:UpdateItem()
    for i = 1, 7 do
        self._view["DayItem" .. i]:UpdateItem(self.diary[i])
    end
end

function M:UpdateDiary()
    self._view.RightBg.gameObject:SetActive(true)
    self._view.DayText:SetText(self.selectDiray.cfg.weather)
    local txt = ConfigHelper.GetLocalStringByPlayerName(self.selectDiray.cfg.words)
    self._view.ContentText:SetText(txt)
    self._view.DateImg:SetPic(self.selectDiray.cfg.monthIcon)
    self._view.EngText_2:SetText(self.selectDiray.cfg.titleEU1)
    
end

--选择日记
function M:_OnSelectItem(id)
    for k, v in pairs(self.diary) do
        if v.cfg.id == id then
            v.isSelect = true
            self.selectDiray = v
        else
            v.isSelect = false
        end
    end
    
    self:UpdateDiary()
    self:UpdateItem()
end

--点击关闭
function M:_OnClickMask(go)
    self:Close()
end

function M:OnClose()
end

function M:OnDispose()
    M.super.OnDispose(self)
    EventMgr:RemoveListener(UIMessageNames.DORM_DIARY_SELECT, self._selectItemCallback)
end

return BenzoinBookCtrl
