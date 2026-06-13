local OtakuFurniturDataMgr = BaseClass("OtakuFurniturDataMgr", Singleton)
local M = OtakuFurniturDataMgr
local MessageId = Proto.MessageId
local tInsert = table.insert
local FurnitureKey = "FurnitureKey"
local seconds = 157680000
function M:__init()
    self._allFurnitures = {} -- all

    self._loadFurnitureByTypeCallBack = nil
    self._responseLoadFurnitureByTypeHandler = nil
    self._loadFurnitureByHeroIdCallBack = nil
    self._responseLoadFurnitureByHeroIdHandler = nil
    self._responseSetFurnitureHandler = nil
    self._setFurnitureCallBack = nil
    self._loadFurnitureByPageCallBack = nil
    self._isSending = false
    self._alreadyLoadFurniture = false
    self._OnNotifyUpdateFurniture = NetPack:RegistResponse(MessageId.NotifyUpdateFurniture,
        Bind(self, self.OnNotifyUpdateFurniture))
    self.initialFurnitureCfgs = ConfigHelper.GetCfgsByLua("initialFurniture")
end

--判断是否是默认家具
function M:CheckDefalutFurniture(furnitureId)
    for key, value in pairs(self.initialFurnitureCfgs) do
        if value.furnitureId == furnitureId then
            return true
        end
    end
    return false
end

-- for update
function M:UpdateFurniture(signleFunture, isDel)
    local data = self._allFurnitures[signleFunture.FurnitureId]

    if isDel and data then
        self._allFurnitures[signleFunture.FurnitureId] = nil
        return
    end

    if data == nil then
        self._allFurnitures[signleFunture.FurnitureId] = signleFunture
    else
        data.HeroId = signleFunture.HeroId
        data.ParentId = signleFunture.ParentId
        data.FurnitureId = signleFunture.FurnitureId
        data.TemplateId = signleFunture.TemplateId
        data.PosIndex = signleFunture.PosIndex
        data.Expire = signleFunture.Expire
    end
end

--根据家具id获取家具数据
function M:GetFurnitureDataById(furnitureId)
    return self._allFurnitures[furnitureId]
end

--根据家具余数id获取家具数据
function M:GetFurnitureDataByRemainderId(remainderId)
    for k,v in pairs(self._allFurnitures) do 
        if k % seconds == remainderId then 
            return v
        end     
    end
end

--判断是否有家具
function M:CheckFurnitureByTemplateId(TemplateId)
    for k, v in pairs(self._allFurnitures) do
        if v.TemplateId == TemplateId then
            return true
        end
    end
    return false
end


--根据模板id获取家具数据
function M:GetFurnitureDataTemplateId(TemplateId)
    local arr = {}
    for k, v in pairs(self._allFurnitures) do
        if v.TemplateId == TemplateId then
            tInsert(arr, v)
        end
    end
    return arr
end

--分页加载家具数据（page<0全部家具）
function M:LoadFurnitureByPage(callback)
    if self._isSending then
        return
    end

    self.isSending = true
    self._loadFurnitureByPageCallBack = callback
    local request = {}
    request.Page = 1
    NetPack:SendMessage(MessageId.RequestLoadFurniture, request)
    self._responseLoadFurnitureByTypeHandler = NetPack:RegistResponse(MessageId.ResponseLoadFurniture,
        Bind(self, self.OnResponseLoadFurniture))
end

function M:OnResponseLoadFurniture(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseLoadFurniture, self._responseLoadFurnitureByPageHandler)
    self._responseLoadFurnitureByPageHandler = nil

    if result ~= 0 then
        return
    end

    for i, v in ipairs(msg.Furnitures) do
        v.cfg = ConfigHelper.GetCfgByLua("houseFurniture", v.TemplateId)
        self:UpdateFurniture(v)
    end

    local totalPage = math.ceil( msg.Total / msg.Count )
    --分页请求
    if msg.Page < totalPage then 
        local request = {}
        request.Page = msg.Page + 1
        NetPack:SendMessage(MessageId.RequestLoadFurniture, request)
        return 
    end
    local Furnitures = {}
    for furnId, furn in pairs(self._allFurnitures) do
        -- body
        table.insert(Furnitures,furn)
    end
    if self._loadFurnitureByPageCallBack then
        self._loadFurnitureByPageCallBack(Furnitures)
    end
    self._loadFurnitureByPageCallBack = nil
