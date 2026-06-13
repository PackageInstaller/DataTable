local M = BaseClass("OtakuRoomByBridgeData", require("DataCenter.Otaku.BaseOtakuRoomData"))

-- 额外附加数据
function M:ExtraData(data)

end

function M:OnInit()
    self:_InitCabinData()
end

function M:OnUpdate(netUpdateType)

end

function M:OnDestory()
    self.m_CabinData = nil
end

function M:GetCabinData()
    return self.m_CabinData
end

function M:_InitCabinData()
    self.m_CabinData = {}
    local handler = Bind(self, self.Level)
    local ERoomType = OtakuType.OtakuRoomType
    local Bridge = ERoomType.EST_Bridge
    local Dormitory = ERoomType.EST_Dormitory
    local Communication = ERoomType.EST_Communication
    local configs = ConfigHelper.GetCfgsByLua("houseRes")
    for _, cfg in pairs(configs or {}) do
        local rmType = cfg.type
        if (rmType ~= Bridge) and (rmType ~= Communication) and (rmType ~= Dormitory) then
            if cfg.index == 1 then -- 多个舱室只显示 index == 1 的， By: DuSir
                table.insert(self.m_CabinData, {
                    roomType = rmType,
                    bridgeLvFunc = handler,
                    icon = cfg.icon,
                    nameId = cfg.name,
                })
            end
        end
    end
    table.sort(self.m_CabinData, function(a, b)
        return a.roomType < b.roomType
    end)
end

return M
