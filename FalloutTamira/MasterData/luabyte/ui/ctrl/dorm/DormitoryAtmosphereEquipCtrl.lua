local DormitoryAtmosphereEquipCtrl = BaseClass("DormitoryAtmosphereEquipCtrl", BaseUICtrl)
local M = DormitoryAtmosphereEquipCtrl

function M:Init()
    local atmosphereItemCls = require("UI.Ctrl.Dorm.DormAtmosphereItemCtrl")
    self._curAttrs = {}
    self._nextAttrs = {}
    for i = 1, 4 do
        self._curAttrs[i] = atmosphereItemCls.New(self._view["Curattr" .. i])
        self._nextAttrs[i] = atmosphereItemCls.New(self._view["Nextattr" .. i])
    end
    self._view.Close.transform:onClick(Bind(self, self.ClickClose))
end

function M:OnEnter()
    local cycleType = protocol.ECycleEvent.ECET_AtmosphereCount
    local cycleData = CycleDataMgr:GetInstance():GetCycleDataByType(cycleType)
    self._curAtmosphere = cycleData:GetAtmosphereCount()
    self:CheakCurAtmosphere()
    self._view.CurValue:SetText(tostring(self._curAtmosphere))
    if self._curcfg == nil then
        self._view.CurPanel.gameObject:SetActive(false)
        self._view.CurTips.gameObject:SetActive(true)
    else
        for i = 1, 4 do
            if self._curcfg.buff[i] then
                self._curAttrs[i]:UpdateItem(self._curcfg.buff[i])
            else
                self._curAttrs[i]:Enable(false)
            end
        end
    end
    if self._nextcfg == nil then
        self._view.NextPanel.gameObject:SetActive(false)
        self._view.NextTips.gameObject:SetActive(true)
        self._view.NextAtmosphere.gameObject:SetActive(false)
    else
        self._view.NextValue:SetText(tostring(self._nextcfg.roomAtmosphere))
        for i = 1, 4 do
            if self._nextcfg.buff[i] then
                self._nextAttrs[i]:UpdateItem(self._nextcfg.buff[i])
            else
                self._nextAttrs[i]:Enable(false)
            end
        end
    end
end

function M:CheakCurAtmosphere(...)
    local cfgs = ConfigHelper.GetCfgs("atmosphereAttribute")
    local length = #cfgs
    for i = 1, length do
        if i == 1 then
            if self._curAtmosphere < cfgs[i].roomAtmosphere and self._curAtmosphere >= 0 then
                self._curcfg = nil
                self._nextcfg = cfgs[i]
            end
        elseif i > 1 and i <= length - 1 then
            if self._curAtmosphere < cfgs[i + 1].roomAtmosphere and self._curAtmosphere >= cfgs[i].roomAtmosphere then
                self._curcfg = cfgs[i]
                self._nextcfg = cfgs[i + 1]
            end
        else
            if self._curAtmosphere >= cfgs[i].roomAtmosphere then
                self._curcfg = cfgs[i]
                self._nextcfg = nil
            end
        end
    end
end

function M:ClickClose()
    self:Close()
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return DormitoryAtmosphereEquipCtrl