end

--根据类型加载家具数据
function M:LoadFurnitureByType(type, callback)
    if self._isSending then
        return
    end

    self.isSending = true
    self._loadFurnitureByTypeCallBack = callback
    local request = {}
    request.Type = type
    NetPack:SendMessage(MessageId.RequestLoadFurnitureByType, request)
    self._responseLoadFurnitureByTypeHandler = NetPack:RegistResponse(MessageId.ResponseLoadFurnitureByType,
        Bind(self, self.OnResponseLoadFurnitureByType))
end

--根据类型加载家具数据返回
function M:OnResponseLoadFurnitureByType(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseLoadFurnitureByType, self._responseLoadFurnitureByTypeHandler)
    self._responseLoadFurnitureByTypeHandler = nil

    if result ~= 0 then
        return
    end

    for i, v in ipairs(msg.Furnitures) do
        v.cfg = ConfigHelper.GetCfgByLua("houseFurniture", v.TemplateId)
        self:UpdateFurniture(v)
    end

    if self._loadFurnitureByTypeCallBack then
        self._loadFurnitureByTypeCallBack(msg.Furnitures)
    end
    self._loadFurnitureByTypeCallBack = nil
    EventMgr:Broadcast(UIMessageNames.LOADFURNITURE, msg.Type)
end

--根据英雄id加载家具数据
function M:RequestLoadRoomFurniture(heroId, callback)
    if self._isSending then
        return
    end

    self._isSending = true

    self._loadFurnitureByHeroIdCallBack = callback
    local request = {}
    request.HeroId = heroId
    NetPack:SendMessage(MessageId.RequestLoadRoomFurniture, request)
    self._responseLoadFurnitureByHeroIdHandler = NetPack:RegistResponse(MessageId.ResponseLoadRoomFurniture,
        Bind(self, self.OnResponseLoadRoomFurniture))
end

--根据英雄id加载家具数据返回
function M:OnResponseLoadRoomFurniture(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseLoadRoomFurniture, self._responseLoadFurnitureByHeroIdHandler)
    self._responseLoadFurnitureByHeroIdHandler = nil

    if result ~= 0 then
        return
    end

    for i, v in ipairs(msg.Furnitures) do
        v.cfg = ConfigHelper.GetCfgByLua("houseFurniture", v.TemplateId)
        self:UpdateFurniture(v)
    end

    local realData = msg.Furnitures

    if self._loadFurnitureByHeroIdCallBack then
        self._loadFurnitureByHeroIdCallBack(realData)
    end
 
    self._loadFurnitureByHeroIdCallBack = nil
end

--根据分页获取家具数据
function M:GetFurnituresByPage(page, callback)
    local arr = self._allFurnitures
    --第一次请求全部家具数据
    if self._alreadyLoadFurniture == false or self._allFurnitures == nil or table.count(self._allFurnitures) == 0 then
        self:LoadFurnitureByPage( callback)
        self._alreadyLoadFurniture = true
    else
        callback(arr)
    end
end

--根据类型获取家具数据
function M:GetFurnituresByType(type, callback)
    local arr = {}

    if self._alreadyLoadFurniture == false or self._allFurnitures == nil or table.count(self._allFurnitures) == 0 then
        self:LoadFurnitureByType(type, callback)
    else
        for k, v in pairs(self._allFurnitures) do
            if v.cfg.type == type then
                tInsert(arr, v)
            end
        end
        callback(arr)
    end
end

--获取区域内所有可布置家具
function M:GetFurnituresByArea(areaType, callBack)
    local arr = {}

    if self._alreadyLoadFurniture == false or self._allFurnitures == nil or table.count(self._allFurnitures) == 0 then
        self:LoadFurnitureByPage( function(datas)
            for k, v in pairs(datas) do
                if table.indexof(v.cfg.areaType, areaType) and v.HeroId == 0 then
                    tInsert(arr, v)
                end
            end
            callBack(arr)
        end)
        self._alreadyLoadFurniture = true
    else
        for k, v in pairs(self._allFurnitures) do
            if table.indexof(v.cfg.areaType, areaType) and v.HeroId == 0 then
                tInsert(arr, v)
            end
        end
        callBack(arr)
    end
end

function M:GetFurnitureByAreaType(areaType)
    local arr = {}
    for k, v in pairs(self._allFurnitures) do
        if table.indexof(v.cfg.areaType, areaType) and v.HeroId == 0 then
            tInsert(arr, v)
        end
    end
    return arr
end

--根据英雄id获取家具数据
function M:GetFurnituresByHero(heroId, callback)
    local arr = {}
    if self._alreadyLoadFurniture == false or self._allFurnitures == nil or table.count(self._allFurnitures) == 0 then
        self:RequestLoadRoomFurniture(heroId, callback)
    else
        for k, v in pairs(self._allFurnitures) do
            if v.HeroId == heroId then
                tInsert(arr, v)
            end
        end
        callback(arr)
    end
end

--替换家具(HeroId 0 为卸下)
function M:RequestSetFurniture(FurnitureId, ParentId, HeroId, PosIndex, callback)
    if self._isSending then
        return
    end

    self._setFurnitureCallBack = callback
    self._isSending = true
    local request = {}
    local furnitureData = self._allFurnitures[FurnitureId]
    furnitureData.ParentId = ParentId
    furnitureData.HeroId = HeroId
    furnitureData.PosIndex = PosIndex
    request.Furniture = furnitureData
    NetPack:SendMessage(MessageId.RequestSetFurniture, request)
    self._responseSetFurnitureHandler = NetPack:RegistResponse(MessageId.ResponseSetFurniture,
        Bind(self, self.OnResponseSetFurniture))
end

--替换家具回调
function M:OnResponseSetFurniture(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseSetFurniture, self._responseSetFurnitureHandler)
    self._responseSetFurnitureHandler = nil

    if result ~= 0 then
        return
    end

    self:UpdateFurniture(msg.Furniture)
    local callBack = self._setFurnitureCallBack
    self._setFurnitureCallBack = nil

    if callBack then
        callBack(msg.Furniture)
    end
end

--批量替换家具
function M:RequestSetFurnitures(Furnitures, callback)
    if self._isSending then
        return
    end

    self._setFurnitureCallBack = callback
    self._isSending = true
    local request = {}

    request.Furnitures = Furnitures
    NetPack:SendMessage(MessageId.RequestSetFurnitures, request)
    self._responseSetFurnituresHandler = NetPack:RegistResponse(MessageId.ResponseSetFurnitures,
        Bind(self, self.OnResponseSetFurnitures))
end

--批量替换家具回调
function M:OnResponseSetFurnitures(messageId, result, msg)
    self._isSending = false
    NetPack:UnRegistResponse(MessageId.ResponseSetFurnitures, self._responseSetFurnituresHandler)
    self._responseSetFurnituresHandler = nil

    if result ~= 0 then
        return
    end

    for k, v in pairs(msg.Furnitures) do
        self:UpdateFurniture(v)
    end

    local callBack = self._setFurnitureCallBack
    self._setFurnitureCallBack = nil

    if callBack then
        callBack(msg.Furnitures)
    end
    --互动交互埋点（3.布置宿舍）
    -- local dataKey = { "interaction_type" }
    local dataValues = { tostring(3) }
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Interaction, dataValues)
    GameHelper.Tips(7118)
end

function M:OnNotifyUpdateFurniture(messageId, result, msg)
    if result ~= 0 then
        return
    end
    for k, v in pairs(msg.Data) do
        v.cfg = ConfigHelper.GetCfgByLua("houseFurniture", v.TemplateId)
        self:UpdateFurniture(v)
    end
end

function M:GetAllFurnitures()
    return self._allFurnitures or {}
end

function M:GetAtmosphere(heroId)
    local atmosphere = 0
    for k, v in pairs(self._allFurnitures) do
        if v.HeroId == heroId then
            atmosphere = atmosphere + v.cfg.atmosphere
        end
    end
    return atmosphere
end

function M:SetCach(furnitureId)
    GameHelper.SetPlayerPrefsInt(FurnitureKey..furnitureId, 1)
end

function M:GetCach(furnitureId)
    return GameHelper.GetPlayerPrefsInt(FurnitureKey..furnitureId, 0)
end 

function M:HasRedpoint(furnitureId)
    local furnitureData = self:GetFurnitureDataById(furnitureId)
    if furnitureData then
        local isDefault = self:CheckDefalutFurniture(furnitureData.TemplateId)
        if isDefault then
            return false
        else
            if furnitureData.HeroId == 0 and self:GetCach(furnitureData.FurnitureId) == 0 then
                return true
            end 
        end
    end 
    return false
end

function M:HasRedpointByRemainderId(furnitureId)
    local furnitureData = self:GetFurnitureDataByRemainderId(furnitureId)
    if furnitureData then
        local isDefault = self:CheckDefalutFurniture(furnitureData.TemplateId)
        if isDefault then
            return false
        else
            if furnitureData.HeroId == 0 and self:GetCach(furnitureData.FurnitureId) == 0 then
                return true
            end 
        end
    end 
    return false
end

--判断是否有家具红点
function M:CheckFurnitureRedPoint(furnitureId)
    if furnitureId == 0 then
        return false
    end

    if furnitureId > 1 then
        local result = self:HasRedpointByRemainderId(furnitureId)
        if result then
            return true
        end
    else
        for k, v in pairs(self._allFurnitures) do
            local result = self:HasRedpoint(v.FurnitureId)
            if result then
                return true
            end
        end
    end
    return false
end

function M:CheckFurnitureTypeRedPoint(type)
    self.context = UIContextMgr:GetInstance():GetContext("DormitoryDressupUI") 
    if type == DormConst.DressupTableType.AccessoryFurniture then
        local furnitures = self.context:GetAllAccessoryFurniture()
        if furnitures then
            for key, value in pairs(furnitures) do
                local result = self:HasRedpoint(value.FurnitureId)
                if result then
                    return true
                end
            end
        end
    end

    if type == DormConst.DressupTableType.ParentFurniture then
        local furnitures = self.context:GetAllParentFurniture()
        if furnitures then
            for key, value in pairs(furnitures) do
                local result = self:HasRedpoint(value.FurnitureId)
                if result then
                    return true
                end
            end
        end
    end
    return false
end

function M:CheckFurnitureAreaTypeRedPoint(type)
    local furnitures = self:GetFurnitureByAreaType(type)
    if furnitures then
        for key, value in pairs(furnitures) do
            local result = self:HasRedpoint(value.FurnitureId)
            if result then
                return true
            end
        end
    end
    return false
end

--设置家具类型红点
function M:SetFurnitureTypeRedPoint(type)
    self.context = UIContextMgr:GetInstance():GetContext("DormitoryDressupUI") 
    if type == DormConst.DressupTableType.AccessoryFurniture then
        local furnitures = self.context:GetAllAccessoryFurniture()
        if furnitures then
            for key, value in pairs(furnitures) do
                self:SetCach(value.FurnitureId)
            end
        end
    end

    if type == DormConst.DressupTableType.ParentFurniture then
        local furnitures = self.context:GetAllParentFurniture()
        if furnitures then
            for key, value in pairs(furnitures) do
                self:SetCach(value.FurnitureId)
            end
        end
    end
end

--设置家具区域红点
function M:SetFurnitureAreaTypeRedPoint(type)
    local furnitures = self:GetFurnitureByAreaType(type)
    if furnitures then
        for key, value in pairs(furnitures) do
            self:SetCach(value.FurnitureId)
        end
    end
end

function M:Dispose()
    self._alreadyLoadFurniture = false
    NetPack:UnRegistResponse(MessageId.NotifyUpdateFurniture, self._OnNotifyUpdateFurniture)
end

return OtakuFurniturDataMgr
